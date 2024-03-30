Return-Path: <linux-pci+bounces-5440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE5489294A
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 05:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256BD1F22296
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 04:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7A62F25;
	Sat, 30 Mar 2024 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddhKCogd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516861FA5;
	Sat, 30 Mar 2024 04:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711772397; cv=none; b=DZBI2lfh3WXtA384ciO5ggg2aYzIdK/Lj6Zo2Qfnp2juFKckhBRbPlLfno/6jj7dX8EjbGx8To4YJLv8X7IwOSXSrJ8EJyGbqcnzu3xRTcCfldkSxg+qWxtgMMfB6zan5cFq9103667TAEQATeqB9MtLEDrKJHqyAMUQILF0xG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711772397; c=relaxed/simple;
	bh=0vCO9UEww6LmblGgZZ5zmiHkjMZnubOns2C7wQhVNS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wt4uWPHonWrIhowJSYdR9st6FOqz2ezKuwfebte/Gs4lzPEcfO9zGLjaB5SmnKrdq7Yx0Dg6qmXuN1FDDtgDNzH6joDw1/2tBamFWmoZZrVg6GaU/o8FI8TKvrrLXlIwzT1s4yDHyAqY7XYieUo2RIiRqMBejm6JxL3dYjKvQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddhKCogd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27860C43601;
	Sat, 30 Mar 2024 04:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711772396;
	bh=0vCO9UEww6LmblGgZZ5zmiHkjMZnubOns2C7wQhVNS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddhKCogdN5hRET7t2XDCJfuQJG3YyW01fPcToBf6GLu4B/ncikP9Xxmssjegmb1Cx
	 UCy+A7tcM8Tgs1coCN1MGiML4wlmag2sy/mNkLnec6ZpwjsdsDc6ibXOH5Fq8KoiMf
	 VPxJoPipUy+/VDepBi4BmnvH5rRVYsnBNLTTUWN4mrTR2YyS0fsBohnULd2Vo0pSSM
	 qzgPJ/P0EAOjXqoQ3xDU077OgHtCFm/qciry57J3pT9JH52Ht27Yr5S1OhZ3tSq0nr
	 wRCXY6TVgbqO8lwPRMSlUhFCoC1dzjhEkR29euv3UNl3aPvXTd9M9UjFAaOz6xr7lH
	 MJNNYKjjHlxRA==
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
Subject: [PATCH v2 08/18] PCI: rockchip-ep: Use a macro to define EP controller .align feature
Date: Sat, 30 Mar 2024 13:19:18 +0900
Message-ID: <20240330041928.1555578-9-dlemoal@kernel.org>
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
index 786efd918b3f..f8c26606df58 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -448,7 +448,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
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
2.44.0


