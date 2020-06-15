// Clases
const Expresion = require("./Expresion");
const { UNKNOWN } = require("./Tipo");

module.exports = class Identificador extends Expresion {
  constructor(nombre, type = UNKNOWN) {
    super(nombre, type);
  }

  // Override
  accept(visitor) {
    return visitor.visit_identificador(this);
  }

  // Override
  //   accept_transfomer(transformer) {
  //     return transformer.transform(this);
  //   }
};
