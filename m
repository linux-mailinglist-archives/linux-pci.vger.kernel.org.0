Return-Path: <linux-pci+bounces-31866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B2DB00B02
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 20:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DE83B3DF3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA182FC3C7;
	Thu, 10 Jul 2025 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxUQYwjJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BE2253A7;
	Thu, 10 Jul 2025 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170866; cv=none; b=Oj4KrYFm267WOH6oml+pNDBVv0NY1wxdTqkWIQzJdnj2Iept4OosHNCY8y8drRpxT7abF4/9kDm1MtGJT7aNlP5bPYz+r1ERJf/8zmAYOvJtuIOEVvzh0m39X7bJRb/3V7WDoYO4aB3unGp3mO+3xvnxqIPLTHD3HefVbGfbTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170866; c=relaxed/simple;
	bh=V4gnryqigc3pxVGgBOv1Nnsyc77tSETZSUUtdyBC5sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LP6+CesbOeLt767EZF/vQK7p8gtU2PB+ErTKWGNjxuZYXCQcwnys42meaXvtRkM0BlPWWUA0YMzwLs17tXZ01CFhafQ9190IRiJmp7veTR23ftra6wh6Hf0gUE1KbooSsAgKBBIIeFYayiM7fjQvi15k2gGRylv/vnOyS0CAl28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxUQYwjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9988AC4CEE3;
	Thu, 10 Jul 2025 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752170865;
	bh=V4gnryqigc3pxVGgBOv1Nnsyc77tSETZSUUtdyBC5sg=;
	h=From:To:Cc:Subject:Date:From;
	b=pxUQYwjJ3J06T9eBuM4iVVf8me3jFJ8FFjnjcgruiKZolQJBZPdXP2KTTUX+urVwp
	 tFiPpCtA+dbF/0Ct17ggQTqBAwECSfL6lInvuveLO2urgYj6b4Bvwl5sjxIvV8XBIz
	 7Pik5MUCZAzYWh8EiWxKLhqGVpypoGTHxf9YlPlWEKZB8NZsl1GxjU3eV+AN2K6ZOV
	 fa+NFMKDS8Xw7yFRngzgK3g4+PKjCi2Z4gv1x/BvM7rDHvqjhi9XwgJMLoumqdzIw2
	 pdfQSc0qUdFq5K0vjT0wR9hMDdlUuLZmYyqSiCy2LFiiSlysowuOJxNY7jQc+7b2TS
	 1S2ms+AcIjGkg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: Convert axis,artpec6-pcie to DT schema
Date: Thu, 10 Jul 2025 13:07:40 -0500
Message-ID: <20250710180741.2970148-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Axis ARTPEC-6/7 PCIe binding to DT schema format. It's a
straight forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/axis,artpec6-pcie.txt        |  50 --------
 .../bindings/pci/axis,artpec6-pcie.yaml       | 118 ++++++++++++++++++
 2 files changed, 118 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec6-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
deleted file mode 100644
index cc6dcdb676b9..000000000000
--- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Axis ARTPEC-6 PCIe interface
-
-This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in snps,dw-pcie.yaml.
-
-Required properties:
-- compatible: "axis,artpec6-pcie", "snps,dw-pcie" for ARTPEC-6 in RC mode;
-	      "axis,artpec6-pcie-ep", "snps,dw-pcie" for ARTPEC-6 in EP mode;
-	      "axis,artpec7-pcie", "snps,dw-pcie" for ARTPEC-7 in RC mode;
-	      "axis,artpec7-pcie-ep", "snps,dw-pcie" for ARTPEC-7 in EP mode;
-- reg: base addresses and lengths of the PCIe controller (DBI),
-	the PHY controller, and configuration address space.
-- reg-names: Must include the following entries:
-	- "dbi"
-	- "phy"
-	- "config"
-- interrupts: A list of interrupt outputs of the controller. Must contain an
-  entry for each entry in the interrupt-names property.
-- interrupt-names: Must include the following entries:
-	- "msi": The interrupt that is asserted when an MSI is received
-- axis,syscon-pcie: A phandle pointing to the ARTPEC-6 system controller,
-	used to enable and control the Synopsys IP.
-
-Example:
-
-	pcie@f8050000 {
-		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
-		reg = <0xf8050000 0x2000
-		       0xf8040000 0x1000
-		       0xc0000000 0x2000>;
-		reg-names = "dbi", "phy", "config";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-			  /* downstream I/O */
-		ranges = <0x81000000 0 0 0xc0002000 0 0x00010000
-			  /* non-prefetchable memory */
-			  0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>;
-		num-lanes = <2>;
-		bus-range = <0x00 0xff>;
-		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "msi";
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 2 &intc GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 3 &intc GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 4 &intc GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
-		axis,syscon-pcie = <&syscon>;
-	};
diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.yaml b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.yaml
new file mode 100644
index 000000000000..dcc5661aa004
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Axis AB
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/axis,artpec6-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Axis ARTPEC-6 PCIe host controller
+
+maintainers:
+  - Jesper Nilsson <jesper.nilsson@axis.com>
+
+description:
+  This PCIe host controller is based on the Synopsys DesignWare PCIe IP.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - axis,artpec6-pcie
+          - axis,artpec6-pcie-ep
+          - axis,artpec7-pcie
+          - axis,artpec7-pcie-ep
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - axis,artpec6-pcie
+          - axis,artpec6-pcie-ep
+          - axis,artpec7-pcie
+          - axis,artpec7-pcie-ep
+      - const: snps,dw-pcie
+
+  reg:
+    minItems: 3
+    maxItems: 4
+
+  reg-names:
+    minItems: 3
+    maxItems: 4
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: msi
+
+  axis,syscon-pcie:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      System controller phandle used to enable and control the Synopsys IP.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - axis,syscon-pcie
+
+oneOf:
+  - $ref: snps,dw-pcie.yaml#
+    properties:
+      reg:
+        maxItems: 3
+
+      reg-names:
+        items:
+          - const: dbi
+          - const: phy
+          - const: config
+
+  - $ref: snps,dw-pcie-ep.yaml#
+    properties:
+      reg:
+        minItems: 4
+
+      reg-names:
+        items:
+          - const: dbi
+          - const: dbi2
+          - const: phy
+          - const: addr_space
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@f8050000 {
+        compatible = "axis,artpec6-pcie", "snps,dw-pcie";
+        device_type = "pci";
+        reg = <0xf8050000 0x2000
+              0xf8040000 0x1000
+              0xc0000000 0x2000>;
+        reg-names = "dbi", "phy", "config";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x81000000 0 0 0xc0002000 0 0x00010000>,
+                 <0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>;
+        num-lanes = <2>;
+        bus-range = <0x00 0xff>;
+        interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 2 &intc GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 3 &intc GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 4 &intc GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+        axis,syscon-pcie = <&syscon>;
+    };
-- 
2.47.2


