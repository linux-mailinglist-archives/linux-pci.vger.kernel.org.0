Return-Path: <linux-pci+bounces-9290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CF1917EBC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C0A1F287C2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C66A180A7C;
	Wed, 26 Jun 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WX2emnU2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3RdAnPRI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WX2emnU2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3RdAnPRI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C617F50F;
	Wed, 26 Jun 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398811; cv=none; b=VA53NvE8Vqhoethpt4j7Z8cza+tAuNr2mzIDLOY7YJPfP/KMEZxncHRKLqKPCsRdfNeqYbgvMQaNaPCUxW/C5qua4gO37GR2Fxo/F6z/Se5UDHfaAkJMq1utHggcPtfILj+bcFZUEDTWS5jbtVoR+4GxLPerxBwkVntcO1Tzd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398811; c=relaxed/simple;
	bh=jTeMDH0IuqYM5aLo9w8l2U6bS8GR1ljExeHdRqVekGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oymfvecLILNDcxeU6e7bhtuOdlTF5nbrhR1eytnuu06RKl6tVDei7ryfcxPG4B+vX4/ososY7c1Sy0GinRNbsF/jqWQrAYIw3zba+AyWcXJS2e7UGzWyha9k6prugyId1EbYYeerfC2sucOXxS6dQklFlbsbh7XGefMsm665c6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WX2emnU2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3RdAnPRI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WX2emnU2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3RdAnPRI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12CCD21AB1;
	Wed, 26 Jun 2024 10:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4NjSFDFxMBcaOlY+WLyo+vBnllfW8rVAUAaxg6satqU=;
	b=WX2emnU2zL8I6BGO9TJl8jgFxl/bJebZ30F00oHlNqxJCEI/b/b4cVzqWBB2ORGOqvopyz
	z80AKaHbEp1vMgkmYj7Y6ln9omivCVU6m0cIKrknMw84fbWf6sRFtwhfFfBKHXag54r0NG
	aGQy9peOsTu2V11FZYpIWWdI42ozGfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4NjSFDFxMBcaOlY+WLyo+vBnllfW8rVAUAaxg6satqU=;
	b=3RdAnPRI7sxgos0KPHVww9Ju6fWFXyZNMNZCWMph66VoapfrNn07NyA3losBfkiljLkmoT
	szlTLM0Zfzzw89Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WX2emnU2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3RdAnPRI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4NjSFDFxMBcaOlY+WLyo+vBnllfW8rVAUAaxg6satqU=;
	b=WX2emnU2zL8I6BGO9TJl8jgFxl/bJebZ30F00oHlNqxJCEI/b/b4cVzqWBB2ORGOqvopyz
	z80AKaHbEp1vMgkmYj7Y6ln9omivCVU6m0cIKrknMw84fbWf6sRFtwhfFfBKHXag54r0NG
	aGQy9peOsTu2V11FZYpIWWdI42ozGfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4NjSFDFxMBcaOlY+WLyo+vBnllfW8rVAUAaxg6satqU=;
	b=3RdAnPRI7sxgos0KPHVww9Ju6fWFXyZNMNZCWMph66VoapfrNn07NyA3losBfkiljLkmoT
	szlTLM0Zfzzw89Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE6C5139C2;
	Wed, 26 Jun 2024 10:46:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UCvzNpXxe2ZuDQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 26 Jun 2024 10:46:45 +0000
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
Subject: [PATCH 6/7] PCI: brcmstb: Add bcm2712 support
Date: Wed, 26 Jun 2024 13:45:43 +0300
Message-ID: <20240626104544.14233-7-svarbanov@suse.de>
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
X-Rspamd-Queue-Id: 12CCD21AB1
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLw7mkaud87zuqqztkur5718rm)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Add bare minimum amount of changes in order to support
PCIe RC hardware IP found in RPi5.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 drivers/pci/controller/pcie-brcmstb.c | 257 +++++++++++++++++++++++++-
 1 file changed, 250 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index ff8e5e672ff0..ec0a66ae06e4 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -55,6 +55,10 @@
 #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
 #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
 
+#define PCIE_RC_PL_PHY_CTL_15				0x184c
+#define  PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK		0x400000
+#define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK	0xff
+
 #define PCIE_MISC_MISC_CTRL				0x4008
 #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK	0x80
 #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK	0x400
@@ -77,6 +81,7 @@
 
 #define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
 #define  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK		0x1f
+#define PCIE_MISC_RC_BAR1_CONFIG_HI			0x4030
 
 #define PCIE_MISC_RC_BAR2_CONFIG_LO			0x4034
 #define  PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK		0x1f
