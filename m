Return-Path: <linux-pci+bounces-14831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80929A314B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 01:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E05285E59
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 23:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CBA1FCF53;
	Thu, 17 Oct 2024 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IhdbLVzt"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A72296DE;
	Thu, 17 Oct 2024 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207077; cv=none; b=PKF3ZeGA4CEJ4GZ59+umq+WLXJ7vJQb9j1n57kzNzqXGn7NZdrFOdHA9WKj95K99r0L+ubtjcw4Q6Yzvegt0yFbJeiYaCXrXkhvBf4jG1oI8V0FkYE/QS/91BU2TpfjblY4jpnbqxGv+tRVKA2l53e4uedfsMd/55uJlbHdZcRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207077; c=relaxed/simple;
	bh=iEUcW5EbPc3CuJsIl+m7Y0Zgw3NQlSs/GEI0BoftKtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JMCedd/+4V0By/sgBAnTL8MRyrKdJcTDh1wuB4jOY8TvQb9zKogxSA4ul0k/Ypwh/bUkLKAkKNUm3s834b0tl17APxOV72f8r6qOc1vqYwW2jniF6nPuwCoUyauWsLN/0FAWS0o0Kxo2nTD0ELfdv91jUXzZMsXEdTqHSyKRwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IhdbLVzt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729207073;
	bh=iEUcW5EbPc3CuJsIl+m7Y0Zgw3NQlSs/GEI0BoftKtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IhdbLVztzE976ILx+y9BQMkNkhBDmWOPy7bWA82yzxfFAYlTRWBUoQ2EjYVpsGB0G
	 +oXkdKtdO9GmU4nVbNIgnRoF3Zw2IZOuEkDGmVAW8b/h7Kf+/ExQRUHuQdlPEtOxWj
	 N6ELuumE1w+mtvXuv+ys6+2iCJvCaQnZRP5kgXanaibSXN1YbD+zFuCl+i8XNw5f5+
	 S2pK8b0nF0lzD0FwS8BdaJSyVCUH/9FbkNQIm6zKExNK+xAV2gcgFmXm/edzA7scJO
	 IZfriRLbx+ck5MvVRBoX4j0W46owM0MePZFxQAC8tH+0t13b46MQw6WiBKU3n5Lq0I
	 A+J2rQ4qaUsaQ==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE73717E0EEC;
	Fri, 18 Oct 2024 01:17:53 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 18 Oct 2024 02:17:31 +0300
Subject: [PATCH v3 3/4] PCI: exynos: Switch to
 devm_clk_bulk_get_all_enabled()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-clk_bulk_ena_fix-v3-3-57e8bb82460c@collabora.com>
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


