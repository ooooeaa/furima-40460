function index (){
  const priceInput = document.getElementById("item_price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    const addTaxDom = document.getElementById("add_tax_price");
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1);

    const profitNumber = document.getElementById("profit");
    profitNumber.innerHTML = Math.floor(inputValue - inputValue * 0.1);
  });
};


window.addEventListener('turbo:load', index);