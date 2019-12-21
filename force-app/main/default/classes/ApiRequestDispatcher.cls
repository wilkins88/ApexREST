public class ApiRequestDispatcher {
    public static void dispatch(ApiMethod method, String apiName, String endpointVersion) {
        try {
            ApiUrlResolver resolver = new ApiUrlResolver(apiName, endpointVersion);
            ApiRequestHandler handler = resolver.resolve(RestContext.request.requestURI);
            switch on method {
                when GET {
                    
                } when POST {

                } when PUT {

                } when PATCH {

                } when DEL {

                }
            }
        } catch (ApiExceptions.ApiException e) {
            // todo handle the error meessage
        }
    }
}
