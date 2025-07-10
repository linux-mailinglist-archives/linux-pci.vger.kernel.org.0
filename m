Return-Path: <linux-pci+bounces-31868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4230AB00B08
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 20:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96804165BF3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 18:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E234B2FCE1F;
	Thu, 10 Jul 2025 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjEc60j7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E402FCE18;
	Thu, 10 Jul 2025 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170882; cv=none; b=am/roRcGOul8GZfmTyXfwQzn4Gw0sa3q0ON8Kxs/XuJZuXvUYgO86thezOsJKSFs734r/StYt9YPzojE0H5xoeY0pF1fbh5YW2Ex9AGKXu095sa2MJQ4kax4uFZQBeZb59fLa3oCUi7TiUOUxxNxQ340hlBZXxovsX8P4xwt35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170882; c=relaxed/simple;
	bh=H/22VoxoJNMCj2KzG+gdrE6//AC+jUMyUk7xyA65920=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJr6UaHeBnYWKakLQd51hEELnUzh2tsCXsXl0ezcU2pIXWS/S9ecv3o0vDFa4ky/lIfKnXYjSyN46XdjujYZFNsCApC+VBqgtQMA7JZAeHijBk9RjpCHwefxitnj/cBgI2xboEMWcMk2eIfAGizzcTZGGJEagbZMJKAfwW7IbPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjEc60j7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F14C4CEE3;
	Thu, 10 Jul 2025 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752170882;
	bh=H/22VoxoJNMCj2KzG+gdrE6//AC+jUMyUk7xyA65920=;
	h=From:To:Cc:Subject:Date:From;
	b=KjEc60j7UV1LD0DOGVyrM5BGtvErn7j9p48hyR9AQkhQoDABqu8/qqOIdFM0V8Hjm
	 dxyOjVB7ZjfGRK2EyWTzkUE8HNOQd0ZmdUovgVyhtl/jrbswN5qNtXD+M1dtBUrDtn
	 0ttaTxxSkx+4DnxJ4kpqlI9UHN0RGfUMSeKTZXTIMspO7YcNZJp9jnW85fX3KwcM7d
	 drjKBPLsWzEPQ4uCx8Fm+GdVXXTVsVoFqA/idSiZSc7yGUf++gJ1D0couFJsb8NVjM
	 s5/q9wYO7qGdgZcVzsWjB5JfUG0Ry/DOcm75Qjl3Ad2eApv53n1kp1TuugqbCfKHDR
	 WJre1r2+kmM2g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Toan Le <toan@os.amperecomputing.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: interrupt-controller: Convert apm,xgene1-msi to DT schema
Date: Thu, 10 Jul 2025 13:07:55 -0500
Message-ID: <20250710180757.2970583-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Applied Micro X-Gene MSI controller binding to DT schema
format. MSI controllers go in interrupt-controller directory so move the
schema there.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../interrupt-controller/apm,xgene1-msi.yaml  | 54 +++++++++++++++
 .../devicetree/bindings/pci/xgene-pci-msi.txt | 68 -------------------
 MAINTAINERS                                   |  2 +-
 3 files changed, 55 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apm,xgene1-msi.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apm,xgene1-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/apm,xgene1-msi.yaml
