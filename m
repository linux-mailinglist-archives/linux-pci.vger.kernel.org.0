Return-Path: <linux-pci+bounces-4925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD10880A43
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 05:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0C9283A14
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 04:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBB111725;
	Wed, 20 Mar 2024 04:03:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1EA1364;
	Wed, 20 Mar 2024 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710907418; cv=none; b=TzrNjgmBS6lmcxBYNB8fGjUfmizGHAnCV1j41rJ5LVhpO4Q+KhrDT6hi1iZ8CE1JSbC5++6PlscX1FDdkwj67zsxzB4G3oFJZn72YrOFovEwc0vfOSTuIcM5kphI/M9ZjOWIJ0z1bJGv5t9r1RLihVwiTgYnnteAxU6/01Khi4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710907418; c=relaxed/simple;
	bh=a1iPkS19wKvYjByVRjYUWC8hvrMspm4HWjt5L6aSPzE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=e55pbXMVMHnBP851rtCkCxgQFBCh9qMiD2mRyap2LVAsZfgDrsxqJZ7CvkG2BXFrnW+evJyx0bqA/EAABjhOL8i7dsjHqECmjAhfVijlyUThi5Av7ih2wCYuiZ90ERqYHnNwIJdbR0OULAbBbAkadKUM1ZmLbNxfTGvfIt61AuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5062F200B54;
	Wed, 20 Mar 2024 05:03:30 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 170402016B4;
	Wed, 20 Mar 2024 05:03:30 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0A0C5183AD0A;
	Wed, 20 Mar 2024 12:03:27 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lorenzo.pieralisi@arm.com,
	marex@denx.de,
	frank.li@nxp.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-imx@nxp.com,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
Date: Wed, 20 Mar 2024 11:45:38 +0800
Message-Id: <1710906338-4596-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Fix i.MX8MP PCIe EP can't trigger MSI issue.
There is one 64Kbytes minimal requirement on i.MX8M PCIe outbound
region configuration.

EP uses Bar0 to set the outboud region to configure the MSI setting.
Set the page_size to "epc_features->align" to meet the requirement,
let the MSI can be triggered successfully.

Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 99a60270b26c..3238b63721bc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1013,9 +1013,14 @@ static void imx6_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	enum pci_barno bar;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	const struct pci_epc_features *epc_features;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
+	if (ep->ops->get_features) {
+		epc_features = ep->ops->get_features(ep);
+		ep->page_size = epc_features->align;
+	}
 }
 
 static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-- 
2.37.1


