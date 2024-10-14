Return-Path: <linux-pci+bounces-14467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8027499CB1B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBCCEB2475A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2D81AA7B9;
	Mon, 14 Oct 2024 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NLNcupGp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X3YVX3Ga";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sh7AI614";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jmR8rWhy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29601AE01D;
	Mon, 14 Oct 2024 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911265; cv=none; b=fuDl4n9DKsJLS6qsKZ+rpnK+BC1QPP8k27HA0QeWx10I7k+lZx5rwYVm0bK47zCRcbZfzyU0d4ydTJZ4JUc3Nb14Bks1P/JzRe7+uOZo35Sl2TDsLTY1xCea6FM1C52L26T6r2KWJwE+QYRD6FZooj7Utx+tYA8xHSQihgm4JeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911265; c=relaxed/simple;
	bh=Re/QGG9c4MGrhUqDXKv6GdwzPh7orhMleqlGLWYZi1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qND29YlBaxCpYVR/JokK+RBBsAq8HMYyGIZm0tsdfGWvaNPXu5gTBXBKSsf70Lb38gg/yCRyO6oNEuI8sBpV2A0VtXQL/SB/Ltm0RbwkX7+5cuZmvIv8FlhVJrx9We4yBW4AssX0HXPepiXvPTq7YxQMBaf7nIQNqvIbtEft5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NLNcupGp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X3YVX3Ga; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sh7AI614; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jmR8rWhy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE6511FE62;
	Mon, 14 Oct 2024 13:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEo+f9srrd2OxsZkjWPR5yewyjOaUtrHuseqRED47jw=;
	b=NLNcupGpY1wn2VBM7lmtOEGpcSk8uerJmcDUX0Pe6tJkDPiaQ2y/Ay5sDwJklinPNOlBdF
	np9wwdyMbTcIJLncJYFFLXyoz6bsbt/2B+rFjFINAsrIXeAylW+2orIeOQ+eS4q9UBvoge
	cm9Nc9zGVP1Tu5xCR7A97dTGMoSLY0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEo+f9srrd2OxsZkjWPR5yewyjOaUtrHuseqRED47jw=;
	b=X3YVX3GavqYV853GSqFdPHqDtzlVFkwzlsrUNZD7YH4P9MxPrJG1weIx17TPA/71ZUpAmV
	EDYeDhWdbI3izOCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEo+f9srrd2OxsZkjWPR5yewyjOaUtrHuseqRED47jw=;
	b=Sh7AI614FJKfZYmYIje/xX6fB9qp5KHAyRzn2CXydyETMt6AQm7Wa368NCGhbws6Y9E2Ec
	gtoCKaYiodsjbAQxFKg2F69jZZrLhSBNqu2VG9bIpycxE2MUa3WH2i+4+5+eBn3De/PAvP
	zr0ulg03Yjp6Pmkqef4OR9nWY9Y59RM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEo+f9srrd2OxsZkjWPR5yewyjOaUtrHuseqRED47jw=;
	b=jmR8rWhyoAaVC8vAYXjKAhgv7mYL8Ki6Gyo8neR7fpyzPUs83Xb5YFytU2Nm9LIsrteiSl
	NW86uU7n0cDXEkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0623013A79;
	Mon, 14 Oct 2024 13:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KA/FOpwXDWcqTwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 14 Oct 2024 13:07:40 +0000
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
Subject: [PATCH v3 09/11] PCI: brcmstb: Adjust PHY PLL setup to use a 54MHz input refclk
Date: Mon, 14 Oct 2024 16:07:08 +0300
Message-ID: <20241014130710.413-10-svarbanov@suse.de>
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

Use canned MDIO writes from Broadcom that switch the ref_clk output
pair to run from the internal fractional PLL, and set the internal
PLL to expect a 54MHz input reference clock.

Without this RPi5 PCIe cannot enumerate endpoint devices on
extension connector.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
v2 -> v3:
 - New patch.

 drivers/pci/controller/pcie-brcmstb.c | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 407343a30439..12591e292c0c 100644
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
@@ -826,6 +831,32 @@ static int brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
 	return 0;
 }
 
+static int brcm_pcie_post_setup_bcm2712(struct brcm_pcie *pcie)
+{
+	const u16 data[] = { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030, 0x5030, 0x0007 };
+	const u8 regs[] = { 0x16, 0x17, 0x18, 0x19, 0x1b, 0x1c, 0x1e };
+	u32 tmp;
+	int i;
+
+	/* Allow a 54MHz (xosc) refclk source */
+
+	brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, SET_ADDR_OFFSET, 0x1600);
+
+	for (i = 0; i < ARRAY_SIZE(regs); i++)
+		brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, regs[i], data[i]);
+
+	usleep_range(100, 200);
+
+	/* Fix for L1SS errata */
+	tmp = readl(pcie->base + PCIE_RC_PL_PHY_CTL_15);
+	tmp &= ~PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK;
+	/* PM clock period is 18.52ns (round down) */
+	tmp |= 0x12;
+	writel(tmp, pcie->base + PCIE_RC_PL_PHY_CTL_15);
+
+	return 0;
+}
+
 static void add_inbound_win(struct inbound_win *b, u8 *count, u64 size,
 			    u64 cpu_addr, u64 pci_offset)
 {
@@ -1189,6 +1220,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK);
 	writel(tmp, base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
 
+	if (pcie->cfg->post_setup)
+		pcie->cfg->post_setup(pcie);
+
 	return 0;
 }
 
@@ -1761,6 +1795,7 @@ static const struct pcie_cfg_data bcm2712_cfg = {
 	.soc_base	= BCM7712,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.post_setup	= brcm_pcie_post_setup_bcm2712,
 	.quirks		= CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN,
 	.num_inbound_wins = 10,
 };
-- 
2.43.0


