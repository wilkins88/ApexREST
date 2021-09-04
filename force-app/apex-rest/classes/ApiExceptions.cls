/**
 * class that houses various API errors
 * Based on: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#client_error_responses
 */ 
public inherited sharing class ApiExceptions {

    /**
     * Base class since we can't use an interface to impose both the Exception
     * and getStatusCode contracts
     */ 
    public inherited sharing abstract class ApiException extends Exception {
        /**
         * Returns the status code attached to the error
         * @return   Status code e.g. 404
         */ 
        public abstract Integer getStatusCode();
    }

    public inherited sharing class BadArguementException extends ApiException {
        public override Integer getStatusCode() {
            return 400;
        }
    }

    public inherited sharing class UnauthorizedException extends ApiException {
        public override Integer getStatusCode() {
            return 401;
        }
    }

    public inherited sharing class ForbiddenException extends ApiException {
        public override Integer getStatusCode() {
            return 403;
        }
    }
    
    public inherited sharing class NotFoundException extends ApiException {
        public override Integer getStatusCode() {
            return 404;
        }
    }

    public inherited sharing class MethodNotAllowedException extends ApiException {
        public override Integer getStatusCode() {
            return 405;
        }
    }

    public inherited sharing class NotAcceptableException extends ApiException {
        public override Integer getStatusCode() {
            return 406;
        }
    }

    public inherited sharing class InternalServerErrorException extends ApiException {
        public override Integer getStatusCode() {
            return 500;
        }
    }

    public inherited sharing class MethodNotSupportedException extends ApiException {
        public override Integer getStatusCode() {
            return 501;
        }
    }

    public inherited sharing class BadGatewayException extends ApiException {
        public override Integer getStatusCode() {
            return 502;
        }
    }

    public inherited sharing class ServiceUnavailableException extends ApiException {
        public override Integer getStatusCode() {
            return 503;
        }
    }

    public inherited sharing class GatewayTimeoutException extends ApiException {
        public override Integer getStatusCode() {
            return 504;
        }
    }

    // add any other necessary exceptions here
}
