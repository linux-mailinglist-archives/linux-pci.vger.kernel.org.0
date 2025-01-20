Return-Path: <linux-pci+bounces-20147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5071A16CC5
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 14:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A6C3A9AA0
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D112A1E25EF;
	Mon, 20 Jan 2025 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BWzKUpwr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ioq9lLKN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BWzKUpwr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ioq9lLKN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D81E1C30;
	Mon, 20 Jan 2025 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378113; cv=none; b=ogQ2114l52pbC2tncqJjzCAwtOqbO2C+ofeDkNnBmGJnW0DyoYxk3LMxwC5JEDBBJHqjwefSG49vdwwwkDgnEUJBrjIzGd0bA+9xrjiTGwoqm3d6c52QKkSAXWuzl5Sv2Aw2SgM6ki1RFzuEW/sIqzNsBnQVZ24VMCGETvzAqSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378113; c=relaxed/simple;
	bh=3lMh5lFp4BK3M7zKk24wn+IxAnj4II1ql1ZrpaPCKV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdMkWg3Lxe3cW18nTfYXwnroFHotsqz6cSE0gAFLzCHHdIF2VNGIshOB0lwirsIuh093rsE+oMab1IUpwhezcjWW41gIKuoWzhJMaC5936vP9WZmRZkYIpG/J+j3AZ7KtS4OOwDAebgc0QD/3IG3uc3PDatFJZf9dW82cByyRvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BWzKUpwr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ioq9lLKN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BWzKUpwr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ioq9lLKN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 375A01F7BA;
	Mon, 20 Jan 2025 13:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737378109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNMEnaoaWPJ+sxIY5eD+3tY94b+X1lAZy7/keyeommQ=;
	b=BWzKUpwrnW79a9b2XXrqGv8Ut8Gk6taJ3Ozesow6Fe2FUvKzekZykRMeKVnGirG/mTlQlp
	cqJtzZvGv9lfaH//POCm26jTLZwzrufg1MOXI7dd4Vggc4Tx+Kuw1QojRr4aPLIff1F1nq
	vLqoh3InYFMQTBiYrXeeUEExBLofP9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737378109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNMEnaoaWPJ+sxIY5eD+3tY94b+X1lAZy7/keyeommQ=;
	b=ioq9lLKNco1k3O+yEfcgJhgyoN0AB8LpTpE9/p7++ClU+oNv3RFTuauv/gOGtvW/RY1vzw
	S1p1pfamLx3a7TBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BWzKUpwr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ioq9lLKN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737378109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNMEnaoaWPJ+sxIY5eD+3tY94b+X1lAZy7/keyeommQ=;
	b=BWzKUpwrnW79a9b2XXrqGv8Ut8Gk6taJ3Ozesow6Fe2FUvKzekZykRMeKVnGirG/mTlQlp
	cqJtzZvGv9lfaH//POCm26jTLZwzrufg1MOXI7dd4Vggc4Tx+Kuw1QojRr4aPLIff1F1nq
	vLqoh3InYFMQTBiYrXeeUEExBLofP9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737378109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNMEnaoaWPJ+sxIY5eD+3tY94b+X1lAZy7/keyeommQ=;
	b=ioq9lLKNco1k3O+yEfcgJhgyoN0AB8LpTpE9/p7++ClU+oNv3RFTuauv/gOGtvW/RY1vzw
	S1p1pfamLx3a7TBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39F1D1393E;
	Mon, 20 Jan 2025 13:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iAzOCzxJjmc4XQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 20 Jan 2025 13:01:48 +0000
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
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH v5 -next 04/11] PCI: brcmstb: Reuse config structure
Date: Mon, 20 Jan 2025 15:01:12 +0200
Message-ID: <20250120130119.671119-5-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250120130119.671119-1-svarbanov@suse.de>
References: <20250120130119.671119-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 375A01F7BA
X-Spam-Level: 
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
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,broadcom.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_RCPT(0.00)[dt];
	R_RATELIMIT(0.00)[to_ip_from(RLw7mkaud87zuqqztkur5718rm)];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51
X-Spam-Flag: NO

