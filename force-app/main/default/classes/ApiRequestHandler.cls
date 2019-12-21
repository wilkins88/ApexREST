/**
 * @author Thomas Wilkins
 * @description Base class for all API handlers to implement for use in the dispatcher
 */ 
public abstract class ApiRequestHandler {

    @TestVisible
    private static final String OPERATION_NOT_SUPPORTED = 'Operation {0} is not supported by this endpoint.';

    /**
     * @description whether or not the operation should be transactional and rollback on error
     * this option exists because in some cases, you might not want to create a savepoint (such as read only)
     * annd in other cases, you might want to rollback on an error (such as if working with FSL)
     * @return   return description
     */ 
    public abstract Boolean shouldRollBackOnError();

    /**
    * @description method handler for GET requests. Should be overriden if a webservices which uses
	* this handler has a HttpGet method
    */ 
    public virtual IApiResponse doGET() {
        throw new ApiExceptions.MethodNotAllowedException(String.format(
			OPERATION_NOT_SUPPORTED,
			new List<String> { 'GET' }
		));
    }

	/**
    * @description method handler for POST requests. Should be overriden if a webservices which uses
	* this handler has a HttpPost method
    */ 
    public virtual IApiResponse doPOST() {
        throw new ApiExceptions.MethodNotAllowedException(String.format(
			OPERATION_NOT_SUPPORTED,
			new List<String> { 'POST' }
		));
    }

	/**
    * @description method handler for PUT requests. Should be overriden if a webservices which uses
	* this handler has a HttpPut method
    */ 
    public virtual IApiResponse doPUT() {
        throw new ApiExceptions.MethodNotAllowedException(String.format(
			OPERATION_NOT_SUPPORTED,
			new List<String> { 'PUT' }
		));
    }

	/**
    * @description method handler for DELETE requests. Should be overriden if a webservices which uses
	* this handler has a HttpDelete method
    */ 
    public virtual IApiResponse doDELETE() {
        throw new ApiExceptions.MethodNotAllowedException(String.format(
			OPERATION_NOT_SUPPORTED,
			new List<String> { 'DELETE' }
		));
    }

	/**
    * @description method handler for PATCH requests. Should be overriden if a webservices which uses
	* this handler has a HttpPatch method
    */ 
    public virtual IApiResponse doPATCH() {
        throw new ApiExceptions.MethodNotAllowedException(String.format(
			OPERATION_NOT_SUPPORTED,
			new List<String> { 'PATCH' }
		));
    }
}
