Return-Path: <linux-pci+bounces-17480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C38E9DED89
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 00:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DEE281F90
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 23:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9967519C569;
	Fri, 29 Nov 2024 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmpixqma"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED1538FAD;
	Fri, 29 Nov 2024 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922495; cv=none; b=p6MhA8JU43wZE8fg5QjHGfPB9RQDRv2YKF+Vk6nw4V+MqEGTRCosH5AmIviaQ3JLnNt5geYDV3RCV+cIPCvFqHPOnMOeQxwjDkGf7VEDKkIwoHUkxY+M3A2gVbbhbIlm0Jp55PO6IF0KtQxrcRP6oF1/8fo7SRgJ9cJq37p7BVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922495; c=relaxed/simple;
	bh=hl2S2LZwn2smx9ARAoEF8vIrYGRpQBw8WQAXlixKIJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABouaVkgOLIXameVWoNL3I5URfq6vvxKejIec7trhY+1cszSoHr/MSOle8HXiLv8rIGC0iZi9s8BmM5B5Bx9beMnY9m88H48zfwqVqVuBej04un6xttC7O6FUMduGL8ZspTCbo+MKpNz+z6gGkjWtAYrJxo1NwDZwfd76zBV9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmpixqma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDB9C4CECF;
	Fri, 29 Nov 2024 23:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732922494;
	bh=hl2S2LZwn2smx9ARAoEF8vIrYGRpQBw8WQAXlixKIJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tmpixqmaOETTs+0vhnV4hlMMgX3B8z5zvkAy+PrmhlC2Je2XIGNJG1WSZgBMaigd8
	 mVvexJAPbuaeVBHtDMXQk/bmMHjHUfptc394fRCdG11EKyWsVAUFMw8GOVRtKzSDoS
	 elBn0x5UIK0IgbuPylKK5tKmfvbSGsWiL/njD3Jj7M/HmmGGFSbwSofKs6jvXA9eaQ
	 pvznIbPl5N9ju6kSRW671B+A4LKbwR8wsZoCZ/yroX0ra8GmrmWrToAxt9q4HuRgFL
	 MJCStRSqvDa3xW/yKI4YUhAVDbEHFCEh8ufHlQMfgrhNwFJrjbE58+dz1xh7fugVeQ
	 iiUNQMsmCWANw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 30 Nov 2024 00:20:10 +0100
Subject: [PATCH v5 1/6] PCI: mediatek-gen3: Add missing
 reset_control_deassert() for mac_rst in mtk_pcie_en7581_power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-pcie-en7581-fixes-v5-1-dbffe41566b3@kernel.org>
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

Even if this is not a real issue since Airoha EN7581 SoC does not require
the mac reset line, add missing reset_control_deassert() for mac reset
line in mtk_pcie_en7581_power_up() callback.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 64ef8ff71b0357b9bf9ad8484095b7aa60c22271..4d1c797a32c236faf79428eb8a83708e9c4f21d8 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -942,6 +942,9 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	 */
 	mdelay(PCIE_EN7581_RESET_TIME_MS);
 
+	/* MAC power on and enable transaction layer clocks */
+	reset_control_deassert(pcie->mac_reset);
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -976,6 +979,7 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 err_clk_prepare:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
+	reset_control_assert(pcie->mac_reset);
 	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
 err_phy_deassert:
 	phy_power_off(pcie->phy);

-- 
2.47.0


