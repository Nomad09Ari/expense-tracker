# Dart 基礎メモ（JS との比較）

- 開始: 2026-10-23
- 書き方: 「JS ではこう → Dart ではこう → つまずいたこと」を**自分の言葉で**埋める
- 読んだ公式ドキュメント:
  - https://dart.dev/language/variables
  - https://dart.dev/null-safety
  - https://dart.dev/null-safety/understanding-null-safety
  - https://dart.dev/language/constructors

---

## 1. 変数（`var` / `final` / `const`）

| JS ではこう | Dart ではこう | つまずいたこと |
|---|---|---|
|  |  |  |

**DartPad で確かめること**
- [ ] `final` の List に `add` → ?
- [ ] `final` の変数に別の List を代入 → ?
- [ ] `const` の List で同じことをする → エラーは実行前？ 実行後？

---

## 2. Null Safety（`?` / `!` / `??` / `?.` / `required`）

| JS ではこう | Dart ではこう | つまずいたこと |
|---|---|---|
|  |  |  |

---

## 3. コンストラクタ（`this.x` / 名前付き引数 / `required`）

| JS ではこう | Dart ではこう | つまずいたこと |
|---|---|---|
|  |  |  |

**DartPad 課題: `data/sample.js` の支出を Dart で表す**
- [ ] `Expense` クラス（id / category / amount / date / note）
- [ ] 3 件のリスト
- [ ] 合計金額を `print`
- [ ] Q2: `note` が空になりうるとき、型と `required` はどう組み合わせる？
- [ ] Q3: `Expense(id: '1', amount: 4000, ...)` と呼ぶには、引数を何で囲む？

---

## 自分の言葉で（本人記入）

-
