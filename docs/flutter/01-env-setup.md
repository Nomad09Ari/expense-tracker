# Flutter 環境構築ログ（expense-tracker / `mobile/`）

- 日付: 2026-10-23
- 目的: expense-tracker を Flutter 化しながら Dart / Flutter の基礎を学ぶための環境を作る
- 対象読者: これから Flutter を始める人（自分を含む）

> 【確認済み】= 実際にこの環境で実行・確認したこと
> 【未解決】= 原因がまだはっきりしていないこと

---

## 環境

| 項目 | 内容 |
|---|---|
| マシン | MacBook Air 2020（Intel / x86_64）、macOS 15.7.9 |
| Flutter（このプロジェクト用） | 3.35.1 / Dart 3.9.0（fvm 4.3.0 で固定） |
| Flutter（PATH 上のグローバル） | 3.47.1 / Dart 3.13.1（Homebrew） |
| エディタ | VS Code + Dart / Flutter 拡張 |
| 動作確認先 | Chrome（Flutter Web）。iOS / Android は未設定 |

---

## 確定手順【確認済み】

ブランチは `develop` から切る（例: `week5/flutter`）。

1. **リポジトリのルートで、3.35.1 を指定してプロジェクトを作る**
   ```bash
   fvm spawn 3.35.1 create --platforms=web,ios,android --project-name expense_mobile mobile
   ```
   - `spawn` = 指定バージョンで 1 回だけコマンドを実行する
   - `--platforms` を付けないと macos / windows / linux も作られる
   - `--project-name` = Dart パッケージ名（`package:expense_mobile/...` になる）。省略するとフォルダ名
2. **`mobile/` に入って fvm でバージョンを固定する**
   ```bash
   cd mobile
   fvm use 3.35.1
   ```
   - `.fvmrc` ができる
   - 既存の `.gitignore` の**末尾に `.fvm/` が追記される**
3. **確認**
   - `fvm flutter --version` → 3.35.1
   - `pubspec.yaml` の `environment: sdk:` → `^3.9.0`（3.35.1 で作られた証拠）
   - `.metadata` の `platforms:` → root / android / ios / web の 4 つだけ
4. **VS Code**
   - `mobile/` を VS Code で開く
   - `mobile/.vscode/settings.json` に `"dart.flutterSdkPath": ".fvm/versions/3.35.1"` を書く
   - `fvm use` が自動で作らない場合があるので、無ければ自分で作る
5. **動作確認**
   - `fvm flutter run -d chrome` → カウンターアプリが表示される
   - `fvm flutter analyze` → `No issues found!`
6. **コミット前の確認**（ルートで実行）
   - `git add -n mobile` で、追加されるファイルを実際には追加せずに一覧表示する
   - `.dart_tool/`・`.idea/`・`*.iml`・`.fvm/`・`build/` が**出てこない**こと
   - `.fvmrc`・`.vscode/settings.json`・`.metadata`・`pubspec.lock` は**出てくる**（コミットする）

---

## ハマりどころ（実際に起きたこと）

| # | 症状 | 原因 | 対処 |
|---|---|---|---|
| 1 | `mobile/.gitignore` が `.fvm/` の 1 行だけになり、`.dart_tool/` などがコミット対象になった | `fvm use` を `create` より**先に**実行した。`flutter create` は**既にあるファイルを上書きしない**ので、Flutter 標準の `.gitignore` が作られなかった | `.gitignore` を削除して `fvm flutter create .` を再実行し、`.fvm/` を追記した。正しい順番は「spawn で create → use」 |
| 2 | `macos/`・`windows/`・`linux/` フォルダが増えた | `create .` を `--platforms` なしで再実行した。指定がないと全プラットフォームが対象になる | 3 フォルダを削除し、`.metadata` の `platforms:` からも 3 項目を削除する |
| 3 | （予防）`fvm` なしで `flutter` を実行すると、別バージョンで動く | ターミナルの `flutter` は PATH 上のグローバル版（3.47.1）を使う | 下の「バージョンの決まり方」を参照。**`fvm` を付ける習慣**と、`fvm flutter --version` で確認する習慣をつける |
| 4 | `create` 直後の `pub get` が数分止まる【未解決】 | 通信は接続したままデータが流れない状態（`lsof` で ESTABLISHED のまま）。ネットワーク経路の MTU 問題が知られていて、MTU 1400 で改善した例がある。ただし今回は **MTU 1400 でも 2 回発生**した | Ctrl+C で止めて `fvm flutter pub get -v` を再実行したら通った。再発したら `-v` のログを残す |
| 5 | Xcode 26 が「この Mac には対応していない」と起動しない | ダウンロードしたのが **Apple silicon 専用版**（`Xcode_26.2_Apple_silicon.xip`）だった。Xcode 26 には Intel Mac でも動く **Universal 版**がある | iOS を確認するときは Universal 版を入れる（今回は未実施） |

### #3 の詳細: `fvm` なしで `create` するとどうなるか

- 3.47.1（Dart 3.13.1）で作られ、`pubspec.yaml` が `sdk: ^3.13.1` になる
- そのあと 3.35.1（Dart 3.9.0）で `pub get` すると、バージョンの解決に失敗する
- 既存プロジェクトで `fvm` なしの `flutter pub get` を実行すると、`pubspec.lock` などが別バージョンで書き換わる。チームでバージョンを揃えている場合は差分の原因になる

---

## 知っておくと役立つこと

### Flutter のバージョンはどこで決まるか

| 実行方法 | 使われるバージョン | 決めているもの |
|---|---|---|
| `flutter ...` | 3.47.1（グローバル） | PATH（`/usr/local/bin/flutter`） |
| `fvm flutter ...` | 3.35.1 | 今いるフォルダ（または親）の `.fvmrc` |
| VS Code の F5 | 3.35.1 | `.vscode/settings.json` の `dart.flutterSdkPath` |

### `package:` import と Next.js の `@`

| | Next.js の `@/` | Dart の `package:expense_mobile/` |
|---|---|---|
| 設定する場所 | `jsconfig.json` の `paths` | `pubspec.yaml` の `name:` |
| 指す先 | プロジェクトのルート | **`lib/` フォルダ** |

- 例: `package:expense_mobile/models/expense.dart` → `mobile/lib/models/expense.dart`
- アプリのコードはすべて `lib/` の中に置く

### `.metadata`

- Flutter のツールが「このプロジェクトをどう作ったか」を記録するファイル
- `revision` = 作成に使った Flutter のコミット（`fvm flutter --version` の revision と一致する）
- `platforms` = `flutter migrate` が使う、プラットフォームごとの作成記録
- コミット対象。プラットフォームのフォルダを削除したら、ここも合わせて削除する

### ESLint（ルートの Next.js 側）

- `flutter run -d chrome` だけなら、`npm run lint` は `mobile/` に影響しない【確認済み】
- `flutter build web` を実行すると `mobile/build/web/` に JS が出力される
- ルートの `eslint.config.mjs` が除外しているのはルート直下の `build/` だけなので、`mobile/` を除外に加えるか検討する【未対応】

---

## 残タスク

- [ ] `.metadata` から linux / macos / windows を削除
- [ ] ESLint の除外に `mobile/` を追加するか決める
- [ ] `mobile/` の初回コミットと push

---

## 自分の言葉で（本人記入）

<!-- 今日いちばん大事だと思ったこと / 次に Flutter を始める人に一言 -->

-
