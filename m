Return-Path: <linux-pci+bounces-9291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0D2917EBE
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595FC1F28A2E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0202717D34C;
	Wed, 26 Jun 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ME2T1xtA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wmkRsyl8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KVdOcEAc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qxhwXl3d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6A180A67;
	Wed, 26 Jun 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398812; cv=none; b=J7Per9McohwxDm/LLZFnuIttatWY590VgAGCpLzuNQK7QcOCwgyn3sNW5Q3J3fb8+5WdiWMoKg/XruRq+3wzDp5wB94unLBEd7cyV3ZkvVeSlHU20QWQpyRu20fpydQkahfRaA1R7g6qafwh826+Pjy+Kz2mD5Oa/tX2UPF3DvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398812; c=relaxed/simple;
	bh=Mtzh34XJOYfDkd3WGKUdg6XQ25u+BNmvo+1kfI8h0IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQbd+PEqkTpkKiXmA9TBsKTtP9T6TJgwx5eA6gifafq/wxz+kc7TwyITm0DBgPkuxh3g49NYroiXO8cisPXTOBFCgB96rJyhqINv7oaM9DMG0j1E7wjlNstFUFOAeiMm9OdaaMKmzFVQTJETSq9OnoSwSab7iu5gotagNxTemKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ME2T1xtA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wmkRsyl8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KVdOcEAc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qxhwXl3d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B31A1FB4B;
	Wed, 26 Jun 2024 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1K+UbnOxASb0mDJc9XuFog+OpnIoP1uonAtx5IplcA=;
	b=ME2T1xtAoQvHjeAqmv4gIHAzLZKkr3Q9j54jJvOy24dUgKXkTwdbeVt75crc7zFwzyp6dY
	VDAKcbU04/Mql1nq7y3JjkE0ewxMe4+6T9EC3iaXZjJeBlDE4T/sXUjVT9hg00jYfll/1k
	765MiL+t9MG6JSisHgBKr1ROBJXZ4Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1K+UbnOxASb0mDJc9XuFog+OpnIoP1uonAtx5IplcA=;
	b=wmkRsyl8tlN80ahr/IupCsdKDiLkLJf/RkuBqQVu1hV2qcnlnuIjOTr6pnQvcsH1CUGYS8
	aldb6jUlDn+/pXCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1K+UbnOxASb0mDJc9XuFog+OpnIoP1uonAtx5IplcA=;
	b=KVdOcEAcaZQpt+5Quj/Fm50BrvG+9rIH3LcFHSHNa1J0HGpAZoNXSW79VLjXRRKt1NB2Mm
	HKLCzqiABlknDeh/Cv0idF8xxFuElsHz/q7F7c+ymJ+egvj3OeL1078pCP/1d56d2SQXLk
	Sjsux4bIaw6O9hKd+Uu0+3RHZuhN9go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1K+UbnOxASb0mDJc9XuFog+OpnIoP1uonAtx5IplcA=;
	b=qxhwXl3ds8mi71DqjO36m/V0MB7iZSFCFUsM5IRKmjLBCrZZgf3sKqbO7YdP3zy/xzcBku
	180XLao+wsJ9GQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2573B13AD2;
	Wed, 26 Jun 2024 10:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OEluBpfxe2ZuDQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 26 Jun 2024 10:46:47 +0000
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
Subject: [PATCH 7/7] arm64: dts: broadcom: bcm2712: Add PCIe DT nodes
Date: Wed, 26 Jun 2024 13:45:44 +0300
Message-ID: <20240626104544.14233-8-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626104544.14233-1-svarbanov@suse.de>
References: <20240626104544.14233-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 

Add PCIe device tree nodes.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 218 ++++++++++++++++++++--
 1 file changed, 202 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index bccb7318ce7e..358b129a0f65 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -186,17 +186,30 @@ cma: linux,cma {
 		};
 	};
 
