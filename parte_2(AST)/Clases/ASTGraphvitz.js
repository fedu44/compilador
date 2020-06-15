// Clases
const Visitor = require("./Visitor");

module.exports = class ASTGraphvitz extends Visitor {
  constructor(id, graph) {
    super();
    this.id = id;
    this.graph = graph;
    this.parents = [];
  }

  getGraph() {
    return this.graph;
  }

  addParent(parent) {
    return (this.parents = [...this.parents, parent]);
  }

  removeParent() {
    return (this.parents = this.parents.slice(0, this.parents.length - 1));
  }

  getNextId() {
    return id + 1;
  }

  visit_program(program) {
    const newId = this.getNewId();
    const id = `Program ${newId}`;
    this.getGraph().addNode(id);
    this.addParent(id);
    super.visit_program(program);
    this.removeParent(id);
    console.log("this.getGraph()", this.getGraph());
    return;
  }

  visit_definitions() {
    return;
  }

  visit_definition() {
    return;
  }
};
