package com.dfire.crud;

import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

/**
 * Created by qqr on 16/8/15.
 */
public class Update {
   static  Properties props = new Properties();
    static {
        String dbUrl="";
        String dbDriver="";
        String dbUsername="";
        String dbPassword="";
        final String DATASOURCE_NAME = "ArtDS";

        final String INSTANCE_NAME = "org.quartz.scheduler.instanceName";
        final String SKIP_UPDATE = "org.quartz.scheduler.skipUpdateCheck";
        final String MAKE_SCHEDULER_DAEMON = "org.quartz.scheduler.makeSchedulerThreadDaemon";
        final String THREAD_POOL_CLASS = "org.quartz.threadPool.class";
        final String THREAD_COUNT = "org.quartz.threadPool.threadCount";
        final String MAKE_THREADS_DAEMONS = "org.quartz.threadPool.makeThreadsDaemons";
        final String DRIVER_DELEGATE = "org.quartz.jobStore.driverDelegateClass";
        final String JOB_STORE_CLASS = "org.quartz.jobStore.class";
        final String DRIVER = "org.quartz.dataSource." + DATASOURCE_NAME + ".driver";
        final String URL = "org.quartz.dataSource." + DATASOURCE_NAME + ".URL";
        final String USER = "org.quartz.dataSource." + DATASOURCE_NAME + ".user";
        final String PASSWORD = "org.quartz.dataSource." + DATASOURCE_NAME + ".password";
        final String VALIDATION_QUERY = "org.quartz.dataSource." + DATASOURCE_NAME + ".validationQuery";
        final String JNDI_URL = "org.quartz.dataSource." + DATASOURCE_NAME + ".jndiURL";


        File quartzFile = new File("quartz.properties");
        if (quartzFile.exists()) {
            FileInputStream o = null;
            try {
                o = new FileInputStream(quartzFile);
                props.load(o);
                o.close();
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }finally {

            }

        }
    }




    public static void main(String[] args) throws SchedulerException {

//        SchedulerFactory schedulerFactoryBean = new StdSchedulerFactory(props);
//        Scheduler scheduler = schedulerFactoryBean.getScheduler();
//        TriggerKey triggerKey = TriggerKey.triggerKey(scheduleJob.getJobName(),
//                scheduleJob.getJobGroup());
//
//        //获取trigger，即在spring配置文件中定义的 bean id="myTrigger"
//        CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
//
//        //表达式调度构建器
//        CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(scheduleJob
//                .getCronExpression());
//
//        //按新的cronExpression表达式重新构建trigger
//        trigger = trigger.getTriggerBuilder().withIdentity(triggerKey)
//                .withSchedule(scheduleBuilder).build();
//
//        //按新的trigger重新设置job执行
//        scheduler.rescheduleJob(triggerKey, trigger);
    }
}
