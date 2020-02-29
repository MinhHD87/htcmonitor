package vn.htc.monitor.app;

import java.util.ArrayList;
import java.util.Scanner;
import org.apache.log4j.Logger;
import static vn.htc.monitor.bootstrap.config.ReadProperties.CHECK;
import vn.htc.monitor.common.MyConfig;
import vn.htc.monitor.common.Tool;
import vn.htc.monitor.db.PoolMng;
import vn.htc.monitor.entity.Account;
import static vn.htc.monitor.entity.Account.CACHE;
import vn.htc.monitor.entity.MoniterStatus;
import vn.htc.monitor.entity.SystemMonitor;
import vn.htc.monitor.entity.model.Infomation;
import vn.htc.monitor.primarywork.Queue;
import vn.htc.monitor.service.Handling;
import vn.htc.monitor.service.ServerService;
import vn.htc.monitor.thread.LogTransactionBilling;
import vn.htc.monitor.thread.MonitorThread;
import vn.htc.monitor.thread.Sendmessegafromapp;
import vn.htc.monitor.thread.SocketCall;
//import vn.htc.monitor.thread.SocketCall;

public class MonitorApp extends Sendmessegafromapp {

    private static final Logger logger = Logger.getLogger(MonitorApp.class);
    public static boolean isRuning = true;
    public static int TPS_LOG = 100;
    public static int port = 8111;
    public static Queue<SystemMonitor> QUEUE_MONITOR_STATUS = new Queue("QUEUE_MONITOR_STATUS");
    //public static Account accountApp = new Account();

    static {
        try {
            // Log4j
            MyConfig.initLog4j();
            // Load Config
            MyConfig.loadConfig();
            // -- 

            //***********KHOI TAO ConnectionPoolManager**************
            if (!PoolMng.CreatePool()) {
                Tool.out("Khong khoi tao duoc ket noi DB");
                System.exit(1);
            }

            //-----------------------------------------
        } catch (Exception ex) {
            logger.error("Thong so gateway chua du..." + Tool.getLogMessage(ex));
            System.exit(1);
        }
    }

    public static WebServer websever;

    public static void appStop() {
        if (websever != null) {
            websever.stop();
        }

        Account.updateDB4Cache();

    }

    public static void reloadCnf() {
        MyConfig.loadConfig();
    }

    public static void main(String[] args) {
        try {

//            SocketCall moa = new SocketCall("monitorrrrrrrr1");
//            if (!moa.getState().toString().equals("RUNNABLE")) {
//                moa.start();
//            }
//            SocketCall moa1 = new SocketCall("HIEUPC");
//            if (!moa1.getState().toString().equals("RUNNABLE")) {
//                moa1.start();
//            }
            MoniterStatus moniterStatus = new MoniterStatus();
            ArrayList all = moniterStatus.findAll();
            
            System.out.println(all);
            
            MonitorThread monitorThread = new MonitorThread();
            monitorThread.start();

            //Webserver
//            websever = new WebServer();
//            websever.start();
//            Account acc = new Account();//Giu cho vui 
//            
//            AlertNotifyBalance_task notifyBalance = new AlertNotifyBalance_task();
//            notifyBalance.start();
//            
//            MonthlyCharg_task monthlyCharg = new MonthlyCharg_task();
//            monthlyCharg.start();
//            
//            MoniterApp moa = new MoniterApp();
//            moa.start();
//            
//            ReloadAble reload = new ReloadAble();
//            reload.start();
//            
//            LogTransactionBilling logBilling = new LogTransactionBilling();
//            logBilling.start();

//Hàm chạy thử gửi sms 
//  MonitorApp http = new MonitorApp();
//        System.out.println("Testing - Send Http POST request");
//        Sendmessegafromapp send = new Sendmessegafromapp();
//        String jsParams = "{\"phone\":\"" + "0374710096" + "\","
//                + "\"mess\":\"" + "TTC2TT" + "\","
//                + "\"user\":\"" + "brandhtc" + "\","
//                + "\"pass\":\"" + "BranHtc7" + "\","
//                + "\"tranId\":\"" + "TKYTT" + "\","
//                + "\"brandName\":\"" + "HTC" + "\","
//                + "\"dataEncode\":\"" + "0" + "\","
//                + "\"sendTime\":\"" + "" + "\","
//                + "\"telcoCode\":\"" + "" + "\"}";
////        send.sendSMS("http://api.brand1.xyz:8080/service/sms_api", jsParams);
//        System.out.println("+++++result" + Sendmessegafromapp.sendSMS("http://api.brand1.xyz:8080/service/sms_api", jsParams));
////Hàm chạy thử gửi voice 
//  MonitorApp http = new MonitorApp();
//        System.out.println("Testing - Send Http POST request");
//        Sendmessegafromapp send = new Sendmessegafromapp();
//        String jsParams = "{\"phone\":\"" + "0374710096" + "\","
//                + "\"mess\":\"" + "TTC2TT" + "\","
//                + "\"user\":\"" + "brandhtc" + "\","
//                + "\"pass\":\"" + "BranHtc7" + "\","
//                + "\"tranId\":\"" + "TKYTT" + "\","
//                + "\"brandName\":\"" + "HTC" + "\","
//                + "\"dataEncode\":\"" + "0" + "\","
//                + "\"sendTime\":\"" + "" + "\","
//                + "\"telcoCode\":\"" + "" + "\"}";
////        send.sendSMS("http://api.brand1.xyz:8080/service/sms_api", jsParams);
//        System.out.println("+++++result" + Sendmessegafromapp.sendSMS("http://api.brand1.xyz:8080/service/sms_api", jsParams));
//Hàm chạy thử gửi email 
//hàm chạy thử Telegram
//            Handling hand = new Handling();
//            hand.start();
//
//            ServerService service = new ServerService();
//            service.startServer(port);
        } catch (Exception e) {
            logger.error("Appstart.main:" + Tool.getLogMessage(e));
        }
    }
}
