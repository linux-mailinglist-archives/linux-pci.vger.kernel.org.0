Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE685745A1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 09:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiGNHOF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 03:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiGNHOD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 03:14:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC82FDF4C;
        Thu, 14 Jul 2022 00:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68AA061B9C;
        Thu, 14 Jul 2022 07:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4253C341C6;
        Thu, 14 Jul 2022 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657782841;
        bh=VzcVFB6LAmsnbOvtp2UG9xz17D7uT1wYZmOvynZD8g0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zuzl5vBA0inaj8zK8+fscKRJV4XgP04LGUlPgJaWGEWw3V4B3Pg3f6eWuTqWzoHB2
         LT1dit1yZSd93RYRiuQmB0ygz6yK7AXfvAehEwXWKho80PMCiZJosjIkszOQyp9dxn
         9rqyzTB9ci0B5Z2RQBxnIQZlrvlrmmzc+X2HTaQkzPAq8v7slLudre/me4vhSn1qr0
         XZ1FMZ4EzGG25MDxQhhYMDpP5McvbkQjdslAuf9XGvXI4ZnK8913/j3Yg0vczvonbA
         GF+FVEfyR0XnAMGQ+FRUyo3AGslGZBu4KFuDkc6vnyHjbPZ9AUkMxDHEeUZmqEvDqg
         D0X56pGEznMaA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oBt30-0001m9-5G; Thu, 14 Jul 2022 09:14:06 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/8] dt-bindings: PCI: qcom: Add SC8280XP to binding
Date:   Thu, 14 Jul 2022 09:13:42 +0200
Message-Id: <20220714071348.6792-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714071348.6792-1-johan+linaro@kernel.org>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the SC8280XP platform to the binding.

SC8280XP use four host interrupts for MSI routing so remove the obsolete
comment referring to newer chipsets supporting one or eight interrupts
(e.g. for backwards compatibility).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 50 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 8142c891f18b..577d166a7476 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -27,6 +27,7 @@ properties:
       - qcom,pcie-qcs404
       - qcom,pcie-sc7280
       - qcom,pcie-sc8180x
+      - qcom,pcie-sc8280xp
       - qcom,pcie-sdm845
       - qcom,pcie-sm8150
       - qcom,pcie-sm8250
@@ -181,6 +182,7 @@ allOf:
             enum:
               - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
+              - qcom,pcie-sc8280xp
               - qcom,pcie-sm8250
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
@@ -596,6 +598,35 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc8280xp
+    then:
+      properties:
+        clocks:
+          minItems: 8
+          maxItems: 9
+        clock-names:
+          minItems: 8
+          items:
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: ddrss_sf_tbu # PCIe SF TBU clock
+            - const: noc_aggr_4 # NoC aggregate 4 clock
+            - const: noc_aggr_south_sf # NoC aggregate South SF clock
+            - const: cnoc_qx # Configuration NoC QX clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
   - if:
       not:
         properties:
@@ -624,7 +655,6 @@ allOf:
         - resets
         - reset-names
 
-    # On newer chipsets support either 1 or 8 msi interrupts
   - if:
       properties:
         compatible:
@@ -660,6 +690,24 @@ allOf:
                 - const: msi6
                 - const: msi7
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc8280xp
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 4
+        interrupt-names:
+          items:
+            - const: msi0
+            - const: msi1
+            - const: msi2
+            - const: msi3
+
   - if:
       properties:
         compatible:
-- 
2.35.1

