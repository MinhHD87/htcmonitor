/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.htcjsc.brandname.voice.dao;

import java.util.ArrayList;
import vn.htcjsc.brandname.voice.model.SystemInfo;

/**
 *
 * @author hoan
 */
public interface SystemInfoDaoIF{
    public ArrayList<SystemInfo> getInfo();
    
}
