public with sharing class AnimalCallout extends Retryable {
    private Logger log = new Logger(AnimalCallout.class.getName());

    public AnimalCallout() {
        firstExecution = Datetime.now();
        retryScheduleInMinutes = new List<Integer>{
            5, 10, 30, 60
        };
    }

    public override JobResult startJob() {
        log.d('Started MockCallout');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        HttpResponse response = http.send(request);
        Integer httpResponseCode = response.getStatusCode();
        if(httpResponseCode == 200){            
            System.debug('response.getBody()=>' + response.getBody());
            // return JobResult.success(response.getBody());
            return JobResult.retry(response.getBody());
        }else {
            System.debug('response.getBody()=>' + response.getBody());
            return JobResult.retry(response.getBody());
        }
    }


    public class Animalwrapper{
        public String[] animals;        
    }


}