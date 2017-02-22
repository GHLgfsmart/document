<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%  
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%> 
<!DOCTYPE html>
<html>  
  <head>  
    <base href="<%=basePath%>">  
      
    <title>验证码</title>  
    <meta http-equiv="pragma" content="no-cache">  
    <meta http-equiv="cache-control" content="no-cache">  
    <meta http-equiv="expires" content="0">      
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">  
    <meta http-equiv="description" content="This is my page">  
    <title>验证码</title>  
    <script type="text/javascript">  
    function refresh(obj) {  
        obj.src = "${pageContext.request.contextPath}/test/yzm?"+Math.random();  
    }  
    </script>  
  </head>  
    
  <body>  
   <form action="<%=path %>/test/login" method="post">
   		<input type="text" name="yanzhenma" placeholder="请输入验证码" />
        <img title="点击更换" onclick="javascript:refresh(this);" src="<%=path%>/test/yzm">
        <input type="submit" value="登录" />
    </form><br />  
    <a href="<%=path%>/test/sms">点击进入短信验证服务</a>
  </body>  
</html>