Return-Path: <linux-pci+bounces-39526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFD1C14A0E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 13:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFDAF4200B4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 12:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA6A32E150;
	Tue, 28 Oct 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="HhTdPZ6k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B832D7D8;
	Tue, 28 Oct 2025 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654550; cv=none; b=kF6Se84noEVyRPTwZNE/9waWDdFKohGQTGg/rua1gLyhGqonC3lF6Zp5c/0nHjU2rk4FNDjGQs7UXuGXZIJTdLn4cpRlS82m1isaAXirXhvnjUfricgF0q04qrNgn0u6TudbchnB2qh9JBI7aAw+60etHtzIywYJycavVLedSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654550; c=relaxed/simple;
	bh=X2PcndL3We/ZUv58nLYjyLUtmdgWBZvyYxK1u/UV+5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTbFosLQaXTBIrL296s3E4wY8h3uTcxtBXAbjxxvdzW/TMx8sKKm9F/j1xv/ijWItCsKsJDLwseIZFtiX4FLAj2flRIvDL7Di0xSmGvuAJelspCs0EkL7T3CD2MXohauiG7s3mTc8MnuV5d8T179EWuOAhwdwj4uRwx+S6Myoko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=HhTdPZ6k; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id 4354D5FD70;
	Tue, 28 Oct 2025 12:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1761654544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uIDQiFNbfRO8K6+0OUU5qkSCkOGmK/G0ptz9lI6GuYE=;
	b=HhTdPZ6kYhlFhHBsHexWTicQNFU5DO5MeoeJ91pwSWk0txicCe7jEXe1EPdN0erCjHHD51
	USOHXil3HP52hCz14jtn+j9G4O3TrdsEOGrlPh5r5LbwYi3+NIotzImtmO4YLYVDp3NKRi
	QNNtd+Gnc6a2gaqn/wzONItyfZpipH8=
Received: from frank-u24.. (fttx-pool-217.61.144.172.bambit.de [217.61.144.172])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id EF43B1226C0;
	Tue, 28 Oct 2025 12:29:03 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC v1] dt-bindings: PCI: convert mediatek-pcie binding to yaml
Date: Tue, 28 Oct 2025 13:28:55 +0100
Message-ID: <20251028122856.121595-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Try to convert the text-binding into a yaml based one to fix some binding
errors for mediatek.

The SoCs handled are very different (clock-count,-names,phys,resets,...)
but handled in one driver.

I'm not sure i did it right, so this is only an RFC :)

only 1 exapmple possible because all are put in one dts-file and includes
affecting each other

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../devicetree/bindings/pci/mediatek-pcie.txt | 289 -----------
 .../bindings/pci/mediatek-pcie.yaml           | 486 ++++++++++++++++++
 2 files changed, 486 insertions(+), 289 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
