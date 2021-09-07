public inherited sharing class ApiRequest {
    
    @TestVisible
    private Blob body;
    @TestVisible
    private ApiMethod method;
    @TestVisible
    private Integer urlPartsCount;

    @TestVisible
    private List<String> urlParts {
        get {
            if (this.urlParts == null) {
                this.urlParts = new List<String>();
            }
            return this.urlParts;
        }
        set;
    }

    @TestVisible
    private Map<String, String> queryparams {
        get {
            if (this.queryParams == null) {
                this.queryParams = new Map<String, String>();
            }
            return this.queryParams;
        }
        set;
    }
    @TestVisible
    private Map<String, String> headers {
        get {
            if (this.headers == null) {
                this.headers = new Map<String, String>();
            }
            return this.headers;
        }
        set;
    }
    public ApiRequest(RestRequest req, ApiMethod method) {
        this.urlParts = req.requestURI.split('/');
        this.urlPartsCount = this.urlParts.size();
        this.method = method;
        this.headers = req.headers;
        this.body = req.requestBody;
        this.queryparams = req.params;
    }

    public String getQueryParam(String key) {
        return this.queryparams.get(key);
    }

    public String getUrlParam(String key) {
        for (Integer i = 0; i < this.urlPartsCount; i++) {
            if (this.urlParts[i] == key && (i + 1) < this.urlPartsCount) {
                return this.urlParts.get(i + 1);
            }
        }
        return null;
    }

    public String getHeader(String key) {
        return this.headers.get(key);
    }

    public IApiContract processBody(IApiContract contract) {
        if (contract == null) {
            return new UnstructuredJson(this.body);
        } else {
            return (IApiContract)JSON.deserialize(this.body.toString(), contract.class);
        }
    }
}
