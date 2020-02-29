/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.htcjsc.brandname.voice.services;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.htcjsc.brandname.voice.model.SystemInfo;
import vn.htcjsc.brandname.voice.dao.SystemInfoDaoIF;

/**
 *
 * @author hoan
 */
@Service("systemInfoSV")
public class SystemInfoServiceImpl implements SystemInfoService{
    
    @Autowired
    SystemInfoDaoIF systemInfoDao;

    @Override
    public ArrayList<SystemInfo> getInfo() {
        return systemInfoDao.getInfo();
    }

   

}
