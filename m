Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A8651C18F
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 15:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380222AbiEEN6A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 09:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380193AbiEEN54 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 09:57:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ECD5798F
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 06:54:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bu29so7665271lfb.0
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2022 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CTHkilprIvL9A/8ur+bw1pjnP/4ABBDDnOBt355kY54=;
        b=cJbdjlgRt5S21pqwH/4LI/wh0h3Zpznl9TYcC0evuBNGcVYXKlVEALpYx7WDmJem4/
         gWUVU+KyKv3b2ZOhn18vaVGL3QAgLZHM8XD3/wEMUXo1nhpdr3cbUBuBBTd/TsumHcre
         vMfUCJ4aae3+uqC3Sjd4C/mZqjudldl5iWWX68a/LCU7pGj4o1RvtFVm3vi0/dj5wY/D
         TynRX1OwF5OBf0kvIa8dLeXxX5QjrDUWHxVab+QOAKoj/XP6BydG5gDgDOAOn1hNHLiq
         a1/xnVabjKRtuoSYSv4x8CAaONsHZorcnaJe9BauiSCQtYzXK5lVjmh66VT3Z5QOD489
         PuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CTHkilprIvL9A/8ur+bw1pjnP/4ABBDDnOBt355kY54=;
        b=7c2uUNv+SjUn4ts0lxcddWVz3eIREmPh4AlDhhVTy/WYca2kFb1dBvxN4SJ25yrAUt
         GDZNruywEG761KZ8FiD73VHnhtczenwIpZUB61QYCHXKEt24jsCZyhty0ClJNuPhboHw
         B6PCc1R7TlCHNQ7FCcvlbawZk1AWJupADlKtIlaXU+eUPhUrxphqXru9BSw8ZvWBrkBL
         k8xT4GWYa/W/mVxApvG/YKxHSYpOH0X24GuHUe9L68WAdamkT7OMGMRrOBgjsT04RtUd
         FeunpUogFOymvvDQE5Pp1IkXWrNr6ghS/fAGfzh37OnVT+NHJAoVZVvHgNWMBC2S3XF3
         NJ9A==
X-Gm-Message-State: AOAM533PIupPaPIJc0oRWxHuI7sC/KAFj7os5rLYPvCN8u8hi9qHoe75
        pdH6xZNCXTFLLkJgLYeI5yfh9w==
X-Google-Smtp-Source: ABdhPJz6ZWKVIfK2ub5g2meRCjSaHdTV6ukDSC/+1DMTCGpGr2aHdKTltlD7dikydGBvhbrrrfM9Qw==
X-Received: by 2002:ac2:5287:0:b0:472:57c7:d1de with SMTP id q7-20020ac25287000000b0047257c7d1demr16887371lfm.654.1651758852648;
        Thu, 05 May 2022 06:54:12 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z24-20020ac25df8000000b0047255d211ccsm221788lfq.251.2022.05.05.06.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:54:12 -0700 (PDT)
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
Subject: [PATCH v7 6/7] dt-bindings: PCI: qcom: Support additional MSI interrupts
Date:   Thu,  5 May 2022 16:54:06 +0300
Message-Id: <20220505135407.1352382-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
References: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
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
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 45 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 0b69b12b849e..fd3290e0e220 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -43,11 +43,20 @@ properties:
     maxItems: 5
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 8
 
   interrupt-names:
+    minItems: 1
     items:
       - const: msi
+      - const: msi2
+      - const: msi3
+      - const: msi4
+      - const: msi5
+      - const: msi6
+      - const: msi7
+      - const: msi8
 
   # Common definitions for clocks, clock-names and reset.
   # Platform constraints are described later.
@@ -623,6 +632,40 @@ allOf:
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
+        - properties:
+            interrupts:
+              minItems: 8
+            interrupt-names:
+              minItems: 8
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.1

