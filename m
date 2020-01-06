Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB813104A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 11:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgAFKTx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 05:19:53 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53656 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgAFKTv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2020 05:19:51 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 006AJdAa107792;
        Mon, 6 Jan 2020 04:19:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578305979;
        bh=LO0DOsSmW/AZAnbIqgXvjwZLf7AGxV3dInnxBKX12bI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=B6Uir64zb+xhpafMHLQYhphdmAB1JkYehv8YlGzDu8/0eINAeY8pAtZzj3o3JvZgP
         K9S53pl3mF9kdUtnhUnhS7ta64iGqDmqZ4s0gPwwX8DdwthUKURNavCF3TebX0WrD0
         c9zjux4Jcq6EmypkDvdTEsHlcbzKJqSB9V4itCcc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 006AJdM7039946
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jan 2020 04:19:39 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 04:19:39 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 04:19:39 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006AIqY2118652;
        Mon, 6 Jan 2020 04:19:35 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 10/14] dt-bindings: PCI: Add host mode dt-bindings for TI's J721E SoC
Date:   Mon, 6 Jan 2020 15:50:54 +0530
Message-ID: <20200106102058.19183-11-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106102058.19183-1-kishon@ti.com>
References: <20200106102058.19183-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add host mode dt-bindings for TI's J721E SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/ti,j721e-pci-host.yaml       | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
new file mode 100644
index 000000000000..b78228ca0452
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/ti,j721e-pci-host.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI J721E PCI Host (PCIe Wrapper)
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+allOf:
+  - $ref: "cdns-pcie-host.yaml#"
+
+properties:
+  compatible:
+      enum:
+        - ti,j721e-pcie-host
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: intd_cfg
+      - const: user_cfg
+      - const: reg
+      - const: cfg
+
+  ti,syscon-pcie-ctrl:
+    description: Phandle to the SYSCON entry required for configuring PCIe mode
+      and link speed.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: clock-specifier to represent input to the PCIe
+
+  clock-names:
+    items:
+      - const: fck
+
+  vendor-id:
+    const: 0x104c
+
+  device-id:
+    const: 0xb00d
+
+  msi-map: true
+
+  dma-coherent:
+    description: Indicates that the PCIe IP block can ensure the coherency
+
+  ranges:
+    maxItems: 2
+
+  reset-gpios:
+    description: GPIO specifier for the PERST# signal
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - ti,syscon-pcie-ctrl
+  - max-link-speed
+  - num-lanes
+  - power-domains
+  - clocks
+  - clock-names
+  - cdns,max-outbound-regions
+  - cdns,no-bar-match-nbits
+  - vendor-id
+  - device-id
+  - msi-map
+  - dma-coherent
+  - ranges
+  - reset-gpios
+  - phys
+  - phy-names
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    pcie0_rc: pcie@2900000 {
+            compatible = "ti,j721e-pcie-host";
+            reg = <0x00 0x02900000 0x00 0x1000>,
+                  <0x00 0x02907000 0x00 0x400>,
+                  <0x00 0x0d000000 0x00 0x00800000>,
+                  <0x00 0x10000000 0x00 0x00001000>;
+            reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+            ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
+            max-link-speed = <3>;
+            num-lanes = <2>;
+            power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
+            clocks = <&k3_clks 239 1>;
+            clock-names = "fck";
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            bus-range = <0x0 0xf>;
+            cdns,max-outbound-regions = <16>;
+            cdns,no-bar-match-nbits = <64>;
+            vendor-id = /bits/ 16 <0x104c>;
+            device-id = /bits/ 16 <0xb00d>;
+            msi-map = <0x0 &gic_its 0x0 0x10000>;
+            dma-coherent;
+            reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
+            phys = <&serdes0_pcie_link>;
+            phy-names = "pcie_phy";
+            ranges = <0x01000000 0x0 0x10001000  0x00 0x10001000  0x0 0x0010000>,
+                     <0x02000000 0x0 0x10011000  0x00 0x10011000  0x0 0x7fef000>;
+    };
-- 
2.17.1

