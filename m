Return-Path: <linux-pci+bounces-7129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956D8BD252
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 18:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B311F22C82
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 16:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F421157486;
	Mon,  6 May 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="beKg6+up"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB1E15664D
	for <linux-pci@vger.kernel.org>; Mon,  6 May 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012139; cv=none; b=dmkDnxw+MZcgiil01ddXnkeaEOzgIbYF/0Z9+VlIxclB7KpUYT7MxmcGEMcO4xTLT7rJz5qEcT5eUraMXkSIUHw4ZGZx5CzGKUnuHl+w/9x35L0RIx1g8vIsDfJobPHnqKr6tPkIGlSfTZkTzLz4dAVg7fbU9JvoF+hieTH10YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012139; c=relaxed/simple;
	bh=zUjxErAfNxsRNkAthkqFDhI6NogrjhKQNib6awNIKNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dj66hCtnFzm+ub4ys3xJfJ+62l3jF70Ymc9qfFdPv9cIGEBL2WkKqRZef6QUZSMhKzJsB0oFt8zsj4P3fXlU3/XhjMdzC9ggHCaP2Fz5HlDHAtXCEX3lRRIOUBc9n9Hps9ZB5XtYxIeOlfI4LUlNMuvLh9INVA7VGsA0lZWKhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=beKg6+up; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715012136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtlPUzut99fgqzwIOlVSGdtokjNewldmjFQ9baMdh6A=;
	b=beKg6+up+zeyc8oCa+O2DfND2aDcOLe9OAGt/ipw2zvOqryyv9MZuXQ1PWKJEshAbUcNQk
	9mz4D8Rl9/1ZBN38EBGquhMW0CZ9uI579Lcj1QEc1QGjp9bNJMgigGh3ZUUZTIVugu0ivX
	fQI57+BYBLoTFKdl82MjJYMmUk8lKkY=
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 5/7] PCI: xilinx-nwl: Clean up clock on probe failure/removal
Date: Mon,  6 May 2024 12:15:08 -0400
Message-Id: <20240506161510.2841755-6-sean.anderson@linux.dev>
In-Reply-To: <20240506161510.2841755-1-sean.anderson@linux.dev>
References: <20240506161510.2841755-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Make sure we turn off the clock on probe failure and device removal.

Fixes: de0a01f52966 ("PCI: xilinx-nwl: Enable the clock through CCF")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 drivers/pci/controller/pcie-xilinx-nwl.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index c0a60cebdb2e..424cc5a1b4d1 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -779,6 +779,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	pcie = pci_host_bridge_priv(bridge);
+	platform_set_drvdata(pdev, pcie);
 
 	pcie->dev = dev;
 
@@ -801,13 +802,13 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	err = nwl_pcie_bridge_init(pcie);
 	if (err) {
 		dev_err(dev, "HW Initialization failed\n");
-		return err;
+		goto err_clk;
 	}
 
 	err = nwl_pcie_init_irq_domain(pcie);
 	if (err) {
 		dev_err(dev, "Failed creating IRQ Domain\n");
-		return err;
+		goto err_clk;
 	}
 
 	bridge->sysdata = pcie;
@@ -817,11 +818,23 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		err = nwl_pcie_enable_msi(pcie);
 		if (err < 0) {
 			dev_err(dev, "failed to enable MSI support: %d\n", err);
-			return err;
+			goto err_clk;
 		}
 	}
 
-	return pci_host_probe(bridge);
+	err = pci_host_probe(bridge);
+
+err_clk:
+	if (err)
+		clk_disable_unprepare(pcie->clk);
+	return err;
+}
+
+static void nwl_pcie_remove(struct platform_device *pdev)
+{
+	struct nwl_pcie *pcie = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(pcie->clk);
 }
 
 static struct platform_driver nwl_pcie_driver = {
@@ -831,5 +844,6 @@ static struct platform_driver nwl_pcie_driver = {
 		.of_match_table = nwl_pcie_of_match,
 	},
 	.probe = nwl_pcie_probe,
+	.remove_new = nwl_pcie_remove,
 };
 builtin_platform_driver(nwl_pcie_driver);
-- 
2.35.1.1320.gc452695387.dirty


