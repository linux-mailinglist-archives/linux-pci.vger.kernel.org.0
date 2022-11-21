Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47E2632292
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 13:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiKUMoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 07:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKUMoM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 07:44:12 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC192BF833;
        Mon, 21 Nov 2022 04:44:10 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,181,1665414000"; 
   d="scan'208";a="143416640"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Nov 2022 21:44:09 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3C3284923703;
        Mon, 21 Nov 2022 21:44:09 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 2/9] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
Date:   Mon, 21 Nov 2022 21:43:53 +0900
Message-Id: <20221121124400.1282768-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
References: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
PCIe endpoint module.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/rcar-gen4-pci-ep.yaml        | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
new file mode 100644
index 000000000000..4b10d67e4336
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rcar-gen4-pci-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car Gen4 PCIe Endpoint
+
+maintainers:
+  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
+
+allOf:
+  - $ref: snps,dw-pcie-ep.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: renesas,r8a779f0-pcie-ep   # R-Car S4-8
+      - const: renesas,rcar-gen4-pcie-ep  # R-Car Gen4
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: atu
+      - const: appl
+      - const: addr_space
+
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      - const: dma
+      - const: sft_ce
+      - const: app
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  max-link-speed: true
+
+  num-lanes: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - resets
+  - power-domains
+  - clocks
+
+additionalProperties: false
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
+        pcie0_ep: pcie-ep@e65d0000 {
+            compatible = "renesas,r8a779f0-pcie-ep", "renesas,rcar-gen4-pcie-ep";
+            reg = <0 0xe65d0000 0 0x1000>, <0 0xe65d1000 0 0x1000>,
+                  <0 0xe65d3000 0 0x2000>, <0 0xfe000000 0 0x400000>;
+            reg-names = "dbi", "atu", "appl", "addr_space";
+            interrupts = <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "dma", "sft_ce", "app";
+            clocks = <&cpg CPG_MOD 624>;
+            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+            resets = <&cpg 624>;
+            num-lanes = <2>;
+            max-link-speed = <2>;
+        };
+    };
-- 
2.25.1

