# 既知の課題

実装中に気づいたが、今は優先度が低いため後回しにした問題を記録する。
コードと直接は結びつかない、自分用の管理ファイル。

優先度: 高 / 中 / 低

---

## 高

## 中

## 低

- **[week3] 削除ボタンのdisabled範囲が粗い**
  複数の支出がある時、どれか1つを削除している間、`isDeleting`が共通stateのため他の削除ボタンも全てdisabledになる。UX上は「クリックした項目だけ」disabledにする方が正確。
  対応方針: 削除中の`id`自体をstateで持ち、`ExpenseItem`側で「自分のidと一致するか」を比較してdisabled判定する。

- **[#12] エラーレスポンスのフィールド名が統一されていない**
  `POST`(`app/api/expenses/route.js`)は`{ error: ... }`、`PATCH`/`DELETE`(`app/api/expenses/[id]/route.js`)は`{ message: ... }`でエラーを返している。Web側は`lib/api.js`の`request()`が`error.error || error.message`の両方を読んでいるため動くが、Flutterなど別のクライアントは両方に対応する必要がある。
  対応方針: どちらか一方(例: `message`)に統一し、`request()`の読み取りも1つにする。レスポンスの形が変わるので、クライアント側と同時に直す。

- **[#12] 壊れたJSONを送ると500になる**
  `POST`/`PATCH`で、bodyが正しいJSONでない場合(例: 最後の項目の後ろにカンマ)、`await request.json()`が例外を投げ、catchしていないため`500`が返る。本来はクライアント側の誤りなので`400`が正しい。
  対応方針: `request.json()`を`try/catch`で囲み、失敗したら`400`と「JSONの形式が正しくありません」などのメッセージを返す。
