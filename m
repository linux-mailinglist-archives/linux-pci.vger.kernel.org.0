Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE2578FE33
	for <lists+linux-pci@lfdr.de>; Fri,  1 Sep 2023 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349718AbjIANRc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Sep 2023 09:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349710AbjIANRc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Sep 2023 09:17:32 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 593ACE7E;
        Fri,  1 Sep 2023 06:17:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,219,1688396400"; 
   d="scan'208";a="178442172"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2023 22:17:26 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 396F9421CCBF;
        Fri,  1 Sep 2023 22:17:26 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 3/3] dt-bindings: PCI: rcar-gen4-pcie-ep: Fix minor issues
Date:   Fri,  1 Sep 2023 22:17:11 +0900
Message-Id: <20230901131711.2861283-4-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix minor issues of rcar-gen4-pci-ep.yaml.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---

This patch will be squashed into the following commit on the pci.git /
controller/rcar branch so that many fixes into a patch:

dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/rcar&id=738bded11aaa3a9717e415197cd6b833dc439cb3
---
 .../bindings/pci/rcar-gen4-pci-ep.yaml        | 39 ++++++++++++-------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
index 4e6be856104c..fe38f62da066 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
@@ -20,7 +20,7 @@ properties:
       - const: renesas,rcar-gen4-pcie-ep  # R-Car Gen4
 
   reg:
-    maxItems: 6
+    maxItems: 7
 
   reg-names:
     items:
@@ -29,6 +29,7 @@ properties:
       - const: atu
       - const: dma
       - const: app
+      - const: phy
       - const: addr_space
 
   interrupts:
@@ -40,12 +41,6 @@ properties:
       - const: sft_ce
       - const: app
 
-  power-domains:
-    maxItems: 1
-
-  resets:
-    maxItems: 1
-
   clocks:
     maxItems: 2
 
@@ -54,8 +49,15 @@ properties:
       - const: core
       - const: ref
 
-  max-functions:
-    maximum: 2
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: pwr
 
   max-link-speed:
     maximum: 4
@@ -63,15 +65,20 @@ properties:
   num-lanes:
     maximum: 4
 
+  max-functions:
+    maximum: 2
+
 required:
   - compatible
   - reg
   - reg-names
   - interrupts
-  - resets
-  - power-domains
+  - interrupt-names
   - clocks
   - clock-names
+  - power-domains
+  - resets
+  - reset-names
 
 unevaluatedProperties: false
 
@@ -87,10 +94,11 @@ examples:
 
         pcie0_ep: pcie-ep@e65d0000 {
             compatible = "renesas,r8a779f0-pcie-ep", "renesas,rcar-gen4-pcie-ep";
-            reg = <0 0xe65d0000 0 0x2000>, <0 0xe65d2800 0 0x0800>,
+            reg = <0 0xe65d0000 0 0x2000>, <0 0xe65d2000 0 0x1000>,
                   <0 0xe65d3000 0 0x2000>, <0 0xe65d5000 0 0x1200>,
-                  <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;
-            reg-names = "dbi", "dbi2", "atu", "dma", "app", "addr_space";
+                  <0 0xe65d6200 0 0x0e00>, <0 0xe65d7000 0 0x0400>,
+                  <0 0xfe000000 0 0x400000>;
+            reg-names = "dbi", "dbi2", "atu", "dma", "app", "phy", "addr_space";
             interrupts = <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
@@ -99,8 +107,9 @@ examples:
             clock-names = "core", "ref";
             power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
             resets = <&cpg 624>;
-            num-lanes = <2>;
+            reset-names = "pwr";
             max-link-speed = <4>;
+            num-lanes = <2>;
             max-functions = /bits/ 8 <2>;
         };
     };
-- 
2.25.1

