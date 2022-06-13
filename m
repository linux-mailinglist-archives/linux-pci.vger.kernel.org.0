Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A407B5494E4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386364AbiFMO4S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357922AbiFMOzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 10:55:55 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F960D2470;
        Mon, 13 Jun 2022 04:57:53 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,297,1647270000"; 
   d="scan'208";a="124235797"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Jun 2022 20:57:22 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 12BF24221054;
        Mon, 13 Jun 2022 20:57:22 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/7] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
Date:   Mon, 13 Jun 2022 20:57:07 +0900
Message-Id: <20220613115712.2831386-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
PCIe endpoint module.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../bindings/pci/rcar-gen4-pci-ep.yaml        | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
new file mode 100644
index 000000000000..654efdb3a51e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
@@ -0,0 +1,111 @@
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
+      - const: snps,dw-pcie-ep
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
+    maxItems: 6
+
+  interrupt-names:
+    items:
+      - const: msi
+      - const: err
+      - const: fatal
+      - const: nonfatal
+      - const: lp
+      - const: vndmsg
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: pcie
+      - const: pcie_bus
+
+  num-ib-windows: true
+
+  num-ob-windows: true
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
+  - clock-names
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
+            compatible = "renesas,r8a779f0-pcie-ep", "renesas,rcar-gen4-pcie-ep",
+                         "snps,dw-pcie-ep";
+            reg = <0 0xe65d0000 0 0x1000>, <0 0xe65d1000 0 0x1000>,
+                  <0 0xe65d3000 0 0x2000>, <0 0xfe000000 0 0x400000>;
+            reg-names = "dbi", "atu", "appl", "addr_space";
+            interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi", "err", "fatal", "nonfatal", "lp", "vndmsg";
+            clocks = <&cpg CPG_MOD 624>, <&pcie_bus_clk>;
+            clock-names = "pcie", "pcie_bus";
+            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+            resets = <&cpg 624>;
+            num-lanes = <2>;
+            max-link-speed = <2>;
+            num-ib-windows = <16>;
+            num-ob-windows = <16>;
+        };
+    };
-- 
2.25.1

