Return-Path: <linux-pci+bounces-11545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4F294D31B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 17:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6A81F21A4E
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91AF198E9C;
	Fri,  9 Aug 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6pgfxLA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3B198A0A;
	Fri,  9 Aug 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216441; cv=none; b=PzpkCfFLsj6mflmTDU9Hv4KVlD5lYNCRs+LGjCh3k8YdFGPcXEHzDPq/CaiwwJSI8zDqwjQ9iJV47mdqHU+tUY8HUFstXRdzO1VjHY+xp+eRoI6N6kyOwr4LyWEyT9Qy8PT9kuS5pUM94kY9flY6CQsBcrxQMt9jaqKgN7m5TmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216441; c=relaxed/simple;
	bh=BRcoeU4eLhd3P4AsLSBnVTY1+227dKuSSDq+0ORb8gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NqnSd7ngeXRLXN8xJvZ8y5+nUlEBkgh2FlPc0OTcEvmAMiGu0YwhoxZ/U+uV8zRQwO6AiTYrkIjUNgr3W+lOFRgmM+LaC8gEshtw1dJK0ZEgFbKdi78Np55bm/XSjyuZ542X1ByzIywQux8hOfgkTdMpISSExB9THUJyqPw8xQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6pgfxLA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723216440; x=1754752440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BRcoeU4eLhd3P4AsLSBnVTY1+227dKuSSDq+0ORb8gc=;
  b=R6pgfxLAH5YJYHnfgRl4dX+Ey9HlV8Qyf0Im0Vrr6DL1art9ZsgYeP/i
   A4cE/3cNm9uIlOzn7QhzZNtdGhVsmWpASiJku2eW5ktCYuUedYgWs5YGI
   7dKtomNFjst301vw8cgJVRUCetSk7D07LUt09L8vtpBnjrIswXQtgdVav
   ICaQbJDj5gc9TQxMRoR19zkKm27VS44mgNTvaY17y2n13PPJicxe6buRG
   xns/nTsyQveW+8Ur3MjfjgQHk21DlEKoe8IzJvWVPC/zo0TxXLAS/MmW3
   WSW9pp/YDSGjIQvwR+KqY7VBVYKwWBZn0er/JJhvOebmCZbfXuy73S+0R
   A==;
X-CSE-ConnectionGUID: LctKPEu0RzeV/OC7Dh+urw==
X-CSE-MsgGUID: 6x1aIUQVTZiPuFwaJyFUCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21368866"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21368866"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:14:00 -0700
X-CSE-ConnectionGUID: IaUgDPB8Q0aWSCUZEORVdQ==
X-CSE-MsgGUID: qLg8g6jrRLOqg26agkGRCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57485955"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2024 08:13:59 -0700
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
Subject: [PATCH v2 2/7] dt-bindings: PCI: altera: msi: Convert to YAML
Date: Fri,  9 Aug 2024 10:12:08 -0500
Message-Id: <20240809151213.94533-3-matthew.gerlach@linux.intel.com>
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
index 53f239114400..29025f24c087 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17665,7 +17665,7 @@ PCI MSI DRIVER FOR ALTERA MSI IP
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
+F:	Documentation/devicetree/bindings/pci/altr,msi-controller.yaml
 F:	drivers/pci/controller/pcie-altera-msi.c
 
 PCI MSI DRIVER FOR APPLIEDMICRO XGENE
-- 
2.34.1


