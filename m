Return-Path: <linux-pci+bounces-19527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF033A05764
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 10:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC0147A29B2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A1517C20F;
	Wed,  8 Jan 2025 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itGVqydC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988901A2395;
	Wed,  8 Jan 2025 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329874; cv=none; b=OmXB46wcSEtnNKtzSYoHvm8RVtHuZGKPZ3v+16iVKJdbufj00n9Rn9v3puN+8F/ZeFC5ZPFszz7/gQGcj9rtRAxKvdm/vCDVAWhgEH1bMB+RIXC1LurJ5JR0DlrA/N209tZIq01wOWuAvR/L1yt8QGi2L7RlAkdGYgZfObC5TwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329874; c=relaxed/simple;
	bh=hPN4D7FTStknqbjGuFANLoFGFT58qAH7862kTNVFYwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRGK2RPxznWf3fkVnnwtHVjblW1Qol/khlyTMtq3sFkflvf91gL0QDBo2Zj3oMGnj/7/CIdBYHAuHnH0V8E8C3UhfSpDj1SjSmGnTQV7nRjdp85/wCpr3CBlZ0fDzxnmAlh6MkUTVQMdV3OwahpR8SR9sT1BqTQaAlqQqU6UsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itGVqydC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1328C4CEE0;
	Wed,  8 Jan 2025 09:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736329874;
	bh=hPN4D7FTStknqbjGuFANLoFGFT58qAH7862kTNVFYwA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=itGVqydCr2lYckymqpdNsd6/HKnE9ZZQ5cRpX4UWKzJExf7kJ3/FnMZcLeLcg2jtu
	 j/QDKg8BsRqnEqa/DioRev+WvSQ9CrzButK5VYMEx68n1K2ETitduLva/aFxYHvSvq
	 Kvdae98yeostOtMyFmIdk2DAUCyRKjEE5yxPNAzcCDeNX4rVuWYuEpQv26Q7yjs5lo
	 uIPw/f6ZhNFnHmSwB0IEjqto4PVUYFiNtyPjok4Flu/sRsh9c+2pD409pmT6XLqbsW
	 JqsjYEFgDiQglzmUwUrT6e/uYYWKa79moUak+9pJvKoHuiyr62dORkWBDr9nhPVb0k
	 IeTBMmBgMgC6A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 08 Jan 2025 10:50:44 +0100
Subject: [PATCH v6 5/5] PCI: mediatek-gen3: rely on msleep() in
 mtk_pcie_en7581_power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-pcie-en7581-fixes-v6-5-21ac939a3b9b@kernel.org>
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

Since mtk_pcie_en7581_power_up() runs in non-atomic context, rely on
msleep() routine instead of mdelay().

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 01e0b53cc1f22fc4b9270a2eb6a55e8948ba2f8b..aa511965eb914f7e58e78194491ca7a23790b99d 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -923,7 +923,7 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	reset_control_assert(pcie->mac_reset);
 
 	/* Wait for the time needed to complete the reset lines assert. */
-	mdelay(PCIE_EN7581_RESET_TIME_MS);
+	msleep(PCIE_EN7581_RESET_TIME_MS);
 
 	/*
 	 * Unlike the other MediaTek Gen3 controllers, the Airoha EN7581
@@ -951,7 +951,7 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	 * Wait for the time needed to complete the bulk de-assert above.
 	 * This time is specific for EN7581 SoC.
 	 */
-	mdelay(PCIE_EN7581_RESET_TIME_MS);
+	msleep(PCIE_EN7581_RESET_TIME_MS);
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);

-- 
2.47.1


