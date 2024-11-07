Return-Path: <linux-pci+bounces-16241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E839C081E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 14:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908D9B21D14
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACDB212658;
	Thu,  7 Nov 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zikc2VXF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC821264D
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987490; cv=none; b=r+ItomCpjBiZXaACu02daTW/Qfaoy2IqPEqFvji07z9XWizoSQbRw/vzvT54Q01ddaZ0nSUGPxkpP/3WUcEgKLTdF/D2NWaj0cSr99pEoA1psy+MX+bxjsuvxE5FZdvROWzufr21BywSIXdLG6QQ+Kf9GxtBU/kfvRgBwHc5drc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987490; c=relaxed/simple;
	bh=btGOvKZTxZhuaxAnzRi1ntXNxujI8W8vvUilrAMbVOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivxG6hFB+Zs7idXfIiFDb9a96GL9KzcJnWFUUzhBjTWqVrIBV9vvIm5EEyrLJZK0G9wI3scvEfiiU7wjoJPror6hBl+ZDIiRNCoVwR0DIMCtHDfxqn2RwUYUedosz8uTZYzCtu28lMWPuqNw4WhVg17ZalEukpfSm3oUMoobeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zikc2VXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E196BC4CECC;
	Thu,  7 Nov 2024 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730987490;
	bh=btGOvKZTxZhuaxAnzRi1ntXNxujI8W8vvUilrAMbVOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zikc2VXFiWG6/99xKSMZnRo6dLllsbHAsCjJjy7JHGNrfbHuwtWCrEQcLnJ5Xp+ID
	 /VYRfkguYkSTn/d6DCMrjYv4Scq8fIshoRYWkg45ttHdpuIdGluoJLVsCZy5Q4QhJ6
	 sXK/hFtofEGozO18hsVQnDNcrnKu36od0fVooytjIAddhozdY5CFXaml6RGoxXbRaC
	 iBZg6gxCBMmWN0wVHfk7Q/iwuRj8v8YleKr7zoO8IZMZEkNGy71tLinT65t4z3u+pr
	 cxuHCc0fNRJVcssxCE1A5/HPOJz2Ubn43OknWXDQkxH4X7bD389u2zHn48KceYGQzn
	 24uMjxTfiiFJg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 07 Nov 2024 14:50:55 +0100
Subject: [PATCH 3/3] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-pcie-en7581-fixes-v1-3-af0c872323c7@kernel.org>
References: <20241107-pcie-en7581-fixes-v1-0-af0c872323c7@kernel.org>
In-Reply-To: <20241107-pcie-en7581-fixes-v1-0-af0c872323c7@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In order to make the code more readable, move phy and mac reset lines
assert/de-assert configuration in .power_up callback
(mtk_pcie_en7581_power_up/mtk_pcie_power_up).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 8c8c733a145634cdbfefd339f4a692f25a6e24de..c0127d0fb4f059b9f9e816360130e183e8f0e990 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -867,6 +867,13 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	int err;
 	u32 val;
 
+	/*
+	 * The controller may have been left out of reset by the bootloader
+	 * so make sure that we get a clean start by asserting resets here.
+	 */
+	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
+				  pcie->phy_resets);
+	reset_control_assert(pcie->mac_reset);
 	/*
 	 * Wait for the time needed to complete the bulk assert in
 	 * mtk_pcie_setup for EN7581 SoC.
@@ -941,6 +948,15 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 	struct device *dev = pcie->dev;
 	int err;
 
+	/*
+	 * The controller may have been left out of reset by the bootloader
+	 * so make sure that we get a clean start by asserting resets here.
+	 */
+	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
+				  pcie->phy_resets);
+	reset_control_assert(pcie->mac_reset);
+	usleep_range(10, 20);
+
 	/* PHY power on and enable pipe clock */
 	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
 	if (err) {
@@ -1013,14 +1029,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
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


