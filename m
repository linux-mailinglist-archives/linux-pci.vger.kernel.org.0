Return-Path: <linux-pci+bounces-23861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DF3A63264
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1E13A4678
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 20:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4B1A238F;
	Sat, 15 Mar 2025 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDiS+o2V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80BB205517;
	Sat, 15 Mar 2025 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742069769; cv=none; b=mSIDm1IV6QK0iFvec1f3bvqpWmgCO11S0Lt0d9ESh5x4HNHhCuwxBv5lA51L2wBjyskcZ+oZ+FPAk1LXHCjbrPbbuPNcHXSa39sF0mffrHlW4bR831Chlf7fbGgFxuuFeuuZJu13NH/d/yTrCP26q2I8vJ2JETnOMTFw+UxGzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742069769; c=relaxed/simple;
	bh=yxt53pJS4LPQZZrMvULyJRtF3Mxw2qD3s3q527wIweA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQKLoo7HHk+qPOxkKWhdEMeqL+ZFIuM/EkvRVlr4F3x53VrGLnl0Tulh2SWJSvgyX4YwUlv/DoCe7LIWhK0e9YONyPE+I7hYM9IVZsFcm4sUqprHQ5Ciauhy/smuhSOPtOWNCb8si6Rq7k2ZWFYUQ2jDsLr1frVnwGTe6sTdwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDiS+o2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EC9C4CEE5;
	Sat, 15 Mar 2025 20:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742069768;
	bh=yxt53pJS4LPQZZrMvULyJRtF3Mxw2qD3s3q527wIweA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDiS+o2VA6dvEjyUCWHUgJVtTZMxCiJKSKIs555J67zRmOwxkO0/8fjNv5SMBxRln
	 8c/kNjeX14+Hqn2cR4gyXmMLUjvFg8IBYl0gXMrOvzVbPZFC/pDgtbyfG9pqCNon6g
	 FaKmNSX2C61vK0my7c1zdlyA6JmGs/LEIxnvaCSjbBQDNPNMHJs3EZnuNA8o3U9L+z
	 oSoBsRKwmkj+V7Pt+OCNmX0+YeCM2hcgre0jmek/ZdBGjVAsnPbabT8itNnfYmfDGY
	 0Cv0SY8DIqJ5r9dsAAbPDOedItN3LY5ULYon8ODOCmTuxBy8DaJ/jiMYPgzUTEy4Fj
	 iaJqOSOY/FT8w==
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
Subject: [PATCH v12 08/13] PCI: dwc: ep: Call epc_create() early in dw_pcie_ep_init()
Date: Sat, 15 Mar 2025 15:15:43 -0500
Message-Id: <20250315201548.858189-9-helgaas@kernel.org>
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

Move devm_pci_epc_create() to the beginning of dw_pcie_ep_init().

devm_pci_epc_create() is generic code that doesn't depend on any DWC
resource, so moving it earlier keeps all the subsequent devicetree-related
code together.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 80ac2f9e88eb..100d26466f05 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -904,6 +904,15 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	INIT_LIST_HEAD(&ep->func_list);
 
+	epc = devm_pci_epc_create(dev, &epc_ops);
+	if (IS_ERR(epc)) {
+		dev_err(dev, "Failed to create epc device\n");
+		return PTR_ERR(epc);
+	}
+
+	ep->epc = epc;
+	epc_set_drvdata(epc, ep);
+
 	ret = dw_pcie_get_resources(pci);
 	if (ret)
 		return ret;
@@ -918,15 +927,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ep->ops->pre_init)
 		ep->ops->pre_init(ep);
 
-	epc = devm_pci_epc_create(dev, &epc_ops);
-	if (IS_ERR(epc)) {
-		dev_err(dev, "Failed to create epc device\n");
-		return PTR_ERR(epc);
-	}
-
-	ep->epc = epc;
-	epc_set_drvdata(epc, ep);
-
 	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
 	if (ret < 0)
 		epc->max_functions = 1;
-- 
2.34.1


