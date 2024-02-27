Return-Path: <linux-pci+bounces-4128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00CF8696A6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 15:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25A11C237A8
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40558145350;
	Tue, 27 Feb 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="LjsQgTFx"
X-Original-To: linux-pci@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E61420C9
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043214; cv=none; b=cwI1yKORoWRgCmRDHiKvPjxG+PUKyr5XXghtefcRkTEJ1xvYX7xBGS3I1IRt8wLW85udUPfmv13exLdRz/QYCGQ4k2sfeGRC8zr/lYX819um5cf55CbO5Sgd/HdN/okr3DC9bszpFNEBQvdAMg0Ep8eQFO+kEwoDQV1aaCVDwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043214; c=relaxed/simple;
	bh=Nob6qN/qkCiuXvIB3sPabKHumbLsd+xpfv29HkFfRv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ghat190QpXidZ+Wp9QGBeAi29vii/pYdtYM1gRJetHjTEall+wyobUBbNsO/EiU7Fd/UE2IWc+Jc3BWtKQQW7r2CYpTBdkYBKHLMp6Sbk0AU1kfE/iWyV2YBmn/bZJYcxrkcwxLNaBB2lVBBjYlbfZ2m9M4/Q7KUliPc+AIv0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=LjsQgTFx; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	In-Reply-To:References; bh=r7SFpf4dLvrRhxoKMvvgpekdUrqBq4F3M57BeGF5vkk=; b=Lj
	sQgTFxPzWXB/XJtOo+oF/TESN4qrao76zAkYQYPNL8mgnDhHQQqBvAfWBUlf1I6Ad4AgvOi4dTx5c
	XX95ndTj/8r8jpNlDpa0RKRHFR8POiNM/w97KKCQOM9SzHSRgaWzDz4R23lCyNo2WONRcKsU8nCqp
	IItbiq9F1Ftl6VK5czGYK1X62YQpCGjqDsqFGTA+BGN51FAnjDQlzQg5hC09V8qGXPMgubt1gwV32
	H8wBoJmTbfw1/vhlFJgId5tHHY19f4rCzEfcZ+qFE7nBM/VFDUWkO/17CAd6HelyeDaAWhu2edi//
	jhwPMgt4+uDnlSXsUX4RY9XEi5hk/rcw==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1reyCj-005mof-DF; Tue, 27 Feb 2024 14:13:09 +0000
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
	Serge Semin <fancer.lancer@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2] PCI: dw-rockchip: Add error messages in .probe()s error paths
Date: Tue, 27 Feb 2024 15:12:54 +0100
Message-ID: <20240227141256.413055-2-ukleinek@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2830; i=ukleinek@debian.org; h=from:subject; bh=Nob6qN/qkCiuXvIB3sPabKHumbLsd+xpfv29HkFfRv4=; b=owEBbAGT/pANAwAKAY+A+1h9Ev5OAcsmYgBl3e3o1zR9lVs2UewhWb9uiYuT6ZDByWgZ1zlhu 9Rgm8F0V6uJATIEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZd3t6AAKCRCPgPtYfRL+ TicgB/YjJU19WoIDuzpBX2npPG7PwKGSw4RVyws3t9z1D9R3m/h/lLPA9QRrDgvEd3IOz7bdNSO WURcEuQZ/w2D+oRxsJ1e1EHrCiL6ro9ebIqSOHbCBky7ObE1oAXJw3beRTp5/LyiaxR/Czd/d82 RFg5XDDkhFgRoGDf8yruur/GmFXY1AWIOFbevUgEMQbNS9y/EoF+QYoLFEfPto0ZMhgVnPFmW3o 34lhojl5D3TUvp4ww600NJu9wGQFRlA8Y/ZxYfnCNLiKKIbghSo1MlmV7Aw9dbDIrWpuSJCF/9s 8SIt/kxYqFsEOt6vvF3kgT3s/NNDylXiAAoDZcfYUb9C9zs=
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Drivers that silently fail to probe provide a bad user experience and
make it unnecessarily hard to debug such a failure. Fix it by using
dev_err_probe() instead of a plain return.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
Hello,

changes since (implicit) v1, sent with Message-Id:
20240227111837.395422-2-ukleinek@debian.org:

 - use dev instead of rockchip->pci.dev as noticed by Serge Semin.
 - added Reviewed-by: tag for Heiko. I assume he agrees to above
   improvement and adding the tag despite the change is fine.

Best regards
Uwe

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index d6842141d384..a13ca83ce260 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -225,11 +225,15 @@ static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
 
 	ret = devm_clk_bulk_get_all(dev, &rockchip->clks);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to get clocks\n");
 
 	rockchip->clk_cnt = ret;
 
-	return clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
+	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable clocks\n");
+
+	return 0;
 }
 
 static int rockchip_pcie_resource_get(struct platform_device *pdev,
@@ -237,12 +241,14 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
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
@@ -320,10 +326,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
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


