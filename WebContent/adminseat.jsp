<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="UTF-8"
    import="util.User"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="util.Seats" %>
<%@ page import="util.DateManager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>显示用户-教室预定系统</title>

    <!-- Bootstrap core CSS -->
    <link href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>
	<% 
		User user = (User)session.getAttribute("user");
	%>
    
 
<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <img style="width:55px;height:51px;" src="./img/logo.jpg"/>
          <a class="navbar-brand hidden-sm" href="./index.jsp">教室预订系统</a>
        </div>
        <%
        if (user != null) { 
        	String tag = "";
        	String ref = "";
        	if (user.getUserType() == 0 || user.getUserType() == -1) {
        		tag = "学生界面";
        		ref = "./student_message.jsp";
        	} else if (user.getUserType() == 1 || user.getUserType() == -2) {
        		tag = "教师界面";
        		ref = "./teacher_message.jsp";
        	} else {
        		tag = "管理员界面";
        		ref = "./admin_message.jsp";
        	}
        }
        		
       	%>
        <div class="navbar-collapse collapse" role="navigation">
          <ul class="nav navbar-nav">
            <li><a href="./adminuser.jsp">管理用户</a></li>
            <li class = "active"><a href="./adminseat.jsp">个人座位预定</a></li>
            <li><a href="./AdminGroupServlet">团体预定</a></li>
            <li><a href="./SetAccessServlet">管理时间段开放权限</a></li>
            <li><a href="changepw.jsp">修改密码</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right hidden-sm">
          	<%if (user != null) { %>
			<li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">用户 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li style="text-align:center;"><a href="#"><%=user.getStudentnum()%></a></li>
                <li style="text-align:center;"><a href="./ExitServlet">退出</a></li>
              </ul>
            </li>
              <%} else { %>
              <li><a><%="尚未登录" %></a></li>
              <%} %>
          </ul>
        </div>
      </div>
    </div>
    
<%
 	 Seats[] seats = new Seats[10];
  	 seats = (Seats[])session.getAttribute("seats");
  	 String date = (String) session.getAttribute("bookdate");
  	int ddate = 0;
  	if(date != null){
  	  ddate = Integer.parseInt(date);
  	 ddate += 1;
  	}
