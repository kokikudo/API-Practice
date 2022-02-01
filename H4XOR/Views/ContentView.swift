//
//  ContentView.swift
//  H4XOR
//
//  Created by kudo koki on 2022/02/01.
//

import SwiftUI

/*
 API通信処理の実装手順
 1. 欲しいデータをプロパティとして持つデータモデル作成
 2.　モデルデータの情報をリストとして返すモデルを作成
 3. 通信処理を行うクラスを作成し、通信処理を書いたメソッドとUIで表示させるためのプロパティを定義
        → メソッド内で取得したJSONデータをデコードしモデル化
            → モデルデータをプロパティにセット
 4. UI側で通信メソッド実行、取得したデータを表示
 */

struct ContentView: View {

    // データを監視するプロトコルであるObsernedObject
    // NetWorkManagerを常に監視する
    @ObservedObject var networkManager = NetWorkManager()

    var body: some View {
        NavigationView {        // ページ移管するためのView

            // List(リストデータ, Identifiableを継承したリスト内のデータ)を使えばIDのあるデータを取得しViewを表示できる
            //  最後の引数がハンドラの場合はクロージャとして外に出せる
            List (networkManager.posts) { post in

                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text(String(post.points))
                        Text(post.title)
                    }
                }


            }
            .navigationTitle("H4X0R NEWS") // リストの上にタイトルを設置できる
        }
        .onAppear { // このViewが表示されたときに実行する
            networkManager.fetchData() // 通信開始
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


