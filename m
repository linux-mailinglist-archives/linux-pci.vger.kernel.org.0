Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5B73EC752
	for <lists+linux-pci@lfdr.de>; Sun, 15 Aug 2021 06:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhHOEfG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 00:35:06 -0400
Received: from [138.197.143.207] ([138.197.143.207]:44970 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbhHOEfG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 00:35:06 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] dt-bindings: PCI: Add Apple PCI controller
Date:   Sun, 15 Aug 2021 00:25:24 -0400
Message-Id: <20210815042525.36878-2-alyssa@rosenzweig.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210815042525.36878-1-alyssa@rosenzweig.io>
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the properties used by the Apple PCI controller. This is a
fairly standard PCI controller, although it is not derived from any
known non-Apple IP.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 .../devicetree/bindings/pci/apple,pcie.yaml   | 153 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 159 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
new file mode 100644
index 000000000000..4378f5a05804
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/apple,pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SoC PCIe Controller Device Tree Bindings
+
+maintainers:
+  - Alyssa Rosenzweig <alyssa@rosenzweig.io>
+
+description: |+
+  Apple SoC PCIe host controller.
+
+allOf:
+ - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: apple,pcie
+
+  reg:
+    items:
+      - description: PCIe configuration region.
+      - description: Core registers.
+      - description: AXI bridge registers.
+      - description: Port 0 (radio) registers.
+      - description: Port 1 (USB) registers.
+      - description: Port 2 (Ethernet) registers.
+
+  reg-names:
+    items:
+      - const: config
+      - const: rc
+      - const: phy
+      - const: port0
+      - const: port1
+      - const: port2
+
+  interrupts:
+    maxItems: 35
+
+  msi-controller:
+    description: Identifies the node as an MSI controller.
+
+  msi-parent:
+    description: MSI controller the device is capable of using.
+
+  reset-gpios:
+    description: Reset lines for each of the ports of the controller.
+
+  pinctrl-0:
+    description: Pin controller for the reset lines.
+
+  pinctrl-names:
+    description: Names for the pin controller.
+
+required:
+  - reg
+  - reg-names
+  - interrupt-parent
+  - interrupts
+  - msi-controller
+  - msi-parent
+  - msi-interrupts
+  - iommu-map
+  - iommu-map-mask
+  - pinctrl-0
+  - pinctrl-names
+  - reset-gpios
+  - bus-range
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - device_type
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie0: pcie@690000000 {
+       	    compatible = "apple,pcie";
+       	    reg = <0x6 0x90000000 0x0 0x1000000>,
+       	          <0x6 0x80000000 0x0 0x100000>,
+       	          <0x6 0x8c000000 0x0 0x100000>,
+       	          <0x6 0x81000000 0x0 0x4000>,
+       	          <0x6 0x82000000 0x0 0x4000>,
+       	          <0x6 0x83000000 0x0 0x4000>;
+       	    reg-names = "config", "rc", "phy", "port0",
+       	    	    "port1", "port2";
+       	    interrupt-parent = <&aic>;
+       	    interrupts = <AIC_IRQ 695 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 698 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 701 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 704 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 705 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 706 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 707 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 708 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 709 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 710 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 711 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 712 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 713 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 714 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 715 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 716 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 717 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 718 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 719 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 720 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 721 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 722 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 723 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 724 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 725 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 726 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 727 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 728 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 729 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 730 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 731 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 732 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 733 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 734 IRQ_TYPE_LEVEL_HIGH>,
+       	    	     <AIC_IRQ 735 IRQ_TYPE_LEVEL_HIGH>;
+       	    msi-controller;
+       	    msi-parent = <&pcie0>;
+       	    msi-interrupts = <704 32>;
+       	    iommu-map = <0x100 &pcie0_dart_0 0 1>,
+       	    	    <0x200 &pcie0_dart_1 0 1>,
+       	    	    <0x300 &pcie0_dart_2 0 1>;
+       	    iommu-map-mask = <0xff00>;
+       	    pinctrl-0 = <&pcie_pins>;
+       	    pinctrl-names = "default";
+       	    reset-gpios = <&gpio 152 0   &gpio 153 0   &gpio 33 0>;
+       	    bus-range = <0 15>;
+       	    #address-cells = <3>;
+       	    #size-cells = <2>;
+       	    ranges = <0x43000000 0x6 0xa0000000 0x6 0xa0000000
+       	    	  0x0 0x20000000>,
+       	    	 <0x02000000 0x0 0xc0000000 0x6 0xc0000000
+       	    	  0x0 0x40000000>;
+       	    device_type = "pci";
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index b63403793c81..d7d2e1d1e2f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1269,6 +1269,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
 F:	drivers/iommu/apple-dart.c
 
+APPLE PCIE CONTROLLER DRIVER
+M:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
+
 APPLE SMC DRIVER
 M:	Henrik Rydberg <rydberg@bitmath.org>
 L:	linux-hwmon@vger.kernel.org
-- 
2.30.2

