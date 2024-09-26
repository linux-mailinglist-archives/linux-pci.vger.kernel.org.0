Return-Path: <linux-pci+bounces-13548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27A5986C87
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 08:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C1728665E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 06:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C191A4B61;
	Thu, 26 Sep 2024 06:30:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3795F1A4AA6;
	Thu, 26 Sep 2024 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727332247; cv=none; b=Mg0ol/D1rhmxh5qHvShzEDEwEC0U/tTwDAu/ttm1J8MlAlDZzpMsAALJFLVshyfJ5T/4lmjDV0cRlulkZFEFrpyETKKhiDrbaF105ayF6oN1aYNc19OaHE6zEsMV23TiV/qx4M2ZHFcrxnKID0XJAqkky6Fqjq0IXQmtiJk+L34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727332247; c=relaxed/simple;
	bh=SGOfHYZeKGSHd0W9j9kxAEOwDChEv5eLNk9JAYnJkZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sdxyDhMvOZW8X/OSWuFK72hz2VhwqejSkecbSXYCOmdXLCexgEkQPJG/WxUvw2qFFuzsKCcDhYVuMVcolB2XV2tVaYiY2N7tp9rNdHuY/6ga8c0nKrT2LM9/AF4u+fCDWen4SZiJMmLSy9zyND4sbQWUOrHciD8dY+j7trWySoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A61EA1A241F;
	Thu, 26 Sep 2024 08:30:44 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 776731A0FAE;
	Thu, 26 Sep 2024 08:30:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EDC93183F0C2;
	Thu, 26 Sep 2024 14:30:41 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	frank.li@nxp.com,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com,
	s.hauer@pengutronix.de
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 8/9] PCI: imx6: Add i.MX8MQ i.MX8Q and i.MX95 PCIe PM support
Date: Thu, 26 Sep 2024 14:07:52 +0800
Message-Id: <1727330873-17486-9-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1727330873-17486-1-git-send-email-hongxing.zhu@nxp.com>
References: <1727330873-17486-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add iMX8MQ i.MX8Q and i.MX95 PCIe suspend/resume support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 36df439d43ae..a8505cd3b53d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1497,7 +1497,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
-			 IMX_PCIE_FLAG_HAS_PHY_RESET,
+			 IMX_PCIE_FLAG_HAS_PHY_RESET |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
@@ -1535,13 +1536,15 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX8Q] = {
 		.variant = IMX8Q,
 		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
-			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.clk_names = imx8q_clks,
 		.clks_cnt = ARRAY_SIZE(imx8q_clks),
 	},
 	[IMX95] = {
 		.variant = IMX95,
-		.flags = IMX_PCIE_FLAG_HAS_SERDES,
+		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.clk_names = imx95_clks,
 		.clks_cnt = ARRAY_SIZE(imx95_clks),
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
-- 
2.37.1


