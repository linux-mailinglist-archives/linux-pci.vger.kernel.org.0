Return-Path: <linux-pci+bounces-11544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4384B94D318
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 17:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAD32824DC
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0225C198E65;
	Fri,  9 Aug 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BO+cgiR2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFFD198845;
	Fri,  9 Aug 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216440; cv=none; b=iL/ptYXE0r+AEkwYfav55Vyzew6fIwMx/F3ifRi54XijsMgSd+IUQ6LxxKfBChK7itOlcvlaxhsUT5xRWpdKOnOCyP/cRbYAXLyllGTtAyTDa7074fG4XXLHYwarXV/ZzQ7h9KpngtmTPearQwgXxXgFL35vxf6wTRzH3lyZtWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216440; c=relaxed/simple;
	bh=rev+FMnUXng/ijmsYWofRQiPNrjvL8AVJON/YsFHmh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qP6o6oEwwC4Sql0MAzzTjd1GtaNd+fujWt5Y+ZQBTabCORYsHy1PwgnhZB/MZlZsnZvs7FwTUng6Lk4XSp+gW9Swa3pethSPdjlLqDsDnBylY6oTDhYbKURICnz5z89CAHdS2tuet0to/Z7otlkZrGJg5K5Az5vsCp2zM52+e3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BO+cgiR2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723216439; x=1754752439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rev+FMnUXng/ijmsYWofRQiPNrjvL8AVJON/YsFHmh4=;
  b=BO+cgiR2nFzduEK/HxGsJe9jKT8DAZC2gSHsK9rvFgKDJrV7NupEtIz4
   GHHsly0gnxf5LOnIr3plH/FvsV/YAPYobZct0YSMH4IATHm2/XYT5D5Qg
   ubvUfVgnv++9ptG3tdi4ke0QP0Y8lJ503FhQvAyrOTqWsYl4nHCb0GoRN
   /t/Zpogx0i4vRR43O4SuTyQQZwCAQjjEAr/4vF3Tzo/CWlBaKn3m+6kBU
   0HOWIm6gdjyGco7S7Ujzd0DHFJ3PDCSEcVHNMudnVqCiRNqyHpFgygrqQ
   SQO03UC2/XI/+d49gKF8oRaiQzBSNJDvcrfy7oMdZfjbF1LXzf6natM+G
   A==;
X-CSE-ConnectionGUID: o7/n/F+8S2iBBlYHHzPu+Q==
X-CSE-MsgGUID: bO/IO3y8Sqq8YNtL8ZuYhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21368859"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21368859"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:13:59 -0700
X-CSE-ConnectionGUID: 64oflbhEToKj8kbv1WbwSw==
X-CSE-MsgGUID: bRTN/bhTRrCFoKY06eUQww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57485952"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2024 08:13:57 -0700
From: matthew.gerlach@linux.intel.com
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/7] dt-bindings: PCI: altera: Convert to YAML
Date: Fri,  9 Aug 2024 10:12:07 -0500
Message-Id: <20240809151213.94533-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809151213.94533-1-matthew.gerlach@linux.intel.com>
References: <20240809151213.94533-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Convert the device tree bindings for the Altera Root Port PCIe controller
from text to YAML. Update the entries in the interrupt-map field to have
the correct number of address cells for the interrupt parent.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v8:
 - Precisely constrain the number of items for reg and reg-names properties.
   Constrain maxItems to 2 for altr,pcie-root-port-1.0.
   Constrain minItems to 3 for altr,pcie-root-port-2.0.

v7:
 - Keep original example dts, but fix warnings of interrupt-map field.

v6:
 - Fix dt_binding_check warnings by creating interrupt-controller subnode
   and fixing interrupt-map.
 - Updated filename in MAINTAINERS.

v5:
 - add interrupt-controller #interrupt-cells to required field
 - don't touch original example dts

v4:
 - reorder reg-names to match original binding
 - move reg and reg-names to top level with limits.

v3:
 - Added years to copyright
 - Correct order in file of allOf and unevaluatedProperties
 - remove items: in compatible field
 - fix reg and reg-names constraints
 - replace deprecated pci-bus.yaml with pci-host-bridge.yaml
 - fix entries in ranges property
 - remove device_type from required

v2:
 - Move allOf: to bottom of file, just like example-schema is showing
 - add constraint for reg and reg-names
 - remove unneeded device_type
 - drop #address-cells and #size-cells
 - change minItems to maxItems for interrupts:
 - change msi-parent to just "msi-parent: true"
 - cleaned up required:
 - make subject consistent with other commits coverting to YAML
 - s/overt/onvert/g
