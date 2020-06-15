// Clases
const Nodo = require("./Nodo");
const { UNKNOWN } = require("./Tipo");

module.exports = class Operacion extends Nodo {
  constructor(name, type = UNKNOWN) {
    super(name);
    this.type = type;
  }

  getType() {
    return this.type;
  }

  setType(type) {
    return (this.type = type);
  }
};
