Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9F45A691B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiH3RAj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 13:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiH3RAA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 13:00:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDE5DAB89
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 09:59:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p185so11915205pfb.13
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2RJUahJy1CyyeYAGPRglH4WrcYkv62869DWyoQBcRWE=;
        b=pcwKwURC2Ax+MN6ar7LnswMcMRwZPdCQFe65TAWQheKtwZO3XjYSU96z4atLSX3KjG
         RJfnEsmo6Z/xpDrewSftEYfuSud4J6JLMW07mnT7sVXNXDi8lAf2l8Mej4hDEjcqsm7z
         w4fpfQMxz8s7PYFdDI+ivUbzBhSble2UZ3lApsbcp3br9SwMfOi3+1c9rul5LYKDmcKo
         P34EvaM7ccBRH4cyeFHuJ23e8LRRck8xsWnRn5kFxkuH/MQoWvcVGmz3jTVBE2UOmEZ0
         ovr9w8doTI/v1P7R2qB6aOEKj8ij5A3N4lP3cs0mKjPEl2oqVYzjyhQz9qyZmGFlldtr
         WfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2RJUahJy1CyyeYAGPRglH4WrcYkv62869DWyoQBcRWE=;
        b=EvPaurYhv++iQPB1BGx37T2n4jiIX5BtDLMRE6T77DkhZU93ulW6dQi6+JH51z9h0a
         YpqC2ZXr1Go7Xnju8gcGZp38oQVayislSTDt6/Ktq9TMRlcDLQUbeHBlpcNSNkkAYtWG
         oao0ZqTIDiXGaFkTZWTo8uEONf9pNRO3kaj69Oq/QBxdEf2DOLbtd/dSrbCy+EVKIGJk
         5EUsZQ71/59DeBYAvF7U7ABrFOeCxUnb0o+tOBGpovR4edH2eFCNtvYmiZkCLq7oj9Em
         hxnnSlpiYp1DP/RSM0z0O5zUDfS5QWbCTZwcWWu6yk/8qrDt/diIfkQNQzpldv2jJEZU
         AaQw==
X-Gm-Message-State: ACgBeo0rkFJa4OMRjl832IklEiH6/7cIyyq+lG9nc/Db69GW2jOozzkd
        X5NjM1bwmLYc4KMzlfzMEL2Q
X-Google-Smtp-Source: AA6agR7tRwab7rC6G1UrdgVxC/KvXmYce/f4rJKit37JFaFDyfHI0nKDM3EUg7fR4CJ8kjOEPuV7qQ==
X-Received: by 2002:aa7:8393:0:b0:537:701d:e7f3 with SMTP id u19-20020aa78393000000b00537701de7f3mr22351779pfm.50.1661878778765;
        Tue, 30 Aug 2022 09:59:38 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id n59-20020a17090a5ac100b001f510175984sm8841261pji.41.2022.08.30.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:59:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 10/11] dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC
Date:   Tue, 30 Aug 2022 22:28:16 +0530
Message-Id: <20220830165817.183571-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
References: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
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

Add devicetree bindings support for SM8450 SoC. Only the clocks are
different on this platform, rest is same as SDX55.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 40 +++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index a15e71491722..5902b45620ed 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: qcom,sdx55-pcie-ep
+    enum:
+      - qcom,sdx55-pcie-ep
+      - qcom,sm8450-pcie-ep
 
   reg:
     items:
@@ -32,10 +34,12 @@ properties:
       - const: mmio
 
   clocks:
-    maxItems: 7
+    minItems: 7
+    maxItems: 8
 
   clock-names:
-    maxItems: 7
+    minItems: 7
+    maxItems: 8
 
   qcom,perst-regs:
     description: Reference to a syscon representing TCSR followed by the two
@@ -125,6 +129,36 @@ allOf:
             - const: sleep
             - const: ref
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8450-pcie-ep
+    then:
+      properties:
+        clocks:
+          maxItems: 8
+          items:
+            - description: PCIe Auxiliary clock
+            - description: PCIe CFG AHB clock
+            - description: PCIe Master AXI clock
+            - description: PCIe Slave AXI clock
+            - description: PCIe Slave Q2A AXI clock
+            - description: PCIe Reference clock
+            - description: PCIe DDRSS SF TBU clock
+            - description: PCIe AGGRE NOC AXI clock
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg
+            - const: bus_master
+            - const: bus_slave
+            - const: slave_q2a
+            - const: ref
+            - const: ddrss_sf_tbu
+            - const: aggre_noc_axi
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1

