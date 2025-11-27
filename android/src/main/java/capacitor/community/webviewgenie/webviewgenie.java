package capacitor.community.webviewgenie;

import com.getcapacitor.Logger;

public class webviewgenie {

    public String echo(String value) {
        Logger.info("Echo", value);
        return value;
    }
}
