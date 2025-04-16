Return-Path: <linux-pci+bounces-26009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ACAA90792
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 17:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D299A5A0B83
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5509D207DE5;
	Wed, 16 Apr 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VNOTY+dy"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76220189BB5;
	Wed, 16 Apr 2025 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816833; cv=none; b=g64wOLGsfyp/POAr8m2BW36a0pjQdOqEd/cBABUSttwCZ/AICE/Ob5iEQjoQ447UfpJYJldsYCj0y1keV3rJqNE7sXJjwF4IkDLeRpyom6zK9tR5sy3zHiFe1uAMwBtjVfLFz02ceBmNHK9WcHRvzhCt/2Y6b/IXCDgbacJXWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816833; c=relaxed/simple;
	bh=rmHHaaug2DDbVdoWrpVDh9XFDcdhs6q/pEUn8PkZvMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pZPnuvvhGXNRRQK7Pzf9zFifZLXyXQ3ZVWE9bEeHA/I6oLewoPdXy28DExs08cUG/GLECN/141nQBMpjdvs92GAOCXowG5KKriwq51llIOF9Le1EGjZciOG3Zkw2y/jPCMih8Zu4XGQtuLvK60FiY9WyZB+h7H9aFEcKCDnoIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VNOTY+dy; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=n/CrH
	Wu7/N0JbLzLhfGyYLZ28eCk9w7x/JfjK48Yd84=; b=VNOTY+dyHQg0QwO0e8psO
	1EQh2MMGJQGnp3gE7RZOKgtSb5zfsTKfHHKKCNbUzvitXSSl3J0y5cC8cALMA47X
	7rtM7Qw4JcH2MELzQEd1xPDKl+z/3X3mmD9+ZB+q/60izYZ7rlG28v4v628nHscN
	aiAFBgX+VVteVApJxz5dW8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDHrr6Ayv9nGGzuAQ--.32225S2;
	Wed, 16 Apr 2025 23:19:29 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de
Cc: manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
Date: Wed, 16 Apr 2025 23:19:26 +0800
Message-Id: <20250416151926.140202-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHrr6Ayv9nGGzuAQ--.32225S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWrZFWfWFy7CrWxtryDAwb_yoW8Cr4xpa
	yDAFW5Ary5GF4agFnrC3Zxur4rt3Zayay7Jws3Kw1I9Fy2yryDtFy3urnxta1fJF40kFy5
	Cr45ta40kr43Xr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pELvKUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhAxo2f-yS0qIAAAsO

The RK3588's PCIe controller defaults to a 128-byte max payload size,
but its hardware capability actually supports 256 bytes. This results
in suboptimal performance with devices that support larger payloads.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c624b7ebd118..5bbb536a2576 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -477,6 +477,22 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void rockchip_pcie_set_max_payload(struct rockchip_pcie *rockchip)
+{
+	struct dw_pcie *pci = &rockchip->pci;
+	u32 dev_cap, dev_ctrl;
+	u16 offset;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	dev_cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCAP);
+	dev_cap &= PCI_EXP_DEVCAP_PAYLOAD;
+
+	dev_ctrl = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
+	dev_ctrl &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	dev_ctrl |= dev_cap << 5;
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, dev_ctrl);
+}
+
 static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 				      struct rockchip_pcie *rockchip)
 {
@@ -511,6 +527,8 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 	pp->ops = &rockchip_pcie_host_ops;
 	pp->use_linkup_irq = true;
 
+	rockchip_pcie_set_max_payload(rockchip);
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");

base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
-- 
2.25.1


