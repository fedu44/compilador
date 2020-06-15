const JisonLex = require("jison-lex");
const jison = require("jison");
const fs = require("fs");
const graphviz = require("graphviz");

// Generate analyzer reading the file.l desde disco:
const grammar = fs.readFileSync("lex.l", "utf8");
JisonLex.generate(grammar); // lexerSource can be saftely deleted
const lexer = new JisonLex(grammar);

// Clases
const Programa = require("./Clases/Programa");
const Bloque = require("./Clases/Bloque");
const ASTGraphvitz = require("./Clases/ASTGraphvitz");

// Base
const Constante = require("./Clases/Base/Constante");
const Variable = require("./Clases/Base/Variable");
const Expresion = require("./Clases/Base/Expresion");
const Identificador = require("./Clases/Base/Identificador");
const Tipo = require("./Clases/Base/Tipo");

// Instrucciones
const Asignacion = require("./Clases/Instrucciones/Asignacion");
const Sentencia = require("./Clases/Instrucciones/Sentencia");

// Operaciones binarias
const Division = require("./Clases/OperacionesBinarias/Division");
const Multiplicacion = require("./Clases/OperacionesBinarias/Multiplicacion");
const Suma = require("./Clases/OperacionesBinarias/Suma");
const Resta = require("./Clases/OperacionesBinarias/Resta");
const ArigOp = require("./Clases/OperacionesBinarias/ArigOp");

//OperacionesUnarias
const OperacionUnaria = require("./Clases/OperacionesUnarias/OperacionUnaria");


// Input to process
lexer.setInput(`
program prueba
const pi: float <- 3.14
var radio: float <- 1.5
var superficie_1: float <- superficie_circulo(radio)
proc main() is
 radio <- 2 + 3 + 4
end
`);

// Se obtienen los tokens con lexer.lex():
let token = "";
let counter = 0;
let allTokens = "";
lexer.yy.lastToken = "INITIAL";
while (token !== "EOF") {
  token = lexer.lex();
  // console.log(`${counter} ${token}\n`);
  allTokens = allTokens + " " + token;
  counter++;
}
console.log("allTokens", allTokens);
// Create digraph G
const g = graphviz.digraph("G");

// Add node (ID: Hello)
// const n1 = g.addNode("Hello", { color: "blue" });
// n1.set("style", "filled");

// // Add node (ID: World)
// g.addNode("World");

// // Add edge between the two nodes
// var e = g.addEdge(n1, "World");
// e.set("color", "red");

// // Print the dot script
// console.log(g.to_dot());

// // Set GraphViz path (if not in your path)
g.setGraphVizPath("./");
// // Generate a PNG output
g.output("png", "AST.png");

const bnf = fs.readFileSync("parser.jison", "utf8");
parser = new jison.Parser(bnf);

// Clases imports

// Base
parser.yy.constante = Constante;
parser.yy.variable = Variable;
parser.yy.expresion = Expresion;
parser.yy.identificador = Identificador;
parser.yy.tipo = Tipo;

// Instrucciones
parser.yy.asignacion = Asignacion;
parser.yy.sentencia = Sentencia;

// OperacionesBinarias
// parser.yy.suma = Suma;
// parser.yy.resta = Resta;
// parser.yy.multiplicacion = Multiplicacion;
// parser.yy.division = Division;
parser.yy.arigOp = ArigOp;

//OperacionesUnarias
parser.yy.operacionUnaria = OperacionUnaria;

parser.yy.stack = {
  array: [],
  lastElement: () => parser.yy.stack.array[parser.yy.stack.array.length - 1],
};
// parser.yy = require("./TablaSimbolos");
const programa = parser.parse(allTokens);
console.log("programa", programa);
// const graficador = new ASTGraphvitz(1, g);
// graficador.visit_program(programa);

// lexer.setInput(`
// program prueba // Comienzo del programa “prueba”.
// const pi: float <- 3.14 // Una constante muy famosa.
// /* Se definen /* algunas */ variables globales */
// var radio: float <- 1.5
// var superficie_1: float <- superficie_circulo(radio)
// // Procedimiento principal
// proc main() is
//  print "Inicio del programa"
//  radio <- 25.8
//  print superficie_1
//  print superficie_2
//  superficie_1 <- superficie_circulo(radio)
//  print superficie_1
//  superficie_2 <- superficie_circulo(2 * radio)
//  print superficie_2
// end
// /* Una función */
// func superficie_circulo(radio: float): float is
//  print "Dentro de función superficie_circulo()"
//  // Definición de una variable local.
//  var radio_2 : float <- cuadrado(radio)
//  return pi * radio_2
// end
// /* Otra función */
// func cuadrado(valor: float): float is
//  return valor * valor
// end
// /* Otra variable global (esta vez, sin inicialización explícita) */
// var superficie_2: float
// `);
