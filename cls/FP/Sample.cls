Class FP.Sample [ Abstract ]
{

ClassMethod Demo(item)
{
  set array = []
  
  for i=1:1:10000 {
    set proxy = ##class(%ZEN.proxyObject).%New()
    set proxy.value = i
    do array.%Push(proxy)
  }
  
  set DoubleItemValue = $classname()_":DoubleItemValue"
  set Odds = $classname()_":Odds"
  set LowerThanFifty = $classname()_":LowerThanFifty"
  set SumValues = $classname()_":SumValues"
  
  // Doubles the value and filter any odd value.
  set functor = ##class(FP.Functor).From(array).Map(DoubleItemValue).Filter(Odds)
  // Removes any value that is higher than 50.
  set lowerThanFiftyFunctor = functor.Filter(LowerThanFifty)
  // Now sum the remaining values and get the result.
  return lowerThanFiftyFunctor.Reduce(SumValues, 0).Result()
}

ClassMethod DoubleItemValue(item As %ZEN.proxyObject, i)
{
  set item.value = (item.value * 2)
  return item
}

ClassMethod Odds(item As %ZEN.proxyObject, i As %Integer)
{
  return (i # 2 '= 0)
}

ClassMethod LowerThanFifty(item As %ZEN.proxyObject, i As %Integer)
{
  return item.value <= 50
}

ClassMethod SumValues(accumulated As %Integer, item As %ZEN.proxyObject, i As %Integer, array As %RegisteredObject, params As %String) As %Integer
{
  return accumulated + item.value
}

}

