Return-Path: <linux-pci+bounces-12991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15224973B7A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCF2283E88
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A51A2C01;
	Tue, 10 Sep 2024 15:19:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC5F1A2561;
	Tue, 10 Sep 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981559; cv=none; b=VSCI6ZIZjc31sBk2EV3b+cyeGREUxDqluwu5cG5XdCC2DzVJh0eiyr3tkJrNwnf+t4ohJ3vIUrYO6JVNnyqPbCZOKNSKDNLZyILZga+9+VzmAMjD8veGOFPRZntHbqnmubSp9WwJmWYyeK/NkXLznR6zyT0X+HTIvn5EtArZ8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981559; c=relaxed/simple;
	bh=RFLTpjvcxXgnO8pZbTh/A1eN3/OXULWZdi5csBclRyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/aYptsPWVxS+b0UIZITVNc6MuixAz81woceoncm2QqH51Is6DBvrkQ+a+SPfAtbGpNvBR8n2Sl7ONThPpLeq4RSCcu95sMFKLcfr1ddcPskMwAYiFDq3/rxZdV2YM0HO2ali40HfEKZGRoGOHMsxlAZa28ZtgPwSq/Vd5LtNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80DA91F821;
	Tue, 10 Sep 2024 15:19:16 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F85F13A3A;
	Tue, 10 Sep 2024 15:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kPXPGHNj4GaxQgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 10 Sep 2024 15:19:15 +0000
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
Subject: [PATCH v2 -next 06/11] PCI: brcmstb: Enable external MSI-X if available
Date: Tue, 10 Sep 2024 18:18:40 +0300
Message-ID: <20240910151845.17308-7-svarbanov@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[dt]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 80DA91F821
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On RPi5 there is an external MIP MSI-X interrupt controller
which can handle up to 64 interrupts.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 drivers/pci/controller/pcie-brcmstb.c | 63 +++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index f2a7a8e93a74..d78f33b33884 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1333,6 +1333,52 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
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
@@ -1898,11 +1944,20 @@ static int brcm_pcie_probe(struct platform_device *pdev)
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
2.35.3


