<center>
	<%
	for(int i=0;i<Integer.parseInt(pagetotal);i++){
	%>
<div class="btn-group">
	<a 
		class= 'btn btn-default'
		href='<% 
		if(!(Integer.toString(i+1)).equals(pageIndex))
		out.print(pageURL+"?pageIndex="+Integer.toString(i+1)+"&pagetotal="+pagetotal+"&totalInfo="+totalInfo+attachPara);
		%>'
		><%=Integer.toString(i+1)%></a>
</div>
<%}
%>
<div class="btn-group dropup">
</div>
</center>
