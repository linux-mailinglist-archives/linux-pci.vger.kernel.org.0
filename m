Return-Path: <linux-pci+bounces-24641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C2EA6ED97
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28F13B09D1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3042254AF7;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVgKAnP6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179525487B;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898395; cv=none; b=E1zWLXWBLSgdhbE3M811YD7MPZa9tMhVCM0eua03we9ADiqz561tMsk0/AQ581zgXsCW/eBd+/tK7P2ly69QGO6iIH/oHA2HgVGS8KqKyH+exDbMTHjlsZzaTaxfPN4DCLuzq8w96hevDr75RIRrXHXtGcLNxCzmMEtSg//SPGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898395; c=relaxed/simple;
	bh=zGUc2WvnYPIRzvCp5NMj+Y73rWIsopTAR6HTlwhIfgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDdB9ENetTphNPkbxyVgIj3DbSxPzTpTsIiJiUFkD+2zL/l3fuH/VEzVLIYjzXKg8TCf8U+Go1TsXMJz3mG8gdQafr6l7faz1AYWVz5O2oMgnEmL4cpdAF4h+KgDOSUvVNSJWsegJKHo3u32DLW2Hp500L4K7iFMogxZLwQLGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVgKAnP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24742C4CEF1;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898395;
	bh=zGUc2WvnYPIRzvCp5NMj+Y73rWIsopTAR6HTlwhIfgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pVgKAnP6STdlwjgThZhygZXsyT5DOz0Gr7M3/npeDViBtaDUBKT0w//YXjwD39gO0
	 NEj3SW0aPwZn0shn8AsigfGE4My7dHT8SRNq/Fa4SmLfSJhMj4eMSvDM+BGBqOFz+W
	 MmUqCUvFOfBlyEpHrAczdgUxX/bwOWft2OA9+ciCUAOE+6A/lpxzYVUCjamvF+Z1sH
	 9W5cuC27Pv/GQCPxjUS470qsHb86ymmHUyLj7ttvAQyiT9JUP9QxT86746FvjOi593
	 Ag0+MN9AMnrkcjd4PfYzikV/cbVgKOM5TS9SBzP8OGoMue6rKRr0mWaa506AvDnPPt
	 IcRpMaJCAwlnQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tx1UP-00GsRS-32;
	Tue, 25 Mar 2025 10:26:33 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH v2 04/13] PCI: apple: Move over to standalone probing
Date: Tue, 25 Mar 2025 10:26:01 +0000
Message-Id: <20250325102610.2073863-5-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250325102610.2073863-1-maz@kernel.org>
References: <20250325102610.2073863-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Now that we have the required infrastructure, split the Apple PCIe
setup into two categories:

- stuff that has to do with PCI setup stays in the .init() callback

- stuff that is just driver gunk (such as MSI setup) goes into a
  probe routine, which will eventually call into the host-common
  code

The result is a far more logical setup process.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 54 ++++++++++++++++-------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index a7e51bc1c2fe8..9c3103d0d1174 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -730,35 +730,15 @@ static void apple_pcie_disable_device(struct pci_host_bridge *bridge, struct pci
 
 static int apple_pcie_init(struct pci_config_window *cfg)
 {
+	struct apple_pcie *pcie = cfg->priv;
 	struct device *dev = cfg->parent;
-	struct platform_device *platform = to_platform_device(dev);
 	struct device_node *of_port;
-	struct apple_pcie *pcie;
 	int ret;
 
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
-		return -ENOMEM;
-
-	pcie->dev = dev;
-
-	mutex_init(&pcie->lock);
-
-	pcie->base = devm_platform_ioremap_resource(platform, 1);
-	if (IS_ERR(pcie->base))
-		return PTR_ERR(pcie->base);
-
-	cfg->priv = pcie;
-	INIT_LIST_HEAD(&pcie->ports);
-
-	ret = apple_msi_init(pcie);
-	if (ret)
-		return ret;
-
 	for_each_child_of_node(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
-			dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);
+			dev_err(dev, "Port %pOF setup fail: %d\n", of_port, ret);
 			of_node_put(of_port);
 			return ret;
 		}
@@ -778,14 +758,40 @@ static const struct pci_ecam_ops apple_pcie_cfg_ecam_ops = {
 	}
 };
 
+static int apple_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct apple_pcie *pcie;
+	int ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->dev = dev;
+	pcie->base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(pcie->base))
+		return PTR_ERR(pcie->base);
+
+	mutex_init(&pcie->lock);
+	INIT_LIST_HEAD(&pcie->ports);
+	dev_set_drvdata(dev, pcie);
+
+	ret = apple_msi_init(pcie);
+	if (ret)
+		return ret;
+
+	return pci_host_common_init(pdev, &apple_pcie_cfg_ecam_ops);
+}
+
 static const struct of_device_id apple_pcie_of_match[] = {
-	{ .compatible = "apple,pcie", .data = &apple_pcie_cfg_ecam_ops },
+	{ .compatible = "apple,pcie" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, apple_pcie_of_match);
 
 static struct platform_driver apple_pcie_driver = {
-	.probe	= pci_host_common_probe,
+	.probe	= apple_pcie_probe,
 	.driver	= {
 		.name			= "pcie-apple",
 		.of_match_table		= apple_pcie_of_match,
-- 
2.39.2


