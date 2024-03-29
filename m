Return-Path: <linux-pci+bounces-5387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB3D891575
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A347F1C223E6
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA0139AF9;
	Fri, 29 Mar 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZniPOvFS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2937165
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703408; cv=none; b=ip1MQr31jTPkacPwB7hBoeBrkJkKDmRZZR0CJV75ZGunm3Hh4MrcrqoLBVtzhrvm1PYJhjBy+HPgl7VRBYVzNR/teopODQuQBcmOSifpbjSNBk3hwoeo/m0gCsSnE/9z4STMhwGLg2lOQJjAvxsjo2CrBSqaTITcXm7pTgeM8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703408; c=relaxed/simple;
	bh=KGfRIg4cyD9K+XEZfIeN75bZ9A1MHBRzIMLdsYfvYAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUxSTMVe7CRJmBfWyshC5BoMYjcWFDMrK8p5MasQLeMZbJpdxphAtpKUZ2qotRY4SaRuKRE/1/HhCZQ+lY0K/Q2ZCURyFGSxte3HVRCVJXQvn+cCQO0803389yfshDqHPFP0lVbzJjZXZg0Mnf3Vbn8OnfbnDuQAUyX/la8yobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZniPOvFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CCDC433C7;
	Fri, 29 Mar 2024 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703407;
	bh=KGfRIg4cyD9K+XEZfIeN75bZ9A1MHBRzIMLdsYfvYAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZniPOvFSN9t6MvBrMlAKYz+qeTGOdeRk/9fgQAZ3T9KyxHIMpUNM7G4YjDbTg/p8r
	 T5I/rM4mcxJ6SLG1D6+zGxjprrFtyJZrrasU/Aaa5wy8OYjeUoyJiHz0zCLuMa6HIy
	 NsHGwe6kawv7/9WY6RRpsxOz/soQWqhz/W1VJOQMY+tasuzgl0DzpxUqZ0/LG/Dptg
	 phFMt2wUiCwCzFRsTMnmyJOT1nuVvzDh90SRbIP+5vDa8cq1klmsuXjTV61ZfNu+XB
	 7MmrPfxIfSA7CrW8nUk/m0asdbmGw9Gu0WYloA0VaOmLhfQ0fX9bXqwlpIE0H6CwBy
	 tckIT9INqNV8A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 13/19] PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
Date: Fri, 29 Mar 2024 18:09:39 +0900
Message-ID: <20240329090945.1097609-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329090945.1097609-1-dlemoal@kernel.org>
References: <20240329090945.1097609-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function rockchip_pcie_ep_get_resources() to parse the DT
node of a rockchip PCIe endpoint controller and allocate the outbound
memory region and memory needed for IRQ handling. This function tidies
up rockchip_pcie_ep_probe(). No functional change.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 109 ++++++++++++----------
 1 file changed, 62 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 223132acc787..c3c132733bd7 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -526,15 +526,70 @@ static const struct of_device_id rockchip_pcie_ep_of_match[] = {
 	{},
 };
 
