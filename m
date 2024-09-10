Return-Path: <linux-pci+bounces-12994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167FD973B83
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB65E2826C6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3EA1A3BD6;
	Tue, 10 Sep 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a22KLDJ8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oYy0Q0WN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a22KLDJ8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oYy0Q0WN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ADB1A38EF;
	Tue, 10 Sep 2024 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981563; cv=none; b=pDduGcj53veiZc/i/X5fuj/M2QPv7e2kDXSSZlRMFcDvMJOxfyMx6w66MKuS+I5Lqkr1a4Zd+SpzoWh46nYZ7C1bjMSFYgPtR0OnPMntHlyapG8+EQV+RQ/Xk8Df8tUI9gM5qwkf7IK/fVv5nxMBZTR2PYqRxGZeHiGbbBf5hd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981563; c=relaxed/simple;
	bh=OyxGySGJIq/Jnjz/qKbyEp8R9n2PGDA5o5Lf3762Gbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hD2BSPev/qwEDHoF0G+Bmz3tugGTMzNru57aX/2RBQ9hO5EcAr8JMtrQ5S+Mmd2dzfSLefqqtOAhpwT+sNVcapFZLV/I96Y4r50sYm2Y6if13inF0g26b+9cmItRheLNYARYHrPtcIPly0VrjUww83T88sIvESJIAKsGxhxXLHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a22KLDJ8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oYy0Q0WN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a22KLDJ8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oYy0Q0WN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FBA721A62;
	Tue, 10 Sep 2024 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syDyu78Swce4jgLrSdRBxkp36MHRC4tpZiLldAb8ZNw=;
	b=a22KLDJ88+juyya4vv3twSU5UN1NBqJeAlxOaHQJVcS7nU6RlOuSLhxmWtB44BQe8ayw1Z
	vxto7N2/kpAP3vlPV8+AFzMcFJT4Lnh2ZKBpyu9UpBU2OKQq3nWt76YYs0Kq9+jVq8Y8d/
	rjzEB7A05RQIjv5zdB1UAOHCnqdQDSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syDyu78Swce4jgLrSdRBxkp36MHRC4tpZiLldAb8ZNw=;
	b=oYy0Q0WN/8UqOfBHuuu/q21GC1kJAqlbjB2vMaic6t5jvVsWifo4Ci3IOh8xdHoxZ97p2Z
	RPYnh7q6oegJr2AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syDyu78Swce4jgLrSdRBxkp36MHRC4tpZiLldAb8ZNw=;
	b=a22KLDJ88+juyya4vv3twSU5UN1NBqJeAlxOaHQJVcS7nU6RlOuSLhxmWtB44BQe8ayw1Z
	vxto7N2/kpAP3vlPV8+AFzMcFJT4Lnh2ZKBpyu9UpBU2OKQq3nWt76YYs0Kq9+jVq8Y8d/
	rjzEB7A05RQIjv5zdB1UAOHCnqdQDSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syDyu78Swce4jgLrSdRBxkp36MHRC4tpZiLldAb8ZNw=;
	b=oYy0Q0WN/8UqOfBHuuu/q21GC1kJAqlbjB2vMaic6t5jvVsWifo4Ci3IOh8xdHoxZ97p2Z
	RPYnh7q6oegJr2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F306813A8F;
	Tue, 10 Sep 2024 15:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +ObYOHZj4GaxQgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 10 Sep 2024 15:19:18 +0000
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
Subject: [PATCH v2 -next 09/11] PCI: brcmstb: Reuse config structure
Date: Tue, 10 Sep 2024 18:18:43 +0300
Message-ID: <20240910151845.17308-10-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910151845.17308-1-svarbanov@suse.de>
References: <20240910151845.17308-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -5.30
X-Spam-Flag: NO

Instead of copying fields from pcie_cfg_data structure to
brcm_pcie reference it directly.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 drivers/pci/controller/pcie-brcmstb.c | 76 ++++++++++++---------------
 1 file changed, 33 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 43d071d12201..caf2b8b63f75 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -191,11 +191,11 @@
 #define SSC_STATUS_PLL_LOCK_MASK	0x800
 #define PCIE_BRCM_MAX_MEMC		3
 
