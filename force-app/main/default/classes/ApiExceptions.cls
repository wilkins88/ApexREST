/**
 * @author Thomas Wilkins
 * @description class that houses various API errors
 */ 
public class ApiExceptions {

    /**
     * Base class since we can't use an interface to impose both the Exception
     * and getStatusCode contracts
     */ 
    private abstract class ApiException extends Exception {
        /**
         * Returns the status code attached to the error
         * @return   Status code e.g. 404
         */ 
        public abstract Integer getStatusCode();
    }

    public class BadArguementException extends ApiException {
        public override Integer getStatusCode() {
            return 400;
        }
    }

    public class UnauthorizedException extends ApiException {
        public override Integer getStatusCode() {
            return 401;
        }
    }

    public class ForbiddenException extends ApiException {
        public override Integer getStatusCode() {
            return 403;
        }
    }
    
    public class NotFoundException extends ApiException {
        public override Integer getStatusCode() {
            return 404;
        }
    }

    public class MethodNotAllowedException extends ApiException {
        public override Integer getStatusCode() {
            return 405;
        }
    }

    public class NotAcceptableException extends ApiException {
        public override Integer getStatusCode() {
            return 406;
        }
    }

    public class InternalServerErrorException extends ApiException {
        public override Integer getStatusCode() {
            return 500;
        }
    }

    public class MethodNotSupportedException extends ApiException {
        public override Integer getStatusCode() {
            return 501;
        }
    }

    // hit the common ones, the rest can be implemented as necessary
}
