Return-Path: <linux-pci+bounces-14302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08AE99A39C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694CA1F21569
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF977216A3B;
	Fri, 11 Oct 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNPEuMko"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94A9212F13;
	Fri, 11 Oct 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648872; cv=none; b=loqDgjI8eAFeNgFnsbGbiZQKtKYgAVqLKibVfh9drUivBW34QfIUAxzY2CEW//6fBeRgOjkwhsj4Sa0iaOigFPjCrAeLZ8kmtF1b/4R7urIjFrBQKU3E4ynGxmOuwHTnAQgQv6VsnogzY3+H6PavGkgxFheNPGdbcuFU0ao4frI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648872; c=relaxed/simple;
	bh=YLOMUlU+AxuuqwEsdq4ZgXbwFIFz42L2scaPxKhjkjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usxePUOTfjEHosNzsHhtP3OPgMonMpfVjS5j/T8YPuJqlw7ZPaOLDDwj8Gcu82I/5gR/V2VvxySLIXrKj+LxAO4SkUrDQ2Op4MZIahItkPvLrvPsFSfCIWHiMOnTGqJgLMxstGYI11fXFQ6e52Ebvc6is85EEd4ij9LaYhGBl5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNPEuMko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57316C4CEC3;
	Fri, 11 Oct 2024 12:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648872;
	bh=YLOMUlU+AxuuqwEsdq4ZgXbwFIFz42L2scaPxKhjkjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNPEuMko2y3K4Wy8tt9gS43pnnuf0SOjsAnTcm0FRzklF4g0TigZFS4W6Kt2jg5KN
	 GXFbZKrkwHai27Yy6lBT6VG9AKq3MvjkqPfohSaltZU7WFdoPQXOFNp86/Hy4d896r
	 yovpMg1zjulzejXMR9GLdJI4t0gB4j4GP7J5Sl8gR72+A2A9InKygmeyHQAjwXWQIH
	 fOa7XUrLYNDuJfc5+CD3wG8xkV0lTgH059jrTzC0CVHnUPS0UcIj32jIQn1FGm+R+V
	 J5bzxLc0Iv/vxtWFMroCrjh76OG6rByOIAlrgdTL33wmSTtSzmIe4wfiJeoUXYHK/3
	 qKuIYdjEcNxCA==
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
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 09/12] PCI: rockchip-ep: Refactor endpoint link training enable
Date: Fri, 11 Oct 2024 21:14:05 +0900
Message-ID: <20241011121408.89890-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011121408.89890-1-dlemoal@kernel.org>
References: <20241011121408.89890-1-dlemoal@kernel.org>
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
bit in the same PCIE_CLIENT_CONFIG register is also moved to
rockchip_pcie_ep_start() and both the controller configuration and link
training enable bits are set with a single call to
rockchip_pcie_write().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 13 ++++++-------
 drivers/pci/controller/pcie-rockchip.c    |  5 +++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 2c8fd8ee327e..56dd4466cae5 100644
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
 
@@ -648,16 +654,9 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 
 	rockchip_pcie_ep_hide_broken_msix_cap(rockchip);
 
-	/* Establish the link automatically */
-	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
-			    PCIE_CLIENT_CONFIG);
-
 	/* Only enable function 0 by default */
 	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
 
-	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
-			    PCIE_CLIENT_CONFIG);
-
 	pci_epc_init_notify(epc);
 
 	return 0;
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
2.47.0


