Class FP.Common [ Abstract ]
{

Property Content As %CacheString [ Private ];

Method Result() As %CacheString
{
  quit ..Content
}

Storage Default
{
<Data name="CommonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Content</Value>
</Value>
</Data>
<DataLocation>^FP.CommonD</DataLocation>
<DefaultData>CommonDefaultData</DefaultData>
<IdLocation>^FP.CommonD</IdLocation>
<IndexLocation>^FP.CommonI</IndexLocation>
<StreamLocation>^FP.CommonS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}

