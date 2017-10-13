var app = new Vue({
    el: '#dashboard',
    mounted : function() {
        let self = this;
        axios.get('/api/clients').then(function(res) {
            self.clients = res.data
        });
    },
    data : function () {
        return {
            msg : 'un message de vue',
            clients   : {},
            products  : {},
            campaigns : {},
            messages  : [],
            selected  : {
                client   : null,
                product  : null,
                campaign : null
            },
            msgIds : [],
            msgIdKeys : {} //classe les positions dans "messages" par "msg_id" schéma
            , sortOrder : 'asc'
            , sortCol : null
            , dateFilter : {
                from : null,
                to   : null
            }
            , totals : {
                prog :         0,
                fichier :      0,
                sent :         0,
                aboutis :      0,
                tx_aboutis :   0,
                opened :       0,
                tx_opened :    0,
                clicks :       0,
                tx_clicks :    0,
                unsubscribes : 0,
                tx_unsubscribes : 0,
                coupons :   0,
                tx_coupons :   0
            }
        }
    },
    computed : {
        filteredMsgs : function() {
            var self = this;
            var f = self.messages.filter(function(msg) {
                if (msg.start) {
                    var start =  msg.start.split('/');
                    start = new Date(start[2], parseInt(start[1])-1, start[0]);
                }

                return !self.dateFilter.from && !self.dateFilter.to //NO FILTER
                    || msg.start && ( //FILTER (needs a start date defined to be displayed in this case)
                        self.dateFilter.from && new Date(self.dateFilter.from) < start && (//[FROM...
                            !self.dateFilter.to //[FROM, NO_LIMIT[
                            || start < new Date(self.dateFilter.to) // [FROM, TO]
                        )
                        || !self.dateFilter.from && self.dateFilter.to &&  start < new Date(self.dateFilter.to) // ]NO_LIMIT, TO]
                    )
            });
            return f;
        }
    },
    methods : {
        getClient : function(resource, searchBy) {
            let self = this;
            self.selected.product = null;
            self.selected.campaign = null;
            axios.get('/api/clients/'+self.selected.client).then(function(res) {
                self.products  = res.data.products;
                self.campaigns = res.data.campaigns;
            });
        },
        computeTotals : function(msgArray) {
            var self = this;
            for (var key in self.totals) {
                self.totals[key] = 0;
            }
            array = msgArray != undefined ? msgArray : self.filteredMsgs;
            array.forEach(function(msg) {
                for (var key in self.totals) {
                    if (key.substr(0, 3) != 'tx_' && self.isNumber(msg[key])) {
                        self.totals[key] += parseFloat(msg[key]);
                    }
                }
            });
            self.computeTotalRates();
            return self.totals;
        },
        computeTotalRates : function() {
            var self = this;
            for (var key in self.totals) {
                if (key.substr(0, 3) == 'tx_') {
                    var intKey = key.substr(3);
                    if (intKey == 'aboutis') {
                        self.totals[key] = (parseInt(self.totals[intKey]) / self.totals.sent * 100).toFixed(2)
                    } else {
                        self.totals[key] = (parseInt(self.totals[intKey]) / self.totals.aboutis * 100).toFixed(2);
                    }
                }
            }
        },
        getMessages : function() {
            let self = this;
            axios.get('/api/messages/product/'+this.selected.product+'/campaign/'+this.selected.campaign).then(function(res) {
                self.messages = res.data;
                self.msgIds = [], self.msgIdKeys = [];
                var requests = [];
                var next = self.messages[0].msg_id, count = 0;

                for (var i in self.messages) {
                    self.msgIds.push(self.messages[i].msg_id);
                    self.msgIdKeys[self.messages[i].msg_id] = i; //remember position of the message

                };

                self.computeTotals();

                function infoCallback(res) {
                    count++;
                    let aboutis = parseInt(self.messages[self.msgIdKeys[res.data.msg_id]].aboutis);
                    let unsubscribes = parseInt(res.data.unsubscribes);
                    let tx_unsubscribes = unsubscribes / aboutis * 100;
                    let tx_coupons = parseInt(res.data.coupons) / aboutis * 100;
                    self.$set(self.messages[self.msgIdKeys[res.data.msg_id]], 'unsubscribes', unsubscribes.toFixed(3));
                    self.$set(self.messages[self.msgIdKeys[res.data.msg_id]], 'tx_unsubscribes', tx_unsubscribes.toFixed(3));
                    self.$set(self.messages[self.msgIdKeys[res.data.msg_id]], 'prog', res.data.envois);
                    self.$set(self.messages[self.msgIdKeys[res.data.msg_id]], 'coupons', res.data.coupons);
                    self.$set(self.messages[self.msgIdKeys[res.data.msg_id]], 'tx_coupons', tx_coupons.toFixed(3));

                    if (self.isNumber(res.data.envois)) self.totals.prog += res.data.envois;
                    if (self.isNumber(unsubscribes)) self.totals.unsubscribes += unsubscribes;
                    if (self.isNumber(res.data.coupons)) self.totals.coupons += res.data.coupons;
                    self.computeTotalRates();

                    if (count < self.messages.length) {
                        next = self.messages[count].msg_id;
                        axios.get('/api/messages/all-infos/' + next).then(infoCallback);
                    }

                }
                axios.get('/api/messages/all-infos/' + next).then(infoCallback);

                // axios.get('/api/messages/espb-infos/'+self.msgIds.join('+')).then(function(res) {
                //     // var results = res.data.slice(2, res.data.length-1).split('},');
                //     for (var j in res.data) {
                //         // results[j] = JSON.parse(results[j]+'}')
                //         let unsubscribes = parseInt(res.data[j].unsubscribes) / parseInt(self.messages[self.msgIdKeys[j]].aboutis) * 100;
                //         self.$set(self.messages[self.msgIdKeys[j]], 'unsubscribes', unsubscribes.toFixed(3));
                //         self.$set(self.messages[self.msgIdKeys[j]], 'prog', res.data[j].envois);
                //         // self.messages[self.msgIdKeys[j]].unsubscribes = res.data[j].unsubscribes;
                //         // self.messages[self.msgIdKeys[j]].prog = res.data[j].envois;
                //     }
                // });
            });
        },
        sortBy : function(col, type) {
            var self = this;

            //params : format dd/mm/YYYY
            function sortByDates(row1, row2) {
                if (row1.start == null) return [row1, row2];
                if (row2.start == null) return [row2, row1];
                var dateTab1 = row1.start.split('/');
                var dateTab2 = row2.start.split('/');

                if (dateTab1[2] == dateTab2[2]) {
                    if (dateTab1[1] == dateTab2[1]) {
                        if (dateTab1[0] < dateTab2[0])
                            return [row1, row2];
                        else
                            return [row2, row1];
                    } else if (dateTab1[1] < dateTab2[1])
                        return [row1, row2];
                    else
                        return [row2, row1];
                } else if (dateTab1[2] < dateTab2[2])
                    return [row1, row2];
                else
                    return [row2, row1];
            }

            function mergeSort(tab, key, type, order) {
                if (tab.length == 2) {
                    if (type == 'int') {
                        if (parseInt(tab[0][key]) < parseInt(tab[1][key]) || !self.isNumber(tab[0][key])) {
                            return tab;
                        } else if (parseInt(tab[0][key]) >= parseInt(tab[1][key]) || !self.isNumber(tab[1][key])){
                            return [tab[1], tab[0]];
                        }
                    } else if (type == 'float') { {
                        if (parseFloat(tab[0][key]) < parseFloat(tab[1][key]) || !self.isNumber(tab[0][key])) {
                            return tab;
                        } else if (parseFloat(tab[0][key]) >= parseFloat(tab[1][key]) || !self.isNumber(tab[1][key])){
                            return [tab[1], tab[0]];
                        }
                    }
                    } else if (type == 'string') {
                        if (tab[0][key] < tab[1][key]) {
                            return tab;
                        } else if (tab[0][key] >= tab[1][key]) {
                            return [tab[1], tab[0]];
                        }
                    } else if (type == 'date')
                        var yo = sortByDates(tab[0], tab[1]);
                        return sortByDates(tab[0], tab[1]);
                } else if (tab.length > 2) {
                    var half = parseInt(tab.length / 2);
                    var first = mergeSort(tab.slice(0, half), key, type, order);
                    var last = mergeSort(tab.slice(half, tab.length), key, type, order);
                    var fIndex = 0, lIndex = 0, sortedTab = [], sIndex = 0;
                    while(sIndex < tab.length) {
                        if (lIndex == last.length) {
                            sortedTab[sIndex] = first[fIndex];
                            fIndex++;
                        } else if (fIndex == first.length ) {
                            sortedTab[sIndex] = last[lIndex];
                            lIndex++;
                        } else if (type == 'int') {
                            if (parseInt(first[fIndex][key]) < parseInt(last[lIndex][key]) || !self.isNumber(first[fIndex][key])) {
                                sortedTab[sIndex] = first[fIndex];
                                fIndex++;
                            } else if (parseInt(first[fIndex][key]) >= parseInt(last[lIndex][key]) || !self.isNumber(last[lIndex][key])) {
                                sortedTab[sIndex] = last[lIndex];
                                lIndex++;
                            }
                        } else if (type == "float") {
                            if (parseFloat(first[fIndex][key]) < parseFloat(last[lIndex][key]) || !self.isNumber(first[fIndex][key])) {
                                sortedTab[sIndex] = first[fIndex];
                                fIndex++;
                            } else if (parseFloat(first[fIndex][key]) >= parseFloat(last[lIndex][key]) || !self.isNumber(last[lIndex][key])) {
                                sortedTab[sIndex] = last[lIndex];
                                lIndex++;
                            }
                        } else if (type == 'string') {
                            if (first[fIndex][key] < last[lIndex][key]) {
                                sortedTab[sIndex] = first[fIndex];
                                fIndex++;
                            } else if (first[fIndex][key] >= last[lIndex][key]) {
                                sortedTab[sIndex] = last[lIndex];
                                lIndex++;
                            }
                        } else if (type == 'date') {
                            var sortedByDates = sortByDates(first[fIndex], last[lIndex]);
                            sortedTab[sIndex] = sortedByDates[0];
                            if (sortedByDates[0].start == first[fIndex].start)
                                fIndex++
                            else lIndex++;
                        }
                        sIndex++;
                    }
                    return sortedTab;
                } else {
                    return tab;
                }
            }

            this.messages = col == this.sortCol
                ? this.messages.reverse()
                : mergeSort(this.messages, col, type, this.sortOrder);

            this.sortCol = col;
        },
        isNumber : function(number) {
            return !isNaN(parseFloat(number))
        }
    }
});
