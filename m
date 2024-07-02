Return-Path: <linux-pci+bounces-9595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB296924381
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 18:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF251C22E2C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 16:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990421BD4E0;
	Tue,  2 Jul 2024 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aL4LJTCJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E3A1BC06B;
	Tue,  2 Jul 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937692; cv=none; b=Ay+FIGk6XuqHhIic8GYJlitboMGr/bI4iajns7AK+u7nXldR3mpiVi1UEZoSbQBZYt+CmlxV79YooeWTjfM2pLWf4CmzZwxiivnFqSPJxH1P2AMbjMOrA1/Y+sj8nvFDSKqY2Cs9mciDwRe3aNhU7w/U4zJ9hjvZh2C8fnj+uWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937692; c=relaxed/simple;
	bh=C2xAMNCA0bq3Yf7LBiebEp9Zv7nzNrK9boSL2VnUezs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MzpXKK494R/iurnaXWTMZs8H9YFGFKcp+3LU00JAI9m9JwJs0Jy4kUIyjo/J5ga/xnQkx18RhOqSmc9uY9rlspITw8j5C/NzbkE8Fv2gXwKThyoeDfApy/sN/mDMXUT3CTfby2xV4Rmz9/J+Dq6TKAJIiqvxtMkF7f5ahHq96Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aL4LJTCJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719937691; x=1751473691;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C2xAMNCA0bq3Yf7LBiebEp9Zv7nzNrK9boSL2VnUezs=;
  b=aL4LJTCJwLOHHyLlo9F8YNyqa4BctqkjhKgCxOTsklZpH2ZazA7YChLu
   UDHg93ce4CYIwcmZoWKvzBUjpRWg95Z0FRO3j5TwSzzrJ5pE2w9MTsH4b
   4DHJIyxfLThRJ+vt/u8738nxmIml/wLXeRD0t2G6uFdsaYmo4r22EMww4
   KmIvSYz2NZsTjr5nDjajd/8LSYSbytM7qldq8woaDoUvG3wTfiw711MpF
   9LCBRsmb+4FOcG3M9fq4CY6uvs+nvS5EnQ1Kinqe3noGS7sIIR0hCBY1k
   EF42+zATCQeesE340boZjUqM1aQVbtzOXECZMbyv31cHta8Qc/NLIc2/5
   Q==;
X-CSE-ConnectionGUID: qNzIjySxQU2p9zKWFnjSfw==
X-CSE-MsgGUID: LxH3p/J8S5GHtnVSsTPBuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17255171"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="17255171"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 09:28:10 -0700
X-CSE-ConnectionGUID: 15WMY8GuS3Gemc+EdG0tDg==
X-CSE-MsgGUID: KaztnQAARZObwRASAUQCEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="76687022"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa002.jf.intel.com with ESMTP; 02 Jul 2024 09:28:07 -0700
From: matthew.gerlach@linux.intel.com
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v8] dt-bindings: PCI: altera: Convert to YAML
Date: Tue,  2 Jul 2024 11:26:52 -0500
Message-Id: <20240702162652.1349121-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

v8 fix
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
index cbc186250383..ff2d2c110e41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17274,7 +17274,7 @@ PCI DRIVER FOR ALTERA PCIE IP
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/pci/altera-pcie.txt
+F:	Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
 F:	drivers/pci/controller/pcie-altera.c
 
 PCI DRIVER FOR APPLIEDMICRO XGENE
-- 
2.34.1


