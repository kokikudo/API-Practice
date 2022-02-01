//
//  PostData.swift
//  H4XOR
//
//  Created by kudo koki on 2022/02/01.
//

import Foundation


// 受信したJSONデータをデコードするクラス
// hitsタグの中身を表示したいのでhitsプロパティを持つ
struct Result: Decodable {
    let hits: [Post]
}

// hitsの中にある情報を持つデータモデル
// Identifiableを継承するとString型のプロパティIdをモデル固有のIDとして認識する
struct Post: Decodable, Identifiable {
    var id: String {
        return objectID //　取得したユニークIDをこのモデルのIDに設定
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String? // URLがない記事もあるのでオプショナル型
}
