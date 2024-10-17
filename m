Return-Path: <linux-pci+bounces-14830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E89A3146
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 01:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF408B24255
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 23:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AAB3DAC00;
	Thu, 17 Oct 2024 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="duoZtuW9"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BB1EE02C;
	Thu, 17 Oct 2024 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207076; cv=none; b=HlPGLFR3VP2BCwFC8KAs/I9n0XZT4UxdkWOawfiKrzfSl76axtwnsMFPG/eK+cfUULa6iJQ+XTOmhUq7sVJP1y6Xvva4hhcyiroTyVoPyR/gSnQB4Uo3UvfUpO0d91yhNAUZNu8I5qEzYa6FNjGHXxK5hzbgRfShlVTM29Q3WJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207076; c=relaxed/simple;
	bh=+ppoxTPO/igxME3lIs+D7CFzw+ePdaoHzXKCgEyp3Ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r175HbMpn/u+AdDfPmIXQQW7iTDUEjj8T28EHYX4qI5ZO3VUArEa+NObBQOSUw6JmpA1I+2nEBTnnNrTSo6VUAdZfsiM85wQpyUv2dMsJhILz+pWkkqpOeYKqoy5q9SqvTKA0O7u0MtqrqCios1RNry97FwYZmPHpzjoEpweics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=duoZtuW9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729207073;
	bh=+ppoxTPO/igxME3lIs+D7CFzw+ePdaoHzXKCgEyp3Ig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=duoZtuW9OSxIMv6WdYPn0i9n8RJBaUUUTc3uoeLJw8WXVFLD29NN6Ld/H5XdIJWxU
	 8h1KwcP/T4fHDfaKseadABK+hkgFg1IJGyp7Lhw/B90pOhrmD35JZyso0n4fKdwc5L
	 Ox7FBjavFIbJ7FIxvdQ/BiFTNep6fmFCz6l7OFEaFD5dBt6PmviyR/vDNqWpAxpRdw
	 f/wzuHgmxoVk7LnCVnNXXKDICdZWRaaN+Wsp8FOZJRjuQNsRRjlfE7PHqgYJhgVgmU
	 6nty7NP3AlK4tHeQbm9S8pKJamcKyMtHxbZWCV7Kf7cXrI9SXkSdqRLk2gF4bTYIqK
	 nQTAjTZpC3Yxg==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E74F717E0ED6;
	Fri, 18 Oct 2024 01:17:52 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 18 Oct 2024 02:17:30 +0300
Subject: [PATCH v3 2/4] soc: mediatek: pwrap: Switch to
 devm_clk_bulk_get_all_enabled()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-clk_bulk_ena_fix-v3-2-57e8bb82460c@collabora.com>
References: <20241018-clk_bulk_ena_fix-v3-0-57e8bb82460c@collabora.com>
In-Reply-To: <20241018-clk_bulk_ena_fix-v3-0-57e8bb82460c@collabora.com>
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


