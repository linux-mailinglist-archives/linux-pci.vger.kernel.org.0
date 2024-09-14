Return-Path: <linux-pci+bounces-13216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E8A9792D2
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 20:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9952C1F224F3
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 18:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86BA1D2201;
	Sat, 14 Sep 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y3BBf5hx"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7541D0483;
	Sat, 14 Sep 2024 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726337135; cv=none; b=GIqliCF8utCxypceH37WNNTmBONBZnSuD1r6yKgSSU6dNzJN0jIq1yQPPj7izKUZF01ZqNHhslLAcmubL5D/FT7Uqijs8yCFZ1ERyrJcJahFq0Nh21F4KWQA7gPf98CVhVHqGBaPls5ljK1AuiV16zLWanqR4DqDR+Sg564NOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726337135; c=relaxed/simple;
	bh=dq/7n5tvMY7OuKBFVI6eGVpyHXnigzcGlUpBjIjzYY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amkWA7POjN4eZAWkJm8RoGgcoSRJ0hcGYM2vziryoEFFHVSCguvmoC6AvF74MYZUPi+0hCob0Vp3FCTZYrQh+LU1HgMNSFg3gObJYuuI2Gh2AfaaOxZBGGs5s0KsNCNt9iu+aM/yvf2dj261OU8L5SJPOcPz7lU7a3ezwSYZJE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y3BBf5hx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726337131;
	bh=dq/7n5tvMY7OuKBFVI6eGVpyHXnigzcGlUpBjIjzYY4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y3BBf5hxlCuSDPu1+AluaS4tOepIRBZjK2FifiEKfkjMNWzP0wmlk6crkFtC+yOAw
	 rYrsXL5Erihlqpk3mkc1kGZP89AkiIk4PGZyiFRirJtQs1F3IjSxCQrhE2q8BV8LXc
	 0rgv0Io/oWa5pjK7FOkvKHAC6rc+whfkE83diX8P1YijeM836hX+i/69GkDeQNsSGS
	 WhfvyN97K42W977+U1sAnVW2E1bN2u4jNEhdZLFw4u9tdlgmU21JBqxcN+m9h1sLA5
	 WwnBvb753+J5qwaH3f39dfnkMELZhQbdZRDlzlsxZumEZ2ztYQGvuOG92Jw3bjxxw2
	 vIG4Amu2XStBA==
Received: from localhost (unknown [188.27.55.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C72A217E360A;
	Sat, 14 Sep 2024 20:05:31 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Sep 2024 21:04:55 +0300
Subject: [PATCH 2/4] soc: mediatek: pwrap: Switch to
 devm_clk_bulk_get_all_enabled()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-clk_bulk_ena_fix-v1-2-ce3537585c06@collabora.com>
References: <20240914-clk_bulk_ena_fix-v1-0-ce3537585c06@collabora.com>
In-Reply-To: <20240914-clk_bulk_ena_fix-v1-0-ce3537585c06@collabora.com>
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

The helper devm_clk_bulk_get_all_enable() is partially broken and will
be dropped since it missed to return the number of clocks stored in the
clk_bulk_data table referenced by the clks argument.

Use the newly introduced devm_clk_bulk_get_all_enabled() variant
instead, which is consistent with devm_clk_bulk_get_all() in terms of
the returned value:

 > 0 if one or more clocks have been stored
 = 0 if there are no clocks
 < 0 if an error occurred

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
2.46.0


