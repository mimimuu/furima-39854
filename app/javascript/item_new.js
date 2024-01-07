function item_new(){
  const price = document.getElementById("item-price")
  price.addEventListener("keyup",() =>{
    const commission = Math.floor(price.value*0.1);
    const charCommission = document.getElementById("add-tax-price"); 
    const profit = Math.floor(price.value - commission);
    const charProfit = document.getElementById("profit");
    charCommission.innerHTML = `${commission.toLocaleString()}`;
    charProfit.innerHTML = `${profit.toLocaleString()}`;
  })
};

window.addEventListener('turbo:load',item_new)