Return-Path: <linux-pci+bounces-14713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 581E39A1840
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D541C202C9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A32D057;
	Thu, 17 Oct 2024 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrIqEtrY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5122087;
	Thu, 17 Oct 2024 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130350; cv=none; b=Ib9FhXxOnLfdUd+ACrRPGoI+GViULu7LqMfoEDgrrqlF4Pg5MGKg8p0fG2+YqyyrZWNfxjEDRNA52zBukqiYAhSsVWO2VyuSDXyBQLr4P6c9EJfSHqlCSUt6W2xsMn59R2NV0tJM5mvqaJYu0I8VhBvnVtNOapGCYSDgWuFQnsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130350; c=relaxed/simple;
	bh=NZPcvMNuuYIfcbG2joADk3VepWG0efvQX25DV7OprLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCxDPWAfR+7pBhLtVo2OcDBMbwEZEUmv93GCS0f6dwLCHBJYlzUh/hXYx3ZSxdi1Jy6t/NhKMzMv+50j4GRX+KUxEWH667dlLvWqPvT0A0r6AhwVjF7xAhDxoc12GeqM2vdA1ln2Fe6/g5omtTc97+2qwe2m7Y1VK8xJIwl0Hk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrIqEtrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AE4C4CED0;
	Thu, 17 Oct 2024 01:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130350;
	bh=NZPcvMNuuYIfcbG2joADk3VepWG0efvQX25DV7OprLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DrIqEtrYYKnQOh1Uw67nKZkEKJJuRVDxS4YgoykA3+sQi6CjPhbhk6C1OpGBHyEMV
	 Kri7DLYD+oXyTKmtw0//BwGa0NOC6pnkW8LWTbH2hBYKxZcU3e4V/phXQDc/Zs/Mw+
	 DIR2abGpt7cDbmtPOYkP52OHOBUpd3Q+JYLPLRSzyBWM+kLPCHbbB03DjUxD3TpHN8
	 lPI/C113nXclSFHgpUx+4kOEOjIk7SfOBwW2i0zD3LXY0Rv0MhjR5YbgB+eFiu4IET
	 8gT/phqnMEz/4SOJMdgsm3N9rrxWxLLxtF24ZYRdyydKXorvE2s9pvhrLm5r3dorcz
	 xo+pdCESm8QeQ==
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
Subject: [PATCH v5 09/14] PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSI-X hiding
Date: Thu, 17 Oct 2024 10:58:44 +0900
Message-ID: <20241017015849.190271-10-dlemoal@kernel.org>
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

Move the code in rockchip_pcie_ep_probe() to hide the MSI-X capability
to its own function, rockchip_pcie_ep_hide_broken_msix_cap().
No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 54 +++++++++++++----------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 8dd2a812e446..d980e0b92745 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -582,6 +582,34 @@ static void rockchip_pcie_ep_exit_ob_mem(struct rockchip_pcie_ep *ep)
 	pci_epc_mem_exit(ep->epc);
 }
 
+static void rockchip_pcie_ep_hide_broken_msix_cap(struct rockchip_pcie *rockchip)
+{
+	u32 cfg_msi, cfg_msix_cp;
+
+	/*
+	 * MSI-X is not supported but the controller still advertises the MSI-X
+	 * capability by default, which can lead to the Root Complex side
+	 * allocating MSI-X vectors which cannot be used. Avoid this by skipping
+	 * the MSI-X capability entry in the PCIe capabilities linked-list: get
+	 * the next pointer from the MSI-X entry and set that in the MSI
+	 * capability entry (which is the previous entry). This way the MSI-X
+	 * entry is skipped (left out of the linked-list) and not advertised.
+	 */
+	cfg_msi = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
+				     ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
+
+	cfg_msi &= ~ROCKCHIP_PCIE_EP_MSI_CP1_MASK;
+
+	cfg_msix_cp = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
+					 ROCKCHIP_PCIE_EP_MSIX_CAP_REG) &
+					 ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK;
+
+	cfg_msi |= cfg_msix_cp;
+
+	rockchip_pcie_write(rockchip, cfg_msi,
+			    PCIE_EP_CONFIG_BASE + ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
+}
+
 static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -589,7 +617,6 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	struct rockchip_pcie *rockchip;
 	struct pci_epc *epc;
 	int err;
-	u32 cfg_msi, cfg_msix_cp;
 
 	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
 	if (!ep)
@@ -624,6 +651,8 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	if (err)
 		goto err_disable_clocks;
 
+	rockchip_pcie_ep_hide_broken_msix_cap(rockchip);
+
 	/* Establish the link automatically */
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
@@ -631,29 +660,6 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	/* Only enable function 0 by default */
 	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
 
-	/*
-	 * MSI-X is not supported but the controller still advertises the MSI-X
-	 * capability by default, which can lead to the Root Complex side
-	 * allocating MSI-X vectors which cannot be used. Avoid this by skipping
-	 * the MSI-X capability entry in the PCIe capabilities linked-list: get
-	 * the next pointer from the MSI-X entry and set that in the MSI
-	 * capability entry (which is the previous entry). This way the MSI-X
-	 * entry is skipped (left out of the linked-list) and not advertised.
-	 */
-	cfg_msi = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
-				     ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
-
-	cfg_msi &= ~ROCKCHIP_PCIE_EP_MSI_CP1_MASK;
-
-	cfg_msix_cp = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
-					 ROCKCHIP_PCIE_EP_MSIX_CAP_REG) &
-					 ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK;
-
-	cfg_msi |= cfg_msix_cp;
-
-	rockchip_pcie_write(rockchip, cfg_msi,
-			    PCIE_EP_CONFIG_BASE + ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
-
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
-- 
2.47.0


