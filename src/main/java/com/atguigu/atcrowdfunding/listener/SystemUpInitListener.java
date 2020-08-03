package com.atguigu.atcrowdfunding.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.atguigu.atcrowdfunding.util.Const;

public class SystemUpInitListener implements ServletContextListener {
	
	Logger log=LoggerFactory.getLogger(SystemUpInitListener.class);
	

	public void contextInitialized(ServletContextEvent sce) {
		ServletContext application = sce.getServletContext();
		String contextPath = application.getContextPath();
		log.debug("当前路径为{}",contextPath);
		application.setAttribute(Const.PATH, contextPath);

	}

	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		log.debug("当前应用终止了");

	}

}
