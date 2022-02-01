//
//  NetworkManager.swift
//  H4XOR
//
//  Created by kudo koki on 2022/02/01.
//

import Foundation
import UIKit

// 通信処理を実行するクラス
class NetWorkManager: ObservableObject {

    // UI側で使用するレスポンスデータ
    @Published var posts = [Post]()

    // レスポンス取得
    func fetchData() {

        // URLが正しいか確認
        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") {

            // 通信するために使うURLSessionクラスを作成
            let session = URLSession(configuration: .default)

            // 通信処理実行。処理後の処理をハンドラにかく
            let task = session.dataTask(with: url) { data, response, error in

                // エラーじゃない時の処理
                if error == nil {

                    // デコード処理
                    let decoder = JSONDecoder() // デコーダー

                    if let sefeData = data {
                        do {
                            let results = try decoder.decode(Result.self, from: sefeData)


                            // Publishedプロパティを更新するときはメインスレッドで同期処理として実行する必要がある
                            DispatchQueue.main.async {
                                // hitsタグの中身をpostsへ代入
                                self.posts = results.hits
                            }
                        } catch {
                            print("Miss Decode!!: \(error)")
                        }
                    }
                }
            }
            task.resume()
        }

    }

}
