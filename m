Return-Path: <linux-pci+bounces-17033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08259D0A95
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 09:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A7CAB20E6D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 08:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9E13DDDF;
	Mon, 18 Nov 2024 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2iIjGxZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53744405FB;
	Mon, 18 Nov 2024 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917128; cv=none; b=Y0ynDFM+ISrx6F5uogZkMG8fsP7sVlIWVAiFuy962rgxQaqFPhKGH7RneFeI1S5HLaonB+qFAOpvgnGwlEwbfpfwUrCkeM+ouXBjBzP4SDgNRtsvxfWQ0f9LV85kVeON72MosWL02ZFcVtRkNT6UhDGzsHZP2qKxYjvg3HmOZ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917128; c=relaxed/simple;
	bh=NSYtiir0GYQgZALNN95zBChKFKSlrmO+BGhvhKJ5ESw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kIe3sfIJUzYvlZyH7impao3jSoe9t2DUkNgCv8Yvf0J+FIicWld6PsiGGdY2YWwT+h1GehcBLVs+OIpPypt9K8Cjv8NRCNqg1VVKJ+SkiSHGQ1AXv4pTH9z/aEqs51l9Lbtzk4A6t+4+kx6BQWmEVfBPyXmwfAtnWObPWgWdXvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2iIjGxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6335C4CECC;
	Mon, 18 Nov 2024 08:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731917128;
	bh=NSYtiir0GYQgZALNN95zBChKFKSlrmO+BGhvhKJ5ESw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I2iIjGxZbamQlE3RIzW5D1sJT5xbEgm0+vFBYCUAdFk3BGRKBPtyH+pu2VoMdx5XR
	 g1Wtkxnyb3H591wvuKnwOspcjhYJgjk37JObFm34MWCjVNS3lacpFojHmYhaXy0SPo
	 vriyg2LALVOoQhbj5Ada3XOV/cLViy/Qp0a/pBzcH4T9ckjjOKqp+2QgW7jetR7djF
	 rNr5RyNyWnNV91fqR2Mfqk2TWEIWlUFsGtnk1WbWkPMHv/d2wYXMq3cFEX5cYbMBTc
	 ilfmO+n+2IDF0dsJFZTaH4O0Mlj8htVKAA+Y5woF6XZ8elGZpTt+11L1VD2RfHGyQp
	 SLL1XvUj0d7cw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 18 Nov 2024 09:04:55 +0100
Subject: [PATCH v4 3/6] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-pcie-en7581-fixes-v4-3-24bb61703ad7@kernel.org>
References: <20241118-pcie-en7581-fixes-v4-0-24bb61703ad7@kernel.org>
In-Reply-To: <20241118-pcie-en7581-fixes-v4-0-24bb61703ad7@kernel.org>
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
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 3cfcb45d31508142d28d338ff213f70de9b4e608..2b80edd4462ad4e9f2a5d192db7f99307113eb8a 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -125,6 +125,8 @@
 
 #define MAX_NUM_PHY_RESETS		3
 
+#define PCIE_MTK_RESET_TIME_US		10
+
 /* Time in ms needed to complete PCIe reset on EN7581 SoC */
 #define PCIE_EN7581_RESET_TIME_MS	100
 
@@ -912,6 +914,14 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	int err;
 	u32 val;
 
+	/*
+	 * The controller may have been left out of reset by the bootloader
+	 * so make sure that we get a clean start by asserting resets here.
+	 */
+	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
+				  pcie->phy_resets);
+	reset_control_assert(pcie->mac_reset);
+
 	/*
 	 * Wait for the time needed to complete the bulk assert in
 	 * mtk_pcie_setup for EN7581 SoC.
@@ -986,6 +996,15 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
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
@@ -1070,14 +1089,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
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


