package com.atguigu.test;

import static org.junit.Assert.*;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Slf4jTest {

    @Test
	public void test() {
		Logger log=LoggerFactory.getLogger(Slf4jTest.class);
		log.debug("debug 消息ID={},姓名={}",1,"ZHANGSAN");
		log.info("通知");
		log.warn("警告");
		log.error("错误");
	}

}
