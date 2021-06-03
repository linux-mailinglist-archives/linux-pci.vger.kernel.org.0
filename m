Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF9E39A248
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 15:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhFCNgz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 09:36:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41972 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhFCNgz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jun 2021 09:36:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153DZ2oo078148;
        Thu, 3 Jun 2021 08:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622727302;
        bh=Mst8RBjpnijyT3+s7IUmhOfazu1+hFrl814VF8Y7N5I=;
        h=From:To:CC:Subject:Date;
        b=rqr5MQ992SKyun1vyfHdyg/qQJN+Rxb9o+wkN4OGg08RGO9G9cHLc141gX0029aFG
         UDI/5qv/BfYFn7Idv1KK+Y1pNW4ZpmiYjCQHcZfZ4DpSRFpqhdVLBgRlIVzoQMrzE/
         YHDu/NwMp0PHWha2KBLqJjh5UU1cI7RSpTwPKvAU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153DZ2wD009399
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 08:35:02 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 08:35:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 08:35:01 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153DYqFp083353;
        Thu, 3 Jun 2021 08:34:53 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: PCI: ti,am65: Convert PCIe host/endpoint mode dt-bindings to YAML
Date:   Thu, 3 Jun 2021 19:04:50 +0530
Message-ID: <20210603133450.24710-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert PCIe host/endpoint mode dt-bindings for TI's AM65/Keystone SoC
to YAML binding.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from v1:
1) Removed '"' for the included schemas
2) Used default #address-cells and #size-cells for the example

 .../devicetree/bindings/pci/pci-keystone.txt  | 115 ------------------
 .../bindings/pci/ti,am65-pci-ep.yaml          |  74 +++++++++++
 .../bindings/pci/ti,am65-pci-host.yaml        |  96 +++++++++++++++
 3 files changed, 170 insertions(+), 115 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-keystone.txt
 create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
