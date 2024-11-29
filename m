Return-Path: <linux-pci+bounces-17483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C659DED91
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 00:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830CA1630B5
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 23:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BC1165F1D;
	Fri, 29 Nov 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qthJv+ia"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C138FAD;
	Fri, 29 Nov 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922503; cv=none; b=KE6k9W48qPhAfmUXXLyEQh3gnbTL7ZdRmX20N0nKto4Kdo485St+b3TFdcaNeGknF7gGib0ccypBKbyu+vxzfstQgG5D14kEE59Lsdfq07MWEKaWB3Kf+7ImHp5NvFhZp7PIe3BlqtrmITnDkVTUdLc7irUuRnxbgZ5YK+Z2kHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922503; c=relaxed/simple;
	bh=BjCvQz0D2wl+pRuXBn4XoivgVQi1wn+sLuPP5F+9XD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DqgSICMBmD2jAUkH6Huu/vTSijgnRqcHISQP5nAw9xJ5L3mGUJ7srY58t4bvvP9iL6iQL5j398NF90jsEgBpv67WEiECExNK8ES+OTr0BLjtpXGwuglZZS96Ig21Yj0gpFZ7Afok3EbQX3M+F+Ha8f0IIGvWYVup4Y6lDZmXVFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qthJv+ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0973C4CECF;
	Fri, 29 Nov 2024 23:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732922503;
	bh=BjCvQz0D2wl+pRuXBn4XoivgVQi1wn+sLuPP5F+9XD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qthJv+iaisz53lJt0zi8tV23TGU2AnESm16mC17EqGgCI/CFirTTflXZLQ0SK/PdB
	 e/Hm/9btNaYNpVVZQZuhUCOro4bN23tGXJvO8evJp4uHj24+BlagIGEn348dSk7WNn
	 EPsMv6K4JdNsFRbTsWchN8BaKUIQzBq++VQUMd0DdUNzxQt5tRB/lVcadW2+BDd2AQ
	 YP/qq+LJXd2pyq6N1w+Za8mFqgen3oBoOzkic1hCSKtxI3r304vcJvVIfGGhMq4tVW
	 MvT4wjqcya4YrF89rX9WFTRBLjn9KG9rzW2L425iTsq4gwT601Y1uvaPAkSIGtbbLp
	 jpHAj/F1Nh4WQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 30 Nov 2024 00:20:13 +0100
Subject: [PATCH v5 4/6] PCI: mediatek-gen3: Add comment about
 initialization order in mtk_pcie_en7581_power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-pcie-en7581-fixes-v5-4-dbffe41566b3@kernel.org>
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
index 6c5e1fb16d17de0325d66277e0508b781fe45112..01e8fde96080fa55f6c23c7d1baab6e22c49fcff 100644
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
2.47.0


