Return-Path: <linux-pci+bounces-20150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72192A16CCE
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 14:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556281672A2
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 13:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AA91E32DC;
	Mon, 20 Jan 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PhG//CNR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XE+soJKd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PhG//CNR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XE+soJKd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8D1E2611;
	Mon, 20 Jan 2025 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378116; cv=none; b=N4A/QuSpgRTE7GHHVbKKAdBP/MVrX2ITANjag2j+kvP/ia4O5INveO1ZeUwfW7VZvct14xMK3xq8zBhDo7NFJs0a5sZ8zbjzFdOoxUiVPejeT9zAR8rb0AnfIiVkP3g9qyLsysT0V3M3nZoUybUsqYK/XXdeSTvo7R03W1hSPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378116; c=relaxed/simple;
	bh=WIX0K86rMpXlzJP31BX3SWHNyljKuS6ojPc/SfIlp1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5dqa6BFyvNr32Sg/9IZBVq8uHmiQ5lCYAKOfMjA48F5QcSfQFT5Jd07nnFd6r9FYW1WriJQGE/DAxtq5FSPZAYBH3hvNV4QKO1+Xp46XS+Ewvk2P7RFVY0C0jJQfn6ay6pdnSxb0i8xX+z00TvX+85T5PfHD8PX8bT7ZhaZAro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PhG//CNR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XE+soJKd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PhG//CNR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XE+soJKd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 531BC1F7B9;
	Mon, 20 Jan 2025 13:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737378112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr83CCecePsYaQsEP0wegYmzR9BkPmF5MRTASSF+bao=;
	b=PhG//CNRuC9SmwtWfawqRjrbp834igWWjtTZHDYxfM10FQT+Os39kpEecuz0g34dSYImgs
	GgXkJNN3gHhrZ1JkICqngnT3s6rZUR61fIz0LWPxOV0F3k/H1KdB9K42EjZpJvkUfBi9xb
	ff2h5CklCN7Hv34YQwkxSABYGdZRW9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737378112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr83CCecePsYaQsEP0wegYmzR9BkPmF5MRTASSF+bao=;
	b=XE+soJKdKZnJCpRkPXAyvgd/V5YW8MRgDRxdTgU0WYsOCtnof9moM/PVlXneQVsYtfO51Q
	zsr8X8Mq06CbuFBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737378112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr83CCecePsYaQsEP0wegYmzR9BkPmF5MRTASSF+bao=;
	b=PhG//CNRuC9SmwtWfawqRjrbp834igWWjtTZHDYxfM10FQT+Os39kpEecuz0g34dSYImgs
	GgXkJNN3gHhrZ1JkICqngnT3s6rZUR61fIz0LWPxOV0F3k/H1KdB9K42EjZpJvkUfBi9xb
	ff2h5CklCN7Hv34YQwkxSABYGdZRW9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737378112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr83CCecePsYaQsEP0wegYmzR9BkPmF5MRTASSF+bao=;
	b=XE+soJKdKZnJCpRkPXAyvgd/V5YW8MRgDRxdTgU0WYsOCtnof9moM/PVlXneQVsYtfO51Q
	zsr8X8Mq06CbuFBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B283139D2;
	Mon, 20 Jan 2025 13:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CK3hEz9Jjmc4XQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 20 Jan 2025 13:01:51 +0000
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
Subject: [PATCH v5 -next 07/11] PCI: brcmstb: Adjust PHY PLL setup to use a 54MHz input refclk
Date: Mon, 20 Jan 2025 15:01:15 +0200
Message-ID: <20250120130119.671119-8-svarbanov@suse.de>
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
X-Spam-Score: -1.30
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,broadcom.com:email,suse.de:mid,suse.de:email];
	RCPT_COUNT_TWELVE(0.00)[22];
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
X-Spam-Flag: NO
X-Spam-Level: 

The default input reference clock for the PHY PLL is 100Mhz, except for
some devices where it is 54Mhz like bcm2712C1 and bcm2712D0.

To implement this adjustments introduce a new .post_setup op in
pcie_cfg_data and call it at the end of brcm_pcie_setup function.

The bcm2712 .post_setup callback implements the required MDIO writes that
switch the PLL refclk and also change PHY PM clock period.

Without this RPi5 PCIex1 is unable to enumerate endpoint devices on
the expansion connector.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v4 -> v5:
 - Updated a comment (Jim).

 drivers/pci/controller/pcie-brcmstb.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 50607df34a66..03396a9d97be 100644
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
@@ -251,6 +255,7 @@ struct pcie_cfg_data {
 	u8 num_inbound_wins;
 	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	int (*post_setup)(struct brcm_pcie *pcie);
 };
 
 struct subdev_regulators {
@@ -826,6 +831,38 @@ static int brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
 	return 0;
 }
 
+static int brcm_pcie_post_setup_bcm2712(struct brcm_pcie *pcie)
+{
+	const u16 data[] = { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030, 0x5030, 0x0007 };
+	const u8 regs[] = { 0x16, 0x17, 0x18, 0x19, 0x1b, 0x1c, 0x1e };
+	int ret, i;
+	u32 tmp;
+
+	/* Allow a 54MHz (xosc) refclk source */
+	ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, SET_ADDR_OFFSET, 0x1600);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+		ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, regs[i], data[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	usleep_range(100, 200);
+
+	/*
+	 * Set L1SS sub-state timers to avoid lengthy state transitions,
+	 * PM clock period is 18.52ns (1/54MHz, round down).
+	 */
+	tmp = readl(pcie->base + PCIE_RC_PL_PHY_CTL_15);
+	tmp &= ~PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK;
+	tmp |= 0x12;
+	writel(tmp, pcie->base + PCIE_RC_PL_PHY_CTL_15);
+
+	return 0;
+}
+
 static void add_inbound_win(struct inbound_win *b, u8 *count, u64 size,
 			    u64 cpu_addr, u64 pci_offset)
 {
@@ -1189,6 +1226,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK);
 	writel(tmp, base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
 
+	if (pcie->cfg->post_setup) {
+		ret = pcie->cfg->post_setup(pcie);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -1715,6 +1758,7 @@ static const struct pcie_cfg_data bcm2712_cfg = {
 	.soc_base	= BCM7712,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.post_setup	= brcm_pcie_post_setup_bcm2712,
 	.quirks		= CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN,
 	.num_inbound_wins = 10,
 };
-- 
2.47.0


