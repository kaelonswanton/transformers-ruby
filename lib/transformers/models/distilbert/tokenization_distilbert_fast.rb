# Copyright 2018 The HuggingFace Inc. team.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Transformers
  module Distilbert
    class DistilBertTokenizerFast < PreTrainedTokenizerFast
      VOCAB_FILES_NAMES = {vocab_file: "vocab.txt", tokenizer_file: "tokenizer.json"}

      self.vocab_files_names = VOCAB_FILES_NAMES
      self.model_input_names = ["input_ids", "attention_mask"]
      self.slow_tokenizer_class = DistilBertTokenizer

      def initialize(
        vocab_file: nil,
        tokenizer_file: nil,
        do_lower_case: true,
        unk_token: "[UNK]",
        sep_token: "[SEP]",
        pad_token: "[PAD]",
        cls_token: "[CLS]",
        mask_token: "[MASK]",
        tokenize_chinese_chars: true,
        strip_accents: nil,
        **kwargs
      )
        super(
          vocab_file,
          tokenizer_file: tokenizer_file,
          do_lower_case: do_lower_case,
          unk_token: unk_token,
          sep_token: sep_token,
          pad_token: pad_token,
          cls_token: cls_token,
          mask_token: mask_token,
          tokenize_chinese_chars: tokenize_chinese_chars,
          strip_accents: strip_accents,
          **kwargs
        )

        if @backend_tokenizer
          raise Todo
        end

        @do_lower_case = do_lower_case
      end

      def build_inputs_with_special_tokens(token_ids_0, token_ids_1 = nil)
        raise Todo
      end

      def create_token_type_ids_from_sequences(token_ids_0, token_ids_1 = nil)
        raise Todo
      end

      def save_vocabulary(save_directory, filename_prefix: nil)
        raise Todo
      end
    end
  end
end
