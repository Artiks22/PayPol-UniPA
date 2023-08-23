package Model;

import java.util.Date;

public class Movimenti {

    private String idMovimento;
    private Date dataMovimento;
    private float importo;
    private String cartaRicevente;

    public Movimenti() {
    }

    public Movimenti(String idMovimento, Date dataMovimento, float importo, String cartaRicevente) {
        this.idMovimento = idMovimento;
        this.dataMovimento = dataMovimento;
        this.importo = importo;
        this.cartaRicevente = cartaRicevente;
    }

    public String getIdMovimento() {
        return idMovimento;
    }

    public void setIdMovimento(String idMovimento) {
        this.idMovimento = idMovimento;
    }

    public Date getDataMovimento() {
        return dataMovimento;
    }

    public void setDataMovimento(Date dataMovimento) {
        this.dataMovimento = dataMovimento;
    }

    public float getImporto() {
        return importo;
    }

    public void setImporto(float importo) {
        this.importo = importo;
    }

    public String getCartaRicevente() {
        return cartaRicevente;
    }

    public void setCartaRicevente(String cartaRicevente) {
        this.cartaRicevente = cartaRicevente;
    }
}
