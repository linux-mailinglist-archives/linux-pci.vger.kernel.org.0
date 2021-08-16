Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C23ECD0C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 05:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhHPDR0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 23:17:26 -0400
Received: from [138.197.143.207] ([138.197.143.207]:45176 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhHPDRZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 23:17:25 -0400
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
Subject: [PATCH v2 1/6] dt-bindings: pci: Add DT bindings for apple,pcie
Date:   Sun, 15 Aug 2021 23:16:16 -0400
Message-Id: <20210816031621.240268-2-alyssa@rosenzweig.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210816031621.240268-1-alyssa@rosenzweig.io>
References: <20210816031621.240268-1-alyssa@rosenzweig.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mark Kettenis <kettenis@openbsd.org>

The Apple PCIe host controller is a PCIe host controller with
multiple root ports present in Apple ARM SoC platforms, including
various iPhone and iPad devices and the "Apple Silicon" Macs.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 .../devicetree/bindings/pci/apple,pcie.yaml   | 166 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
new file mode 100644
index 000000000000..054f6f069833
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/apple,pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple PCIe host controller
+
+maintainers:
+  - Mark Kettenis <kettenis@openbsd.org>
+
+description: |
+  The Apple PCIe host controller is a PCIe host controller with
+  multiple root ports present in Apple ARM SoC platforms, including
+  various iPhone and iPad devices and the "Apple Silicon" Macs.
+  The controller incorporates Synopsys DesigWare PCIe logic to
+  implements its root ports.  But the ATU found on most DesignWare
+  PCIe host bridges is absent.
+  All root ports share a single ECAM space, but separate GPIOs are
+  used to take the PCI devices on those ports out of reset.  Therefore
+  the standard "reset-gpio" and "max-link-speed" properties appear on
+  the child nodes that represent the PCI bridges that correspond to
+  the individual root ports.
+  MSIs are handled by the PCIe controller and translated into regular
+  interrupts.  A range of 32 MSIs is provided.  These 32 MSIs can be
+  distributed over the root ports as the OS sees fit by programming
+  the PCIe controller's port registers.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: apple,t8103-pcie
+      - const: apple,pcie
+
+  reg:
+    minItems: 3
+    maxItems: 5
+
+  reg-names:
+    minItems: 3
+    maxItems: 5
+    items:
+      - const: config
+      - const: rc
+      - const: port0
+      - const: port1
+      - const: port2
+
+  ranges:
+    minItems: 2
+    maxItems: 2
+
+  interrupts:
+    description:
+      Interrupt specifiers.
+    minItems: 1
+    maxItems: 35
+
+  msi-controller: true
+  msi-parent: true
+
+  msi-ranges:
+    description:
+      A list of pairs <intid span>, where "intid" is the first
+      interrupt number that can be used as an MSI, and "span" the size
+      of that range.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      minItems: 2
+      maxItems: 2
+
+  iommu-map: true
+  iommu-map-mask: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - bus-range
+  - interrupts
+  - msi-controller
+  - msi-parent
+  - msi-ranges
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie0: pcie@690000000 {
+        compatible = "apple,t8103-pcie", "apple,pcie";
+        device_type = "pci";
+
+        reg = <0x6 0x90000000 0x0 0x1000000>,
+              <0x6 0x80000000 0x0 0x4000>,
+              <0x6 0x81000000 0x0 0x8000>,
+              <0x6 0x82000000 0x0 0x8000>,
+              <0x6 0x83000000 0x0 0x8000>;
+        reg-names = "config", "rc", "port0", "port1", "port2";
+
+        interrupt-parent = <&aic>;
+        interrupts = <AIC_IRQ 695 IRQ_TYPE_LEVEL_HIGH>,
+                     <AIC_IRQ 698 IRQ_TYPE_LEVEL_HIGH>,
+                     <AIC_IRQ 701 IRQ_TYPE_LEVEL_HIGH>;
+
+        msi-controller;
+        msi-parent = <&pcie0>;
+        msi-ranges = <704 32>;
+
+        iommu-map = <0x100 &dart0 1 1>,
+                    <0x200 &dart1 1 1>,
+                    <0x300 &dart2 1 1>;
+        iommu-map-mask = <0xff00>;
+
+        bus-range = <0 3>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x43000000 0x6 0xa0000000 0x6 0xa0000000 0x0 0x20000000>,
+                 <0x02000000 0x0 0xc0000000 0x6 0xc0000000 0x0 0x40000000>;
+
+        clocks = <&pcie_core_clk>, <&pcie_aux_clk>, <&pcie_ref_clk>;
+        pinctrl-0 = <&pcie_pins>;
+        pinctrl-names = "default";
+
+        pci@0,0 {
+          device_type = "pci";
+          reg = <0x0 0x0 0x0 0x0 0x0>;
+          reset-gpios = <&pinctrl_ap 152 0>;
+          max-link-speed = <2>;
+
+          #address-cells = <3>;
+          #size-cells = <2>;
+          ranges;
+        };
+
+        pci@1,0 {
+          device_type = "pci";
+          reg = <0x800 0x0 0x0 0x0 0x0>;
+          reset-gpios = <&pinctrl_ap 153 0>;
+          max-link-speed = <2>;
+
+          #address-cells = <3>;
+          #size-cells = <2>;
+          ranges;
+        };
+
+        pci@2,0 {
+          device_type = "pci";
+          reg = <0x1000 0x0 0x0 0x0 0x0>;
+          reset-gpios = <&pinctrl_ap 33 0>;
+          max-link-speed = <1>;
+
+          #address-cells = <3>;
+          #size-cells = <2>;
+          ranges;
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b63403793c81..a5687cf6f925 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1701,6 +1701,7 @@ C:	irc://irc.oftc.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/irqchip/irq-apple-aic.c
-- 
2.30.2

