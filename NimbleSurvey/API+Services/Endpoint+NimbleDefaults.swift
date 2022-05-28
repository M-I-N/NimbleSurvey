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
    }
    
    enum DefaultValues: String {
        case domain = "https://survey-api.nimblehq.co"
        case contentType = "application/json"
        case clientId = "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE"
        case clientSecret = "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"
        case passwordGrantType = "password"
    }
}
