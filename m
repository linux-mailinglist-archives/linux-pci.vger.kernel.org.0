Return-Path: <linux-pci+bounces-5389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169FE891578
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE10B227F3
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F56C39FD3;
	Fri, 29 Mar 2024 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG9gQ7xQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492AE37711
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703411; cv=none; b=LcfwCgc41l7gsnjrp3nLeDtX6M0qhp9jvvv4jXxPTybedXpIs1v74QuazqiFyBoMTFImxB4AJ7r/1FBP9vyMbX/zO46V1qg0byfqNiG5b+opRvVmJ47+6LD3xmUqexWe5WDQnigriKVq9+BrbqKhbZmWcR5RVTnkqd7ZtydYDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703411; c=relaxed/simple;
	bh=h8X8PrPgY8Hng7qpmyQmQNd4ZBulxmwQHIfO5ggjjo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNhsRN7jV6FS8amb2afIm3ZRcaWGPECpOzYJjxrFLgnXmyNuzi3XOIptiX3BAj6KRjGXmDG6JOgfLwyWBGsVjNijqK/FMuqpbOD4klpjc52qUMPu1Y/DxlKvdw1MbmcDjYdNNssCCZaSTlzvBi518Io0WAojGl5wAxhnwlU2LOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG9gQ7xQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED51C433F1;
	Fri, 29 Mar 2024 09:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703410;
	bh=h8X8PrPgY8Hng7qpmyQmQNd4ZBulxmwQHIfO5ggjjo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nG9gQ7xQmyJ2v7u6XspNZLnVQNnX3iWwigV9fQyL/NpnIq+kDuIRhn0EcKlX0v+IY
	 WS/I16TOqOHY3Oe8uHG0E5d7u+OjKAQISXIXRqcnx/RZSz5CrSKIFwMfRv4w9IKUNR
	 zC4t9SpoyRZOP9BQAT3SDWjYB637IfxQ7Bqqjhgi5Xo24qUbKxBJR0dw4sEBPMEYAv
	 4fyER67K3NZn4Cnpz3Ln+CNTabOg8PVcbqavrROoSvKxDI8Yb6zP1cddZ6OF4qwrOf
	 3LdDacAErm3+lOLAtgM36/+4td8EAObcRM/LqvNP/6eYkVz2m61NLHO6b5YhnM1nFm
	 jSe8I0MaWCKsA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 15/19] PCI: rockchip-ep: Refactor endpoint link training enable
Date: Fri, 29 Mar 2024 18:09:41 +0900
Message-ID: <20240329090945.1097609-16-dlemoal@kernel.org>
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
 drivers/pci/controller/pcie-rockchip-ep.c | 14 ++++++--------
 drivers/pci/controller/pcie-rockchip.c    |  5 +++--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index b6b9161932c9..7df036098ecd 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -461,6 +461,12 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
 
 	rockchip_pcie_write(rockchip, cfg, PCIE_CORE_PHY_FUNC_CFG);
 
+	/* Enable configuration and start link training */
+	rockchip_pcie_write(rockchip,
+			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
+			    PCIE_CLIENT_CONF_ENABLE,
+			    PCIE_CLIENT_CONFIG);
+
 	return 0;
 }
 
@@ -539,7 +545,6 @@ static int rockchip_pcie_ep_get_resources(struct rockchip_pcie_ep *ep)
 
 	ep->ob_addr = devm_kcalloc(dev, ep->max_regions, sizeof(*ep->ob_addr),
 				   GFP_KERNEL);
-
 	if (!ep->ob_addr)
 		return -ENOMEM;
 
@@ -650,16 +655,9 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 
 	rockchip_pcie_ep_hide_msix_cap(rockchip);
 
-	/* Establish the link automatically */
-	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
-			    PCIE_CLIENT_CONFIG);
-
 	/* Only enable function 0 by default */
 	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
 
-	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
-			    PCIE_CLIENT_CONFIG);
-
 	return 0;
 err_release_resources:
 	rockchip_pcie_ep_release_resources(ep);
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0ef2e622d36e..dbec700ba9f9 100644
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
2.44.0


