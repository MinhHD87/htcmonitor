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
import vn.htcjsc.brandname.voice.commons.Md5;
import vn.htcjsc.brandname.voice.commons.Tool;
import vn.htcjsc.brandname.voice.config.MyConfig;
import vn.htcjsc.brandname.voice.db.DBPool;
import vn.htcjsc.brandname.voice.model.SysAccount;

/**
 *
 * @author Private
 */
@Repository("accDao")
public class SysAccountDaoImpl implements SysAccountDaoIF {

    static Logger logger = Logger.getLogger(SysAccountDaoImpl.class);

    @Override
    public ArrayList<SysAccount> view(int page, int maxRow, String key, String phone, String email, int status, boolean isDel) {
        ArrayList<SysAccount> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM SYS_ACCOUNT A WHERE ISDEL = ? ";
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ?)";
        }
        if (!Tool.checkNull(phone)) {
            sql += " AND PHONE = ? ";
        }
        if (!Tool.checkNull(email)) {
            sql += " AND EMAIL = ? ";
        }
        if (status != MyConfig.STATUS.ALL.val) {
            sql += " AND STATUS = ? ";
        }
        sql += " ORDER BY A.ACC_ID DESC LIMIT ?,?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setBoolean(i++, isDel);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
            }
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, phone);
            }
            if (!Tool.checkNull(email)) {
                pstm.setString(i++, email);
            }
            if (status != MyConfig.STATUS.ALL.val) {
                pstm.setInt(i++, status);
            }
            pstm.setInt(i++, (page - 1) * maxRow);
            pstm.setInt(i++, maxRow);
            rs = pstm.executeQuery();
            while (rs.next()) {
                SysAccount acc = new SysAccount();
                acc.setAccId(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUsername(rs.getString("USERNAME"));
                acc.setPassword(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setDel(rs.getBoolean("ISDEL"));
                result.add(acc);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    @Override
    public int count(String key, String phone, String email, int status, boolean isdel) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM SYS_ACCOUNT A WHERE ISDEL = ? ";
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ?)";
        }
        if (!Tool.checkNull(phone)) {
            sql += " AND PHONE = ? ";
        }
        if (!Tool.checkNull(email)) {
            sql += " AND EMAIL = ? ";
        }
        if (status != MyConfig.STATUS.ALL.val) {
            sql += " AND STATUS = ? ";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setBoolean(i++, isdel);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
            }
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, phone);
            }
            if (!Tool.checkNull(email)) {
                pstm.setString(i++, email);
            }
            if (status != MyConfig.STATUS.ALL.val) {
                pstm.setInt(i++, status);
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    @Override
    public ArrayList<SysAccount> findAllSysAccountActive(String key) {
        ArrayList<SysAccount> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM SYS_ACCOUNT WHERE STATUS = ? AND ISDEL != ?";
        if (!Tool.checkNull(key)) {
            sql += " AND( USERNAME like ? or FULL_NAME like ?) ";
        }
        sql += " ORDER BY ACC_ID DESC,STATUS DESC";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, MyConfig.STATUS.ACTIVE.val);
            pstm.setBoolean(i++, MyConfig.ISDEL);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                SysAccount acc = new SysAccount();
                acc.setAccId(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUsername(rs.getString("USERNAME"));
                acc.setPassword(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setDel(rs.getBoolean("ISDEL"));
                result.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    @Override
    public SysAccount findById(int accID) {
        SysAccount acc = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM SYS_ACCOUNT  WHERE ACC_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, accID);
            rs = pstm.executeQuery();
            if (rs.next()) {
                acc = new SysAccount();
                acc.setAccId(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUsername(rs.getString("USERNAME"));
                acc.setPassword(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setDel(rs.getBoolean("ISDEL"));
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return acc;
    }

    @Override
    public SysAccount checkLoginDB(String userName, String password) {
        SysAccount result = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM SYS_ACCOUNT  WHERE upper(USERNAME) = upper(?) AND PASSWORD = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, userName);
            pstm.setString(2, Md5.encryptMD5(password));
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = new SysAccount();
                result.setAccId(rs.getInt("ACC_ID"));
                result.setParentId(rs.getInt("PARENT_ID"));
                result.setUsername(rs.getString("USERNAME"));
                result.setFullName(rs.getString("FULL_NAME"));
                result.setAddress(rs.getString("ADDRESS"));
                result.setPhone(rs.getString("PHONE"));
                result.setEmail(rs.getString("EMAIL"));
                result.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                result.setCreateBy(rs.getString("CREATE_BY"));
                result.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                result.setUpdateBy(rs.getString("UPDATE_BY"));
                result.setStatus(rs.getInt("STATUS"));
                result.setDel(rs.getBoolean("ISDEL"));
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    @Override
    public int create(SysAccount oneAcc) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO SYS_ACCOUNT(PARENT_ID,USERNAME,PASSWORD,FULL_NAME,ADDRESS,PHONE,EMAIL,CREATE_DATE,CREATE_BY,STATUS) "
                + "                    VALUES(    ?    ,    ?   ,    ?   ,     ?   ,  ?    ,  ?  ,   ? ,   NOW()   ,    ?    ,   ?  )";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            int i = 1;
            pstm.setInt(i++, oneAcc.getParentId());
            pstm.setString(i++, oneAcc.getUsername());
            pstm.setString(i++, Md5.encryptMD5(oneAcc.getPassword()));
            pstm.setString(i++, oneAcc.getFullName());
            pstm.setString(i++, oneAcc.getAddress());
            pstm.setString(i++, oneAcc.getPhone());
            pstm.setString(i++, oneAcc.getEmail());
            pstm.setString(i++, oneAcc.getCreateBy());
            pstm.setInt(i++, oneAcc.getStatus());
            if (pstm.executeUpdate() == 1) {
                try (ResultSet generatedKeys = pstm.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        result = generatedKeys.getInt(1);
                    } else {
                        throw new SQLException("Creating SysAccount failed, no ID obtained.");
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    @Override
    public SysAccount update(SysAccount edit) {
        SysAccount result = findById(edit.getAccId());
        if (result != null) {
            Connection conn = null;
            PreparedStatement pstm = null;
            String sql = "UPDATE SYS_ACCOUNT SET PARENT_ID = ?, USERNAME = ?,";
            if (!Tool.checkNull(edit.getPassword())) {
                sql += "PASSWORD = ?,";
            }
            sql += "FULL_NAME = ?,ADDRESS = ?,PHONE = ?,EMAIL = ?"
                    + ",UPDATE_DATE = NOW(),UPDATE_BY = ?,STATUS=? "
                    + " where ACC_ID = ?";
            try {
                conn = DBPool.getConnection();
                conn.setAutoCommit(false);
                pstm = conn.prepareStatement(sql);
                int i = 1;
                pstm.setInt(i++, edit.getParentId());
                pstm.setString(i++, edit.getUsername());
                if (!Tool.checkNull(edit.getPassword())) {
                    pstm.setString(i++, Md5.encryptMD5(edit.getPassword()));
                }
                pstm.setString(i++, edit.getFullName());
                pstm.setString(i++, edit.getAddress());
                pstm.setString(i++, edit.getPhone());
                pstm.setString(i++, edit.getEmail());
                pstm.setString(i++, edit.getUpdateBy());
                pstm.setInt(i++, edit.getStatus());
                pstm.setInt(i++, edit.getAccId());
                if (pstm.executeUpdate() == 1) {
                    conn.commit();
                    return result;
                } else {
                    conn.rollback();
                    result = null;
                }
            } catch (SQLException ex) {
                DBPool.rollback(conn, result);
                logger.error(Tool.getLogMessage(ex));
            } finally {
                DBPool.freeConn(null, pstm, conn);
            }
        }
        return result;
    }

    @Override
    public SysAccount deleteForEver(int accId) {
        SysAccount result = findById(accId);
        if (result != null) {
            Connection conn = null;
            PreparedStatement pstm = null;
            String sql = "DELETE FROM SYS_ACCOUNT WHERE ACC_ID = ?";
            try {
                conn = DBPool.getConnection();
                conn.setAutoCommit(false);
                pstm = conn.prepareStatement(sql);
                pstm.setInt(1, accId);
                if (pstm.executeUpdate() == 1) {
                    System.out.println("Xoa xong tài khoản");
                    pstm = conn.prepareStatement("DELETE FROM USER_PRIVILEGES WHERE ACC_ID = ?");
                    pstm.setInt(1, accId);
                    if (pstm.executeUpdate() >= 0) {
                        System.out.println("Xoa xong quyen cua tài khoản");
                        conn.commit();
                    } else {
                        System.out.println("Khong xoa duoc Quyen cua tài khoản");
                        conn.rollback();
                        result = null;
                    }
                } else {
                    System.out.println("Khong xóa duoc tai khoan");
                    conn.rollback();
                    result = null;
                }
            } catch (SQLException ex) {
                DBPool.rollback(conn, result);
                logger.error(Tool.getLogMessage(ex));
            } finally {
                DBPool.freeConn(null, pstm, conn);
            }
        }
        return result;
    }

    @Override
    public SysAccount delete(int accID) {
        SysAccount result = findById(accID);
        if (result != null) {

            Connection conn = null;
            PreparedStatement pstm = null;
            String sql = "UPDATE  SYS_ACCOUNT SET ISDEL = ? WHERE ACC_ID = ?";
            try {
                conn = DBPool.getConnection();
                conn.setAutoCommit(false);
                pstm = conn.prepareStatement(sql);
                pstm.setBoolean(1, Boolean.TRUE);
                pstm.setInt(2, accID);
                if (pstm.executeUpdate() == 1) {
                    conn.commit();
                } else {
                    DBPool.rollback(conn, result);
                }
            } catch (SQLException ex) {
                DBPool.rollback(conn, result);
                logger.error(Tool.getLogMessage(ex));
            } finally {
                DBPool.freeConn(null, pstm, conn);
            }

        }
        return result;
    }

    @Override
    public SysAccount undoDelete(int accID) {
        SysAccount result = findById(accID);
        if (result != null) {
            Connection conn = null;
            PreparedStatement pstm = null;
            String sql = "UPDATE  SYS_ACCOUNT SET ISDEL = ? WHERE ACC_ID = ?";
            try {
                conn = DBPool.getConnection();
                conn.setAutoCommit(false);
                pstm = conn.prepareStatement(sql);
                pstm.setBoolean(1, Boolean.FALSE);
                pstm.setInt(2, accID);
                if (pstm.executeUpdate() == 1) {
                    conn.commit();
                } else {
                    DBPool.rollback(conn, result);
                }
            } catch (SQLException ex) {
                DBPool.rollback(conn, result);
                logger.error(Tool.getLogMessage(ex));
            } finally {
                DBPool.freeConn(null, pstm, conn);
            }
        }
        return result;
    }

    @Override
    public ArrayList<SysAccount> findSysAccountOnRole(int page, int maxrow, String key) {
        ArrayList<SysAccount> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT s.ACC_ID,s.USERNAME,s.FULL_NAME,s.PHONE,s.EMAIL,s.STATUS,r.ROLE_ID FROM sys_account s LEFT JOIN ROLE_ACC_DETAIL r "
                + "ON s.ACC_ID = r.ACC_ID WHERE s.STATUS = ? AND s.ISDEL != ?";
        if (!Tool.checkNull(key)) {
            sql += " WHERE (USERNAME = ? OR FULL_NAME like ? )";
        }
        sql += " ORDER BY ACC_ID DESC LIMIT ?,?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, MyConfig.STATUS.ACTIVE.val);
            pstm.setBoolean(i++, MyConfig.ISDEL);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
            }
            pstm.setInt(i++, (page - 1) * maxrow);
            pstm.setInt(i++, maxrow);
            rs = pstm.executeQuery();
            while (rs.next()) {
                SysAccount acc = new SysAccount();
                acc.setAccId(rs.getInt("ACC_ID"));
                acc.setUsername(rs.getString("USERNAME"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setRoleId(rs.getInt("ROLE_ID"));
                result.add(acc);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    @Override
    public int countSysAccountOnRole(String key) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT s.ACC_ID,s.USERNAME,s.FULL_NAME,s.PHONE,s.EMAIL ,r.ROLE_ID FROM sys_account s LEFT JOIN ROLE_ACC_DETAIL r ON s.ACC_ID = r.ACC_ID";
        if (!Tool.checkNull(key)) {
            sql += " WHERE STATUS = ? AND ISDEL != ? AND (USERNAME = ? OR FULL_NAME like ? )";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, MyConfig.STATUS.ACTIVE.val);
            pstm.setBoolean(i++, MyConfig.ISDEL);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

}
