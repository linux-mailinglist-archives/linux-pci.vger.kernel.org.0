Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9D35B449D
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 08:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiIJGcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 02:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiIJGcf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 02:32:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A318ADCE2
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 23:32:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e20so6555218wri.13
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 23:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=g2cRg6vja1xVLyvuk31wUicvTsmqZJjRGy3zZQep69w=;
        b=gPdrnmuPn77o8HVG6IUn596O9hfZI6jr9wJlrxIwXr4tn9LE/Rwikk6FDJ+MiH8c3L
         bimiHBpWLM2YeP+wV4JB7R4YCmRKyWQeDjjcqkfoV8+eTRs2u1aq9VaZ8bwglBHcPKNK
         1XATRAXX8ds5H76/g9PhMrY6YE3Lw6o3AgVeklmmrpvAh2sXBR5aBMt4YRtrX6iJWULF
         JadGls0oPbJdgBdq4CPEaVnAU4HmXWk6nANY59XxiSAQ6pxDXvqdFiRVazf229Jja8yt
         eq+KURMPSdqFPmFZg/PsO8FFGBKmGie/8KdQ6lNv/GntocxrkY+p0lbZOITS9Ks7PfDf
         3crA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=g2cRg6vja1xVLyvuk31wUicvTsmqZJjRGy3zZQep69w=;
        b=TxFHYnphm+Ks55Abk0a/UGJWBlEXXX7o/9eXlevD5pBpMkW/bEtKYR+yPKfppHwGE7
         yfdqA1kEWTdEBp4fjQu2pEQ6nWkNCsBQVrFyfHWUEHMo5FZeEGXSZqzbeQX0PIp1S3Me
         iBYFTG1viqKTDH9dnP5lX99ekvB2HXvxBBKMQot75fduzm3XSk7Z8xJ8wDaoVWMCKvRD
         v8Z0h+YcFwp5Im3Z4V6WIOicy1Vr5eREteQhZPKmnBB/55OLgWlNv5pounlhg9q0mqq+
         BNr1AymlWcv9xOYHo13yJKlSpRc34SBRZ2Qz9FycUEmdVN6Gi/YlzQsijopgo48V16m5
         QF3A==
X-Gm-Message-State: ACgBeo0OQL/1Enug5mukHcNDoWuko9mL7JU3KAa/zvjxx0/7GeA5gYBY
        1JOt0Fhv0DGI695BXvmUpFRp
X-Google-Smtp-Source: AA6agR6TKT1M3WAffPM55QUeI+tz68QvLvb4lXO9kJncgFLfYcQTyMeTv4jjCZKc/7CV92cfLG/mHg==
X-Received: by 2002:a05:6000:136b:b0:22a:3b92:4c05 with SMTP id q11-20020a056000136b00b0022a3b924c05mr3775896wrz.183.1662791540600;
        Fri, 09 Sep 2022 23:32:20 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:32:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 10/12] dt-bindings: PCI: qcom-ep: Define clocks per platform
Date:   Sat, 10 Sep 2022 12:00:43 +0530
Message-Id: <20220910063045.16648-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
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

In preparation of adding the bindings for future SoCs, let's define the
clocks per platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 50 ++++++++++++-------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index b728ede3f09f..bb8e982e69be 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -9,9 +9,6 @@ title: Qualcomm PCIe Endpoint Controller binding
 maintainers:
   - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 
-allOf:
-  - $ref: "pci-ep.yaml#"
-
 properties:
   compatible:
     const: qcom,sdx55-pcie-ep
@@ -35,24 +32,10 @@ properties:
       - const: mmio
 
   clocks:
-    items:
-      - description: PCIe Auxiliary clock
-      - description: PCIe CFG AHB clock
-      - description: PCIe Master AXI clock
-      - description: PCIe Slave AXI clock
-      - description: PCIe Slave Q2A AXI clock
-      - description: PCIe Sleep clock
-      - description: PCIe Reference clock
+    maxItems: 7
 
   clock-names:
-    items:
-      - const: aux
-      - const: cfg
-      - const: bus_master
-      - const: bus_slave
-      - const: slave_q2a
-      - const: sleep
-      - const: ref
+    maxItems: 7
 
   qcom,perst-regs:
     description: Reference to a syscon representing TCSR followed by the two
@@ -112,6 +95,35 @@ required:
   - reset-names
   - power-domains
 
+allOf:
+  - $ref: pci-ep.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdx55-pcie-ep
+    then:
+      properties:
+        clocks:
+          items:
+            - description: PCIe Auxiliary clock
+            - description: PCIe CFG AHB clock
+            - description: PCIe Master AXI clock
+            - description: PCIe Slave AXI clock
+            - description: PCIe Slave Q2A AXI clock
+            - description: PCIe Sleep clock
+            - description: PCIe Reference clock
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg
+            - const: bus_master
+            - const: bus_slave
+            - const: slave_q2a
+            - const: sleep
+            - const: ref
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1

