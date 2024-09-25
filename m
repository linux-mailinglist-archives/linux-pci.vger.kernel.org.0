Return-Path: <linux-pci+bounces-13487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1168A9852C6
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 08:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429D61C22C01
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 06:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C7815574C;
	Wed, 25 Sep 2024 06:11:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CB152787;
	Wed, 25 Sep 2024 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727244682; cv=none; b=I0MmyHs96RZoKIcVuux6hRldP7VY0ptDyBI3TQOzu0+xTsNF9HVCdyxLfrLraBqLM3awfe1mSjXIq2/U2MayAWC4/5YAqDWcdj5Dt1XZrBpWs4yD+2pZ+nQAd2NnaypwGbiTsr0rydNIpEL+kCrqNPrXyl/vNLiyb+d5GxbsuW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727244682; c=relaxed/simple;
	bh=/Na4mmXiKLt8UcFVI72fQXazUo7b1yDzIc3NeYd3v20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=l7AWw/9qjljl/pvKEJttaVmGJN67niMBrUdW31nQgCoGZ+lyX8uyw/ghBERpLTj7WmaDCzl5LgGT7WWqQ2wjCoRATaX/XINwpOPLJIN4WFxktO+2lsuf8838rsM6ugJEgyjkX+KTPeak1BRtBimUB2auXByRpCHyoK3aJlPtvf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 92CB7201FD3;
	Wed, 25 Sep 2024 08:11:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2DD93201FE7;
	Wed, 25 Sep 2024 08:11:13 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C5AB7183AD51;
	Wed, 25 Sep 2024 14:11:11 +0800 (+08)
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
Subject: [PATCH v1 2/2] PCI: dwc: Do stop link in the dw_pcie_suspend_noirq
Date: Wed, 25 Sep 2024 13:48:37 +0800
Message-Id: <1727243317-15729-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1727243317-15729-1-git-send-email-hongxing.zhu@nxp.com>
References: <1727243317-15729-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

On i.MX8QM, PCIe link can't be re-established again in
dw_pcie_resume_noirq(), if the LTSSM_EN bit is not cleared properly in
dw_pcie_suspend_noirq().

Add dw_pcie_stop_link() into dw_pcie_suspend_noirq() to fix this issue and
keep symmetric in suspend/resume function since there is
dw_pcie_start_link() in dw_pcie_resume_noirq().

Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index cb8c3c2bcc79..9ca33895456f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -952,6 +952,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 		}
 	}
 
+	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
 
-- 
2.37.1


