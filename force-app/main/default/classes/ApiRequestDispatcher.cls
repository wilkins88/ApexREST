public class ApiRequestDispatcher {
    public static void dispatch(ApiMethod method, String apiName, String endpointVersion) {
        Savepoint sp;
        try {
            ApiUrlResolver resolver = new ApiUrlResolver(apiName, endpointVersion);
            ApiRequestHandler handler = resolver.resolve(RestContext.request.requestURI);
            if (handler.shouldRollBackOnError()) sp = Database.setSavepoint();
            IApiResponse response;
            switch on method {
                when GET {
                    response = handler.doGET();
                } when POST {
                    response = handler.doPOST();
                } when PUT {
                    response = handler.doPUT();
                } when PATCH {
                    response = handler.doPATCH();
                } when DEL {
                    response = handler.doDELETE();
                }
            }
        } catch (ApiExceptions.ApiException e) {
            if (sp != null) Database.rollback(sp);
            // todo handle the error meessage
        }
    }
}
