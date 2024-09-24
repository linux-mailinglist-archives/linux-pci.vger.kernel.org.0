Return-Path: <linux-pci+bounces-13402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DD3983BB0
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 05:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E341D1F229C6
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 03:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2D249638;
	Tue, 24 Sep 2024 03:50:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42358481CD;
	Tue, 24 Sep 2024 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727149836; cv=none; b=KcF3gCn46lHVfnRtvlLbSw5Muo6Fr+cw7uaf9loZ82VX5+AprGBRZlUc6zAaSD7MyK4Io2XgOfSs6S0CShUwubDRaPdtjeWFAB3BeKEmtpZTjuic2psS7mbe0kVxfcdAwjBrJg8OjuNcq0VwnIz3CKBBj2YJfNzlGChxCwInBkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727149836; c=relaxed/simple;
	bh=sQ9MeQogb1yW5Cc6yYBVPX298b0I4TU9AsXyCbfNl88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YnxXcJPcyR//RN2pVKRV61JFiBbZFG1nfbgqDlizMLQ/DAvlLdGFkp6CCF4f1xVohosVWR6TRZCpslRphp1d0VHJDRm5IPDNo+Gp/Vqs0CHFNM6lh7e808kE15tKj2lKL96qqv6bMM38FpWhaYH32Oyj4zyysQYoD3hYXNBTPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C248620140A;
	Tue, 24 Sep 2024 05:50:33 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 898172006D1;
	Tue, 24 Sep 2024 05:50:33 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 79B85183DC03;
	Tue, 24 Sep 2024 11:50:31 +0800 (+08)
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
Subject: [PATCH v1 8/9] PCI: imx6: Add i.MX8MQ i.MX8Q and i.MX95 PCIe PM support
Date: Tue, 24 Sep 2024 11:27:43 +0800
Message-Id: <1727148464-14341-9-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
References: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add iMX8MQ i.MX8Q and i.MX95 PCIe suspend/resume support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
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


