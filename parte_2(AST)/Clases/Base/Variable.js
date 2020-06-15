// Clases
const Expresion = require("./Expresion");

module.exports = class Variable extends Expresion {
  constructor(nombre, type = UNKNOWN, declaracion) {
    super(nombre, type);
    this.declaracion = declaracion;
  }

  getDeclaracion() {
    return this.declaracion;
  }

  setDeclaracion(declaracion) {
    this.declaracion = declaracion;
  }

  // Override
  accept(visitor) {
    return visitor.visit_variable(this);
  }

  // Override
  //   accept_transfomer(transformer) {
  //     return transformer.transform(this);
  //   }
};
