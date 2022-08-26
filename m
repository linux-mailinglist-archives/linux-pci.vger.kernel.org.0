Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47D15A2E43
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 20:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345098AbiHZSVA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 14:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345084AbiHZSU2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 14:20:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DED7E30D
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:20:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i7-20020a17090adc0700b001fd7ccbec3cso452211pjv.0
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3lqErrpIi1UlNBvr2etlxbn6jm+KxN6urj/clypYcWk=;
        b=PbPTUljjg1SsS5dFb8e/vCqYlugM52N7dokTtp+WBMai2jOd+em3lFMHLlR0oYnjPg
         /l2aZgL7ipkAbM8OnpVRPwALPcmvSFcThtg5FZR9t2HgXdAdjGlz6cIg6Tl+jDg/fnw1
         EJrXYvf5JroRsAkbyVkRiPHhzisyFGeW0twEAxdegvAvaGCjT48bPgKuJeS3XJ4Ea0lT
         0GqLbGAhpKfT2zpe3NNRC84hcFeN1+uwPgiF+b5WicOaxmdSSlwJI/1cjR4vZw/HTCTZ
         P84U93Aq/aM1vc8esQAaNSSD9DmBVQzOTmyMiViWHz6hEwcSp/Lo420q/aH0jynLqsOn
         OFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3lqErrpIi1UlNBvr2etlxbn6jm+KxN6urj/clypYcWk=;
        b=3OU/FnbZ9jkali6OmX1EQywGeUQmuTOtGP/fb49Filj13ymlxHGYLVbvdQULm3wcJR
         r2LYUNImcWKVcznzkk1l26nc+J7ET/+tf7vc/37DW2ITIYUSxZRZTjMxN23VGGeze6dG
         50ZPEepgsFVIXP5pRqMxGh/sV/mTGtnbkEKz41L+LGUOSD2kRv76aiyREuTQ7MLS/ADf
         PBablIN578TDgDWA+MucyfbRkhivQfIBxkfZgcFwX6N6tKxwd3bgdsx9UN3JqUXuI7Sl
         JTNJETg68yi7jX8Rn6uZ57Ywy3KkrOAHlQzRpE6Wnu52OiqHS1udjyOc/eeoe0rBm6VB
         pJhA==
X-Gm-Message-State: ACgBeo0mssbjKZHxy6jlcw0PzBf2Am2Aa/pHjMoQHnmLhR2u6z/D7X3E
        wgQtOwsbbqlAk3p7BN7Ay1AS
X-Google-Smtp-Source: AA6agR7+n0c5CRzHR7sK9J7ct2fdBFRX+tR2gUuM0cP3JMWMSLakss7BFRqubjEYa+HPa14dMYQBqw==
X-Received: by 2002:a17:90a:aa08:b0:1fd:8016:29f1 with SMTP id k8-20020a17090aaa0800b001fd801629f1mr501590pjq.23.1661538021015;
        Fri, 26 Aug 2022 11:20:21 -0700 (PDT)
Received: from localhost.localdomain ([117.193.214.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b00173368e9dedsm1881868plr.252.2022.08.26.11.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:20:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/11] dt-bindings: PCI: qcom-ep: Define clocks per platform
Date:   Fri, 26 Aug 2022 23:49:21 +0530
Message-Id: <20220826181923.251564-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation of adding the bindings for future SoCs, let's define the
clocks per platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 46 +++++++++++--------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index b728ede3f09f..83a2cfc63bc1 100644
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
@@ -35,24 +32,12 @@ properties:
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
+    minItems: 7
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
+    minItems: 7
+    maxItems: 7
 
   qcom,perst-regs:
     description: Reference to a syscon representing TCSR followed by the two
@@ -112,6 +97,29 @@ required:
   - reset-names
   - power-domains
 
+allOf:
+  - $ref: "pci-ep.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdx55-pcie-ep
+    then:
+      properties:
+        clocks:
+          minItems: 7
+          maxItems: 7
+        clock-names:
+          items:
+            - const: aux # PCIe Auxiliary clock
+            - const: cfg # PCIe CFG AHB clock
+            - const: bus_master # PCIe Master AXI clock
+            - const: bus_slave # PCIe Slave AXI clock
+            - const: slave_q2a # PCIe Slave Q2A AXI clock
+            - const: sleep # PCIe Sleep clock
+            - const: ref # PCIe Reference clock
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1

