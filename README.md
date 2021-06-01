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
