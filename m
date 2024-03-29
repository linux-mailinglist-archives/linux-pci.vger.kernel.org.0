Return-Path: <linux-pci+bounces-5390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C024891577
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B19E1F22BAA
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946BD37165;
	Fri, 29 Mar 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKI6quCu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98B2C6AA
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703412; cv=none; b=Ps7ja0V8wQng1XC+eiKc34I3+LLXhuXf9n0f8sLc7eIXHHyYgccaJNmpYu6TCwe9k1OI+edJ0IkvR4D7ysRO5BN6CmbeX0Wpgj6CiX8sRQijACuhXMtIh5fbw23gqRBwo/yH65iK35a2c8bx8CABSA93cGhWEsr6qy9Hn+84fLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703412; c=relaxed/simple;
	bh=RXLldZKLpPMu+MutiLKOGWj1dxASTXunfudattYEHEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4Dn1Bl9lGNN6nfQE2RAI7/pS+kNhF8MtPdHUdjf7dhvEO0Ov0nbjR4Xo8yS1E5kPGC/TT3AVlEljd4TRSeRAv67+wDK15g1/bQSkXjeinFfWNWca4MO1jxM4ojPK/Z1XJSXboEhnq2o48N7ElVPRqSs5/nmqSqFEmPEIQwXZyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKI6quCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FD2C43390;
	Fri, 29 Mar 2024 09:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703412;
	bh=RXLldZKLpPMu+MutiLKOGWj1dxASTXunfudattYEHEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKI6quCuJe1QmenF8fJF1NLI7QagbAaAlQPF1h3JDyt2nFUJByBEdlZa+/AhsnzFL
	 b1Tk9TZzWeO5D9jAHDJT9wlo9YD5vtGGCsrTUUjz0wSZV09oCQLO7VyWvrepubRvcK
	 mqk14eWHVHDiN6JrUQPI7n5wbFFCX2b/fkuWisgh/9yvATffAD78sHcj3pBjTZuOnU
	 YlcIB3XRPKGcAbhaVY40YcYQwlioOAyb985mf74Oz4gDL+LY1k1AxxQOsGktm0DfN4
	 gaa+mQguBnU/jyoM3s2QCr8GMyq/dESFUw9GdH84ob9QWWfSdktvDNutG1y5WVsq7o
	 y8vgMF8uJi7dA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 16/19] PCI: rockship-ep: Introduce rockchip_pcie_ep_stop()
Date: Fri, 29 Mar 2024 18:09:42 +0900
Message-ID: <20240329090945.1097609-17-dlemoal@kernel.org>
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

Define the EPC operation ->stop for the rockchip endpoint driver with
the function rockchip_pcie_ep_stop(). This function disables link
training and the controller configuration, as the reverse to what
the start operation defined with rockchip_pcie_ep_start() does.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 13 +++++++++++++
 drivers/pci/controller/pcie-rockchip.h    |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 7df036098ecd..c126da07bf0c 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -470,6 +470,18 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
 	return 0;
 }
 
+static void rockchip_pcie_ep_stop(struct pci_epc *epc)
+{
+	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
+	struct rockchip_pcie *rockchip = &ep->rockchip;
+
+	/* Stop link training and disable configuration */
+	rockchip_pcie_write(rockchip,
+			    PCIE_CLIENT_CONF_DISABLE |
+			    PCIE_CLIENT_LINK_TRAIN_DISABLE,
+			    PCIE_CLIENT_CONFIG);
+}
+
 static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
@@ -494,6 +506,7 @@ static const struct pci_epc_ops rockchip_pcie_epc_ops = {
 	.get_msi	= rockchip_pcie_ep_get_msi,
 	.raise_irq	= rockchip_pcie_ep_raise_irq,
 	.start		= rockchip_pcie_ep_start,
+	.stop		= rockchip_pcie_ep_stop,
 	.get_features	= rockchip_pcie_ep_get_features,
 };
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 30398156095f..0263f158ee8d 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -32,6 +32,7 @@
 #define   PCIE_CLIENT_CONF_ENABLE	  HIWORD_UPDATE_BIT(0x0001)
 #define   PCIE_CLIENT_CONF_DISABLE       HIWORD_UPDATE(0x0001, 0)
 #define   PCIE_CLIENT_LINK_TRAIN_ENABLE	  HIWORD_UPDATE_BIT(0x0002)
+#define   PCIE_CLIENT_LINK_TRAIN_DISABLE  HIWORD_UPDATE(0x0002, 0)
 #define   PCIE_CLIENT_ARI_ENABLE	  HIWORD_UPDATE_BIT(0x0008)
 #define   PCIE_CLIENT_CONF_LANE_NUM(x)	  HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
 #define   PCIE_CLIENT_MODE_RC		  HIWORD_UPDATE_BIT(0x0040)
-- 
2.44.0


