Return-Path: <linux-pci+bounces-7432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029E78C4891
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 23:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5C0284150
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEAC81728;
	Mon, 13 May 2024 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZ2IfGIr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929131DA24;
	Mon, 13 May 2024 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633995; cv=none; b=i2SYHcXbGioAIiNlAmcXjcpqRRNouzeAfr0Rh7WjXWezUPqye1shwE5G+3GRzYkMt5zkmLwBNr3RxdRmu4hQb5kEv69uSEcs+RuSY9cY88vSEz4pvuWJbdEcYu9cIP1k2NHe/iOTR5Kd10eh15rURzqLF7verTimg+0xvcJeSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633995; c=relaxed/simple;
	bh=dkkEaZdlGlHT49ZU3NBORQGpKALXUwJ7ygaxgEkYyeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vw7h+vy22haG97IRZ/I30OQYDdGHyVRQq3M3V4fN0OWExOjzVw7mEsL9+cKvPoe+QSMq/MYAh5fKvAk0GBH7aYVjIb90LVHKaAiEhIEeHFCMFxzSvwZpSMpYNuUap6VdtGqaLCyBpqZMV7JqrOdkBD8Mzv6ZIJtar//MRvxDdbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZ2IfGIr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715633994; x=1747169994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dkkEaZdlGlHT49ZU3NBORQGpKALXUwJ7ygaxgEkYyeE=;
  b=aZ2IfGIrYEr8cE7vYZKrzfbnE4ou3d+OBtC8nNOtfwEiqN48TFAzWUwF
   STQXP/b6y37zT7rVV75QHMkgW7WwRBZRUGf1OUcb+iBKZgTOlCrWohVjJ
   TlIfgq97oj1jHAU7+uB2bZDk5y/Rpl/VUMcEDNXl1GbH1Bq51wStnit+t
   Vb8FRDjUQLOEXaLZMDBrWNeGnL98OFol2+Vs8Bn09IGttPBLXt+9d3RZZ
   XWX7mBCsbEJCpJTMKPw04URIjNIGfxjDgQkVBea6tS7ukcnFfZTG1zJyl
   JPkR/VjSoJlmLJpLeHxTdMtz6l/whn7+92s63vCSHTb98txUl0uCuOqE5
   A==;
X-CSE-ConnectionGUID: xZ4e70j+QLqNqmOLAbTYww==
X-CSE-MsgGUID: S/zfnvV6QJOIGleNcrCidw==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="22260139"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="22260139"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 13:59:52 -0700
X-CSE-ConnectionGUID: MqTWVmp9RwygEqtnbLGWMQ==
X-CSE-MsgGUID: oN8DMCwXREC2y98S/enIRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30493213"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by fmviesa006.fm.intel.com with ESMTP; 13 May 2024 13:59:50 -0700
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
Subject: [PATCH v5] dt-bindings: PCI: altera: Convert to YAML
Date: Mon, 13 May 2024 15:59:13 -0500
Message-Id: <20240513205913.313592-1-matthew.gerlach@linux.intel.com>
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
v5:
 - add interrupt-conntroller #interrupt-cells to required field
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
 .../devicetree/bindings/pci/altera-pcie.txt   | 50 ----------
 .../bindings/pci/altr,pcie-root-port.yaml     | 93 +++++++++++++++++++
 2 files changed, 93 insertions(+), 50 deletions(-)
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
index 000000000000..7f02e7fb33e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
@@ -0,0 +1,93 @@
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
+        interrupt-map = <0 0 0 1 &pcie_0 1>,
+                        <0 0 0 2 &pcie_0 2>,
+                        <0 0 0 3 &pcie_0 3>,
+                        <0 0 0 4 &pcie_0 4>;
+        ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000>,
+                 <0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
+    };
-- 
2.34.1