---
 .../devicetree/bindings/pci/altera-pcie.txt   |  50 --------
 .../bindings/pci/altr,pcie-root-port.yaml     | 114 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 115 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml

diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
deleted file mode 100644
index 816b244a221e..000000000000
--- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Altera PCIe controller
-
-Required properties:
-- compatible :	should contain "altr,pcie-root-port-1.0" or "altr,pcie-root-port-2.0"
-- reg:		a list of physical base address and length for TXS and CRA.
-		For "altr,pcie-root-port-2.0", additional HIP base address and length.
-- reg-names:	must include the following entries:
-		"Txs": TX slave port region
-		"Cra": Control register access region
-		"Hip": Hard IP region (if "altr,pcie-root-port-2.0")
-- interrupts:	specifies the interrupt source of the parent interrupt
-		controller.  The format of the interrupt specifier depends
-		on the parent interrupt controller.
-- device_type:	must be "pci"
-- #address-cells:	set to <3>
-- #size-cells:		set to <2>
-- #interrupt-cells:	set to <1>
-- ranges:	describes the translation of addresses for root ports and
-		standard PCI regions.
-- interrupt-map-mask and interrupt-map: standard PCI properties to define the
-		mapping of the PCIe interface to interrupt numbers.
-
-Optional properties:
-- msi-parent:	Link to the hardware entity that serves as the MSI controller
-		for this PCIe controller.
-- bus-range:	PCI bus numbers covered
-
-Example
-	pcie_0: pcie@c00000000 {
-		compatible = "altr,pcie-root-port-1.0";
-		reg = <0xc0000000 0x20000000>,
-			<0xff220000 0x00004000>;
-		reg-names = "Txs", "Cra";
-		interrupt-parent = <&hps_0_arm_gic_0>;
-		interrupts = <0 40 4>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-		bus-range = <0x0 0xFF>;
-		device_type = "pci";
-		msi-parent = <&msi_to_gic_gen_0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pcie_0 1>,
-			            <0 0 0 2 &pcie_0 2>,
-			            <0 0 0 3 &pcie_0 3>,
-			            <0 0 0 4 &pcie_0 4>;
-		ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
-			  0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
-	};
diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
new file mode 100644
index 000000000000..52533fccc134
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2015, 2019, 2024, Intel Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/altr,pcie-root-port.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera PCIe Root Port
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
+
+properties:
+  compatible:
+    enum:
+      - altr,pcie-root-port-1.0
+      - altr,pcie-root-port-2.0
+
+  reg:
+    items:
+      - description: TX slave port region
+      - description: Control register access region
+      - description: Hard IP region
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: Txs
+      - const: Cra
+      - const: Hip
+    minItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  interrupt-map-mask:
+    items:
+      - const: 0
+      - const: 0
+      - const: 0
+      - const: 7
+
+  interrupt-map:
+    maxItems: 4
+
+  "#interrupt-cells":
+    const: 1
+
+  msi-parent: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - "#interrupt-cells"
+  - interrupt-controller
+  - interrupt-map
+  - interrupt-map-mask
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - altr,pcie-root-port-1.0
+    then:
+      properties:
+        reg:
+          maxItems: 2
+
+        reg-names:
+          maxItems: 2
+
+    else:
+      properties:
+        reg:
+          minItems: 3
+
+        reg-names:
+          minItems: 3
+
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pcie_0: pcie@c00000000 {
+        compatible = "altr,pcie-root-port-1.0";
+        reg = <0xc0000000 0x20000000>,
+              <0xff220000 0x00004000>;
+        reg-names = "Txs", "Cra";
+        interrupt-parent = <&hps_0_arm_gic_0>;
+        interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        bus-range = <0x0 0xff>;
+        device_type = "pci";
+        msi-parent = <&msi_to_gic_gen_0>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &pcie_0 0 0 0 1>,
+                        <0 0 0 2 &pcie_0 0 0 0 2>,
+                        <0 0 0 3 &pcie_0 0 0 0 3>,
+                        <0 0 0 4 &pcie_0 0 0 0 4>;
+        ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000>,
+                 <0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e71f97fb674..53f239114400 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17435,7 +17435,7 @@ PCI DRIVER FOR ALTERA PCIE IP
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/pci/altera-pcie.txt
+F:	Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
 F:	drivers/pci/controller/pcie-altera.c
 
 PCI DRIVER FOR APPLIEDMICRO XGENE
-- 
2.34.1


