//
//  SurveyItemViewModel.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 27/5/22.
//

import Foundation

struct SurveyItemViewModel {
    let coverImage: String
    let name: String
    let description: String
    let showDetail: () -> Void
    
    var coverImageURL: URL? {
        let largeCoverImage = coverImage + "l"
        return URL(string: largeCoverImage)
    }
}

extension SurveyItemViewModel {
    init(survey: Survey, showDetail: @escaping () -> Void) {
        coverImage = survey.attributes.coverImageURL
        name = survey.attributes.title
        description = survey.attributes.attributesDescription
        self.showDetail = showDetail
    }
}