-#define IDX_ADDR(pcie)			((pcie)->reg_offsets[EXT_CFG_INDEX])
-#define DATA_ADDR(pcie)			((pcie)->reg_offsets[EXT_CFG_DATA])
-#define PCIE_RGR1_SW_INIT_1(pcie)	((pcie)->reg_offsets[RGR1_SW_INIT_1])
-#define HARD_DEBUG(pcie)		((pcie)->reg_offsets[PCIE_HARD_DEBUG])
-#define INTR2_CPU_BASE(pcie)		((pcie)->reg_offsets[PCIE_INTR2_CPU_BASE])
+#define IDX_ADDR(pcie)			((pcie)->cfg->offsets[EXT_CFG_INDEX])
+#define DATA_ADDR(pcie)			((pcie)->cfg->offsets[EXT_CFG_DATA])
+#define PCIE_RGR1_SW_INIT_1(pcie)	((pcie)->cfg->offsets[RGR1_SW_INIT_1])
+#define HARD_DEBUG(pcie)		((pcie)->cfg->offsets[PCIE_HARD_DEBUG])
+#define INTR2_CPU_BASE(pcie)		((pcie)->cfg->offsets[PCIE_INTR2_CPU_BASE])
 
 /* Rescal registers */
 #define PCIE_DVT_PMU_PCIE_PHY_CTRL				0xc700
