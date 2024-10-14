Return-Path: <linux-pci+bounces-14463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5598699CB10
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6D5B23D81
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E1B1ABED8;
	Mon, 14 Oct 2024 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZAxlWxqi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5/Zp48/p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZAxlWxqi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5/Zp48/p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694E31AB534;
	Mon, 14 Oct 2024 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911261; cv=none; b=cRCFa03R7hnQkozSK/TuEhl3m8XnohtsO3jeCOiHat5PkmnItR38We7BYgAkzqxxON99r5CDtKKKGyQJZpzqcfQiUX+ycP7IhynjuI7V/2C4YQM5e6ifZ8o2paUMvINeAVbwnVVymTKWaqF1jwW0j3DuftR5w8zR8VKe53ySd4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911261; c=relaxed/simple;
	bh=6GWRSgUpCdoUY9hh+1yTDdP86TiWongLkz8HE537dtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KibaexeplQ1ro5OicAp2VAXT4uRjla8eVUq2MaBdofi3YTXntmQX8aM7wSn+LqRYAhartEseaezf563W9prryBchWRXxIpkHQC7fd7cAcNJqAuJW9B4RsCiPyhsxOps/r+T3MwiCsKZ4X++q6n9pefZsrvDN0apTqBGbLCJq1Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZAxlWxqi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5/Zp48/p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZAxlWxqi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5/Zp48/p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D24131FE57;
	Mon, 14 Oct 2024 13:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DCAVJXCB/9zzBCk/NgKVl3/lMA3I5cjuushV32SkV0=;
	b=ZAxlWxqi4J8lej4rm8+JhepYDPLTp5ypbEP4s/QklpyYTRJjuw5XGPuWh0myFF27nuvGIc
	Yb/OWKt3i53k9vnPtKVgH0uRVt4lYE2/k/5BXH/WSyD/we3wXTNqUBL/vwza0INgWKbGkI
	cjyh91m5onuTsa2oyZOuj/2b70KZ+AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DCAVJXCB/9zzBCk/NgKVl3/lMA3I5cjuushV32SkV0=;
	b=5/Zp48/pk1hv3Ra5Vx7IRvZUeqMqa1QKfmd2R0lcILyp7m0M9/DQyQVYWlRoLqm2NpbS1Q
	HQoybphr0i/n9RBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZAxlWxqi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="5/Zp48/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DCAVJXCB/9zzBCk/NgKVl3/lMA3I5cjuushV32SkV0=;
	b=ZAxlWxqi4J8lej4rm8+JhepYDPLTp5ypbEP4s/QklpyYTRJjuw5XGPuWh0myFF27nuvGIc
	Yb/OWKt3i53k9vnPtKVgH0uRVt4lYE2/k/5BXH/WSyD/we3wXTNqUBL/vwza0INgWKbGkI
	cjyh91m5onuTsa2oyZOuj/2b70KZ+AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DCAVJXCB/9zzBCk/NgKVl3/lMA3I5cjuushV32SkV0=;
	b=5/Zp48/pk1hv3Ra5Vx7IRvZUeqMqa1QKfmd2R0lcILyp7m0M9/DQyQVYWlRoLqm2NpbS1Q
	HQoybphr0i/n9RBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C65CF13A79;
	Mon, 14 Oct 2024 13:07:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CNT6LZgXDWcqTwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 14 Oct 2024 13:07:36 +0000
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
Subject: [PATCH v3 05/11] PCI: brcmstb: Enable external MSI-X if available
Date: Mon, 14 Oct 2024 16:07:04 +0300
Message-ID: <20241014130710.413-6-svarbanov@suse.de>
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
X-Rspamd-Queue-Id: D24131FE57
X-Spam-Score: -1.51
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLw7mkaud87zuqqztkur5718rm)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On RPi5 there is an external MIP MSI-X interrupt controller
which can handle up to 64 interrupts.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
v2 -> v3:
 - No changes

drivers/pci/controller/pcie-brcmstb.c | 63 +++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index b0ef2f31914d..b76c16287f37 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1323,6 +1323,52 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	return 0;
 }
 
+static int brcm_pcie_enable_external_msix(struct brcm_pcie *pcie,
+					  struct device_node *msi_np)
+{
+	struct inbound_win inbound_wins[PCIE_BRCM_MAX_INBOUND_WINS];
+	u64 msi_pci_addr, msi_phys_addr;
+	struct resource r;
+	int mip_bar, ret;
+	u32 val, reg;
+
+	ret = of_property_read_reg(msi_np, 1, &msi_pci_addr, NULL);
+	if (ret)
+		return ret;
+
+	ret = of_address_to_resource(msi_np, 0, &r);
+	if (ret)
+		return ret;
+
+	msi_phys_addr = r.start;
+
+	/* Find free inbound window for MIP access */
+	mip_bar = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
+	if (mip_bar < 0)
+		return mip_bar;
+
+	mip_bar += 1;
+	reg = brcm_bar_reg_offset(mip_bar);
+
+	val = lower_32_bits(msi_pci_addr);
+	val |= brcm_pcie_encode_ibar_size(SZ_4K);
+	writel(val, pcie->base + reg);
+
+	val = upper_32_bits(msi_pci_addr);
+	writel(val, pcie->base + reg + 4);
+
+	reg = brcm_ubus_reg_offset(mip_bar);
+
+	val = lower_32_bits(msi_phys_addr);
+	val |= PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK;
+	writel(val, pcie->base + reg);
+
+	val = upper_32_bits(msi_phys_addr);
+	writel(val, pcie->base + reg + 4);
+
+	return 0;
+}
+
 static const char * const supplies[] = {
 	"vpcie3v3",
 	"vpcie3v3aux",
@@ -1888,11 +1934,20 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
-	if (pci_msi_enabled() && msi_np == pcie->np) {
-		ret = brcm_pcie_enable_msi(pcie);
+	if (pci_msi_enabled()) {
+		msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
+		const char *str;
+
+		if (msi_np == pcie->np) {
+			str = "internal MSI";
+			ret = brcm_pcie_enable_msi(pcie);
+		} else {
+			str = "external MSI-X";
+			ret = brcm_pcie_enable_external_msix(pcie, msi_np);
+		}
+
 		if (ret) {
-			dev_err(pcie->dev, "probe of internal MSI failed");
+			dev_err(pcie->dev, "enable of %s failed\n", str);
 			goto fail;
 		}
 	}
-- 
2.43.0