%>
        <br><br><br>
    <div class="container">
    <form action="./PersonalSeatsServlet" method="post" onsubmit="return reg(this);" class="form-horizontal">
	            <div class="form-group">
	              <label for="authcode" class="col-sm-3 control-label" style="width:100px;">查询日期：</label>
	              <div class="col-sm-5">
	                <div class="input-group">
	                  <select class = "form-control" name="bookdate">
		    				<option selected value = "6"> <%=DateManager.getFormatDate(6) %> </option>
		    				<option selected value = "5"> <%=DateManager.getFormatDate(5) %> </option>
		    				<option selected value = "4"> <%=DateManager.getFormatDate(4) %> </option>
		    				<option selected value = "3"> <%=DateManager.getFormatDate(3) %> </option>
		    				<option selected value = "2"> <%=DateManager.getFormatDate(2) %> </option>
		    				<option selected value = "1"> <%=DateManager.getFormatDate(1) %> </option>
		    				<option selected value = "0"> <%=DateManager.getFormatDate(0) %> </option>
					  </select>
	            	</div>
	              </div>
	              </div>
	              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	              <input type="submit" class="btn btn-success" value="查 询">
		          <input type="reset" class="btn btn-success" value="重 置">
	 </form>	
	            </div>

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <%
    if (seats == null || seats.length == 0)
		{
		%>
		<div id="table" style="display: none" >
		<%
		} else {
    %>
    <div class="container">
    <form action="./DelSeatServlet" method="post" onsubmit="return reg(this);">
	<%
	int a = Integer.valueOf((String)session.getAttribute("bookdate"));
	%>
    <h1>取消个人座位预订&nbsp;<%=DateManager.getFormatDate(a) %></h1>
		<input type = 'hidden' name = "bookdate" value = <%=ddate - 1%>>
		<table class="table table-striped">
		   <thead>
		      <tr>
		      	 <th align="right">座位号</th>
		      	 <th ><%=DateManager.getPeroid(0) %></th>
		         <th><%=DateManager.getPeroid(1) %></th>
		         <th><%=DateManager.getPeroid(2) %></th>
		         <th><%=DateManager.getPeroid(3) %></th>
		         <th><%=DateManager.getPeroid(4) %></th>
		      </tr>
		   </thead>
		   <tbody>
		   
<%
	

	for (int i = 0 ; i < seats.length ; i ++)
	{
		
%>
		      <tr>
		      	<td><%="座位"+i %></td>
	  			<%
	  			if( seats[i].getPeroid0()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><span><input type = "radio" name = "delSeat" id = <%=i + "_0" %> value = <%=i + "_0_" + seats[i].getPeroid0()  %>>
		  			<%=seats[i].getOwnerPeroid0() %></span></td>
		  		<%
	  			} else if ( seats[i].getPeroid0()==0 ){
	  				%><td bgcolor="green">空闲</td><%
	  			} else if ( seats[i].getPeroid0()==2 ) {
	  				%><td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid0() != null)
	  				{
	  				%>
	  				<span><input type = "radio" name = "delSeat" id = <%=i + "_0" %> value = <%=i + "_0_" + seats[i].getPeroid0()  %>>
		  			<%=seats[i].getOwnerPeroid0() %></span>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				已过期
	  				<%
	  				}
	  				%>
	  				</td><%
	  				
	  			} else if ( seats[i].getPeroid0()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
	  			
	  			<%
	  			if( seats[i].getPeroid1()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><span><input type = "radio" name = "delSeat" id = <%=i + "_1" %> value = <%=i + "_1_" + seats[i].getPeroid1()  %>>
		  			<%=seats[i].getOwnerPeroid1() %></span></td>
		  		<%
	  			} else if ( seats[i].getPeroid1()==0 ){
	  				%><td bgcolor="green">空闲</td><%
	  			}else if ( seats[i].getPeroid1()==2 ) {
	  				%><td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid1() != null)
	  				{
	  				%>
	  				<span><input type = "radio" name = "delSeat" id = <%=i + "_1" %> value = <%=i + "_1_" + seats[i].getPeroid1()  %>>
		  			<%=seats[i].getOwnerPeroid1() %></span>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				已过期
	  				<%
	  				}
	  				%>
	  				</td><%
	  				
	  			} else if ( seats[i].getPeroid1()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
	  			
	  			<%
	  			if( seats[i].getPeroid2()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><span><input type = "radio" name = "delSeat" id = <%=i + "_2" %> value = <%=i + "_2_" + seats[i].getPeroid2()  %>>
		  			<%=seats[i].getOwnerPeroid2() %></span></td>
		  		<%
	  			} else if ( seats[i].getPeroid2()==0 ){
	  				%><td bgcolor="green">空闲</td><%
	  			} else if ( seats[i].getPeroid2()==2 ) {
	  				%><td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid2() != null)
	  				{
	  				%>
	  				<span><input type = "radio" name = "delSeat" id = <%=i + "_2" %> value = <%=i + "_2_" + seats[i].getPeroid2()  %>>
		  			<%=seats[i].getOwnerPeroid2() %></span>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				已过期
	  				<%
	  				}
	  				%>
	  				</td><%
	  				
	  			} else if ( seats[i].getPeroid2()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
	  			
	  			<%
	  			if( seats[i].getPeroid3()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><span><input type = "radio" name = "delSeat" id = <%=i + "_3" %> value = <%=i + "_3_" + seats[i].getPeroid3()  %>>
		  			<%=seats[i].getOwnerPeroid3() %></span></td>
		  		<%
	  			} else if ( seats[i].getPeroid3()==0 ){
	  				%><td bgcolor="green">空闲</td><%
	  			} else if ( seats[i].getPeroid3()==2 ) {
	  				%><td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid3() != null)
	  				{
	  				%>
	  				<span><input type = "radio" name = "delSeat" id = <%=i + "_3" %> value = <%=i + "_3_" + seats[i].getPeroid3()  %>>
		  			<%=seats[i].getOwnerPeroid3() %></span>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				已过期
	  				<%
	  				}
	  				%>
	  				</td><%
	  				
	  			}else if ( seats[i].getPeroid3()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
	  			
	  			<%
	  			if( seats[i].getPeroid4()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><span><input type = "radio" name = "delSeat" id = <%=i + "_4" %> value = <%=i + "_4_" + seats[i].getPeroid4()  %>>
		  			<%=seats[i].getOwnerPeroid4() %></span></td>
		  		<%
	  			} else if ( seats[i].getPeroid4()==0 ){
	  				%><td bgcolor="green">空闲</td><%
	  			} else if ( seats[i].getPeroid4()==2 ) {
	  				%><td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid4() != null)
	  				{
	  				%>
	  				<span><input type = "radio" name = "delSeat" id = <%=i + "_4" %> value = <%=i + "_4_" + seats[i].getPeroid4()  %>>
		  			<%=seats[i].getOwnerPeroid4() %></span>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				已过期
	  				<%
	  				}
	  				%>
	  				</td><%
	  				
	  			} else if ( seats[i].getPeroid4()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
		      </tr>
 <%}%>
		   </tbody>
		</table>
		
		<input type="submit" class="btn btn-success" value="取消预订" onclick="if(!confirm('确定取消？'))return false;">
		<input type="reset" class="btn btn-success" value="重 置">
		</form>
	  </div>
	  <%} %>