+static int rockchip_pcie_ep_get_resources(struct rockchip_pcie_ep *ep)
+{
+	struct rockchip_pcie *rockchip = &ep->rockchip;
+	struct device *dev = rockchip->dev;
+	struct pci_epc_mem_window *windows = NULL;
+	int err, i;
+
+	err = rockchip_pcie_parse_ep_dt(rockchip, ep);
+	if (err)
+		return err;
+
+	ep->ob_addr = devm_kcalloc(dev, ep->max_regions, sizeof(*ep->ob_addr),
+				   GFP_KERNEL);
+
+	if (!ep->ob_addr)
+		return -ENOMEM;
+
+	windows = devm_kcalloc(dev, ep->max_regions,
+			       sizeof(struct pci_epc_mem_window), GFP_KERNEL);
+	if (!windows)
+		return -ENOMEM;
+
+	for (i = 0; i < ep->max_regions; i++) {
+		windows[i].phys_base = rockchip->mem_res->start + (SZ_1M * i);
+		windows[i].size = SZ_1M;
+		windows[i].page_size = SZ_1M;
+	}
+	err = pci_epc_multi_mem_init(ep->epc, windows, ep->max_regions);
+	devm_kfree(dev, windows);
+
+	if (err < 0) {
+		dev_err(dev, "failed to initialize the memory space\n");
+		return err;
+	}
+
+	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(ep->epc, &ep->irq_phys_addr,
+						  SZ_1M);
+	if (!ep->irq_cpu_addr) {
+		dev_err(dev, "failed to reserve memory space for MSI\n");
+		goto err_epc_mem_exit;
+	}
+
+	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
+
+	return 0;
+
+err_epc_mem_exit:
+	pci_epc_mem_exit(ep->epc);
+
+	return err;
+}
+
+static void rockchip_pcie_ep_release_resources(struct rockchip_pcie_ep *ep)
+{
+	pci_epc_mem_exit(ep->epc);
+}
+
 static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rockchip_pcie_ep *ep;
 	struct rockchip_pcie *rockchip;
 	struct pci_epc *epc;
-	size_t max_regions;
-	struct pci_epc_mem_window *windows = NULL;
-	int err, i;
+	int err;
 	u32 cfg_msi, cfg_msix_cp;
 
 	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
@@ -554,13 +609,13 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	ep->epc = epc;
 	epc_set_drvdata(epc, ep);
 
-	err = rockchip_pcie_parse_ep_dt(rockchip, ep);
+	err = rockchip_pcie_ep_get_resources(ep);
 	if (err)
 		return err;
 
 	err = rockchip_pcie_enable_clocks(rockchip);
 	if (err)
-		return err;
+		goto err_release_resources;
 
 	err = rockchip_pcie_init_port(rockchip);
 	if (err)
@@ -570,47 +625,9 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
-	max_regions = ep->max_regions;
-	ep->ob_addr = devm_kcalloc(dev, max_regions, sizeof(*ep->ob_addr),
-				   GFP_KERNEL);
-
-	if (!ep->ob_addr) {
-		err = -ENOMEM;
-		goto err_uninit_port;
-	}
-
 	/* Only enable function 0 by default */
 	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
 
-	windows = devm_kcalloc(dev, ep->max_regions,
-			       sizeof(struct pci_epc_mem_window), GFP_KERNEL);
-	if (!windows) {
-		err = -ENOMEM;
-		goto err_uninit_port;
-	}
-	for (i = 0; i < ep->max_regions; i++) {
-		windows[i].phys_base = rockchip->mem_res->start + (SZ_1M * i);
-		windows[i].size = SZ_1M;
-		windows[i].page_size = SZ_1M;
-	}
-	err = pci_epc_multi_mem_init(epc, windows, ep->max_regions);
-	devm_kfree(dev, windows);
-
-	if (err < 0) {
-		dev_err(dev, "failed to initialize the memory space\n");
-		goto err_uninit_port;
-	}
-
-	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
-						  SZ_1M);
-	if (!ep->irq_cpu_addr) {
-		dev_err(dev, "failed to reserve memory space for MSI\n");
-		err = -ENOMEM;
-		goto err_epc_mem_exit;
-	}
-
-	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
-
 	/*
 	 * MSI-X is not supported but the controller still advertises the MSI-X
 	 * capability by default, which can lead to the Root Complex side
@@ -638,10 +655,8 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 			    PCIE_CLIENT_CONFIG);
 
 	return 0;
-err_epc_mem_exit:
-	pci_epc_mem_exit(epc);
-err_uninit_port:
-	rockchip_pcie_deinit_phys(rockchip);
+err_release_resources:
+	rockchip_pcie_ep_release_resources(ep);
 err_disable_clocks:
 	rockchip_pcie_disable_clocks(rockchip);
 	return err;
-- 
2.44.0


