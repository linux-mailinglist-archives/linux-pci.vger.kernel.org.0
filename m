Return-Path: <linux-pci+bounces-36589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5FAB8C6D8
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 13:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39ACB1BC06A5
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 11:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC202FCC17;
	Sat, 20 Sep 2025 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D27igykI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5512F532E
	for <linux-pci@vger.kernel.org>; Sat, 20 Sep 2025 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758368478; cv=none; b=uW1ES5ROGyDWhm5PpoGNWVX6Wfhyh7/CYAkGvELZaAHe20GgRVtc80c5dkKgYJ5f2Al7xIKsWay/uTeT1bBm/Q9EuTRVpK4Knrps3NucLsup0HGBej5+9jvptxl3wUPotzm20zYsZxkxHXNf7tbsZg6cz1f/EsuiOf8nsvJA8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758368478; c=relaxed/simple;
	bh=iNCc/QZrXuBPA/HJSrt/htpcqEgIn85/PdweWSw1dkA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nbvah0LC935YQQ1H8K+hn0teeEkmeLn/yK2l61GgZW21w7kc6gke2lxBBYzcqmihOkrl6n46wxQVSQpgwuC+fvByfXDM4/gsMsms1mXafKO0vPNwI+QVXf7NG8R3IQ1u/Q1VEiSpKy7oTFwA0xUeInU3O9LLI6jaoYS4t4EMaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D27igykI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso25545315e9.0
        for <linux-pci@vger.kernel.org>; Sat, 20 Sep 2025 04:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758368473; x=1758973273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=stSgd5iAYDqNwOUY1eQUgrY1TF6EF7Q40oeSIOldsdU=;
        b=D27igykIrkEenLYfYPDSSFnVzfchU0oaLglH9xAjPIi1Zr00hfTtTl1Z/A0otkxqBf
         e8Z/B0L4vtqbmO4vLSV+NPMQ+3hoKfOz5MWsWwHRojrFz8BZ/4KUoqo0SX2EXy3TdSOd
         eGyfZzYwQ+uoT/C+MdaliLL+CaE3ND4MQyIVGf68fuHdXH6ybDfanjCC284ns//XPLr/
         KL/0Y8VOm+QFAkxnr+zFF1gd7KnrPydrZuMZTcbGXqXWnX6b+rJWIl948yW8ckReWWAA
         Ecp+PDSd0a7tHiYguk5x8qEKD4FR1b0blN2eJu+U+0N/I79lkj5t25dAbYVJiVvYNjqj
         sqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758368473; x=1758973273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stSgd5iAYDqNwOUY1eQUgrY1TF6EF7Q40oeSIOldsdU=;
        b=DKBRuv80JUTL9C21x7bWfv005sLaqTI4lUm9oPdET2WQS1tT7+ElK/OOI217cbSEmM
         yznOqX55WfSME7cYHEos4g167LESJ62LgS+dZ0WABdJXDuefnEQwqXRuOhpq1GnadTgK
         U9ByCuOk5dl9j7ogmXj4vugi3duIyox6Rc3eK2Z5KJ5DUirXsF8nqEWH3g5cFQq9jnbE
         1BqZs6NaeGJyvurqPWi4jnE0m+cqIjmtIWtPuhWZ96awdtIB614Pbk9X7G80kEC4Lg+R
         Jk1EY3cvhuFj2myr5gWWQq+l/JYbYCzN1rGATTCK+xkyc6/dqdthZU4ENkN4cZMafHcI
         iIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB/YJ6dDnSpzJCbbd7Ri/+RECLZek56xOFARZ26oeF4/Rdm8vXVLaJ4SzobTjwovYnWde+3f+Q4/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DJY/sdcZ+YlykOHOoG+KYMtnQQiC1AQIi820+S2KLSQIqTT7
	NM7rLkzyuBEYsDLB/UKRkcb1+ciJhkVxMR1wUExXWYmLztJo8pZREOG+
X-Gm-Gg: ASbGncvc+bBXXpwgrVzH5YYbZgU9CfQA+uwdswTzyVluaM4abNXHm/2AjQHZEiBY3/i
	JgMkrkJZfTXS2iD0pIdLbnwOZdKeqAS45a2OXDWEn4T99mjOIXHMNaOEoR+FXRwtD+JP6PUeo0q
	A6SmKWDmawJqn1IrLU7rncbdVEm/GKzYeo7zhKJJulZ8/qKrNE2Stqm0o6pLs8p1+7nmdIGOXS/
	CM0/VsdF3U0s22qpUj+2CqRWFdSD5mL/Yu1uoBqmlcETdWK9cg+xVNXRHxVGuhuV6kapxtjX/fr
	xaoXxoWPukbMesWB3x71B3ZCp2Ad7hNdiYUU/G2LqpHevdyd5RaYbn4fz/1OLqFvTe9q0DV/dI8
	igFJm7oi4oNkGH13dhAIWh4XsW9Y9CLB6HCQ31Bc6pDvFzo9goZp6AKlSNnYBaUCaJXUwyP0=
