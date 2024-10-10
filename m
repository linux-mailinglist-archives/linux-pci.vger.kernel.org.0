Return-Path: <linux-pci+bounces-14136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3374997CD7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1C51C221F2
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 06:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A7E1A08CA;
	Thu, 10 Oct 2024 06:11:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FED1A00E2;
	Thu, 10 Oct 2024 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540679; cv=none; b=DUu4bSVCWzfK/Y6JIt+nuzRDcsZ09fZy30+pc6oKJJ2Zvvb6S92KJW5dXqDuB1b+e+WV/pqVHFUZHgWnC6yS57CgSWytcUCjuko9s3dDaP3EaUHtbHn8Ji778EyjbGzQh6KPBPCmXDP1XxJWSjqDoY7KLXIDI6JywAjChx7+jhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540679; c=relaxed/simple;
	bh=4NgXf7xSWI/1Sbxfwsz44UAu39ZpeOOq4QE/ebcvyE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IfuXGmbB1FZBuWCdCJSD2qOhM+oy/ZSd82h0F3t2h9sysCDEnM8AaBpqcr5UCpP06M5Nkm2L5hczlImMTwK3XdHQGcpvigb2ConZWyG35LP7GcyqerxkKZPu2LPNiugpLD6dIIydRxouEulqW9rFj1BqbGbB1yZkLr2an2PuVcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DA8AD201EA0;
	Thu, 10 Oct 2024 08:11:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9EC9B2025CB;
	Thu, 10 Oct 2024 08:11:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0E8871846662;
	Thu, 10 Oct 2024 14:11:13 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	frank.li@nxp.com,
	robh@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 1/2] PCI: dwc: Fix resume failure if no EP is connected on some platforms
Date: Thu, 10 Oct 2024 13:47:48 +0800
Message-Id: <1728539269-1861-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728539269-1861-1-git-send-email-hongxing.zhu@nxp.com>
References: <1728539269-1861-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The dw_pcie_suspend_noirq() function currently returns success directly
if no endpoint (EP) device is connected. However, on some platforms,
power loss occurs during suspend, causing dw_resume() to do nothing in
this case. This results in a system halt because the DWC controller is
not initialized after power-on during resume.

Call deinit() in suspend and init() at resume regardless of whether
there are EP device connections or not. It is not harmful to perform
deinit() and init() again for the no power-off case, and it keeps the
code simple and consistent in logic.

Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a0822d5371bc..a52101bbecf4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -933,23 +933,23 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
 		return 0;
 
-	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
-		return 0;
-
-	if (pci->pp.ops->pme_turn_off)
-		pci->pp.ops->pme_turn_off(&pci->pp);
-	else
-		ret = dw_pcie_pme_turn_off(pci);
+	/* Only send out PME_TURN_OFF when PCIE link is up */
+	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
+		if (pci->pp.ops->pme_turn_off)
+			pci->pp.ops->pme_turn_off(&pci->pp);
+		else
+			ret = dw_pcie_pme_turn_off(pci);
 
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
 
-	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
-				PCIE_PME_TO_L2_TIMEOUT_US/10,
-				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-	if (ret) {
-		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-		return ret;
+		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
+					PCIE_PME_TO_L2_TIMEOUT_US/10,
+					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+		if (ret) {
+			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+			return ret;
+		}
 	}
 
 	if (pci->pp.ops->deinit)
-- 
2.37.1


