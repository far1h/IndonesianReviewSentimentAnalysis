import Cocoa
import CreateML
import TabularData

let csv = Bundle.main.url(forResource: "PRDECT-ID Dataset", withExtension: "csv")!
let dataframe = try DataFrame(contentsOfCSVFile: csv)
print(dataframe)

let classifier = try MLTextClassifier(trainingData: dataframe, textColumn: "Customer Review", labelColumn: "Sentiment")

let metadata = MLModelMetadata(author: "Farih Muhammad",
                                 shortDescription: "A model to classify Indonesian customer reviews as positive or negative.",
                                 version: "1.0")

try classifier.write(to: URL(fileURLWithPath: "/Users/farihmuhammad/Downloads/ios_70_hour_bootcamp/IndonesianReviewSentimentAnalysis.mlmodel"), metadata: metadata)
