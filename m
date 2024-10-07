Return-Path: <linux-pci+bounces-13919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCABA992373
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685581F2294C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4416A41C69;
	Mon,  7 Oct 2024 04:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT3Xa4i9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD9D2AF1B;
	Mon,  7 Oct 2024 04:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274362; cv=none; b=nfPbg7ry3mcrjzpLj6Vr2O1NveurSmaSjgWzaL3NaKSTsJNChDTqu1NlI5Iyvq6GOIgjm3iAuLP3cfyUxFOGFH1iK7LrVtutSBdu7FsNOB5MP1CmlQw4ugm3yibUSMZxP81DFucCUwG91ms+omGWskR/L1MkozCRIV/IYDwPMUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274362; c=relaxed/simple;
	bh=SrNUJWek3Y8VxlqV3FvME5E78Yk8z8nUv9tQDwM46zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MH/A5fLjklk09a6s7wkmP+TxqiMiLV6o4sP51xbpalq27O/iuVUaMWFlRybaWAPfVy3UyYRyyDvAV4Ivfg2fDogpqQrKsFN6GODcJZ8Dqt0wEmO+LRCV71hbANVycR53RvA0hgEsgvXNUS+5pXnE55Uu3hCV2vWKc13FXsGaxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT3Xa4i9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA69C4CECF;
	Mon,  7 Oct 2024 04:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728274361;
	bh=SrNUJWek3Y8VxlqV3FvME5E78Yk8z8nUv9tQDwM46zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aT3Xa4i9puv0Mkh4TNQufJLGdxXmsRrzpjcEnyURGja7fsmtYkUG4Y+c/aUdKSYgu
	 2PsBIhd+tk7tUfC4JC5ZoszWfPoNCYN4ST4V42EUFTVpD9I9SwtfuWUoXTYRGOmDI2
	 zKyf0cFKy2ORgfDMR1BHBMtLPQ+enrQzBtklitUp56lw8c6MeyzOsgLqNvI56fSt1B
	 Udu+v4acrR/UIw/+uyvMc1dex8eW3ZESB1eZAFbnsSL2lUf0jhkD3/C18L+HErQNXe
	 ivGi1gYqx3spG/Mu1nvy24jBAxaPL2GvGUUGb9jtho5JzvJOtSU/+eIvTn/ioAm7xu
	 X8cbn3948lC4Q==
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
Subject: [PATCH v3 09/12] PCI: rockship-ep: Introduce rockchip_pcie_ep_stop()
Date: Mon,  7 Oct 2024 13:12:15 +0900
Message-ID: <20241007041218.157516-10-dlemoal@kernel.org>
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
index 99f26f4a485b..a801e040bcad 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -468,6 +468,18 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
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
@@ -492,6 +504,7 @@ static const struct pci_epc_ops rockchip_pcie_epc_ops = {
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
2.46.2


