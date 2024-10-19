Return-Path: <linux-pci+bounces-14904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F1F9A4CFE
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 13:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0242283676
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 11:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449AF1DFE0E;
	Sat, 19 Oct 2024 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HvWq5L2j"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC6190688;
	Sat, 19 Oct 2024 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729336577; cv=none; b=eG3cxL3YB4ZGFSFZ3uus/aUzh47fkfshAwQ82dKZPSZUw4VIlfEe9Rv/gEvwm2vP1aCPUUCXiVriB7fdDlN1KOKx0T7RbzOanhyjbND3ZLNiCRHGfm7Z9UqoZkKaLRfgFY066P4INrd0s+XzViyD28BBh8VV26jPOmz9sPEhlMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729336577; c=relaxed/simple;
	bh=+ppoxTPO/igxME3lIs+D7CFzw+ePdaoHzXKCgEyp3Ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n2cYKJe9O9wgBZ3ouO8lF6/gcxUpU5bVmPUfZXMsSB8xhl2/UyOIF8hIpX0OtT5nZhSSx+zld582qgqc+f7OMaOvmTpYM96Obiz2cR6mgT5b9/rHE83i1MJO1cVxwW53wymiA2+nmDCj6K+7xRIYYsuysWZmA6VXYCC+1Ylmc/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HvWq5L2j; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729336573;
	bh=+ppoxTPO/igxME3lIs+D7CFzw+ePdaoHzXKCgEyp3Ig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HvWq5L2jdWOetnT7uwg5JX4j6UctFRZk9UvbvGOmxo/oU8ES21dapAIV+BxNg2l+Y
	 0KipfkNVRtWaMEVF9Hoixyuy97phZIwcQZffAQGAIpTTJ3ux0OMRzgE4fA06nEd8mj
	 w31bWqyfN7oRIAnl487pM5Wwmrjm2rgWLN+2l58ZFFGlJUay3SSgLK/lswz9Wl/Rg9
	 uGaaS0qS7qg4hWpy7Ly4pRmIpuU7p48s+j2QhrFOOuuTmSIz+FW5peiPAfkzTR9isx
	 mpbkG6m6PRpsyjks1yhC1X9Sr0Zk96yuPbZssRvpFKgohAS9HcridZQh/RxjLLsLkl
	 ADBYKCRQsl3yQ==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 27C2317E35D3;
	Sat, 19 Oct 2024 13:16:13 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 19 Oct 2024 14:16:01 +0300
Subject: [PATCH v4 2/4] soc: mediatek: pwrap: Switch to
 devm_clk_bulk_get_all_enabled()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-clk_bulk_ena_fix-v4-2-57f108f64e70@collabora.com>
References: <20241019-clk_bulk_ena_fix-v4-0-57f108f64e70@collabora.com>
In-Reply-To: <20241019-clk_bulk_ena_fix-v4-0-57f108f64e70@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.14.2

The helper devm_clk_bulk_get_all_enable() missed to return the number of
clocks stored in the clk_bulk_data table referenced by the clks
argument and, therefore, will be dropped.

Use the newly introduced devm_clk_bulk_get_all_enabled() variant
instead, which is consistent with devm_clk_bulk_get_all() in terms of
the returned value:

 > 0 if one or more clocks have been stored
 = 0 if there are no clocks
 < 0 if an error occurred

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 9fdc0ef79202618d0bd0188d0bf53152285c6c51..0bcd8582637550c90c1c6df619077b7df7bb0048 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -2518,8 +2518,8 @@ static int pwrap_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_clk_bulk_get_all_enable(wrp->dev, &clk);
-	if (ret)
+	ret = devm_clk_bulk_get_all_enabled(wrp->dev, &clk);
+	if (ret < 0)
 		return dev_err_probe(wrp->dev, ret,
 				     "failed to get clocks\n");
 

-- 
2.47.0


