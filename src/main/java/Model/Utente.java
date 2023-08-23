package Model;

public class Utente {
    private int id;
    private String nome;
    private String cognome;
    private String email;
    private String password;
    private boolean negBlock;
    private int userType;


    public Utente() {

    }

    public Utente(int id, String nome, String cognome, String email, String password, boolean negBlock, int userType) {
        this.id = id;
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.password = password;
        this.negBlock = negBlock;
        this.userType = userType;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isNegBlock() {
        return negBlock;
    }

    public void setNegBlock(boolean negBlock) {
        this.negBlock = negBlock;
    }

    public int getUserType() {
        return userType;
    }

    public void setUserType(int userType) {
        this.userType = userType;
    }
}
