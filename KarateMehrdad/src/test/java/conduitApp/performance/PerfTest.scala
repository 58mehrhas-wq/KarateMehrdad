package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol() {
    "/api/articles/{articleId}" -> Nil
  }

  // protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
//   protocol.runner.karateEnv("perf")

  val createArticle = scenario("Create and Delete article").exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))


  setUp(
    createArticle.inject(
        atOnceUsers(1)
        ).protocols(protocol)
  )

}
