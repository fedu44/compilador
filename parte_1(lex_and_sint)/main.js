const JisonLex = require("jison-lex");
const jison = require("jison");
const fs = require("fs");

// Generate analyzer reading the file.l desde disco:
const grammar = fs.readFileSync("lex.l", "utf8");
JisonLex.generate(grammar); // lexerSource can be saftely deleted
const lexer = new JisonLex(grammar);

// Input to process
lexer.setInput(`
program prueba // Comienzo del programa “prueba”.
const pi: float <- 3.14 // Una constante muy famosa.
/* Se definen /* algunas */ variables globales */
var radio: float <- 1.5
var superficie_1: float <- superficie_circulo(radio)
// Procedimiento principal
proc main() is
 print "Inicio del programa"
 radio <- 25.8
 print superficie_1
 print superficie_2
 superficie_1 <- superficie_circulo(radio)
 print superficie_1
 superficie_2 <- superficie_circulo(2 * radio)
 print superficie_2
end
/* Una función */
func superficie_circulo(radio: float): float is
 print "Dentro de función superficie_circulo()"
 // Definición de una variable local.
 var radio_2 : float <- cuadrado(radio)
 return pi * radio_2
end
/* Otra función */
func cuadrado(valor: float): float is
 return valor * valor
end
/* Otra variable global (esta vez, sin inicialización explícita) */
var superficie_2: float
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
const bnf = fs.readFileSync("parser.jison", "utf8");
parser = new jison.Parser(bnf);
parser.yy.iterator_counter = 0;
parser.yy.can_return_value = false;
// parser.yy = require("./TablaSimbolos");
parser.parse(allTokens);
