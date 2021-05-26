Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026CD39192C
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhEZNsx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 09:48:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57698 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhEZNsx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 09:48:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QDlG1D035324;
        Wed, 26 May 2021 08:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622036836;
        bh=d0jC/OySiRsngPle8BzJUIQHlPf9fjVAmZwBHLhGfXQ=;
        h=From:To:CC:Subject:Date;
        b=waBAgyHjlMIp/g6rbWIO+n2UQMb83oR+D+CUTlkFOPD3lSYwiPsORG1BDim3zyND9
         XfAZFQy7xzMusr28BQ/AmXHxk023m2a/JUdJMUFFRIiLOOumUA+H0A4JM0fIFi5FJE
         3+mlHOHASBHKmbbizPJyYrLB7i1boAcl89kvB9ag=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QDlG3F097710
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 08:47:16 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 08:47:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 08:47:16 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QDl9OK081128;
        Wed, 26 May 2021 08:47:10 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] dt-bindings: PCI: ti,am65: Convert PCIe host/endpoint mode dt-bindings to YAML
Date:   Wed, 26 May 2021 19:17:08 +0530
Message-ID: <20210526134708.27887-1-kishon@ti.com>
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
 .../devicetree/bindings/pci/pci-keystone.txt  | 115 ------------------
 .../bindings/pci/ti,am65-pci-ep.yaml          |  80 ++++++++++++
 .../bindings/pci/ti,am65-pci-host.yaml        | 105 ++++++++++++++++
 3 files changed, 185 insertions(+), 115 deletions(-)
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
index 000000000000..419d48528105
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/ti,am65-pci-ep.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI AM65 PCI Endpoint
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+allOf:
+  - $ref: "pci-ep.yaml#"
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
+    #include <dt-bindings/gpio/gpio.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie0_ep: pcie-ep@5500000 {
+                compatible = "ti,am654-pcie-ep";
+                reg =  <0x0 0x5500000 0x0 0x1000>,
+                       <0x0 0x5501000 0x0 0x1000>,
+                       <0x0 0x10000000 0x0 0x8000000>,
+                       <0x0 0x5506000 0x0 0x1000>;
+                reg-names = "app", "dbics", "addr_space", "atu";
+                power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
+                ti,syscon-pcie-mode = <&pcie0_mode>;
+                num-ib-windows = <16>;
+                num-ob-windows = <16>;
+                max-link-speed = <2>;
+                dma-coherent;
+                interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
new file mode 100644
index 000000000000..3764ce01ee5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
@@ -0,0 +1,105 @@
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
+    oneOf:
+      - const: ti,am654-pcie-rc
+      - description: PCIe controller in Keystone
+        items:
+          - const: ti,keystone-pcie
+          - const: snps,dw-pcie
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
+                device_type = "pci";
+        };
+    };
-- 
2.17.1

