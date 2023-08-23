package Model;

import java.util.Date;

public class Carta {

    private String CardNum;
    private Date creationDate;
    private Date expireDate;
    private boolean flagBlocked;
    private int cvv;
    private float balance;
    private String ownerID;

    public Carta() {
    }

    public Carta(String cardNum, Date creationDate, Date expireDate, boolean flagBlocked, int cvv, float balance, String ownerID) {
        CardNum = cardNum;
        this.creationDate = creationDate;
        this.expireDate = expireDate;
        this.flagBlocked = flagBlocked;
        this.cvv = cvv;
        this.balance = balance;
        this.ownerID = ownerID;
    }

    public String getCardNum() {
        return CardNum;
    }

    public void setCardNum(String cardNum) {
        CardNum = cardNum;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    public boolean isFlagBlocked() {
        return flagBlocked;
    }

    public void setFlagBlocked(boolean flagBlocked) {
        this.flagBlocked = flagBlocked;
    }

    public int getCvv() {
        return cvv;
    }

    public void setCvv(int cvv) {
        this.cvv = cvv;
    }

    public float getBalance() {
        return balance;
    }

    public void setBalance(float balance) {
        this.balance = balance;
    }

    public String getOwnerID() {
        return ownerID;
    }

    public void setOwnerID(String ownerID) {
        this.ownerID = ownerID;
    }
}