@@ -92,6 +97,8 @@
 #define  PCIE_MISC_MSI_DATA_CONFIG_VAL_32		0xffe06540
 #define  PCIE_MISC_MSI_DATA_CONFIG_VAL_8		0xfff86540
 
+#define PCIE_MISC_RC_CONFIG_RETRY_TIMEOUT		0x405c
+
 #define PCIE_MISC_PCIE_CTRL				0x4064
 #define  PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK	0x1
 #define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK		0x4
@@ -122,8 +129,9 @@
 #define PCIE_MEM_WIN0_LIMIT_HI(win)	\
 		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
 
-#define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
+#define PCIE_MISC_HARD_PCIE_HARD_DEBUG	(pcie->cfg->offsets[PCIE_HARD_DEBUG])
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
+#define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_PERST_ASSERT_MASK		0x8
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK		0x200000
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
 #define  PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x00800000
@@ -131,7 +139,37 @@
 	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
 	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
 
-#define PCIE_INTR2_CPU_BASE		0x4300
+#define PCIE_MISC_UBUS_CTRL					0x40a4
+#define  PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_ERR_DIS_MASK	BIT(13)
+#define  PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_DECERR_DIS_MASK	BIT(19)
+
+#define PCIE_MISC_UBUS_TIMEOUT					0x40a8
+
+#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP			0x40ac
+#define  PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_ENABLE_MASK	BIT(0)
+#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_HI			0x40b0
+
+#define PCIE_MISC_UBUS_BAR2_CONFIG_REMAP			0x40b4
+#define  PCIE_MISC_UBUS_BAR2_CONFIG_REMAP_ACCESS_ENABLE_MASK	BIT(0)
+
+/* Additional RC BARs */
+#define  PCIE_MISC_RC_BAR_CONFIG_LO_SIZE_MASK		0x1f
+#define PCIE_MISC_RC_BAR4_CONFIG_LO			0x40d4
+#define PCIE_MISC_RC_BAR4_CONFIG_HI			0x40d8
+#define PCIE_MISC_RC_BAR10_CONFIG_LO			0x4104
+#define PCIE_MISC_RC_BAR10_CONFIG_HI			0x4108
+
+#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_ENABLE		0x1
+#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_LO_MASK		0xfffff000
+#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_HI_MASK		0xff
+#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_LO		0x410c
+#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_HI		0x4110
+#define PCIE_MISC_UBUS_BAR10_CONFIG_REMAP_LO		0x413c
+#define PCIE_MISC_UBUS_BAR10_CONFIG_REMAP_HI		0x4140
+
+#define PCIE_MISC_AXI_READ_ERROR_DATA			0x4170
+
+#define PCIE_INTR2_CPU_BASE		(pcie->cfg->offsets[INTR2_CPU])
 #define PCIE_MSI_INTR2_BASE		0x4500
 /* Offsets from PCIE_INTR2_CPU_BASE and PCIE_MSI_INTR2_BASE */
 #define  MSI_INT_STATUS			0x0
