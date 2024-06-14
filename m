Return-Path: <linux-pci+bounces-8849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22255909086
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 18:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDEA1F24112
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5B119FA6A;
	Fri, 14 Jun 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TniGD/lv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E715FD04;
	Fri, 14 Jun 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382983; cv=none; b=ivwVpHg03FYSpy843wAc+g3lnZ6mIG6f9G+t+sZt6XPEVRMopIT2PROeMu8xTnE/N3RLe6+DjrDnkkqByYp/KbxyXm9/tGdTjl4PbMpQ6OmEbh9A9hO45B5Kd6eMojSCJUjEMIfs11VzU5xk60cimKtHi2K5CdYKJAPw1OZbEzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382983; c=relaxed/simple;
	bh=k4MQdn5qWpovAjgmlRE25dnN8DhrxSbg+12CebdRdY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EtYUGEy7IsMS7IyYwbPPgRKGKpFOypJVgs8iP/BZnkIciJUE4+PZsCPYZTre9ezH8cS4UM71Cdd0r+0rK9Ljv3ns3wpEgi7Knq3poeoxy2I5ag0dd2Yg1mC6VGdGsykoE0Ho8R1NiIjLZSm7psw75aNFF/O6awMfG/Fb9PcRMHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TniGD/lv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718382982; x=1749918982;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k4MQdn5qWpovAjgmlRE25dnN8DhrxSbg+12CebdRdY0=;
  b=TniGD/lvI4od3j1a0E3Wr2IdFkWvB8z/bbAXt1xMQRFN7u0xW+8Me6Kw
   P4bdfmDtxjTlnxb9ny7jSrOchH7k4Ls1piT8DVBtoJKBFeLuDoat4IYCU
   JffGiGgKR4mlcAdzEPAjWetSw2cRnFVQEGj7sTf5sCeCE+djgasJtQtD4
   e840HkwFHsVzeKdH6BqEKXGCQ48sugTo/W56Uf6iBjlXoq3WzPuNOT6UO
   Mat7mAUXPQqD5wN3jH27xON/LW9BJJdQl9Cnv3R9Q4EG6tJi1I1ap/IyV
   mGaMSTRMF/EjVBcyAvmn0aG4DT85EXqw+oZvdxLiScfNqvDZHERiK+ieW
   w==;
X-CSE-ConnectionGUID: bWuIyquhQJ+s5f6e7Q3DfA==
X-CSE-MsgGUID: jilCtJbOTvOyBBKpFHT6Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19102628"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="19102628"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 09:36:16 -0700
X-CSE-ConnectionGUID: IY9CzUfcTCiva/1x1+pc1A==
X-CSE-MsgGUID: 0/yS/rb6TXqvYCeIuPMjvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="40406137"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by fmviesa007.fm.intel.com with ESMTP; 14 Jun 2024 09:36:14 -0700
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
Subject: [PATCH v7] dt-bindings: PCI: altera: Convert to YAML
Date: Fri, 14 Jun 2024 11:35:20 -0500
Message-Id: <20240614163520.494047-1-matthew.gerlach@linux.intel.com>
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
 .../devicetree/bindings/pci/altera-pcie.txt   | 50 ----------
 .../bindings/pci/altr,pcie-root-port.yaml     | 93 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 94 insertions(+), 51 deletions(-)
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
index 000000000000..0aaf5dbcc9cc
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
+        interrupt-map = <0 0 0 1 &pcie_0 0 0 0 1>,
+                        <0 0 0 2 &pcie_0 0 0 0 2>,
+                        <0 0 0 3 &pcie_0 0 0 0 3>,
+                        <0 0 0 4 &pcie_0 0 0 0 4>;
+        ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000>,
+                 <0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a2f416e4a7c6..1fa87de1a1d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17156,7 +17156,7 @@ PCI DRIVER FOR ALTERA PCIE IP
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/pci/altera-pcie.txt
+F:	Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
 F:	drivers/pci/controller/pcie-altera.c
 
 PCI DRIVER FOR APPLIEDMICRO XGENE
-- 
2.34.1