@@ -283,8 +283,6 @@ struct brcm_pcie {
 	int			gen;
 	u64			msi_target_addr;
 	struct brcm_msi		*msi;
-	const int		*reg_offsets;
-	enum pcie_soc_base	soc_base;
 	struct reset_control	*rescal;
 	struct reset_control	*perst_reset;
 	struct reset_control	*bridge_reset;
@@ -292,18 +290,14 @@ struct brcm_pcie {
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 	u32			hw_rev;
-	int			(*perst_set)(struct brcm_pcie *pcie, u32 val);
-	int			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
-	bool			has_phy;
-	u32			quirks;
-	u8			num_inbound_wins;
+	const struct pcie_cfg_data	*cfg;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
 {
-	return pcie->soc_base == BCM7435 || pcie->soc_base == BCM7425;
+	return pcie->cfg->soc_base == BCM7435 || pcie->cfg->soc_base == BCM7425;
 }
 
 /*
@@ -863,7 +857,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	 * security considerations, and is not implemented in our modern
 	 * SoCs.
 	 */
-	if (pcie->soc_base != BCM7712)
+	if (pcie->cfg->soc_base != BCM7712)
 		add_inbound_win(b++, &n, 0, 0, 0);
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
@@ -880,10 +874,10 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 		 * That being said, each BARs size must still be a power of
 		 * two.
 		 */
-		if (pcie->soc_base == BCM7712)
+		if (pcie->cfg->soc_base == BCM7712)
 			add_inbound_win(b++, &n, size, cpu_start, pcie_start);
 
-		if (n > pcie->num_inbound_wins)
+		if (n > pcie->cfg->num_inbound_wins)
 			break;
 	}
 
@@ -897,7 +891,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	 * that enables multiple memory controllers.  As such, it can return
 	 * now w/o doing special configuration.
 	 */
-	if (pcie->soc_base == BCM7712)
+	if (pcie->cfg->soc_base == BCM7712)
 		return n;
 
 	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
@@ -1020,7 +1014,7 @@ static void set_inbound_win_registers(struct brcm_pcie *pcie,
 		 * 7712:
 		 *     All of their BARs need to be set.
 		 */
-		if (pcie->soc_base == BCM7712) {
+		if (pcie->cfg->soc_base == BCM7712) {
 			/* BUS remap register settings */
 			reg_offset = brcm_ubus_reg_offset(i);
 			tmp = lower_32_bits(cpu_addr) & ~0xfff;
@@ -1043,15 +1037,15 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	int memc, ret;
 
 	/* Reset the bridge */
-	ret = pcie->bridge_sw_init_set(pcie, 1);
+	ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
 	if (ret)
 		return ret;
 
 	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
-	if (pcie->soc_base == BCM2711) {
-		ret = pcie->perst_set(pcie, 1);
+	if (pcie->cfg->soc_base == BCM2711) {
+		ret = pcie->cfg->perst_set(pcie, 1);
 		if (ret) {
-			pcie->bridge_sw_init_set(pcie, 0);
+			pcie->cfg->bridge_sw_init_set(pcie, 0);
 			return ret;
 		}
 	}
@@ -1059,7 +1053,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-	ret = pcie->bridge_sw_init_set(pcie, 0);
+	ret = pcie->cfg->bridge_sw_init_set(pcie, 0);
 	if (ret)
 		return ret;
 
@@ -1079,9 +1073,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	 */
 	if (is_bmips(pcie))
 		burst = 0x1; /* 256 bytes */
-	else if (pcie->soc_base == BCM2711)
+	else if (pcie->cfg->soc_base == BCM2711)
 		burst = 0x0; /* 128 bytes */
-	else if (pcie->soc_base == BCM7278)
+	else if (pcie->cfg->soc_base == BCM7278)
 		burst = 0x3; /* 512 bytes */
 	else
 		burst = 0x2; /* 512 bytes */
@@ -1206,7 +1200,7 @@ static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
 	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
 
 	/* 7712 does not have this (RGR1) timer */
-	if (pcie->soc_base == BCM7712)
+	if (pcie->cfg->soc_base == BCM7712)
 		return;
 
 	/* Each unit in timeout register is 1/216,000,000 seconds */
@@ -1284,7 +1278,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	int ret, i;
 
 	/* Unassert the fundamental reset */
-	ret = pcie->perst_set(pcie, 0);
+	ret = pcie->cfg->perst_set(pcie, 0);
 	if (ret)
 		return ret;
 
@@ -1527,12 +1521,12 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
 
 static inline int brcm_phy_start(struct brcm_pcie *pcie)
 {
-	return pcie->has_phy ? brcm_phy_cntl(pcie, 1) : 0;
+	return pcie->cfg->has_phy ? brcm_phy_cntl(pcie, 1) : 0;
 }
 
 static inline int brcm_phy_stop(struct brcm_pcie *pcie)
 {
-	return pcie->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
+	return pcie->cfg->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
 }
 
 static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
@@ -1543,7 +1537,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	if (brcm_pcie_link_up(pcie))
 		brcm_pcie_enter_l23(pcie);
 	/* Assert fundamental reset */
-	ret = pcie->perst_set(pcie, 1);
+	ret = pcie->cfg->perst_set(pcie, 1);
 	if (ret)
 		return ret;
 
@@ -1557,9 +1551,9 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
 	writel(tmp, base + HARD_DEBUG(pcie));
 
-	if (!(pcie->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
+	if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
 		/* Shutdown PCIe bridge */
-		ret = pcie->bridge_sw_init_set(pcie, 1);
+		ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
 
 	return ret;
 }
@@ -1647,7 +1641,7 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 		goto err_reset;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
-	pcie->bridge_sw_init_set(pcie, 0);
+	pcie->cfg->bridge_sw_init_set(pcie, 0);
 
 	/* SERDES_IDDQ = 0 */
 	tmp = readl(base + HARD_DEBUG(pcie));
@@ -1878,13 +1872,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->dev = &pdev->dev;
 	pcie->np = np;
-	pcie->reg_offsets = data->offsets;
-	pcie->soc_base = data->soc_base;
-	pcie->perst_set = data->perst_set;
-	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
-	pcie->has_phy = data->has_phy;
-	pcie->quirks = data->quirks;
-	pcie->num_inbound_wins = data->num_inbound_wins;
+	pcie->cfg = data;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
@@ -1919,7 +1907,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
 
-	pcie->bridge_sw_init_set(pcie, 0);
+	pcie->cfg->bridge_sw_init_set(pcie, 0);
 
 	if (pcie->swinit_reset) {
 		ret = reset_control_assert(pcie->swinit_reset);
@@ -1958,7 +1946,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
-	if (pcie->soc_base == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
+	if (pcie->cfg->soc_base == BCM4908 &&
+	    pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
 		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
 		ret = -ENODEV;
 		goto fail;
@@ -1982,7 +1971,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	bridge->ops = pcie->soc_base == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
+	bridge->ops = pcie->cfg->soc_base == BCM7425 ?
+				&brcm7425_pcie_ops : &brcm_pcie_ops;
 	bridge->sysdata = pcie;
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.35.3


