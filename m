Return-Path: <linux-pci+bounces-15297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768979B02D1
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 14:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9F31F21B57
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B69870822;
	Fri, 25 Oct 2024 12:45:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343293DAC0D;
	Fri, 25 Oct 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860338; cv=none; b=FiTduWTGeGb5FJeU1lA+ec4OmM2Xw65mMNOb49Ruc55XCH+l7BHssQ4x6emZUI2ovmghWlpAuVz/yewx8gz3aY/mz5MEWESReaCAM/gwW065RvEPvFF12LXzte2J9hSJJEZCbt0YaCWlkSRFrVXnvTN3wTnZQNCIPZep+E6DztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860338; c=relaxed/simple;
	bh=R8PgU+MutmDV5F4/Y3yJh/BQu7g4AU5OQxrJb86VyGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMQ+LRHfx88govOVm8T/UiPmOKL9IcfZnrI4SH3CPXkoVPxUxUfrVCp/W/IRM9+Nia9co8F25Abo34sSUEALD9Q5VfWiOD06uF7FjHNnFtV1/S4LhaElBnucd2gyqSYqaD5FESFAn/lUQvVS4W1u90uqQPA8HZC+Y2HlEEWrOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DD9021D74;
	Fri, 25 Oct 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A04E136F5;
	Fri, 25 Oct 2024 12:45:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6MGSE+2SG2fzOAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 25 Oct 2024 12:45:33 +0000
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
Subject: [PATCH v4 06/10] PCI: brcmstb: Enable external MSI-X if available
Date: Fri, 25 Oct 2024 15:45:11 +0300
Message-ID: <20241025124515.14066-7-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025124515.14066-1-svarbanov@suse.de>
References: <20241025124515.14066-1-svarbanov@suse.de>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[dt];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 6DD9021D74
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On RPi5 there is an external MIP MSI-X interrupt controller
which can handle up to 64 interrupts.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
v3 -> v4:
 - no changes.

 drivers/pci/controller/pcie-brcmstb.c | 63 +++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c01462b07eea..af01a7915c94 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1318,6 +1318,52 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
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
@@ -1879,11 +1925,20 @@ static int brcm_pcie_probe(struct platform_device *pdev)
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


