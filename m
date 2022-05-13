Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E45262D9
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 15:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380641AbiEMNRN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 09:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380640AbiEMNRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 09:17:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F176311164
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 06:17:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d19so14479727lfj.4
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HYUuQ4fR4SBZdSuM6IAnUnoggotKrAQZZIhO70s2q7Y=;
        b=ChLKujV6Y1lpp9wTj0B3X09dHIg98LpZaep9jTg3LQtxQpL6jRoxuAiHbAzkzvK+nW
         WMC7hJ2L3f58eWDlyy2nUqUxvDlFmUU+cWTPjLLq7i0J2V5SLdKCJ6HE3Etc686cWMub
         wqqVXDM+Lxs9tXcthxX/BNsnREsb/MlRM7PplN2/R5WODUupmFUiAHdm99LCdNclHj0R
         53xru/fLmBTsbteV9gzgi9qVb2IWDXxs220RJGqgS01IWqm1czhFAjGMqPeLjngF+mjS
         Uz6J/0BboeLrjmB0OF1BPpyitN3+D7JQc0UPe82uB6OwYCKhafaPHXw/nShrEYpiZhl6
         E+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYUuQ4fR4SBZdSuM6IAnUnoggotKrAQZZIhO70s2q7Y=;
        b=zHyY4dOpM6mG4nXK9QebRbtKx3qoxtx4qEy7wvV5qpdSy/s3BqI5hN6fvDehp/snTx
         hvTx7+6kcViLRcG3fCU3mvRBjxaPT+Fmq+BWapLsvMlaAawfXzc9BMeooB/29AsHBgP0
         7tlOxCJypSUU84nhlwhKr1XmyDpVEWvZq3FFnVu3Ucq24i3dz7GIP6nXgPEM56hiUD4m
         oKwOvGplKgqUK2rVnMDQAX/CGcdNO8piRFwPYDftX3c0+L9A2342GAoyJEbRp98kcJ4l
         KDV/WQRexquKenpRmSBoEL0+2y1RDVxU4l/P0dzJ1m4y5n5lVMbEIFvny2QEBntgqpBw
         vc+g==
X-Gm-Message-State: AOAM532duVnUFtxrm1yQ6YNo6gbkgAyWimn40wfmJqvIPoTQjYRGr8BB
        0dekTc5ChdoFI5Pn7g+wOD/FlA==
X-Google-Smtp-Source: ABdhPJwFJZVeVw2xJQ23xQ/LC7+pFuF2yAN9SdSJFS/y6pRRklPJtslvhOx3xLOhKmUfq5JRSzrejg==
X-Received: by 2002:a05:6512:c28:b0:473:b6ce:96fe with SMTP id z40-20020a0565120c2800b00473b6ce96femr3390096lfu.595.1652447825444;
        Fri, 13 May 2022 06:17:05 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u22-20020a2ea176000000b0024f3d1dae8fsm436991ljl.23.2022.05.13.06.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:17:04 -0700 (PDT)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 09/10] dt-bindings: PCI: qcom: Support additional MSI interrupts
Date:   Fri, 13 May 2022 16:16:54 +0300
Message-Id: <20220513131655.2927616-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513131655.2927616-1-dmitry.baryshkov@linaro.org>
References: <20220513131655.2927616-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Qualcomm platforms each group of 32 MSI vectors is routed to the
separate GIC interrupt. Document mapping of additional interrupts.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

