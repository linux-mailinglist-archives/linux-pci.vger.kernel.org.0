Return-Path: <linux-pci+bounces-25877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1EEA88DE8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 23:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4C717B4CE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 21:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0B91EA7D3;
	Mon, 14 Apr 2025 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/w3h7+u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42001A9B28;
	Mon, 14 Apr 2025 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666906; cv=none; b=r3ePwtWJ6158RcSi9eYfV0vkFE4fNnUNRN/ywPpIPSilUcw0ywzigLoZMxcIkxR8m6LoJfWcpXzw+QfRfK+WX3QfC+n1wNDG+b+p87FqK5WubX0n+24yQdE0th7RJHMpvl0/14ZpRlPmKfah3KiWIm65pd1Cve6FhJ3Fclq8IMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666906; c=relaxed/simple;
	bh=56UD9sxCwRsZ7jmoJ4U9OVV4xFNm0c0zNetF7YhUZeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fA/HdsH0U/FqT2QXVWy/nmLZPxMCGo26I+JLDHU6NTMCBQM47DuRyAIXKpF9lvJYBAXacN5Ox/9+GbO6/6ZFJLj1w+zOd3sXJjWTtDSRNDnbVeWB9fZQ9L4mHhjjie+03I9d3+1fk4xWgHTt8rbRXcNYkn0eBymSRxLqo23bJc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/w3h7+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA66C4CEE2;
	Mon, 14 Apr 2025 21:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744666905;
	bh=56UD9sxCwRsZ7jmoJ4U9OVV4xFNm0c0zNetF7YhUZeI=;
	h=From:To:Cc:Subject:Date:From;
	b=X/w3h7+uJbpoc45U8Im/jaz/u/cG+ujt41fwvIrpAmIJdOCUaSGejMTaiZyevJG2J
	 t+kt+uXP+WiIgThFuMHByBxYZS09Q2kPzKJUYFrarJiNWc8ifa5ROHk9gNaqLekk7a
	 dokhETg2y1TWK11lMBI7WqbbzK72h4iTFJSP2bTuPCwH9ZDfIfxCws9l/p71Kq5SFL
	 SPrdF/cStsctggbOwwys1fs7ZAn4gxuvd5Wa5WMqVM/7DHKWG7FCl1qc9eODvbfUsr
	 +x349Lh+pK6nxOe7eFfg3sojB+pzPYh7LFK9IaFockxCr7HITlS7K2k4XgbncgVk7G
	 UDkbcOiIz917A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: Convert marvell,armada8k-pcie to schema
Date: Mon, 14 Apr 2025 16:41:33 -0500
Message-ID: <20250414214135.1680076-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the marvell,armada8k-pcie binding to DT schema. The binding
uses different names for reg, clocks, and phys which have to be added
to the common Synopsys DWC binding.

The "marvell,reset-gpio" property was not documented. Mark it deprecated
as the "reset-gpios" property can be used instead. The "msi-parent"
property was also not documented.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/marvell,armada8k-pcie.yaml   | 100 ++++++++++++++++++
 .../devicetree/bindings/pci/pci-armada8k.txt  |  48 ---------
 .../bindings/pci/snps,dw-pcie-common.yaml     |   3 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   4 +-
 MAINTAINERS                                   |   2 +-
 5 files changed, 106 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/marvell,armada8k-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt

