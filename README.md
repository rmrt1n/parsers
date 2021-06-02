# parsers
an exploration of parsing techniques in r7rs scheme.  
the parsing target are math expressions following this grammar:  

```
expr -> expr ('+' | '-') term | term
term -> term ('*' | '/' | '%') factor | factor
factor -> power '^' factor | power
power -> ('-' | '+') power | base
base -> '(' expr ')' | number
number -> [0-9]+
```

## techniques
for now these are the parsing techniques I used:  
- [recursive descent](https://en.wikipedia.org/wiki/Recursive_descent_parser) -> `rec-desc.sld`
- [recursive ascent](https://en.wikipedia.org/wiki/Recursive_ascent_parser) -> `rec-asc.sld`
- [pratt](https://en.wikipedia.org/wiki/Operator-precedence_parser#Pratt_parsing) -> `pratt.sld`

## resources
these are the resources I used for learning about parsers:  
**recursive descent parsing**:  
- [Parsing Expressions . Crafting Interpreters](https://craftinginterpreters.com/parsing-expressions.html) 
- [Let's Build a Simple Interpreter](https://ruslanspivak.com/lsbasi-part7/)
- [Create a programming language [part 3] - The Parser](https://www.youtube.com/watch?v=4HW3RAoWMpg)
- [Recursive Descent Parser in OCaml](https://www.youtube.com/watch?v=5RVyIP5p5aM)

**recursive ascent parsing**:
- [Writing a recursive ascent parser by hand](https://www.abubalay.com/blog/2018/04/08/recursive-ascent)
- [lalr1-table-generator](https://github.com/alexpizarroj/lalr1-table-generator)
- [Recursive Ascent: An LR Analog to Recursive Descent](https://dl.acm.org/doi/pdf/10.1145/47907.47909)
- [Recursive-Ascent Parsing](https://dl.acm.org/doi/pdf/10.5555/770818.770849)

**pratt parsing**:
- [Simple but Powerful Pratt Parsing](https://matklad.github.io/2020/04/13/simple-but-powerful-pratt-parsing.html)
- [Pratt Parsing](https://dev.to/jrop/pratt-parsing)
- [prattparser](https://github.com/richardjennings/prattparser)

