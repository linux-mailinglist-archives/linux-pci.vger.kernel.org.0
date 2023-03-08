Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC3D6B00FA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 09:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCHIZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 03:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCHIYs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 03:24:48 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CEA02054D;
        Wed,  8 Mar 2023 00:24:26 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.98,243,1673881200"; 
   d="scan'208";a="151900488"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 08 Mar 2023 17:24:25 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 115104010E0D;
        Wed,  8 Mar 2023 17:24:25 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     Sergey.Semin@baikalelectronics.ru, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 03/12] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
Date:   Wed,  8 Mar 2023 17:23:43 +0900
Message-Id: <20230308082352.491561-4-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308082352.491561-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230308082352.491561-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
PCIe host module.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/rcar-gen4-pci-host.yaml      | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
new file mode 100644
index 000000000000..b9ed37217bc4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car Gen4 PCIe Host
+
+maintainers:
+  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
+
+allOf:
+  - $ref: snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: renesas,r8a779f0-pcie   # R-Car S4-8
+      - const: renesas,rcar-gen4-pcie  # R-Car Gen4
+
+  interrupts:
+    maxItems: 4
+
+  interrupt-names:
+    items:
+      - const: msi
+      - const: dma
+      - const: sft_ce
+      - const: app
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  max-link-speed:
+    maximum: 4
+
+  num-lanes:
+    maximum: 4
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a779f0-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a779f0-sysc.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie: pcie@e65d0000 {
+            compatible = "renesas,r8a779f0-pcie", "renesas,rcar-gen4-pcie";
+            reg = <0 0xe65d0000 0 0x3000>, <0 0xe65d3000 0 0x2000>,
+                  <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;
+            reg-names = "dbi", "atu", "app", "config";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            bus-range = <0x00 0xff>;
+            device_type = "pci";
+            ranges =  <0x81000000 0 0x00000000 0 0xfe000000 0 0x00010000
+                       0x82000000 0 0x30000000 0 0x30000000 0 0x10000000>;
+            dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+            interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi", "dma", "sft_ce", "app";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
+                             0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
+                             0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
+                             0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cpg CPG_MOD 624>;
+            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+            resets = <&cpg 624>;
+            num-lanes = <2>;
+            snps,enable-cdm-check;
+            max-link-speed = <2>;
+        };
+    };
-- 
2.25.1

