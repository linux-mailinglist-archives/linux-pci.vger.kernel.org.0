Return-Path: <linux-pci+bounces-13918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA534992371
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63A6CB21E9A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96565D477;
	Mon,  7 Oct 2024 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpzGI8yo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F76358222;
	Mon,  7 Oct 2024 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274359; cv=none; b=fxYy+fYSeGb7KKjNvYI6Q0ltPrtBxqZaVQ7FjKpZJZ9H7zZxnTknWeFn9S0zfQD3psCa/uIkA1pzIyB7d+LOGk3Dbfd0PqlsG2wtCkVRRtMfMuUE/y95Vk67cexJ9pWsEM5sfVbQQ1dYw7pEJBVKbxHNenEYBW8a6Jlr8IaneEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274359; c=relaxed/simple;
	bh=fKsYpad1zguMtK/DfpCjZvBQjZDyg/qD7gNXQQtFa1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNnLI2kDTp33BxSnPnKCUOHjx6VRmsKr6ej8PodHpTxBxIDBhABJ18os8+rHLvsiO7cDjkNCqZuyqqEdyKhfAMMk50W++cfTOWjd2kWth012q/wleDvGhPSjSc3zOaPXxdNSQfCPMrHQ9Ho6yj226vWIDS2SCPU9rc8UC/2PuBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpzGI8yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC52CC4CED2;
	Mon,  7 Oct 2024 04:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728274359;
	bh=fKsYpad1zguMtK/DfpCjZvBQjZDyg/qD7gNXQQtFa1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JpzGI8yohiZntr6lfBNgRPxh77k3ANxGOcSoRp0xgh9ExHXgC08ZIa0vkWpgHJfDI
	 S79xZX4bDSTZuONlqkRNb7t4L/AEsTNYXRSXQTtKLieWQg9MadYnIxT43fzHvDe6XN
	 tKtcQRfiw21p/itA0sdgwrL8YJKFbz54wRkpvnwsb4bhfK75vwWrqTsoqLwcMajB/T
	 KF8eeA9O8Uyg3dCHKheJEHHz7FGL+gaynnxEd2jLO+Q8V0hHS6Qa4J6s/e5Q/t+2Kf
	 LLorDtATbrwdWcL6mcT1UaGhj03FdJ/up4QR8yusJgCWE/VYK2W/MJEqe1QBtDViMJ
	 fEagBXR+83Z4g==
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
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 08/12] PCI: rockchip-ep: Refactor endpoint link training enable
Date: Mon,  7 Oct 2024 13:12:14 +0900
Message-ID: <20241007041218.157516-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007041218.157516-1-dlemoal@kernel.org>
References: <20241007041218.157516-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rockchip_pcie_init_port() enables link training for a
controller configured in EP mode. Enabling link training is again done
in rockchip_pcie_ep_probe() after that function executed
rockchip_pcie_init_port(). Enabling link training only needs to be done
once, and doing so at the probe stage before the controller is actually
started by the user serves no purpose.

Refactor this by removing the link training enablement from both
rockchip_pcie_init_port() and rockchip_pcie_ep_probe() and moving it to
the endpoint start operation defined with rockchip_pcie_ep_start().
Enabling the controller configuration using the PCIE_CLIENT_CONF_ENABLE
bit in the same PCIE_CLIENT_CONFIG register is also move to
rockchip_pcie_ep_start() and both the controller configuration and link
training enable bits are set with a single call to
rockchip_pcie_write().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 11 ++++++-----
 drivers/pci/controller/pcie-rockchip.c    |  5 +++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 7a1798fcc2ad..99f26f4a485b 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -459,6 +459,12 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
 
 	rockchip_pcie_write(rockchip, cfg, PCIE_CORE_PHY_FUNC_CFG);
 
+	/* Enable configuration and start link training */
+	rockchip_pcie_write(rockchip,
+			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
+			    PCIE_CLIENT_CONF_ENABLE,
+			    PCIE_CLIENT_CONFIG);
+
 	return 0;
 }
 
@@ -537,7 +543,6 @@ static int rockchip_pcie_ep_get_resources(struct rockchip_pcie_ep *ep)
 
 	ep->ob_addr = devm_kcalloc(dev, ep->max_regions, sizeof(*ep->ob_addr),
 				   GFP_KERNEL);
-
 	if (!ep->ob_addr)
 		return -ENOMEM;
 
@@ -648,10 +653,6 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 
 	rockchip_pcie_ep_hide_msix_cap(rockchip);
 
-	/* Establish the link automatically */
-	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
-			    PCIE_CLIENT_CONFIG);
-
 	/* Only enable function 0 by default */
 	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
 
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index c07d7129f1c7..154e78819e6e 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -244,11 +244,12 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
 				    PCIE_CLIENT_CONFIG);
 
-	regs = PCIE_CLIENT_LINK_TRAIN_ENABLE | PCIE_CLIENT_ARI_ENABLE |
+	regs = PCIE_CLIENT_ARI_ENABLE |
 	       PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes);
 
 	if (rockchip->is_rc)
-		regs |= PCIE_CLIENT_CONF_ENABLE | PCIE_CLIENT_MODE_RC;
+		regs |= PCIE_CLIENT_LINK_TRAIN_ENABLE |
+			PCIE_CLIENT_CONF_ENABLE | PCIE_CLIENT_MODE_RC;
 	else
 		regs |= PCIE_CLIENT_CONF_DISABLE | PCIE_CLIENT_MODE_EP;
 
-- 
2.46.2


