// Clases
const Expresion = require("../Base/Expresion");

module.exports = class ArigOp extends Expresion {
  constructor(left, right, op, name = "No name") {
    super(name, op);
    this.left = left;
    this.right = right;
  }
};
