Return-Path: <linux-pci+bounces-20149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EFEA16CCA
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 14:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7710316A037
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDB01E32B6;
	Mon, 20 Jan 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xrDys0bl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jGr9OA1h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xrDys0bl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jGr9OA1h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6061E2310;
	Mon, 20 Jan 2025 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378115; cv=none; b=JP1fBfHnj78y/7+IbwuU6fhKD3LVeI5BZD3vq4D+tCDLl2khkFxsZj9FreNP0qv91iisuvE9pHPej2nzBMmd/zTALOJ6KjYNKNxIx1+RwWwbeMYsrYj42vbyzJ9GTVDl5XN27D9foTreylUYs5SEg9R7fGS+2oD/fniOcf3hd80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378115; c=relaxed/simple;
	bh=LszW2CXGy4PnnD6kWXDpJunyu/ZepYJjr47aNZJaaVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAvDbziozPNozXr+t8E+uCPRPuCObSwVnigsN/Yg6O3lSloYcppGoLM4+6GyxRPsgGb0ovP14kJUVZJgAsI08LnvMMQ1FA41F5VXjBAEAQdJo+KDdfTAsC9VRhW7VKx21mfpREDviQshIKm2f8cCJzIfF0WmbMyYPNIJfXIemNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xrDys0bl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jGr9OA1h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xrDys0bl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jGr9OA1h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B8C42118E;
	Mon, 20 Jan 2025 13:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737378111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqdRXFThafvaNgTZcZyA2i0EQ7u6jl3E97vuuTbOYUM=;
	b=xrDys0blkgX/SNMYH2Da3dav+ybw2SjthaprdQv6rNFgh47Kxol+53L8b9qQLJWWFRIc3y
	RXwV42117lvxXcIUoPP667rHXl7Z51sea+xyT9fzjG8POC7rGDGw6RLvOcXpQn9zA4ArLE
	m41mzI1ZHVGJGmFTrwVddyQsX4eCQus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737378111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqdRXFThafvaNgTZcZyA2i0EQ7u6jl3E97vuuTbOYUM=;
	b=jGr9OA1hwjfxV3rjfn2t2mgQPGWS3+K6EYOOAfgdr2pWs/k/zPcxsgTCjhbtIQzERNM30q
	BgTVgOs32E/Md+Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xrDys0bl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jGr9OA1h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737378111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqdRXFThafvaNgTZcZyA2i0EQ7u6jl3E97vuuTbOYUM=;
	b=xrDys0blkgX/SNMYH2Da3dav+ybw2SjthaprdQv6rNFgh47Kxol+53L8b9qQLJWWFRIc3y
	RXwV42117lvxXcIUoPP667rHXl7Z51sea+xyT9fzjG8POC7rGDGw6RLvOcXpQn9zA4ArLE
	m41mzI1ZHVGJGmFTrwVddyQsX4eCQus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737378111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqdRXFThafvaNgTZcZyA2i0EQ7u6jl3E97vuuTbOYUM=;
	b=jGr9OA1hwjfxV3rjfn2t2mgQPGWS3+K6EYOOAfgdr2pWs/k/zPcxsgTCjhbtIQzERNM30q
	BgTVgOs32E/Md+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53FE31393E;
	Mon, 20 Jan 2025 13:01:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IMomEj5Jjmc4XQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 20 Jan 2025 13:01:50 +0000
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
Subject: [PATCH v5 -next 06/11] PCI: brcmstb: Add bcm2712 support
Date: Mon, 20 Jan 2025 15:01:14 +0200
Message-ID: <20250120130119.671119-7-svarbanov@suse.de>
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
X-Rspamd-Queue-Id: 4B8C42118E
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,broadcom.com:email,suse.de:email,suse.de:dkim,suse.de:mid];
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

Add bare minimum amount of changes in order to support PCIe RC hardware
IP found on RPi5. The PCIe controller on bcm2712 is based on bcm7712 and
as such it inherits register offsets, perst, bridge_reset ops and inbound
windows count.
Although, the implementation for bcm2712 needs a workaround related to the
control of the bridge_reset where turning off of the root port must not
shutdown the bridge_reset and this must be avoided. To implement this
workaround a quirks field is introduced in pcie_cfg_data struct.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v4 -> v5:
 - No changes.

 drivers/pci/controller/pcie-brcmstb.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 59190d8be0fb..50607df34a66 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -234,10 +234,20 @@ struct inbound_win {
 	u64 cpu_addr;
 };
 
+/*
+ * The RESCAL block is tied to PCIe controller #1, regardless of the number of
+ * controllers, and turning off PCIe controller #1 prevents access to the RESCAL
+ * register blocks, therefore no other controller can access this register
+ * space, and depending upon the bus fabric we may get a timeout (UBUS/GISB),
+ * or a hang (AXI).
+ */
+#define CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN		BIT(0)
+
 struct pcie_cfg_data {
 	const int *offsets;
 	const enum pcie_soc_base soc_base;
 	const bool has_phy;
+	const u32 quirks;
 	u8 num_inbound_wins;
 	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
@@ -1488,8 +1498,9 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
 	writel(tmp, base + HARD_DEBUG(pcie));
 
-	/* Shutdown PCIe bridge */
-	ret = pcie->bridge_sw_init_set(pcie, 1);
+	if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
+		/* Shutdown PCIe bridge */
+		ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
 
 	return ret;
 }
@@ -1699,6 +1710,15 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.num_inbound_wins = 3,
 };
 
+static const struct pcie_cfg_data bcm2712_cfg = {
+	.offsets	= pcie_offsets_bcm7712,
+	.soc_base	= BCM7712,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.quirks		= CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN,
+	.num_inbound_wins = 10,
+};
+
 static const struct pcie_cfg_data bcm4908_cfg = {
 	.offsets	= pcie_offsets,
 	.soc_base	= BCM4908,
@@ -1750,6 +1770,7 @@ static const struct pcie_cfg_data bcm7712_cfg = {
 
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
+	{ .compatible = "brcm,bcm2712-pcie", .data = &bcm2712_cfg },
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
-- 
2.47.0