@@ -205,6 +243,8 @@ enum {
 	RGR1_SW_INIT_1,
 	EXT_CFG_INDEX,
 	EXT_CFG_DATA,
+	PCIE_HARD_DEBUG,
+	INTR2_CPU,
 };
 
 enum {
@@ -219,6 +259,7 @@ enum pcie_type {
 	BCM4908,
 	BCM7278,
 	BCM2711,
+	BCM2712,
 };
 
 struct pcie_cfg_data {
@@ -264,6 +305,7 @@ struct brcm_pcie {
 	struct brcm_msi		*msi;
 	struct reset_control	*rescal;
 	struct reset_control	*perst_reset;
+	struct reset_control	*bridge_reset;
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 	u32			hw_rev;
@@ -288,8 +330,8 @@ static int brcm_pcie_encode_ibar_size(u64 size)
 	if (log2_in >= 12 && log2_in <= 15)
 		/* Covers 4KB to 32KB (inclusive) */
 		return (log2_in - 12) + 0x1c;
-	else if (log2_in >= 16 && log2_in <= 35)
-		/* Covers 64KB to 32GB, (inclusive) */
+	else if (log2_in >= 16 && log2_in <= 36)
+		/* Covers 64KB to 64GB, (inclusive) */
 		return log2_in - 15;
 	/* Something is awry so disable */
 	return 0;
@@ -444,7 +486,7 @@ static struct irq_chip brcm_msi_irq_chip = {
 
 static struct msi_domain_info brcm_msi_domain_info = {
 	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI),
+		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
 	.chip	= &brcm_msi_irq_chip,
 };
 
@@ -668,6 +710,41 @@ static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
 	return 0;
 }
 
+static int brcm_pcie_enable_external_msix(struct brcm_pcie *pcie,
+					  struct device_node *msi_np)
+{
+	u64 msi_pci_addr, msi_phys_addr;
+	u32 val;
+
+	if (of_property_read_u64(msi_np, "brcm,msi-pci-addr", &msi_pci_addr)) {
+		dev_err(pcie->dev, "Unable to find MSI PCI address\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u64(msi_np, "reg", &msi_phys_addr)) {
+		dev_err(pcie->dev, "Unable to find MSI physical address\n");
+		return -EINVAL;
+	}
+
+	/* Use RC_BAR1 for MIP access */
+
+	val = lower_32_bits(msi_pci_addr);
+	val |= brcm_pcie_encode_ibar_size(0x1000);
+	writel(val, pcie->base + PCIE_MISC_RC_BAR1_CONFIG_LO);
+
+	val = upper_32_bits(msi_pci_addr);
+	writel(val, pcie->base + PCIE_MISC_RC_BAR1_CONFIG_HI);
+
+	val = lower_32_bits(msi_phys_addr);
+	val |= PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_ENABLE_MASK;
+	writel(val, pcie->base + PCIE_MISC_UBUS_BAR1_CONFIG_REMAP);
+
+	val = upper_32_bits(msi_phys_addr);
+	writel(val, pcie->base + PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_HI);
+
+	return 0;
+}
+
 /* The controller is capable of serving in both RC and EP roles */
 static bool brcm_pcie_rc_mode(struct brcm_pcie *pcie)
 {
@@ -748,6 +825,18 @@ static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 }
 
+static void brcm_pcie_bridge_sw_init_set_2712(struct brcm_pcie *pcie, u32 val)
+{
+	if (WARN_ONCE(!pcie->bridge_reset,
+		      "missing bridge reset controller\n"))
+		return;
+
+	if (val)
+		reset_control_assert(pcie->bridge_reset);
+	else
+		reset_control_deassert(pcie->bridge_reset);
+}
+
 static void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
 {
 	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
@@ -769,6 +858,16 @@ static void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
 	writel(tmp, pcie->base +  PCIE_MISC_PCIE_CTRL);
 }
 
+static void brcm_pcie_perst_set_2712(struct brcm_pcie *pcie, u32 val)
+{
+	u32 tmp;
+
+	/* Perst bit has moved and assert value is 0 */
+	tmp = readl(pcie->base + PCIE_MISC_PCIE_CTRL);
+	u32p_replace_bits(&tmp, !val, PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK);
+	writel(tmp, pcie->base +  PCIE_MISC_PCIE_CTRL);
+}
+
 static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
@@ -795,6 +894,9 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 		size += entry->res->end - entry->res->start + 1;
 		if (pcie_beg < lowest_pcie_addr)
 			lowest_pcie_addr = pcie_beg;
+		/* Only consider the first entry */
+		if (pcie->cfg->type == BCM2711 || pcie->cfg->type == BCM2712)
+			break;
 	}
 
 	if (lowest_pcie_addr == ~(u64)0) {
@@ -865,6 +967,30 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 	return 0;
 }
 
+static int brcm_pcie_get_rc_bar_n(struct brcm_pcie *pcie,
+				  int idx,
+				  u64 *rc_bar_cpu,
+				  u64 *rc_bar_size,
+				  u64 *rc_bar_pci)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	struct resource_entry *entry;
+	int i = 0;
+
+	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
+		if (i == idx) {
+			*rc_bar_cpu  = entry->res->start;
+			*rc_bar_size = entry->res->end - entry->res->start + 1;
+			*rc_bar_pci = entry->res->start - entry->offset;
+			return 0;
+		}
+
+		i++;
+	}
+
+	return -EINVAL;
+}
+
 static int brcm_pcie_setup(struct brcm_pcie *pcie)
 {
 	u64 rc_bar2_offset, rc_bar2_size;
@@ -873,7 +999,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	struct resource_entry *entry;
 	u32 tmp, burst, aspm_support;
 	int num_out_wins = 0;
-	int ret, memc;
+	int ret, memc, count, i;
 
 	/* Reset the bridge */
 	pcie->cfg->bridge_sw_init_set(pcie, 1);
@@ -907,6 +1033,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		burst = 0x0; /* 128 bytes */
 	else if (pcie->cfg->type == BCM7278)
 		burst = 0x3; /* 512 bytes */
+	else if (pcie->cfg->type == BCM2712)
+		burst = 0x1; /* 128 bytes */
 	else
 		burst = 0x2; /* 512 bytes */
 
@@ -934,7 +1062,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	writel(upper_32_bits(rc_bar2_offset),
 	       base + PCIE_MISC_RC_BAR2_CONFIG_HI);
 
+	tmp = readl(base + PCIE_MISC_UBUS_BAR2_CONFIG_REMAP);
+	u32p_replace_bits(&tmp, 1, PCIE_MISC_UBUS_BAR2_CONFIG_REMAP_ACCESS_ENABLE_MASK);
+	writel(tmp, base + PCIE_MISC_UBUS_BAR2_CONFIG_REMAP);
 	tmp = readl(base + PCIE_MISC_MISC_CTRL);
+
 	for (memc = 0; memc < pcie->num_memc; memc++) {
 		u32 scb_size_val = ilog2(pcie->memc_size[memc]) - 15;
 
@@ -945,8 +1077,32 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		else if (memc == 2)
 			u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(2));
 	}
