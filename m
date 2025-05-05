Return-Path: <linux-pci+bounces-27198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C3BAA9EAD
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 00:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AD5189BD68
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 22:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB626A08C;
	Mon,  5 May 2025 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgZd4LJd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB2613AF2;
	Mon,  5 May 2025 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482515; cv=none; b=mLFfjXf08js+fNXBiLmtemau+mJTC91G+di9Lw8lYPGxUNzfUZZ1h2DxPoE/EFBiKCDLC3SeZVejqY437Zf3ucPIhYHfLEi8RWjGoTAqAL9l7dfKK1lT7Euup0QiKIFF824M7CPR2lG0eCA0iMux/iT+X67w5okKrIABMBPbWCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482515; c=relaxed/simple;
	bh=55XDFxWGcB1qN4x9HaNj27mOmq2XQiQ5ukihNGYhR0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHBV55ld95J1THVkWG4S+O6SQiVNMG7lAITknHIFszVgCdJYG0gsjVUUjzIzVtWlGj6yIhjPNox6DtsL3RdQHuvnlCMasJ5x5yN4Tpyko3mQJ6QAxR65oO3Dequ9dG28s3hsCQEH+NZnzv32Laq+5lWvj5lzG0QMCcBb1U/JWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgZd4LJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8DAC4CEE4;
	Mon,  5 May 2025 22:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746482514;
	bh=55XDFxWGcB1qN4x9HaNj27mOmq2XQiQ5ukihNGYhR0g=;
	h=From:To:Cc:Subject:Date:From;
	b=hgZd4LJddoPofodkRZPGO0Fsu8+KcluN2IQ8vEt2imAePBGrCLgGaHG6I9Sek3Ys0
	 4cHEHwboIttCahfukNXC+sZfH8X8EsfIMkp3yVAsH9ZSDo8FfRNfS0gwUk2A4g4Dhu
	 3JxiJarmSlUBwfPXil1zl0xQrpcLKuK3hSXKXIyecIS6mZ6e1HEsKzmZzXK3NPUazA
	 xW5ss5TszJER/yTTzIO33XBhqJfuCu24Saiv4BRQX6bXY0q0Vo8VkjtWQcQGw/rqje
	 9y+8zY8GrkHlJSKER4MPsUdISttlDMLu1eNGk8blOCkbr+q3kqvuMsO7Ao5jNkF6Ai
	 yuOEKNDlOMNLw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: PCI: Convert v3,v360epc-pci to DT schema
Date: Mon,  5 May 2025 17:01:37 -0500
Message-ID: <20250505220139.2202164-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the v3,v360epc-pci binding to DT schema format.

Add "clocks" which was not documented and is required. Drop "syscon"
which was documented, but is not used.

Drop the "v3,v360epc-pci" compatible by itself as this device is only
used on the Arm Integrator/AP and not likely going to be used anywhere
else at this point.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
- Update MAINTAINERS
---
 .../bindings/pci/v3,v360epc-pci.yaml          | 100 ++++++++++++++++++
 .../bindings/pci/v3-v360epc-pci.txt           |  76 -------------
 MAINTAINERS                                   |   2 +-
 3 files changed, 101 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/v3,v360epc-pci.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/v3,v360epc-pci.yaml b/Documentation/devicetree/bindings/pci/v3,v360epc-pci.yaml
