Class FP.Value Extends (%RegisteredObject, FP.Common)
{

Method %OnNew(value As %CacheString = "") As %Status
{
  set ..Content = value
  quit $$$OK
}

}

