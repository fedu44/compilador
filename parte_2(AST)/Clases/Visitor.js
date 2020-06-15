// Clases
const Nodo = require("./Base/Nodo");

module.exports = class Visitor {
  constructor(id = 1) {
    this.id = id;
  }

  getNewId() {
    return this.id++;
  }

  visit_program(program) {
    return program.getBloque().accept(this);
  }

  visit_definiciones(definiciones) {
    return program.getBloque().accept(this);
  }

  visit_definitions() {
    return;
  }

  visit_definition() {
    return;
  }
};
