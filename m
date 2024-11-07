Return-Path: <linux-pci+bounces-16240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBDC9C081D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 14:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0001C223C4
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 13:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF804212646;
	Thu,  7 Nov 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrrO1sAW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8672101B7
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987487; cv=none; b=prlfHTkbW/KWQTcZfrV4KlWiX2alGEJdTzh1HrSgMIpMV0xgdwmfGw4n55+ev8p9qi83KtANxZJrF3yb19f/XHYyFK08VsCrKJIeLzHNCVEAm283u5c2wrJdX0ynnYBibYwUREbi7G1Ex1cuVXzloRiyK5pisOWY1IpYI288a/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987487; c=relaxed/simple;
	bh=EyDwIt88XF1ie7BfiMN0PnlL3XgXILjIU8/naicxr1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OZ+6Xbc+ph5+cyeV9xXTMu993jGNbBMi0xlxpIM/oaJq7Fp0uWXQ5+Lwun5LREu+yPSPbbOgO3TN+6B6mWE4mUFZHvWJtNPhsd2I8WZGoMyO0aSIhib1tRpIH9asPBViA2Dxc+ctN14n5gyxOmzjegwPgQEW7aQs8fIrHvce5r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrrO1sAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123BAC4CED0;
	Thu,  7 Nov 2024 13:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730987487;
	bh=EyDwIt88XF1ie7BfiMN0PnlL3XgXILjIU8/naicxr1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KrrO1sAWC/yWE+U/fKXp2U0WRJrLNKqbduLjYdaKGr7aUOFo1pA6YcWtxSkQ+XD+y
	 63w9cjDUX/6NBHKjF9QsEJCEe+mf39xKnH/+suYjhl2uWiJ4xQs8JBKCm6eASY+zjR
	 bxOcJN0d9llvXnZlXV1eo1Bsb27z0t2dzLoww1s9o6eJa8zZ/DUVcCygU5CGvGdjWh
	 XjniDYse61zmVo9knPZBjpeRtQ//VtXqFi3rdVvGNNOP3PJe5lZnk1mqRxy55a4LRB
	 BJmW7KeZY55Uv29JioF+rjw99U6Lv4MMdAZxbI90a1cKNV1oXM3YmTKKi2vPkehTAE
	 htHd0YpGjDBsg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 07 Nov 2024 14:50:54 +0100
Subject: [PATCH 2/3] PCI: mediatek-gen3: rely on clk_bulk_prepare_enable in
 mtk_pcie_en7581_power_up
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-pcie-en7581-fixes-v1-2-af0c872323c7@kernel.org>
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

Squash clk_bulk_prepare and clk_bulk_enable in
clk_bulk_prepare_enable in mtk_pcie_en7581_power_up routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 0fac0b9fd785e463d26d29d695b923db41eef9cc..8c8c733a145634cdbfefd339f4a692f25a6e24de 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -903,12 +903,6 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	err = clk_bulk_prepare(pcie->num_clks, pcie->clks);
-	if (err) {
-		dev_err(dev, "failed to prepare clock\n");
-		goto err_clk_prepare;
-	}
-
 	val = FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
 	      FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
 	      FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
@@ -921,17 +915,15 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	      FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
 	writel_relaxed(val, pcie->base + PCIE_PIPE4_PIE8_REG);
 
-	err = clk_bulk_enable(pcie->num_clks, pcie->clks);
+	err = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (err) {
 		dev_err(dev, "failed to prepare clock\n");
-		goto err_clk_enable;
+		goto err_clk_init;
 	}
 
 	return 0;
 
-err_clk_enable:
-	clk_bulk_unprepare(pcie->num_clks, pcie->clks);
-err_clk_prepare:
+err_clk_init:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 	reset_control_assert(pcie->mac_reset);

-- 
2.47.0


