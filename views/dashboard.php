<div class="col-xs-12 text-center" id="dashboard">
    <h1>Tableau de bord des campagnes</h1>

    <div class="col-md-offset-1 col-md-10 text-left">
        <div class="form-group">
            <label for="client">Client</label>
            <select class="form-control" name="client" v-model="selected.client" v-on:change="getClient">
                <option></option>
                <option v-for="client in clients" :value="client.acc_id">{{client.acc_name}}</option>
            </select>
        </div>
        <div v-if="selected.client" class="row">
            <div class="form-group col-md-6">
                <label for="campagne">Campagne</label>
                <select class="form-control" name="campagne" v-model="selected.campaign" v-on:change="getMessages">
                    <option value="null"></option>
                    <option v-for="campaign in campaigns" :value="campaign.camp_id">{{campaign.camp_name}}</option>
                </select>
            </div>
            <div class="form-group col-md-6">
                <label for="products">Produits</label>
                <select class="form-control" name="products" v-model="selected.product" v-on:change="getMessages">
                    <option value="null"></option>
                    <option v-for="product in products" :value="product.prod_id">{{product.prod_name}}</option>
                </select>
            </div>
            <div v-if="selected.product || selected.campaign">
                <div class="form-group col-md-6">
                    <label for="from">De</label>
                    <input class="form-control" name="from" type="date" v-model="dateFilter.from" v-on:change="computeTotals()" :disabled="!readyToExport"/>
                </div>
                <div class="form-group col-md-6">
                    <label for="to">à</label>
                    <input class="form-control" name="to" type="date" v-model="dateFilter.to" v-on:change="computeTotals()" :disabled="!readyToExport"/>
                </div>
            </div>
            <div v-if="selected.product || selected.campaign" class="col-xs-12">
                <table id="messages" class="table">
                    <thead>
                        <tr>
                            <th :data-ready="readyToExport" v-on:click="sortBy('msg_name', 'string')">Message</th>
                            <th :data-ready="readyToExport" v-on:click="sortBy('start', 'date')">Début</th>
                            <th :data-ready="readyToExport" v-on:click="sortBy('prog', 'int')">Programmés</th>
                            <th :data-ready="readyToExport" v-on:click="sortBy('fichier', 'int')">Fichier</th>
                            <th :data-ready="readyToExport" v-on:click="sortBy('sent', 'int')">Envoyés</th>
                            <th :data-ready="readyToExport" v-on:click="sortBy('aboutis', 'int')">Aboutis</th>
                            <th :data-ready="readyToExport" v-on:click="sortBy('tx_aboutis', 'float')">TauxAboutis</th>
                            <th :data-ready="readyToExport" v-on:click="sortBy('opened', 'int')">Ouverts</th>
                            <th :data-ready="readyToExport" v-on:click="sortBy('tx_opened', 'float')">Taux Ouverts</th>
                            <th :data-ready="readyToExport" v-on:click="sortBy('clicks', 'int')">Clics</th>
                            <th :data-ready="readyToExport" v-on:click="sortBy('tx_clicks', 'float')">Taux Clics</th>
                            <th :data-ready="readyToExport" v-on:click="sortBy('tx_unsubscribes', 'float')">Désabonnements</th>
                            <th :data-ready="readyToExport" v-on:click="sortBy('coupons', 'int')">Coupons</th>
                            <th :data-ready="readyToExport" v-on:click="sortBy('tx_coupons', 'float')">Taux coupons</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="msg in filteredMsgs">
                            <td>{{msg.msg_name}}</td>
                            <td>{{msg.start}}</td>
                            <td>{{msg.prog}}</td>
                            <td>{{msg.fichier}}</td>
                            <td>{{msg.sent}}</td>
                            <td>{{msg.aboutis}}</td>
                            <td>{{msg.tx_aboutis}}<span v-if="isNumber(msg.tx_aboutis)">%</span></td>
                            <td>{{msg.opened}}</td>
                            <td>{{msg.tx_opened}}<span v-if="isNumber(msg.tx_opened)">%</span></td>
                            <td>{{msg.clicks}}</td>
                            <td>{{msg.tx_clicks}}<span v-if="isNumber(msg.tx_clicks)">%</span></td>
                            <td>{{msg.tx_unsubscribes}}<span v-if="isNumber(msg.tx_unsubscribes)">%</span></td>
                            <td>{{msg.coupons}}</td>
                            <td>{{msg.tx_coupons}}<span v-if="isNumber(msg.tx_coupons)">%</span></td>
                        </tr>
                        <tr id="totals">
                            <td>TOTAL</td>
                            <td></td>
                            <td>{{totals.prog}}</td>
                            <td>{{totals.fichier}}</td>
                            <td>{{totals.sent}}</td>
                            <td>{{totals.aboutis}}</td>
                            <td>{{totals.tx_aboutis}}%</td>
                            <td>{{totals.opened}}</td>
                            <td>{{totals.tx_opened}}%</td>
                            <td>{{totals.clicks}}</td>
                            <td>{{totals.tx_clicks}}%</td>
                            <td>{{totals.tx_unsubscribes}}%</td>
                            <td>{{totals.coupons}}</td>
                            <td>{{totals.tx_coupons}}%</td>
                        </tr>
                    </tbody>
                </table>
                <!-- <a v-if="readyToExport" class="button col-xs-12 col-md-3" v-on:click="exporter">Exporter</a> -->
                <div class="btn-group btn-group-justified" role="group">
                    <a :disabled="!readyToExport" download="export.csv" class="btn btn-primary col-xs-12 col-md-3" @click="exporter" :href="exportUri">Exporter</a>
                </div>
            </div>
        </div>
    </div>
</div>
