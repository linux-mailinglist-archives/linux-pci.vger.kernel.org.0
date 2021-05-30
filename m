Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613A7395343
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 00:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhE3WqL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 May 2021 18:46:11 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:49319 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229887AbhE3WqK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 May 2021 18:46:10 -0400
Received: from copland.sibelius.xs4all.nl ([83.163.83.176])
        by smtp-cloud8.xs4all.net with ESMTP
        id nUANlDkLZIpGynUAYlJsI8; Mon, 31 May 2021 00:44:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1622414670; bh=v9Q5Kl1IPoPR/CPYbDRNvSRH30D4ErtWXDUou+JHmZA=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=iTlYLvWGzxsgENk59OlIlDeqov8NK7iJNzryvJo23laTHzemX82SBw2LVQHJSSPj6
         +uX9W1A+2o4VNawg7yD8e0MJDtO9aT4fSZrGAmAXEkdCT7mtgE6rQkyvBewdiLsAFA
         jrKpJ4dLru1mr3lykz8rsOfyyBAp9cIdZawpV0mJzWYMmBglFdpiJJhckq4Zon21L2
         ijS8TxwsRdlbKC61m0yfKSubDAOkN4OqPxh1m43OK9Zb7tRczIaC7TSmzeAOoF0mxw
         4WidljcKdIP0IjpppA1oOPrvyNHj3prAD/jZ/K/uPTpRdcfHDesVUveUZmIIgljG7R
         Wk0/3PoOmQYtw==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, robin.murphy@arm.com,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
Date:   Mon, 31 May 2021 00:44:00 +0200
Message-Id: <20210530224404.95917-2-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210530224404.95917-1-mark.kettenis@xs4all.nl>
References: <20210530224404.95917-1-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDlxk29GONAd/wEOZXSyfcsNUDOTD2ItYv+fnlBWfUwrOtd4qdGOpTM7dlDMflBg0S2276Ppb5TcCo/GdAFqipq6vWxG6qrWkkbjnk57XvXcCRFyufi4
 0QOdjXUAyu/6LpEkAUvgoXeVHRHUwv1zGk9Y3vLKTvn6aaJYjI3IEHQWT4ub3k/NdS8jNDFj2ZzHgG8HPQv3jgS34o0CfMuGzZPrLBZKo4xP4CnyEVlNB49w
 oZkEsrfMgOjxhzLTjXCO/TiB2yEu01bo3sYv20zIp5CLiYRnG2+GniXJGC4nlBL0rbJ/vRAjrftrdtS2RF5DxFr+h6Kl2ETodJZGkVz74dJgfSmhBCmS1o4U
 Maaq4G96fZAHv8D3B53G0daIcmkeWwkHt72nZNT/+mJ0EjKOvjnIZDxakKp35wdbhXfNesyQVrYsZBTZi1TUnAC6U9l036fuXXFfNR6+Nfm7JVrQToufNfSw
 FuPXVOd/+JbvOcP7CYiXp4jtg3niRj9d/g9FeD9XuaE31W09LmO64K/WOTU=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mark Kettenis <kettenis@openbsd.org>

The Apple PCIe host controller is a PCIe host controller with
multiple root ports present in Apple ARM SoC platforms, including
various iPhone and iPad devices and the "Apple Silicon" Macs.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 .../devicetree/bindings/pci/apple,pcie.yaml   | 167 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
new file mode 100644
index 000000000000..62ba3a735140
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -0,0 +1,167 @@
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
+    #include <dt-bindings/pinctrl/apple.h>
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
index 7327c9b778f1..789d79315485 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1654,6 +1654,7 @@ C:	irc://chat.freenode.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/irqchip/irq-apple-aic.c
-- 
2.31.1

