function calculation (){
  const price = document.getElementById('item-price');
  price.addEventListener('input',() => {
    const formData = price.value;
    const tax = document.getElementById('add-tax-price');
    const profit = document.getElementById('profit');
    tax.innerHTML = Math.floor(formData / 10).toLocaleString();
    profit.innerHTML = Math.ceil(formData - formData / 10).toLocaleString();
  });
}
window.addEventListener('load', calculation);