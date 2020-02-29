/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.htcjsc.brandname.voice.model;

/**
 *
 * @author hoan
 */
public class SystemInfo {
    private int id;
    private String account;
    private String agencyCode;
    private String cpu;
    private int currentCall;
    private int maxCall;
    private int balance;
    private int queueCall;

    public SystemInfo() {
    }

    public SystemInfo(int id, String account, String agencyCode, String cpu, int currentCall, int maxCall, int balance, int queueCall) {
        this.id = id;
        this.account = account;
        this.agencyCode = agencyCode;
        this.cpu = cpu;
        this.currentCall = currentCall;
        this.maxCall = maxCall;
        this.balance = balance;
        this.queueCall = queueCall;
    }

    @Override
    public String toString() {
        return "SystemInfo{" + "id=" + id + ", account=" + account + ", agencyCode=" + agencyCode + ", cpu=" + cpu + ", currentCall=" + currentCall + ", maxCall=" + maxCall + ", balance=" + balance + ", queueCall=" + queueCall + '}';
    }

    
    
    public int getId() {
        return id;
    }

    public String getAccount() {
        return account;
    }

    public String getAgencyCode() {
        return agencyCode;
    }

    public String getCpu() {
        return cpu;
    }

    public int getCurrentCall() {
        return currentCall;
    }

    public int getMaxCall() {
        return maxCall;
    }

    public int getBalance() {
        return balance;
    }

    public int getQueueCall() {
        return queueCall;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public void setAgencyCode(String agencyCode) {
        this.agencyCode = agencyCode;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public void setCurrentCall(int currentCall) {
        this.currentCall = currentCall;
    }

    public void setMaxCall(int maxCall) {
        this.maxCall = maxCall;
    }

    public void setBalance(int balance) {
        this.balance = balance;
    }

    public void setQueueCall(int queueCall) {
        this.queueCall = queueCall;
    }
    
    
    
}
