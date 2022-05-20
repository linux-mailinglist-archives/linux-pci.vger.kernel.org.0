Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DE252F2DA
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 20:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350126AbiETSce (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 14:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352754AbiETSb4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 14:31:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A70D3AA4F
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 11:31:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p22so15724873lfo.10
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HYUuQ4fR4SBZdSuM6IAnUnoggotKrAQZZIhO70s2q7Y=;
        b=X4oIh/DT61PtzHnpKmzPraEthERRUoDiBARoyBkbYkzGlvqpPpDy+F3bl/qWEKGNo9
         JjHVe3kxX9YQC0w40D/IzfH1CvaV3hyidNGxlPd2F7EPOcE3zSr3mQWHV10M4nTPuYNb
         mqB2s78/8THZqtl8dn3v9/swEqTFGbu4y4m22wPB2L7QHrGbWWd6LhuXbSN8915T5dUb
         PNbVGcT5dx3edrQgPhc6AgoXAj9NyPBG+9FHtep2v5jUpGXGQsMLIoMKxG1RjMAJMKI6
         OLn6tM/2p15Ileo9y/Uc2ZTfo/NU8+x8sH5LbY8mtx8MRdtFcJOfRgKSLF2KdagRB2DI
         ePIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYUuQ4fR4SBZdSuM6IAnUnoggotKrAQZZIhO70s2q7Y=;
        b=5fpvYHocYKZQy/WFo4Q1BLJJBL0f5kiVVWI9mnvuwl1blYps0sTOqi2iEweAVnLxyo
         0qFw7Un4TsO1lwUgWWEgx0IDoPnYy/uKxg20E4MCbjH0riUNTyBLMxw3oKF2uczTV3yh
         r02LfyFYs70pIlUo7DwqLatDkgSI3q4Qdj8Xb6ZrNq/MskLi1mELhszmMfzTatK1JhiA
         xve2bHD0vyloxU3k3z0MZ27itD4ncJzUwCX0j/JKEro7wCqTn5FMjLso6uWRHCjUWzRC
         m1XQAqZoq4H3jhESCXAOUoL4bDhZ+VvqEjJ5Sjdojkj/wTvdgoeMzEc6a5VQ8LQLyfuQ
         sgxg==
X-Gm-Message-State: AOAM532cEO6ZrN0c/K3QBHJ0JuttfZMeQYntlfephnV1SGctcZ9Yc+3Q
        48wkuxJ/+2MuWrV8d7q/JQl09Q==
X-Google-Smtp-Source: ABdhPJzyVbKMJ57kOGL6RNEQwGiVIM9HKUDkUtE2x/DdTnx8ibeKSJSQhlA3lBM/180aZs3zNapMpA==
X-Received: by 2002:a19:7115:0:b0:473:f2a7:661 with SMTP id m21-20020a197115000000b00473f2a70661mr7250781lfc.586.1653071486030;
        Fri, 20 May 2022 11:31:26 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e9556000000b0024f3d1daef4sm392951ljh.124.2022.05.20.11.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:31:25 -0700 (PDT)
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
        Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 5/7] dt-bindings: PCI: qcom: Support additional MSI interrupts
Date:   Fri, 20 May 2022 21:31:12 +0300
Message-Id: <20220520183114.1356599-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520183114.1356599-1-dmitry.baryshkov@linaro.org>
References: <20220520183114.1356599-1-dmitry.baryshkov@linaro.org>
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

