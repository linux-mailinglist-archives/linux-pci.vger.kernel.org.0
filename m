Return-Path: <linux-pci+bounces-5447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AB9892958
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 05:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B3C283670
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 04:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082DF2F25;
	Sat, 30 Mar 2024 04:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTt6Pu1N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A3B65F;
	Sat, 30 Mar 2024 04:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711772418; cv=none; b=ZOVR8k2G4EKW4Em56+Lw04nNKgmlQV+xHcIuPefsz4mD/aQ/irirMQRwp4KnlGw1hFyIS4cykWyuc+jI4q7wU8N4XweHyjoK6ShPFfKrlH7HoFuHe+BRjn4Gyun69XXx9y/cDqJQkBOn9VQIcFeYredfDwznmOIWoyW5of7CFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711772418; c=relaxed/simple;
	bh=1pkm8EJkDV8JLNfXadYBTmhaHEtJmAs5GElm0tmZClk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrluX4QyvJgccGzFxBTdbG2Yh+9MWVB7P5K8QOzFu40xE3g4yA/mY4Z3XJc779QVfDuG/cCGna9qMY1hye76MDRbR2IbQDFSACN5moUyjo3xGtB/veNYvQCmu5hzfChM5FHB7ltE8WiHjx6ZX9AAquyLtnSRlEPTp/Cd9oSbbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTt6Pu1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDA5C433B2;
	Sat, 30 Mar 2024 04:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711772418;
	bh=1pkm8EJkDV8JLNfXadYBTmhaHEtJmAs5GElm0tmZClk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lTt6Pu1NPT5ncZn8NqBACv8mckbzPFXXzema+DA4DpgU/KtUjqo+k9kItim70/IkR
	 JKEo0aNd85eFcU14EHdQ8z9CV/lT+vXKgDXj+GMmA00bosZO1fr7eAYzn8lV3lnmEg
	 tvqaGELag5oAiKH6++az7jT2PUQBx9/cdhi+ipL+APez70a9rJS4h/F8sSisKKEq+W
	 svUZFGwCq9zPQce73nzF1mf75b9fj44tzsjri1zkwZok35fcrQ1u2vt9nSDViaZ0IH
	 bfOOPLuRsDpX5Fn3bhVds339vPpHY6pypfzEvGGefX8AySQLi8zRDxG66BO+jyfHA/
	 QXP/Q31zq2LNw==
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
Subject: [PATCH v2 15/18] PCI: rockship-ep: Introduce rockchip_pcie_ep_stop()
Date: Sat, 30 Mar 2024 13:19:25 +0900
Message-ID: <20240330041928.1555578-16-dlemoal@kernel.org>
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
index 9215cac91f61..2767e8f1771d 100644
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


