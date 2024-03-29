Return-Path: <linux-pci+bounces-5383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC32D891571
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6768D2857A8
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C5839AEC;
	Fri, 29 Mar 2024 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIE7fTuK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68DC36AE7
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703401; cv=none; b=q3G7TOobbJkTB1FXIA6quQFd2rL0ncbGVO7PSKTK0giElLDVSdDEZPZNnR/dhcaW6Jj7MJUHuiEICWHL2A+Rf0c+ZyjUJv/vdSaE+VSeMYW+OLwvzDv4dcDOb7ABBAmF2RoQasv5FAcMDxMBt0yop6dnb3jmaeu/AiyZd65gZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703401; c=relaxed/simple;
	bh=TtEADjsIY+AJrW5BwZotEsQEf9GAL1QtAJ4zDREYbqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UR10Va7+wBr8Izw3qmhZFBIABBZSV6BkrVHaB0mb2CRuTddVo/+siD0eOzy1zSEU/jMAvCX9LMmycM1jMGR9RExbhRfyU+BsSsPZnw32uqdk3nwUTGrVCOpAn6s3pFF9fXkAv1dNxaAP/BzHRlJMMMoOf+WKtEukJ23wAjNMZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIE7fTuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA82C433F1;
	Fri, 29 Mar 2024 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703401;
	bh=TtEADjsIY+AJrW5BwZotEsQEf9GAL1QtAJ4zDREYbqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIE7fTuKedWyvQK2FwnsTcjVJ1MMjL3vsvbjnj30S6RgBPJqoqCK6r4R0C6KEJuMw
	 h9a954yfAWJni+TB7SzNy6WhjrPYuZu9Wptix8U+DbcfzJXMl7vUc1r0c1zL+FdpGS
	 a1uGmz6jlo77nl4TQGYWYgzlZVzqM7d9bP0eO3qhhvuMPjKdR4z30a76nxsApXZlj8
	 SueYjW+MSqO9P0UiFrLVUYDTuxm89/o1pw192wlyTKsALDmUWDmpMgyuRVsUsLMTbD
	 PGnTCs27vm31xhrYhXhCqKZYI8axAY9/2gXivKLxJfFR2yvASrqjZF69HUdZEYUcwq
	 hijHSs1t63AHw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 09/19] PCI: rockchip-ep: use macro to define EP controller .align feature
Date: Fri, 29 Mar 2024 18:09:35 +0900
Message-ID: <20240329090945.1097609-10-dlemoal@kernel.org>
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

Introduce the macro ROCKCHIP_PCIE_AT_SIZE_ALIGN using
ROCKCHIP_PCIE_AT_MIN_NUM_BITS to define the .align field of the
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


