package com.dfire.crud;

import com.dfire.job.TestJob;
import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;

import java.io.*;
import java.util.Properties;

import static org.quartz.CronScheduleBuilder.cronSchedule;
import static org.quartz.JobBuilder.newJob;
import static org.quartz.JobKey.jobKey;
import static org.quartz.SimpleScheduleBuilder.simpleSchedule;
import static org.quartz.TriggerBuilder.newTrigger;
import static org.quartz.TriggerKey.triggerKey;

/**
 * Created by qqr on 16/8/15.
 */
public class Update {
    static  Properties props = new Properties();

    static {
        try {
            InputStream in = Update.class.getResourceAsStream("/quartz_local.properties");
            props.load(in);
            in.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {

        }
    }

    public static void main(String[] args) throws InterruptedException {

        try {
            // Grab the Scheduler instance from the Factory

            SchedulerFactory schedulerFactory = new StdSchedulerFactory(props);
            org.quartz.Scheduler scheduler = schedulerFactory.getScheduler();


            JobDetail job = newJob(TestJob.class)
                    .withIdentity("job1", "group1")
                    .build();

            String triggerName = "trigger1";
            String triggerGroupName = "group1";
            CronTrigger trigger2 = newTrigger()
                    .withIdentity(triggerName, triggerGroupName)
                    .withSchedule(cronSchedule("0/5 * * * * ?")).build();

            scheduler.scheduleJob(job, trigger2);
            scheduler.start();

            /*----------------------------------------------------*/
            Thread.sleep(1000 * 10);
            System.out.println("更新任务");
            TriggerKey triggerKey = TriggerKey.triggerKey(triggerName, triggerGroupName);
            // 触发器
            TriggerBuilder<Trigger> triggerBuilder = TriggerBuilder.newTrigger();
            // 触发器名,触发器组
            triggerBuilder.withIdentity(triggerName, triggerGroupName);
            triggerBuilder.startNow();
            // 触发器时间设定
            triggerBuilder.withSchedule(CronScheduleBuilder.cronSchedule("0/1 * * * * ?"));
            // 创建Trigger对象
            trigger2 = (CronTrigger) triggerBuilder.build();
            // 方式一 ：修改一个任务的触发时间
            scheduler.rescheduleJob(triggerKey, trigger2);



        } catch (SchedulerException se) {
            se.printStackTrace();
        }
    }


}
