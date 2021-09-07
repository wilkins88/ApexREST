/**
 * Base class for all API handlers to implement for use in the dispatcher
 */ 
public inherited sharing abstract class ApiRequestHandler {

    @TestVisible
    private static final String OPERATION_NOT_SUPPORTED = 'Operation {0} is not supported by this endpoint.';

    @TestVisible
    protected Map<String, String> params {
        get {
            if (this.params == null) {
                this.params = new Map<String, String>();
            }
            return this.params;
        }
        set;
    }
    @TestVisible
    protected Map<String, String> headers {
        get {
            if (this.headers == null) {
                this.headers = new Map<String, String>();
            }
            return this.headers;
        }
        set;
    }

    @TestVisible
    protected IApiContract body;

    /**
     * Whether or not the operation should be transactional and rollback on error
     * this option exists because in some cases, you might not want to create a savepoint (such as read only)
     * annd in other cases, you might want to rollback on an error (such as if working with FSL)
     * @return  whether or not the transaction should roll back on error
     */ 
    public abstract Boolean shouldRollBackOnError();

    /**
     * Returns the Api Contract (model) that is used for the integration
     * This is used to get the class for automated desierialization
     */
    private abstract IApiContract getApiContract();

    /**
     * Returns the map of url param names to the validator used to validate the url param
     * @return Map of string url param names (as they appear in the url) to validators
     */
    protected abstract Map<String, IValidator> getUrlParams();

    /**
     * Returns the map of header keys to header validators
     * @return Map of string header keys to validators
     */
    protected virtual Map<String, IValidator> getHeaders() {
        return new Map<String, IValidator>();
    }

    /**
     * Returns the map of query param names to the validator used to validate the query param
     * @return Map of string query param names (as they appear in the url) to validators
     */
    protected virtual Map<String, IValidator> getQueryParams() {
        return new Map<String, IValidator>();
    }

    /**
    * method handler for GET requests. Should be overriden if a webservices which uses
	* this handler has a HttpGet method
    * @throws ApiExceptions.MethodNotAllowedException if method not overriden
    */ 
    public virtual IApiResponse doGET() {
        throw new ApiExceptions.MethodNotAllowedException(String.format(
			OPERATION_NOT_SUPPORTED,
			new List<String> { 'GET' }
		));
    }

	/**
    * method handler for POST requests. Should be overriden if a webservices which uses
	* this handler has a HttpPost method
    * @throws ApiExceptions.MethodNotAllowedException if method not overriden
    */ 
    public virtual IApiResponse doPOST() {
        throw new ApiExceptions.MethodNotAllowedException(String.format(
			OPERATION_NOT_SUPPORTED,
			new List<String> { 'POST' }
		));
    }

	/**
    * method handler for PUT requests. Should be overriden if a webservices which uses
	* this handler has a HttpPut method
    * @throws ApiExceptions.MethodNotAllowedException if method not overriden
    */ 
    public virtual IApiResponse doPUT() {
        throw new ApiExceptions.MethodNotAllowedException(String.format(
			OPERATION_NOT_SUPPORTED,
			new List<String> { 'PUT' }
		));
    }

	/**
    * method handler for DELETE requests. Should be overriden if a webservices which uses
	* this handler has a HttpDelete method
    * @throws ApiExceptions.MethodNotAllowedException if method not overriden
    */ 
    public virtual IApiResponse doDELETE() {
        throw new ApiExceptions.MethodNotAllowedException(String.format(
			OPERATION_NOT_SUPPORTED,
			new List<String> { 'DELETE' }
		));
    }

	/**
    * method handler for PATCH requests. Should be overriden if a webservices which uses
	* this handler has a HttpPatch method
    * @throws ApiExceptions.MethodNotAllowedException if method not overriden
    */ 
    public virtual IApiResponse doPATCH() {
        throw new ApiExceptions.MethodNotAllowedException(String.format(
			OPERATION_NOT_SUPPORTED,
			new List<String> { 'PATCH' }
		));
    }

    /**
     * Loads the api request and inits various pieces of request state within the handler
     * @param req the Api request wrapper
     */
    public void loadRequest(ApiRequest req) {
        for (String queryParam : this.getQueryParams().keySet()) {
            String param = req.getQueryParam(queryParam);
            this.getQueryParams.get(queryParam).validate(param);
            this.params.put(queryParam, param);
        }
        for (String urlparam : this.getUrlParams().keySet()) {
            String param = req.getUrlParam(urlparam);
            this.getUrlParams.get(urlparam).validate(param);
            this.params.put(urlparam, param);
        }
        for (String header : this.getHeaders().keySet()) {
            String headerValue = req.getHeader(header);
            this.getHeaders().get(header).validate(headerValue);
            this.headers.put(header, headerValue);
        }
        this.body = req.processBody(this.getApiContract());
    }
}
