Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E45838212F
	for <lists+linux-pci@lfdr.de>; Sun, 16 May 2021 23:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhEPV1n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 May 2021 17:27:43 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:57347 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229600AbhEPV1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 May 2021 17:27:42 -0400
Received: from copland.sibelius.xs4all.nl ([83.163.83.176])
        by smtp-cloud8.xs4all.net with ESMTP
        id iOA9lJWwKWkKbiOAJlkPrN; Sun, 16 May 2021 23:19:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1621199951; bh=q2RC92/hLaydTt0okUIaSkxR8QBeVY8t6TyQtHRgv44=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=tQyV6JXw5L3Mr/9g2paWsUvCsIaUyENSlWfzYW5LXkpr+vmrUSc4Ol44CkSJCFrrx
         P2RRhH3MWgUhLQSTvTWVvVH1RvIJfmcnR3WaBgyLVPwBEu9xDZi/BfiJuFU29CLhA+
         SruAHWzW75nX5ZDlT1cjYx7mf6NbP9vpSaEHeGTsV2rIAgTrvWpLDKQR4bzjS8j0ZA
         K0tOx6brcx60Phx74h8r1fnwAXdj3kSyUNpemFvncc8fv7eWyZQsC/R45LpjJWlZ33
         wcEgU/tSgU0drmdq2wSXmXPaWNLrpkhLx1dVWSvimUm8xwBSGXEiUhU/1eMwqvpSC3
         xr2HZ18AUuikQ==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, arnd@arndb.de,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
Date:   Sun, 16 May 2021 23:18:46 +0200
Message-Id: <20210516211851.74921-2-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516211851.74921-1-mark.kettenis@xs4all.nl>
References: <20210516211851.74921-1-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJvxWUUCHehoXYbOzuVATHDHqh8QmGvFtp9FrCC7AWfboWK8mWyaDIsNx1ZhbrOwX3mHxMHf56sutw1oXpqEkwSvMnAyLcPjfFiX08HXD3Kr+a6BiPpC
 /JRPskO7qrAPZuboIAGU+D677hmGtqgneVsQnpoNh2AoEDWMFCRRtchckZ1oa5dw5RjT1fLHSW1Q1fHxWpPxrbTsvvfe+RmKHPavMiDhqJHyv2QfqDiJuWQi
 Dxk4s9vxpfulkho4yAtwTGvvQrU93D4uAkvd7lPIcAH/8ou5vTYLrQOp/INzxEN7t5KEOAJNuuk50EIAqRHymi8pv2YLzQ9YYNjr3GQgldXSPnGWzNtaty8v
 dYxTw1IlFqDupUMltip/NhXXQgt7uxd+nGRQUo1UmgZrbPzooWrnLEPeiWeDEabzNYheAE5gwx+0laglXtVoLlYAOTOq6Iw640D8BaRusdf/nAdwPLRCMD9V
 CdwJpSb81hVFQJvNHFx+DHobgvAQdMQxz6YE3kvk+2B9+26UkotcIT1wnpg=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mark Kettenis <kettenis@openbsd.org>

The Apple PCIe host controller is a PCIe host controller with
multiple root ports present in Apple ARM SoC platforms, including
various iPhone and iPad devices and the "Apple Silicon" Macs.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 .../devicetree/bindings/pci/apple,pcie.yaml   | 150 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
new file mode 100644
index 000000000000..af3c9f64e380
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -0,0 +1,150 @@
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
+    minItems: 4
+    maxItems: 6
+
+  reg-names:
+    minItems: 4
+    maxItems: 7
+    items:
+      - const: ecam
+      - const: rc
+      - const: phy
+      - const: port0
+      - const: port1
+      - const: port2
+
+  ranges:
+    minItems: 2
+    maxItems: 2
+
+  interrupts:
+    minItems: 3
+    maxItems: 3
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
+              <0x6 0x8c000000 0x0 0x4000>,
+              <0x6 0x81000000 0x0 0x8000>,
+              <0x6 0x82000000 0x0 0x8000>,
+              <0x6 0x83000000 0x0 0x8000>;
+        reg-names = "ecam", "rc", "phy", "port0", "port1", "port2";
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
+        iommu-map = <0x0 &dart0 0x8000 0x100>,
+                    <0x100 &dart0 0x100 0x100>,
+                    <0x200 &dart1 0x200 0x100>,
+                    <0x300 &dart2 0x300 0x100>;
+        iommu-map-mask = <0xff00>;
+
+        bus-range = <0 7>;
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

