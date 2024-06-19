Return-Path: <linux-pci+bounces-8965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0AD90E819
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 12:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014531F21DC8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 10:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050CA12D1E7;
	Wed, 19 Jun 2024 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O6dYELlR"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950567F499;
	Wed, 19 Jun 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792136; cv=none; b=ZxN/9NvMXrglJUXqH3JWCzesd1S4gllvS3dX9tcHNioV0o9Ct3tOBXJx7OGx0rXttGjvd550NhGNBPxRzlBo6c+tToAlFe+mehJJ6LZXWL7OegMH8KOJLLs+mqghTx2TSuTaHKrsTMtJ80Qqu3SjyBOhs1g+ZEK5af+31pfpQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792136; c=relaxed/simple;
	bh=Hi7CNJIos7Z9zyfmhn8gv5F7wudXu7ivCs1VjXQ08h0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nruTbjiGQTarQzBAiRetOA+fZiN5qX2I+GNUjq3HBD9t0QBdlZ9q+11Iz7B9QKXSIBuPK/oYYaWWwbkrYEfY46BNV4geufxuT29s6Wd15PwsdaiART1NY/vPvlb8B4s2QjYBjO8O5vO/IALvyAsh05b/iUf3fFTnUS5/c0dPOA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O6dYELlR; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E696CE000E;
	Wed, 19 Jun 2024 10:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718792127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJFPWxXw72vNyH+gQgC1DthvjYV6wnk21OakN4I7AYs=;
	b=O6dYELlR2YwvpcvFq8Q8N4nEjBVQtgeiQQ3wBVPNyCXXl0ZvVZf1oVgDoZTWT+A/F8IqXy
	Eu39528qfpzzxtk1aTYpVRtCSPkbZ8UI3aXOrw+BBHDNV9G077cULmPDTcIVDySUZi3Gj7
	TQhNOSR/4o9j5KOwf7p0f/H1zrtn53MtPiuCU4ZP4Nh/RYcn8C7Hsa/avUNQQ9kS9tGxB7
	Nrr4i4bN1n4wu6H3eK/K/LS603V1bfri7wPZwfVXCzHu9TIFrbR8tIQuBza80w7HPnLbT1
	xyHDg2pohnYpCC0Mau0bfMfz0/KSiLkc6sSK5EO74irQO9pCR9GaMZUQ0QswVg==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Wed, 19 Jun 2024 12:15:11 +0200
Subject: [PATCH v7 3/7] PCI: j721e: Use dev_err_probe() in the probe()
 function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-j7200-pcie-s2r-v7-3-a2f9156da6c3@bootlin.com>
References: <20240102-j7200-pcie-s2r-v7-0-a2f9156da6c3@bootlin.com>
In-Reply-To: <20240102-j7200-pcie-s2r-v7-0-a2f9156da6c3@bootlin.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
 thomas.petazzoni@bootlin.com, u-kumar1@ti.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com

Use dev_err_probe() instead of dev_err() in the probe() function to
simplify the code and standardize the error output.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 85718246016b..98484f001562 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -482,20 +482,20 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
-		dev_err(dev, "pm_runtime_get_sync failed\n");
+		dev_err_probe(dev, ret, "pm_runtime_get_sync failed\n");
 		goto err_get_sync;
 	}
 
 	ret = j721e_pcie_ctrl_init(pcie);
 	if (ret < 0) {
-		dev_err(dev, "pm_runtime_get_sync failed\n");
+		dev_err_probe(dev, ret, "pm_runtime_get_sync failed\n");
 		goto err_get_sync;
 	}
 
 	ret = devm_request_irq(dev, irq, j721e_pcie_link_irq_handler, 0,
 			       "j721e-pcie-link-down-irq", pcie);
 	if (ret < 0) {
-		dev_err(dev, "failed to request link state IRQ %d\n", irq);
+		dev_err_probe(dev, ret, "failed to request link state IRQ %d\n", irq);
 		goto err_get_sync;
 	}
 
@@ -505,28 +505,25 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	case PCI_MODE_RC:
 		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 		if (IS_ERR(gpiod)) {
-			ret = PTR_ERR(gpiod);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Failed to get reset GPIO\n");
+			ret = dev_err_probe(dev, PTR_ERR(gpiod), "Failed to get reset GPIO\n");
 			goto err_get_sync;
 		}
 
 		ret = cdns_pcie_init_phy(dev, cdns_pcie);
 		if (ret) {
-			dev_err(dev, "Failed to init phy\n");
+			dev_err_probe(dev, ret, "Failed to init phy\n");
 			goto err_get_sync;
 		}
 
 		clk = devm_clk_get_optional(dev, "pcie_refclk");
 		if (IS_ERR(clk)) {
-			ret = PTR_ERR(clk);
-			dev_err(dev, "failed to get pcie_refclk\n");
+			ret = dev_err_probe(dev, PTR_ERR(clk), "failed to get pcie_refclk\n");
 			goto err_pcie_setup;
 		}
 
 		ret = clk_prepare_enable(clk);
 		if (ret) {
-			dev_err(dev, "failed to enable pcie_refclk\n");
+			dev_err_probe(dev, ret, "failed to enable pcie_refclk\n");
 			goto err_pcie_setup;
 		}
 		pcie->refclk = clk;
@@ -554,7 +551,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	case PCI_MODE_EP:
 		ret = cdns_pcie_init_phy(dev, cdns_pcie);
 		if (ret) {
-			dev_err(dev, "Failed to init phy\n");
+			dev_err_probe(dev, ret, "Failed to init phy\n");
 			goto err_get_sync;
 		}
 

-- 
2.39.2


