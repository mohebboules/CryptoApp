//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by Moheb Boules on 22/12/2024.
//

import Foundation

//JSON data
/*
 URL: https://api.coingecko.com/api/v3/global
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 16236,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1197,
     "total_market_cap": {
       "btc": 35975998.746197,
       "eth": 1034111443.03037,
       "ltc": 34440928483.6397,
       "bch": 7660845232.88197,
       "bnb": 5238951787.33056,
       "eos": 4367141365355.89,
       "xrp": 1546860400759.64,
       "xlm": 9676270946617.38,
       "link": 156127513424.683,
       "dot": 491635278335.873,
       "yfi": 403789557.734134,
       "usd": 3468393510277.4,
       "aed": 12739409363248.9,
       "ars": 3530471563028947,
       "aud": 5548541707705.2,
       "bdt": 412809853485314,
       "bhd": 1303453496703.84,
       "bmd": 3468393510277.4,
       "brl": 21108642903548.2,
       "cad": 4979919402056.29,
       "chf": 3100344932934.31,
       "clp": 3426441018972843,
       "cny": 25306786408388,
       "czk": 83561576967656.2,
       "dkk": 24804563028099.8,
       "eur": 3325402051029.19,
       "gbp": 2760033098492.91,
       "gel": 9737514780103.79,
       "hkd": 26966586122731.3,
       "huf": 1.37674411996951e+15,
       "idr": 56088431972748870,
       "ils": 12620651569457,
       "inr": 294635866625853,
       "jpy": 542612822715347,
       "krw": 5016753741135434,
       "kwd": 1064103128953.11,
       "lkr": 1.01424009568159e+15,
       "mmk": 7276689584561979,
       "mxn": 69649850597933.5,
       "myr": 15635517944330.5,
       "ngn": 5359393616795224,
       "nok": 39262561375691.1,
       "nzd": 6132237651549.79,
       "php": 204062932177171,
       "pkr": 961552832816105,
       "pln": 14172254748247.1,
       "rub": 356529660972169,
       "sar": 13028354289803.1,
       "sek": 38265398241486.4,
       "sgd": 4701754242532.04,
       "thb": 118808085497797,
       "try": 121642806982140,
       "twd": 113177148633862,
       "uah": 144880013388126,
       "vef": 347290242184.076,
       "vnd": 88287998369338990,
       "zar": 63534725999963.4,
       "xdr": 2635160526942.4,
       "xag": 117597026535.814,
       "xau": 1322220973.98795,
       "bits": 35975998746197,
       "sats": 3.5975998746197e+15
     },
     "total_volume": {
       "btc": 2020931.39637943,
       "eth": 58090625.8452722,
       "ltc": 1934699691.98295,
       "bch": 430343651.142458,
       "bnb": 294295155.662737,
       "eos": 245321697944.745,
       "xrp": 86894008746.3645,
       "xlm": 543559051517.934,
       "link": 8770374825.29787,
       "dot": 27617333894.3575,
       "yfi": 22682650.1888663,
       "usd": 194835045146.849,
       "aed": 715629120824.376,
       "ars": 198322244674422,
       "aud": 311686194463.401,
       "bdt": 23189360204529.5,
       "bhd": 73220763481.5922,
       "bmd": 194835045146.849,
       "brl": 1185766084763.72,
       "cad": 279744157821.846,
       "chf": 174160124331.091,
       "clp": 192478387658843,
       "cny": 1421594423409.47,
       "czk": 4694024358191.43,
       "dkk": 1393382308872.21,
       "eur": 186802580740.58,
       "gbp": 155043299371.373,
       "gel": 546999389249.779,
       "hkd": 1514832734264.49,
       "huf": 77337822820590.2,
       "idr": 3150735965583239,
       "ils": 708957968878.548,
       "inr": 16551003283170.6,
       "jpy": 30480968637998.8,
       "krw": 281813306001305,
       "kwd": 59775391851.0533,
       "lkr": 56974364138993.8,
       "mmk": 408763924718089,
       "mxn": 3912540992107.42,
       "myr": 878316383521.995,
       "ngn": 301060907360687,
       "nok": 2205552194566.84,
       "nzd": 344474984211.164,
       "php": 11463119881214.9,
       "pkr": 54014686925712.4,
       "pln": 796118400500.217,
       "rub": 20027852198970.2,
       "sar": 731860438765.47,
       "sek": 2149537119087.12,
       "sgd": 264118387201.068,
       "thb": 6673977053982.74,
       "try": 6833215931216.3,
       "twd": 6357662358186.83,
       "uah": 8138552867691.78,
       "vef": 19508833070.554,
       "vnd": 4959528409116222,
       "zar": 3569027324009.01,
       "xdr": 148028653240.951,
       "xag": 6605946501.26881,
       "xau": 74275015.9108818,
       "bits": 2020931396379.43,
       "sats": 202093139637943
     },
     "market_cap_percentage": {
       "btc": 55.0353449244909,
       "eth": 11.6480179023076,
       "usdt": 4.03064832801082,
       "xrp": 3.70038115268869,
       "bnb": 2.78441142021142,
       "sol": 2.54600246343539,
       "doge": 1.3406109169867,
       "usdc": 1.23781917699637,
       "steth": 0.942338522852707,
       "ada": 0.928890830663016
     },
     "market_cap_change_percentage_24h_usd": -5.32949588554889,
     "updated_at": 1734857352
   }
 }
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable{
    
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24hUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24hUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
      
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}){
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}){
            return item.value.asPrecentString()
        }
        return ""
    }
    
}
