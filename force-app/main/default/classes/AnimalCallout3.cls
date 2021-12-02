public with sharing class AnimalCallout3 extends Retryable {
    private Logger log = new Logger(AnimalCallout3.class.getName());
    private Set<String> setIds {get;set;}

    public AnimalCallout3(Set<String> pSetIds) {
        firstExecution = Datetime.now();
        retryScheduleInMinutes = new List<Integer>{
            5, 10, 15, 20
        };

        this.setIds = pSetIds;
    }

    public override JobResult startJob() {
        log.d('Started MockCallout');

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(genJSbody(this.setIds));

        HttpResponse response = http.send(request);
        Integer httpResponseCode = response.getStatusCode();
        System.debug('httpResponseCode=>' + httpResponseCode);
        if(httpResponseCode == 200){

            System.debug('response.getBody()=>' + response.getBody());
            return JobResult.success(response.getBody());
        }else {
            System.debug('response.getBody()=>' + response.getBody());
            return JobResult.success(response.getBody());
        }
    }


    public class Animalwrapper{
        public String[] animals;        
    }

    public static String genJSbody(Set<String> ids){
        JSONGenerator gen = JSON.createGenerator(true);

        gen.writeStartObject();

        for(String id : ids){
            gen.writeObjectField('id', ids);
        }
        gen.writeEndObject();

        return gen.getAsString();
    }

    
}