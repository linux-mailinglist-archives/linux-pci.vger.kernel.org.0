Return-Path: <linux-pci+bounces-9288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76199917EB6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5802B27978
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A19917E904;
	Wed, 26 Jun 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LYD0VyRe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fWRKKU8/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LYD0VyRe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fWRKKU8/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6240917D34C;
	Wed, 26 Jun 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398808; cv=none; b=LmhgKDrqaR8+b0dii3XN+71qiidGDnJGCXcnpIITrHTx1+PVbl3dQ+yZS7TvFTECh3and9MLZPRG+RAcNsaB5yanOJBFOjcf7muM/9Zo4vndITFkBRvfnnZ4kjjWJDZZTpyp6ZNEOk0YGXKJ814MUcTtJn2fojdvVtzGVZ5QinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398808; c=relaxed/simple;
	bh=hBvKT+woKDc6d5S9L2xndSzH0DYvu4by448J24njEIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UO8NdJbRpR4zQjzM3PE3nZcPpsA7Ix3VdK5ieXaHVBlME2LIE4c0qXrOqwqaAAV9ojmbtDTcAHD1VWGSld6b3vf5as1SY01Sgtzoo/3cULFaN+TsLPxZGqtipJtFyvdgbGHSyeYuBjeQHYGrY4iRYqS3iXFflgkQojC8c/+qR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LYD0VyRe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fWRKKU8/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LYD0VyRe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fWRKKU8/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B01371FB51;
	Wed, 26 Jun 2024 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rG7TLenaNhdBfSdkJB+HAnNqfUqW1wpICxeiaL35Lq0=;
	b=LYD0VyRekFKWEwRAYMw1Rhuja3JXZPU0Tkp99PEGrGlWCxbPnjNUkAEzeC8W6Yoo1XgLGr
	DKuruYHATU+5FkPPw7lJl4G+OFqj4BvyZn4dGUHoTzGYbOxG9WoSSTtjSCw295NA/BPDkG
	qBeky35y7ao4zyLRft5sl/OBgd5FdX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rG7TLenaNhdBfSdkJB+HAnNqfUqW1wpICxeiaL35Lq0=;
	b=fWRKKU8/0R66UJsrYAUGbDLBRHGeXUaymd42YQaK6aTjxQr+FzbvO+YurxCxEr2FRxrKpq
	TD0mnYXrWzoEayCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rG7TLenaNhdBfSdkJB+HAnNqfUqW1wpICxeiaL35Lq0=;
	b=LYD0VyRekFKWEwRAYMw1Rhuja3JXZPU0Tkp99PEGrGlWCxbPnjNUkAEzeC8W6Yoo1XgLGr
	DKuruYHATU+5FkPPw7lJl4G+OFqj4BvyZn4dGUHoTzGYbOxG9WoSSTtjSCw295NA/BPDkG
	qBeky35y7ao4zyLRft5sl/OBgd5FdX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rG7TLenaNhdBfSdkJB+HAnNqfUqW1wpICxeiaL35Lq0=;
	b=fWRKKU8/0R66UJsrYAUGbDLBRHGeXUaymd42YQaK6aTjxQr+FzbvO+YurxCxEr2FRxrKpq
	TD0mnYXrWzoEayCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B626139C2;
	Wed, 26 Jun 2024 10:46:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0K4hI5Pxe2ZuDQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 26 Jun 2024 10:46:43 +0000
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
Subject: [PATCH 4/7] PCI: brcmstb: Reuse config structure
Date: Wed, 26 Jun 2024 13:45:41 +0300
Message-ID: <20240626104544.14233-5-svarbanov@suse.de>
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
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
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

Instead of copying fields from pcie_cfg_data structure to
brcm_pcie reference it directly.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 drivers/pci/controller/pcie-brcmstb.c | 44 ++++++++++++---------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c08683febdd4..4ca509502336 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -184,9 +184,9 @@
 #define SSC_STATUS_PLL_LOCK_MASK	0x800
 #define PCIE_BRCM_MAX_MEMC		3
 
