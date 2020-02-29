/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.htcjsc.brandname.voice.services;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.htcjsc.brandname.voice.commons.HttpUtil;
import vn.htcjsc.brandname.voice.commons.Tool;
import vn.htcjsc.brandname.voice.config.MyConfig;
import vn.htcjsc.brandname.voice.dao.SysAccountDaoIF;
import vn.htcjsc.brandname.voice.model.SysAccount;
import vn.htcjsc.brandname.voice.model.ext.ConfigAction;

/**
 *
 * @author Private
 */
@Service("accService")
@Transactional
public class SysAccountServiceImpl implements SysAccountService {

    static final Logger logger = Logger.getLogger(SysAccountServiceImpl.class);

    @Autowired
    SysAccountDaoIF accDao;
    @Autowired

    //--

    static String[] USER_BLACK_LIST = {"admin",
        "administrator",
        "moderator",
        "mode",
        "quantri",};

    public static boolean isBlackList(String user) {
        boolean result = false;
        for (String one : USER_BLACK_LIST) {
            if (user.startsWith(one)) {
                result = true;
                break;
            }
        }
        return result;
    }

    public static void outerReload() {

    }

    @Override
    public ArrayList<SysAccount> view(int page, int maxRow, String key, String phone, String email, int status, boolean isdel) {
        return accDao.view(page, maxRow, key, phone, email, status, isdel);
    }

    @Override
    public int count(String key, String phone, String email, int status, boolean isdel) {
        return accDao.count(key, phone, email, status, isdel);
    }

    @Override
    public SysAccount getSysAccountLogin(HttpSession session) {
        SysAccount acc = null;
        try {
            acc = (SysAccount) session.getAttribute(MyConfig.USER_SESSION_NAME);
        } catch (Exception e) {
            logger.error("SysAccount.getSysAccount:" + Tool.getLogMessage(e));
        }
        return acc;
    }

    @Override
    public String getUserName(HttpServletRequest request) {
        SysAccount acc = getSysAccountLogin(request);
        if (acc != null) {
            return acc.getUsername();
        } else {
            return "Unknow";
        }
    }

    @Override
    public SysAccount getSysAccountLogin(HttpServletRequest request) {
        SysAccount acc = null;
        try {
            HttpSession session = request.getSession(false);
            acc = (SysAccount) session.getAttribute(MyConfig.USER_SESSION_NAME);
        } catch (Exception e) {
            logger.error("SysAccount.getSysAccount:" + Tool.getLogMessage(e));
        }
        return acc;
    }

    @Override
    public SysAccount findById(int accID) {
        return accDao.findById(accID);
    }

    @Override
    public SysAccount checkLoginDB(String userName, String password) {
        SysAccount account = accDao.checkLoginDB(userName, password);
        if (account != null) {
        }
        return account;
    }

    @Override
    public int create(SysAccount oneAcc) {
        if (isBlackList(oneAcc.getUsername())) {
            return -1;
        }
        return accDao.create(oneAcc);
    }

    @Override
    public SysAccount update(SysAccount accUpdate) {
        return accDao.update(accUpdate);
    }

    @Override
    public SysAccount delete(int accID) {
        return accDao.delete(accID);
    }

    @Override
    public SysAccount deleteForEver(int accID) {
        return accDao.deleteForEver(accID);
    }

    @Override
    public SysAccount undoDelete(int accID) {
        return accDao.undoDelete(accID);
    }

    @Override
    public boolean updateIsdelete(int accID) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated 
    }
//--

    @Override
    public ArrayList<SysAccount> findSysAccountOnRole(int page, int maxrow, String key) {
        return accDao.findSysAccountOnRole(page, maxrow, key);
    }

    @Override
    public int countSysAccountOnRole(String key) {
        return accDao.countSysAccountOnRole(key);
    }

    @Override
    public HashMap<String, Boolean> checkRight(HttpServletRequest request) {
        HashMap<String, Boolean> hasRole = new HashMap<>();
        SysAccount account = getSysAccountLogin(request);
        if (account != null) {
            // Lay ra modul dang truy xuat
            String uri = HttpUtil.getURI(request);
            uri = Tool.removeEndCharactor(uri, "/");
//            System.out.println("uri=" + uri);
//            System.out.println("Module Id="+moduleId);
//            System.out.println("checkRight moduleId:"+moduleId);
            if (account.isDebug()) {
                ArrayList<String> listRole = ConfigAction.listNameAction();
                for (String one : listRole) {
                    hasRole.put(one, Boolean.TRUE);
                }
            }
        }
        return hasRole;
    }

    /**
     *
     * @param request
     * @return
     */
    @Override
    public boolean checkAccess(HttpServletRequest request) {
        boolean right = false;
        SysAccount account = getSysAccountLogin(request);
        if (account != null) {
            String uri = HttpUtil.getURI(request);
//            int moduleId = moduleService.findModuleID(uri, request.getContextPath());
            // Lay ra modul dang truy xuat
//            System.out.println("checkAccess uri:" + uri);
        } else {
            System.out.println("Account in checkAccess is null");
            return right;
        }
//        System.out.println("account.isDebug():"+account.isDebug());
        return right || account.isDebug();
    }

    public boolean accessModule(String modulePath, HttpServletRequest request) {
        boolean right = false;
        SysAccount account = getSysAccountLogin(request);
        if (account != null) {
            modulePath = Tool.removeEndCharactor(modulePath, "/"); 
        } else {
            return right;
        }
        return right || account.isDebug();
    }

    @Override
    public ArrayList<SysAccount> findAllSysAccountActive(String key) {
        return accDao.findAllSysAccountActive(key);
    }

    // ADDITION Method
    /**
     *
     * @param rolePath
     * @param uri
     * @param contextPath
     * @return
     */
    private boolean checkURL(String rolePath, String uri, String contextPath) {
        boolean right = Boolean.FALSE;
        try {
            if (!Tool.checkNull(rolePath) && !Tool.checkNull(uri)) {
                rolePath = Tool.removeEndCharactor(rolePath, "/");
                uri = Tool.removeEndCharactor(uri, "/");
                String[] arrPath = rolePath.split("[;,]");
                if (arrPath != null) {
                    for (String onePath : arrPath) {
//                        System.out.println("==>onePath:"+onePath+" | => "+contextPath + onePath);
                        if (onePath.equals(uri) || uri.equals(contextPath + onePath)) {
                            right = true;
                            break;
                        }
                    }
                }
            } else {
                logger.error("==> !Tool.checkNull(rolePath):" + !Tool.checkNull(rolePath) + " | !Tool.checkNull(uri):" + !Tool.checkNull(uri));
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        }

        return right;
    }

}