new file mode 100644
index 000000000000..49db952697f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/apm,xgene1-msi.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/apm,xgene1-msi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AppliedMicro X-Gene v1 PCIe MSI controller
+
+maintainers:
+  - Toan Le <toan@os.amperecomputing.com>
+
+properties:
+  compatible:
+    const: apm,xgene1-msi
+
+  msi-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 16
+
+required:
+  - compatible
+  - msi-controller
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    msi@79000000 {
+        compatible = "apm,xgene1-msi";
+        msi-controller;
+        reg = <0x79000000 0x900000>;
+        interrupts = <0x0 0x10 0x4>,
+                     <0x0 0x11 0x4>,
+                     <0x0 0x12 0x4>,
+                     <0x0 0x13 0x4>,
+                     <0x0 0x14 0x4>,
+                     <0x0 0x15 0x4>,
+                     <0x0 0x16 0x4>,
+                     <0x0 0x17 0x4>,
+                     <0x0 0x18 0x4>,
+                     <0x0 0x19 0x4>,
+                     <0x0 0x1a 0x4>,
+                     <0x0 0x1b 0x4>,
+                     <0x0 0x1c 0x4>,
+                     <0x0 0x1d 0x4>,
+                     <0x0 0x1e 0x4>,
+                     <0x0 0x1f 0x4>;
+    };
diff --git a/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
deleted file mode 100644
index 85d9b95234f7..000000000000
--- a/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
+++ /dev/null
@@ -1,68 +0,0 @@
-* AppliedMicro X-Gene v1 PCIe MSI controller
-
-Required properties:
-
-- compatible: should be "apm,xgene1-msi" to identify
-	      X-Gene v1 PCIe MSI controller block.
-- msi-controller: indicates that this is an X-Gene v1 PCIe MSI controller node
-- reg: physical base address (0x79000000) and length (0x900000) for controller
-       registers. These registers include the MSI termination address and data
-       registers as well as the MSI interrupt status registers.
-- reg-names: not required
-- interrupts: A list of 16 interrupt outputs of the controller, starting from
-	      interrupt number 0x10 to 0x1f.
-- interrupt-names: not required
-
-Each PCIe node needs to have property msi-parent that points to an MSI
-controller node
-
-Examples:
-
-SoC DTSI:
-
-	+ MSI node:
-	msi@79000000 {
-		compatible = "apm,xgene1-msi";
-		msi-controller;
-		reg = <0x00 0x79000000 0x0 0x900000>;
-		interrupts = 	<0x0 0x10 0x4>
-				<0x0 0x11 0x4>
-				<0x0 0x12 0x4>
-				<0x0 0x13 0x4>
-				<0x0 0x14 0x4>
-				<0x0 0x15 0x4>
-				<0x0 0x16 0x4>
-				<0x0 0x17 0x4>
-				<0x0 0x18 0x4>
-				<0x0 0x19 0x4>
-				<0x0 0x1a 0x4>
-				<0x0 0x1b 0x4>
-				<0x0 0x1c 0x4>
-				<0x0 0x1d 0x4>
-				<0x0 0x1e 0x4>
-				<0x0 0x1f 0x4>;
-	};
-
-	+ PCIe controller node with msi-parent property pointing to MSI node:
-	pcie0: pcie@1f2b0000 {
-		device_type = "pci";
-		compatible = "apm,xgene-storm-pcie", "apm,xgene-pcie";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = < 0x00 0x1f2b0000 0x0 0x00010000   /* Controller registers */
-			0xe0 0xd0000000 0x0 0x00040000>; /* PCI config space */
-		reg-names = "csr", "cfg";
-		ranges = <0x01000000 0x00 0x00000000 0xe0 0x10000000 0x00 0x00010000   /* io */
-			  0x02000000 0x00 0x80000000 0xe1 0x80000000 0x00 0x80000000>; /* mem */
-		dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
-			      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
-		interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-		interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0xc2 0x1
-				 0x0 0x0 0x0 0x2 &gic 0x0 0xc3 0x1
-				 0x0 0x0 0x0 0x3 &gic 0x0 0xc4 0x1
-				 0x0 0x0 0x0 0x4 &gic 0x0 0xc5 0x1>;
-		dma-coherent;
-		clocks = <&pcie0clk 0>;
-		msi-parent= <&msi>;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index d0df1130d5ff..3699fe4be6b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19146,7 +19146,7 @@ M:	Toan Le <toan@os.amperecomputing.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/apm,xgene1-msi.yaml
 F:	drivers/pci/controller/pci-xgene-msi.c
 
 PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
-- 
2.47.2


