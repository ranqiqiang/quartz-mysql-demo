package com.dfire.crud;

import com.dfire.job.TestJob;
import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import static org.quartz.CronScheduleBuilder.cronSchedule;
import static org.quartz.JobBuilder.newJob;
import static org.quartz.JobKey.jobKey;
import static org.quartz.TriggerBuilder.newTrigger;
import static org.quartz.TriggerKey.triggerKey;

/**
 * Created by qqr on 16/8/16.
 */
public class Stop {
    static Properties props = new Properties();

    static {
        try {
            InputStream in = Stop.class.getResourceAsStream("/quartz_local.properties");
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
                    .withSchedule(cronSchedule("0/3 * * * * ?")).build();

            scheduler.scheduleJob(job, trigger2);
            scheduler.start();

            TriggerKey triggerKey = TriggerKey.triggerKey(triggerName, triggerGroupName);
            JobKey jobKey = trigger2.getJobKey();

            Thread.sleep(1000 * 10);
            System.out.println("停止");
            scheduler.pauseJob(jobKey);

            Thread.sleep(1000 * 10);
            System.out.println("从新开启");
            scheduler.resumeJob(jobKey);

            Thread.sleep(1000 * 10);
            System.out.println("移除触发器");
            scheduler.unscheduleJob(triggerKey);


            Thread.sleep(1000 * 10);
            System.out.println("删除任务");
            scheduler.deleteJob(jobKey);


        } catch (SchedulerException se) {
            se.printStackTrace();
        }
    }
}
