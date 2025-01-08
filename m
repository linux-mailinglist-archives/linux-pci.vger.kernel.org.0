Return-Path: <linux-pci+bounces-19578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D304A06974
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 00:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0915D1676A6
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 23:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229AA2046AA;
	Wed,  8 Jan 2025 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4BNrrHl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C29204F6F
	for <linux-pci@vger.kernel.org>; Wed,  8 Jan 2025 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736379089; cv=none; b=iwOL+uP+pP4gaJoDQurtEvKjH8ntUARWcmxsC1haLUObJgGYQnkZvOvxcXf0DJez3qgTh8DNyr8naDIF10hxYUF4nwY4gc346p8uK+yen1bza7wkO/S3Xbnup3HMzLekABiHV65Auhyj178sSFZiKorEfhf2tWdYtiRB0RF3iDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736379089; c=relaxed/simple;
	bh=GiFdQ5UtYcRYcp3zYYBYEPklXgFurcCnVm6n3PHnxS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VCnQQ6hBoOsE7bMNyCTfMg/ejEgQaA26pkQuU3KsiieFRKmfRGEJWuhkgdo3pqqntbVJzTL7AwvYqVrC0ioLpV/gtjaCy/C2jCxKYHGqY/HtsB3fVpl0/UIOf4Zy2Rcj0iA7rjhPcLaCB2o/qm/BI7DatR2YHtbmq2W7hF3Mt3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4BNrrHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B0CC4AF0C;
	Wed,  8 Jan 2025 23:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736379088;
	bh=GiFdQ5UtYcRYcp3zYYBYEPklXgFurcCnVm6n3PHnxS4=;
	h=From:Date:Subject:To:Cc:From;
	b=T4BNrrHl85zlnYCSFcnydKLUpbyeiEbSFAIQKlfT9kmdA4WPJBsHhPwOPqt+FAAJI
	 wdxdoc7/ckxgK5+8AeTFvi6dN6h56k2PlVqF+0SHi2V9Og1eQs74ojuz6ivsgTnP9N
	 Lo8x5h1RWI/I2UpoNtbLOMT6HLRyBDwKeSBFFgaFZRluaF/QeKMNzilsnqlck4xGkj
	 JA8Gpx1CRHFscY2vGao5y/z5lunNkLansocBlQZ8NlDB30e0jb3xaO1sRSuTvTW4je
	 QgsDVXEqwptaex83Rj3AXYAlc+6kt9CWP2rXVjjBCAlDaTQ9x24Z6g5w2XJLSA2aCb
	 wqSzOVqrkRY/Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 09 Jan 2025 00:30:45 +0100
Subject: [PATCH v4] PCI: mediatek-gen3: Avoid PCIe resetting via PERST# for
 Airoha EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-pcie-en7581-rst-fix-v4-1-4a45c89fb143@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKQKf2cC/x2MQQqAIBAAvxJ7bkEXResr0SF0q71YaEQg/T3pO
 AMzFQpn4QJjVyHzLUWO1MD0HYR9SRujxMZAiqzSyuMZhJGTs15jLheu8qAzjsjbSHrQ0Mozc9P
 /dZrf9wOnOeLEZQAAAA==
X-Change-ID: 20250108-pcie-en7581-rst-fix-7472285d2191
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Hui Ma <hui.ma@airoha.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Airoha EN7581 has a hw bug asserting/releasing PERST# signal causing
occasional PCIe link down issues. In order to overcome the problem,
PERST# signal is not asserted/released during device probe or
suspend/resume phase and the PCIe block is reset using
en7523_reset_assert() and en7581_pci_enable().

Introduce flags field in the mtk_gen3_pcie_pdata struct in order to
specify per-SoC capabilities.

Tested-by: Hui Ma <hui.ma@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v4:
- fix typos and comments
- Link to v3: https://lore.kernel.org/r/20241113-pcie-en7581-rst-fix-v3-1-23c5082335f7@kernel.org

