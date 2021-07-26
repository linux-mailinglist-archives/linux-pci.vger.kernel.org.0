Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB9A3D55B2
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jul 2021 10:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhGZHwL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 03:52:11 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:46469 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231728AbhGZHwL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jul 2021 03:52:11 -0400
Received: from copland.sibelius.xs4all.nl ([83.163.83.176])
        by smtp-cloud9.xs4all.net with ESMTP
        id 7w2DmOzH54Jsb7w2QmW9Nr; Mon, 26 Jul 2021 10:32:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1627288358; bh=GWt5LuWPf3oek+gIp/5dyhcc4QQE8RQI7HAJudeIgsw=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=LOumNdCm5LdudnnCecwSz33JKKX1SuZ6ewF7zSDOR7+TzT/8PXSr+wCZlInAYgNwi
         mE7owpgG17hPX3tnU7n6Exkn+LAHtGnQBOVyTMfwGNfCgcCTuezsgOridF3LDE+9R/
         Kp/8AyUoBUFWmZ5gVTgqCr//tS+GM4CZCIlHb10aw8U9+XEWLCVGe9r+OWUzGcghr2
         FKleytXkh8OoBWs2+WYoylICTQwFncFquLX7ENMMA5DhJHwk55tYFHmwEeD2LbIvnH
         L4FIdfK+/35jYiBNpbWHnY7GnJ2PoeU8lgASLjBy1fCZxNACnjsigZG7v2ciT77ZeZ
         RBIcoCp91fdqA==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, robin.murphy@arm.com, sven@svenpeter.dev,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
Date:   Mon, 26 Jul 2021 10:32:00 +0200
Message-Id: <20210726083204.93196-2-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726083204.93196-1-mark.kettenis@xs4all.nl>
References: <20210726083204.93196-1-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfP11OTtA1mcDlQcRvuB1CqGUBdkCQoJMby5ObOd4hsvrK9swzvorSiJRQLGZQiTkvCIUDx8iIj1Flzkh9+sPsNN6Hm48I2rjidwq3IcGbXWRv9OG7ePg
 kEqnUYJXlc471PE8nipHXO/rQ7CBAwPhDaJrWG8sLd2kTT1XMBvZ5b0MFIALxoGsAU7YUoF1lIBd99CTwNSufq++OXrWz9Y0xQ4KDPNUHCwDS5U3ljzb4o3M
 Fy+7dYmawgXiOkZwWO3wYnhgXlZtbhE6iZ0mCFxlBVE221gBQe+2IeP/GyfqKLUEHUHe0ysdxg1w/OO/Kf6+EGN5MuRWupEyTlvA5iXPQBJOJomiyALraQUm
 /+2DCYN1yLuuj4sbr/ZDBnObBoGnPzY/Sl5oaehoY+Iaew6xirLJAlplHcbvfz8Zjn9ctfAK9vxj2u2Vw9qepTunPgaHFdxSkjIN/YO65//lqbH8fOgEu1G5
 wGw/E4oGLJr1rmpGh7t8IXFk6xZNP5iBdaGCj5iIsey8AaFr2vSrrVM4/RQ4UbBvNQ4r6Hqo4kCPR7ZsPS5gsEkwLHBtZ4KpgJ8/hQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mark Kettenis <kettenis@openbsd.org>

The Apple PCIe host controller is a PCIe host controller with
multiple root ports present in Apple ARM SoC platforms, including
various iPhone and iPad devices and the "Apple Silicon" Macs.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 .../devicetree/bindings/pci/apple,pcie.yaml   | 166 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
new file mode 100644
index 000000000000..bfcbdee79c64
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
+      Interrupt specifiers, one for each root port.
+    minItems: 1
+    maxItems: 3
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
index 19135a9d778e..f4aa40d3166e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1694,6 +1694,7 @@ C:	irc://chat.freenode.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/irqchip/irq-apple-aic.c
-- 
2.32.0

