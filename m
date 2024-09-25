Return-Path: <linux-pci+bounces-13492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D7098531C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 08:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94FD1F2426C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CEC157466;
	Wed, 25 Sep 2024 06:47:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84941156F4A;
	Wed, 25 Sep 2024 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246829; cv=none; b=rBYt4+YLWaqqXlJ18d4TQkRkIuqvJyx2LPBeIvIdksn1xPvRXpu3sPa0CJr44Q6u6S1Uh8oSJF9dGWCrNy0iigZpmFpWPBl1n9aNAvhX4OIFzt+4vpbyjBi5sthfAD6Bbs1bwjN9pDG9zMncZVz+c4twBYvvH9soQ8TwYAVKDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246829; c=relaxed/simple;
	bh=vEwp+6zX/gtGSos3iU4WiXjvDBbj1xVRs/TyfXbWHtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=a/rWxH3NA5zLZg8GwRspq7025Je9CjIdOLUT5tju9WUBWKbMdM43yXRKOPOYcHjnMqw7AfFwpeGgR74sRT/E7gK8qBExEzjQtNDpvE6jKOtma6ICVo4Nx5nIgim0Efg37tgOOx/Z3+19fa1U0D+82LzixiIf1c9Bi2/e5r5HfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E2C7A202A74;
	Wed, 25 Sep 2024 08:47:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AB7512029FC;
	Wed, 25 Sep 2024 08:47:05 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A90CD183AD47;
	Wed, 25 Sep 2024 14:47:03 +0800 (+08)
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
Subject: [PATCH v2 3/9] PCI: imx6: Fetch dbi2 and iATU base addesses from DT
Date: Wed, 25 Sep 2024 14:24:31 +0800
Message-Id: <1727245477-15961-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1727245477-15961-1-git-send-email-hongxing.zhu@nxp.com>
References: <1727245477-15961-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Since dbi2 and atu regs are added for i.MX8M PCIes. Fetch the dbi2 and iATU
base addresses from DT directly, and remove the useless codes.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2aa02674c817..e8e401729893 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1113,7 +1113,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 			   struct platform_device *pdev)
 {
 	int ret;
-	unsigned int pcie_dbi2_offset;
 	struct dw_pcie_ep *ep;
 	struct dw_pcie *pci = imx_pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
@@ -1123,25 +1122,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	ep = &pci->ep;
 	ep->ops = &pcie_ep_ops;
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX8MQ_EP:
-	case IMX8MM_EP:
-	case IMX8MP_EP:
-		pcie_dbi2_offset = SZ_1M;
-		break;
-	default:
-		pcie_dbi2_offset = SZ_4K;
-		break;
-	}
-
-	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
-
-	/*
-	 * FIXME: Ideally, dbi2 base address should come from DT. But since only IMX95 is defining
-	 * "dbi2" in DT, "dbi_base2" is set to NULL here for that platform alone so that the DWC
-	 * core code can fetch that from DT. But once all platform DTs were fixed, this and the
-	 * above "dbi_base2" setting should be removed.
-	 */
 	if (device_property_match_string(dev, "reg-names", "dbi2") >= 0)
 		pci->dbi_base2 = NULL;
 
-- 
2.37.1


