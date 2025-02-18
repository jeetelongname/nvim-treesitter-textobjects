;; "Classes"
(VarDecl 
  (_ (ContainerDecl (ContainerMembers) @class.inner))) @class.outer

;; functions
(_ 
  (FnProto)
  (Block) @function.inner) @function.outer

;; loops
(ForTypeExpr
  (SuffixExpr 
    (SwitchExpr) @loop.inner)) @loop.outer

(ForStatement 
  (BlockExpr) @loop.inner) @loop.outer

(WhileStatement
  (BlockExpr) @loop.inner) @loop.outer

;; blocks
(_ (Block) @block.inner) @block.outer

;; parameters
((ParamDeclList 
  "," @_start . (ParamDecl) @parameter.inner)
 (#make-range! "parameter.outer" @_start @parameter.inner)) 
((ParamDeclList
  . (ParamDecl) @parameter.inner . ","? @_end)
 (#make-range! "parameter.outer" @parameter.inner @_end)) 

;; arguments
((FnCallArguments
  "," @_start . (_) @parameter.inner)
 (#make-range! "parameter.outer" @_start @parameter.inner)) 
((FnCallArguments
  . (_) @parameter.inner . ","? @_end)
 (#make-range! "parameter.outer" @parameter.inner @_end)) 

;; comments
(doc_comment) @comment.outer
(line_comment) @comment.outer

;; conditionals
(IfStatement
  (_ (Block) @conditional.inner)) @conditional.outer

((SwitchExpr
  "{" @_start "}" @_end)
  (#make-range! "conditional.inner" @_start @_end))  @conditional.outer

;; calls
(_ (FnCallArguments) @call.inner) @call.outer
