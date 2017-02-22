package com.lgf.servlet;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lgf.util.RandomValidateCode;
import com.opensymphony.xwork2.ActionContext;
import com.sun.org.apache.xerces.internal.util.SynchronizedSymbolTable;
import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;

public class RandomValidateCodeServlet extends javax.servlet.http.HttpServlet{

	private static final long serialVersionUID = 2263207880438608493L;
	
	/*@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("image/jpeg");//设置相应类型,告诉浏览器输出的内容为图片  
        response.setHeader("Pragma", "No-cache");//设置响应头信息，告诉浏览器不要缓存此内容  
        response.setHeader("Cache-Control", "no-cache");  
        response.setDateHeader("Expire", 0);  
        RandomValidateCode randomValidateCode = new RandomValidateCode();  
        try {  
            randomValidateCode.getRandcode(request, response);//输出图片方法  
        } catch (Exception e) {  
            e.printStackTrace();
        }  
	}*/
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String method = request.getRequestURI();
		method = method.substring(method.lastIndexOf("/")+1);
		if(method.equals("yzm")) {
			response.setContentType("image/jpeg");//设置相应类型,告诉浏览器输出的内容为图片  
	        response.setHeader("Pragma", "No-cache");//设置响应头信息，告诉浏览器不要缓存此内容  
	        response.setHeader("Cache-Control", "no-cache");  
	        response.setDateHeader("Expire", 0);  
	        RandomValidateCode randomValidateCode = new RandomValidateCode();  
	        try {  
	            randomValidateCode.getRandcode(request, response);//输出图片方法  
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		}else if(method.equals("login")) {
			String yzm = null;
			if(request.getParameter("yanzhenma") != null){
				yzm = request.getParameter("yanzhenma").toUpperCase();
			}
			String yuanyzm = String.valueOf(request.getSession().getAttribute("RANDOMVALIDATECODEKEY"));
			System.out.println("输入验证码："+yzm+"原验证码:"+yuanyzm);
			if(yzm.equals(yuanyzm)){
				System.out.println("正确");
			}else {
				System.out.println("错误");
			}
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}else if(method.equals("sms")) {
			request.getRequestDispatcher("/WEB-INF/jsp/note_verify.jsp").forward(request, response);
		}else if(method.equals("note_verify")) {
			String result = null;
			String random = "";
			for(int i=0; i<6; i++) {
				random+=new Random().nextInt(10);
			}
			ActionContext.getContext().getSession().put("random", random);// 取得随机字符串放入HttpSession
			String phone = request.getParameter("phone");
			System.out.println(phone+"***********"+random);
			TaobaoClient client = new DefaultTaobaoClient("http://gw.api.taobao.com/router/rest", "23637582", "45fb58aad30d5c3bbddaab9bb540a32e");
			AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
			req.setExtend( "" );
			req.setSmsType( "normal" );
			req.setSmsFreeSignName( "短信测试" );  //短信签名
			req.setSmsParamString( "{name:"+random+"}" );	//短信模板
			req.setRecNum(phone);	//电话号码
			req.setSmsTemplateCode( "SMS_47450135" );	//短信模板ID
			AlibabaAliqinFcSmsNumSendResponse rsp;
			try {
				rsp = client.execute(req);
				System.out.println(rsp.getBody());
				result = rsp.getSubMsg();
			} catch (ApiException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println(result+"///");
		}
	}
}
