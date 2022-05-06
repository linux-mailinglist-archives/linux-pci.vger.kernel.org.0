Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0351DBCE
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442769AbiEFPY7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 11:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442679AbiEFPY5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 11:24:57 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD0562136
        for <linux-pci@vger.kernel.org>; Fri,  6 May 2022 08:21:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p10so13131048lfa.12
        for <linux-pci@vger.kernel.org>; Fri, 06 May 2022 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/QSONSEpjxrPZtFb9gmtNnByfU6eZhR98/Jc/QyZERA=;
        b=HWClHrabwkjxcA2CtSeU23o6GO2OMPDOjI2fw4har7wqRa2qhzfxFDlz0BCeoejIfO
         IDFEgmhezRdtbuAlKVd94wD37B04PS8/adyQMuqNipoAZO0/KnUfYk6hGlPRmVbXpVur
         nkH71JkDJfgjAvpIdtVYGZHMBs1govfvXhzH3F1jByooJWDS0H70fWlNdVT/lq8RRkFB
         GDxckoEPsZumrqGeKrhAePDInhv2/F1ZaM4L0wO+zmq0lMcGp/8S1uz12kwHgT3EWnIR
         3mWi90gZbBMCVglu/5+FYQiRULw7HR34DZZ7UZHTu2vkf4rS5wfEVAJtI9tgPocbrG3L
         fZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/QSONSEpjxrPZtFb9gmtNnByfU6eZhR98/Jc/QyZERA=;
        b=Rxyg+S8OmiGSLBEgq3JpG4+/uWxQvpGYhISwP9Q311RZCDGmzPZQtJKolvspNR1kjy
         eiYrxjUFMkIXKDZyJoqEJLtbU9XCvweOad0wKAgU+/DaI1+ke4zsIm/BYiclTDq5ui3r
         1pvdv6Hx/akNrh4ILJjQWb7Wb7H0c1xdsNFbkEFsWINJ3dsn2kUJC+dVPCrDcZmuJR2n
         +bL0P81p++Y/QukUO72k9/FNnuXQkdXb4ixqPbdOwvS6KSES4jTI2iqiLeRqB8dk7g/V
         JfbuwzWKpR1oSHHA+BBgH8CWtqlqj9SLYLn5Da4AJ/AiQpL9oBTOJNNHekcisH6V1Wak
         OAvw==
X-Gm-Message-State: AOAM533qwF8RgBG0xqtUG7YOanjdotaR27MJFwjU/5+m89TAuczMEkf4
        TMZ8T2bxJbL+Xsyo/j0vRekJxg==
X-Google-Smtp-Source: ABdhPJysUAIrL7QY6s4XuAbn/XZxOwZnTPUA14uicd/0xjxsBDKC0P+IVky1n8F0aFR5uMU0YFXKtg==
X-Received: by 2002:a05:6512:3f01:b0:46b:a5ba:3b89 with SMTP id y1-20020a0565123f0100b0046ba5ba3b89mr2801120lfa.28.1651850471526;
        Fri, 06 May 2022 08:21:11 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651239d000b0047255d211e6sm716757lfu.277.2022.05.06.08.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 08:21:11 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 3/8] dt-bindings: PCI: qcom: Specify reg-names explicitly
Date:   Fri,  6 May 2022 18:21:02 +0300
Message-Id: <20220506152107.1527552-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
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

Instead of specifying the enum of possible reg-names, specify them
explicitly. This allows us to specify which chipsets need the "atu"
regions, which do not. Also it clearly describes which platforms
enumerate PCIe cores using the dbi region and which use parf region for
that.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 91 +++++++++++++++++--
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index ce4f53cdaba0..e91ae436cafe 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -40,13 +40,6 @@ properties:
   reg-names:
     minItems: 4
     maxItems: 5
-    items:
-      enum:
-        - parf # Qualcomm specific registers
-        - dbi # DesignWare PCIe registers
-        - elbi # External local bus interface registers
-        - config # PCIe configuration space
-        - atu # ATU address space (optional)
 
   interrupts:
     maxItems: 1
@@ -117,6 +110,90 @@ required:
 
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
+
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
+            - const: atu # ATU address space
+            - const: parf # Qualcomm specific registers
+            - const: config # PCIe configuration space
+
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
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
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
+            - const: atu # ATU address space
+            - const: config # PCIe configuration space
+
   - if:
       properties:
         compatible:
-- 
2.35.1

