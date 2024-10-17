Return-Path: <linux-pci+bounces-14712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1C69A1841
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212D2B2229F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2E2B9B9;
	Thu, 17 Oct 2024 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vft2HIxT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56222087;
	Thu, 17 Oct 2024 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130348; cv=none; b=Q1WxW0/0cV22vPaYxfRRigAbUt1IMT3SaFQ7noOLAqHZ4INcW6RhnVWrPjE8/d5AdQvbsEUZFtts8Ejd56plYdLt+HJUgWy+S4M0DorxQp4kOiPALZkKIJuIn4PpL718JHequGxUyL+aUhWK8ili4H6fU4Q7kBe7b2ABpsfYrEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130348; c=relaxed/simple;
	bh=TZTC/UN+ioxo8kHC1srfQQYjsUIYfU7EFjfKzLP8H9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pmkx9r5V6hQva2x27hXf5ROXJBJetKMLMH3/pdi06zrKvsm2R5OcqqYO7vKqDx97exLFc5u5CjTVzUqvU6XXHikYsTEUc1gPYAwEJB+rKcH+ZgUdQ/NqY03f+QbEMfYsc+lAAOaqPMXYYMl39Bklrzfe/hFOsKdRfd3I1jRc+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vft2HIxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FACBC4CECF;
	Thu, 17 Oct 2024 01:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130348;
	bh=TZTC/UN+ioxo8kHC1srfQQYjsUIYfU7EFjfKzLP8H9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vft2HIxTJdPc5yRYN1H9fBOSThk3i5v6HXmTjF/BnwyJgiGCPEjFqLMJtL2LHL94U
	 MlpR20RFwrRvQX301EZ43p3XkAezdJH+fKMfgPKUXINvg0UY388Fd/OzBGDP/8ZPpr
	 3NLa5a3VgEM8hABxSX3lpZMl965vFDNOKO9+ogni1pE3jelgp822UZXn4QHw6vAOmH
	 5PfWOnXoM15MxDkrDpLZ1B2mk7Z9Fyp2zC09ylbP7ygFd3klLKhydLG1MSY76U2Xne
	 QUruNdnTxx2ZKF1KKPtfESUobk6sLUTuOZADrJ0/8Y/FSV/WVq9XEq6uUX3+BOOXxL
	 C/yK5Cx1CZTGQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 08/14] PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
Date: Thu, 17 Oct 2024 10:58:43 +0900
Message-ID: <20241017015849.190271-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017015849.190271-1-dlemoal@kernel.org>
References: <20241017015849.190271-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function rockchip_pcie_ep_init_ob_mem()
allocate the outbound memory regions and memory needed for IRQ handling.

These changes tidy up rockchip_pcie_ep_probe(). No functional change.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 107 ++++++++++++----------
 1 file changed, 61 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 705f6741fa53..8dd2a812e446 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -529,15 +529,66 @@ static const struct of_device_id rockchip_pcie_ep_of_match[] = {
 	{},
 };
 
+static int rockchip_pcie_ep_init_ob_mem(struct rockchip_pcie_ep *ep)
+{
+	struct rockchip_pcie *rockchip = &ep->rockchip;
+	struct device *dev = rockchip->dev;
+	struct pci_epc_mem_window *windows = NULL;
+	int err, i;
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
+static void rockchip_pcie_ep_exit_ob_mem(struct rockchip_pcie_ep *ep)
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
@@ -561,10 +612,14 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	err = rockchip_pcie_enable_clocks(rockchip);
+	err = rockchip_pcie_ep_init_ob_mem(ep);
 	if (err)
 		return err;
 
+	err = rockchip_pcie_enable_clocks(rockchip);
+	if (err)
+		goto err_exit_ob_mem;
+
 	err = rockchip_pcie_init_port(rockchip);
 	if (err)
 		goto err_disable_clocks;
@@ -573,47 +628,9 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
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
@@ -643,10 +660,8 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	pci_epc_init_notify(epc);
 
 	return 0;
-err_epc_mem_exit:
-	pci_epc_mem_exit(epc);
-err_uninit_port:
-	rockchip_pcie_deinit_phys(rockchip);
+err_exit_ob_mem:
+	rockchip_pcie_ep_exit_ob_mem(ep);
 err_disable_clocks:
 	rockchip_pcie_disable_clocks(rockchip);
 	return err;
-- 
2.47.0


