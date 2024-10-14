Return-Path: <linux-pci+bounces-14468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF699CB1E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0001C23CC4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69731BD01F;
	Mon, 14 Oct 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J5k5buL3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eGuDE/yS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J5k5buL3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eGuDE/yS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FA51B4F15;
	Mon, 14 Oct 2024 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911266; cv=none; b=YuHZPuKCnpE+APzUAyYO5Dhj8/aMr1mSnwZ0wk8+f+LHRG8euo6VTo1ZCpcK0RlghXrxKjgH8JG+8s4YhCpYyTm3G1cyMvLCjk+eZXT9AtFQvX5zJLyu2q3LxqvU8wp3ACulFowwjuSRotiRzBlmzI23cy5zlhOea2Ow+QjMI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911266; c=relaxed/simple;
	bh=u2Z7lcwvvRxHIhUTFSqQVM6ChLp5cNHW2bk/dIImK9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7YUJfBIBtvm1cGO100vKF4GpwByvBU+eubjVRikXBH3HH+dRT+UsxXsuPqzggkpbiPSfJ+0Cnv92iiYnX9AT7mblbsGPZ1VsosAAOteoNTTYSs2XMT5IxYxoONvmlUIl12sLZLoiSnS0jR3ol+PbBG3cq9UcNzBZKcJDQ3Y1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J5k5buL3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eGuDE/yS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J5k5buL3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eGuDE/yS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CBEE1FE59;
	Mon, 14 Oct 2024 13:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEpzsrKRyO4Yy2bsVlZAct+Q7axO2e+hhJ6JBnpitqQ=;
	b=J5k5buL3sqx1OsDBzS/REyTsp6ICBHahgP05Xnzh8GWvMGBIV37MsEkHAm3JxBPdEWUaeP
	xB3jl+zMxC7O8vmwksq/tvCip0hICQTJv1kFCWEqQsOVDLZo3Dxir15xhGl5/MuK8NDR1X
	wF7nLMpzqwPSKhPjKwpB4tv6fqIllks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEpzsrKRyO4Yy2bsVlZAct+Q7axO2e+hhJ6JBnpitqQ=;
	b=eGuDE/yS1RNyh2yBKTU6LmV3NXVk7eRY2AHQjroET8QoBluiq216eqcy0yNIJWyEOfxr7C
	EkbGOcQUF8AUgqAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEpzsrKRyO4Yy2bsVlZAct+Q7axO2e+hhJ6JBnpitqQ=;
	b=J5k5buL3sqx1OsDBzS/REyTsp6ICBHahgP05Xnzh8GWvMGBIV37MsEkHAm3JxBPdEWUaeP
	xB3jl+zMxC7O8vmwksq/tvCip0hICQTJv1kFCWEqQsOVDLZo3Dxir15xhGl5/MuK8NDR1X
	wF7nLMpzqwPSKhPjKwpB4tv6fqIllks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEpzsrKRyO4Yy2bsVlZAct+Q7axO2e+hhJ6JBnpitqQ=;
	b=eGuDE/yS1RNyh2yBKTU6LmV3NXVk7eRY2AHQjroET8QoBluiq216eqcy0yNIJWyEOfxr7C
	EkbGOcQUF8AUgqAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 089FF13A42;
	Mon, 14 Oct 2024 13:07:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sA9aO50XDWcqTwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 14 Oct 2024 13:07:41 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH v3 10/11] arm64: dts: broadcom: bcm2712: Add PCIe DT nodes
Date: Mon, 14 Oct 2024 16:07:09 +0300
Message-ID: <20241014130710.413-11-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014130710.413-1-svarbanov@suse.de>
References: <20241014130710.413-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.30
X-Spam-Flag: NO

