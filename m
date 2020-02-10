Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD82815749A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 13:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBJMbz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 07:31:55 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38396 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgBJMbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2020 07:31:55 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01ACVkMq023220;
        Mon, 10 Feb 2020 06:31:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581337906;
        bh=8UKzchovWQsic5D+IhNkKAsu3YPA30ZLZgLl2grTVhY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ww2oRgASEWczpC2P1dADxThAu8oEuj+OwFnLu6ZfLXEHyRvTgBAI+/+OP7RdlNbOp
         c4DWuxR2LQCS1TsfriEAzcrSl5XaIuM0BsAIPbwJXseH5S7X8dGIJbuApoDe20iHGi
         Lo/mlljbb+KUClnx2/XVLYSl73xSNEZJdhHfaylY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01ACVk7o082926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Feb 2020 06:31:46 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 06:31:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 06:31:46 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01ACVaEZ129098;
        Mon, 10 Feb 2020 06:31:43 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     Mark Rutland <mark.rutland@arm.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/2] dt-bindings: PCI: Convert PCIe Host/Endpoint in Cadence platform to DT schema
Date:   Mon, 10 Feb 2020 18:05:07 +0530
Message-ID: <20200210123507.9491-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210123507.9491-1-kishon@ti.com>
References: <20200210123507.9491-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Include Cadence core DT schema and define the Cadence platform DT schema
for both Host and Endpoint mode. Note: The Cadence core DT schema could
be included for other platforms using Cadence PCIe core.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/cdns,cdns-pcie-ep.txt        | 27 -------
 .../bindings/pci/cdns,cdns-pcie-ep.yaml       | 48 ++++++++++++
 .../bindings/pci/cdns,cdns-pcie-host.txt      | 66 ----------------
 .../bindings/pci/cdns,cdns-pcie-host.yaml     | 76 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 5 files changed, 125 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