-#define IDX_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_INDEX])
-#define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
-#define PCIE_RGR1_SW_INIT_1(pcie)	(pcie->reg_offsets[RGR1_SW_INIT_1])
+#define IDX_ADDR(pcie)			((pcie)->cfg->offsets[EXT_CFG_INDEX])
+#define DATA_ADDR(pcie)			((pcie)->cfg->offsets[EXT_CFG_DATA])
+#define PCIE_RGR1_SW_INIT_1(pcie)	((pcie)->cfg->offsets[RGR1_SW_INIT_1])
 
 /* Rescal registers */
 #define PCIE_DVT_PMU_PCIE_PHY_CTRL				0xc700
@@ -261,22 +261,19 @@ struct brcm_pcie {
 	int			gen;
 	u64			msi_target_addr;
 	struct brcm_msi		*msi;
-	const int		*reg_offsets;
-	enum pcie_type		type;
 	struct reset_control	*rescal;
 	struct reset_control	*perst_reset;
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 	u32			hw_rev;
-	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
-	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
+	const struct pcie_cfg_data	*cfg;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
 {
-	return pcie->type == BCM7435 || pcie->type == BCM7425;
+	return pcie->cfg->type == BCM7435 || pcie->cfg->type == BCM7425;
 }
 
 /*
@@ -878,16 +875,16 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	int ret, memc;
 
 	/* Reset the bridge */
-	pcie->bridge_sw_init_set(pcie, 1);
+	pcie->cfg->bridge_sw_init_set(pcie, 1);
 
 	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
-	if (pcie->type == BCM2711)
-		pcie->perst_set(pcie, 1);
+	if (pcie->cfg->type == BCM2711)
+		pcie->cfg->perst_set(pcie, 1);
 
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-	pcie->bridge_sw_init_set(pcie, 0);
+	pcie->cfg->bridge_sw_init_set(pcie, 0);
 
 	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
 	if (is_bmips(pcie))
@@ -905,9 +902,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	 */
 	if (is_bmips(pcie))
 		burst = 0x1; /* 256 bytes */
-	else if (pcie->type == BCM2711)
+	else if (pcie->cfg->type == BCM2711)
 		burst = 0x0; /* 128 bytes */
-	else if (pcie->type == BCM7278)
+	else if (pcie->cfg->type == BCM7278)
 		burst = 0x3; /* 512 bytes */
 	else
 		burst = 0x2; /* 512 bytes */
@@ -1120,7 +1117,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	int ret, i;
 
 	/* Unassert the fundamental reset */
-	pcie->perst_set(pcie, 0);
+	pcie->cfg->perst_set(pcie, 0);
 
 	/*
 	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
@@ -1320,7 +1317,7 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	if (brcm_pcie_link_up(pcie))
 		brcm_pcie_enter_l23(pcie);
 	/* Assert fundamental reset */
-	pcie->perst_set(pcie, 1);
+	pcie->cfg->perst_set(pcie, 1);
 
 	/* Deassert request for L23 in case it was asserted */
 	tmp = readl(base + PCIE_MISC_PCIE_CTRL);
@@ -1333,7 +1330,7 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
 
 	/* Shutdown PCIe bridge */
-	pcie->bridge_sw_init_set(pcie, 1);
+	pcie->cfg->bridge_sw_init_set(pcie, 1);
 }
 
 static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
@@ -1413,7 +1410,7 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 		goto err_reset;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
-	pcie->bridge_sw_init_set(pcie, 0);
+	pcie->cfg->bridge_sw_init_set(pcie, 0);
 
 	/* SERDES_IDDQ = 0 */
 	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
@@ -1595,10 +1592,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->dev = &pdev->dev;
 	pcie->np = np;
-	pcie->reg_offsets = data->offsets;
-	pcie->type = data->type;
-	pcie->perst_set = data->perst_set;
-	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
+	pcie->cfg = data;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
@@ -1645,7 +1639,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
-	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
+	if (pcie->cfg->type == BCM4908 &&
+	    pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
 		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
 		ret = -ENODEV;
 		goto fail;
@@ -1660,7 +1655,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	bridge->ops = pcie->type == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
+	bridge->ops = pcie->cfg->type == BCM7425 ?
+				&brcm7425_pcie_ops : &brcm_pcie_ops;
 	bridge->sysdata = pcie;
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.43.0


