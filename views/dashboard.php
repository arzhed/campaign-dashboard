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
            <div v-if="selected.product || selected.campaign" class="col-xs-12">
                <table class="table">
                    <thead>
                        <tr>
                            <th v-on:click="sortBy('msg_name', 'string')">Message</th>
                            <th v-on:click="sortBy('start', 'date')">Début</th>
                            <th v-on:click="sortBy('prog', 'int')">Programmés</th>
                            <th v-on:click="sortBy('fichier', 'int')">Fichier</th>
                            <th v-on:click="sortBy('sent', 'int')">Envoyés</th>
                            <th v-on:click="sortBy('aboutis', 'int')">Aboutis</th>
                            <th v-on:click="sortBy('tx_aboutis', 'float')">TauxAboutis</th>
                            <th v-on:click="sortBy('opened', 'int')">Ouverts</th>
                            <th v-on:click="sortBy('tx_opened', 'float')">Taux Ouverts</th>
                            <th v-on:click="sortBy('clicks', 'int')">Clics</th>
                            <th v-on:click="sortBy('tx_clicks', 'float')">Taux Clics</th>
                            <th v-on:click="sortBy('unsubscribes', 'int')">Désabonnements</th>
                            <th v-on:click="sortBy('nb_coupons', 'int')">Coupons</th>
                            <th v-on:click="sortBy('tx_coupons', 'float')">Taux coupons</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="msg in messages">
                            <td>{{msg.msg_name}}</td>
                            <td>{{msg.start}}</td>
                            <td>{{msg.prog}}</td>
                            <td>{{msg.fichier}}</td>
                            <td>{{msg.sent}}</td>
                            <td>{{msg.aboutis}}</td>
                            <td>{{msg.tx_aboutis}}%</td>
                            <td>{{msg.opened}}</td>
                            <td>{{msg.tx_opened}}%</td>
                            <td>{{msg.clicks}}</td>
                            <td>{{msg.tx_clicks}}%</td>
                            <td>{{msg.unsubscribes}}%</td>
                            <td>{{msg.nb_coupons}}</td>
                            <td>{{msg.tx_coupons}}%</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
