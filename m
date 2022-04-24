Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC5250D203
	for <lists+linux-pci@lfdr.de>; Sun, 24 Apr 2022 15:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbiDXNXy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Apr 2022 09:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiDXNXn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Apr 2022 09:23:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AD2A1B0
        for <linux-pci@vger.kernel.org>; Sun, 24 Apr 2022 06:20:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w1so21906384lfa.4
        for <linux-pci@vger.kernel.org>; Sun, 24 Apr 2022 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r63/wTPr4/PHvX+hVpl1ZWtMnqt2kinAFP5uZt5KkRE=;
        b=ALmRy/bFlY69tvB5T3mBwXhmSpEaxXkLGQShEotFEuSD4RWbrgMXqsnfjOdQADWurQ
         MSNPGTbc98Wdm+3Miz853Lmib3OnmUKCP42RpXC1Aq77m7qhjXIH3Cic4TBs6Udyoyar
         pTAfJiz3GA2lJeHChB3xgj9r7E1IhLzCFppv+3y56mPC1bv2mtaNOpqruPyNQkcRZ3Rv
         zcpaDntmzcVzBUuJT+UuY8ZU6WtjtY+uaVpue4cCjE+5ZMm46iA1uOHJsqVRx/CXVC71
         3N+qdTsxglieVRY9mNJAXy5U9gZ0xpdn/txsIzP8I/6qlxORFuNpT4nTNcUoL1xUi0uP
         Kjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r63/wTPr4/PHvX+hVpl1ZWtMnqt2kinAFP5uZt5KkRE=;
        b=kZwIBtIuGYxszHvr4wILXmk8U4ES2rw8gVKz64+fk8MTAYArlRbsLR0+s5yjGRS5BB
         yPbOI9rMcthR1SFb30d93OeTVXhhD6blhFm5J3i+pQtIcQPEPP15zErRHfsXHHIj8xIx
         WrBEuQlRO3XyBNeA8rE05LXfSKIFLyygMLLImfbVwH4IIkMaze5tK5KCZp/eVZL5P4vd
         HUaxRd8E15y6xPa++cmvUi0D+nR/waeDwXRxxeuxMZiL/RBirxEhoc2zDqiu+8sD5Z/a
         tLG7973Fa+s5IEZcutJq+uc30pXNlEBE11yglBxpLPM7wUQlitmLGtYnL91Itvaao6UE
         Cdmw==
X-Gm-Message-State: AOAM531cvgIoA2PDms3Fd96ijOmZkKfu6EhWGMm+/z8wj3OFgDN0m8Bb
        deGDuABIic+A7+h1ssq+10ldOg==
X-Google-Smtp-Source: ABdhPJz62gajffXDWjGnPCI0nRAXA8BAM9TDCLtTQ1iSpcdCOb5MmZTMh76RuYP2hIZ3E7ueCPFOhg==
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id h16-20020a19ca50000000b00471f556092bmr5626331lfj.587.1650806438850;
        Sun, 24 Apr 2022 06:20:38 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id l12-20020a056512332c00b0046d0e0e5b44sm1015877lfe.20.2022.04.24.06.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 06:20:38 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/8] dt-bindings: pci/qcom,pcie: add schema for sc7280 chipset
Date:   Sun, 24 Apr 2022 16:20:30 +0300
Message-Id: <20220424132034.2235768-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424132034.2235768-1-dmitry.baryshkov@linaro.org>
References: <20220424132034.2235768-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for sc7280-specific clock and reset definitions.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index c79b12a0d315..48d56b073564 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -25,6 +25,7 @@ properties:
       - qcom,pcie-ipq4019
       - qcom,pcie-ipq8074
       - qcom,pcie-qcs404
+      - qcom,pcie-sc7280
       - qcom,pcie-sc8180x
       - qcom,pcie-sdm845
       - qcom,pcie-sm8250
@@ -176,6 +177,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
               - qcom,pcie-sm8250
               - qcom,pcie-sm8450-pcie0
@@ -411,6 +413,36 @@ allOf:
             - const: pwr # PWR reset
             - const: ahb # AHB reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc7280
+    then:
+      properties:
+        clocks:
+          minItems: 11
+          maxItems: 11
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: pipe_mux # PIPE MUX
+            - const: phy_pipe # PIPE output clock
+            - const: ref # REFERENCE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: tbu # PCIe TBU clock
+            - const: ddrss_sf_tbu # PCIe SF TBU clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
   - if:
       properties:
         compatible:
-- 
2.35.1

