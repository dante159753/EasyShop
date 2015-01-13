<nav class="navbar navbar-default navbar-fixed-top">
	 <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="./">EasyShop</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <form action="showItem.jsp" class="navbar-form navbar-left" role="search">
        <div class="form-group">
          <input type="text" class="form-control" name="searchKey" id="searchBar" <%if(searchKey!=null)out.print("value='"+searchKey+"'");%> placeholder="输入关键字...">
        </div>
        <button type="submit" class="btn btn-default">搜索</button>
      </form>
      <%String userID="";
userID=(String)session.getAttribute("userID");
if(userID==null){
%>
      <ul class="nav navbar-nav navbar-right">
        <li class="active"><a href="login.jsp">登录</a></li>
        <li><a href="signUp.jsp">注册</a></li>
      </ul>
      <%}else{%>
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><%=session.getAttribute("username")%> <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="showCart.jsp">购物车</a></li>
            <li><a href="showOrder.jsp">我的订单</a></li>
            <li class="divider"></li>
            <li><a href="deleteSession.jsp">注销</a></li>
          </ul>
        </li>
      </ul>
      <%}%>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>