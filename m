Return-Path: <linux-pci+bounces-17481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD269DED8D
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 00:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151E1281863
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 23:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43348198E69;
	Fri, 29 Nov 2024 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OM7K39CT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46338FAD;
	Fri, 29 Nov 2024 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922498; cv=none; b=utLT8bRVVf6+M+bD/X/+VxZp/Abkdz/0S6O5Ma4jrmTG5IN6PbFA3xH4wqzq2Vg6sJXL4Vo3/NjbE/L/Et/uMS18TWu4HxD9Tcsy4nhwh7XU+J48EGOZPLrO4qMZQyDdLLt66aah1wvEdeykl8xjB04ETmPvjvTBBEl38FYVVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922498; c=relaxed/simple;
	bh=2VEtGqjec9nicO3CSib69XF9LVTOgYFa/s85m9iDYH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZbMx32IMQK07sN4cXw2irHhZqFWpFX2cXnp3eTAHx0ILVg+az0RJodVal+SfHop9TFmmM9+QKVkX3qmUuD3LYmMjZpY7unwWGSru5F824vHZ8yJ0YQ49S709CyR3XspjmorM6XatF+mxzVhwgR5THp5HuZtBzoL4U6DFCLxBUHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OM7K39CT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26242C4CECF;
	Fri, 29 Nov 2024 23:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732922497;
	bh=2VEtGqjec9nicO3CSib69XF9LVTOgYFa/s85m9iDYH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OM7K39CTf0ik0jHUf8OSiB8ua/pwbgTKD3e952FdPIkdEoziqALoLp7mL9nImzgMI
	 7WEq+TFdvvRf/Ev6l+gumRm1vMmnnlMHbVasnBpKVWQGVf1HiPUTyxNADevqo7vK03
	 /wQJxmaRyTLFute/GwvfgQ4Fo+aEjWrjU3EZs9mrLeeMwPOBRwBo3AjuYsYroj00i8
	 rND9z9vsm9v9CoVZ3ct/UlAlxipUBoWr0bOtq7W8HO+8/6JUawIGZUT1oWz+oeJNN2
	 dNeAw5Z404X1QtIaxDazD6P4GBosybPFpRlAwa3UvisQtLQLDsgcjcjepPk+rIPojD
	 ZH+kBLlKH6FJA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 30 Nov 2024 00:20:11 +0100
Subject: [PATCH v5 2/6] PCI: mediatek-gen3: rely on
 clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-pcie-en7581-fixes-v5-2-dbffe41566b3@kernel.org>
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

Replace clk_bulk_prepare() and clk_bulk_enable() with
clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up() routine.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 4d1c797a32c236faf79428eb8a83708e9c4f21d8..3cfcb45d31508142d28d338ff213f70de9b4e608 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -948,12 +948,6 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
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
@@ -966,17 +960,15 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	      FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
 	writel_relaxed(val, pcie->base + PCIE_PIPE4_PIE8_REG);
 
-	err = clk_bulk_enable(pcie->num_clks, pcie->clks);
+	err = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (err) {
 		dev_err(dev, "failed to prepare clock\n");
-		goto err_clk_enable;
+		goto err_clk_prepare_enable;
 	}
 
 	return 0;
 
-err_clk_enable:
-	clk_bulk_unprepare(pcie->num_clks, pcie->clks);
-err_clk_prepare:
+err_clk_prepare_enable:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 	reset_control_assert(pcie->mac_reset);

-- 
2.47.0


