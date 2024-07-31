Return-Path: <linux-pci+bounces-11056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578BE94323D
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 16:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3441C22001
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA921BBBC7;
	Wed, 31 Jul 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQWinuIW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9521BBBE7;
	Wed, 31 Jul 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436895; cv=none; b=j8RYu9AhOlSc8+Yl/ILNvwXuy4SDh/9ORGLaWHxYgEFu181j2LGL1ltCfO2D4YL7oyMyJDySeP4bVCqE3VQOJgBZbEQ0UIDNxfr55HRxghvnKx4d9YTIR1MvYlfEjK8ERLIrefKF7WZ2h+uq1AzPkU0SgcfTvIxGgCQnZaKf01Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436895; c=relaxed/simple;
	bh=iPApjiNqmQ2J74sxfpDomVvZdzFkNgJyabB10mjKRKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gNCyR7VRk2/TZwh/aj5wBjCan0wbd+y54xkzw+dj2W3VxAXKfBOMz2OZ5rXIV3VvLqVKzdfcI2X6+aSAfZRSrJGywBRl+Kptu3ekKYgAZvOzM1mw77D4dXLyD16U81dtqAMuLi1NDT3aCwyGHFVc0JnjVrRnyTp0ZzynUau25eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQWinuIW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722436894; x=1753972894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iPApjiNqmQ2J74sxfpDomVvZdzFkNgJyabB10mjKRKw=;
  b=RQWinuIWmFet+IZD26PmS/sq3bTV6CX4v91HVkEMwTfOeyNr/36cwVIB
   JAA6OEsAlll4pgJzA1dY14VCXiK2nu7XRIIL3uTX82KO25/mumMbxWPBC
   U3z2FqL5VutbBiMXM0bVX6UjW4eTOVCKMY6j1DNttXF0wK9IRkEvegDfg
   W8C0fBptc9ge2tVXtim3CxHJICMeLFhzg4Ux5acGQe44pzm86Dv1og/I+
   DPZeeU+kNu5q1Jl9gMHD8+jrtkvk3ak7IXKrmTIFrKv7D1+ebmKyIV+0r
   qmHtmDwjf3qOAsEQ+D+06Hhiv5MTVPR38PpDj6CCeis4y+fAhrOU5jGLf
   w==;
X-CSE-ConnectionGUID: qLlhnOBERqGkoy5Oia5RpQ==
X-CSE-MsgGUID: V/5W3djsRsSYHwSRNMM1Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20479809"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20479809"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:41:24 -0700
X-CSE-ConnectionGUID: nmR2uBpZRayNT8BbaS8CKA==
X-CSE-MsgGUID: IbMIqJCzS5GN0ItSnz9SMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="55295539"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa007.jf.intel.com with ESMTP; 31 Jul 2024 07:41:23 -0700
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
Subject: [PATCH 2/7] dt-bindings: PCI: altera: msi: Convert to YAML
Date: Wed, 31 Jul 2024 09:39:41 -0500
Message-Id: <20240731143946.3478057-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731143946.3478057-1-matthew.gerlach@linux.intel.com>
References: <20240731143946.3478057-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Convert the device tree bindings for the Altera PCIe MSI controller
from text to YAML.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v2: remove unused label
---
 .../bindings/pci/altera-pcie-msi.txt          | 27 --------
 .../bindings/pci/altr,msi-controller.yaml     | 65 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 66 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
 create mode 100644 Documentation/devicetree/bindings/pci/altr,msi-controller.yaml

diff --git a/Documentation/devicetree/bindings/pci/altera-pcie-msi.txt b/Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
deleted file mode 100644
index 9514c327d31b..000000000000
--- a/Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Altera PCIe MSI controller
-
-Required properties:
-- compatible:	should contain "altr,msi-1.0"
-- reg:		specifies the physical base address of the controller and
-		the length of the memory mapped region.
-- reg-names:	must include the following entries:
-		"csr": CSR registers
-		"vector_slave": vectors slave port region
-- interrupts:	specifies the interrupt source of the parent interrupt
-		controller. The format of the interrupt specifier depends on the
-		parent interrupt controller.
-- num-vectors:	number of vectors, range 1 to 32.
-- msi-controller:	indicates that this is MSI controller node
-
-
-Example
-msi0: msi@0xFF200000 {
-	compatible = "altr,msi-1.0";
-	reg = <0xFF200000 0x00000010
-		0xFF200010 0x00000080>;
-	reg-names = "csr", "vector_slave";
-	interrupt-parent = <&hps_0_arm_gic_0>;
-	interrupts = <0 42 4>;
-	msi-controller;
-	num-vectors = <32>;
-};
diff --git a/Documentation/devicetree/bindings/pci/altr,msi-controller.yaml b/Documentation/devicetree/bindings/pci/altr,msi-controller.yaml
new file mode 100644
index 000000000000..98814862d006
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/altr,msi-controller.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2015, 2024, Intel Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/altr,msi-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera PCIe MSI controller
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
+
+properties:
+  compatible:
+    enum:
+      - altr,msi-1.0
+
+  reg:
+    items:
+      - description: CSR registers
+      - description: Vectors slave port region
+
+  reg-names:
+    items:
+      - const: csr
+      - const: vector_slave
+
+  interrupts:
+    maxItems: 1
+
+  msi-controller: true
+
+  num-vectors:
+    description: number of vectors
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 32
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - msi-controller
+  - num-vectors
+
+allOf:
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    msi@ff200000 {
+        compatible = "altr,msi-1.0";
+        reg = <0xff200000 0x00000010>,
+              <0xff200010 0x00000080>;
+        reg-names = "csr", "vector_slave";
+        interrupt-parent = <&hps_0_arm_gic_0>;
+        interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+        msi-controller;
+        num-vectors = <32>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 55ad37e73183..2faf57628973 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17596,7 +17596,7 @@ PCI MSI DRIVER FOR ALTERA MSI IP
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
+F:	Documentation/devicetree/bindings/pci/altr,msi-controller.yaml
 F:	drivers/pci/controller/pcie-altera-msi.c
 
 PCI MSI DRIVER FOR APPLIEDMICRO XGENE
-- 
2.34.1


