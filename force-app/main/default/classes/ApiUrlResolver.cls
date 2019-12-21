
/**
 * @author Thomas Wilkins
 * @description Class for resolving a URL based on endpoint configurations
 */ 
public with sharing class ApiUrlResolver {
    // custom metadata should be "mocked" for tests by directly setting this variable
    @TestVisible
    private List<ApiEndpointVersion__mdt> endpoints {
        get {
            if (this.endpoints == null) {
                // query the related list, because at the time of writing,
                // there is a bug where cross-object filters on custom metadata picklists does not work
                // see https://salesforce.stackexchange.com/questions/221868/unable-to-query-with-cross-object-pick-list-field-filter-on-custom-metadata-soql
                List<ApiEndpoint__mdt> apiEndpoints = [
                    SELECT Id,
                    (
                        SELECT 
                            EndpointVersion__c, ClassName__c,
                            ApiEndpoint__r.ApiName__c, 
                            ApiEndpoint__r.EndpointRegex__c 
                        FROM ApiEndpointVersions__r
                        WHERE EndpointVersion__c = :this.endpointVersion
                        AND IsActive__c = true
                    )
                    FROM ApiEndpoint__mdt
                    WHERE ApiName__c = :this.apiName
                ];
                this.endpoints = new List<ApiEndpointVersion__mdt>();
                // this should handle if you have multiple configs for different web services 
                for (ApiEndpoint__mdt apiEndpoint : apiEndpoints) {
                    this.endpoints.addAll(apiEndpoint.ApiEndpointVersions__r);
                }
            }
            return this.endpoints;
        } set;
    }

    @TestVisible
    private String apiName, endpointVersion;

    /**
     * Constructor
     * @param  apiName         The name of the api e.g. /services/apexrest/<apiName>/<endpointVersion>/<endpoint>
     * @param  endpointVersion The version of the endpoint e.g. /services/apexrest/<apiName>/<endpointVersion>/<endpoint>
     * @return                 this
     */ 
    public ApiUrlResolver(String apiName, String endpointVersion) {
        this.apiName = apiName;
        this.endpointVersion = endpointVersion;
    }

    /**
     * Attempts to match the current rest URL against configured endpoints
     * @param  url             a rest url to test for matches
     * @return                 The handler configured for the requested endpoint
     * @throws                 ApiExceptions.NotFoundException
     */ 
    public IApiRequestHandler resolve(String url) {
        for (ApiEndpointVersion__mdt endpoint : this.endpoints) {
            String fullRegex = '/' + 
                endpoint.ApiEndpoint__r.ApiName__c + '/' + 
                endpoint.EndpointVersion__c + '/' + 
                endpoint.ApiEndpoint__r.EndpointRegex__c;
            if (Pattern.matches(fullRegex, url)) {
                return (IApiRequestHandler)Type.forName(endpoint.ClassName__c).newInstance();
            } 
        }
        throw new ApiExceptions.NotFoundException('Endpoint: ' + url + ' not found.');
    }
}