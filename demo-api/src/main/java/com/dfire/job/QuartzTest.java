package com.dfire.job;
import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;

import java.io.*;
import java.util.Properties;

import static org.quartz.CronScheduleBuilder.cronSchedule;
import static org.quartz.JobBuilder.*;
import static org.quartz.JobKey.jobKey;
import static org.quartz.TriggerBuilder.*;
import static org.quartz.SimpleScheduleBuilder.*;
import static org.quartz.TriggerKey.triggerKey;

public class QuartzTest {

    static  Properties props = new Properties();

    static {
        try {
            InputStream in = QuartzTest.class.getResourceAsStream("/quartz_local.properties");
            props.load(in);
            in.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {

        }
    }

    public static void main(String[] args) {

        try {
            // Grab the Scheduler instance from the Factory

            SchedulerFactory schedulerFactory = new StdSchedulerFactory(props);
            org.quartz.Scheduler scheduler = schedulerFactory.getScheduler();


            JobDetail job = newJob(TestJob.class)
                    .withIdentity("job1", "group1")
                    .build();

            SimpleTrigger tempTrigger = (SimpleTrigger) newTrigger()
                    .withIdentity(triggerKey("temp-trigger-tempTriggerGroup"))
                    .startNow()
                    .build();

            // Trigger the job to run now, and then repeat every 40 seconds
            Trigger trigger = newTrigger()
                    .withIdentity("trigger1", "group1")
                    .startNow()
                    .withSchedule(simpleSchedule()
                            .withIntervalInSeconds(5)
                            .repeatForever())
                    .build();


            CronTrigger trigger2 = newTrigger()
                    .withIdentity("trigger1","group1")
                    .withSchedule(cronSchedule("0/2 * * * * ?")).build();

            // Tell quartz to schedule the job using our trigger
            scheduler.scheduleJob(job, trigger2);
            int i = 0;
            while (i++%5==0){
                scheduler.deleteJob(jobKey("trigger1","group1"));
            }


            // and start it off
            scheduler.start();

//            scheduler.shutdown();

        } catch (SchedulerException se) {
            se.printStackTrace();
        }


    }
}
