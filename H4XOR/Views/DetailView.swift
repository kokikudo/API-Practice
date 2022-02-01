//
//  DetailView.swift
//  H4XOR
//
//  Created by kudo koki on 2022/02/01.
//

import SwiftUI
import WebKit // WebViewを使うためのライブラリ

// WebViewを表示するView
struct DetailView: View {

    let url: String?

    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://github.com/kokikudo?tab=repositories")
    }
}

// Webページを表示するためのView
// 現状は、WebKitのWebViewをSwiftUI用のWKWebViewに変換して表示する
struct WebView: UIViewRepresentable { // WebKitなどで使われているViewをSwiftUIに変換するためのプロトコル
    let urlString: String?

    // View生成メソッド。使うViewを返すだけでOK。
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    // View更新時のメソッド
    func updateUIView(_ uiView: WKWebView, context: Context) {

        // urlのnilチェック
        if let safeString = urlString {

            // URLに変換
            if let url = URL(string: safeString) {

                // URLRequestに変換して読み込み
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }


}
