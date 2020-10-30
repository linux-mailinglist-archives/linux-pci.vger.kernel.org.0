Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21E29FD33
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 06:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgJ3F3N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 01:29:13 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:54405 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgJ3F3M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2020 01:29:12 -0400
X-IronPort-AV: E=Sophos;i="5.77,432,1596466800"; 
   d="scan'208";a="61230116"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Oct 2020 14:29:11 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 03BB0400F793;
        Fri, 30 Oct 2020 14:29:11 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     bhelgaas@google.com, marek.vasut+renesas@gmail.com,
        robh+dt@kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 1/3] dt-bindings: pci: rcar-pci-host: convert bindings to json-schema
Date:   Fri, 30 Oct 2020 14:29:03 +0900
Message-Id: <1604035745-22095-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604035745-22095-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1604035745-22095-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert Renesas PCIe Host controller bindings documentation to
json-schema. Note that some compatible doesn't contain on
the original documentation so that incremental patches are required
for it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../devicetree/bindings/pci/rcar-pci-host.yaml     | 113 +++++++++++++++++++++
 Documentation/devicetree/bindings/pci/rcar-pci.txt |  72 -------------
 2 files changed, 113 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
new file mode 100644
index 0000000..40c38a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rcar-pci-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car PCIe Host
+
+maintainers:
+  - Marek Vasut <marek.vasut+renesas@gmail.com>
+  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
+
+allOf:
+  - $ref: pci-bus.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,pcie-r8a7742      # RZ/G1H
+              - renesas,pcie-r8a7743      # RZ/G1M
+              - renesas,pcie-r8a7744      # RZ/G1N
+              - renesas,pcie-r8a7790      # R-Car H2
+              - renesas,pcie-r8a7791      # R-Car M2-W
+              - renesas,pcie-r8a7793      # R-Car M2-N
+          - const: renesas,pcie-rcar-gen2 # R-Car Gen2 and RZ/G1
+      - items:
+          - enum:
+              - renesas,pcie-r8a774a1     # RZ/G2M
+              - renesas,pcie-r8a774b1     # RZ/G2N
+              - renesas,pcie-r8a774c0     # RZ/G2E
+              - renesas,pcie-r8a7795      # R-Car H3
+              - renesas,pcie-r8a7796      # R-Car M3-W
+              - renesas,pcie-r8a77961     # R-Car M3-W+
+              - renesas,pcie-r8a77980     # R-Car V3H
+              - renesas,pcie-r8a77990     # R-Car E3
+          - const: renesas,pcie-rcar-gen3 # R-Car Gen3 and RZ/G2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 3
+    maxItems: 3
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: pcie
+      - const: pcie_bus
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7791-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a7791-sysc.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie: pcie@fe000000 {
+            compatible = "renesas,pcie-r8a7791", "renesas,pcie-rcar-gen2";
+            reg = <0 0xfe000000 0 0x80000>;
+             #address-cells = <3>;
+             #size-cells = <2>;
+             bus-range = <0x00 0xff>;
+             device_type = "pci";
+             ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000>,
+                      <0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000>,
+                      <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>,
+                      <0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+             dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>,
+                          <0x42000000 2 0x00000000 2 0x00000000 0 0x40000000>;
+             interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+                          <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+                          <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+             #interrupt-cells = <1>;
+             interrupt-map-mask = <0 0 0 0>;
+             interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+             clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
+             clock-names = "pcie", "pcie_bus";
+             power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+             resets = <&cpg 319>;
+         };
+    };
diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
deleted file mode 100644
index 14d307d..0000000
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-* Renesas R-Car PCIe interface
-
-Required properties:
-compatible: "renesas,pcie-r8a7742" for the R8A7742 SoC;
-	    "renesas,pcie-r8a7743" for the R8A7743 SoC;
-	    "renesas,pcie-r8a7744" for the R8A7744 SoC;
-	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
-	    "renesas,pcie-r8a774b1" for the R8A774B1 SoC;
-	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
-	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
-	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
-	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
-	    "renesas,pcie-r8a7793" for the R8A7793 SoC;
-	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
-	    "renesas,pcie-r8a7796" for the R8A77960 SoC;
-	    "renesas,pcie-r8a77961" for the R8A77961 SoC;
-	    "renesas,pcie-r8a77980" for the R8A77980 SoC;
-	    "renesas,pcie-r8a77990" for the R8A77990 SoC;
-	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
-				     RZ/G1 compatible device.
-	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 or
-				     RZ/G2 compatible device.
-
-	    When compatible with the generic version, nodes must list the
-	    SoC-specific version corresponding to the platform first
-	    followed by the generic version.
-
-- reg: base address and length of the PCIe controller registers.
-- #address-cells: set to <3>
-- #size-cells: set to <2>
-- bus-range: PCI bus numbers covered
-- device_type: set to "pci"
-- ranges: ranges for the PCI memory and I/O regions.
-- dma-ranges: ranges for the inbound memory regions.
-- interrupts: two interrupt sources for MSI interrupts, followed by interrupt
-	source for hardware related interrupts (e.g. link speed change).
-- #interrupt-cells: set to <1>
-- interrupt-map-mask and interrupt-map: standard PCI properties
-	to define the mapping of the PCIe interface to interrupt numbers.
-- clocks: from common clock binding: clock specifiers for the PCIe controller
-	and PCIe bus clocks.
-- clock-names: from common clock binding: should be "pcie" and "pcie_bus".
-
-Optional properties:
-- phys: from common PHY binding: PHY phandle and specifier (only make sense
-	for R-Car gen3 SoCs where the PCIe PHYs have their own register blocks).
-- phy-names: from common PHY binding: should be "pcie".
-
-Example:
-
-SoC-specific DT Entry:
-
-	pcie: pcie@fe000000 {
-		compatible = "renesas,pcie-r8a7791", "renesas,pcie-rcar-gen2";
-		reg = <0 0xfe000000 0 0x80000>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		bus-range = <0x00 0xff>;
-		device_type = "pci";
-		ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
-			  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
-			  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
-			  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
-		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000
-			      0x42000000 2 0x00000000 2 0x00000000 0 0x40000000>;
-		interrupts = <0 116 4>, <0 117 4>, <0 118 4>;
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 116 4>;
-		clocks = <&mstp3_clks R8A7791_CLK_PCIE>, <&pcie_bus_clk>;
-		clock-names = "pcie", "pcie_bus";
-	};
-- 
2.7.4

