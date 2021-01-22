Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533BF30061F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 15:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbhAVOxJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 09:53:09 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:15860 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbhAVOxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 09:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611327185; x=1642863185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=DQL2Ra74x0xb0P3WleJ9hVYbtCvbdvs0044RgnpVkos=;
  b=N9jYZwNTcYCz69gJfEG/vxf5FFz17HtNEJNqWnGAIqhUrcxn1z+Pkj7E
   FR+65iz/iqewKN7uGXGJTswLMeXXt9r9R7zDQmENLFtNS6wGqGs2d5bF3
   0zy7DKzwP56t6GGpZVlhDb4vKztKnhD7qUwF4NZCmnmLldaXCgDyIxq8X
   ReJwNzIbWpX3/xLtD1Yqhx99Y56dV+1B/Sde9SpBupJLNJI3M1JQDYRji
   9q53SnyqVW4svKpI+NQO+evUkvvs+q+lNUcvVGiWLw8JAwsuW7JmhEmxP
   Hq/EsXfXhDbvNsCpPdI9by8rvRa9CxA/5MjxomBiaJ2327JwGQeD1gTfG
   A==;
IronPort-SDR: /sWFoEIqNOW2Fge2XYodtJszBWitVjhESZNhIruEVacUeYQ4TYFkR22awRgjkegd5b31c+6lOq
 JwHU7VLAMuIOGzhXhuo/SD0tbujufGo5DK+jKS+6UhxB4h2+T7i1kBlLdkskj4lpXaZFtsucbf
 Ov6KXfH1BNn5a+MHPX2ha4XWtUzpP+tikPjgipninuOHugoblZXsnDBfd6TygHDzfcce/GlCAk
 iTL917QRqrTBHJSRHtsrg35kxoczJBkM9MgFoTa0J6Qyv3a4YcBm2UQm51VanCbPSzJncGnidx
 eeo=
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="112095796"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2021 07:51:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 07:51:49 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 07:51:47 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: [PATCH v20 2/4] dt-bindings: PCI: microchip: Add Microchip PolarFire host binding
Date:   Fri, 22 Jan 2021 14:51:35 +0000
Message-ID: <20210122145137.29023-3-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122145137.29023-1-daire.mcnamara@microchip.com>
References: <20210122145137.29023-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Add device tree bindings for the Microchip PolarFire PCIe controller
when configured in host (Root Complex) mode.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/microchip,pcie-host.yaml     | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
new file mode 100644
index 000000000000..04251d71f56b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/microchip,pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PCIe Root Port Bridge Controller Device Tree Bindings
+
+maintainers:
+  - Daire McNamara <daire.mcnamara@microchip.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: microchip,pcie-host-1.0 # PolarFire
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: apb
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: PCIe host controller
+      - description: builtin MSI controller
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: pcie
+      - const: msi
+
+  ranges:
+    maxItems: 1
+
+  msi-controller:
+    description: Identifies the node as an MSI controller.
+
+  msi-parent:
+    description: MSI controller the device is capable of using.
+
+required:
+  - reg
+  - reg-names
+  - "#interrupt-cells"
+  - interrupts
+  - interrupt-map-mask
+  - interrupt-map
+  - msi-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc {
+            #address-cells = <2>;
+            #size-cells = <2>;
+            pcie0: pcie@2030000000 {
+                    compatible = "microchip,pcie-host-1.0";
+                    reg = <0x0 0x70000000 0x0 0x08000000>,
+                          <0x0 0x43000000 0x0 0x00010000>;
+                    reg-names = "cfg", "apb";
+                    device_type = "pci";
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    #interrupt-cells = <1>;
+                    interrupts = <119>;
+                    interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+                    interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+                                    <0 0 0 2 &pcie_intc0 1>,
+                                    <0 0 0 3 &pcie_intc0 2>,
+                                    <0 0 0 4 &pcie_intc0 3>;
+                    interrupt-parent = <&plic0>;
+                    msi-parent = <&pcie0>;
+                    msi-controller;
+                    bus-range = <0x00 0x7f>;
+                    ranges = <0x03000000 0x0 0x78000000 0x0 0x78000000 0x0 0x04000000>;
+                    pcie_intc0: interrupt-controller {
+                        #address-cells = <0>;
+                        #interrupt-cells = <1>;
+                        interrupt-controller;
+                    };
+            };
+    };
-- 
2.25.1

