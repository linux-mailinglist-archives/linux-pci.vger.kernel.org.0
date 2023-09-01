Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324A778FE2F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Sep 2023 15:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349713AbjIANRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Sep 2023 09:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIANRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Sep 2023 09:17:30 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFD57E7E;
        Fri,  1 Sep 2023 06:17:27 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,219,1688396400"; 
   d="scan'208";a="174734873"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2023 22:17:26 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 18812420FDB4;
        Fri,  1 Sep 2023 22:17:26 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/3] dt-bindings: PCI: rcar-gen4-pcie: Fix minor issues
Date:   Fri,  1 Sep 2023 22:17:10 +0900
Message-Id: <20230901131711.2861283-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix minor issues of rcar-gen4-pci-host.yaml.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---

This patch will be squashed into the following commit on the pci.git /
controller/rcar branch so that many fixes into a patch:

dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/rcar&id=af285bc39885eaeed434c607a977d664916681a7
---
 .../bindings/pci/rcar-gen4-pci-host.yaml      | 36 ++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index 513a3416dd8e..ffb34339b637 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -20,7 +20,7 @@ properties:
       - const: renesas,rcar-gen4-pcie  # R-Car Gen4
 
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
       - const: config
 
   interrupts:
@@ -55,7 +56,7 @@ properties:
   resets:
     maxItems: 1
 
-  resets-names:
+  reset-names:
     items:
       - const: pwr
 
@@ -68,7 +69,9 @@ properties:
 required:
   - compatible
   - reg
+  - reg-names
   - interrupts
+  - interrupt-names
   - clocks
   - clock-names
   - power-domains
@@ -91,8 +94,21 @@ examples:
             compatible = "renesas,r8a779f0-pcie", "renesas,rcar-gen4-pcie";
             reg = <0 0xe65d0000 0 0x1000>, <0 0xe65d2000 0 0x0800>,
                   <0 0xe65d3000 0 0x2000>, <0 0xe65d5000 0 0x1200>,
-                  <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;
-            reg-names = "dbi", "dbi2", "atu", "dma", "app", "config";
+                  <0 0xe65d6200 0 0x0e00>, <0 0xe65d7000 0 0x0400>,
+                  <0 0xfe000000 0 0x400000>;
+            reg-names = "dbi", "dbi2", "atu", "dma", "app", "phy", "config";
+            interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi", "dma", "sft_ce", "app";
+            clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
+            clock-names = "core", "ref";
+            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+            resets = <&cpg 624>;
+            reset-names = "pwr";
+            max-link-speed = <4>;
+            num-lanes = <2>;
             #address-cells = <3>;
             #size-cells = <2>;
             bus-range = <0x00 0xff>;
@@ -100,24 +116,12 @@ examples:
             ranges = <0x01000000 0 0x00000000 0 0xfe000000 0 0x00400000>,
                      <0x02000000 0 0x30000000 0 0x30000000 0 0x10000000>;
             dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
-            interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "msi", "dma", "sft_ce", "app";
             #interrupt-cells = <1>;
             interrupt-map-mask = <0 0 0 7>;
             interrupt-map = <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
                             <0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
                             <0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
                             <0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&cpg CPG_MOD 624>, <&clkref>;
-            clock-names = "core", "ref";
-            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-            resets = <&cpg 624>;
-            reset-names = "pwr";
-            num-lanes = <2>;
             snps,enable-cdm-check;
-            max-link-speed = <4>;
         };
     };
-- 
2.25.1

