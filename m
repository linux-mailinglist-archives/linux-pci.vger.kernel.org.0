Return-Path: <linux-pci+bounces-5421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFB6892202
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 18:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8371F25932
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 17:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CC385629;
	Fri, 29 Mar 2024 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDOGqfJS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90633CC4;
	Fri, 29 Mar 2024 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731641; cv=none; b=YxA4oW1f9flYyfWR0LwKXAw7gHwx6uzTz4wLQyZ6aUDCJh/PpNppObIEJqBXgne8waYQsjWn5OwCsO31fn2HELbaoesXhq4FKt7JUZ95Z4eMAWdfj8ekSu+vu9wZt+YaxrOcIOKITMJegl3aSZex9Qqmdr1qNki4j4UZKVsKvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731641; c=relaxed/simple;
	bh=iV56zgBWXBOye2nA5+pTdyz84vnPkMVcgqGSOiaWdR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QLi9ONdryU/NJZbrgE5pCQYbhxq8zjEXSRSBI8aj5A1qLaj3gbekQWkXYyO2WVkrie827sioCXhcHG99AT6wbPa+PPSsbWKhf+TTcDXY9h7UtKMtG9s+RRflEMCiM40fMrwcY/NgZfOQq1zCsDlI50ij0fW1onO1IdqPD1m1x7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDOGqfJS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711731640; x=1743267640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iV56zgBWXBOye2nA5+pTdyz84vnPkMVcgqGSOiaWdR4=;
  b=nDOGqfJSw/yveUPE66A30wy19Wx5nXlc4T2y8UYx7OhWNKEFULa8CBJ+
   m2qxnBGPwFyNZ8fkyiVDumXDAe+7RnBZrXxekaVVfvSDoRdJlUZbKPVw1
   +LlA8k0D/hEGLcISL7rYlTl+FQCUO66M5vBQQjzDFdsFfZFLsKs/to93+
   N+KlbIz947x64mxu5gEqHGllEX0mUJ24u62l38Db8oBhV1qSAmGM5g4P7
   DCRngSPvjJQFfksQCz2fxg3I26Bf2ZPhs+xKSdxvDkVJa+9bebNbwwsaJ
   BYqzacfWNKCazSsdQc9m29clWyGd/CuwHbXgYIp2Zr1GltgPMj+NslmB8
   Q==;
X-CSE-ConnectionGUID: MgXgekE9SbalRu3b7YM32Q==
X-CSE-MsgGUID: iUrhyUZlSOyE1nMXc85CHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7519770"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="7519770"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 10:00:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17065468"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by fmviesa006.fm.intel.com with ESMTP; 29 Mar 2024 10:00:38 -0700
From: matthew.gerlach@linux.intel.com
To: joyce.ooi@intel.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH] dt-bindings: pci: altera: covert to yaml
Date: Fri, 29 Mar 2024 12:00:31 -0500
Message-Id: <20240329170031.3379524-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Covert the device tree bindings for the Altera Root
Port controller from text to yaml.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 .../devicetree/bindings/pci/altera-pcie.txt   |  50 ---------
 .../bindings/pci/altr,pcie-root-port.yaml     | 106 ++++++++++++++++++
 2 files changed, 106 insertions(+), 50 deletions(-)
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
index 000000000000..8f1ad1362ad1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2024, Intel Corporation
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
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - altr,pcie-root-port-1.0
+          - altr,pcie-root-port-2.0
+
+  reg:
+    minItems: 2
+    maxItems: 3
+
+  reg-names:
+    description:
+      TX slave port region (Txs)
+      Control register access region (Cra)
+      Hard IP region if altr,pcie-root-port-2.0 (Hip)
+
+    items:
+      - const: Txs
+      - const: Cra
+      - const: Hip
+    minItems: 2
+
+  device_type:
+    const: pci
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
+
+  interrupts:
+    minItems: 1
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
+  msi-parent:
+    description: Link to the hardware entity that serves as the MSI controller.
+
+  bus-range:
+    description: PCI bus numbers covered.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - device_type
+  - "#address-cells"
+  - "#size-cells"
+  - interrupts
+  - interrupt-map
+  - interrupt-map-mask
+  - "#interrupt-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie_0: pcie@c00000000 {
+        compatible = "altr,pcie-root-port-1.0";
+        reg = <0xc0000000 0x20000000>,
+            <0xff220000 0x00004000>;
+        reg-names = "Txs", "Cra";
+        interrupt-parent = <&hps_0_arm_gic_0>;
+        interrupts = <0 40 4>;
+        #interrupt-cells = <1>;
+        bus-range = <0x0 0xFF>;
+        device_type = "pci";
+        msi-parent = <&msi_to_gic_gen_0>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &pcie_intc 1>,
+                        <0 0 0 2 &pcie_intc 2>,
+                        <0 0 0 3 &pcie_intc 3>,
+                        <0 0 0 4 &pcie_intc 4>;
+        ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
+              0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
+    };
-- 
2.34.1


