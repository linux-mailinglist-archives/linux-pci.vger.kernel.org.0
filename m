Return-Path: <linux-pci+bounces-14464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A099799CB13
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C095A1C23C72
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469511AC89A;
	Mon, 14 Oct 2024 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HJXLGE4n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ssdhNbJw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HJXLGE4n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ssdhNbJw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D081ABEAD;
	Mon, 14 Oct 2024 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911262; cv=none; b=hzYPrQTALd6CKUIPujAvWGBCw1DbQzjEgCCdAfssPH1hij+fp1Xxb2EJjtCl3FtvsH4AGs+1ePWW4I8cOPN8p7GtPHcgCK1wwLcmwlRu1ZF2LF8LlSXSRiOmPqb8rYv9iteVIdPBzTA4qa2o9QtiAPbsS2WCB3LJ4KtYz2E2ayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911262; c=relaxed/simple;
	bh=PrfP7Oac+w/o/H2gkwpbllj+z9evzAJFbgexhwyJMKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEGzXFJH9Opy80jIoUt0nKzNujGTc3AiEWBcs3Odk8Gm/opnrWo8n/gWYlrsXOT7LdCy5kfXmcR7I9mgg5USa8ehuuJzwkaV3XwNWu9QnbLiUT7WqCqFtj8VRpTqyr21+XJUspwkbfVcdUAZmxN9fVE3JZncnvoKxPkaekkQYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HJXLGE4n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ssdhNbJw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HJXLGE4n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ssdhNbJw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D71E421D47;
	Mon, 14 Oct 2024 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eMhuTNIBdSJPh8TPKTFZlnEo8UZ6V6UxbrWcayc+o0=;
	b=HJXLGE4nqCmjxd7DHWJBgcLe4LF6mgkwBlzIDZHW8fhdHAieXlVWKXtw79DKYERHpV0ies
	HsnW+2ztvO4c9V2CgxitsFlYx4UBF9pHe0HgGw586StFCJjBVShx+2RAFp5L1mBDQXckJP
	hoGLDVhnjK0wS73stD1paUFTX463Ubk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eMhuTNIBdSJPh8TPKTFZlnEo8UZ6V6UxbrWcayc+o0=;
	b=ssdhNbJwCYrh/oRnPPzEtGI/aW9xyupJogPqEj+srrqO5PK+lB6uoIGe6eTm+ALTzygPaG
	V6wBBWuWs0HGZ+BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HJXLGE4n;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ssdhNbJw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eMhuTNIBdSJPh8TPKTFZlnEo8UZ6V6UxbrWcayc+o0=;
	b=HJXLGE4nqCmjxd7DHWJBgcLe4LF6mgkwBlzIDZHW8fhdHAieXlVWKXtw79DKYERHpV0ies
	HsnW+2ztvO4c9V2CgxitsFlYx4UBF9pHe0HgGw586StFCJjBVShx+2RAFp5L1mBDQXckJP
	hoGLDVhnjK0wS73stD1paUFTX463Ubk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eMhuTNIBdSJPh8TPKTFZlnEo8UZ6V6UxbrWcayc+o0=;
	b=ssdhNbJwCYrh/oRnPPzEtGI/aW9xyupJogPqEj+srrqO5PK+lB6uoIGe6eTm+ALTzygPaG
	V6wBBWuWs0HGZ+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D741513A42;
	Mon, 14 Oct 2024 13:07:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eLgpMpkXDWcqTwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 14 Oct 2024 13:07:37 +0000
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
Subject: [PATCH v3 06/11] PCI: brcmstb: Avoid turn off of bridge reset
Date: Mon, 14 Oct 2024 16:07:05 +0300
Message-ID: <20241014130710.413-7-svarbanov@suse.de>
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
X-Rspamd-Queue-Id: D71E421D47
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
	RCPT_COUNT_TWELVE(0.00)[21];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLw7mkaud87zuqqztkur5718rm)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51
X-Spam-Flag: NO

On PCIe turn off avoid shutdown of bridge reset,
by introducing a quirk flag.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
v2 -> v3:
 - Added more descriptive comment on CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN quirk.

 drivers/pci/controller/pcie-brcmstb.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index b76c16287f37..757a1646d53c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -234,10 +234,20 @@ struct inbound_win {
 	u64 cpu_addr;
 };
 
+/*
+ * The RESCAL block is tied to PCIe controller #1, regardless of the number of
+ * controllers, and turning off PCIe controller #1 prevents access to the RESCAL
+ * register blocks, therefore not other controller can access this register
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
@@ -290,6 +300,7 @@ struct brcm_pcie {
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
 	bool			has_phy;
+	u32			quirks;
 	u8			num_inbound_wins;
 };
 
@@ -1539,8 +1550,9 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
 	writel(tmp, base + HARD_DEBUG(pcie));
 
-	/* Shutdown PCIe bridge */
-	ret = pcie->bridge_sw_init_set(pcie, 1);
+	if (!(pcie->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
+		/* Shutdown PCIe bridge */
+		ret = pcie->bridge_sw_init_set(pcie, 1);
 
 	return ret;
 }
@@ -1854,6 +1866,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->perst_set = data->perst_set;
 	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
 	pcie->has_phy = data->has_phy;
+	pcie->quirks = data->quirks;
 	pcie->num_inbound_wins = data->num_inbound_wins;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
-- 
2.43.0


