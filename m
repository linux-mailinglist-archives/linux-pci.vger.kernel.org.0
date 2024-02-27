Return-Path: <linux-pci+bounces-4117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53817868F79
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E200283458
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0360A1386D4;
	Tue, 27 Feb 2024 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DujlSMdt"
X-Original-To: linux-pci@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784D41386C3
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 11:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034853; cv=none; b=ohWk9sBbVZBMPKgwRBlx/0wgIn6gFWCtw5ujm/8RZrvYoRCXTb+T+g0MwmUC0jFKrdVy8g3uOySWYYDh382P+XAhld2YuHKixtxtVsm+X3N6djgnvZM659w5DvBvVQEpoKumEW5g/3NdK61+Uaa4ewzWommfYd3W6UIMIcfw28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034853; c=relaxed/simple;
	bh=S9/+LCdR6jnIUOPSc20FoU3XYkHo/paVrIUASEIKU+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YBasSPvjdTugQjlpVg1yHz/3hahISfU1ri0HUvVUak/vCxfrqW+jgGgpZ7yLriR/Olt/opgik4FK5OZp6JXYZetPlDVFM0rlke3aw/dV1oIVgvFelvPQB1TCEY3swR6oEwvlVcbm27qyUpJnH1ClfW6HoEdbeTxrNBEz0HLMUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DujlSMdt; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	In-Reply-To:References; bh=u0E2Diup0AiiVMnnreZGh7XxC7/vc7JDGyBFgrh4bLE=; b=Du
	jlSMdt/csM2FIIOZ1AS0n0P83As7aMdCWOJDjmcrIPqgtls2EuAIK82ShyD0YrcEMMV0y+eCXH304
	XTaI6pWoBHkLI8UxcAmUJKYoqj47O99ek4DOeObVnmY2Hi+pQllVh26StMO4oqrUVvahhyGTRedlO
	etXa7iqGxm+Zt15NDVgRZ0ZrSd9uDQsHb8fGjkvxILNVul4p/HAtB88s4a8ME3WDTVDKMRTwMl3Hs
	AvL9eq1q/vm64lmkCcBPxHeBs/oMbUufb6UF4aclAvqkSFGsCPUWI7rx/vHk+SOjRdtxjEjKZ/uXy
	vES0PJWlqPXNuYrgIggl5A071H4A7mnQ==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1revU5-005dFm-EL; Tue, 27 Feb 2024 11:18:53 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Lei Chuanhua <lchuanhua@maxlinear.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] PCI: dw-rockchip: Add error messages in .probe()s error paths
Date: Tue, 27 Feb 2024 12:18:35 +0100
Message-ID: <20240227111837.395422-2-ukleinek@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2503; i=ukleinek@debian.org; h=from:subject; bh=S9/+LCdR6jnIUOPSc20FoU3XYkHo/paVrIUASEIKU+w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl3cUO3qnSxDO51sVKwCI6WeHaZXuaDt0oaGYFH AP8pZoKluCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZd3FDgAKCRCPgPtYfRL+ TpAOB/9Or1GBTlt/LmDI3zIRKVEm+fzI/Ak/c4hElCMqqpxElSkjIdgVrX9Q7wVoMgpqcoKrqCn +ENT4zaE1WtEsts6EhE2NsI1g4dzT8vdDQ3+zOSA/Q1mhQJh8RtBAD5IeZyRXIMPeDj3b1d8mMc tD68hrGU+/C4kyap3lil5NMgGgvcwBabDrXWmE3LSSo30x5JaIoF/0io/vqt2Z6mqZ8EzzfWO2P ErXpSJK1kQYODWlFTbsbUxhZ2u4DlTqR3VCeKuSgOMSRjCE4MbCnRsCehX0TmQnaOsOzZxzlHxh 58dIJQdt8balEQlp3Zu1DZGd71McdGBGyPleT1FX3yTGcT+O
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Drivers that silently fail to probe provide a bad user experience and
make it unnecessarily hard to debug such a failure. Fix it by using
dev_err_probe() instead of a plain return.

Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index d6842141d384..4c16d8d2e178 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -225,11 +225,17 @@ static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
 
 	ret = devm_clk_bulk_get_all(dev, &rockchip->clks);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(rockchip->pci.dev, ret,
+				     "failed to get clocks\n");
 
 	rockchip->clk_cnt = ret;
 
-	return clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
+	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
+	if (ret)
+		return dev_err_probe(rockchip->pci.dev, ret,
+				     "failed to enable clocks\n");
+
+	return 0;
 }
 
 static int rockchip_pcie_resource_get(struct platform_device *pdev,
@@ -237,12 +243,14 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
 {
 	rockchip->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
 	if (IS_ERR(rockchip->apb_base))
-		return PTR_ERR(rockchip->apb_base);
+		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->apb_base),
+				     "failed to map apb registers\n");
 
 	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
 						     GPIOD_OUT_HIGH);
 	if (IS_ERR(rockchip->rst_gpio))
-		return PTR_ERR(rockchip->rst_gpio);
+		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst_gpio),
+				     "failed to get reset gpio\n");
 
 	rockchip->rst = devm_reset_control_array_get_exclusive(&pdev->dev);
 	if (IS_ERR(rockchip->rst))
@@ -320,10 +328,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		rockchip->vpcie3v3 = NULL;
 	} else {
 		ret = regulator_enable(rockchip->vpcie3v3);
-		if (ret) {
-			dev_err(dev, "failed to enable vpcie3v3 regulator\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to enable vpcie3v3 regulator\n");
 	}
 
 	ret = rockchip_pcie_phy_init(rockchip);

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.43.0