+
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
+	if (pcie->cfg->type == BCM2712) {
+		/* Suppress AXI error responses and return 1s for read failures */
+		tmp = readl(base + PCIE_MISC_UBUS_CTRL);
+		u32p_replace_bits(&tmp, 1, PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_ERR_DIS_MASK);
+		u32p_replace_bits(&tmp, 1, PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_DECERR_DIS_MASK);
+		writel(tmp, base + PCIE_MISC_UBUS_CTRL);
+		writel(0xffffffff, base + PCIE_MISC_AXI_READ_ERROR_DATA);
+
+		/*
+		 * Adjust timeouts. The UBUS timeout also affects CRS
+		 * completion retries, as the request will get terminated if
+		 * either timeout expires, so both have to be a large value
+		 * (in clocks of 750MHz).
+		 * Set UBUS timeout to 250ms, then set RC config retry timeout
+		 * to be ~240ms.
+		 *
+		 * Setting CRSVis=1 will stop the core from blocking on a CRS
+		 * response, but does require the device to be well-behaved...
+		 */
+		writel(0xb2d0000, base + PCIE_MISC_UBUS_TIMEOUT);
+		writel(0xaba0000, base + PCIE_MISC_RC_CONFIG_RETRY_TIMEOUT);
+	}
+
 	/*
 	 * We ideally want the MSI target address to be located in the 32bit
 	 * addressable memory area. Some devices might depend on it. This is
@@ -983,6 +1139,38 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
 	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
+	/* Program additional inbound windows (RC_BAR4..RC_BAR10) */
+	count = (pcie->cfg->type == BCM2712) ? 7 : 0;
+	for (i = 0; i < count; i++) {
+		u64 bar_cpu, bar_size, bar_pci;
+
+		ret = brcm_pcie_get_rc_bar_n(pcie, 1 + i, &bar_cpu, &bar_size,
+					     &bar_pci);
+		if (ret)
+			break;
+
+		tmp = lower_32_bits(bar_pci);
+		u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(bar_size),
+				  PCIE_MISC_RC_BAR_CONFIG_LO_SIZE_MASK);
+		writel(tmp, base + PCIE_MISC_RC_BAR4_CONFIG_LO + i * 8);
+		writel(upper_32_bits(bar_pci),
+		       base + PCIE_MISC_RC_BAR4_CONFIG_HI + i * 8);
+
+		tmp = upper_32_bits(bar_cpu) &
+			PCIE_MISC_UBUS_BAR_CONFIG_REMAP_HI_MASK;
+		writel(tmp,
+		       base + PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_HI + i * 8);
+		tmp = lower_32_bits(bar_cpu) &
+			PCIE_MISC_UBUS_BAR_CONFIG_REMAP_LO_MASK;
+		writel(tmp | PCIE_MISC_UBUS_BAR_CONFIG_REMAP_ENABLE,
+		       base + PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_LO + i * 8);
+	}
+
+	if (pcie->gen) {
+		dev_info(pcie->dev, "Forcing gen %d\n", pcie->gen);
+		brcm_pcie_set_gen(pcie, pcie->gen);
+	}
+
 	/*
 	 * For config space accesses on the RC, show the right class for
 	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
@@ -1043,6 +1231,10 @@ static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
 	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
 	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
 
+	/* BCM2712 doesn't have an RGR bridge */
+	if (pcie->cfg->type == BCM2712)
+		return;
+
 	/* Each unit in timeout register is 1/216,000,000 seconds */
 	writel(216 * timeout_us, pcie->base + REG_OFFSET);
 }
