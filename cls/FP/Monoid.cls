Class FP.Monoid Extends %RegisteredObject
{

Property Functor As FP.Functor [ Private ];

Method %OnNew(functor As FP.Functor) As %Status
{
  set ..Functor = functor
  quit $$$OK
}

Method PushValue(mappable As %RegisteredObject, item As %CacheString) [ Internal, Private ]
{
  if mappable.%IsA("%DynamicArray") {
    do mappable.%Push(item)
  } else {
    do mappable.Insert(item)
  }
}

Method GetFunctorLength(functorValue As %RegisteredObject) As %Integer [ Internal, Private ]
{
 
  if functorValue.%IsA("%DynamicArray") {    
    quit functorValue.%Size()
  }
  quit functorValue.Count()
}

Method GetFunctorItem(functorValue As %RegisteredObject, index As %Integer) As %CacheString [ Internal, Private ]
{
 
  if functorValue.%IsA("%DynamicArray") {    
    quit functorValue.%Get(index - 1)
  }
  quit functorValue.GetAt(index)
}

Method Map(monoid As %String, params... As %String) As FP.Functor
{
  #dim item As %RegisteredObject
  
  set functorValue = ..Functor.Result()
  set mappable = $System.OBJ.New($classname(functorValue))
  set className = $piece(monoid, ":", 1)
  set classMethod = $piece(monoid, ":", 2)  
  
  for i=1:1:..GetFunctorLength(functorValue) {
    set item = ..GetFunctorItem(functorValue, i)
    set result = $classmethod(className, classMethod, item.%ConstructClone(1), i, params...)
    do ..PushValue(mappable, result) 
  }
  quit ##class(FP.Functor).From(mappable)
}

Method Filter(monoid As %String, params... As %String)
{
  set functorValue = ..Functor.Result()
  set mappable = $System.OBJ.New($classname(functorValue))
  set className = $piece(monoid, ":", 1)
  set classMethod = $piece(monoid, ":", 2)  
  
  for i=1:1:..GetFunctorLength(functorValue) {    
    set item = ..GetFunctorItem(functorValue, i)
    set passed = $classmethod(className, classMethod, item.%ConstructClone(1), i, params...)
    if passed = 1 {    
      do ..PushValue(mappable, item) 
    }
  }
  quit ##class(FP.Functor).From(mappable)
}

Method Some(monoid As %String, params... As %String) As FP.Functor
{
  set className = $piece(monoid, ":", 1)
  set classMethod = $piece(monoid, ":", 2)
  set functorValue = ..Functor.Result()
  set passed = 0
  
  for i=1:1:..GetFunctorLength(functorValue) {    
    set item = ..GetFunctorItem(functorValue, i)
    set passed = $classmethod(className, classMethod, item.%ConstructClone(1), i, params...)
    if passed = 1 quit
  }
  quit ##class(FP.Value).%New(passed)
}

Method Every(monoid As %String, params... As %String) As FP.Functor
{
  set className = $piece(monoid, ":", 1)
  set classMethod = $piece(monoid, ":", 2)
  set passed = 1
  set functorValue = ..Functor.Result()
  
  for i=1:1:..GetFunctorLength(functorValue) {    
    set item = ..GetFunctorItem(functorValue, i)
    set passed = $classmethod(className, classMethod, item.%ConstructClone(1), i, params...)
    if passed = "" || (passed = 0) quit
  }
  quit ##class(FP.Value).%New(passed)
}

Method Reduce(monoid As %String, initialAccumulated As %CacheString, params... As %String)
{
  set className = $piece(monoid, ":", 1)
  set classMethod = $piece(monoid, ":", 2)
  set accumulated = initialAccumulated  
  set functorValue = ..Functor.Result()
  
  for i=1:1:..GetFunctorLength(functorValue) {    
    set item = ..GetFunctorItem(functorValue, i)
    set accumulated = $classmethod(className, classMethod, accumulated, item.%ConstructClone(1), i, functorValue, params...)
  }
  if $isobject(accumulated) && (accumulated.%Extends("%Collection.AbstractList") || accumulated.%Extends("%DynamicArray")) {
    quit ##class(FP.Functor).From(accumulated)
  }
  quit ##class(FP.Value).%New(accumulated)
}

Method ReduceRight(monoid As %String, initialAccumulated As %CacheString, params... As %String)
{
  set className = $piece(monoid, ":", 1)
  set classMethod = $piece(monoid, ":", 2)
  set accumulated = initialAccumulated
  set functorValue = ..Functor.Result()
  
  for i=..GetFunctorLength(functorValue):-1:1 {
    set item = ..GetFunctorItem(functorValue, i)
    set accumulated = $classmethod(className, classMethod, accumulated, item.%ConstructClone(1), i, functorValue, params...)
  }
  if $isobject(accumulated) && (accumulated.%Extends("%Collection.AbstractList") || accumulated.%Extends("%DynamicArray")) {
    quit ##class(FP.Functor).From(accumulated)
  }
  quit ##class(FP.Value).%New(accumulated)
}

Method Result() As %CacheString
{
  quit ..Functor.Result()
}

}

