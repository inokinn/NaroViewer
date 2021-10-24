//
//  RankingRowsRequest.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/24.
//

import Alamofire

final class RankingRowsRequest: BaseRequest {
    
    var ncode: String = ""
    var out: String = ""
    
    var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    var path: String {
        return "novelapi/api/"
    }
    
    var parameters: Parameters? {
        return ["ncode": self.ncode, "out": self.out, "lim": self.lim, "of": self.of]
    }
    
    var lim: Int {
        return 500
    }
    
    var of: String {
        return "t-n-u-w-s-bg-g-k-gf-gl-gp-dp-wp-mp-qp-yp"
    }
    
    typealias ResponseType = [RankingRowsResponse]
}
