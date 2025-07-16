
const custList = document.getElementById('customerList');
const weekTable = document.getElementById('weekTable');
let customers = JSON.parse(localStorage.getItem('customers')) || [];

function save() {
  localStorage.setItem('customers', JSON.stringify(customers));
  render();
}

function render() {
  custList.innerHTML = '';
  customers.forEach((c, i) => {
    const li = document.createElement('li');
    li.textContent = `${c.name} | مبلغ: ${c.amount.toLocaleString()} | هفته: ${c.week} | اقساط: ${c.installments} | پیش‌پرداخت: ${c.percent}%`;
    const del = document.createElement('button');
    del.textContent = 'حذف';
    del.onclick = () => { customers.splice(i,1); save(); };
    li.appendChild(del);
    custList.appendChild(li);
  });

  const weeks = Array(96).fill().map((_,i) => ({week: i+1, cash:0, inst:0, balance:0}));
  customers.forEach(c => {
    const cashAmt = c.amount * c.percent / 100;
    const instAmt = (c.amount - cashAmt) / c.installments;
    weeks[c.week-1].cash += cashAmt;
    for (let j=0; j<c.installments; j++) {
      let idx = c.week -1 + (j+1)*4;
      if (idx < 96) weeks[idx].inst += instAmt;
    }
  });

  let balance = 0;
  weekTable.innerHTML = '';
  weeks.forEach(w => {
    balance += w.cash + w.inst;
    w.balance = balance;
    const tr = document.createElement('tr');
    tr.innerHTML = `<td>${w.week}</td>
      <td>${w.cash.toLocaleString()}</td>
      <td>${w.inst.toLocaleString()}</td>
      <td>${w.balance.toLocaleString()}</td>`;
    weekTable.appendChild(tr);
  });
}

document.getElementById('addCustomer').onclick = () => {
  const name = document.getElementById('custName').value.trim();
  const amount = parseFloat(document.getElementById('custAmount').value) || 0;
  const week = parseInt(document.getElementById('custWeek').value) || 1;
  const installments = parseInt(document.getElementById('custInstallments').value) || 1;
  const percent = parseFloat(document.getElementById('custPercent').value) || 0;
  if (!name || !amount) return alert('اطلاعات ناقص است');
  customers.push({name, amount, week, installments, percent});
  save();
};

render();
