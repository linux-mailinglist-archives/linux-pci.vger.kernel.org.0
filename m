Return-Path: <linux-pci+bounces-19526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C0A05762
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 10:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3F33A22D4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DEB1F3D3E;
	Wed,  8 Jan 2025 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIan2Zu4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01441F4E5F;
	Wed,  8 Jan 2025 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329871; cv=none; b=nbsWsm3o8/kQ+OPTRBvjxz6u222iy7436Clc2exTmtZ5FCjqa0J1+4LIxdDfIowHIIfI5wskZsARYgEdIDzPIobVCf/I+WTJsT5lyXvl6nJo5Qluhx9ZeRzr8Sc9M3kN3rJ00zIdUiRrNeixKaD+N6QjymauvW7RjqqukN0Kdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329871; c=relaxed/simple;
	bh=hUb9miYebZT06jePw/BBYK9Z5F6LbG4WTTs+ZWUFqZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMbOjJpiKFEP680oIcJNPAXlDCW82G1LYDDMKvdV9+FZ8S+tt6TqHlGLewJKdDLx+hfLD2eE3Udq082vPigDdPY6GDnUQbmBrWVJ4Ax5fxEgyDW3+mAwc+JpJL4NZhfOIJxivYg/fva+aRQyGFEwzeeFJlezixxEJLkP3Jp8+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIan2Zu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA6BC4CEE0;
	Wed,  8 Jan 2025 09:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736329871;
	bh=hUb9miYebZT06jePw/BBYK9Z5F6LbG4WTTs+ZWUFqZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FIan2Zu4iLJ6UWsEVg1D8Vk9oQZX58TmLB3RkTg5tFRfKL2Xapx9uy+wJYLoZdUTk
	 Z1nzeInHtMCpNPWkbtUXOkc7gLSnb93jlFm4KUdyOZQM0y0uS7/CKsNywTe1Kd/JrR
	 WrwaFrlDd3Gz77wlCQS9eXxZqXMAgsaEmP6PPId8PGkTXbcz4dQVHxQidyxBc+Te1F
	 W4e9H7GxN+rP27fdl/YSNJvoX7dPu9NdjTp7KKNMHo/PxkIQz1yk8BqZ56dYaTV0Ba
	 UqICKNIVeFK1P9q8Y8lW68qKYCDlIuGd5SPFsnwaOB7CDNZ90G6NHHPFY7FarWCIVX
	 RiGmHj05bm9NA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 08 Jan 2025 10:50:43 +0100
Subject: [PATCH v6 4/5] PCI: mediatek-gen3: Move reset delay in
 mtk_pcie_en7581_power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-pcie-en7581-fixes-v6-4-21ac939a3b9b@kernel.org>
References: <20250108-pcie-en7581-fixes-v6-0-21ac939a3b9b@kernel.org>
In-Reply-To: <20250108-pcie-en7581-fixes-v6-0-21ac939a3b9b@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
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
running clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up().
In order to make the code more readable, move the wait for the time
needed to complete the PCIe reset from en7581_pci_enable() to
mtk_pcie_en7581_power_up().
Reduce reset timeout from 250ms to the standard PCIE_T_PVPERL_MS value
(100ms) since it has no impact on the driver behavior.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/clk/clk-en7523.c                    | 1 -
 drivers/pci/controller/pcie-mediatek-gen3.c | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index e52c5460e927f54c6df152c60560f438f89ec928..513730e5b953f4412b6b12b98c742692de5424c1 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -477,7 +477,6 @@ static int en7581_pci_enable(struct clk_hw *hw)
 	       REG_PCI_CONTROL_PERSTOUT;
 	val = readl(np_base + REG_PCI_CONTROL);
 	writel(val | mask, np_base + REG_PCI_CONTROL);
-	msleep(250);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 71df8817c1635b04b67233fb43abe2de7770b0f2..01e0b53cc1f22fc4b9270a2eb6a55e8948ba2f8b 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -974,6 +974,13 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 		goto err_clk_prepare_enable;
 	}
 
+	/*
+	 * Airoha EN7581 performs PCIe reset via clk callbacks since it has a
+	 * hw issue with PCIE_PE_RSTB signal. Add wait for the time needed to
+	 * complete the PCIe reset.
+	 */
+	msleep(PCIE_T_PVPERL_MS);
+
 	return 0;
 
 err_clk_prepare_enable:

-- 
2.47.1