Changes in v3:
- cosmetics
- Link to v2: https://lore.kernel.org/r/20241104-pcie-en7581-rst-fix-v2-1-ffe5839c76d8@kernel.org

Changes in v2:
- introduce flags field in mtk_gen3_pcie_flags struct instead of adding
  reset callback
- fix the leftover case in mtk_pcie_suspend_noirq routine
- add more comments
- Link to v1: https://lore.kernel.org/r/20240920-pcie-en7581-rst-fix-v1-1-1043fb63ffc9@kernel.org
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 59 ++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index be52e3a123abd0d0086f9f1a603e3abaa18f319f..74dfef8ce9ec1bbc28c4a25cd1025f92ba3638a7 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -133,10 +133,18 @@ struct mtk_gen3_pcie;
 #define PCIE_CONF_LINK2_CTL_STS		(PCIE_CFG_OFFSET_ADDR + 0xb0)
 #define PCIE_CONF_LINK2_LCR2_LINK_SPEED	GENMASK(3, 0)
 
+enum mtk_gen3_pcie_flags {
+	SKIP_PCIE_RSTB	= BIT(0), /* Skip PERST# assertion during device
+				   * probing or suspend/resume phase to
+				   * avoid hw bugs/issues.
+				   */
+};
+
 /**
  * struct mtk_gen3_pcie_pdata - differentiate between host generations
  * @power_up: pcie power_up callback
  * @phy_resets: phy reset lines SoC data.
+ * @flags: pcie device flags.
  */
 struct mtk_gen3_pcie_pdata {
 	int (*power_up)(struct mtk_gen3_pcie *pcie);
@@ -144,6 +152,7 @@ struct mtk_gen3_pcie_pdata {
 		const char *id[MAX_NUM_PHY_RESETS];
 		int num_resets;
 	} phy_resets;
+	u32 flags;
 };
 
 /**
@@ -438,22 +447,33 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
 	writel_relaxed(val, pcie->base + PCIE_MISC_CTRL_REG);
 
-	/* Assert all reset signals */
-	val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
-	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
-	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
-
 	/*
-	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
-	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
-	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
-	 * for the power and clock to become stable.
+	 * Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
+	 * causing occasional PCIe link down. In order to overcome the issue,
+	 * PCIE_RSTB signals are not asserted/released at this stage and the
+	 * PCIe block is reset using en7523_reset_assert() and
+	 * en7581_pci_enable().
 	 */
-	msleep(100);
-
-	/* De-assert reset signals */
-	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
-	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
+		/* Assert all reset signals */
+		val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
+		val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
+		       PCIE_PE_RSTB;
+		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+
+		/*
+		 * Described in PCIe CEM specification revision 6.0.
+		 *
+		 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
+		 * for the power and clock to become stable.
+		 */
+		msleep(PCIE_T_PVPERL_MS);
+
+		/* De-assert reset signals */
+		val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
+			 PCIE_PE_RSTB);
+		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+	}
 
 	/* Check if the link is up or not */
 	err = readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val,
@@ -1231,10 +1251,12 @@ static int mtk_pcie_suspend_noirq(struct device *dev)
 		return err;
 	}
 
-	/* Pull down the PERST# pin */
-	val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
-	val |= PCIE_PE_RSTB;
-	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
+		/* Assert the PERST# pin */
+		val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
+		val |= PCIE_PE_RSTB;
+		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+	}
 
 	dev_dbg(pcie->dev, "entered L2 states successfully");
 
@@ -1285,6 +1307,7 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_en7581 = {
 		.id[2] = "phy-lane2",
 		.num_resets = 3,
 	},
+	.flags = SKIP_PCIE_RSTB,
 };
 
 static const struct of_device_id mtk_pcie_of_match[] = {

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20250108-pcie-en7581-rst-fix-7472285d2191

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


