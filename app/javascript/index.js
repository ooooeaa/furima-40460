const index = () => {
  const priceInput = document.getElementById("item_price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const tax = Math.floor(inputValue * 0.1);

    const addTaxDom = document.getElementById("add_tax_price");
    addTaxDom.innerHTML = tax;

    const profit = inputValue - tax;
    const profitNumber = document.getElementById("profit");
    profitNumber.innerHTML = profit;
  });
};

window.addEventListener('turbo:load', index);
window.addEventListener("turbo:render", index);
