Return-Path: <linux-pci+bounces-20480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0BDA20FF2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 18:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8013A8AC6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2911F560F;
	Tue, 28 Jan 2025 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6HDviyG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14BC1DED48;
	Tue, 28 Jan 2025 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086850; cv=none; b=K3DiWR/ZcoyZlU3Gk+pKmFptyHh3Vwy1yX+o8Mp0ukA6S5RUgQ9Zu9Y66DGKBdEmsIFQTHwoHGpxO8N0Gz5qrrStCDitCTGq9ZRtZjymNTotqQ6KwCXzxTi5KpqM0iIx+Q2PBbOdCe330ln7yoVmfvX8SHZAueVgu+Yh7z9GFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086850; c=relaxed/simple;
	bh=uTwbAGSjoYcmoPMQdSqt8uRACDufhTf/5L9rzTY3n90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUWHcK1tC7ubzp6PXckU1mHxQfRbp/AiBQ+VGifoV32m6LWARdIwR4zkjQEHe9rgRFlRSRMAmt+nTYX0PvvDdlYSJ5CjZdQJtByoq4F4yI5EN0ortvAHAvN/kIe8ioP5pR/p7KlZCcfB/9JdrnI9ueGbSnhDyi8X6d8VaXjzHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6HDviyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1F7C4CEE1;
	Tue, 28 Jan 2025 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738086849;
	bh=uTwbAGSjoYcmoPMQdSqt8uRACDufhTf/5L9rzTY3n90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a6HDviyGfVHeSrpIL5DkIp26a2Blcsnv2V4ming+k5LEF7HvMT3jqTMQ4aXbjYsjz
	 a62l+Rqv6WxxoMUa9FQH/GclxE234l3DNZIVwst5j/XaZx5MFgkcKoE/n2+41i+0zO
	 mmkXYGK0T86xnR8b/zMe9216xMfHCWcX/+RSDvElhN9izQdTYkKP98st3QVsdoBWHY
	 ClldlPPcTcjmIFWkeSl0pmnBnylkZ3tJCVoUIHL8sJLqEK4yYoUMYwRgCxoKxEwPF0
	 BQ8Tyb9WhImr/rk0LLAYai1p/oqVK0TfYjGzX7EqKlCbLJxZRqY6mI18auONhZwa5n
	 1dXEM/v+eB8FA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Hui Ma <hui.ma@airoha.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 12/15] PCI: mediatek-gen3: Avoid PCIe resetting via PERST# for Airoha EN7581 SoC
Date: Tue, 28 Jan 2025 12:53:43 -0500
Message-Id: <20250128175346.1197097-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128175346.1197097-1-sashal@kernel.org>
References: <20250128175346.1197097-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 491cb9c5084790aafa02e843349492c284373231 ]

Airoha EN7581 has a hw bug asserting/releasing PERST# signal causing
occasional PCIe link down issues. In order to overcome the problem,
PERST# signal is not asserted/released during device probe or
suspend/resume phase and the PCIe block is reset using
en7523_reset_assert() and en7581_pci_enable().

Introduce flags field in the mtk_gen3_pcie_pdata struct in order to
specify per-SoC capabilities.

Link: https://lore.kernel.org/r/20250109-pcie-en7581-rst-fix-v4-1-4a45c89fb143@kernel.org
Tested-by: Hui Ma <hui.ma@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 59 ++++++++++++++-------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index be52e3a123abd..74dfef8ce9ec1 100644
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
-- 
2.39.5


