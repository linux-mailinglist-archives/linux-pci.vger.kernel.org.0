Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3B9413A35
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 20:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhIUSnh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 14:43:37 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:36409 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233592AbhIUSng (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 14:43:36 -0400
Received: from cust-df1d398c ([IPv6:fc0c:c1f5:9ac0:c45f:1583:5c5b:91fa:2436])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Skb8mlMr9pQdWSkbVmYt60; Tue, 21 Sep 2021 20:34:53 +0200
From:   Mark Kettenis <kettenis@openbsd.org>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, robin.murphy@arm.com, sven@svenpeter.dev,
        alyssa@rosenzweig.io, Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v5 3/4] dt-bindings: pci: Add DT bindings for apple,pcie
Date:   Tue, 21 Sep 2021 20:34:14 +0200
Message-Id: <20210921183420.436-4-kettenis@openbsd.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921183420.436-1-kettenis@openbsd.org>
References: <20210921183420.436-1-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOLUNauYebB14EKfYCcbtG7mcDuU16KBc//0aV3bOFb2jgIgXgskJmIcM2nFmWXZ/SOzVeFKGkQlulOTpX+CRgTIb97aEZi6Yz0xPD9zFnFpFp25ltSt
 4osBgFMz/+r4zu8dfOxgL7+Pvjt1Pt2JL0ggeCcuPZ4Maksaj6UyiNh19CDQu5duRqBPiwr2L3S/KyM5L4leI88jcIzh80902pYaN/7UkKAPUERiMJzA/CiL
 4NXjFjjYzWAYRyo/UQi1JffDojcUbjqPYxS5t6xUzOPmDeMEs4ew1BE9exe7E9ZkgNv0vmT+3w/pC8W75M0XnEoGH09ARjcnNggWnmHRbu/lnc2K9jU2Jw7X
 HXA89zy000nXDT3wsPBFoTZHJFuVgbHz6fvpHnm7yZC4BrfMm0q76mV/WZRr6n4SRU/HFE7hW+7wZs89dSv8O5a21FB7Zg+xTyAwXgvbY3vvKsmCTUvcjSK/
 GWFyg+ms18hjCac2W7N9kDe6ZqzJRF8l6OO1d00izgu8E2pwj7hDLvjugGp/GKMPSNB9R3A1eTYHJ05/XQmAbj8Hh2OxIQaHzeD5kZLOE4FfkrEwZUcal9Yk
 s/QNYMQnHYkXKqfgxiwhANJMyl5om+s08NyzE6/MkvXQnO4WWaZnoV6wDhGvgKYquMgsdPcXsDaawGE7LLJ30wTbzhuDLU1XpofAqiLci+kXsqj6yqPI68si
 fqPgzRB0HybBJmB33lFgxjfityA/LzXw2jvjxpkfjhNg4pkYvxsq39G1oNiBa74SswNLyDd6K+Jg+NqdHMQFbCLEzlNHT9kSJA8rl+bmurSufNLajdyNJeVl
 AzkB5MSfA5rV7AOhn+9FNUCBQ6QQQvHqxTGzDMwy+0UjhxA4jRsgx1/kellpzA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Apple PCIe host controller is a PCIe host controller with
multiple root ports present in Apple ARM SoC platforms, including
various iPhone and iPad devices and the "Apple Silicon" Macs.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 .../devicetree/bindings/pci/apple,pcie.yaml   | 161 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
new file mode 100644
index 000000000000..f17a8fe39e6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -0,0 +1,161 @@
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
+
+  All root ports share a single ECAM space, but separate GPIOs are
+  used to take the PCI devices on those ports out of reset.  Therefore
+  the standard "reset-gpios" and "max-link-speed" properties appear on
+  the child nodes that represent the PCI bridges that correspond to
+  the individual root ports.
+
+  MSIs are handled by the PCIe controller and translated into regular
+  interrupts.  A range of 32 MSIs is provided.  These 32 MSIs can be
+  distributed over the root ports as the OS sees fit by programming
+  the PCIe controller's port registers.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
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
+  msi-parent: true
+
+  msi-ranges:
+    maxItems: 1
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
+              <0x6 0x80000000 0x0 0x100000>,
+              <0x6 0x81000000 0x0 0x4000>,
+              <0x6 0x82000000 0x0 0x4000>,
+              <0x6 0x83000000 0x0 0x4000>;
+        reg-names = "config", "rc", "port0", "port1", "port2";
+
+        interrupt-parent = <&aic>;
+        interrupts = <AIC_IRQ 695 IRQ_TYPE_LEVEL_HIGH>,
+                     <AIC_IRQ 698 IRQ_TYPE_LEVEL_HIGH>,
+                     <AIC_IRQ 701 IRQ_TYPE_LEVEL_HIGH>;
+
+        msi-controller;
+        msi-parent = <&pcie0>;
+        msi-ranges = <&aic AIC_IRQ 704 IRQ_TYPE_EDGE_RISING 32>;
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
+        power-domains = <&ps_apcie>, <&ps_apcie_gp>, <&ps_pcie_ref>;
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
index c6b8a720c0bc..30bea4042e7e 100644
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
2.33.0

