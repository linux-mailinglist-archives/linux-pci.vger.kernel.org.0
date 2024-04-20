Return-Path: <linux-pci+bounces-6498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B0A8ABC15
	for <lists+linux-pci@lfdr.de>; Sat, 20 Apr 2024 16:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90351B20D97
	for <lists+linux-pci@lfdr.de>; Sat, 20 Apr 2024 14:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB4322301;
	Sat, 20 Apr 2024 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oyi4d1fo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F1B669;
	Sat, 20 Apr 2024 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713624847; cv=none; b=Si71hZGAE07igW7NJJmyGoeY8cqjJbhu0b4olDyFUAqeKDLf9lHzuMlMy2i9PVysRW3KlROb6YENZ/0AvTpupxRJJAWQeCS6eFzoh0UOMJBbD5zRTC/FBawvH5CocSi0Qq9ywFpdTFdit7HohlOB/ZbElLXRpxl5W2bFGv1ac0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713624847; c=relaxed/simple;
	bh=oIrb6wJ4fZuey5KYNJS/voO+opaNOiTbqtomeD0H9EQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I+Lwm7qJjQ7AGMKcjbPyRyR6xjnIHD/uRADaOO0ruQMnQRVODIfTI/bsubityQunel5j1GmNL0ZODPRnMNi2JMi0bVgTx9hq2QsM8vRZPz+KvG/Ru1tAUjPJAE8ByQidVFTYtnt52vcxPIYkluS8+X+qq/Sn4QUSmNOoaG7+9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oyi4d1fo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713624845; x=1745160845;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oIrb6wJ4fZuey5KYNJS/voO+opaNOiTbqtomeD0H9EQ=;
  b=Oyi4d1foWrAdT7nvDlyWcWfARTpVyOJ5KSF3hifoMSFHdLhcLY4/H29p
   HPb5W1swFGiPZxwLEhHgjXgbcrhuLzUwP6l8sNVUucVXHejB0h/q0QQML
   CdtHxaX2vfUTtO4i8jF0xTdbS0dFZP1QQpx/6FNtyBcGgZydxifNZhcMn
   FymH33XrRbXdJWK8JYqYLD3gTkE7bova2uonrNj7HuabpcBLQv8Uh1yzY
   k5hbu63Crx8JtSJkc8uyZATawjqalYu0J9PJoKsPNwuxP6szxdphCDGwf
   qR2imr1sclzGiuJxyAUl7Mat4PGscdoTCPapW2yZoyhqNrILisKeqAg7c
   g==;
X-CSE-ConnectionGUID: hSyxUjwAQi+nK3QBaJQPiw==
X-CSE-MsgGUID: JZQ1tPTiSCa1MAUw0K+DRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="31696851"
X-IronPort-AV: E=Sophos;i="6.07,216,1708416000"; 
   d="scan'208";a="31696851"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 07:54:04 -0700
X-CSE-ConnectionGUID: YWHLdN4jTM2kWBYvcjtEtQ==
X-CSE-MsgGUID: rpM0sb4sRoqDyyTYw2qWrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,216,1708416000"; 
   d="scan'208";a="54528949"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa002.jf.intel.com with ESMTP; 20 Apr 2024 07:54:04 -0700
From: matthew.gerlach@linux.intel.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v4] dt-bindings: PCI: altera: Convert to YAML
Date: Sat, 20 Apr 2024 09:53:42 -0500
Message-Id: <20240420145342.118643-1-matthew.gerlach@linux.intel.com>
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
from text to YAML.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
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
 .../devicetree/bindings/pci/altera-pcie.txt   | 50 -----------
 .../bindings/pci/altr,pcie-root-port.yaml     | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 50 deletions(-)
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
index 000000000000..5794396f0986
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
@@ -0,0 +1,88 @@
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
+  - interrupt-map
+  - interrupt-map-mask
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
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
+        #interrupt-cells = <1>;
+        bus-range = <0x0 0xff>;
+        device_type = "pci";
+        msi-parent = <&msi_to_gic_gen_0>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &pcie_intc 1>,
+                        <0 0 0 2 &pcie_intc 2>,
+                        <0 0 0 3 &pcie_intc 3>,
+                        <0 0 0 4 &pcie_intc 4>;
+        ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000>,
+                 <0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
+    };
-- 
2.34.1


