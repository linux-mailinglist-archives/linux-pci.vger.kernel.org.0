Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254FC6B1EE4
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 09:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjCIIwz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 03:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCIIwh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 03:52:37 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5806DF240
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 00:52:12 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so5324609pjb.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 00:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EYpDut5qXdF8PJg7sJ4kHxpp0TN8JiS9nsevzfwY0E=;
        b=x3F7JgMlovl1XU8nVdsqn4mHmNqXlJEYHWmoDdnGdy7axcb9V0kWlcut+/j7ms2vY3
         bdzQLe2YnarCw7FURfEMM3g8FA7CdN9aBD/LlS/VzBA5rCHqfah3JNXuN3wJb+AjIdVC
         qstSluYMGygbTqFib7W/MX/7SabK1G8d95h2T5H1KVzB602YhSlED3pZeenHYseiA7Jy
         0HB66BP2HT+y7AKnW8cZkVszSn+9FgTzFeMKZrk0HXGLtngE6/MGvko0qAnx4RqwYzRx
         mQHJ2x/w1xDgBhoRH77WtggGLIZso7kRRs/jcbv9fzAJBiLSqb3ADV/hYomBlMWSftjt
         eSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EYpDut5qXdF8PJg7sJ4kHxpp0TN8JiS9nsevzfwY0E=;
        b=7bp0lMmLePrHKBi2dY0iGjd3VGoFK2EOvB6AWMLpwjKc2/VuP4imCfbBq4zmpUDpcW
         1a+Qd+7bmm7aGTVi3rv85N/FjF8kvvm5cIH61LmiTFuN08OK5YqJNDD2w4ILhBYM+Ze1
         TZpTSBkySu24i/wuDVzKjgYxD4f/EtOR7v7a98Vx9voa1qZSyUK0O30Q7XzQQxpOngdW
         AWDEF0ogbnIGRvgYhpNk9iVoVeNt8Ty3TyXykf2VVOgCEudFu9pqWOqBsrPtFr1TZnch
         ojMEw3usRrD9L4v9UZJm6y4tfOO3MB6BiY9X77rImgjoZV8Q6wUAw+80we0t2SBN8CPl
         UzSA==
X-Gm-Message-State: AO0yUKVukRSvX7c3v0MXiJJzm/7+bPfCJhrIgz+jFGtYhTz6wIX9uWLS
        yyLmwzPhNGwLENPfJUdfll+C
X-Google-Smtp-Source: AK7set9VfPte/UHFCsEVGLAhICyvRPSNWw85/k9dEYb3tXq7cBVz1ZeoCAkQRcBPyn2ealkza5VhOw==
X-Received: by 2002:a05:6a20:9389:b0:cd:2952:7b69 with SMTP id x9-20020a056a20938900b000cd29527b69mr24464708pzh.52.1678351927414;
        Thu, 09 Mar 2023 00:52:07 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:52:07 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 13/17] dt-bindings: PCI: qcom: Add "mhi" register region to supported SoCs
Date:   Thu,  9 Mar 2023 14:20:58 +0530
Message-Id: <20230309085102.120977-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"mhi" register region contains the MHI registers that could be used by
the PCIe controller drivers to get debug information like PCIe link
transition counts on newer SoCs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index fb32c43dd12d..ecbb0f9efa21 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -44,11 +44,11 @@ properties:
 
   reg:
     minItems: 4
-    maxItems: 5
+    maxItems: 6
 
   reg-names:
     minItems: 4
-    maxItems: 5
+    maxItems: 6
 
   interrupts:
     minItems: 1
@@ -185,13 +185,15 @@ allOf:
       properties:
         reg:
           minItems: 4
-          maxItems: 4
+          maxItems: 5
         reg-names:
+          minItems: 4
           items:
             - const: parf # Qualcomm specific registers
             - const: dbi # DesignWare PCIe registers
             - const: elbi # External local bus interface registers
             - const: config # PCIe configuration space
+            - const: mhi # MHI registers
 
   - if:
       properties:
@@ -209,14 +211,16 @@ allOf:
       properties:
         reg:
           minItems: 5
-          maxItems: 5
+          maxItems: 6
         reg-names:
+          minItems: 5
           items:
             - const: parf # Qualcomm specific registers
             - const: dbi # DesignWare PCIe registers
             - const: elbi # External local bus interface registers
             - const: atu # ATU address space
             - const: config # PCIe configuration space
+            - const: mhi # MHI registers
 
   - if:
       properties:
-- 
2.25.1

