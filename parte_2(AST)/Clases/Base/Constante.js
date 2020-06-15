// Clases
const Expresion = require("./Expresion");

module.exports = class Constante extends Expresion {
  constructor(nombre, type, value) {
    super(nombre, type);
    this.value = value;
  }

  getValue() {
    return this.value;
  }

  setValue(value) {
    this.value = value;
  }

  // Override
  accept(visitor) {
    return visitor.visit_constante(this);
  }

  // Override
  //   accept_transfomer(transformer) {
  //     return transformer.transform(this);
  //   }
};
