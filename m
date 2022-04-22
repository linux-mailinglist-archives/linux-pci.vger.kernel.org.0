Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6161150B6E3
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 14:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447319AbiDVML4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 08:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447310AbiDVMLz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 08:11:55 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E956431;
        Fri, 22 Apr 2022 05:09:01 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 227FD240010;
        Fri, 22 Apr 2022 12:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650629338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pmv2fRcR52A5+9c/lLM+zKkbiFwkoGkYA+wRNOQLibM=;
        b=MFKweBrvIKrvIRdZddkrmJklYpBV/ZW1IsBUE0D7V1NbSrX5Iu0cEiH323p6t8JNtvlrey
        bAboyoksZfG/UfF5b2pdEIIdwvJ/C1tyQd4LGsYpit8z/EYuae1JqwspCDjDSWD5b6t1ta
        Leq10/FYDwIUaBtkSnt58F0TaVFXfEFevylUdcyjjFt7g3Hl4r04Xi7+NhkSuqjEqvxGsw
        eHdl3w52JthKHgq3n1zzT2seaAqsJm+GREAR2D7qv3STQQJfWbnazHoCEueeP1F+BRvY59
        d/xXF6ywg3OvV9+I9izLD1iKNnCQpJ/mIXXyPnvkaA9jFrN49uWHlWRARwencQ==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v3 1/8] dt-bindings: PCI: pci-rcar-gen2: Convert bindings to json-schema
Date:   Fri, 22 Apr 2022 14:08:43 +0200
Message-Id: <20220422120850.769480-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120850.769480-1-herve.codina@bootlin.com>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert Renesas PCI bridge bindings documentation to json-schema.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../devicetree/bindings/pci/pci-rcar-gen2.txt |  84 ----------
 .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 156 ++++++++++++++++++
 2 files changed, 156 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml

diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
deleted file mode 100644
index aeba38f0a387..000000000000
--- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ /dev/null
@@ -1,84 +0,0 @@
-Renesas AHB to PCI bridge
--------------------------
-
-This is the bridge used internally to connect the USB controllers to the
-AHB. There is one bridge instance per USB port connected to the internal
-OHCI and EHCI controllers.
-
-Required properties:
-- compatible: "renesas,pci-r8a7742" for the R8A7742 SoC;
-	      "renesas,pci-r8a7743" for the R8A7743 SoC;
-	      "renesas,pci-r8a7744" for the R8A7744 SoC;
-	      "renesas,pci-r8a7745" for the R8A7745 SoC;
-	      "renesas,pci-r8a7790" for the R8A7790 SoC;
-	      "renesas,pci-r8a7791" for the R8A7791 SoC;
-	      "renesas,pci-r8a7793" for the R8A7793 SoC;
-	      "renesas,pci-r8a7794" for the R8A7794 SoC;
-	      "renesas,pci-rcar-gen2" for a generic R-Car Gen2 or
-				      RZ/G1 compatible device.
-
-
-	      When compatible with the generic version, nodes must list the
-	      SoC-specific version corresponding to the platform first
-	      followed by the generic version.
-
-- reg:	A list of physical regions to access the device: the first is
-	the operational registers for the OHCI/EHCI controllers and the
-	second is for the bridge configuration and control registers.
-- interrupts: interrupt for the device.
-- clocks: The reference to the device clock.
-- bus-range: The PCI bus number range; as this is a single bus, the range
-	     should be specified as the same value twice.
-- #address-cells: must be 3.
-- #size-cells: must be 2.
-- #interrupt-cells: must be 1.
-- interrupt-map: standard property used to define the mapping of the PCI
-  interrupts to the GIC interrupts.
-- interrupt-map-mask: standard property that helps to define the interrupt
-  mapping.
-
-Optional properties:
-- dma-ranges: a single range for the inbound memory region. If not supplied,
-  defaults to 1GiB at 0x40000000. Note there are hardware restrictions on the
-  allowed combinations of address and size.
-
-Example SoC configuration:
-
-	pci0: pci@ee090000  {
-		compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
-		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
-		reg = <0x0 0xee090000 0x0 0xc00>,
-		      <0x0 0xee080000 0x0 0x1100>;
-		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
-
-		bus-range = <0 0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
-		interrupt-map-mask = <0xff00 0 0 0x7>;
-		interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
-				 0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
-				 0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
-
-		usb@1,0 {
-			reg = <0x800 0 0 0 0>;
-			phys = <&usb0 0>;
-			phy-names = "usb";
-		};
-
-		usb@2,0 {
-			reg = <0x1000 0 0 0 0>;
-			phys = <&usb0 0>;
-			phy-names = "usb";
-		};
-	};
-
-Example board setup:
-
-&pci0 {
-	status = "okay";
-	pinctrl-0 = <&usb0_pins>;
-	pinctrl-names = "default";
-};
diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
new file mode 100644
index 000000000000..494eb975c146
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
@@ -0,0 +1,156 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/renesas,pci-rcar-gen2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas AHB to PCI bridge
+
+maintainers:
+  - Marek Vasut <marek.vasut+renesas@gmail.com>
+  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
+
+description: |
+  This is the bridge used internally to connect the USB controllers to the
+  AHB. There is one bridge instance per USB port connected to the internal
+  OHCI and EHCI controllers.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,pci-r8a7742      # RZ/G1H
+              - renesas,pci-r8a7743      # RZ/G1M
+              - renesas,pci-r8a7744      # RZ/G1N
+              - renesas,pci-r8a7745      # RZ/G1E
+              - renesas,pci-r8a7790      # R-Car H2
+              - renesas,pci-r8a7791      # R-Car M2-W
+              - renesas,pci-r8a7793      # R-Car M2-N
+              - renesas,pci-r8a7794      # R-Car E2
+          - const: renesas,pci-rcar-gen2 # R-Car Gen2 and RZ/G1
+
+  reg:
+    items:
+      - description: Operational registers for the OHCI/EHCI controllers.
+      - description: Bridge configuration and control registers.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Device clock
+
+  clock-names:
+    items:
+      - const: pclk
+
+  resets:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  bus-range:
+    description: |
+      The PCI bus number range; as this is a single bus, the range
+      should be specified as the same value twice.
+
+  dma-ranges:
+    description: |
+      A single range for the inbound memory region. If not supplied,
+      defaults to 1GiB at 0x40000000. Note there are hardware restrictions on
+      the allowed combinations of address and size.
+    maxItems: 1
+
+patternProperties:
+  'usb@[0-1],0':
+    type: object
+
+    description:
+      This a USB controller PCI device
+
+    properties:
+      reg:
+        description:
+          Identify the correct bus, device and function number in the
+          form <bdf 0 0 0 0>.
+
+        items:
+          minItems: 5
+          maxItems: 5
+
+      phys:
+        description:
+          Reference to the USB phy
+        maxItems: 1
+
+      phy-names:
+        maxItems: 1
+
+    required:
+      - reg
+      - phys
+      - phy-names
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-map
+  - interrupt-map-mask
+  - clocks
+  - resets
+  - power-domains
+  - bus-range
+  - "#address-cells"
+  - "#size-cells"
+  - "#interrupt-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/r8a7790-cpg-mssr.h>
+    #include <dt-bindings/power/r8a7790-sysc.h>
+
+    pci@ee090000  {
+        compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
+        device_type = "pci";
+        reg = <0xee090000 0xc00>,
+              <0xee080000 0x1100>;
+        clocks = <&cpg CPG_MOD 703>;
+        power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+        resets = <&cpg 703>;
+        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+
+        bus-range = <0 0>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <1>;
+        ranges = <0x02000000 0 0xee080000 0xee080000 0 0x00010000>;
+        dma-ranges = <0x42000000 0 0x40000000 0x40000000 0 0x40000000>;
+        interrupt-map-mask = <0xf800 0 0 0x7>;
+        interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+
+        usb@1,0 {
+            reg = <0x800 0 0 0 0>;
+            phys = <&usb0 0>;
+            phy-names = "usb";
+        };
+
+        usb@2,0 {
+            reg = <0x1000 0 0 0 0>;
+            phys = <&usb0 0>;
+            phy-names = "usb";
+        };
+    };
-- 
2.35.1

