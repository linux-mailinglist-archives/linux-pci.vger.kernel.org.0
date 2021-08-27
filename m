Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B073F9D78
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 19:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhH0RQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 13:16:50 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:55917 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237387AbhH0RQs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 13:16:48 -0400
Received: from cust-df1d398c ([IPv6:fc0c:c1f5:9ac0:c45f:1583:5c5b:91fa:2436])
        by smtp-cloud8.xs4all.net with ESMTPA
        id JfS3mDfw9JWNeJfSPm6c5G; Fri, 27 Aug 2021 19:15:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1630084557; bh=Uz8+b1QNzCpdFU82TySBiAwuag28IbzRbqJyuly6XeQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=KOcTJdPoscNbp+Vy0HL4GjCty++SjNJqWehflgdnYf+I8gtkMiofXtglRQFhoDuQd
         uScYPaKF1V8gcSK2/QKJTuwFQitdrB1RIgKb3FPIuzlxIzjfQiJoK1AftTTlVzBL2U
         hO2DsRpBPXKCCA+lwWXx/TNUnYgv/v1pP8WjD/Dr40Jwlii8J0JmM+rhQYIFo06kaq
         5Gu32ezXupJKnwbuosfH35CAwqcLEFZxTC4T30YEEJhelIS5ThOvYsrXkcFQYjRgIE
         24pK1fU/LeZyfoJJXqz5/u4OaR7VeWi4Ka+ee0XEL1mhj0pHnevxx0kE399YbnwmA+
         7s0chd3pjtIPA==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     alyssa@rosenzweig.io, Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
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
Subject: [PATCH v4 3/4] dt-bindings: pci: Add DT bindings for apple,pcie
Date:   Fri, 27 Aug 2021 19:15:28 +0200
Message-Id: <20210827171534.62380-4-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHUwGkgju7STnLF2OOvJyhiYbu3MW7/VD0w7cOrLxJ4yEZRiqmKcfm7383j1gUCxeQ4buUzHKiFquo0vvpzW8Bblpa5VteOv2zTB7nlHXPBUhXa8hD9j
 jn6reyALKre8dc3VV/vUYM3I8mNz6s483Gjr3v0Fw+0wlNHhwXqppxErEzGEvWdbjaZzXSZdoqjU7ocdG5/LA5xdYaeC4bYLqHGj7G4GWt1w+0lCdVRbXFP4
 pSkURt18WmNq5qaTyvp2YwuVmmtPIPhOMbjw4jarKziy+n1MCafXWRnm9b2cDYyq6QrEcIPq6/wSlOMkba1d0CyIPTOjFwrjs6NLnteLFesvYIQZlYm1hCPV
 ISHtofm1Mqm9OmcnMyaCXxHP/drkEh2XdbfYO/NIQRbU8Aaoizp0u7OG8nM4DbeLX41sdib19faem5WjUOrxizrhLSk+3QvNVMarmsG6jmavhztSCqYSW9Jy
 L7MxTXRoXwqK1S+CpOnYxhgU3nEI4EcHGbIPcXnY0/R9fdB3fPlddzHxv2iJIET0HBaB85D2p02xoFOnfz+oTBGORgDWKiLafVJCDTslvcL4G9wj9T1zXTmB
 mhv5BiRlC+J3CUg2uJg+ExeaOagNZCLGzODQnQb0emSfzZ2VxNKASeBCTwvrFpllHusdLfy1KwlcOhX4brnpmv7S11OeuLph709w8nxmlzfkwXAJtd7f4Etg
 PnnSTtFd47AADSKIX+0lT/6cas3KUHRw4JgcIeoeYoTG+L+PoqVpr8Lz4FRylrzf5AIFo3HxVaxaZQwdn58Q6DYS1ekz346MCuF/1IlviRg0cih52GsgC2m7
 SxoqvEmrI/J6bE/ePWI=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mark Kettenis <kettenis@openbsd.org>

The Apple PCIe host controller is a PCIe host controller with
multiple root ports present in Apple ARM SoC platforms, including
various iPhone and iPad devices and the "Apple Silicon" Macs.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 .../devicetree/bindings/pci/apple,pcie.yaml   | 165 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
new file mode 100644
index 000000000000..97a126db935a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -0,0 +1,165 @@
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
+  - $ref: ../interrupt-controller/msi-controller.yaml#
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
+#  msi-ranges:
+#    description:
+#      A list of pairs <intid span>, where "intid" is the first
+#      interrupt number that can be used as an MSI, and "span" the size
+#      of that range.
+#    $ref: /schemas/types.yaml#/definitions/phandle-array
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
2.32.0

