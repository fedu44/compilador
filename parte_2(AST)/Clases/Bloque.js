// Clases
const Nodo = require("./Base/Nodo");

module.exports = class Bloque extends Nodo {
  constructor(nombre, sentencias, alcance) {
    super(nombre);
    this.sentencias = sentencias;
    this.alcance = alcance;
  }

  getAlcance() {
    return this.alcance;
  }

  setAlcance(alcance) {
    this.alcance = alcance;
  }

  getSentencias() {
    return this.sentencias;
  }

  setSentencias(sentencias) {
    this.sentencias = sentencias;
  }

  // Override
  accept(visitor) {
    return visitor.visit_definiciones(this.sentencias);
  }

  // Override
  accept_transfomer(transformer) {
    return transformer.transform(this);
  }
};
