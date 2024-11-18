Return-Path: <linux-pci+bounces-17034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4877F9D0A97
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 09:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005DF1F22416
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 08:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7927F153BE4;
	Mon, 18 Nov 2024 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3h+wdqc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F380149C6F;
	Mon, 18 Nov 2024 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917133; cv=none; b=FJBB525RfRCc21nIWREfr39OTRp+BEzmXGgzA9aW4BuP0zN/yDsOx0KnzyD2fHpDg7bLshkYE1WLd/+HZALfNCpk9qGJcVCSK4vyk+8K7KbDrsDfcvmrCjR/nCW65cyRBJW4Js6a9ITLdZivSHpn+qn+4Jul0JZ4ft1n7oqmfe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917133; c=relaxed/simple;
	bh=MpFcnXsLs0FykV4/uYqbeWHc6Oz2yoAZD2lwk7/5GiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C4yt59OWhLmCRFW64ky3kpoFyc8Ur8RFyf76N4nILTniFQCnUH3SAbCQeio/b1UOs1zB5j2aBeanwoPI6mMDmAhEPTi3k2ZJHGePld/jQesoSwBh1kyCDm+yZVa8GdLkGpN9HHmrqCGt42L8QxkXPhKPRKP2pk4cHAJZg2rxTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3h+wdqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C3AC4CECC;
	Mon, 18 Nov 2024 08:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731917132;
	bh=MpFcnXsLs0FykV4/uYqbeWHc6Oz2yoAZD2lwk7/5GiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K3h+wdqc2+vd8N2fSa+a+STJtPFjVQh8ET/uuysZZoioX45SIGX7eas+bA20tJ40y
	 LsCowysdMznZeGxfI5SesbDrjRb/jSiEgg9kqfUhwtgpzZqxKbBAtMRSVqPNtgJAqF
	 ZJDyFfok9/ASFk4o6O4MrYa3xZXi9OPL0CHbFqBPnSk8v2XYa/g5/ssIgyvuKaPBub
	 S4fkZCeVTFvUs+DATHKl7eMFgZJMIzl4K8iwJIblUWeDkKv5uOeu/cM0X7wYYutQZ8
	 a0hfjsrbZEGK4H2tPS7ubg5FmCRPtaxhCP/47d8Qc5isk8rv2kJSoniY/vT5h9gzYf
	 2RjYeW8FaNvPA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 18 Nov 2024 09:04:56 +0100
Subject: [PATCH v4 4/6] PCI: mediatek-gen3: Add comment about
 initialization order in mtk_pcie_en7581_power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-pcie-en7581-fixes-v4-4-24bb61703ad7@kernel.org>
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
index 2b80edd4462ad4e9f2a5d192db7f99307113eb8a..e4f890a73cb8ada7423301fa7a9acc3e177d0cad 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -928,6 +928,10 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	 */
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


