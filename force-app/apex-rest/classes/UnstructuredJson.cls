public inherited sharing class UnstructuredJson implements IApiContract{
    @TestVisible
    private Map<String, Object> payload {
        get {
            if (this.payload == null) {
                this.payload = new Map<String, Object>();
            }
            return this.payload;
        }
        set;
    }

    public UnstructuredJson(Blob requestBody) {
        this.payload = JSON.deserializeUntyped(requestBody.toString());
    }

    public Map<String, Object> getPayload() {
        return this.payload;
    }
}
