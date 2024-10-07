Return-Path: <linux-pci+bounces-13912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B4B992365
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4CD1F22838
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2F15338D;
	Mon,  7 Oct 2024 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGQ5JKe2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDF3C2F;
	Mon,  7 Oct 2024 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274347; cv=none; b=ke2dlXxLCR6X7g0LYwmjs1Kv6wU7nMmuZndjSkbUf43DZTCY3lp/86xlckNWJOJY2kLNhXfgxG3jCRzFCiwq9ou4BXoGIk0rM2zkXbrk53fLOvmsUg7nr1qykSD78jMs4WHyUn2rnqF6dlCJAvnxqev08l9EaN2I27DPCY6gvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274347; c=relaxed/simple;
	bh=lYwTrY0jS1tCfZGBdpC5Zd5QRFOVHWsbeSniB+7qLxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ithzIBU6SIoC06rhqPvOlxFyWtI4TKdUCOxuhJWMWpHDY27nbBRrP0hSb6GsHObV22/k5GINOwDh2Y3knLgvJYJBnA9KQxHdJ3pXBEEgSdvklKZn/BUK4MNKGUH+WvZb+Fu2lKtqPtUYdPsUCsYMZnMe9svV+dxHi4y8EFlyqfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGQ5JKe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2F7C4CED0;
	Mon,  7 Oct 2024 04:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728274346;
	bh=lYwTrY0jS1tCfZGBdpC5Zd5QRFOVHWsbeSniB+7qLxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BGQ5JKe2YQwtiSg+YyGQ6bWx5D6dv+0ynxFVl49qydjwcwMDeABObBiwr4a/7Ufdr
	 o2tOTZGAXjZNgXVWMravJJeteBBX77c0SgWoqA0deBFBanWQxSMjZ1Pf6YzZmOvGhm
	 HTdw+V3F+vZm+0RfCdq8X8mG5e08ucGGDuITQ2NGetMsV+YTwuf8/a1lCke1pq/pGe
	 YiPQW8amJJUw3yKU4hif6Pw2Sd5SyhQiJXALc9GY5DRZoPXojmTztaWy8fijza/ppS
	 oq4qYMRsFDsmNLxC7hH+o3q+2naD70Tty+0c2zz0YdKYvOXfCAYqp4kEzv3P6So2Tk
	 8BoYSAkOZbqwg==
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
Subject: [PATCH v3 02/12] PCI: rockchip-ep: Use a macro to define EP controller .align feature
Date: Mon,  7 Oct 2024 13:12:08 +0900
Message-ID: <20241007041218.157516-3-dlemoal@kernel.org>
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

Introduce the macro ROCKCHIP_PCIE_AT_SIZE_ALIGN defined using
ROCKCHIP_PCIE_AT_MIN_NUM_BITS to initialize the .align field of the
controller epc_features structure, avoiding using the "magic" value 8
directly.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 2 +-
 drivers/pci/controller/pcie-rockchip.h    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 27a7febb74e0..5a07084fb7c4 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -446,7 +446,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
-	.align = 256,
+	.align = ROCKCHIP_PCIE_AT_SIZE_ALIGN,
 };
 
 static const struct pci_epc_features*
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 15ee949f2485..02368ce9bd54 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -248,6 +248,7 @@
 
 #define ROCKCHIP_PCIE_AT_MIN_NUM_BITS  8
 #define ROCKCHIP_PCIE_AT_MAX_NUM_BITS  20
+#define ROCKCHIP_PCIE_AT_SIZE_ALIGN    (1UL << ROCKCHIP_PCIE_AT_MIN_NUM_BITS)
 
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
 	(PCIE_CORE_AXI_CONF_BASE + 0x0828 + (fn) * 0x0040 + (bar) * 0x0008)
-- 
2.46.2