deleted file mode 100644
index 4a0475e2ba7e..000000000000
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Cadence PCIe endpoint controller
-
-Required properties:
-- compatible: Should contain "cdns,cdns-pcie-ep" to identify the IP used.
-- reg: Should contain the controller register base address and AXI interface
-  region base address respectively.
-- reg-names: Must be "reg" and "mem" respectively.
-- cdns,max-outbound-regions: Set to maximum number of outbound regions
-
-Optional properties:
-- max-functions: Maximum number of functions that can be configured (default 1).
-- phys: From PHY bindings: List of Generic PHY phandles. One per lane if more
-  than one in the list.  If only one PHY listed it must manage all lanes. 
-- phy-names:  List of names to identify the PHY.
-
-Example:
-
-pcie@fc000000 {
-	compatible = "cdns,cdns-pcie-ep";
-	reg = <0x0 0xfc000000 0x0 0x01000000>,
-	      <0x0 0x80000000 0x0 0x40000000>;
-	reg-names = "reg", "mem";
-	cdns,max-outbound-regions = <16>;
-	max-functions = /bits/ 8 <8>;
-	phys = <&ep_phy0 &ep_phy1>;
-	phy-names = "pcie-lane0","pcie-lane1";
-};
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
new file mode 100644
index 000000000000..016c374cf125
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/cdns,cdns-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence PCIe EP Controller
+
+maintainers:
+  - Tom Joseph <tjoseph@cadence.com>
+
+allOf:
+  - $ref: "cdns-pcie-ep.yaml#"
+
+properties:
+  compatible:
+    const: cdns,cdns-pcie-ep
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: reg
+      - const: mem
+
+required:
+  - reg
+  - reg-names
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@fc000000 {
+                compatible = "cdns,cdns-pcie-ep";
+                reg = <0x0 0xfc000000 0x0 0x01000000>,
+                      <0x0 0x80000000 0x0 0x40000000>;
+                reg-names = "reg", "mem";
+                cdns,max-outbound-regions = <16>;
+                max-functions = /bits/ 8 <8>;
+                phys = <&pcie_phy0>;
+                phy-names = "pcie-phy";
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
deleted file mode 100644
index 91de69c713a9..000000000000
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-* Cadence PCIe host controller
-
-This PCIe controller inherits the base properties defined in
-host-generic-pci.txt.
-
-Required properties:
-- compatible: Should contain "cdns,cdns-pcie-host" to identify the IP used.
-- reg: Should contain the controller register base address, PCIe configuration
-  window base address, and AXI interface region base address respectively.
-- reg-names: Must be "reg", "cfg" and "mem" respectively.
-- #address-cells: Set to <3>
-- #size-cells: Set to <2>
-- device_type: Set to "pci"
-- ranges: Ranges for the PCI memory and I/O regions
-- #interrupt-cells: Set to <1>
-- interrupt-map-mask and interrupt-map: Standard PCI properties to define the
-  mapping of the PCIe interface to interrupt numbers.
-
-Optional properties:
-- cdns,max-outbound-regions: Set to maximum number of outbound regions
-  (default 32)
-- cdns,no-bar-match-nbits: Set into the no BAR match register to configure the
-  number of least significant bits kept during inbound (PCIe -> AXI) address
-  translations (default 32)
-- vendor-id: The PCI vendor ID (16 bits, default is design dependent)
-- device-id: The PCI device ID (16 bits, default is design dependent)
-- phys: From PHY bindings: List of Generic PHY phandles. One per lane if more
-  than one in the list.  If only one PHY listed it must manage all lanes. 
-- phy-names:  List of names to identify the PHY.
-
-Example:
-
-pcie@fb000000 {
-	compatible = "cdns,cdns-pcie-host";
-	device_type = "pci";
-	#address-cells = <3>;
-	#size-cells = <2>;
-	bus-range = <0x0 0xff>;
-	linux,pci-domain = <0>;
-	cdns,max-outbound-regions = <16>;
-	cdns,no-bar-match-nbits = <32>;
-	vendor-id = /bits/ 16 <0x17cd>;
-	device-id = /bits/ 16 <0x0200>;
-
-	reg = <0x0 0xfb000000  0x0 0x01000000>,
-	      <0x0 0x41000000  0x0 0x00001000>,
-	      <0x0 0x40000000  0x0 0x04000000>;
-	reg-names = "reg", "cfg", "mem";
-
-	ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
-		 <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
-
-	#interrupt-cells = <0x1>;
-
-	interrupt-map = <0x0 0x0 0x0  0x1  &gic  0x0 0x0 0x0 14 0x1
-			 0x0 0x0 0x0  0x2  &gic  0x0 0x0 0x0 15 0x1
-			 0x0 0x0 0x0  0x3  &gic  0x0 0x0 0x0 16 0x1
-			 0x0 0x0 0x0  0x4  &gic  0x0 0x0 0x0 17 0x1>;
-
-	interrupt-map-mask = <0x0 0x0 0x0  0x7>;
-
-	msi-parent = <&its_pci>;
-
-	phys = <&pcie_phy0>;
-	phy-names = "pcie-phy";
-};
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
new file mode 100644
index 000000000000..2f605297f862
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/cdns,cdns-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence PCIe host controller
+
+maintainers:
+  - Tom Joseph <tjoseph@cadence.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: "cdns-pcie-host.yaml#"
+
+properties:
+  compatible:
+    const: cdns,cdns-pcie-host
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: reg
+      - const: cfg
+      - const: mem
+
+  msi-parent: true
+
+required:
+  - reg
+  - reg-names
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@fb000000 {
+            compatible = "cdns,cdns-pcie-host";
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            bus-range = <0x0 0xff>;
+            linux,pci-domain = <0>;
+            cdns,max-outbound-regions = <16>;
+            cdns,no-bar-match-nbits = <32>;
+            vendor-id = /bits/ 16 <0x17cd>;
+            device-id = /bits/ 16 <0x0200>;
+
+            reg = <0x0 0xfb000000  0x0 0x01000000>,
+                  <0x0 0x41000000  0x0 0x00001000>,
+                  <0x0 0x40000000  0x0 0x04000000>;
+            reg-names = "reg", "cfg", "mem";
+
+            ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
+                     <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
+
+            #interrupt-cells = <0x1>;
+
+            interrupt-map = <0x0 0x0 0x0  0x1  &gic  0x0 0x0 0x0 14 0x1>,
+                 <0x0 0x0 0x0  0x2  &gic  0x0 0x0 0x0 15 0x1>,
+                 <0x0 0x0 0x0  0x3  &gic  0x0 0x0 0x0 16 0x1>,
+                 <0x0 0x0 0x0  0x4  &gic  0x0 0x0 0x0 17 0x1>;
+
+            interrupt-map-mask = <0x0 0x0 0x0  0x7>;
+
+            msi-parent = <&its_pci>;
+
+            phys = <&pcie_phy0>;
+            phy-names = "pcie-phy";
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f..e0402e001edd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12739,7 +12739,7 @@ PCI DRIVER FOR CADENCE PCIE IP
 M:	Tom Joseph <tjoseph@cadence.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/cdns,*.txt
+F:	Documentation/devicetree/bindings/pci/cdns,*
 F:	drivers/pci/controller/pcie-cadence*
 
 PCI DRIVER FOR FREESCALE LAYERSCAPE
-- 
2.17.1

