trigger AccountTrigger on Account (before insert) {
    Set<String> ids = new Set<String>{'0','1'};
    for(Account acc: (List<Account>) Trigger.new){
        System.enqueueJob(new AnimalCallout());
       
        System.enqueueJob(new AnimalCallout2(ids));
        System.enqueueJob(new AnimalCallout3(ids));
    }
}