//
//  Survey.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 27/5/22.
//

import Foundation

struct SurveyResponse: Decodable {
    let data: [Survey]
    let meta: Meta
}

struct Survey: Decodable {
    let id: String
    let type: String
    let attributes: Attributes
    
    struct Attributes: Decodable {
        let title: String
        let attributesDescription: String
        let isActive: Bool
        let coverImageURL: String
        let createdAt: String
        let activeAt: String
        let surveyType: String

        enum CodingKeys: String, CodingKey {
            case title
            case attributesDescription = "description"
            case isActive = "is_active"
            case coverImageURL = "cover_image_url"
            case createdAt = "created_at"
            case activeAt = "active_at"
            case surveyType = "survey_type"
        }
    }
}

struct Meta: Decodable {
    let page: Int
    let pages: Int
    let pageSize: Int
    let records: Int

    enum CodingKeys: String, CodingKey {
        case page, pages
        case pageSize = "page_size"
        case records
    }
}
