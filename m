Return-Path: <linux-pci+bounces-5445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F579892954
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 05:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3572836D5
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 04:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC89881F;
	Sat, 30 Mar 2024 04:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho9P7M3B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF78BFA;
	Sat, 30 Mar 2024 04:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711772412; cv=none; b=KpUKtS94lo9+Dk1vUDrYOgIlYMJyISVeRK/rdBZR81OdUBEYVLc1xvZTGwXH/U+YMukk6VOjw7VTXqlHJmb40ds5HRiP8IXOnQscZfCiD6wPn3OWjaJjbIOi13OkwbVCplVO6/2fgN/UIjdvOaKKe1mlTyh6f7flx1Iz42MvWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711772412; c=relaxed/simple;
	bh=HPoVVjcVe6HIOPN/k8oM/fkWmZU5+6y/P1eSH7nj+qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUzcVAa6VNHb1NiiYNj9KXjU5B43TP2P3GV76RtoaFE9gpk+ILpErkbDtisyXeXumgusHe2soWfuUWgcMV74FYhUh+d27ZxCAAOUif4LkBhijymqa4Ok86lIQoX7oD7+jhhrdfcMwRLNp79iRMrSetUMhkSpyOsa+jMG2F+dFjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ho9P7M3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3C4C43601;
	Sat, 30 Mar 2024 04:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711772412;
	bh=HPoVVjcVe6HIOPN/k8oM/fkWmZU5+6y/P1eSH7nj+qE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ho9P7M3BXucw3ZE+1SB8u6uuIupk7Hl9KZIANwe958z2nPmtKzua0S08ZXn21l8qM
	 8IxFUT36raIbQim6C3TTW5XjCGyBQROhZhdw8cz42lvMVO3WKcwov2LUaXX1Yt2ZMF
	 8Z5dNTP9sZAUy9Y3o9AjoUi7g4T/7NRU/f7VxQ0BruAxfxuz2UiLOBBbaG5TRwTyd+
	 BDfswS8T4myiIcwiCKWir2qVlDC5qVeYFDLZQk4YLb4sFzzOymbOWP6ips9UScbAwl
	 sOBXHAeIM9QkE0vyzEX6KO7DM2V3whj9SHgjF03Y02ptC3XaVEWLA4+Cg50y1vs4hr
	 LQ5jiTEHR4/Pw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 13/18] PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSI-X hiding
Date: Sat, 30 Mar 2024 13:19:23 +0900
Message-ID: <20240330041928.1555578-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330041928.1555578-1-dlemoal@kernel.org>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the code in rockchip_pcie_ep_probe() to hide the MSI-X capability
to its own function, rockchip_pcie_ep_hide_msix_cap(). No functional
changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 54 +++++++++++++----------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 17d9fe48c621..a7d008d95a8a 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -583,6 +583,34 @@ static void rockchip_pcie_ep_release_resources(struct rockchip_pcie_ep *ep)
 	pci_epc_mem_exit(ep->epc);
 }
 
+static void rockchip_pcie_ep_hide_msix_cap(struct rockchip_pcie *rockchip)
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
@@ -590,7 +618,6 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	struct rockchip_pcie *rockchip;
 	struct pci_epc *epc;
 	int err;
-	u32 cfg_msi, cfg_msix_cp;
 
 	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
 	if (!ep)
@@ -621,6 +648,8 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	if (err)
 		goto err_disable_clocks;
 
+	rockchip_pcie_ep_hide_msix_cap(rockchip);
+
 	/* Establish the link automatically */
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
@@ -628,29 +657,6 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
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
2.44.0


