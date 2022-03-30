Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83704EBA24
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 07:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiC3FZb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 01:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbiC3FZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 01:25:29 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50CC915DA8F;
        Tue, 29 Mar 2022 22:23:37 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Mar 2022 14:23:37 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 5FE0F2058B50;
        Wed, 30 Mar 2022 14:23:37 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Mar 2022 14:23:37 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id AB2B9B62B7;
        Wed, 30 Mar 2022 14:23:36 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: uniphier: Convert uniphier-pcie.txt to json-schema
Date:   Wed, 30 Mar 2022 14:23:33 +0900
Message-Id: <1648617814-9217-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648617814-9217-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1648617814-9217-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the file into a JSON description at the yaml format.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/pci/socionext,uniphier-pcie.yaml | 96 +++++++++++++++++++
 .../devicetree/bindings/pci/uniphier-pcie.txt | 82 ----------------
 MAINTAINERS                                   |  2 +-
 3 files changed, 97 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
new file mode 100644
index 000000000000..f5926d0fb085
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/socionext,uniphier-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier PCIe host controller
+
+description: |
+  UniPhier PCIe host controller is based on the Synopsys DesignWare
+  PCI core. It shares common features with the PCIe DesignWare core and
+  inherits common properties defined in
+  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    enum:
+      - socionext,uniphier-pcie
+
+  reg:
+    minItems: 3
+    maxItems: 4
+
+  reg-names:
+    minItems: 3
+    items:
+      - const: dbi
+      - const: link
+      - const: config
+      - const: atu
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  num-viewport: true
+
+  num-lanes: true
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie-phy
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie: pcie@66000000 {
+        compatible = "socionext,uniphier-pcie";
+        reg-names = "dbi", "link", "config";
+        reg = <0x66000000 0x1000>, <0x66010000 0x10000>, <0x2fff0000 0x10000>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        clocks = <&sys_clk 24>;
+        resets = <&sys_rst 24>;
+        num-lanes = <1>;
+        num-viewport = <1>;
+        bus-range = <0x0 0xff>;
+        device_type = "pci";
+        ranges = <0x81000000 0 0x00000000  0x2ffe0000  0 0x00010000>,
+                 <0x82000000 0 0x00000000  0x20000000  0 0x0ffe0000>;
+        phy-names = "pcie-phy";
+        phys = <&pcie_phy>;
+        #interrupt-cells = <1>;
+        interrupt-names = "dma", "msi";
+        interrupts = <0 224 4>, <0 225 4>;
+        interrupt-map-mask = <0 0 0  7>;
+        interrupt-map = <0 0 0  1  &pcie_intc 0>,
+                        <0 0 0  2  &pcie_intc 1>,
+                        <0 0 0  3  &pcie_intc 2>,
+                        <0 0 0  4  &pcie_intc 3>;
+
+        pcie_intc: legacy-interrupt-controller {
+            interrupt-controller;
+            #interrupt-cells = <1>;
+            interrupt-parent = <&gic>;
+            interrupts = <0 226 4>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
deleted file mode 100644
index 359585db049f..000000000000
--- a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-Socionext UniPhier PCIe host controller bindings
-
-This describes the devicetree bindings for PCIe host controller implemented
-on Socionext UniPhier SoCs.
-
-UniPhier PCIe host controller is based on the Synopsys DesignWare PCI core.
-It shares common functions with the PCIe DesignWare core driver and inherits
-common properties defined in
-Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
-
-Required properties:
-- compatible: Should be "socionext,uniphier-pcie".
-- reg: Specifies offset and length of the register set for the device.
-	According to the reg-names, appropriate register sets are required.
-- reg-names: Must include the following entries:
-    "dbi"    - controller configuration registers
-    "link"   - SoC-specific glue layer registers
-    "config" - PCIe configuration space
-    "atu"    - iATU registers for DWC version 4.80 or later
-- clocks: A phandle to the clock gate for PCIe glue layer including
-	the host controller.
-- resets: A phandle to the reset line for PCIe glue layer including
-	the host controller.
-- interrupts: A list of interrupt specifiers. According to the
-	interrupt-names, appropriate interrupts are required.
-- interrupt-names: Must include the following entries:
-    "dma" - DMA interrupt
-    "msi" - MSI interrupt
-
-Optional properties:
-- phys: A phandle to generic PCIe PHY. According to the phy-names, appropriate
-	phys are required.
-- phy-names: Must be "pcie-phy".
-
-Required sub-node:
-- legacy-interrupt-controller: Specifies interrupt controller for legacy PCI
-	interrupts.
-
-Required properties for legacy-interrupt-controller:
-- interrupt-controller: identifies the node as an interrupt controller.
-- #interrupt-cells: specifies the number of cells needed to encode an
-	interrupt source. The value must be 1.
-- interrupt-parent: Phandle to the parent interrupt controller.
-- interrupts: An interrupt specifier for legacy interrupt.
-
-Example:
-
-	pcie: pcie@66000000 {
-		compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
-		status = "disabled";
-		reg-names = "dbi", "link", "config";
-		reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
-		      <0x2fff0000 0x10000>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		clocks = <&sys_clk 24>;
-		resets = <&sys_rst 24>;
-		num-lanes = <1>;
-		num-viewport = <1>;
-		bus-range = <0x0 0xff>;
-		device_type = "pci";
-		ranges =
-		/* downstream I/O */
-			<0x81000000 0 0x00000000  0x2ffe0000  0 0x00010000
-		/* non-prefetchable memory */
-			 0x82000000 0 0x00000000  0x20000000  0 0x0ffe0000>;
-		#interrupt-cells = <1>;
-		interrupt-names = "dma", "msi";
-		interrupts = <0 224 4>, <0 225 4>;
-		interrupt-map-mask = <0 0 0  7>;
-		interrupt-map = <0 0 0  1  &pcie_intc 0>,	/* INTA */
-				<0 0 0  2  &pcie_intc 1>,	/* INTB */
-				<0 0 0  3  &pcie_intc 2>,	/* INTC */
-				<0 0 0  4  &pcie_intc 3>;	/* INTD */
-
-		pcie_intc: legacy-interrupt-controller {
-			interrupt-controller;
-			#interrupt-cells = <1>;
-			interrupt-parent = <&gic>;
-			interrupts = <0 226 4>;
-		};
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 4cc47b2dbdc9..c1d377be991c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15337,7 +15337,7 @@ PCIE DRIVER FOR SOCIONEXT UNIPHIER
 M:	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/uniphier-pcie*
+F:	Documentation/devicetree/bindings/pci/socionext,uniphier-pcie*
 F:	drivers/pci/controller/dwc/pcie-uniphier*
 
 PCIE DRIVER FOR ST SPEAR13XX
-- 
2.25.1

