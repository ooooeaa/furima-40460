// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

window.addEventListener('load', () => {
  const priceInput = document.getElementById("item_price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    const addTaxDom = document.getElementById("add_tax_price");
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1);

    const profitNumber = document.getElementById("profit");
    profitNumber.innerHTML = Math.floor(inputValue - inputValue * 0.1);

  });
});