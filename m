Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BDA6C8E06
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 13:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjCYMZK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 08:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjCYMZJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 08:25:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7A14226;
        Sat, 25 Mar 2023 05:25:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEC28B80707;
        Sat, 25 Mar 2023 12:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F48EC433A1;
        Sat, 25 Mar 2023 12:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679747104;
        bh=9q14Il46k5uyn12jYNB4ZkkGtkCjMJRqckUk0X9df9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRXG/kvdlZXHpWZv1Laz4Spb7z8KV1mSQVHI4zCmzLozMf5Rspktwx6QP9i0PhNYV
         frz7snEppGdeqdQkjAXrLBgrEnOsCOvEXQhdkBa7poDuVwaPhUaGMUzA+tGtEX+tnv
         uvjf7PztK8GL3MytSd8g+y84WkKXiUzzYfflc9dR7PkT3Trn68v3MWC7Rsh9wb/3C5
         ongHUZzTX2VJLTWAerPagg2n45dlnSOTm8XR49QjnmNVIzZpUskqcK1fNnM6kgry9s
         s0feSFSd6f5ZJsuEea6hHjpAbZjifashomF7wmTR4+X0f4FdOs1Sy1+RAIHK6nSNpN
         TPs5cnM6sWsJA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/12] dt-bindings: PCI: qcom: Document sc8180x properties
Date:   Sat, 25 Mar 2023 17:54:34 +0530
Message-Id: <20230325122444.249507-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230325122444.249507-1-vkoul@kernel.org>
References: <20230325122444.249507-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

sc8180x PCIe clocks and resets are different from the common pcie
binding, this warrants the oneOf clause for the clocks and resets

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 49 ++++++++++++++++++-
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index fb32c43dd12d..d4f837924e7c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -459,6 +459,33 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc8180x
+    then:
+      properties:
+        clocks:
+          minItems: 8
+          maxItems: 8
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: ref # REFERENCE clock
+            - const: tbu # PCIe TBU clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
   - if:
       properties:
         compatible:
@@ -507,7 +534,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-sc8180x
               - qcom,pcie-sm8150
               - qcom,pcie-sm8250
     then:
@@ -675,6 +701,7 @@ allOf:
           contains:
             enum:
               - qcom,pcie-sa8540p
+              - qcom,pcie-sc8180x
               - qcom,pcie-sc8280xp
     then:
       required:
@@ -717,7 +744,6 @@ allOf:
             enum:
               - qcom,pcie-msm8996
               - qcom,pcie-sc7280
-              - qcom,pcie-sc8180x
               - qcom,pcie-sdm845
               - qcom,pcie-sm8150
               - qcom,pcie-sm8250
@@ -746,6 +772,25 @@ allOf:
                 - const: msi6
                 - const: msi7
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc8180x
+    then:
+      oneOf:
+        - properties:
+            interrupts:
+              maxItems: 1
+            interrupt-names:
+              items:
+                - const: msi
+            iommus:
+              maxItems: 1
+            iommu-map:
+              maxItems: 2
+
   - if:
       properties:
         compatible:
-- 
2.39.2

