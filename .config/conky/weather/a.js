
const a = "asdvasdvasd 11:23 asnvas哈";

var b = a.replace( /^\D+:/g, '');
console.log(b)
var c  = a.replace(/[^0-9:]/g, "");

console.log(c)

const d = "this \n is a multi\n line\n string";

console.log(d);
