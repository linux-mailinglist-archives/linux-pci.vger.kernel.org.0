Return-Path: <linux-pci+bounces-25047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6015AA77770
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 11:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D39B188E930
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B381EF0B2;
	Tue,  1 Apr 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O00QXRY8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E71EF376;
	Tue,  1 Apr 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499058; cv=none; b=Vb3pyhO/2HuVXfZOYeqBnn/Lwtq9jHq0XVb59crWWNbdH57m26+PwOAMJ5flnmH/iFvepSqwdB1fz0xzbQ1XLpg1oLgK9F4ontSR3663+LCO0VD6RsUFVPeWhb/k2u6VHqBOpbGcxIPZ1tfZNI4n3Ne/mxsfFjBeN6V67xTvcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499058; c=relaxed/simple;
	bh=N1nHX41VAbTth+my1DnLmQ+I/I1nrU0WjhF/thdk4u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HdBB9geJsuMh3dmJ/30CdIQpEGBRCYTYIWDtq7k3EaIIr+nHL637TGSIUjtn8VvLvXqoenV67qb0vj9Uzrwvt57g05uy1ikF1ztOFf3OvUyN8DhixkUY4eqg73epPn6gWJSHGqCi7E/PgYtbVdiTi0UTnIFbJO7ehrAiE3gvbs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O00QXRY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB926C4AF0F;
	Tue,  1 Apr 2025 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743499058;
	bh=N1nHX41VAbTth+my1DnLmQ+I/I1nrU0WjhF/thdk4u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O00QXRY8MVm0JZtF5V6kXJXMMRx/23J4IuUzVJZQbK6AYebjCFP2zDqMMAFCK4XtP
	 M9YLj8XlQLsryVUY9a5vPqbNFO7CI0/1UD7vUFsba76mOstdeyjGdcGatsyDGeYOgD
	 8fZWPZAO9WoB+SitnFNWtOSP/tIA2va+/mjCfzkDgG/QdckIJekCzFbDFbHZO8735W
	 XTYMXUBFvOPKegHcjA1EC5caMKum+EZcEknVOcoGmdUD+zolB9bQioGjHK4ns/mB1Y
	 qRetlUpdMcJu3faZ1TJLtNe8TqAtqLub2O7DGtzxWnnLSt8ViHXBQNId4AyxxiyE3j
	 pDjSDLNK8xdlw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tzXkV-001GqU-Uf;
	Tue, 01 Apr 2025 10:17:36 +0100
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: [PATCH v3 05/13] PCI: apple: Move over to standalone probing
Date: Tue,  1 Apr 2025 10:17:05 +0100
Message-Id: <20250401091713.2765724-6-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250401091713.2765724-1-maz@kernel.org>
References: <20250401091713.2765724-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, mark.kettenis@xs4all.nl
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Now that we have the required infrastructure, split the Apple PCIe
setup into two categories:

- stuff that has to do with PCI setup stays in the .init() callback

- stuff that is just driver gunk (such as MSI setup) goes into a
  probe routine, which will eventually call into the host-common
  code

The result is a far more logical setup process.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Tested-by: Janne Grunau <j@jannau.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 54 ++++++++++++++++-------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 842f8cee7c868..d07e488051290 100644
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
 	for_each_available_child_of_node(dev->of_node, of_port) {
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


