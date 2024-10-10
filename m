Return-Path: <linux-pci+bounces-14137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A8997CD9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1BF281DAB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 06:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF541A0BED;
	Thu, 10 Oct 2024 06:11:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB161A0732;
	Thu, 10 Oct 2024 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540679; cv=none; b=KwjE6XEMvAEVTT38taSQTghzJKu1Ghzruam6M79uY3Xi4jZdflZeKY1VYd3w+0EslH9qdvNdP+UDO9R0EE2mirkTgxP5/2DQhbA+oahiPFyrTjQjhQkyFbxWnmuc7Y2ltUvtcMpka7Huvol0hYlfJMIpMMKKn6JGoyx9FCysUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540679; c=relaxed/simple;
	bh=MwiKEE1wvhyJ9zJoLL3AnBu7gEh1iYNvknUkhR99PAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=n+7+LSSuRtK18GbWuUrl6fkWuAPr7/V5A2vZiSxO1ErRUn8yKE1NhEFBPL+cMP0isgCCFDUnX0VRyQNjzcI5OxomGIwA4QjV6i4ryjNSAhYCenS71Mb7cq04wF9+Zv7vQJ+9FnPAH/XJYaetpVNG+Om03AhelHVwNkGTXCQ8Mk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E8B4A1A1E23;
	Thu, 10 Oct 2024 08:11:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AFC3B1A2894;
	Thu, 10 Oct 2024 08:11:16 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1EFBC1846661;
	Thu, 10 Oct 2024 14:11:15 +0800 (+08)
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
Subject: [PATCH v2 2/2] PCI: dwc: Always stop link in the dw_pcie_suspend_noirq
Date: Thu, 10 Oct 2024 13:47:49 +0800
Message-Id: <1728539269-1861-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728539269-1861-1-git-send-email-hongxing.zhu@nxp.com>
References: <1728539269-1861-1-git-send-email-hongxing.zhu@nxp.com>
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a52101bbecf4..f673443d4098 100644
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


