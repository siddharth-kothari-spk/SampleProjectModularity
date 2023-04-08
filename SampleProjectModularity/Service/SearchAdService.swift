//
//  SearchAdService.swift
//  SampleProjectModularity
//
//  Created by sidkotha on 08/04/23.
//


class SearchAdService {
    
    private let loader: (([SearchAdModel]) -> Void) -> Void

    init(loader: @escaping (([SearchAdModel]) -> Void) -> Void = NetworkClient.sharedInstance.getAds) {
        self.loader = loader
    }
    func load(filters: [String], completion: ([SearchAdModel]) -> Void) {
        loader {ads in
          //  completion(ads)
          //  completion(ads) // to fail test case
            guard !filters.isEmpty else {
                return completion(ads)
            }
            
            let filteredAds = ads.compactMap { (item) -> SearchAdModel?  in
                
                for filter in filters {
                    if !item.ad.name
                        .lowercased()
                        .contains(filter.lowercased()) {
                        return nil
                    }
                }
                return item
            }
            completion(filteredAds)
        }
    }
}
