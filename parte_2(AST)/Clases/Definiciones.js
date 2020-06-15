// Clases
const Nodo = require("./Nodo");

module.exports = class Definiciones extends Nodo {
  constructor(nombre, bloque) {
    super(nombre);
    this.bloque = bloque;
  }

  getBloque() {
    return this.bloque;
  }

  setBloque(bloque) {
    this.bloque = bloque;
  }

  // Override
  accept(visitor) {
    return visitor.visit(this);
  }

  // Override
  accept_transfomer(transformer) {
    return transformer.transform(this);
  }
};
