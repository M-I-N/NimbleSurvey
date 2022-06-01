//
//  Endpoint+NimbleDefaults.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 23/5/22.
//

import Foundation

struct NimbleEndpoint {
    enum Keys: String {
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case pageNumber = "page[number]"
        case pageSize = "page[size]"
        case authorization = "Authorization"
    }
    
    enum DefaultValues: String {
        // FIXME: Fix the domains when available
#if DEV_DEBUG
        case domain = "https://nimble-survey-web-staging.herokuapp.com/"
#elseif DEV_RELEASE
        case domain = "https://nimble-survey-web-staging.herokuapp.com/"
#elseif DEBUG
        case domain = "https://survey-api.nimblehq.co"
#else
        case domain = "https://survey-api.nimblehq.co"
#endif
        
        case contentType = "application/json"
        case clientId = "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE"
        case clientSecret = "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"
        case passwordGrantType = "password"
        case refreshTokenGrantType = "refresh_token"
    }
}