new file mode 100644
index 000000000000..38cac88f17bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/v3,v360epc-pci.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/v3,v360epc-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: V3 Semiconductor V360 EPC PCI bridge
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  This bridge is found in the ARM Integrator/AP (Application Platform)
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: arm,integrator-ap-pci
+      - const: v3,v360epc-pci
+
+  reg:
+    items:
+      - description: V3 host bridge controller
+      - description: Configuration space
+
+  clocks:
+    maxItems: 1
+
+  dma-ranges:
+    maxItems: 2
+    description:
+      The inbound ranges must be aligned to a 1MB boundary, and may be 1MB, 2MB,
+      4MB, 8MB, 16MB, 32MB, 64MB, 128MB, 256MB, 512MB, 1GB or 2GB in size. The
+      memory should be marked as pre-fetchable.
+
+  interrupts:
+    description: Bus Error IRQ
+    maxItems: 1
+
+  ranges:
+    description:
+      The non-prefetchable and prefetchable memory windows must each be exactly
+      256MB (0x10000000) in size. The prefetchable memory window must be
+      immediately adjacent to the non-prefetchable memory window.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - dma-ranges
+  - "#interrupt-cells"
+  - interrupt-map
+  - interrupt-map-mask
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pci@62000000 {
+        compatible = "arm,integrator-ap-pci", "v3,v360epc-pci";
+        #interrupt-cells = <1>;
+        #size-cells = <2>;
+        #address-cells = <3>;
+        reg = <0x62000000 0x10000>, <0x61000000 0x01000000>;
+        device_type = "pci";
+        interrupt-parent = <&pic>;
+        interrupts = <17>; /* Bus error IRQ */
+        clocks = <&pciclk>;
+        ranges = <0x01000000 0 0x00000000 0x60000000 0 0x01000000>,     /* 16 MiB @ LB 60000000 */
+                 <0x02000000 0 0x40000000 0x40000000 0 0x10000000>,     /* 256 MiB @ LB 40000000 1:1 */
+                 <0x42000000 0 0x50000000 0x50000000 0 0x10000000>;     /* 256 MiB @ LB 50000000 1:1 */
+        dma-ranges = <0x02000000 0 0x20000000 0x20000000 0 0x20000000>, /* EBI: 512 MB @ LB 20000000 1:1 */
+                     <0x02000000 0 0x80000000 0x80000000 0 0x40000000>; /* CM alias: 1GB @ LB 80000000 */
+        interrupt-map-mask = <0xf800 0 0 0x7>;
+        interrupt-map =
+            /* IDSEL 9 */
+            <0x4800 0 0 1 &pic 13>, /* INT A on slot 9 is irq 13 */
+            <0x4800 0 0 2 &pic 14>, /* INT B on slot 9 is irq 14 */
+            <0x4800 0 0 3 &pic 15>, /* INT C on slot 9 is irq 15 */
+            <0x4800 0 0 4 &pic 16>, /* INT D on slot 9 is irq 16 */
+            /* IDSEL 10 */
+            <0x5000 0 0 1 &pic 14>, /* INT A on slot 10 is irq 14 */
+            <0x5000 0 0 2 &pic 15>, /* INT B on slot 10 is irq 15 */
+            <0x5000 0 0 3 &pic 16>, /* INT C on slot 10 is irq 16 */
+            <0x5000 0 0 4 &pic 13>, /* INT D on slot 10 is irq 13 */
+            /* IDSEL 11 */
+            <0x5800 0 0 1 &pic 15>, /* INT A on slot 11 is irq 15 */
+            <0x5800 0 0 2 &pic 16>, /* INT B on slot 11 is irq 16 */
+            <0x5800 0 0 3 &pic 13>, /* INT C on slot 11 is irq 13 */
+            <0x5800 0 0 4 &pic 14>, /* INT D on slot 11 is irq 14 */
+            /* IDSEL 12 */
+            <0x6000 0 0 1 &pic 16>, /* INT A on slot 12 is irq 16 */
+            <0x6000 0 0 2 &pic 13>, /* INT B on slot 12 is irq 13 */
+            <0x6000 0 0 3 &pic 14>, /* INT C on slot 12 is irq 14 */
+            <0x6000 0 0 4 &pic 15>; /* INT D on slot 12 is irq 15 */
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt b/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
deleted file mode 100644
index 11063293f761..000000000000
--- a/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
+++ /dev/null
@@ -1,76 +0,0 @@
-V3 Semiconductor V360 EPC PCI bridge
-
-This bridge is found in the ARM Integrator/AP (Application Platform)
-
-Required properties:
-- compatible: should be one of:
-  "v3,v360epc-pci"
-  "arm,integrator-ap-pci", "v3,v360epc-pci"
-- reg: should contain two register areas:
-  first the base address of the V3 host bridge controller, 64KB
-  second the configuration area register space, 16MB
-- interrupts: should contain a reference to the V3 error interrupt
-  as routed on the system.
-- bus-range: see pci.txt
-- ranges: this follows the standard PCI bindings in the IEEE Std
-  1275-1994 (see pci.txt) with the following restriction:
-  - The non-prefetchable and prefetchable memory windows must
-    each be exactly 256MB (0x10000000) in size.
-  - The prefetchable memory window must be immediately adjacent
-    to the non-prefetcable memory window
-- dma-ranges: three ranges for the inbound memory region. The ranges must
-  be aligned to a 1MB boundary, and may be 1MB, 2MB, 4MB, 8MB, 16MB, 32MB,
-  64MB, 128MB, 256MB, 512MB, 1GB or 2GB in size. The memory should be marked
-  as pre-fetchable. Two ranges are supported by the hardware.
-
-Integrator-specific required properties:
-- syscon: should contain a link to the syscon device node, since
-  on the Integrator, some registers in the syscon are required to
-  operate the V3 host bridge.
-
-Example:
-
-pci: pciv3@62000000 {
-	compatible = "arm,integrator-ap-pci", "v3,v360epc-pci";
-	#interrupt-cells = <1>;
-	#size-cells = <2>;
-	#address-cells = <3>;
-	reg = <0x62000000 0x10000>, <0x61000000 0x01000000>;
-	interrupt-parent = <&pic>;
-	interrupts = <17>; /* Bus error IRQ */
-	clocks = <&pciclk>;
-	bus-range = <0x00 0xff>;
-	ranges = 0x01000000 0 0x00000000 /* I/O space @00000000 */
-		0x60000000 0 0x01000000 /* 16 MiB @ LB 60000000 */
-		0x02000000 0 0x40000000 /* non-prefectable memory @40000000 */
-		0x40000000 0 0x10000000 /* 256 MiB @ LB 40000000 1:1 */
-		0x42000000 0 0x50000000 /* prefetchable memory @50000000 */
-		0x50000000 0 0x10000000>; /* 256 MiB @ LB 50000000 1:1 */
-	dma-ranges = <0x02000000 0 0x20000000 /* EBI memory space */
-		0x20000000 0 0x20000000 /* 512 MB @ LB 20000000 1:1 */
-		0x02000000 0 0x80000000 /* Core module alias memory */
-		0x80000000 0 0x40000000>; /* 1GB @ LB 80000000 */
-	interrupt-map-mask = <0xf800 0 0 0x7>;
-	interrupt-map = <
-	/* IDSEL 9 */
-	0x4800 0 0 1 &pic 13 /* INT A on slot 9 is irq 13 */
-	0x4800 0 0 2 &pic 14 /* INT B on slot 9 is irq 14 */
-	0x4800 0 0 3 &pic 15 /* INT C on slot 9 is irq 15 */
-	0x4800 0 0 4 &pic 16 /* INT D on slot 9 is irq 16 */
-	/* IDSEL 10 */
-	0x5000 0 0 1 &pic 14 /* INT A on slot 10 is irq 14 */
-	0x5000 0 0 2 &pic 15 /* INT B on slot 10 is irq 15 */
-	0x5000 0 0 3 &pic 16 /* INT C on slot 10 is irq 16 */
-	0x5000 0 0 4 &pic 13 /* INT D on slot 10 is irq 13 */
-	/* IDSEL 11 */
-	0x5800 0 0 1 &pic 15 /* INT A on slot 11 is irq 15 */
-	0x5800 0 0 2 &pic 16 /* INT B on slot 11 is irq 16 */
-	0x5800 0 0 3 &pic 13 /* INT C on slot 11 is irq 13 */
-	0x5800 0 0 4 &pic 14 /* INT D on slot 11 is irq 14 */
-	/* IDSEL 12 */
-	0x6000 0 0 1 &pic 16 /* INT A on slot 12 is irq 16 */
-	0x6000 0 0 2 &pic 13 /* INT B on slot 12 is irq 13 */
-	0x6000 0 0 3 &pic 14 /* INT C on slot 12 is irq 14 */
-	0x6000 0 0 4 &pic 15 /* INT D on slot 12 is irq 15 */
-	>;
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index 63e804277519..e4a753c5b671 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18569,7 +18569,7 @@ PCI DRIVER FOR V3 SEMICONDUCTOR V360EPC
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
+F:	Documentation/devicetree/bindings/pci/v3,v360epc-pci.yaml
 F:	drivers/pci/controller/pci-v3-semi.c
 
 PCI DRIVER FOR XILINX VERSAL CPM
-- 
2.47.2


