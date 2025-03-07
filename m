Return-Path: <linux-pci+bounces-23172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8380A57636
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 00:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEB297A499D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 23:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C80212F8F;
	Fri,  7 Mar 2025 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa4liii3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433B212D8D;
	Fri,  7 Mar 2025 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390674; cv=none; b=qTTiLaCf8aIFotJkxZHMBJfdQZuMSk33d9DKKPAPOphm0U0flVz/zfLhfpG3GC7DxlNP7z60BvsY0g3nOzahcLF5Hxhf+DDzLNlZOoHQnaNXrci7zXiS+TFKIl1/w76QAHqIvrrKC003iRIfZNsyL+35lN4E1k5rXSp2ez+X7/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390674; c=relaxed/simple;
	bh=ua0QgEy0dtgEEi4JLJEBT5g3dBO7iHT7Cgd7aa1B+Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PdPPKOFj0ykGB68CsjLcD6brmfTDbTP+hCI44O/dzRNJwhFD7CoF7htEhBRNuImVsS2fNFer44W9mVeVIo3fvJZFA86yNJloFRcUtw08nd8vx2ZACcTUE4HdwCN/TEFkstnOKGnznnCXAg7NBosrIRmZqbDkhrImHvoml3pcBPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa4liii3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E4DC4CED1;
	Fri,  7 Mar 2025 23:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741390674;
	bh=ua0QgEy0dtgEEi4JLJEBT5g3dBO7iHT7Cgd7aa1B+Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xa4liii3Xc5XxFFQL/XL0QZzGnmQmkhiGfhADFOcOCnT1EjvZ1UHgXBePJR6QYXV3
	 vRSyXotvvUma0enW3P3Hz5UchElelf+MHveAv49uy8ZtnWSa7B2pTGGtQufFMNwOhu
	 S7JMWx9w41is4jaJncM6XbSpZHKDQHIRFNU/i3pmhHyAyEjFuh/ZXoyq5qzZALLoSF
	 2DKkZ24v6T2wlcVkoQeFyeHPdaq+MeUc8kAlwNRs/WpRBskBiUBzhyzGjRa8yJHX+2
	 VbAmbRdLKNgDsWHmQ1fDIwPNcxqQY1vUplr99mv3a4Q26RKQBzX8gpZ1jxKEs7stBY
	 2ld1PzjsN/poQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/4] PCI: dwc: Move cfg0 setup to dw_pcie_cfg0_setup()
Date: Fri,  7 Mar 2025 17:37:41 -0600
Message-Id: <20250307233744.440476-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307233744.440476-1-helgaas@kernel.org>
References: <20250307233744.440476-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Move pp->cfg0 setup to dw_pcie_cfg0_setup().  No functional change
intended.
---
 .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 1206b26bff3f..de2f2dcf5c40 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -418,22 +418,12 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
-int dw_pcie_host_init(struct dw_pcie_rp *pp)
+static int dw_pcie_cfg0_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
-	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
-	struct resource_entry *win;
-	struct pci_host_bridge *bridge;
 	struct resource *res;
-	int ret;
-
-	raw_spin_lock_init(&pp->lock);
-
-	ret = dw_pcie_get_resources(pci);
-	if (ret)
-		return ret;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (!res) {
@@ -448,6 +438,28 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (IS_ERR(pp->va_cfg0_base))
 		return PTR_ERR(pp->va_cfg0_base);
 
+	return 0;
+}
+
+int dw_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+	struct resource_entry *win;
+	struct pci_host_bridge *bridge;
+	int ret;
+
+	raw_spin_lock_init(&pp->lock);
+
+	ret = dw_pcie_get_resources(pci);
+	if (ret)
+		return ret;
+
+	ret = dw_pcie_cfg0_setup(pp);
+	if (ret)
+		return ret;
+
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
-- 
2.34.1