-	soc: soc@107c000000 {
+	soc: soc@0 {
 		compatible = "simple-bus";
-		ranges = <0x00000000  0x10 0x00000000  0x80000000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges =
+			<0x00 0x00000000  0x00 0x00000000  0x10 0x00000000>,
+			<0x10 0x00000000  0x10 0x00000000  0x01 0x00000000>,
+			<0x14 0x00000000  0x14 0x00000000  0x04 0x00000000>,
+			<0x18 0x00000000  0x18 0x00000000  0x04 0x00000000>,
+			<0x1c 0x00000000  0x1c 0x00000000  0x04 0x00000000>;
+
+		dma-ranges =
+			<0x00 0x00000000  0x00 0x00000000  0x10 0x00000000>,
+			<0x10 0x00000000  0x10 0x00000000  0x01 0x00000000>,
+			<0x14 0x00000000  0x14 0x00000000  0x04 0x00000000>,
+			<0x18 0x00000000  0x18 0x00000000  0x04 0x00000000>,
+			<0x1c 0x00000000  0x1c 0x00000000  0x04 0x00000000>;
 
 		sdio1: mmc@fff000 {
 			compatible = "brcm,bcm2712-sdhci",
 				     "brcm,sdhci-brcmstb";
-			reg = <0x00fff000 0x260>,
-			      <0x00fff400 0x200>;
+			reg = <0x10 0x00fff000 0x0 0x260>,
+			      <0x10 0x00fff400 0x0 0x200>;
 			reg-names = "host", "cfg";
 			interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_emmc2>;
@@ -206,7 +219,7 @@ sdio1: mmc@fff000 {
 
 		system_timer: timer@7c003000 {
 			compatible = "brcm,bcm2835-system-timer";
-			reg = <0x7c003000 0x1000>;
+			reg = <0x10 0x7c003000 0x0 0x1000>;
 			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
@@ -216,19 +229,19 @@ system_timer: timer@7c003000 {
 
 		mailbox: mailbox@7c013880 {
 			compatible = "brcm,bcm2835-mbox";
-			reg = <0x7c013880 0x40>;
+			reg = <0x10 0x7c013880 0x0 0x40>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			#mbox-cells = <0>;
 		};
 
 		local_intc: local-intc@7cd00000 {
 			compatible = "brcm,bcm2836-l1-intc";
-			reg = <0x7cd00000 0x100>;
+			reg = <0x10 0x7cd00000 0x0 0x100>;
 		};
 
 		uart10: serial@7d001000 {
 			compatible = "arm,pl011", "arm,primecell";
-			reg = <0x7d001000 0x200>;
+			reg = <0x10 0x7d001000 0x0 0x200>;
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_uart>, <&clk_vpu>;
 			clock-names = "uartclk", "apb_pclk";
@@ -238,7 +251,7 @@ uart10: serial@7d001000 {
 
 		interrupt-controller@7d517000 {
 			compatible = "brcm,bcm7271-l2-intc";
-			reg = <0x7d517000 0x10>;
+			reg = <0x10 0x7d517000 0x0 0x10>;
 			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
@@ -246,7 +259,7 @@ interrupt-controller@7d517000 {
 
 		gio_aon: gpio@7d517c00 {
 			compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
-			reg = <0x7d517c00 0x40>;
+			reg = <0x10 0x7d517c00 0x0 0x40>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			brcm,gpio-bank-widths = <17 6>;
@@ -258,13 +271,186 @@ gio_aon: gpio@7d517c00 {
 
 		gicv2: interrupt-controller@7fff9000 {
 			compatible = "arm,gic-400";
-			reg = <0x7fff9000 0x1000>,
-			      <0x7fffa000 0x2000>,
-			      <0x7fffc000 0x2000>,
-			      <0x7fffe000 0x2000>;
+			reg = <0x10 0x7fff9000 0x0 0x1000>,
+			      <0x10 0x7fffa000 0x0 0x2000>,
+			      <0x10 0x7fffc000 0x0 0x2000>,
+			      <0x10 0x7fffe000 0x0 0x2000>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
 		};
+
+		mip0: msi-controller@130000 {
+			compatible = "brcm,bcm2712-mip-intc";
+			reg = <0x10 0x00130000 0x00 0xc0>;
+			msi-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			brcm,msi-base-spi = <128>;
+			brcm,msi-num-spis = <64>;
+			brcm,msi-offset = <0>;
+			brcm,msi-pci-addr = <0xff 0xfffff000>;
+		};
+
+		mip1: msi-controller@131000 {
+			compatible = "brcm,bcm2712-mip-intc";
+			reg = <0x10 0x00131000 0x00 0xc0>;
+			msi-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			brcm,msi-base-spi = <247>;
+			/* Actually 20 total, but the others are
+			 * both sparse and non-consecutive
+			 */
+			brcm,msi-num-spis = <8>;
+			brcm,msi-offset = <8>;
+			brcm,msi-pci-addr = <0xff 0xffffe000>;
+		};
+
+		pcie_rescal: reset-controller@119500 {
+			compatible = "brcm,bcm7216-pcie-sata-rescal";
+			reg = <0x10 0x00119500 0x00 0x10>;
+			#reset-cells = <0>;
+		};
+
+		bcm_reset: reset-controller@1504318 {
+			compatible = "brcm,brcmstb-reset";
+			reg = <0x10 0x01504318 0x00 0x30>;
+			#reset-cells = <1>;
+		};
+
+		/* Single-lane Gen3 PCIe
+		 * Outbound window at 14_0000_0000-17_ffff_ffff
+		 */
+		pcie0: pcie@100000 {
+			compatible = "brcm,bcm2712-pcie";
+			reg = <0x10 0x00100000  0x0 0x9310>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			max-link-speed = <2>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			/* Unused interrupts: 208: AER, 215: NMI, 216: PME */
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
+			ranges = <0x02000000 0x00 0x00000000
+				  0x17 0x00000000
+				  0x0 0xfffffffc>,
+				 <0x43000000 0x04 0x00000000
+				  0x14 0x00000000
+				  0x3 0x00000000>;
+
+			dma-ranges = <0x43000000 0x10 0x00000000
+				      0x00 0x00000000
+				      0x10 0x00000000>;
+
+			status = "disabled";
+		};
+
+		/* Single-lane Gen3 PCIe
+		 * Outbound window at 18_0000_0000-1b_ffff_ffff
+		 */
+		pcie1: pcie@110000 {
+			compatible = "brcm,bcm2712-pcie";
+			reg = <0x10 0x00110000  0x0 0x9310>;
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			max-link-speed = <2>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			/* Unused interrupts: 218: AER, 225: NMI, 226: PME */
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
+			msi-controller;
+			msi-parent = <&mip1>;
+
+			ranges = <0x02000000 0x00 0x00000000
+				  0x1b 0x00000000
+				  0x00 0xfffffffc>,
+				 <0x43000000 0x04 0x00000000
+				  0x18 0x00000000
+				  0x03 0x00000000>;
+
+			dma-ranges = <0x03000000 0x10 0x00000000
+				      0x00 0x00000000
+				      0x10 0x00000000>;
+
+			status = "disabled";
+		};
+
+		/* Quad-lane Gen3 PCIe
+		 * Outbound window at 1c_0000_0000-1f_ffff_ffff
+		 */
+		pcie2: pcie@120000 {
+			compatible = "brcm,bcm2712-pcie";
+			reg = <0x10 0x00120000 0x00 0x9310>;
+			device_type = "pci";
+			linux,pci-domain = <2>;
+			max-link-speed = <2>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <4>;
+			#address-cells = <3>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			/* Unused interrupts: 228: AER, 235: NMI, 236: PME */
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
+			// ~4GB, 32-bit, non-prefetchable at PCIe 00_0000_0000
+			ranges = <0x02000000 0x00 0x00000000
+				  0x1f 0x00000000
+				  0x0 0xfffffffc>,
+			// 12GB, 64-bit, prefetchable at PCIe 04_0000_0000
+				 <0x43000000 0x04 0x00000000
+				  0x1c 0x00000000
+				  0x03 0x00000000>;
+
+			// 64GB system RAM space at PCIe 10_0000_0000
+			dma-ranges = <0x02000000 0x00 0x00000000
+				      0x1f 0x00000000
+				      0x00 0x00400000>,
+				     <0x43000000 0x10 0x00000000
+				      0x00 0x00000000
+				      0x10 0x00000000>;
+
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.43.0


