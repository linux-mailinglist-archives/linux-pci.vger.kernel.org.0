Return-Path: <linux-pci+bounces-23857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2CCA63253
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7153B4C43
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A901C701C;
	Sat, 15 Mar 2025 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt74XQ34"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09781C6FFF;
	Sat, 15 Mar 2025 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742069762; cv=none; b=SuFtDxzcX81j5ZYMy7M860QOvxT/KIdRRa+4SDh2R3VW5qX6rQlASD8VcDWJfxmSJPn1Uiz82LWyA5dZfjrs+N3H/TRZt8cXSWG3ywPomq/w8O6sG8mDoQi9+MVpiXtpMrv1DCwzPiQM74Mu6D1mSWqCLgbkeGtImqnwFXIDdQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742069762; c=relaxed/simple;
	bh=CpTQVdmtXh0uTx65c9F5PQoTrjYzcny7+9eiEMKtE/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NMVM5aLTSKMOYm0W0KC9xZuvLKd0kAEic3AgyF2ggMnp4dY2AkIMhFL99SuJYc6iZrwq59KlXI/g8gOhSFSxy9+JzP1epY2s7XH55t0KRDrgWU5FFzBy4NVrx+3BFaOv4bPAib7qq9JUWODabefTKntl6DkwqyF7qOGkICfbnYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt74XQ34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143E7C113CF;
	Sat, 15 Mar 2025 20:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742069762;
	bh=CpTQVdmtXh0uTx65c9F5PQoTrjYzcny7+9eiEMKtE/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rt74XQ34r5n1G30d4C5QLmhvGYhqtsM5ePEZ58Oc4IqMG9sBy9XR8xvhB8JcyOjzb
	 kuxktKG3tnl8vCzlYIIjkwdBz1D66shG3pZmj7Lxcwd3KjQMyNXj0lDLrejzRsV2eD
	 0TAFR6cNwPiLRU3rJKifXVEVbg42FzVxZAVTUYFvUKe1wx2EclDyrxx0v5hoTVONv5
	 1QnpgTq19p3pc4IdJdCXz8R1mJzaB1bFTR34jN3Eq+vVCBzm4+EGOxgnvSIc/jrCVd
	 2frTdiiq9jDT3rkwNm+vllPK8LNZpKAI3mXivT9ixE7f2X2ndZMt8epfQ0RTL5287A
	 wY+Sc6Gzt07DQ==
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
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 04/13] PCI: dwc: Consolidate devicetree handling in dw_pcie_host_get_resources()
Date: Sat, 15 Mar 2025 15:15:39 -0500
Message-Id: <20250315201548.858189-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250315201548.858189-1-helgaas@kernel.org>
References: <20250315201548.858189-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Consolidate devicetree resource handling in dw_pcie_host_get_resources().
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 37 +++++++++++++------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 5636243fb90e..9ce06b1ee266 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -418,25 +418,15 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
-int dw_pcie_host_init(struct dw_pcie_rp *pp)
+static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
-	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource_entry *win;
-	struct pci_host_bridge *bridge;
 	struct resource *res;
 	int ret;
 
-	raw_spin_lock_init(&pp->lock);
-
-	bridge = devm_pci_alloc_host_bridge(dev, 0);
-	if (!bridge)
-		return -ENOMEM;
-
-	pp->bridge = bridge;
-
 	ret = dw_pcie_get_resources(pci);
 	if (ret)
 		return ret;
@@ -455,13 +445,36 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		return PTR_ERR(pp->va_cfg0_base);
 
 	/* Get the I/O range from DT */
-	win = resource_list_first_type(&bridge->windows, IORESOURCE_IO);
+	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_IO);
 	if (win) {
 		pp->io_size = resource_size(win->res);
 		pp->io_bus_addr = win->res->start - win->offset;
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
+	return 0;
+}
+
+int dw_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+	struct pci_host_bridge *bridge;
+	int ret;
+
+	raw_spin_lock_init(&pp->lock);
+
+	bridge = devm_pci_alloc_host_bridge(dev, 0);
+	if (!bridge)
+		return -ENOMEM;
+
+	pp->bridge = bridge;
+
+	ret = dw_pcie_host_get_resources(pp);
+	if (ret)
+		return ret;
+
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
 	bridge->child_ops = &dw_child_pcie_ops;
-- 
2.34.1


