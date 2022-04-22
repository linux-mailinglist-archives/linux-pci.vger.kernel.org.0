Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC3B50B67E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447180AbiDVLvn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 07:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447175AbiDVLvn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 07:51:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54AC56419
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 04:48:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d6so13819861lfv.9
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9X2YF1TdcTzEa8yAtyFAH7jy6IlIlfrF2Il4DQ4XyO8=;
        b=fLhWYGhQ//CzUCpclOBRvCEO4WosJAkuPeAa9qv5wZfBP+I5Fs4K8is0R0bBssZUcv
         bNzBqHcLNtWYUNFNn+YDYFheHlKLrfRzgk3zA4TouAhx1XBUy1p9nKKx0kCMQ6qQh9bG
         nk/bFMWUur3VS4vaDsd+e5IRCgr1pHVPsX7vISjTRkXtfmzQpUvcaUV/iZYQXJXG1m40
         iiSMZH1hWLfdOuJbNxXom1NOtg+yoAYJ9gZ8ZyRJ4abktHvpzzSWlC2TQ0zZqchZ+PU6
         kkWuPtHwmiqpmTMR7fKqilqK0fcXLd6rAn2MY8qmeQiYAN0z7btHqRIerBYqMGJe1B8A
         KB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9X2YF1TdcTzEa8yAtyFAH7jy6IlIlfrF2Il4DQ4XyO8=;
        b=g5eT9qiYVQdpopm8DHbz0ehFpZK7I6UgZVPlEQ23wQBdok3BITfGrqNbNIfku2kXZF
         pjGWxQ4fqlKeB/7+5mRxBWvpM7hwkJK6eU5nRHzykd8NzxPVReY7fFah7ZwCAEp95Mkh
         FlNZBLJ+HOdOGGOakkMyxWPf5yePSg63jM0GjlBLcWdAUeAXyxApDebZotM4n+BAh1/C
         osPy8bc8J790hP9bVzkmHVC4JQFZIvaOebslmEle2xx01/8K9TlzNNK0wPMoKbhT3FVN
         FyILPkRaKO+8V7PryDL300q8SqVQ4Jr2ZRNOcPapzNn5jqJshuwmuVuHa1Gp8t/tWl7g
         kaSQ==
X-Gm-Message-State: AOAM531yj6gl7RqKH0jsosyf4RjlwfPXZSYnZ5jnhRtImrbb7YL49+VX
        jkTAUloQAjyXIumrBm6qA3uggg==
X-Google-Smtp-Source: ABdhPJwhC4/rJQcIjxfeGPo9LkbStIn8dyKvjMW3YiNS4XsD2BM02vj9dgON0YIc+upk/EK+qzPuyw==
X-Received: by 2002:a05:6512:1398:b0:448:bda0:99f2 with SMTP id p24-20020a056512139800b00448bda099f2mr2896081lfa.681.1650628127191;
        Fri, 22 Apr 2022 04:48:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([188.162.65.189])
        by smtp.gmail.com with ESMTPSA id h7-20020a19ca47000000b0047014ca10f2sm200695lfj.8.2022.04.22.04.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 04:48:46 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: pci/qcom-pcie: specify reg-names explicitly
Date:   Fri, 22 Apr 2022 14:48:38 +0300
Message-Id: <20220422114841.1854138-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
References: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of specifying the enum of possible reg-names, specify them
explicitly. This allows us to specify which chipsets need the "atu"
regions, which do not. Also it clearly describes which platforms
enumerate PCIe cores using the dbi region and which use parf region for
that.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 96 ++++++++++++++++---
 1 file changed, 81 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 7210057d1511..e78e63ea4b25 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -35,21 +35,6 @@ properties:
           - qcom,pcie-ipq6018
       - const: snps,dw-pcie
 
-  reg:
-    minItems: 4
-    maxItems: 5
-
-  reg-names:
-    minItems: 4
-    maxItems: 5
-    items:
-      enum:
-        - parf # Qualcomm specific registers
-        - dbi # DesignWare PCIe registers
-        - elbi # External local bus interface registers
-        - config # PCIe configuration space
-        - atu # ATU address space (optional)
-
   interrupts:
     maxItems: 1
 
@@ -108,6 +93,87 @@ required:
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-apq8064
+              - qcom,pcie-ipq4019
+              - qcom,pcie-ipq8064
+              - qcom,pcie-ipq8064v2
+              - qcom,pcie-ipq8074
+              - qcom,pcie-qcs404
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 4
+        reg-names:
+          items:
+            - const: dbi # DesignWare PCIe registers
+            - const: elbi # External local bus interface registers
+            - const: parf # Qualcomm specific registers
+            - const: config # PCIe configuration space
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq6018
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 5
+        reg-names:
+          items:
+            - const: dbi # DesignWare PCIe registers
+            - const: elbi # External local bus interface registers
+            - const: atu # ATU address space (optional)
+            - const: parf # Qualcomm specific registers
+            - const: config # PCIe configuration space
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-apq8084
+              - qcom,pcie-msm8996
+              - qcom,pcie-sdm845
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 4
+        reg-names:
+          items:
+            - const: parf # Qualcomm specific registers
+            - const: dbi # DesignWare PCIe registers
+            - const: elbi # External local bus interface registers
+            - const: config # PCIe configuration space
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc7280
+              - qcom,pcie-sc8180x
+              - qcom,pcie-sm8250
+              - qcom,pcie-sm8450-pcie0
+              - qcom,pcie-sm8450-pcie1
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 5
+        reg-names:
+          items:
+            - const: parf # Qualcomm specific registers
+            - const: dbi # DesignWare PCIe registers
+            - const: elbi # External local bus interface registers
+            - const: atu # ATU address space (optional)
+            - const: config # PCIe configuration space
   - if:
       properties:
         compatible:
-- 
2.35.1

