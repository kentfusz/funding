package com.atguigu.atcrowdfunding.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.service.TAdminService;
import com.atguigu.atcrowdfunding.service.TMenuService;
import com.atguigu.atcrowdfunding.service.TRoleService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.MD5Util;

@Controller
public class DispatchController {
	
	@Autowired
	TAdminService adminService;
	
	@Autowired
	TRoleService roleService;
	
	@Autowired
	TMenuService menuService;

	Logger log = LoggerFactory.getLogger(DispatchController.class);
	
	
	@RequestMapping("/main")
	public String main(HttpSession session) {
		
		if (session==null) {
			return "redirect:/login";
		}
		
		List<TMenu> menuList =(List<TMenu>) session.getAttribute("menuList");
		
		if (menuList==null) {
			menuList = menuService.listMenuAll();
			
			session.setAttribute("menuList", menuList);
			
		}
		

		
		return "main";
	}
	
	
	
	@RequestMapping("/index")
	public String index() {
		log.debug("跳转到系统主页面");
		return "index";
	}
	
	
	@RequestMapping("/login")
	public String login() {
		log.debug("跳转到登录页面");	

		return "login";
	}
	
//	@RequestMapping("/logout")
//	public String logout(HttpSession session) {
//		
//		if (session !=null) {
//			session.removeAttribute(Const.LOGIN_ADMIN);
//			session.invalidate();
//		}
//		return "redirect:/index";
//	}
	
	
//	@RequestMapping("/doLogin")
//	public String doLogin(String loginacct,String userpswd,HttpSession session,Model model) {
//		log.debug("登录中.....");
//		
//		log.debug("用户名={}",loginacct);
//		log.debug("用户密码={}",userpswd);
//		
//		Map<String, Object> paramMap=new HashMap<String, Object>();
//		paramMap.put("loginacct", loginacct);
//		paramMap.put("userpswd",userpswd);
//		
//		try {
//			TAdmin admin=adminService.getTAdminByLogin(paramMap);
//			session.setAttribute(Const.LOGIN_ADMIN, admin);
//			log.debug("登录成功");
//			
//			return "redirect:/main";
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			
//			log.debug("登录失败={}",e.getMessage());
//			model.addAttribute("message", e.getMessage());
//			return "login";
//		}
//		
		
		
	

}
