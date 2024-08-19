require_relative "test_helper"

class PipelineTest < Minitest::Test
  def test_ner
    ner = Transformers.pipeline("ner")
    result = ner.("Ruby is a programming language created by Matz")
    assert_equal 3, result.size
    assert_equal "I-MISC", result[0][:entity]
    assert_in_delta 0.96, result[0][:score]
    assert_equal 1, result[0][:index]
    assert_equal "Ruby", result[0][:word]
    assert_equal 0, result[0][:start]
    assert_equal 4, result[0][:end]
  end

  def test_sentiment_analysis
    classifier = Transformers.pipeline("sentiment-analysis")
    result = classifier.("We are very happy to show you the 🤗 Transformers library.")
    assert_equal "POSITIVE", result[:label]
    assert_in_delta 0.9998, result[:score]

    result = classifier.(["We are very happy to show you the 🤗 Transformers library.", "We hope you don't hate it."])
    assert_equal "POSITIVE", result[0][:label]
    assert_in_delta 0.9998, result[0][:score]
    assert_equal "NEGATIVE", result[1][:label]
    assert_in_delta 0.5309, result[1][:score]
  end

  def test_question_answering
    qa = Transformers.pipeline("question-answering")
    result = qa.(question: "Who invented Ruby?", context: "Ruby is a programming language created by Matz")
    assert_in_delta 0.998, result[:score]
    assert_equal 42, result[:start]
    assert_equal 46, result[:end]
    assert_equal "Matz", result[:answer]

    result = qa.("Who invented Ruby?", "Ruby is a programming language created by Matz")
    assert_equal "Matz", result[:answer]
  end

  def test_feature_extraction
    fe = Transformers.pipeline("feature-extraction")
    result = fe.("We are very happy to show you the 🤗 Transformers library.")
    assert_in_delta 0.454, result[0][0][0]
  end

  def test_image_classification
    classifier = Transformers.pipeline("image-classification")
    result = classifier.("test/support/pipeline-cat-chonk.jpeg")
    assert_equal "lynx, catamount", result[0][:label]
    assert_in_delta 0.433, result[0][:score], 0.01
    assert_equal "cougar, puma, catamount, mountain lion, painter, panther, Felis concolor", result[1][:label]
    assert_in_delta 0.035, result[1][:score], 0.01
  end

  def test_image_feature_extraction
    fe = Transformers.pipeline("image-feature-extraction")
    result = fe.("test/support/pipeline-cat-chonk.jpeg")
    assert_in_delta 0.868, result[0][0][0], 0.01
  end
end
