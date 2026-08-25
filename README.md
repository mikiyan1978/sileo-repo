# MacDock

Mac風フローティングウィンドウマネージャー for iOS (Rootless Jailbreak)

## インストール

SileoのソースタブにURLを追加:

    https://mikiyan1978.github.io/sileo-repo/

ランディングページ: https://mikiyan1978.github.io/sileo-repo/

## 動作環境

- iOS 15.0以上
- Rootless脱獄(Dopamine推奨)
- MobileSubstrate / Substitute
- iphoneos-arm64

## 機能一覧

### ウィンドウ化
アプリ内の⧉ボタン、またはアプリ選択パネルからウィンドウ化できます。

### Traffic Lightボタン
- 赤: ウィンドウを閉じる(アプリも終了)
- 黄: 0.6倍縮小/復元トグル
- 青: ウィンドウ解除してフルスクリーンで起動

### ヘッダーバーのジェスチャー
- シングルタップ: ボタン表示/非表示
- ダブルタップ: 0.6倍縮小/復元
- 長押し(0.7秒): ウィンドウを閉じる
- ドラッグ: ウィンドウを移動

### リサイズ
- ピンチジェスチャー(2本指)
- 右下ハンドルをドラッグ
- 最小サイズ: 120pt

### 画面端スナップ
端から70pt以内で放すと自動で吸い付きます。左右・上下に対応。Dynamic Island考慮済み。

### ウィンドウ位置の記憶
閉じた時の位置とサイズをアプリごとに記憶。次回起動時に自動復元。

### アプリ選択パネル
- 上部: ウィンドウ化中のアプリアイコン(横スクロール)
- 下部: インストール済みアプリ一覧
- サービス系アプリは自動除外

### マルチウィンドウ
複数アプリを同時にウィンドウ化可能。

## 設定

設定アプリ → MacDock

- MacDock を有効にする: オン/オフ(respring不要) デフォルト:ON
- 画面端に自動スナップ: 端に吸い付く デフォルト:ON
- 位置・サイズを記憶する: 位置を記憶 デフォルト:ON
- 記憶した位置をリセット: 全削除
- ドラッグ中の透明度: 0.3〜1.0 デフォルト:0.75

## 技術詳細

### 開発環境
- 言語: Objective-C (Logos)
- ビルド: Theos (rootless scheme)
- 対象: SpringBoard (iOS 16.2)
- 脱獄: Dopamine (rootless)

### アーキテクチャ
- MacDock.dylib: メインTweak (SpringBoardに注入)
- MacDockAppButton.dylib: アプリ内ボタン (各アプリに注入)
- MacDockPref.bundle: 設定UI

### ウィンドウ化の仕組み
1. ⧉ボタンタップ → windowize通知送信
2. requestsuspend通知送信
3. 0.3秒後にlayerHostView生成
4. フローティングウィンドウに組み込み
5. スケール変換で表示

### 設定保存先 (rootless)
/var/jb/var/mobile/Library/Preferences/com.mikiyan1978.macdock.plist

### 設定の即時反映
NSDistributedNotificationCenterで設定変更をリアルタイムでSpringBoardに通知。respring不要。

## よくある質問

Q: 対応していないアプリがある
A: SPUISecureWindowのみを使用するアプリ(NewTermなど)はウィンドウ化できません。

Q: ホーム画面に⧉ボタンが出る
A: userrebootを実行してください。killall SpringBoardでは解消されない場合があります。

Q: 設定を変えても反映されない
A: 設定アプリを閉じてから数秒待ってみてください。

Q: セーフモードになる
A: 設定でMacDockを無効にしてから問題のあるアプリを特定してください。

## 更新履歴

### v1.0.0
- 初回リリース
- フローティングウィンドウ管理
- アプリ選択パネル
- Traffic Lightボタン
- 設定UI(宇宙/SF風)
- Sileoリポジトリ公開

## 開発者

mikiyan1978
- Blog: http://mikiyan1978.hatenablog.com/
- Repo: https://mikiyan1978.github.io/sileo-repo/

## 免責事項

本Tweakは脱獄環境専用です。使用による不具合・データ損失等について開発者は責任を負いません。自己責任でご使用ください。
