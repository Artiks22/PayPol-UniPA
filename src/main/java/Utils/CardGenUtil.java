package Utils;
import com.mifmif.common.regex.Generex;

public class CardGenUtil {
    public CardGenUtil() {
    }



    public static String generazioneNumeroCarta() {
        String numeroCarta;
        Generex generex = new Generex("(5[1-5][0-9]{14}|2(22[1-9][0-9]{12}|2[3-9][0-9]{13}|[3-6][0-9]{14}|7[0-1][0-9]{13}|720[0-9]{12}))");
        numeroCarta = generex.random();

        return numeroCarta;
        
    }

    public static String generazioneCvv() {
        String numeroCvv;
        Generex generex = new Generex("[0-9]{3}");
        numeroCvv = generex.random();
        return numeroCvv;
    }


}
