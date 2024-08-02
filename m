Return-Path: <linux-pci+bounces-11173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3003945868
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 09:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699791F22267
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 07:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB416B3B5;
	Fri,  2 Aug 2024 07:06:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E461FDA;
	Fri,  2 Aug 2024 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722582397; cv=none; b=KVFdiRksOfljMV/ecBh+KD7DaoCZ+Zh1mqFV5ydnwiLZC3C9yQEhq9uFQzqI6Uz779yz3HUgFuCIrbwgat/RMmxZI4tqIP1kJ7sCY/WfvpLQsGRvdywHkRzxrNiyVmO0x6QXflGaAPEfDS4NO4Wz1Z9FLl95OIeAyL7BK6rxDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722582397; c=relaxed/simple;
	bh=B8R0+soTkRLKX7M1hwzeNsFHB8sKJ5BpKxBTvbjHMGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eakRsX8DDhdmrSuLbH9k8MnvWnTKfRkFyjc7RhJSbpai4ifG88raFjSUQkNBHUYB75xGD3BnWzXPtyxlcQ8/AIp5qJr2gVEjVW+Nb6FBSUusC7mWtNmuuUpNfdXXHtrUJAmJb+R9YcaRzdgf04eidxJRV6foU36THT1lbcWyPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BE84F201067;
	Fri,  2 Aug 2024 09:06:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 855972001CA;
	Fri,  2 Aug 2024 09:06:27 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0990E183ACAC;
	Fri,  2 Aug 2024 15:06:24 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	l.stach@pengutronix.de
Cc: hongxing.zhu@nxp.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v5 3/5] ata: ahci_imx: AHB clock rate setting is not required on i.MX8QM AHCI SATA
Date: Fri,  2 Aug 2024 14:46:51 +0800
Message-Id: <1722581213-15221-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
References: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

i.MX8QM AHCI SATA doesn't need AHB clock rate to set the vendor
specified TIMER1MS register.
Do the AHB clock rate setting for i.MX53 and i.MX6Q AHCI SATA only.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/ata/ahci_imx.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 75258ed42d2ee..4dd98368f8562 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -872,12 +872,6 @@ static int imx_ahci_probe(struct platform_device *pdev)
 		return PTR_ERR(imxpriv->sata_ref_clk);
 	}
 
-	imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
-	if (IS_ERR(imxpriv->ahb_clk)) {
-		dev_err(dev, "can't get ahb clock.\n");
-		return PTR_ERR(imxpriv->ahb_clk);
-	}
-
 	if (imxpriv->type == AHCI_IMX6Q || imxpriv->type == AHCI_IMX6QP) {
 		u32 reg_value;
 
@@ -937,11 +931,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
 		goto disable_clk;
 
 	/*
-	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL,
-	 * and IP vendor specific register IMX_TIMER1MS.
-	 * Configure CAP_SSS (support stagered spin up).
-	 * Implement the port0.
-	 * Get the ahb clock rate, and configure the TIMER1MS register.
+	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL.
+	 * Set CAP_SSS (support stagered spin up) and Implement the port0.
 	 */
 	reg_val = readl(hpriv->mmio + HOST_CAP);
 	if (!(reg_val & HOST_CAP_SSS)) {
@@ -954,8 +945,19 @@ static int imx_ahci_probe(struct platform_device *pdev)
 		writel(reg_val, hpriv->mmio + HOST_PORTS_IMPL);
 	}
 
-	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
-	writel(reg_val, hpriv->mmio + IMX_TIMER1MS);
+	if (imxpriv->type != AHCI_IMX8QM) {
+		/*
+		 * Get AHB clock rate and configure the vendor specified
+		 * TIMER1MS register on i.MX53, i.MX6Q and i.MX6QP only.
+		 */
+		imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
+		if (IS_ERR(imxpriv->ahb_clk)) {
+			dev_err(dev, "Failed to get ahb clock\n");
+			goto disable_sata;
+		}
+		reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
+		writel(reg_val, hpriv->mmio + IMX_TIMER1MS);
+	}
 
 	ret = ahci_platform_init_host(pdev, hpriv, &ahci_imx_port_info,
 				      &ahci_platform_sht);
-- 
2.37.1


