Return-Path: <linux-pci+bounces-14906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822EE9A4D06
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 13:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2971F22E69
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE4A1E0484;
	Sat, 19 Oct 2024 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l+K7cjD/"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96341DEFC6;
	Sat, 19 Oct 2024 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729336578; cv=none; b=Odt2Z8/+tkEAYGLEjnb+jKoyBSbm5Nz+hjOXKXd4ci5zwqrg60mmEewVyV3n/UdaHg8ZhQXx496GjIOWMXXl9VDCdhggDp4317dH5smE34HqwD/X4ILFMRpzp02RKZpQfjpUnSgAHoeJLXezykhHKiYzbyTUnoCrhR1j9RD+l0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729336578; c=relaxed/simple;
	bh=iEUcW5EbPc3CuJsIl+m7Y0Zgw3NQlSs/GEI0BoftKtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GglBE+rsyo6GaFPpzjanS7IWAqmc5gG6Zplon3qc23Z55vabQmg1XIfWCvhkTc/pWjTtVcqVVzUkXYX4Us0e2Mvony13jvNEgsbbd+I3DRAK5w7//Xe1xKV3ghbGsYaOaDcnaBhY/5vnR2POzrgTokZgazBZTiyZse2qaPaPxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l+K7cjD/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729336574;
	bh=iEUcW5EbPc3CuJsIl+m7Y0Zgw3NQlSs/GEI0BoftKtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l+K7cjD/pTs0weGajKDR9txdYrJWQmLpsz5ovpm+fdxl1yifaBF7e/x6TCdNIYw18
	 oDArNc35ONstfzKL5jttKHoGxfyeZnl7tOxtyUCUlcAQbOf3OVRb2E7m6kJtjAtSFg
	 lME+5Ox/0eJr1tNmedv6dSSy8FHHolpRJ0uRKvNx+g+z2YOQBjkp00jx9efxZIVvAZ
	 R5xsp3jEc1iVEJatT69AHe2eSEA5SSC2vHdFOJ1615UlUhqgjUzbLJlo5L4jDCOgJw
	 B/PWsqE4K8+r3Zkt98B7KRJrZ3qQTkrwb46Iv2AJBGrEZBdCCojM3nhSJqc4FNAyoC
	 vLuSym2o1NUnw==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F34CE17E35DC;
	Sat, 19 Oct 2024 13:16:13 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 19 Oct 2024 14:16:02 +0300
Subject: [PATCH v4 3/4] PCI: exynos: Switch to
 devm_clk_bulk_get_all_enabled()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-clk_bulk_ena_fix-v4-3-57f108f64e70@collabora.com>
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 6a830166d37fff5bbbc35aaa7cc1b67b03e6ec3b..ace736b025b1b7d4cdcbd51d2e9d99af29f21149 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -300,7 +300,7 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(ep->elbi_base))
 		return PTR_ERR(ep->elbi_base);
 
-	ret = devm_clk_bulk_get_all_enable(dev, &ep->clks);
+	ret = devm_clk_bulk_get_all_enabled(dev, &ep->clks);
 	if (ret < 0)
 		return ret;
 

-- 
2.47.0


