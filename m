Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 422D211692E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 10:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLIJVU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 04:21:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49950 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfLIJVT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 04:21:19 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB99LCe6080946;
        Mon, 9 Dec 2019 03:21:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575883272;
        bh=YobrPQ65XL9eRBwZXhJ3WyYimyOjvLKJGFnM3tEfmto=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XotwPxFcTCJ+IQk3kLoL1x6tP2aCnh35v9/evsXiBBpMO53mriTy6h/QESs6ybOw3
         6gsGvsyXSPXk2skQt97w28lsZKSHJpXBmhS2PpGhl/Ks9Zn4a59hLT3yYmOEYqr7Nk
         ecBg+wwoZkbFxO6a6xcJovjv2wf0HVWNHz+ciLa0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB99LCeB005933
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 03:21:12 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 03:21:12 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 03:21:12 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB99Kcd7087697;
        Mon, 9 Dec 2019 03:21:09 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 09/13] dt-bindings: PCI: Add host mode dt-bindings for TI's J721E SoC
Date:   Mon, 9 Dec 2019 14:51:43 +0530
Message-ID: <20191209092147.22901-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209092147.22901-1-kishon@ti.com>
References: <20191209092147.22901-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add host mode dt-bindings for TI's J721E SoC.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/ti,j721e-pci-host.yaml       | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
new file mode 100644
index 000000000000..96184e1f419f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -0,0 +1,161 @@
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
+properties:
+  compatible:
+      enum:
+          - ti,j721e-pcie-host
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
+                 and link speed.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  max-link-speed:
+    minimum: 1
+    maximum: 3
+
+  num-lanes:
+    minimum: 1
+    maximum: 2
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
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
+
+  bus-range:
+    description: Range of bus numbers associated with this controller.
+
+  cdns,max-outbound-regions:
+    description: As defined in
+                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/int32
+      - enum: [16]
+
+  cdns,no-bar-match-nbits:
+    description: As defined in
+                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/int32
+      - enum: [64]
+
+  vendor-id:
+    const: 0x104c
+    description: As defined in
+                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+
+  device-id:
+    const: 0xb00d
+    description: As defined in
+                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+
+  msi-map: true
+
+  dma-coherent:
+    description: Indicates that the PCIe IP block can ensure the coherency
+
+  ranges: true
+
+  reset-gpios:
+    description: GPIO specifier for the PERST# signal
+
+  phys:
+    description: As defined in
+                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+
+  phy-names:
+    description: As defined in
+                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
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
+  - "#address-cells"
+  - "#size-cells"
+  - bus-range
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

