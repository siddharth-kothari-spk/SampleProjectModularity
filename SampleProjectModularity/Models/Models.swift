import Foundation

class AdModel: Equatable {
    static func == (lhs: AdModel, rhs: AdModel) -> Bool {
        lhs === rhs
    }
    
    init(id: AnyHashable, name: String, price: Price, seller: Seller, image: String?) {
        self.id = id
        self.name = name
        self.price = price
        self.seller = seller
        self.image = image
    }
    let id: AnyHashable
    let name: String
    let price: Price
    let seller: Seller
    let image: String?
    
    func toSearchAdModel() -> SearchAdModel {
        SearchAdModel(ad: self, searchedQuery: "")
    }
}

struct Seller: Equatable {
    let name: String
    let website: String?
}

struct Price: Equatable {
    let priceAmount: Double
    let priceString: String
}


struct SearchAdModel: Equatable {
    let ad: AdModel
    let searchedQuery: String
}
