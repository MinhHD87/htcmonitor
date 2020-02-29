/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.htcjsc.brandname.voice.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import vn.htcjsc.brandname.voice.commons.Tool;
import vn.htcjsc.brandname.voice.db.DBPool;
import vn.htcjsc.brandname.voice.model.SystemInfo;

/**
 *
 * @author hoan
 */
@Repository("systemInfoDao")
public class SystemInfoDaoImpl implements SystemInfoDaoIF{
    
    static final Logger logger = Logger.getLogger(SystemInfoDaoImpl.class);

    @Override
    public ArrayList<SystemInfo> getInfo() {
        ArrayList<SystemInfo> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM system_info ORDER BY ID DESC";
        try {
            conn = DBPool.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                SystemInfo one = new SystemInfo();
                one.setId(rs.getInt("ID"));
                one.setAccount(rs.getString("ACCOUNT"));
                one.setAgencyCode(rs.getString("AGENCY_CODE"));
                one.setCpu(rs.getString("CPU"));
                one.setCurrentCall(rs.getInt("CURRENT_CALL"));
                one.setMaxCall(rs.getInt("MAX_CALL"));
                one.setBalance(rs.getInt("BALANCE"));
                one.setQueueCall(rs.getInt("QUEUECALL"));
                
                list.add(one);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, ps, conn);
        }
        return list;

    }
}