@@ -1113,7 +1305,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	void __iomem *base = pcie->base;
-	u16 nlw, cls, lnksta;
+	u16 nlw, cls, lnksta, tmp16;
 	bool ssc_good = false;
 	int ret, i;
 
@@ -1159,6 +1351,17 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 		 pci_speed_string(pcie_link_speed[cls]), nlw,
 		 ssc_good ? "(SSC)" : "(!SSC)");
 
+	/*
+	 * RootCtl bits are reset by perst_n, which undoes pci_enable_crs()
+	 * called prior to pci_add_new_bus() during probe. Re-enable here.
+	 */
+	tmp16 = readw(base + BRCM_PCIE_CAP_REGS + PCI_EXP_RTCAP);
+	if (tmp16 & PCI_EXP_RTCAP_CRSVIS) {
+		tmp16 = readw(base + BRCM_PCIE_CAP_REGS + PCI_EXP_RTCTL);
+		u16p_replace_bits(&tmp16, 1, PCI_EXP_RTCTL_CRSSVE);
+		writew(tmp16, base + BRCM_PCIE_CAP_REGS + PCI_EXP_RTCTL);
+	}
+
 	return 0;
 }
 
@@ -1336,6 +1539,13 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
 	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
 
+	/*
+	 * Shutting down this bridge on pcie1 means accesses to rescal block
+	 * will hang the chip if another RC wants to assert/deassert rescal.
+	 */
+	if (pcie->cfg->type == BCM2712)
+		return;
+
 	/* Shutdown PCIe bridge */
 	pcie->cfg->bridge_sw_init_set(pcie, 1);
 }
@@ -1494,12 +1704,16 @@ static const int pcie_offsets[] = {
 	[RGR1_SW_INIT_1] = 0x9210,
 	[EXT_CFG_INDEX]  = 0x9000,
 	[EXT_CFG_DATA]   = 0x9004,
+	[PCIE_HARD_DEBUG] = 0x4204,
+	[INTR2_CPU]      = 0x4300,
 };
 
 static const int pcie_offsets_bmips_7425[] = {
 	[RGR1_SW_INIT_1] = 0x8010,
 	[EXT_CFG_INDEX]  = 0x8300,
 	[EXT_CFG_DATA]   = 0x8304,
+	[PCIE_HARD_DEBUG] = 0x4204,
+	[INTR2_CPU]      = 0x4300,
 };
 
 static const struct pcie_cfg_data generic_cfg = {
@@ -1538,6 +1752,8 @@ static const int pcie_offset_bcm7278[] = {
 	[RGR1_SW_INIT_1] = 0xc010,
 	[EXT_CFG_INDEX] = 0x9000,
 	[EXT_CFG_DATA] = 0x9004,
+	[PCIE_HARD_DEBUG] = 0x4204,
+	[INTR2_CPU]      = 0x4300,
 };
 
 static const struct pcie_cfg_data bcm7278_cfg = {
@@ -1556,8 +1772,23 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
+static const int pcie_offsets_bcm2712[] = {
+	[EXT_CFG_INDEX] = 0x9000,
+	[EXT_CFG_DATA] = 0x9004,
+	[PCIE_HARD_DEBUG] = 0x4304,
+	[INTR2_CPU] = 0x4400,
+};
+
+static const struct pcie_cfg_data bcm2712_cfg = {
+	.offsets = pcie_offsets_bcm2712,
+	.type = BCM2712,
+	.perst_set = brcm_pcie_perst_set_2712,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_2712,
+};
+
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
+	{ .compatible = "brcm,bcm2712-pcie", .data = &bcm2712_cfg },
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
@@ -1635,6 +1866,12 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		clk_disable_unprepare(pcie->clk);
 		return PTR_ERR(pcie->perst_reset);
 	}
+	pcie->bridge_reset =
+		devm_reset_control_get_optional_exclusive(&pdev->dev, "bridge");
+	if (IS_ERR(pcie->bridge_reset)) {
+		clk_disable_unprepare(pcie->clk);
+		return PTR_ERR(pcie->bridge_reset);
+	}
 
 	ret = reset_control_reset(pcie->rescal);
 	if (ret)
@@ -1666,6 +1903,12 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 			dev_err(pcie->dev, "probe of internal MSI failed");
 			goto fail;
 		}
+	} else if (pci_msi_enabled() && msi_np != pcie->np) {
+		ret = brcm_pcie_enable_external_msix(pcie, msi_np);
+		if (ret) {
+			dev_err(pcie->dev, "probe of external MSI-X failed\n");
+			goto fail;
+		}
 	}
 
 	bridge->ops = pcie->cfg->type == BCM7425 ?
-- 
2.43.0