deleted file mode 100644
index 47202a2938f2..000000000000
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ /dev/null
@@ -1,115 +0,0 @@
-TI Keystone PCIe interface
-
-Keystone PCI host Controller is based on the Synopsys DesignWare PCI
-hardware version 3.65.  It shares common functions with the PCIe DesignWare
-core driver and inherits common properties defined in
-Documentation/devicetree/bindings/pci/designware-pcie.txt
-
-Please refer to Documentation/devicetree/bindings/pci/designware-pcie.txt
-for the details of DesignWare DT bindings.  Additional properties are
-described here as well as properties that are not applicable.
-
-Required Properties:-
-
-compatibility: Should be "ti,keystone-pcie" for RC on Keystone2 SoC
-	       Should be "ti,am654-pcie-rc" for RC on AM654x SoC
-reg: Three register ranges as listed in the reg-names property
-reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
-	   TI specific application registers, "config" for the
-	   configuration space address
-
-pcie_msi_intc : Interrupt controller device node for MSI IRQ chip
-	interrupt-cells: should be set to 1
-	interrupts: GIC interrupt lines connected to PCI MSI interrupt lines
-	(required if the compatible is "ti,keystone-pcie")
-msi-map: As specified in Documentation/devicetree/bindings/pci/pci-msi.txt
-	 (required if the compatible is "ti,am654-pcie-rc".
-
-ti,syscon-pcie-id : phandle to the device control module required to set device
-		    id and vendor id.
-ti,syscon-pcie-mode : phandle to the device control module required to configure
-		      PCI in either RC mode or EP mode.
-
- Example:
-	pcie_msi_intc: msi-interrupt-controller {
-			interrupt-controller;
-			#interrupt-cells = <1>;
-			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 32 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 33 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 37 IRQ_TYPE_EDGE_RISING>;
-	};
-
-pcie_intc: Interrupt controller device node for Legacy IRQ chip
-	interrupt-cells: should be set to 1
-
- Example:
-	pcie_intc: legacy-interrupt-controller {
-		interrupt-controller;
-		#interrupt-cells = <1>;
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>,
-			<GIC_SPI 27 IRQ_TYPE_EDGE_RISING>,
-			<GIC_SPI 28 IRQ_TYPE_EDGE_RISING>,
-			<GIC_SPI 29 IRQ_TYPE_EDGE_RISING>;
-	};
-
-Optional properties:-
-	phys: phandle to generic Keystone SerDes PHY for PCI
-	phy-names: name of the generic Keystone SerDes PHY for PCI
-	  - If boot loader already does PCI link establishment, then phys and
-	    phy-names shouldn't be present.
-	interrupts: platform interrupt for error interrupts.
-
-DesignWare DT Properties not applicable for Keystone PCI
-
-1. pcie_bus clock-names not used.  Instead, a phandle to phys is used.
-
-AM654 PCIe Endpoint
-===================
-
-Required Properties:-
-
-compatibility: Should be "ti,am654-pcie-ep" for EP on AM654x SoC
-reg: Four register ranges as listed in the reg-names property
-reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
-	   TI specific application registers, "atu" for the
-	   Address Translation Unit configuration registers and
-	   "addr_space" used to map remote RC address space
-num-ib-windows: As specified in
-		Documentation/devicetree/bindings/pci/designware-pcie.txt
-num-ob-windows: As specified in
-		Documentation/devicetree/bindings/pci/designware-pcie.txt
-num-lanes: As specified in
-	   Documentation/devicetree/bindings/pci/designware-pcie.txt
-power-domains: As documented by the generic PM domain bindings in
-	       Documentation/devicetree/bindings/power/power_domain.txt.
-ti,syscon-pcie-mode: phandle to the device control module required to configure
-		      PCI in either RC mode or EP mode.
-
-Optional properties:-
-
-phys: list of PHY specifiers (used by generic PHY framework)
-phy-names: must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
-               number of lanes as specified in *num-lanes* property.
-("phys" and "phy-names" DT bindings are specified in
-Documentation/devicetree/bindings/phy/phy-bindings.txt)
-interrupts: platform interrupt for error interrupts.
-
-pcie-ep {
-	compatible = "ti,am654-pcie-ep";
-	reg =  <0x5500000 0x1000>, <0x5501000 0x1000>,
-	       <0x10000000 0x8000000>, <0x5506000 0x1000>;
-	reg-names = "app", "dbics", "addr_space", "atu";
-	power-domains = <&k3_pds 120>;
-	ti,syscon-pcie-mode = <&pcie0_mode>;
-	num-lanes = <1>;
-	num-ib-windows = <16>;
-	num-ob-windows = <16>;
-	interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
-};
diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
new file mode 100644
index 000000000000..78c217d362a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/ti,am65-pci-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI AM65 PCI Endpoint
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+allOf:
+  - $ref: pci-ep.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,am654-pcie-ep
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: app
+      - const: dbics
+      - const: addr_space
+      - const: atu
+
+  power-domains:
+    maxItems: 1
+
+  ti,syscon-pcie-mode:
+    description: Phandle to the SYSCON entry required for configuring PCIe in RC or EP mode.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  interrupts:
+    minItems: 1
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - max-link-speed
+  - power-domains
+  - ti,syscon-pcie-mode
+  - dma-coherent
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    pcie0_ep: pcie-ep@5500000 {
+        compatible = "ti,am654-pcie-ep";
+        reg =  <0x5500000 0x1000>,
+               <0x5501000 0x1000>,
+               <0x10000000 0x8000000>,
+               <0x5506000 0x1000>;
+        reg-names = "app", "dbics", "addr_space", "atu";
+        power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
+        ti,syscon-pcie-mode = <&pcie0_mode>;
+        num-ib-windows = <16>;
+        num-ob-windows = <16>;
+        max-link-speed = <2>;
+        dma-coherent;
+        interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+    };
diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
new file mode 100644
index 000000000000..834dc1c1743c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
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
+      - ti,keystone-pcie
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
+required:
+  - compatible
+  - reg
+  - reg-names
+  - max-link-speed
+  - ti,syscon-pcie-id
+  - ti,syscon-pcie-mode
+  - ranges
+
+if:
+  properties:
+    compatible:
+      enum:
+        - ti,am654-pcie-rc
+then:
+  required:
+    - dma-coherent
+    - power-domains
+    - msi-map
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    pcie0_rc: pcie@5500000 {
+        compatible = "ti,am654-pcie-rc";
+        reg =  <0x5500000 0x1000>,
+               <0x5501000 0x1000>,
+               <0x10000000 0x2000>,
+               <0x5506000 0x1000>;
+        reg-names = "app", "dbics", "config", "atu";
+        power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x81000000 0 0          0x10020000 0 0x00010000>,
+                 <0x82000000 0 0x10030000 0x10030000 0 0x07FD0000>;
+        ti,syscon-pcie-id = <&pcie_devid>;
+        ti,syscon-pcie-mode = <&pcie0_mode>;
+        bus-range = <0x0 0xff>;
+        num-viewport = <16>;
+        max-link-speed = <2>;
+        dma-coherent;
+        interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+        msi-map = <0x0 &gic_its 0x0 0x10000>;
+        device_type = "pci";
+    };
-- 
2.17.1