X-Google-Smtp-Source: AGHT+IHgTDf5WwQfys//pKULPb53D8Gc2Nk7XHr9aX3tFXTfdSEHfoO36OquyG0LLWZDfjL3rx1tXQ==
X-Received: by 2002:a05:600c:1d0d:b0:45e:598:90b0 with SMTP id 5b1f17b1804b1-467e6f3680cmr64661545e9.9.1758368473016;
        Sat, 20 Sep 2025 04:41:13 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4613e754140sm161724365e9.21.2025.09.20.04.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 04:41:12 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: PCI: mediatek: Convert to YAML schema
Date: Sat, 20 Sep 2025 13:41:01 +0200
Message-ID: <20250920114103.16964-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the PCI mediatek Documentation to YAML schema to enable
validation of the supported GEN1/2 Mediatek PCIe controller.

While converting, lots of cleanup were done from the .txt with better
specifying what is supported by the various PCIe controller variant and
drop of redundant info that are part of the standard PCIe Host Bridge
schema.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/pci/mediatek-pcie.txt | 289 ---------
 .../bindings/pci/mediatek-pcie.yaml           | 564 ++++++++++++++++++
 2 files changed, 564 insertions(+), 289 deletions(-)
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
index 000000000000..f6c391c4add2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
@@ -0,0 +1,564 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/mediatek-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCIe controller on MediaTek SoCs
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: mediatek,mt2701-pcie
+      - const: mediatek,mt2712-pcie
+      - const: mediatek,mt7622-pcie
+      - const: mediatek,mt7623-pcie
+      - const: mediatek,mt7629-pcie
+      - items:
+          - const: airoha,en7523-pcie
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
+  clocks:
+    minItems: 1
+    maxItems: 6
+
+  clock-names:
+    minItems: 1
+    maxItems: 6
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: pcie_irq
+
+  resets:
+    minItems: 1
+    maxItems: 3
+
+  reset-names:
+    minItems: 1
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
+          enum:
+            - mediatek,mt2701-pcie
+            - mediatek,mt7623-pcie
+    then:
+      properties:
+        reg:
+          minItems: 4
+
+        reg-names:
+          items:
+            - const: subsys
+            - const: port0
+            - const: port1
+            - const: port2
+
+        clocks:
+          minItems: 4
+          maxItems: 4
+
+        clock-names:
+          items:
+            - const: free_ck
+            - const: sys_ck0
+            - const: sys_ck1
+            - const: sys_ck2
+
+        interrupts: false
+
+        interrupt-names: false
+
+        interrupt-controller: false
+
+        resets:
+          minItems: 3
+
+        reset-names:
+          items:
+            - const: pcie-rst0
+            - const: pcie-rst1
+            - const: pcie-rst2
+
+        phys:
+          minItems: 3
+
+        phy-names:
+          items:
+            - const: pcie-phy0
+            - const: pcie-phy1
+            - const: pcie-phy2
+
+      required:
+        - resets
+        - reset-names
+        - phys
+        - phy-names
+        - power-domains
+
+  - if:
+      properties:
+        compatible:
+          const: mediatek,mt2712-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 1
+
+        reg-names:
+          items:
+            - enum: [ port0, port1 ]
+
+        clocks:
+          minItems: 2
+          maxItems: 2
+
+        clock-names:
+          items:
+            - enum: [ sys_ck0, sys_ck1 ]
+            - enum: [ ahb_ck0, ahb_ck1 ]
+
+        reset: false
+
+        reset-names: false
+
+        phys:
+          maxItems: 1
+
+        phy-names:
+          items:
+            - enum: [ pcie-phy0, pcie-phy1 ]
+
+      required:
+        - interrupts
+        - interrupt-names
+        - interrupt-controller
+        - phys
+        - phy-names
+        - power-domains
+
+  - if:
+      properties:
+        compatible:
+          const: mediatek,mt7622-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 1
+
+        reg-names:
+          items:
+            - enum: [ port0, port1 ]
+
+        clocks:
+          minItems: 6
+          maxItems: 6
+
+        clock-names:
+          items:
+            - enum: [ sys_ck0, sys_ck1 ]
+            - enum: [ ahb_ck0, ahb_ck1 ]
+            - enum: [ aux_ck0, aux_ck1 ]
+            - enum: [ axi_ck0, axi_ck1 ]
+            - enum: [ obff_ck0, obff_ck1 ]
+            - enum: [ pipe_ck0, pipe_ck1 ]
+
+        reset: false
+
+        reset-names: false
+
+        phys: false
+
+        phy-names: false
+
+      required:
+        - interrupts
+        - interrupt-names
+        - interrupt-controller
+        - power-domains
+
+  - if:
+      properties:
+        compatible:
+          const: mediatek,mt7629-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 1
+
+        reg-names:
+          items:
+            - enum: [ port0, port1 ]
+
+        clocks:
+          minItems: 6
+          maxItems: 6
+
+        clock-names:
+          items:
+            - enum: [ sys_ck0, sys_ck1 ]
+            - enum: [ ahb_ck0, ahb_ck1 ]
+            - enum: [ aux_ck0, aux_ck1 ]
+            - enum: [ axi_ck0, axi_ck1 ]
+            - enum: [ obff_ck0, obff_ck1 ]
+            - enum: [ pipe_ck0, pipe_ck1 ]
+
+        reset: false
+
+        reset-names: false
+
+        phys:
+          maxItems: 1
+
+        phy-names:
+          items:
+            - enum: [ pcie-phy0, pcie-phy1 ]
+
+      required:
+        - interrupts
+        - interrupt-names
+        - interrupt-controller
+        - power-domains
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: airoha,en7523-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 1
+
+        reg-names:
+          items:
+            - enum: [ port0, port1 ]
+
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          items:
+            - enum: [ sys_ck0, sys_ck1 ]
+
+        reset: false
+
+        reset-names: false
+
+        phys: false
+
+        phy-names: false
+
+        power-domain: false
+
+      required:
+        - interrupts
+        - interrupt-names
+        - interrupt-controller
+
+unevaluatedProperties: false
+
+examples:
+  # MT7623
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mt2701-clk.h>
+    #include <dt-bindings/reset/mt2701-resets.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/power/mt2701-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        hifsys: syscon@1a000000 {
+            compatible = "mediatek,mt7623-hifsys",
+                        "mediatek,mt2701-hifsys",
+                        "syscon";
+            reg = <0 0x1a000000 0 0x1000>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+        };
+
+        pcie@1a140000 {
+            compatible = "mediatek,mt7623-pcie";
+            device_type = "pci";
+            reg = <0 0x1a140000 0 0x1000>, /* PCIe shared registers */
+                  <0 0x1a142000 0 0x1000>, /* Port0 registers */
+                  <0 0x1a143000 0 0x1000>, /* Port1 registers */
+                  <0 0x1a144000 0 0x1000>; /* Port2 registers */
+            reg-names = "subsys", "port0", "port1", "port2";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0xf800 0 0 0>;
+            interrupt-map = <0x0000 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0800 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>,
+                            <0x1000 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
+            clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
+                    <&hifsys CLK_HIFSYS_PCIE0>,
+                    <&hifsys CLK_HIFSYS_PCIE1>,
+                    <&hifsys CLK_HIFSYS_PCIE2>;
+            clock-names = "free_ck", "sys_ck0", "sys_ck1", "sys_ck2";
+            resets = <&hifsys MT2701_HIFSYS_PCIE0_RST>,
+                     <&hifsys MT2701_HIFSYS_PCIE1_RST>,
+                     <&hifsys MT2701_HIFSYS_PCIE2_RST>;
+            reset-names = "pcie-rst0", "pcie-rst1", "pcie-rst2";
+            phys = <&pcie0_phy PHY_TYPE_PCIE>, <&pcie1_phy PHY_TYPE_PCIE>,
+                   <&pcie2_phy PHY_TYPE_PCIE>;
+            phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
+            power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
+            bus-range = <0x00 0xff>;
+            ranges = <0x81000000 0 0x1a160000 0 0x1a160000 0 0x00010000	/* I/O space */
+                      0x83000000 0 0x60000000 0 0x60000000 0 0x10000000>;	/* memory space */
+
+            pcie@0,0 {
+                reg = <0x0000 0 0 0 0>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                #interrupt-cells = <1>;
+                interrupt-map-mask = <0 0 0 0>;
+                interrupt-map = <0 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>;
+                ranges;
+            };
+
+            pcie@1,0 {
+                reg = <0x0800 0 0 0 0>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                #interrupt-cells = <1>;
+                interrupt-map-mask = <0 0 0 0>;
+                interrupt-map = <0 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
+                ranges;
+            };
+
+            pcie@2,0 {
+                reg = <0x1000 0 0 0 0>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                #interrupt-cells = <1>;
+                interrupt-map-mask = <0 0 0 0>;
+                interrupt-map = <0 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
+                ranges;
+            };
+        };
+    };
+
+  # MT2712
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/phy/phy.h>
+
+    soc_1 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@112ff000 {
+            compatible = "mediatek,mt2712-pcie";
+            device_type = "pci";
+            reg = <0 0x112ff000 0 0x1000>;
+            reg-names = "port1";
+            linux,pci-domain = <1>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "pcie_irq";
+            clocks = <&topckgen>, /* CLK_TOP_PE2_MAC_P1_SEL */
+                     <&pericfg>; /* CLK_PERI_PCIE1 */
+            clock-names = "sys_ck1", "ahb_ck1";
+            phys = <&u3port1 PHY_TYPE_PCIE>;
+            phy-names = "pcie-phy1";
+            bus-range = <0x00 0xff>;
+            ranges = <0x82000000 0 0x11400000  0x0 0x11400000  0 0x300000>;
+            status = "disabled";
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+                            <0 0 0 2 &pcie_intc1 1>,
+                            <0 0 0 3 &pcie_intc1 2>,
+                            <0 0 0 4 &pcie_intc1 3>;
+            pcie_intc1: interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+            };
+        };
+
+        pcie@11700000 {
+            compatible = "mediatek,mt2712-pcie";
+            device_type = "pci";
+            reg = <0 0x11700000 0 0x1000>;
+            reg-names = "port0";
+            linux,pci-domain = <0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "pcie_irq";
+            clocks = <&topckgen>, /* CLK_TOP_PE2_MAC_P0_SEL */
+                     <&pericfg>; /* CLK_PERI_PCIE0 */
+            clock-names = "sys_ck0", "ahb_ck0";
+            phys = <&u3port0 PHY_TYPE_PCIE>;
+            phy-names = "pcie-phy0";
+            bus-range = <0x00 0xff>;
+            ranges = <0x82000000 0 0x20000000 0x0 0x20000000 0 0x10000000>;
+            status = "disabled";
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+                            <0 0 0 2 &pcie_intc0 1>,
+                            <0 0 0 3 &pcie_intc0 2>,
+                            <0 0 0 4 &pcie_intc0 3>;
+            pcie_intc0: interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+            };
+        };
+    };
+
+  # MT7622
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/mt7622-power.h>
+
+    soc_2 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1a143000 {
+            compatible = "mediatek,mt7622-pcie";
+            device_type = "pci";
+            reg = <0 0x1a143000 0 0x1000>;
+            reg-names = "port0";
+            linux,pci-domain = <0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-names = "pcie_irq";
+            clocks = <&pciesys>, /* CLK_PCIE_P0_MAC_EN */
+                     <&pciesys>, /* CLK_PCIE_P0_AHB_EN */
+                     <&pciesys>, /* CLK_PCIE_P0_AUX_EN */
+                     <&pciesys>, /* CLK_PCIE_P0_AXI_EN */
+                     <&pciesys>, /* CLK_PCIE_P0_OBFF_EN */
+                     <&pciesys>; /* CLK_PCIE_P0_PIPE_EN */
+            clock-names = "sys_ck0", "ahb_ck0", "aux_ck0",
+                          "axi_ck0", "obff_ck0", "pipe_ck0";
+
+            power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
+            bus-range = <0x00 0xff>;
+            ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x8000000>;
+            status = "disabled";
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc0_1 0>,
+                            <0 0 0 2 &pcie_intc0_1 1>,
+                            <0 0 0 3 &pcie_intc0_1 2>,
+                            <0 0 0 4 &pcie_intc0_1 3>;
+            pcie_intc0_1: interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+            };
+        };
+
+        pcie@1a145000 {
+            compatible = "mediatek,mt7622-pcie";
+            device_type = "pci";
+            reg = <0 0x1a145000 0 0x1000>;
+            reg-names = "port1";
+            linux,pci-domain = <1>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-names = "pcie_irq";
+            clocks = <&pciesys>, /* CLK_PCIE_P1_MAC_EN */
+                     /* designer has connect RC1 with p0_ahb clock */
+                     <&pciesys>, /* CLK_PCIE_P0_AHB_EN */
+                     <&pciesys>, /* CLK_PCIE_P1_AUX_EN */
+                     <&pciesys>, /* CLK_PCIE_P1_AXI_EN */
+                     <&pciesys>, /* CLK_PCIE_P1_OBFF_EN */
+                     <&pciesys>; /* CLK_PCIE_P1_PIPE_EN */
+            clock-names = "sys_ck1", "ahb_ck1", "aux_ck1",
+                          "axi_ck1", "obff_ck1", "pipe_ck1";
+
+            power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
+            bus-range = <0x00 0xff>;
+            ranges = <0x82000000 0 0x28000000  0x0 0x28000000  0 0x8000000>;
+            status = "disabled";
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc1_1 0>,
+                            <0 0 0 2 &pcie_intc1_1 1>,
+                            <0 0 0 3 &pcie_intc1_1 2>,
+                            <0 0 0 4 &pcie_intc1_1 3>;
+            pcie_intc1_1: interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+            };
+        };
+    };
-- 
2.51.0


