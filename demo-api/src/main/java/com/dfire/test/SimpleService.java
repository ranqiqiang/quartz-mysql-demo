package com.dfire.test;

import java.io.Serializable;

import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


@Service("simpleService")
public class SimpleService {

    private static final Logger logger = LoggerFactory.getLogger(SimpleService.class);

    public void testMethod1(){
        //这里执行定时调度业务
        logger.info("testMethod1.......1");
        System.out.println(new DateTime().toString("yyyy-MM-dd hh:mm:ss"));
    }

    public void testMethod2(){
        logger.info("testMethod2.......2");
        System.out.println(222222);
    }
}