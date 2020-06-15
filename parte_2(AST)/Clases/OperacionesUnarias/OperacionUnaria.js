// Clases
const Expresion = require("../Base/Expresion");
const { UNKNOWN } = require("../Base/Tipo");

module.exports = class OperacionUnaria extends Expresion {
  constructor(name, expression, type = UNKNOWN) {
    super(name, type);
    this.expression = expression;
  }

  getExpression() {
    return this.expression;
  }

  setExpression(expression) {
    this.expression = expression;
  }
};
