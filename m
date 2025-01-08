Return-Path: <linux-pci+bounces-19525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F526A05763
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 10:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190747A1C16
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 09:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF36199249;
	Wed,  8 Jan 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMuy0ZeE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B017C20F;
	Wed,  8 Jan 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329870; cv=none; b=CpP9+b2d8Hg6vh9cX47RCY42Eiu92q8x+z3OEWPoIdnkP6pGY1GAs/zbLKgOBsqjOdzgdry+1eD5+NqUIE9CTtS5OSmgKiYG2RcMXvDQYKPB1lptBqmGNeJ8M088jYNJwoRVpfOFinmf/liaV17iNL0s0XO2uTpDvLIbmxn638E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329870; c=relaxed/simple;
	bh=7c+kocCfpLH6i+F/+/Wlp6DSrIjmG2PsUPjDIxgIlik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DWt36a+Z0FTewsbamvAXCNhnySWyUgvuYHzc93TZVU+lElICN1frv6pWaHHfGVQJtDcrA47rssAJ8npMoSt6yw8q2VAt0+SScAwUzYoOmB+nj/ktvRuf4mQjOJMAud8IrlHV+7E0xYYA3RUZWcADtvarK8IY4MgVsYP3SjmtXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMuy0ZeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A807C4CEE0;
	Wed,  8 Jan 2025 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736329868;
	bh=7c+kocCfpLH6i+F/+/Wlp6DSrIjmG2PsUPjDIxgIlik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TMuy0ZeEb5SXW00QOWOhrfLQH2hZbuw/Drj3LK64kpw8F26vHrWlS/u70M2n1voZc
	 R3bDCZDHmA4kCcAB5eQC/kB4oewxssZkp94dGMebmIp3hXmaZ/3ceka4wrMAYDuSyM
	 jCtVw4ugM3uwyTkreMaMpH919P1MarZ8QJa/Ajsw1P4+fjdSaHWrE47sF61gAisPoX
	 IoEz+EvJt2gFJ8ZDS2f7g/NXazMABtXBPqUaIPpLBn8up2VeSPw6zbzYzBZsFG3Oqy
	 fX4B1xkNVYqnyYUvQJjPU2GNU0aJyCcFub8sHxVuiZsbyu5b8OGVsAnFr/OeGVeSaT
	 IhQYkc+ZPCbgA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 08 Jan 2025 10:50:42 +0100
Subject: [PATCH v6 3/5] PCI: mediatek-gen3: Add comment about
 initialization order in mtk_pcie_en7581_power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-pcie-en7581-fixes-v6-3-21ac939a3b9b@kernel.org>
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

Add a comment in mtk_pcie_en7581_power_up() to clarify, unlike the other
MediaTek Gen3 controllers, the Airoha EN7581 requires PHY initialization
and power-on before PHY reset deassert.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 4ce2b9d0dcd54e44cb645603d81865d26b2c8f23..71df8817c1635b04b67233fb43abe2de7770b0f2 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -925,6 +925,10 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	/* Wait for the time needed to complete the reset lines assert. */
 	mdelay(PCIE_EN7581_RESET_TIME_MS);
 
+	/*
+	 * Unlike the other MediaTek Gen3 controllers, the Airoha EN7581
+	 * requires PHY initialization and power-on before PHY reset deassert.
+	 */
 	err = phy_init(pcie->phy);
 	if (err) {
 		dev_err(dev, "failed to initialize PHY\n");

-- 
2.47.1


