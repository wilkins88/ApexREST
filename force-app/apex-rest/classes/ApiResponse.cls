/**
 * @author Thomas Wilkins
 * @description basic Api response class. Might not be flexible enough for enterprise integrations
 * but it is a good starting point for simple ones
 */ 
public inherited sharing class ApiResponse implements IApiResponse {
    @TestVisible
    private Object responseObject;
    @TestVisible
    private Integer statusCode;

    public ApiResponse(Integer statusCode, Object responseObject) {
        this.statusCode = statusCode;
        this.responseObject = responseObject;
    }

    public RestResponse toResponse() {
        RestResponse response = new RestResponse();
        response.statusCode = this.statusCode;
        response.responseBody = Blob.valueOf(JSON.serialize(this.responseObject));
        return response;
    }
}
