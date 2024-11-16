Return-Path: <linux-pci+bounces-16960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D299CFD43
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 09:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D572281208
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 08:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40469192D7E;
	Sat, 16 Nov 2024 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO5STveO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447338382;
	Sat, 16 Nov 2024 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731745172; cv=none; b=q0af4yUfRl+bqQ4gEeJuvDoBJZ+85ZGII+6g4RbbVkFk/9ZFud3x1H1ibGcRyKoY39gTLH+j5Rxx6OwkR1Ik4t9ohHAjt6I/zDVLT42tdZMp3oRzJ+jE7DHSggBTjzCHliTFYIBlhRjcXnQD+H5aDj2x/STA348TKAKcWK2ukVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731745172; c=relaxed/simple;
	bh=GCOmRbv/GyYdnHeXa5q5vrx3cB5TAF+dSdL665F3kuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K1TioXjBQNablq1xwV47Ah76VLgN/mg6e7Kz+mU6QwhJuFJVHLluAp9QU+jFLlvD0/fbYn2lG+HbVc+VXY13ALp9SwraSBkSq3g7uPnRdSwVoekitHsF2SenwlmoZGnAWJCRuPinTrRB7LnYeCltZOaneqVMw1t6Qd2q4vJhhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO5STveO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D290C4CEC3;
	Sat, 16 Nov 2024 08:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731745171;
	bh=GCOmRbv/GyYdnHeXa5q5vrx3cB5TAF+dSdL665F3kuE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MO5STveOVD0odbSgLIzSj/yq1GdC7poAi7FEnmHg+3sKxl4fm0Aqp6/mvYCGHq5Jo
	 IlnRpPxwGsZZZbTCIqwFWml87iKrbTZOgXkT4x4SdPGCaSXxD+ySsinDvstOy4f20X
	 QPAfXVTugoivf4Rt+OPYCJ2NUaNpec5IJbjGl+CIJXrBkzGSE/l91lRxft3DnOBpyA
	 uBasviRc7HqVfUHf9t/oFITErP3ptGDhSZ2tcI8s01amyOWeHYM52rSaq80jxbC8Vi
	 ME4uodSh3QS8xpRiNXtwRMQ3X544fERN1CrVKqNGZV/fLlwqcHYGH1Z8Qg2AlpB7nF
	 MT9/VM5giFWXA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 16 Nov 2024 09:18:25 +0100
Subject: [PATCH v3 4/6] PCI: mediatek-gen3: Add comment about
 initialization order in mtk_pcie_en7581_power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-pcie-en7581-fixes-v3-4-f7add3afc27e@kernel.org>
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

Add a comment in mtk_pcie_en7581_power_up() to clarify, unlike MediaTek
PCIe controller, the Airoha EN7581 requires PHY initialization and
power-on before PHY reset deassert.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 2b80edd4462ad4e9f2a5d192db7f99307113eb8a..dd30530a43b1097871acc9e76a7534f30819432d 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -928,6 +928,10 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	 */
 	mdelay(PCIE_EN7581_RESET_TIME_MS);
 
+	/*
+	 * Unlike the MediaTek controllers, the Airoha EN7581 requires PHY
+	 * initialization and power-on before PHY reset deassert.
+	 */
 	err = phy_init(pcie->phy);
 	if (err) {
 		dev_err(dev, "failed to initialize PHY\n");

-- 
2.47.0


