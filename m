Return-Path: <linux-pci+bounces-14523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E012599E1D0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 10:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2031F2353B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7374E1DD9D6;
	Tue, 15 Oct 2024 08:57:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE21DAC99;
	Tue, 15 Oct 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982650; cv=none; b=uTqVtM6UlnI86/DAabIhga8fDrena2J2IiUoHMG7pd1dYIZBX430MmIXukeVq6U36FCDHLUIlhjy0YO7QvH2QFWyqW5KdCPGNSkf7zZPeHso7uSGODxZDiAvD4vH2GZGnzAj8JbWVk83p+X4RLfAiwRWsrgktfSzeRNdoqgPEX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982650; c=relaxed/simple;
	bh=CVsgwbXow+2/QV1U9+Di1rNmZSKT7eTOnxPUtfMfdJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OptHJbfI/fNSSTYU7xjvmaYXGvAppL/wjTaJLGL62x3ZqvPfHnX4JfKXJGm6RjLrKyYJFZ5rx0fyocoEQuqtHl2LyEDaBn7lGyj+i1/qwj1QbAB91rYQngYh4kv/7aKz+fs139+p/Xv6OMsdaTiQylS+ax5P44lRqh62SYnSkjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 31B481A17A2;
	Tue, 15 Oct 2024 10:57:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EB34D1A09C9;
	Tue, 15 Oct 2024 10:57:26 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C6D6E183DC03;
	Tue, 15 Oct 2024 16:57:24 +0800 (+08)
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
Subject: [PATCH v4 3/9] PCI: imx6: Fetch dbi2 and iATU base addesses from DT
Date: Tue, 15 Oct 2024 16:33:27 +0800
Message-Id: <1728981213-8771-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
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
index 52a8b2dc828a..2ae6fa4b5d32 100644
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


