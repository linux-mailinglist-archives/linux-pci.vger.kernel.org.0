Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BF553C672
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242627AbiFCHlr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 03:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242611AbiFCHlq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 03:41:46 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EB337037
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 00:41:45 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q1so7609562ljb.5
        for <linux-pci@vger.kernel.org>; Fri, 03 Jun 2022 00:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VzqGnSkfjGsd12VJjeT042q1msdDMzMuRj8aU0uV6Z8=;
        b=JW+Wj6GKO3Hete5xX4WCSldTy55518ngmRs7hbWLGhqHQgNF8vic9mT03E5dhtpBcj
         RuOPfBp4PHOH6s13puvMlkC/WJH6MHkQIVbArlNsXO5pUq7DjcqkKTq3LiyGKvUP5FhF
         +v1pz4/VdmF+dpbZKolasX4ZVOVC4B6osjdGp0r1w01D6x2bnTy5ea1a36n2EXAuUhHm
         YZVZHiU/j1T6MwPSIwR8ukn9W73iJxDr0+KtVc5DnGKlz7XxSSj58nhbZPx5vhZVvPYK
         Qjsh0trqCu5geSwGVERowTuf+SjTIeOOykQiTZexbd1naunyx+7nc41BkqQL5msOhc53
         v/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VzqGnSkfjGsd12VJjeT042q1msdDMzMuRj8aU0uV6Z8=;
        b=OjClxH82hMCHGiWc+e1ikfVYzmGd7LemZdlqfDLITpHTDiS39iQDZ1h6zW4rFVacBp
         PNJ8UaVIiNj1RytryYLH1rM53ToYFUyWOEMPINV6goKYEdmYlJNBDPPMJN4+TcF8O0+k
         JVH8tASRfm6BMFitV2ggjn3G1LuMSdH+uzs+Hm7f1OQ0tDOZV3j27TOyDd4Jxn3B+ZvA
         m0grYVmLdzrsuajOLAdyaSNaT2VicjXDIAayYohAAe0poENUWuTWkasq5299141lHT04
         afHJRZy34HiiSqet99j1CJFo+UBlNpF9w5Cgu1YiNe3U0xrIbe2tcR79Yj0Mq37VDGIC
         G+MA==
X-Gm-Message-State: AOAM53116dcOogFNHpMUgKlAFMzMmRZPQdnWj2ES+d0GnKTXElVeKTnn
        1WcpgfWfWkKYKYWTDe4WnUTl+g==
X-Google-Smtp-Source: ABdhPJwEr4X05lvOTXAGdcqbv4f7mVzXduDHiGlvABJyNh4VQZqY2OgaXNBhmXEOb0UOi0z3z4yUSQ==
X-Received: by 2002:a2e:874a:0:b0:255:7b02:8f26 with SMTP id q10-20020a2e874a000000b002557b028f26mr2678603ljj.320.1654242103389;
        Fri, 03 Jun 2022 00:41:43 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x6-20020ac24886000000b00477b11144e9sm1450023lfc.66.2022.06.03.00.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 00:41:42 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v13 5/7] dt-bindings: PCI: qcom: Support additional MSI interrupts
Date:   Fri,  3 Jun 2022 10:41:35 +0300
Message-Id: <20220603074137.1849892-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220603074137.1849892-1-dmitry.baryshkov@linaro.org>
References: <20220603074137.1849892-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Qualcomm platforms each group of 32 MSI vectors is routed to the
separate GIC interrupt. Document mapping of additional interrupts.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 53 +++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 0b69b12b849e..fe8f9a62a665 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -43,11 +43,12 @@ properties:
     maxItems: 5
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 8
 
   interrupt-names:
-    items:
-      - const: msi
+    minItems: 1
+    maxItems: 8
 
   # Common definitions for clocks, clock-names and reset.
   # Platform constraints are described later.
@@ -623,6 +624,52 @@ allOf:
         - resets
         - reset-names
 
+    # On newer chipsets support either 1 or 8 msi interrupts
+    # On older chipsets it's always 1 msi interrupt
+  - if:
+      properties:
+        compatibles:
+          contains:
+            enum:
+              - qcom,pcie-msm8996
+              - qcom,pcie-sc7280
+              - qcom,pcie-sc8180x
+              - qcom,pcie-sdm845
+              - qcom,pcie-sm8150
+              - qcom,pcie-sm8250
+              - qcom,pcie-sm8450-pcie0
+              - qcom,pcie-sm8450-pcie1
+    then:
+      oneOf:
+        - properties:
+            interrupts:
+              maxItems: 1
+            interrupt-names:
+              maxItems: 1
+              items:
+                - const: msi
+        - properties:
+            interrupts:
+              minItems: 8
+            interrupt-names:
+              minItems: 8
+              items:
+                - const: msi0
+                - const: msi1
+                - const: msi2
+                - const: msi3
+                - const: msi4
+                - const: msi5
+                - const: msi6
+                - const: msi7
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          items:
+            - const: msi
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.1