Instead of copying fields from pcie_cfg_data structure to
brcm_pcie reference it directly.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelil <florian.fainelli@broadcom.com>
---
v4 -> v5:
 - No changes.

 drivers/pci/controller/pcie-brcmstb.c | 70 ++++++++++++---------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e733a27dc8df..48b2747d8c98 100644
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
@@ -276,8 +276,6 @@ struct brcm_pcie {
 	int			gen;
 	u64			msi_target_addr;
 	struct brcm_msi		*msi;
-	const int		*reg_offsets;
-	enum pcie_soc_base	soc_base;
 	struct reset_control	*rescal;
 	struct reset_control	*perst_reset;
 	struct reset_control	*bridge_reset;
@@ -285,17 +283,14 @@ struct brcm_pcie {
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 	u32			hw_rev;
-	int			(*perst_set)(struct brcm_pcie *pcie, u32 val);
-	int			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
-	bool			has_phy;
-	u8			num_inbound_wins;
+	const struct pcie_cfg_data	*cfg;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
 {
-	return pcie->soc_base == BCM7435 || pcie->soc_base == BCM7425;
+	return pcie->cfg->soc_base == BCM7435 || pcie->cfg->soc_base == BCM7425;
 }
 
 /*
@@ -855,7 +850,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	 * security considerations, and is not implemented in our modern
 	 * SoCs.
 	 */
-	if (pcie->soc_base != BCM7712)
+	if (pcie->cfg->soc_base != BCM7712)
 		add_inbound_win(b++, &n, 0, 0, 0);
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
@@ -872,10 +867,10 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
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
 
@@ -889,7 +884,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	 * that enables multiple memory controllers.  As such, it can return
 	 * now w/o doing special configuration.
 	 */
-	if (pcie->soc_base == BCM7712)
+	if (pcie->cfg->soc_base == BCM7712)
 		return n;
 
 	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
@@ -1012,7 +1007,7 @@ static void set_inbound_win_registers(struct brcm_pcie *pcie,
 		 * 7712:
 		 *     All of their BARs need to be set.
 		 */
-		if (pcie->soc_base == BCM7712) {
+		if (pcie->cfg->soc_base == BCM7712) {
 			/* BUS remap register settings */
 			reg_offset = brcm_ubus_reg_offset(i);
 			tmp = lower_32_bits(cpu_addr) & ~0xfff;
@@ -1036,15 +1031,15 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
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
@@ -1052,7 +1047,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-	ret = pcie->bridge_sw_init_set(pcie, 0);
+	ret = pcie->cfg->bridge_sw_init_set(pcie, 0);
 	if (ret)
 		return ret;
 
@@ -1072,9 +1067,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
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
@@ -1199,7 +1194,7 @@ static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
 	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
 
 	/* 7712 does not have this (RGR1) timer */
-	if (pcie->soc_base == BCM7712)
+	if (pcie->cfg->soc_base == BCM7712)
 		return;
 
 	/* Each unit in timeout register is 1/216,000,000 seconds */
@@ -1277,7 +1272,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	int ret, i;
 
 	/* Unassert the fundamental reset */
-	ret = pcie->perst_set(pcie, 0);
+	ret = pcie->cfg->perst_set(pcie, 0);
 	if (ret)
 		return ret;
 
@@ -1463,12 +1458,12 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
 
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
@@ -1479,7 +1474,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	if (brcm_pcie_link_up(pcie))
 		brcm_pcie_enter_l23(pcie);
 	/* Assert fundamental reset */
-	ret = pcie->perst_set(pcie, 1);
+	ret = pcie->cfg->perst_set(pcie, 1);
 	if (ret)
 		return ret;
 
@@ -1582,7 +1577,7 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 		goto err_reset;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
-	pcie->bridge_sw_init_set(pcie, 0);
+	pcie->cfg->bridge_sw_init_set(pcie, 0);
 
 	/* SERDES_IDDQ = 0 */
 	tmp = readl(base + HARD_DEBUG(pcie));
@@ -1803,12 +1798,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->dev = &pdev->dev;
 	pcie->np = np;
-	pcie->reg_offsets = data->offsets;
-	pcie->soc_base = data->soc_base;
-	pcie->perst_set = data->perst_set;
-	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
-	pcie->has_phy = data->has_phy;
-	pcie->num_inbound_wins = data->num_inbound_wins;
+	pcie->cfg = data;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
@@ -1843,7 +1833,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
 
-	pcie->bridge_sw_init_set(pcie, 0);
+	pcie->cfg->bridge_sw_init_set(pcie, 0);
 
 	if (pcie->swinit_reset) {
 		ret = reset_control_assert(pcie->swinit_reset);
@@ -1882,7 +1872,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
-	if (pcie->soc_base == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
+	if (pcie->cfg->soc_base == BCM4908 &&
+	    pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
 		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
 		ret = -ENODEV;
 		goto fail;
@@ -1897,7 +1888,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	bridge->ops = pcie->soc_base == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
+	bridge->ops = pcie->cfg->soc_base == BCM7425 ?
+				&brcm7425_pcie_ops : &brcm_pcie_ops;
 	bridge->sysdata = pcie;
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.47.0


