Return-Path: <linux-pci+bounces-31867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8FCB00B04
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 20:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD651C4818F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 18:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AEB2FCE04;
	Thu, 10 Jul 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oal1wbIR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DB2FC3DE;
	Thu, 10 Jul 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170874; cv=none; b=TUAQsooxfWAww/jF9lDWagnb7Zza1zj58dfiGWd0x3Hq4wE+KJdFW2F7VR9d4NagWGQDSJl9Ch3A0oXxtTRYqqeV6XNKSiO8kSwkEyAv/YmEHPWjDxn+0k5xEW2rhOLTcfzajdQhIEIh0U+a7dldwv6V4kSJwFlsqNYqE2H23JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170874; c=relaxed/simple;
	bh=ZQ/AhO5ngZJ87DRDBcdCJYW+ubzFHrCvIl8+BWa/nE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIH8LYYwxKQu42GtW4RMpYTrODOFdb2zuSzONDtN3vOpJVRx+VZSMnEP6KX1EoUR123GSLyGU9il1FCRYv0GahD2TG9yooJx/WfxnI70fINy3N9n0QcRkOlAM4q1xpJbMToq70TJ7YBWCdtf5RfRG/7kOIbEjzr32+NkYM8f7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oal1wbIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A02C4CEF4;
	Thu, 10 Jul 2025 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752170872;
	bh=ZQ/AhO5ngZJ87DRDBcdCJYW+ubzFHrCvIl8+BWa/nE0=;
	h=From:To:Cc:Subject:Date:From;
	b=oal1wbIRJBUEoQmZmfp5F9IGQbbH1RMvd7a7+GHcOMW5DmOEfpDC4pxqnJEYbcktJ
	 xTdWvCP+lQeXHVncdV5ZwR7yHnfC14AoH2evqWcyM3+JZK3hZ8oAkCRjpQjMrLMOZO
	 aOVNDgPq9/ZyK/L26DbmbZ3nezLE/h1pCxVxreaqBaBZp5wMYnpCfiqJnawF7E2tjS
	 jZsd6k0s97nJV9/enrmP93rgCHRdT0C+aWaRNNBfP7BJe/9OxH0MgsUGqdOYZgqPm4
	 Stzlb7qpl9OuJDKJRgjwcEOYMU4MF02wKiuPsGzbz3Tnbp47p9PkqNqanKWwQs6xgx
	 fqf7pN6riLo1A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Toan Le <toan@os.amperecomputing.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: Convert apm,xgene-pcie to DT schema
Date: Thu, 10 Jul 2025 13:07:48 -0500
Message-ID: <20250710180749.2970379-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Applied Micro X-Gene PCIe binding to DT schema format. It's
a straight forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/apm,xgene-pcie.yaml          | 84 +++++++++++++++++++
 .../devicetree/bindings/pci/xgene-pci.txt     | 50 -----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 85 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/apm,xgene-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/xgene-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/apm,xgene-pcie.yaml b/Documentation/devicetree/bindings/pci/apm,xgene-pcie.yaml
new file mode 100644
index 000000000000..2504b8235889
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/apm,xgene-pcie.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/apm,xgene-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AppliedMicro X-Gene PCIe interface
+
+maintainers:
+  - Toan Le <toan@os.amperecomputing.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: apm,xgene-storm-pcie
+          - const: apm,xgene-pcie
+      - items:
+          - const: apm,xgene-pcie
+
+  reg:
+    items:
+      - description: Controller configuration registers
+      - description: PCI configuration space registers
+
+  reg-names:
+    items:
+      - const: csr
+      - const: cfg
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pcie
+
+  dma-coherent: true
+
+  msi-parent:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - '#interrupt-cells'
+  - interrupt-map-mask
+  - interrupt-map
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1f2b0000 {
+            compatible = "apm,xgene-storm-pcie", "apm,xgene-pcie";
+            device_type = "pci";
+            #interrupt-cells = <1>;
+            #size-cells = <2>;
+            #address-cells = <3>;
+            reg = <0x00 0x1f2b0000 0x0 0x00010000>, /* Controller registers */
+                  <0xe0 0xd0000000 0x0 0x00040000>; /* PCI config space */
+            reg-names = "csr", "cfg";
+            ranges = <0x01000000 0x00 0x00000000 0xe0 0x10000000 0x00 0x00010000>, /* io */
+                    <0x02000000 0x00 0x80000000 0xe1 0x80000000 0x00 0x80000000>; /* mem */
+            dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000>,
+                        <0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
+            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+            interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0xc2 0x1>,
+                            <0x0 0x0 0x0 0x2 &gic 0x0 0xc3 0x1>,
+                            <0x0 0x0 0x0 0x3 &gic 0x0 0xc4 0x1>,
+                            <0x0 0x0 0x0 0x4 &gic 0x0 0xc5 0x1>;
+            dma-coherent;
+            clocks = <&pcie0clk 0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/xgene-pci.txt b/Documentation/devicetree/bindings/pci/xgene-pci.txt
deleted file mode 100644
index 92490330dc1c..000000000000
--- a/Documentation/devicetree/bindings/pci/xgene-pci.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* AppliedMicro X-Gene PCIe interface
-
-Required properties:
-- device_type: set to "pci"
-- compatible: should contain "apm,xgene-pcie" to identify the core.
-- reg: A list of physical base address and length for each set of controller
-       registers. Must contain an entry for each entry in the reg-names
-       property.
-- reg-names: Must include the following entries:
-  "csr": controller configuration registers.
-  "cfg": PCIe configuration space registers.
-- #address-cells: set to <3>
-- #size-cells: set to <2>
-- ranges: ranges for the outbound memory, I/O regions.
-- dma-ranges: ranges for the inbound memory regions.
-- #interrupt-cells: set to <1>
-- interrupt-map-mask and interrupt-map: standard PCI properties
-	to define the mapping of the PCIe interface to interrupt
-	numbers.
-- clocks: from common clock binding: handle to pci clock.
-
-Optional properties:
-- status: Either "ok" or "disabled".
-- dma-coherent: Present if DMA operations are coherent
-
-Example:
-
-	pcie0: pcie@1f2b0000 {
-		status = "disabled";
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
-	};
-
diff --git a/MAINTAINERS b/MAINTAINERS
index 3699fe4be6b6..a8e55647487f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18913,7 +18913,7 @@ M:	Toan Le <toan@os.amperecomputing.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/xgene-pci.txt
+F:	Documentation/devicetree/bindings/pci/apm,xgene-pcie.yaml
 F:	drivers/pci/controller/pci-xgene.c
 
 PCI DRIVER FOR ARM VERSATILE PLATFORM
-- 
2.47.2


