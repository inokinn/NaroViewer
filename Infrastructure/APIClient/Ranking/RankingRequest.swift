//
//  RankingRequest.swift
//  Infrastructure
//
//  Created by Nobuya Inoue on 2021/10/16.
//

import Alamofire

final class RankingRequest: BaseRequest {
    
    var rtype: String = ""
    var out: String = ""
    
    var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    var path: String {
        return "rank/rankget/"
    }
    
    var parameters: Parameters? {
        return ["rtype": self.rtype, "out": self.out]
    }
    
    typealias ResponseType = [RankingResponse]
}
