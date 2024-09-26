Return-Path: <linux-pci+bounces-13554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 643689871DF
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 12:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081701F29D90
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77321AE862;
	Thu, 26 Sep 2024 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kHORPuui"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68B91AD9C2;
	Thu, 26 Sep 2024 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347437; cv=none; b=i2Xc1B4Q8+9IoD6TGvp/ZH2ggP2K+j8cZzHslGQ5N7B3BFTY5u5H7cusWitIvSCS6SWR+rKodyiCF1xhImuAPD1u9/LhbSnvr8GB688iPncHYKW6FRdHHmeOaFcINiR7G75yJVW2JqsyirYcfB6PwugfAro/5on911k7gyfpvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347437; c=relaxed/simple;
	bh=9JD18HLscMqRuWIdJkk+VbCzvj6IXUPz5uq7gj9Ck0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GgAyzjI3ZcNe3dep30Rl1k1r9QjbQwp8nyjkl5nI6/Fl4/Zt8fkHnEiVpL/LUnKqA9Y1SIbWXqhwrhhEnfAgfAR8G5Gzgn+okEcgmhnbZ3qOYcYHWN7ieG6Byc/xhxemx3EGAn0wZVL0riOYLoivkKXlsG7xm+eqDq6L8RD34vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kHORPuui; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727347434;
	bh=9JD18HLscMqRuWIdJkk+VbCzvj6IXUPz5uq7gj9Ck0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kHORPuuiOyzA/rGRcD9H+MjSkVA/V6ShGu5jNq0icAkBNq6Y8XmXehXjZiUrClloY
	 Zn4yiDlnT1HU3OdSq4HK0124zR4yO+5wH7zGqCW5OJ8rJaYouDBNC+OHYf4R9mCb6h
	 vl9xcXWx316igl/hwr5ELGqBqS3p7/ZULZdg2rbMpt1UUp7yiMQmoAqXOrjc1BRuOy
	 Jydk/RbmS9bVH1H3DHiJ+cTWiJbI9+dIuF4peFmXLAdaVj53eonvktxAop4MESU/M0
	 Kr0GmLbC8mtKUk864eEOFx+MMDzxc4Jpj3zQOMweAx/i0ITqIzZM56o6blSVSKJTnO
	 PGaTklyCCr+JA==
Received: from localhost (unknown [IPv6:2a01:e0a:d1a:1250:792b:136f:2a18:fd70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2CB1F17E120B;
	Thu, 26 Sep 2024 12:43:54 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 26 Sep 2024 13:43:21 +0300
Subject: [PATCH v2 2/4] soc: mediatek: pwrap: Switch to
 devm_clk_bulk_get_all_enabled()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-clk_bulk_ena_fix-v2-2-9c767510fbb5@collabora.com>
References: <20240926-clk_bulk_ena_fix-v2-0-9c767510fbb5@collabora.com>
In-Reply-To: <20240926-clk_bulk_ena_fix-v2-0-9c767510fbb5@collabora.com>
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
X-Mailer: b4 0.14.1

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
index 9fdc0ef79202..0bcd85826375 100644
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
2.46.1