Add PCIe devicetree nodes, plus needed reset and mip MSI-X
controllers.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
v2 -> v3:
- Added comments on ranges and dma-ranges properties (Florian)

 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 160 ++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 6e5a984c1d4e..a83de23856e3 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -192,6 +192,12 @@ soc: soc@107c000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		pcie_rescal: reset-controller@119500 {
+			compatible = "brcm,bcm7216-pcie-sata-rescal";
+			reg = <0x00119500 0x10>;
+			#reset-cells = <0>;
+		};
+
 		sdio1: mmc@fff000 {
 			compatible = "brcm,bcm2712-sdhci",
 				     "brcm,sdhci-brcmstb";
@@ -204,6 +210,12 @@ sdio1: mmc@fff000 {
 			mmc-ddr-3_3v;
 		};
 
+		bcm_reset: reset-controller@1504318 {
+			compatible = "brcm,brcmstb-reset";
+			reg = <0x01504318 0x30>;
+			#reset-cells = <1>;
+		};
+
 		system_timer: timer@7c003000 {
 			compatible = "brcm,bcm2835-system-timer";
 			reg = <0x7c003000 0x1000>;
@@ -267,6 +279,154 @@ gicv2: interrupt-controller@7fff9000 {
 		};
 	};
 
+	axi@1000000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0x00 0x00000000 0x10 0x00000000 0x01 0x00000000>,
+			 <0x14 0x00000000 0x14 0x00000000 0x04 0x00000000>,
+			 <0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>,
+			 <0x1c 0x00000000 0x1c 0x00000000 0x04 0x00000000>;
+
+		dma-ranges = <0x00 0x00000000 0x00 0x00000000 0x10 0x00000000>,
+			     <0x14 0x00000000 0x14 0x00000000 0x04 0x00000000>,
+			     <0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>,
+			     <0x1c 0x00000000 0x1c 0x00000000 0x04 0x00000000>;
+
+		pcie0: pcie@100000 {
+			compatible = "brcm,bcm2712-pcie";
+			reg = <0x00 0x00100000 0x00 0x9310>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			max-link-speed = <2>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			interrupt-parent = <&gicv2>;
+			interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pcie", "msi";
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gicv2 GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gicv2 GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gicv2 GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&bcm_reset 42>, <&pcie_rescal>;
+			reset-names = "bridge", "rescal";
+			msi-controller;
+			msi-parent = <&pcie0>;
+
+			ranges =
+				/* ~4GB, 32-bit, non-prefetchable at PCIe 00_0000_0000 */
+				<0x02000000 0x00 0x00000000 0x17 0x00000000 0x00 0xfffffffc>,
+				/* 12GB, 64-bit, prefetchable at PCIe 04_0000_0000 */
+				<0x43000000 0x04 0x00000000 0x14 0x00000000 0x03 0x00000000>;
+
+			dma-ranges =
+				/* 64GB, 64-bit, prefetchable at PCIe 10_0000_0000 */
+				<0x43000000 0x10 0x00000000 0x00 0x00000000 0x10 0x00000000>;
+
+			status = "disabled";
+		};
+
+		pcie1: pcie@110000 {
+			compatible = "brcm,bcm2712-pcie";
+			reg = <0x00 0x00110000 0x00 0x9310>;
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			max-link-speed = <2>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			interrupt-parent = <&gicv2>;
+			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pcie", "msi";
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gicv2 GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gicv2 GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gicv2 GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&bcm_reset 43>, <&pcie_rescal>;
+			reset-names = "bridge", "rescal";
+			msi-parent = <&mip1>;
+
+			ranges =
+				/* ~4GB, 32-bit, non-prefetchable at PCIe 00_0000_0000 */
+				<0x02000000 0x00 0x00000000 0x1b 0x00000000 0x00 0xfffffffc>,
+				/* 12GB, 64-bit, prefetchable at PCIe 04_0000_0000 */
+				<0x43000000 0x04 0x00000000 0x18 0x00000000 0x03 0x00000000>;
+
+			dma-ranges =
+				/* 64GB, 64-bit, non-prefetchable at PCIe 10_0000_0000 */
+				<0x03000000 0x10 0x00000000 0x00 0x00000000 0x10 0x00000000>;
+
+			status = "disabled";
+		};
+
+		pcie2: pcie@120000 {
+			compatible = "brcm,bcm2712-pcie";
+			reg = <0x00 0x00120000 0x00 0x9310>;
+			device_type = "pci";
+			linux,pci-domain = <2>;
+			max-link-speed = <2>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <4>;
+			#address-cells = <3>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			interrupt-parent = <&gicv2>;
+			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pcie", "msi";
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gicv2 GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gicv2 GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gicv2 GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&bcm_reset 44>, <&pcie_rescal>;
+			reset-names = "bridge", "rescal";
+			msi-parent = <&mip0>;
+
+			ranges =
+				/* ~4GB, 32-bit, non-prefetchable at PCIe 00_0000_0000 */
+				<0x02000000 0x00 0x00000000 0x1f 0x00000000 0x00 0xfffffffc>,
+				/* 12GB, 64-bit, prefetchable at PCIe 04_0000_0000 */
+				<0x43000000 0x04 0x00000000 0x1c 0x00000000 0x03 0x00000000>;
+
+			dma-ranges =
+				/* 4MB, 32-bit, non-prefetchable at PCIe 00_0000_0000 */
+				<0x02000000 0x00 0x00000000 0x1f 0x00000000 0x00 0x00400000>,
+				/* 64GB, 64-bit, prefetchable at PCIe 10_0000_0000 */
+				<0x43000000 0x10 0x00000000 0x00 0x00000000 0x10 0x00000000>;
+
+			status = "disabled";
+		};
+
+		mip0: msi-controller@130000 {
+			compatible = "brcm,bcm2712-mip";
+			reg = <0x00 0x00130000 0x00 0xc0>,
+			      <0xff 0xfffff000 0x00 0x1000>;
+			msi-controller;
+			msi-ranges = <&gicv2 GIC_SPI 128 IRQ_TYPE_EDGE_RISING 64>;
+			brcm,msi-offset = <0>;
+		};
+
+		mip1: msi-controller@131000 {
+			compatible = "brcm,bcm2712-mip";
+			reg = <0x00 0x00131000 0x00 0xc0>,
+			      <0xff 0xfffff000 0x00 0x1000>;
+			msi-controller;
+			msi-ranges = <&gicv2 GIC_SPI 247 IRQ_TYPE_EDGE_RISING 8>;
+			brcm,msi-offset = <8>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
-- 
2.43.0


