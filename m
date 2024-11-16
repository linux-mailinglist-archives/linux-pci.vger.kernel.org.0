Return-Path: <linux-pci+bounces-16961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16529CFD46
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 09:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B295B24E63
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2781925BA;
	Sat, 16 Nov 2024 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tot5XOPX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059238382;
	Sat, 16 Nov 2024 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731745176; cv=none; b=gMEUcaLAzoAJZ2aYH/XmU2OXN+iGz7Plt6NbriFxam/R1oKcfBiSpV3kfSdYwwEuIyD16JQMAF1yw4z+7epj2v9ga/G/Z8JRhHsQVqpiew8h0HF27R5fDuhIFn5mdh7t+mvXVpH50MFrVb+ChjNLrdKr8HsSfFmsGa/yNxCeYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731745176; c=relaxed/simple;
	bh=L4hA2wy50Ckn1zmHwXFzkEw586yHIeg2jaZbtr70EFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lj5O/ELgxsfW1WuO4++0SqW6bw5UbDkzjt3zg1Lnxq7NjP4jLhJ2V4WFZ9qCJW8yILw5tgBuJPbwrVIttvf6P/oDhnW51kECEXjUrA//MZmbfTRtlqMK/0/VL65VlkhQ7VqZs25pJk7akAii8M5rRM/UqdMPCV6g5koZEo9embA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tot5XOPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F20C4CEC3;
	Sat, 16 Nov 2024 08:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731745176;
	bh=L4hA2wy50Ckn1zmHwXFzkEw586yHIeg2jaZbtr70EFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tot5XOPXlSP4EzGywdvLL4decfH9hIuKyEHI3PRdHkubDoyx33bpMTXP0dgB11FMB
	 EpsB4VKPrkXoLLY5qJwPP8p0h8+TpXDY/yp5FC2aO3brEcSLtyY5QZ7BDAOKgFHNLI
	 H5Iyi24/jXAfgzBd/GOikwpSz0UHunfxFvlugtVisUpWep3wEKXhpCOacmDT7hKoqO
	 ZjUiFHuknfJknYCC+Cjv8suevXJ8DRM56ZDHePT1+eO6ROnL+Gve3Zx5gdrEr5Bbt0
	 T6Xh/Dg+5Kpc89OnxvkEciq+6j+k4Je/M6Gie+eO64e+/xVG9YTYGFNkSYBAhAbrbl
	 9Gn8m2hfOvxMA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 16 Nov 2024 09:18:26 +0100
Subject: [PATCH v3 5/6] PCI: mediatek-gen3: Add reset delay in
 mtk_pcie_en7581_power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-pcie-en7581-fixes-v3-5-f7add3afc27e@kernel.org>
References: <20241116-pcie-en7581-fixes-v3-0-f7add3afc27e@kernel.org>
In-Reply-To: <20241116-pcie-en7581-fixes-v3-0-f7add3afc27e@kernel.org>
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

Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
causing occasional PCIe link down issues. In order to overcome the
problem, PCIe block is reset using REG_PCI_CONTROL (0x88) and
REG_RESET_CONTROL (0x834) registers available in the clock module
running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
In order to make the code more readable, move the wait for the time
needed to complete the PCIe reset from en7581_pci_enable() to
mtk_pcie_en7581_power_up().
Reduce reset timeout from 250ms to PCIE_T_PVPERL_MS (100ms).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/clk/clk-en7523.c                    | 1 -
 drivers/pci/controller/pcie-mediatek-gen3.c | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index 22fbea61c3dcc05e63f8fa37e203c62b2a6fe79e..bf9d9594bef8a54316e28e56a1642ecb0562377a 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -393,7 +393,6 @@ static int en7581_pci_enable(struct clk_hw *hw)
 	       REG_PCI_CONTROL_PERSTOUT;
 	val = readl(np_base + REG_PCI_CONTROL);
 	writel(val | mask, np_base + REG_PCI_CONTROL);
-	msleep(250);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index dd30530a43b1097871acc9e76a7534f30819432d..795f134e1970c504e8d9588c09a9c3ff51e5397e 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -980,6 +980,13 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 		goto err_clk_prepare_enable;
 	}
 
+	/*
+	 * Airoha EN7581 performs PCIe reset via clk callabacks since it has a
+	 * hw issue with PCIE_PE_RSTB signal. Add wait for the time needed to
+	 * complete the PCIe reset.
+	 */
+	msleep(PCIE_T_PVPERL_MS);
+
 	return 0;
 
 err_clk_prepare_enable:

-- 
2.47.0


