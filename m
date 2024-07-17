Return-Path: <linux-pci+bounces-10457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B8A93422E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A4E1F222C9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 18:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB2183060;
	Wed, 17 Jul 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZtLqw72z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0456D181BBE;
	Wed, 17 Jul 2024 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240364; cv=none; b=Ywj+d7uU/V3Zh30/n/97/xScWF9skNzlVeuzo2NnSJ+WK0+md/t9wWeDwRlzgaQnl7eD1VxxMHWZZ4Lb7tlU+pbkqRRT+VTBJnIB3JPnXkPYRn89CdV6jl3b5CFyqaOjgBZJQGcacGZeN2XO7j0b5762plaVvn7v1hEqm17MPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240364; c=relaxed/simple;
	bh=GmUUSK5wGPMIjTgA2rtDl0EVIe+HRUqTQRe1IJXXyoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SKKMj5bO+W0BC/S5mTpLx3+81EBfzhjJyfKDQHM/lhvPhvSSZth56EpPem4uWmPR4ywnvlyJzdW+u0TwEJJqIVBnDoxovi2YkUz3z6BZuu7740xBIq8KBVsWt8IaTpVzZGP4QFpwDmuE0htSbVIEaMdUo9rnzZOLUVt+3dPl7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZtLqw72z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721240362; x=1752776362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GmUUSK5wGPMIjTgA2rtDl0EVIe+HRUqTQRe1IJXXyoQ=;
  b=ZtLqw72zTZ1XD1rty/MpkrpVxIk6ZrzfOiDbKUlwWezqUGwRfGGuvXj9
   ZR7y64rEZ4W+UfOIRz4+eUx5BxiZ824PHvdDWHC6vnzMGh5o8feH72LL0
   NH+i/54GFpGLT7coKHW8MGeORpx7hOPmN7uGqPZJl4qriqTS8/KNi1zIe
   4FUTUev3AcgaWAfDzquyrpDEjC08dJ8lbBt+tx8ttBociyNxvtW6zaSWd
   JCoktSRyQTiJbPRXqnjQYB+9V7UDfdwFB8Iqpc3elQEclySJogV287JkE
   YOh3H/uu+JOcKA05BbdmLiFkmHLbcfn1I11RsIWq8lvHS4De/GbEjJu19
   Q==;
X-CSE-ConnectionGUID: YMjvFbxhRfqD3sdYkQR28Q==
X-CSE-MsgGUID: Kbnf9STSSye7ROe72Sskgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18461490"
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="18461490"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 11:19:21 -0700
X-CSE-ConnectionGUID: BK4n1Gw7TPi3uA5tprpqAg==
X-CSE-MsgGUID: YDzbysw2RuCRKkhBAcMtQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="50358864"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by fmviesa008.fm.intel.com with ESMTP; 17 Jul 2024 11:19:20 -0700
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
Subject: [PATCH] dt-bindings: PCI: altera: msi: Convert to YAML
Date: Wed, 17 Jul 2024 13:17:56 -0500
Message-Id: <20240717181756.2177553-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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
index 000000000000..84ff0b8a7725
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
+    msi0: msi@ff200000 {
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
index f296a5ea2529..8a3424a03772 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17585,7 +17585,7 @@ PCI MSI DRIVER FOR ALTERA MSI IP
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
+F:	Documentation/devicetree/bindings/pci/altr,msi-controller.yaml
 F:	drivers/pci/controller/pcie-altera-msi.c
 
 PCI MSI DRIVER FOR APPLIEDMICRO XGENE
-- 
2.34.1


