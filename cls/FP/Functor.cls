Class FP.Functor Extends (%RegisteredObject, FP.Common)
{

Method %OnNew(mappable As %RegisteredObject) As %Status [ Private ]
{
  set ..Content = mappable
  quit $$$OK
}

ClassMethod From(mappable As %RegisteredObject) As FP.Monoid
{
  set functor = ..%New(mappable)
  quit ##class(FP.Monoid).%New(functor)
}

}