<% 
if(seats != null) { 
%>
	<input type = 'hidden' name = "bookdate" value = <%=ddate - 1%>>
    <div class="container">
    <form action="./AddSeatServlet" method="post" onsubmit="return reg(this);">
    <%
	int a1 = Integer.valueOf((String)session.getAttribute("bookdate"));
	%>
    <div style="float:left;"><h1>添加个人座位预订&nbsp;<%=DateManager.getFormatDate(a1) %></h1></div>
    <div style="float:right;">
        <div class="container">
	            <div class="form-group">
	              <label for="authcode" class="col-sm-3 control-label" style="width:100px;">用户：</label>
	              <div class="col-sm-5">
	                <div class="input-group">
	                  <select class = "form-control" name="bookuser">
						<%
			   			ArrayList<User> showallusers = (ArrayList<User>)session.getAttribute("showallusers");
			   			for (int j = 0 ; j < showallusers.size() ; j ++)
			   			{
			   				if(showallusers.get(j).getUserType() == 0)
			   				{
			   			%>
			   				<option selected value = <%=showallusers.get(j).getStudentnum() %>> <%=showallusers.get(j).getStudentnum() %> </option>
			   				
			   			
			   			<%
			   				}
			   			}
			   			%>
					  </select>
	            	</div>
	              </div>
	              </div>
	            </div>
    </div>

		<table class="table table-striped">
		   <thead>
		      <tr>
		      	 <th align="right">座位号</th>
		      	 <th ><%=DateManager.getPeroid(0) %></th>
		         <th><%=DateManager.getPeroid(1) %></th>
		         <th><%=DateManager.getPeroid(2) %></th>
		         <th><%=DateManager.getPeroid(3) %></th>
		         <th><%=DateManager.getPeroid(4) %></th>
		      </tr>
		   </thead>
		   <tbody>
		   <%
		   for (int i = 0 ; i < seats.length ; i ++)
		   {
		   %>
		   <tr>
		   <td><%="座位"+i %></td>
		   
	  			<%
	  			if( seats[i].getPeroid0()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><%=seats[i].getOwnerPeroid0() %></td>
		  		<%
	  			} else if ( seats[i].getPeroid0()==0 ){
	  				%><td bgcolor="green">
	  				<input type = "radio" name = "addSeat" id = <%=i + "_0" %> value = <%=i + "_0_" + seats[i].getPeroid0()  %>>
	  				空闲
	  				</td><%
	  			} else if ( seats[i].getPeroid0()==2 ) {
	  				%><td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid0() != null)
	  				{
	  				%>
	  				<%-- <span><input type = "radio" name = "addSeat" id = <%=i + "_0" %> value = <%=i + "_0_" + seats[i].getPeroid0()  %>> --%>
		  			<%=seats[i].getOwnerPeroid0() %></span>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				<span><input type = "radio" name = "addSeat" id = <%=i + "_0" %> value = <%=i + "_0_" + seats[i].getPeroid0()  %>>已过期</span>
	  				<%
	  				}
	  				%>
	  				</td><%
	  				
	  			} else if ( seats[i].getPeroid0()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
		   
	  			<%
	  			if( seats[i].getPeroid1()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><%=seats[i].getOwnerPeroid1() %></td>
		  		<%
	  			} else if ( seats[i].getPeroid1()==0 ){
	  				%><td bgcolor="green">
	  				<input type = "radio" name = "addSeat" id = <%=i + "_1" %> value = <%=i + "_1_" + seats[i].getPeroid1()  %>>
	  				空闲
	  				</td><%
	  			} else if ( seats[i].getPeroid1()==2 ) {
	  				%><td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid1() != null)
	  				{
	  				%>
	  				<%-- <span><input type = "radio" name = "addSeat" id = <%=i + "_1" %> value = <%=i + "_1_" + seats[i].getPeroid1()  %>> --%>
		  			<%=seats[i].getOwnerPeroid1() %></span>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				<span><input type = "radio" name = "addSeat" id = <%=i + "_1" %> value = <%=i + "_1_" + seats[i].getPeroid1()  %>>已过期</span>
	  				<%
	  				}
	  				%>
	  				</td><%
	  				
	  			} else if ( seats[i].getPeroid1()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
		   
	  			<%
	  			if( seats[i].getPeroid2()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><%=seats[i].getOwnerPeroid2() %></td>
		  		<%
	  			} else if ( seats[i].getPeroid2()==0 ){
	  				%><td bgcolor="green">
	  				<input type = "radio" name = "addSeat" id = <%=i + "_2" %> value = <%=i + "_2_" + seats[i].getPeroid2()  %>>
	  				空闲
	  				</td><%
	  			} else if ( seats[i].getPeroid2()==2 ) {
	  				%><td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid2() != null)
	  				{
	  				%>
	  				<%-- <span><input type = "radio" name = "addSeat" id = <%=i + "_2" %> value = <%=i + "_2_" + seats[i].getPeroid2()  %>> --%>
		  			<%=seats[i].getOwnerPeroid2() %></span>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				<span><input type = "radio" name = "addSeat" id = <%=i + "_2" %> value = <%=i + "_2_" + seats[i].getPeroid2()  %>>已过期</span>
	  				<%
	  				}
	  				%>
	  				</td><%
	  				
	  			}else if ( seats[i].getPeroid2()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
		   
	  			<%
	  			if( seats[i].getPeroid3()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><%=seats[i].getOwnerPeroid3() %></td>
		  		<%
	  			} else if ( seats[i].getPeroid3()==0 ){
	  				%><td bgcolor="green">
	  				<input type = "radio" name = "addSeat" id = <%=i + "_3" %> value = <%=i + "_3_" + seats[i].getPeroid3()  %>>
	  				空闲
	  				</td><%
	  			} else if ( seats[i].getPeroid3()==2 ) {
	  				%><td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid3() != null)
	  				{
	  				%>
	  				<%-- <span><input type = "radio" name = "addSeat" id = <%=i + "_3" %> value = <%=i + "_3_" + seats[i].getPeroid3()  %>> --%>
		  			<%=seats[i].getOwnerPeroid3() %></span>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				<span><input type = "radio" name = "addSeat" id = <%=i + "_3" %> value = <%=i + "_3_" + seats[i].getPeroid3()  %>>已过期</span>
	  				<%
	  				}
	  				%>
	  				</td><%
	  				
	  			} else if ( seats[i].getPeroid3()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
		   
	  			<%
	  			if( seats[i].getPeroid4()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><%=seats[i].getOwnerPeroid4() %></td>
		  		<%
	  			} else if ( seats[i].getPeroid4()==0 ){
	  				%><td bgcolor="green">
	  				<input type = "radio" name = "addSeat" id = <%=i + "_4" %> value = <%=i + "_4_" + seats[i].getPeroid4()  %>>
	  				空闲
	  				</td><%
	  			} else if ( seats[i].getPeroid4()==2 ) {
	  				%><td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid4() != null)
	  				{
	  				%>
	  				<%-- <span><input type = "radio" name = "addSeat" id = <%=i + "_4" %> value = <%=i + "_4_" + seats[i].getPeroid4()  %>> --%>
		  			<%=seats[i].getOwnerPeroid4() %></span>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				<span><input type = "radio" name = "addSeat" id = <%=i + "_4" %> value = <%=i + "_4_" + seats[i].getPeroid4()  %>>已过期</span>
	  				<%
	  				}
	  				%>
	  				</td><%
	  				
	  			} else if ( seats[i].getPeroid4()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
		   
		   
		   
		   
		   </tr>		
		   <%
		   }}
		   %>
		   

		   
		   
		   </tbody>
		</table>
		
		<input type="submit" class="btn btn-success" value="添加用户预定" onclick="if(!confirm('确定添加该座位？'))return false;">
		<input type="reset" class="btn btn-success" value="重 置">
		</form>
	  </div>
	  

	  
    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
        </div>
      </div>

      <hr>

      <footer>
        <p>&copy; 版权所有 教研院</p>
      </footer>
    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