deleted file mode 100644
index 684227522267..000000000000
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
+++ /dev/null
@@ -1,289 +0,0 @@
-MediaTek Gen2 PCIe controller
-
-Required properties:
-- compatible: Should contain one of the following strings:
-	"mediatek,mt2701-pcie"
-	"mediatek,mt2712-pcie"
-	"mediatek,mt7622-pcie"
-	"mediatek,mt7623-pcie"
-	"mediatek,mt7629-pcie"
-	"airoha,en7523-pcie"
-- device_type: Must be "pci"
-- reg: Base addresses and lengths of the root ports.
-- reg-names: Names of the above areas to use during resource lookup.
-- #address-cells: Address representation for root ports (must be 3)
-- #size-cells: Size representation for root ports (must be 2)
-- clocks: Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names:
-  Mandatory entries:
-   - sys_ckN :transaction layer and data link layer clock
-  Required entries for MT2701/MT7623:
-   - free_ck :for reference clock of PCIe subsys
-  Required entries for MT2712/MT7622:
-   - ahb_ckN :AHB slave interface operating clock for CSR access and RC
-	      initiated MMIO access
-  Required entries for MT7622:
-   - axi_ckN :application layer MMIO channel operating clock
-   - aux_ckN :pe2_mac_bridge and pe2_mac_core operating clock when
-	      pcie_mac_ck/pcie_pipe_ck is turned off
-   - obff_ckN :OBFF functional block operating clock
-   - pipe_ckN :LTSSM and PHY/MAC layer operating clock
-  where N starting from 0 to one less than the number of root ports.
-- phys: List of PHY specifiers (used by generic PHY framework).
-- phy-names : Must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
-  number of PHYs as specified in *phys* property.
-- power-domains: A phandle and power domain specifier pair to the power domain
-  which is responsible for collapsing and restoring power to the peripheral.
-- bus-range: Range of bus numbers associated with this controller.
-- ranges: Ranges for the PCI memory and I/O regions.
-
-Required properties for MT7623/MT2701:
-- #interrupt-cells: Size representation for interrupts (must be 1)
-- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
-  Please refer to the standard PCI bus binding document for a more detailed
-  explanation.
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: Must be "pcie-rst0", "pcie-rst1", "pcie-rstN".. based on the
-  number of root ports.
-
-Required properties for MT2712/MT7622/MT7629:
--interrupts: A list of interrupt outputs of the controller, must have one
-	     entry for each PCIe port
-- interrupt-names: Must include the following entries:
-	- "pcie_irq": The interrupt that is asserted when an MSI/INTX is received
-- linux,pci-domain: PCI domain ID. Should be unique for each host controller
-
-In addition, the device tree node must have sub-nodes describing each
-PCIe port interface, having the following mandatory properties:
-
-Required properties:
-- device_type: Must be "pci"
-- reg: Only the first four bytes are used to refer to the correct bus number
-  and device number.
-- #address-cells: Must be 3
-- #size-cells: Must be 2
-- #interrupt-cells: Must be 1
-- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
-  Please refer to the standard PCI bus binding document for a more detailed
-  explanation.
-- ranges: Sub-ranges distributed from the PCIe controller node. An empty
-  property is sufficient.
-
-Examples for MT7623:
-
-	hifsys: syscon@1a000000 {
-		compatible = "mediatek,mt7623-hifsys",
-			     "mediatek,mt2701-hifsys",
-			     "syscon";
-		reg = <0 0x1a000000 0 0x1000>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-	pcie: pcie@1a140000 {
-		compatible = "mediatek,mt7623-pcie";
-		device_type = "pci";
-		reg = <0 0x1a140000 0 0x1000>, /* PCIe shared registers */
-		      <0 0x1a142000 0 0x1000>, /* Port0 registers */
-		      <0 0x1a143000 0 0x1000>, /* Port1 registers */
-		      <0 0x1a144000 0 0x1000>; /* Port2 registers */
-		reg-names = "subsys", "port0", "port1", "port2";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0xf800 0 0 0>;
-		interrupt-map = <0x0000 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>,
-				<0x0800 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>,
-				<0x1000 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
-			 <&hifsys CLK_HIFSYS_PCIE0>,
-			 <&hifsys CLK_HIFSYS_PCIE1>,
-			 <&hifsys CLK_HIFSYS_PCIE2>;
-		clock-names = "free_ck", "sys_ck0", "sys_ck1", "sys_ck2";
-		resets = <&hifsys MT2701_HIFSYS_PCIE0_RST>,
-			 <&hifsys MT2701_HIFSYS_PCIE1_RST>,
-			 <&hifsys MT2701_HIFSYS_PCIE2_RST>;
-		reset-names = "pcie-rst0", "pcie-rst1", "pcie-rst2";
-		phys = <&pcie0_phy PHY_TYPE_PCIE>, <&pcie1_phy PHY_TYPE_PCIE>,
-		       <&pcie2_phy PHY_TYPE_PCIE>;
-		phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
-		bus-range = <0x00 0xff>;
-		ranges = <0x81000000 0 0x1a160000 0 0x1a160000 0 0x00010000	/* I/O space */
-			  0x83000000 0 0x60000000 0 0x60000000 0 0x10000000>;	/* memory space */
-
-		pcie@0,0 {
-			reg = <0x0000 0 0 0 0>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>;
-			ranges;
-		};
-
-		pcie@1,0 {
-			reg = <0x0800 0 0 0 0>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
-			ranges;
-		};
-
-		pcie@2,0 {
-			reg = <0x1000 0 0 0 0>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
-			ranges;
-		};
-	};
-
-Examples for MT2712:
-
-	pcie1: pcie@112ff000 {
-		compatible = "mediatek,mt2712-pcie";
-		device_type = "pci";
-		reg = <0 0x112ff000 0 0x1000>;
-		reg-names = "port1";
-		linux,pci-domain = <1>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "pcie_irq";
-		clocks = <&topckgen CLK_TOP_PE2_MAC_P1_SEL>,
-			 <&pericfg CLK_PERI_PCIE1>;
-		clock-names = "sys_ck1", "ahb_ck1";
-		phys = <&u3port1 PHY_TYPE_PCIE>;
-		phy-names = "pcie-phy1";
-		bus-range = <0x00 0xff>;
-		ranges = <0x82000000 0 0x11400000  0x0 0x11400000  0 0x300000>;
-		status = "disabled";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pcie_intc1 0>,
-				<0 0 0 2 &pcie_intc1 1>,
-				<0 0 0 3 &pcie_intc1 2>,
-				<0 0 0 4 &pcie_intc1 3>;
-		pcie_intc1: interrupt-controller {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-		};
-	};
-
-	pcie0: pcie@11700000 {
-		compatible = "mediatek,mt2712-pcie";
-		device_type = "pci";
-		reg = <0 0x11700000 0 0x1000>;
-		reg-names = "port0";
-		linux,pci-domain = <0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "pcie_irq";
-		clocks = <&topckgen CLK_TOP_PE2_MAC_P0_SEL>,
-			 <&pericfg CLK_PERI_PCIE0>;
-		clock-names = "sys_ck0", "ahb_ck0";
-		phys = <&u3port0 PHY_TYPE_PCIE>;
-		phy-names = "pcie-phy0";
-		bus-range = <0x00 0xff>;
-		ranges = <0x82000000 0 0x20000000 0x0 0x20000000 0 0x10000000>;
-		status = "disabled";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pcie_intc0 0>,
-				<0 0 0 2 &pcie_intc0 1>,
-				<0 0 0 3 &pcie_intc0 2>,
-				<0 0 0 4 &pcie_intc0 3>;
-		pcie_intc0: interrupt-controller {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-		};
-	};
-
-Examples for MT7622:
-
-	pcie0: pcie@1a143000 {
-		compatible = "mediatek,mt7622-pcie";
-		device_type = "pci";
-		reg = <0 0x1a143000 0 0x1000>;
-		reg-names = "port0";
-		linux,pci-domain = <0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-names = "pcie_irq";
-		clocks = <&pciesys CLK_PCIE_P0_MAC_EN>,
-			 <&pciesys CLK_PCIE_P0_AHB_EN>,
-			 <&pciesys CLK_PCIE_P0_AUX_EN>,
-			 <&pciesys CLK_PCIE_P0_AXI_EN>,
-			 <&pciesys CLK_PCIE_P0_OBFF_EN>,
-			 <&pciesys CLK_PCIE_P0_PIPE_EN>;
-		clock-names = "sys_ck0", "ahb_ck0", "aux_ck0",
-			      "axi_ck0", "obff_ck0", "pipe_ck0";
-
-		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
-		bus-range = <0x00 0xff>;
-		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x8000000>;
-		status = "disabled";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pcie_intc0 0>,
-				<0 0 0 2 &pcie_intc0 1>,
-				<0 0 0 3 &pcie_intc0 2>,
-				<0 0 0 4 &pcie_intc0 3>;
-		pcie_intc0: interrupt-controller {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-		};
-	};
-
-	pcie1: pcie@1a145000 {
-		compatible = "mediatek,mt7622-pcie";
-		device_type = "pci";
-		reg = <0 0x1a145000 0 0x1000>;
-		reg-names = "port1";
-		linux,pci-domain = <1>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-names = "pcie_irq";
-		clocks = <&pciesys CLK_PCIE_P1_MAC_EN>,
-			 /* designer has connect RC1 with p0_ahb clock */
-			 <&pciesys CLK_PCIE_P0_AHB_EN>,
-			 <&pciesys CLK_PCIE_P1_AUX_EN>,
-			 <&pciesys CLK_PCIE_P1_AXI_EN>,
-			 <&pciesys CLK_PCIE_P1_OBFF_EN>,
-			 <&pciesys CLK_PCIE_P1_PIPE_EN>;
-		clock-names = "sys_ck1", "ahb_ck1", "aux_ck1",
-			      "axi_ck1", "obff_ck1", "pipe_ck1";
-
-		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
-		bus-range = <0x00 0xff>;
-		ranges = <0x82000000 0 0x28000000  0x0 0x28000000  0 0x8000000>;
-		status = "disabled";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pcie_intc1 0>,
-				<0 0 0 2 &pcie_intc1 1>,
-				<0 0 0 3 &pcie_intc1 2>,
-				<0 0 0 4 &pcie_intc1 3>;
-		pcie_intc1: interrupt-controller {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
new file mode 100644
index 000000000000..6d464b96b13d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
@@ -0,0 +1,486 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/mediatek-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Gen2 PCIe controller
+
+maintainers:
+  - Jianjun Wang <jianjun.wang@mediatek.com>
+
+description: |+
+  PCIe Gen2 MAC controller for MediaTek SoCs.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2701-pcie
+              - mediatek,mt2712-pcie
+              - mediatek,mt7622-pcie
+              - mediatek,mt7623-pcie
+              - mediatek,mt7629-pcie
+      - items:
+          - enum:
+              - airoha,en7523-pcie
+          - const: mediatek,mt7622-pcie
+
+  reg:
+    minItems: 1
+    maxItems: 4
+
+  reg-names:
+    minItems: 1
+    maxItems: 4
+
+  interrupts:
+    maxItems: 1
+
+  ranges:
+    minItems: 1
+    maxItems: 8
+
+  iommu-map:
+    maxItems: 1
+
+  iommu-map-mask:
+    const: 0
+
+  resets:
+    minItems: 1
+    maxItems: 3
+
+  reset-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum: [ pcie-rst0, pcie-rst1, pcie-rst2 ]
+
+  clocks:
+    minItems: 1
+    maxItems: 6
+
+  clock-names:
+    minItems: 1
+    maxItems: 6
+
+  device_type:
+    const: pci
+
+  '#address-cells':
+    const: 3
+
+  '#size-cells':
+    const: 2
+
+  assigned-clocks:
+    maxItems: 3
+
+  assigned-clock-parents:
+    maxItems: 3
+
+  phys:
+    minItems: 1
+    maxItems: 3
+
+  phy-names:
+    minItems: 1
+    maxItems: 3
+
+  power-domains:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupt-controller:
+    description: Interrupt controller node for handling legacy PCI interrupts.
+    type: object
+    properties:
+      '#address-cells':
+        const: 0
+      '#interrupt-cells':
+        const: 1
+      interrupt-controller: true
+
+    required:
+      - '#address-cells'
+      - '#interrupt-cells'
+      - interrupt-controller
+
+    additionalProperties: false
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 1
+
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - ranges
+  - clocks
+  - clock-names
+  - '#interrupt-cells'
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt2701-pcie
+              - mediatek,mt7623-pcie
+    then:
+      properties:
+        clocks:
+          minItems: 4
+
+        clock-names:
+          items:
+            - const: free_ck
+            - const: sys_ck0
+            - const: sys_ck1
+            - const: sys_ck2
+
+        phy-names:
+          items:
+            - const: pcie-phy0
+            - const: pcie-phy1
+            - const: pcie-phy2
+
+        reg-names:
+          items:
+            - const: subsys
+            - const: port0
+            - const: port1
+            - const: port2
+
+        resets:
+          minItems: 3
+          maxItems: 3
+
+        reset-names:
+          items:
+            - const: pcie-rst0
+            - const: pcie-rst1
+            - const: pcie-rst2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt2712-pcie
+
+    then:
+      properties:
+        clocks:
+          minItems: 2
+
+        clock-names:
+          items:
+            - enum: [sys_ck0, sys_ck1]
+            - enum: [ahb_ck0, ahb_ck1]
+
+        phy-names:
+          items:
+            - enum: [pcie-phy0, pcie-phy1, pcie-phy2]
+
+        reg-names:
+          items:
+            enum: [port0, port1]
+
+        resets:
+          minItems: 1
+          maxItems: 2
+
+        reset-names:
+          minItems: 1
+          maxItems: 2
+
+      required:
+        - interrupts
+        - interrupt-names
+        - linux,pci-domain
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt7622-pcie
+
+    then:
+      properties:
+        clocks:
+          minItems: 1
+
+        reg-names:
+          items:
+            - enum: [port0, port1]
+
+        clock-names:
+          minItems: 1
+          items:
+            - enum: [sys_ck0, sys_ck1]
+            - enum: [ahb_ck0, ahb_ck1]
+            - enum: [aux_ck0, aux_ck1]
+            - enum: [axi_ck0, axi_ck1]
+            - enum: [obff_ck0, obff_ck1]
+            - enum: [pipe_ck0, pipe_ck1]
+
+      required:
+        - interrupts
+        - interrupt-names
+        - linux,pci-domain
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt7629-pcie
+
+    then:
+      required:
+        - interrupts
+        - interrupt-names
+        - linux,pci-domain
+
+unevaluatedProperties: false
+
+examples:
+#  - |
+#    #include <dt-bindings/interrupt-controller/arm-gic.h>
+#    #include <dt-bindings/interrupt-controller/irq.h>
+#    #include <dt-bindings/clock/mt2701-clk.h>
+#    #include <dt-bindings/reset/mt2701-resets.h>
+#    #include <dt-bindings/phy/phy.h>
+#    #include <dt-bindings/power/mt2701-power.h>
+
+#    soc {
+#    #address-cells = <2>;
+#    #size-cells = <2>;
+#    hifsys: syscon@1a000000 {
+#        compatible = "mediatek,mt7623-hifsys",
+#                 "mediatek,mt2701-hifsys",
+#                 "syscon";
+#        reg = <0 0x1a000000 0 0x1000>;
+#        #clock-cells = <1>;
+#        #reset-cells = <1>;
+#    };
+#    pcie: pcie@1a140000 {
+#        compatible = "mediatek,mt7623-pcie";
+#        device_type = "pci";
+#        reg = <0 0x1a140000 0 0x1000>, /* PCIe shared registers */
+#              <0 0x1a142000 0 0x1000>, /* Port0 registers */
+#              <0 0x1a143000 0 0x1000>, /* Port1 registers */
+#              <0 0x1a144000 0 0x1000>; /* Port2 registers */
+#        reg-names = "subsys", "port0", "port1", "port2";
+#        #address-cells = <3>;
+#        #size-cells = <2>;
+#        #interrupt-cells = <1>;
+#        interrupt-map-mask = <0xf800 0 0 0>;
+#        interrupt-map = <0x0000 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>,
+#                <0x0800 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>,
+#                <0x1000 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
+#        clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
+#             <&hifsys CLK_HIFSYS_PCIE0>,
+#             <&hifsys CLK_HIFSYS_PCIE1>,
+#             <&hifsys CLK_HIFSYS_PCIE2>;
+#        clock-names = "free_ck", "sys_ck0", "sys_ck1", "sys_ck2";
+#        resets = <&hifsys MT2701_HIFSYS_PCIE0_RST>,
+#             <&hifsys MT2701_HIFSYS_PCIE1_RST>,
+#             <&hifsys MT2701_HIFSYS_PCIE2_RST>;
+#        reset-names = "pcie-rst0", "pcie-rst1", "pcie-rst2";
+#        phys = <&pcie0_phy PHY_TYPE_PCIE>, <&pcie1_phy PHY_TYPE_PCIE>,
+#               <&pcie2_phy PHY_TYPE_PCIE>;
+#        phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
+#        power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
+#        bus-range = <0x00 0xff>;
+#        ranges = <0x81000000 0 0x1a160000 0 0x1a160000 0 0x00010000    /* I/O space */
+#              0x83000000 0 0x60000000 0 0x60000000 0 0x10000000>;    /* memory space */
+#        pcie@0,0 {
+#            reg = <0x0000 0 0 0 0>;
+#            #address-cells = <3>;
+#            #size-cells = <2>;
+#            #interrupt-cells = <1>;
+#            interrupt-map-mask = <0 0 0 0>;
+#            interrupt-map = <0 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>;
+#            ranges;
+#        };
+#        pcie@1,0 {
+#            reg = <0x0800 0 0 0 0>;
+#            #address-cells = <3>;
+#            #size-cells = <2>;
+#            #interrupt-cells = <1>;
+#            interrupt-map-mask = <0 0 0 0>;
+#            interrupt-map = <0 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
+#            ranges;
+#        };
+#        pcie@2,0 {
+#            reg = <0x1000 0 0 0 0>;
+#            #address-cells = <3>;
+#            #size-cells = <2>;
+#            #interrupt-cells = <1>;
+#            interrupt-map-mask = <0 0 0 0>;
+#            interrupt-map = <0 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
+#            ranges;
+#        };
+#    };
+#    };
+#  - |
+#    #include <dt-bindings/interrupt-controller/arm-gic.h>
+#    #include <dt-bindings/interrupt-controller/irq.h>
+#    #include <dt-bindings/clock/mt2712-clk.h>
+#    #include <dt-bindings/phy/phy.h>
+#    soc {
+#    #address-cells = <2>;
+#    #size-cells = <2>;
+#    pcie1: pcie@112ff000 {
+#        compatible = "mediatek,mt2712-pcie";
+#        device_type = "pci";
+#        reg = <0 0x112ff000 0 0x1000>;
+#        reg-names = "port1";
+#        linux,pci-domain = <1>;
+#        #address-cells = <3>;
+#        #size-cells = <2>;
+#        interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+#        interrupt-names = "pcie_irq";
+#        clocks = <&topckgen CLK_TOP_PE2_MAC_P1_SEL>,
+#             <&pericfg CLK_PERI_PCIE1>;
+#        clock-names = "sys_ck1", "ahb_ck1";
+#        phys = <&u3port1 PHY_TYPE_PCIE>;
+#        phy-names = "pcie-phy1";
+#        bus-range = <0x00 0xff>;
+#        ranges = <0x82000000 0 0x11400000  0x0 0x11400000  0 0x300000>;
+#        status = "disabled";
+#        #interrupt-cells = <1>;
+#        interrupt-map-mask = <0 0 0 7>;
+#        interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+#                <0 0 0 2 &pcie_intc1 1>,
+#                <0 0 0 3 &pcie_intc1 2>,
+#                <0 0 0 4 &pcie_intc1 3>;
+#        pcie_intc1: interrupt-controller {
+#            interrupt-controller;
+#            #address-cells = <0>;
+#            #interrupt-cells = <1>;
+#        };
+#     };
+#     pcie0: pcie@11700000 {
+#        compatible = "mediatek,mt2712-pcie";
+#        device_type = "pci";
+#        reg = <0 0x11700000 0 0x1000>;
+#        reg-names = "port0";
+#        linux,pci-domain = <0>;
+#        #address-cells = <3>;
+#        #size-cells = <2>;
+#        interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+#        interrupt-names = "pcie_irq";
+#        clocks = <&topckgen CLK_TOP_PE2_MAC_P0_SEL>,
+#             <&pericfg CLK_PERI_PCIE0>;
+#        clock-names = "sys_ck0", "ahb_ck0";
+#        phys = <&u3port0 PHY_TYPE_PCIE>;
+#        phy-names = "pcie-phy0";
+#        bus-range = <0x00 0xff>;
+#        ranges = <0x82000000 0 0x20000000 0x0 0x20000000 0 0x10000000>;
+#        status = "disabled";
+#        #interrupt-cells = <1>;
+#        interrupt-map-mask = <0 0 0 7>;
+#        interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+#                <0 0 0 2 &pcie_intc0 1>,
+#                <0 0 0 3 &pcie_intc0 2>,
+#                <0 0 0 4 &pcie_intc0 3>;
+#        pcie_intc0: interrupt-controller {
+#            interrupt-controller;
+#            #address-cells = <0>;
+#            #interrupt-cells = <1>;
+#        };
+#    };
+#    };
+#
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mt7622-clk.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/power/mt7622-power.h>
+    #include <dt-bindings/reset/mt7622-reset.h>
+    soc {
+    #address-cells = <2>;
+    #size-cells = <2>;
+    pcie0: pcie@1a143000 {
+        compatible = "mediatek,mt7622-pcie";
+        device_type = "pci";
+        reg = <0 0x1a143000 0 0x1000>;
+        reg-names = "port0";
+        linux,pci-domain = <0>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-names = "pcie_irq";
+        clocks = <&pciesys CLK_PCIE_P0_MAC_EN>,
+             <&pciesys CLK_PCIE_P0_AHB_EN>,
+             <&pciesys CLK_PCIE_P0_AUX_EN>,
+             <&pciesys CLK_PCIE_P0_AXI_EN>,
+             <&pciesys CLK_PCIE_P0_OBFF_EN>,
+             <&pciesys CLK_PCIE_P0_PIPE_EN>;
+        clock-names = "sys_ck0", "ahb_ck0", "aux_ck0",
+                  "axi_ck0", "obff_ck0", "pipe_ck0";
+        power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
+        bus-range = <0x00 0xff>;
+        ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x8000000>;
+        status = "disabled";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+                <0 0 0 2 &pcie_intc0 1>,
+                <0 0 0 3 &pcie_intc0 2>,
+                <0 0 0 4 &pcie_intc0 3>;
+        pcie_intc0: interrupt-controller {
+            interrupt-controller;
+            #address-cells = <0>;
+            #interrupt-cells = <1>;
+        };
+    };
+    pcie1: pcie@1a145000 {
+        compatible = "mediatek,mt7622-pcie";
+        device_type = "pci";
+        reg = <0 0x1a145000 0 0x1000>;
+        reg-names = "port1";
+        linux,pci-domain = <1>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-names = "pcie_irq";
+        clocks = <&pciesys CLK_PCIE_P1_MAC_EN>,
+             /* designer has connect RC1 with p0_ahb clock */
+             <&pciesys CLK_PCIE_P0_AHB_EN>,
+             <&pciesys CLK_PCIE_P1_AUX_EN>,
+             <&pciesys CLK_PCIE_P1_AXI_EN>,
+             <&pciesys CLK_PCIE_P1_OBFF_EN>,
+             <&pciesys CLK_PCIE_P1_PIPE_EN>;
+        clock-names = "sys_ck1", "ahb_ck1", "aux_ck1",
+                  "axi_ck1", "obff_ck1", "pipe_ck1";
+        power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
+        bus-range = <0x00 0xff>;
+        ranges = <0x82000000 0 0x28000000  0x0 0x28000000  0 0x8000000>;
+        status = "disabled";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+                <0 0 0 2 &pcie_intc1 1>,
+                <0 0 0 3 &pcie_intc1 2>,
+                <0 0 0 4 &pcie_intc1 3>;
+        pcie_intc1: interrupt-controller {
+            interrupt-controller;
+            #address-cells = <0>;
+            #interrupt-cells = <1>;
+        };
+    };
+    };
-- 
2.43.0


