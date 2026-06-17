import org.jenkinsci.plugins.cloudstats.CloudStatistics

def cloudStats = CloudStatistics.get()
cloudStats.active.clear()
cloudStats.log.clear()
cloudStats.save()