diff --git a/Documentation/devicetree/bindings/pci/marvell,armada8k-pcie.yaml b/Documentation/devicetree/bindings/pci/marvell,armada8k-pcie.yaml
new file mode 100644
index 000000000000..f3ba9230ce2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/marvell,armada8k-pcie.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/marvell,armada8k-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 7K/8K PCIe interface
+
+maintainers:
+  - Thomas Petazzoni <thomas.petazzoni@bootlin.com>
+
+description:
+  This PCIe host controller is based on the Synopsys DesignWare PCIe IP.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - marvell,armada8k-pcie
+  required:
+    - compatible
+
+allOf:
+  - $ref: snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - marvell,armada8k-pcie
+      - const: snps,dw-pcie
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: ctrl
+      - const: config
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: reg
+
+  interrupts:
+    maxItems: 1
+
+  msi-parent:
+    maxItems: 1
+
+  phys:
+    minItems: 1
+    maxItems: 4
+
+  phy-names:
+    minItems: 1
+    maxItems: 4
+
+  marvell,reset-gpio:
+    maxItems: 1
+    deprecated: true
+
+required:
+  - interrupt-map
+  - clocks
+  - msi-parent
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pcie@f2600000 {
+        compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
+        reg = <0xf2600000 0x10000>, <0xf6f00000 0x80000>;
+        reg-names = "ctrl", "config";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <1>;
+        device_type = "pci";
+        dma-coherent;
+        msi-parent = <&gic_v2m0>;
+
+        ranges = <0x81000000 0 0xf9000000 0xf9000000 0 0x10000>,  /* downstream I/O */
+                 <0x82000000 0 0xf6000000 0xf6000000 0 0xf00000>;  /* non-prefetchable memory */
+        interrupt-map-mask = <0 0 0 0>;
+        interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+        interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+        num-lanes = <1>;
+        clocks = <&cpm_syscon0 1 13>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
deleted file mode 100644
index ff25a134befa..000000000000
--- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-* Marvell Armada 7K/8K PCIe interface
-
-This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in snps,dw-pcie.yaml.
-
-Required properties:
-- compatible: "marvell,armada8k-pcie"
-- reg: must contain two register regions
-   - the control register region
-   - the config space region
-- reg-names:
-   - "ctrl" for the control register region
-   - "config" for the config space region
-- interrupts: Interrupt specifier for the PCIe controller
-- clocks: reference to the PCIe controller clocks
-- clock-names: mandatory if there is a second clock, in this case the
-   name must be "core" for the first clock and "reg" for the second
-   one
-
-Optional properties:
-- phys: phandle(s) to PHY node(s) following the generic PHY bindings.
-	Either 1, 2 or 4 PHYs might be needed depending on the number of
-	PCIe lanes.
-- phy-names: names of the PHYs corresponding to the number of lanes.
-	Must be "cp0-pcie0-x4-lane0-phy", "cp0-pcie0-x4-lane1-phy" for
-	2 PHYs.
-
-Example:
-
-	pcie@f2600000 {
-		compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
-		reg = <0 0xf2600000 0 0x10000>, <0 0xf6f00000 0 0x80000>;
-		reg-names = "ctrl", "config";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		device_type = "pci";
-		dma-coherent;
-
-		bus-range = <0 0xff>;
-		ranges = <0x81000000 0 0xf9000000 0  0xf9000000 0 0x10000	/* downstream I/O */
-			  0x82000000 0 0xf6000000 0  0xf6000000 0 0xf00000>;	/* non-prefetchable memory */
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		num-lanes = <1>;
-		clocks = <&cpm_syscon0 1 13>;
-	};
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index dc05761c5cf9..34594972d8db 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -115,7 +115,7 @@ properties:
             above for new bindings.
           oneOf:
             - description: See native 'dbi' clock for details
-              enum: [ pcie, pcie_apb_sys, aclk_dbi ]
+              enum: [ pcie, pcie_apb_sys, aclk_dbi, reg ]
             - description: See native 'mstr/slv' clock for details
               enum: [ pcie_bus, pcie_inbound_axi, pcie_aclk, aclk_mst, aclk_slv ]
             - description: See native 'pipe' clock for details
@@ -201,6 +201,7 @@ properties:
           oneOf:
             - pattern: '^pcie(-?phy[0-9]*)?$'
             - pattern: '^p2u-[0-7]$'
+            - pattern: '^cp[01]-pcie[0-2]-x[124](-lane[0-3])?-phy$'  # marvell,armada8k-pcie
 
   reset-gpio:
     deprecated: true
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 1117a86fb6f7..69e82f438f58 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -105,6 +105,8 @@ properties:
             Vendor-specific CSR names. Consider using the generic names above
             for new bindings.
           oneOf:
+            - description: See native 'dbi' CSR region for details.
+              enum: [ ctrl ]
             - description: See native 'elbi/app' CSR region for details.
               enum: [ apb, mgmt, link, ulreg, appl ]
             - description: See native 'atu' CSR region for details.
@@ -117,7 +119,7 @@ properties:
               const: slcr
     allOf:
       - contains:
-          const: dbi
+          enum: [ dbi, ctrl ]
       - contains:
           const: config
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..9764b87ea304 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18411,7 +18411,7 @@ M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
+F:	Documentation/devicetree/bindings/pci/marvell,armada8k-pcie.yaml
 F:	drivers/pci/controller/dwc/pcie-armada8k.c
 
 PCI DRIVER FOR CADENCE PCIE IP
-- 
2.47.2


