//
//  SearchNovelRequest.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/25.
//

import Alamofire

final class SearchNovelRequest: BaseRequest {
    
    var word: String = ""
    var out: String = ""
    
    var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    var path: String {
        return "novelapi/api/"
    }
    
    var parameters: Parameters? {
        return ["word": self.word, "out": self.out, "lim": self.lim, "of": self.of, "title": 1, "ex": 1, "keyword": 1, "wname": 1]
    }
    
    var lim: Int {
        return 00
    }
    
    var of: String {
        return "t-n-u-w-s-bg-g-k-gf-gl-gp-f-r-a-ah"
    }
    
    typealias ResponseType = [SearchNovelRowResponse]
}
