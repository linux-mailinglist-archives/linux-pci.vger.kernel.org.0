Return-Path: <linux-pci+bounces-17482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5089DED8F
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 00:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF72A1637EB
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 23:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D18165F1D;
	Fri, 29 Nov 2024 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1b5l6Nm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8FD38FAD;
	Fri, 29 Nov 2024 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922500; cv=none; b=e1ZV5qFwMtWyoi/W+wuHspKlx4sfisjBEOaoFhsqHc5TX7rOUGiV5aMJik7jAodKnGljy1BZGUi+n08yZTB+ncybmksMgcNuczPMa4OQTQMTXZwKYWOkeLDnWY97wD+dn6MSL+5IyHw3puqreZKLRN9rOz7azhmViRgDzi9gwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922500; c=relaxed/simple;
	bh=ugku9pso3x81u0glSHvCY10Yvp4iU8R62ycqNYCHwBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqJ6zklHXtgg/rk3NRRzdDmjjm7unsika03N37FgNDaoYorLVDISUwT803n8dbuowFHoZpG7k5YZ3Dt2d+z0jsxKxFpxVDeyItfBVjqf0UzJMS0sNwgRL5eqMBV0TukjQERjQm9TxpnwluHeOZfif5MyKL9LUFFQHAktpqALoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1b5l6Nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29233C4CECF;
	Fri, 29 Nov 2024 23:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732922500;
	bh=ugku9pso3x81u0glSHvCY10Yvp4iU8R62ycqNYCHwBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V1b5l6Nmc075l4sr3Ys4TGuhI/3wI2OjE9pxwEjjZUcmwm59Zf1FgZLqX3bODkdhk
	 QECDC+oE0ZxU67esPyIQH9Soa0TZnakJTTLOviybcBVL0+hHCIYn+VgTv/IYczOETj
	 WQiFvRnsOsBzf+FktVBkuf7GKbq8Mh1ceEtqBud+4vCp7vfWjUrCgnuXSH9LjI+2rl
	 e5fMMgnCNUkHDS4ZG/f8x7EPupqW1OiSzXTkYSwLCRJFbS2xvUWiHbpQbwJihsLrMl
	 u4IRdzWqEGGnwEfoulS5dtutxsrSSuhtPxUkx1Fh6vAQL6PqN+gQbcmr+PTf+kfrcq
	 5NyT+J7B33zsw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 30 Nov 2024 00:20:12 +0100
Subject: [PATCH v5 3/6] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-pcie-en7581-fixes-v5-3-dbffe41566b3@kernel.org>
References: <20241130-pcie-en7581-fixes-v5-0-dbffe41566b3@kernel.org>
In-Reply-To: <20241130-pcie-en7581-fixes-v5-0-dbffe41566b3@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In order to make the code more readable, the reset_control_bulk_assert()
for PHY reset lines is moved to make it pair with
reset_control_bulk_deassert() in mtk_pcie_power_up() and
mtk_pcie_en7581_power_up(). The same change is done for
reset_control_assert() used to assert MAC reset line.

Introduce PCIE_MTK_RESET_TIME_US macro for the time needed to
complete PCIe reset on MediaTek controller.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 3cfcb45d31508142d28d338ff213f70de9b4e608..6c5e1fb16d17de0325d66277e0508b781fe45112 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -125,6 +125,8 @@
 
 #define MAX_NUM_PHY_RESETS		3
 
+#define PCIE_MTK_RESET_TIME_US		10
+
 /* Time in ms needed to complete PCIe reset on EN7581 SoC */
 #define PCIE_EN7581_RESET_TIME_MS	100
 
@@ -913,9 +915,14 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	u32 val;
 
 	/*
-	 * Wait for the time needed to complete the bulk assert in
-	 * mtk_pcie_setup for EN7581 SoC.
+	 * The controller may have been left out of reset by the bootloader
+	 * so make sure that we get a clean start by asserting resets here.
 	 */
+	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
+				  pcie->phy_resets);
+	reset_control_assert(pcie->mac_reset);
+
+	/* Wait for the time needed to complete the reset lines assert. */
 	mdelay(PCIE_EN7581_RESET_TIME_MS);
 
 	err = phy_init(pcie->phy);
@@ -986,6 +993,15 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 	struct device *dev = pcie->dev;
 	int err;
 
+	/*
+	 * The controller may have been left out of reset by the bootloader
+	 * so make sure that we get a clean start by asserting resets here.
+	 */
+	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
+				  pcie->phy_resets);
+	reset_control_assert(pcie->mac_reset);
+	usleep_range(PCIE_MTK_RESET_TIME_US, 2 * PCIE_MTK_RESET_TIME_US);
+
 	/* PHY power on and enable pipe clock */
 	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
 	if (err) {
@@ -1070,14 +1086,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	 * counter since the bulk is shared.
 	 */
 	reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
-	/*
-	 * The controller may have been left out of reset by the bootloader
-	 * so make sure that we get a clean start by asserting resets here.
-	 */
-	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
-
-	reset_control_assert(pcie->mac_reset);
-	usleep_range(10, 20);
 
 	/* Don't touch the hardware registers before power up */
 	err = pcie->soc->power_up(pcie);

-- 
2.47.0


