<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%  
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>短信验证码</title>
<style type="text/css">
.getPwd_btn{border:none;color: #fff;width: 120px;height: 40px;line-height: 40px;text-align:center;font-size: 16px;border-radius: 5px;display: inline-block;cursor:pointer;}
.getPwd_btn i{cursor:pointer;}
</style>
</head>
<body>
	<form>
		<ol>
			<li><i>手机号码</i>
                <input type="text"  id="userinfo.phone" placeholder="输入手机号码" class="input input2" onfocus="javascript:checkPhone12();" onblur="javascript:checkPhone1s2(this.value);" name="userinfo.phone" /><span id="span5s" class="spans"></span>
                <span class="error"></span>            
            </li>
			<li>
				<input id="userinfo.remark" type="text" placeholder="验证码" value="" name="userinfo.remark" class="input_text">
				<!--<s:textfield name="random" size="10px"></s:textfield>-->
				<span style="margin-left:5px;background:#2da7e0;display:none" class="getPwd_btn" id="getPwd_btn" onclick="getPwd_btn();"  />获取验证码</span><span class="time" id="time_con" style="display:none"><i id="time">30</i> 秒后可重新获取验证码</span>
				<span style="margin-left:5px;background:#ddd;display:inline-block;cursor: default;" class="getPwd_btn" id="getPwd_btn_hide"   />获取验证码</span><span class="time" id="time_con" style="display:none"><br/>
				<span id="span8s" class="spans" ></span>
            </li>
            <li>
            	<input type="submit" value="确定" class="input_a" id="reg-btn" onclick="validate()">
            </li>
		</ol>
	</form>
	
	<script type="text/javascript" src="<%=path %>/js/jquery-1.7.2.js"></script>
    <script  type="text/javascript">
		  //倒计时 
		    function getPwd_btn(){
		    	//alert("aaa");
		 	  var phone=document.getElementById("userinfo.phone").value;
			  var timenow = new Date().getTime(); 
		    	$.ajax({
		    		   url: "<%=path %>/test/note_verify",
		    		   type: "POST", 
		    		   data: "d="+timenow+"&phone="+phone, 
		    		   success: function(data){ 
		    		     //alert(data);//返回的数据	 
		    		   }  
		    		});
			  
		      var getPwd_btn=document.getElementById("getPwd_btn");
		      var timer=null;
		      var i = 29;
		            timer=setInterval(function(){ 
		                document.getElementById("time_con").style.display="inline-block"        
		                document.getElementById("time").innerHTML = i--;
		                getPwd_btn.style.background="#ddd";
		                if(i == -1) {                    
		                    clearInterval(timer);                    
		                    document.getElementById("time_con").style.display="none";
		                    getPwd_btn.style.background="#2da7e0";
		                }
		            },1000); 
		          
		        };

		        function checkPhone12(){
		        	document.getElementById("span5s").innerHTML="请输入手机号或座机";
		        }

		        function checkPhone1s2(phone){
		        	var phone1=document.getElementById("userinfo.phone");
		        	//alert(phone1.value);
		        	if(phone1.value==''||phone1.value==null){
		        		document.getElementById("span5s").innerHTML="<img src='images/icon2.png' /><font color='red'>手机号码格式错误</font>";
		        		document.getElementById("getPwd_btn_hide").style.display="inline-block";
		        		document.getElementById("getPwd_btn").style.display="none";
		        	}else{
		        		var p=/(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\(\d{3}\))|(\d{3}\-))?(1[358]\d{9})$)/;
		        		document.getElementById("getPwd_btn_hide").style.display="inline-block";
		        		document.getElementById("getPwd_btn").style.display="none";
		        		if(!p.exec(phone1.value)){
		        			document.getElementById("span5s").innerHTML="<img src='images/icon2.png' /><font color='red'>手机号码格式错误</font>";
		        		}else{
		        			document.getElementById("span5s").innerHTML="<img src='images/icon1.png' />";
		        			if(window.ActiveXObject){
		        				xhr = new ActiveXObject("Microsoft.XMLHTTP");
		        			}else if(window.XMLHttpRequest){
		        				xhr = new XMLHttpRequest();
		        			}else{
		        				alert("can't create xhr object!");
		        			}
		        		    /* xhr.open("get", "/ZhongCaiBao/userinfo/checkUser.action?checkFlag=phone&userinfo.phone="+phone); */
		        		   /*  xhr.send(null);
		        		    xhr.onreadystatechange=doResponse;
		        		    function doResponse(){
		        		    	//alert("doResponse()");
		        			    if(xhr.readyState==4&&xhr.status==200){
		        			    	var txt=xhr.responseText;
		        			        if(txt=='手机号可以使用'){
		        			    	   document.getElementById("span5s").innerHTML="<img src='images/icon1.png' />"+txt;
		        			    	   document.getElementById("getPwd_btn").style.display="inline-block";
		        			    	   document.getElementById("getPwd_btn_hide").style.display="none";
		        			        }else{
		        			    	   document.getElementById("span5s").innerHTML="<img src='images/icon2.png' />"+txt;
		        			        }
		        			    }
		          
		        			} */
		        			document.getElementById("getPwd_btn").style.display="inline-block";
     			    	   document.getElementById("getPwd_btn_hide").style.display="none";
		        		}
		        	}
		        }
	</script>
</body>
</html>