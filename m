Return-Path: <linux-pci+bounces-14524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA35999E1D3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 10:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70877285E26
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 08:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A1B1E00BF;
	Tue, 15 Oct 2024 08:57:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD81DD9BD;
	Tue, 15 Oct 2024 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982652; cv=none; b=WL2YCS/xXoyeN76kyN+qQkkxfpM67yO58Jd6sKPg4/vkSnXagKej9zRidrdY5jvnEhCHYwzYgnOHxs0kYsKiVl7CGU+rvVUVO6B6TGunQHPnqMsohwYKNM4TE/ETveCs50/m1bvzd5iBWZftdbyQQVQr3nmz7YCUwGRD4KJZ4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982652; c=relaxed/simple;
	bh=fFUfoQr7BDA8XW3C7x0D31L9BuEwyuCray9WmFT5Ijg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=P+KDZsOcrbki9kjA6U3ngKJ0TCRruJDrOyi7mYH5AKfb9DLlHcE4iFtlVgxFtSSZPWoCXWJ6sjmuUeFKc5Hrc9XD3+86+AQ3doDdR4YEKCt+1arbsPWLh4OcajFI7Zc483146cmaqdEMBrs+cFnBUlThYsH7mY20ip1bCC4lKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D8AFA20168E;
	Tue, 15 Oct 2024 10:57:28 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 99CF7200C87;
	Tue, 15 Oct 2024 10:57:28 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6BB0E183DC02;
	Tue, 15 Oct 2024 16:57:26 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com,
	s.hauer@pengutronix.de
Cc: hongxing.zhu@nxp.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v4 4/9] PCI: imx6: Correct controller_id generation logic for i.MX7D
Date: Tue, 15 Oct 2024 16:33:28 +0800
Message-Id: <1728981213-8771-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

i.MX7D only has one PCIe controller, so controller_id should always be 0.
The previous code is incorrect although yielding the correct result. Fix by
removing IMX7D from the switch case branch.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2ae6fa4b5d32..ca8714c625fe 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1338,7 +1338,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	switch (imx_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
-	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx_pcie->controller_id = 1;
 		break;
-- 
2.37.1


