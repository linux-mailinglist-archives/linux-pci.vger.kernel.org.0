Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B787348C0B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 10:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCYJBG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 05:01:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38284 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhCYJAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 05:00:48 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12P90amT101317;
        Thu, 25 Mar 2021 04:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616662836;
        bh=sezG+qEvftRSAB241eU4VJpTNCR8Qd1P+LhmxTQG/HE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SYon1b04KQwlo+oEZNAJeQ5meOP6z0veopPJ2tRxogFOWsvLFB7IM38YN77jdIMd+
         UnscukqrUfcl4AwUfYOficZfJXZNvIIUSJIIm/3cJjawBX9Cp1EF0a4Upo6sCoqmc4
         WtEG1YB6fSe0haRqgasJ5a1cY/AmhHqD/cRyD+wk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12P90ajl053909
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Mar 2021 04:00:36 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 25
 Mar 2021 04:00:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 25 Mar 2021 04:00:36 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12P90Rk8115556;
        Thu, 25 Mar 2021 04:00:32 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 1/6] dt-bindings: PCI: ti,am65: Add PCIe host mode dt-bindings for TI's AM65 SoC
Date:   Thu, 25 Mar 2021 14:30:21 +0530
Message-ID: <20210325090026.8843-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325090026.8843-1-kishon@ti.com>
References: <20210325090026.8843-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe host mode dt-bindings for TI's AM65 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/ti,am65-pci-host.yaml        | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
new file mode 100644
index 000000000000..b77e492886fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI AM65 PCI Host
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,am654-pcie-rc
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: app
+      - const: dbics
+      - const: config
+      - const: atu
+
+  power-domains:
+    maxItems: 1
+
+  ti,syscon-pcie-id:
+    description: Phandle to the SYSCON entry required for getting PCIe device/vendor ID
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  ti,syscon-pcie-mode:
+    description: Phandle to the SYSCON entry required for configuring PCIe in RC or EP mode.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  msi-map: true
+
+  dma-coherent: true
+
+patternProperties:
+  "interrupt-controller":
+    type: object
+    description: interrupt controller to handle legacy interrupts.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - max-link-speed
+  - num-lanes
+  - power-domains
+  - ti,syscon-pcie-id
+  - ti,syscon-pcie-mode
+  - msi-map
+  - ranges
+  - reset-gpios
+  - phys
+  - phy-names
+  - dma-coherent
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie0_rc: pcie@5500000 {
+                compatible = "ti,am654-pcie-rc";
+                reg =  <0x0 0x5500000 0x0 0x1000>,
+                       <0x0 0x5501000 0x0 0x1000>,
+                       <0x0 0x10000000 0x0 0x2000>,
+                       <0x0 0x5506000 0x0 0x1000>;
+                reg-names = "app", "dbics", "config", "atu";
+                power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges = <0x81000000 0 0          0x0 0x10020000 0 0x00010000>,
+                         <0x82000000 0 0x10030000 0x0 0x10030000 0 0x07FD0000>;
+                ti,syscon-pcie-id = <&pcie_devid>;
+                ti,syscon-pcie-mode = <&pcie0_mode>;
+                bus-range = <0x0 0xff>;
+                num-viewport = <16>;
+                max-link-speed = <2>;
+                dma-coherent;
+                interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+                msi-map = <0x0 &gic_its 0x0 0x10000>;
+                #interrupt-cells = <1>;
+                interrupt-map-mask = <0 0 0 7>;
+                interrupt-map = <0 0 0 1 &pcie0_intc 0>, /* INT A */
+                                <0 0 0 2 &pcie0_intc 0>, /* INT B */
+                                <0 0 0 3 &pcie0_intc 0>, /* INT C */
+                                <0 0 0 4 &pcie0_intc 0>; /* INT D */
+
+                pcie0_intc: interrupt-controller {
+                        interrupt-controller;
+                        #interrupt-cells = <1>;
+                        interrupt-parent = <&gic500>;
+                        interrupts = <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>;
+                };
+        };
-- 
2.17.1

