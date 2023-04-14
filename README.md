# ai_chat

Chat Interfaceは、ユーザーとAIアシスタントとの対話を可能にするFlutterアプリケーションです。ユーザーが入力したメッセージをバックエンドAPIに送信し、AIアシスタントの応答を受信して表示します。

## 前提条件

- Flutter 2.5.0 以降がインストールされていること
- APIサーバー（AIアシスタントを提供するエンドポイント）が稼働していること

## セットアップ

1. このリポジトリをクローンまたはダウンロードします。

```agsl
git clone https://github.com/keijijin/ai_chat.git
```

2. プロジェクトのルートディレクトリに.envファイルを作成し、APIサーバーのURLをAPI_URLとして定義します。

```agsl
API_URL=https://your-api-server-url.com
```

3. プロジェクトのルートディレクトリで、以下のコマンドを実行して依存関係をインストールします。

```agsl
flutter pub get
```

4. エミュレータまたは実機でアプリケーションを実行します。

```agsl
flutter run
```


## 使用方法

1. アプリケーションを起動すると、チャット画面が表示されます。
2. テキストフィールドにメッセージを入力し、送信ボタンをタップするか、キーボードの送信キーを押すことでメッセージを送信できます。
3. AIアシスタントからの応答が表示されます。会話を続けるには、新しいメッセージを入力して送信してください。

## About Flutter

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
