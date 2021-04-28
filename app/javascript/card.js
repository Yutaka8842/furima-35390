const card = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // 環境変数を読み込む
  if ( document.getElementById('card-form')){
  const form = document.getElementById("card-form"); 
  form.addEventListener("submit", (e) => { // イベント発火
    e.preventDefault();

    const formResult = document.getElementById("card-form");
    const formData = new FormData(formResult);

    const card = { // カードオブジェクトを生成
      number: formData.get("card[number]"),              // カード番号
      cvc: formData.get("card[cvc]"),                    // カード裏面の3桁の数字
      exp_month: formData.get("card[exp_month]"),        // 有効期限の月
      exp_year: `20${formData.get("card[exp_year]")}`,   // 有効期限の年
    };

    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        const token = response.id;
        const renderDom = document.getElementById("card-form");   //idを元に要素を取得
        const tokenObj = `<input value=${token} name='card_token' type="hidden">`;   //paramsの中にトークンを含める
        renderDom.insertAdjacentHTML("beforeend", tokenObj);  //フォームの一番最後に要素を追加

        document.getElementById("card-number").removeAttribute("name");
        document.getElementById("card-cvc").removeAttribute("name");
        document.getElementById("card-exp-month").removeAttribute("name");
        document.getElementById("card-exp-year").removeAttribute("name");

        document.getElementById("card-form").submit();
      }   
    });
  });
 }
};

window.addEventListener("load", card);