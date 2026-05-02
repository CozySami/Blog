+++
slug = "matryoshka-embedding"
title = "Understand Matryoshka Embedding"
date = "2024-11-20"
draft = false
tags = [
    "TIL", "LLM"
]
+++

### What is Matryoshka Embedding?
Matryoshka embedding are designed with a unique feature: even their smaller, truncated embeddings preserve a similar distance in the original feature space. This means users can easily choose a smaller dimension without sacrificing much retrieval accuracy.

{{< b2img "blog/matryoshka_model.png" "matryoshka_model" >}}

Credit: hugging face

### How Does It Work?
During the training of Matryoshka embeddings, we apply weights to the base distance metric across each dimension to derive the loss function:

- Equal weight for all dimensions: Each dimension receives the same weight, ensuring balanced loss contribution from each dimension. Remember that this is not necessary. If we want to optimize for some dimensions by sacrificing others, we can use non-equal weights.
- No limitation to base distance metric: The user can train with any distance metric, such as cosine loss, as the base.

### Why It Matters
In a multi stage retrieval application, we have need different considerations at different steps, in terms of latency and accuracy. Matryoshka Embedding is a powerful tool for cases when we need different dimensions of the same model in different retrieval step and train once.

### Key Insight
Matryoshka Embedding shares an analogy with techniques like PCA (unsupervised) and LDA (supervised). When training the model, the goal is to rotate and project the original space into a lower-dimensional space while maintaining meaningful distances.
The unique aspect is that we use additional freedom when we rotate all dimensions at the same time, to enforce that lower dimensions should always be expanded in the sequential order (e.g., from n = 64 to n = 1024).

## Reference
[Introduction to Matryoshka Embedding Models](https://huggingface.co/blog/matryoshka)