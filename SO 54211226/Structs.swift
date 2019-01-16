//
//  Structs.swift
//  SO 54211226
//
//  Created by acyrman on 1/16/19.
//  Copyright © 2019 iCyrman. All rights reserved.
//

struct Quote: Decodable {
    let quote: String?
    let author: String?
    let length: String?
    let tags: [String]?
    let category: String?
    let title: String?
    let date: String?
}

struct WebsiteObjectStruct: Decodable {
    let success: SuccessStruct
    let contents: ContentsStruct
}

struct SuccessStruct: Decodable{
    let total: Int?
}

struct ContentsStruct: Decodable{
    let quotes: [Quote]?
    let copyright:  String?
}
