Return-Path: <linux-pci+bounces-29545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3D8AD6F7C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029501BC5720
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 11:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF561442F4;
	Thu, 12 Jun 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpS2iSmY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657832F4323
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749729005; cv=none; b=GKyEO0DFD6FnzIZaftBQaWFgVwsU/hJ5qAu6JNTqGbSKVXoyxqItjgg92idLHETW+rOOZCtkNFBQUv77j4SWrc0O72T8DBOX8ueb9L3BGff1KGGYNXncvAe1w3Q9nbltPSg7ga+eCND5JYNz0rvnycxAeBCpyJeyLs9JR7nue48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749729005; c=relaxed/simple;
	bh=GHuMuAeNK50IE8bnNq+YCIKQbjGZygjZTh2aEInq0qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+/aUiOXHOgN2fVUpK61VDDahzUJ/Bt0+pOJXpbdg89UVUr38n9Fm50kSMwxcjPKq/iIs00S17Izuky3x03Ckv4wNRfkPwK279j7RaTuZuzr4O+2KF1/ZQTiNHklleXihhthuB0tXZUlOi3GLivfXY0++NNOwYwE04M3Fo8OniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpS2iSmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29921C4AF0C;
	Thu, 12 Jun 2025 11:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749729005;
	bh=GHuMuAeNK50IE8bnNq+YCIKQbjGZygjZTh2aEInq0qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpS2iSmY6gJsj1xmQLwNSatzd1YUcLQ6Z1HAp/6BAC6nadqpJTsiJZwcsiOqHzuZV
	 EWm60IVh1PZTq9i5n7IvP8cYojc8J728NRXQgsVPUFZF0Ly4aPKdYaIHvarUtIVcoZ
	 PsayNiGGp8QBVdzChUzwxlBxFpTgqOtHt1FjDKxUWo/5j9yx+x8FpXCxjzckBzs21+
	 0k1Dn0GvM02pSOnSyNZSRlggbdzSz4Qub53K8PsKewGg/iMJtkOyHxOcrV4QdLwaI1
	 fYlOKwkqRCjwLcYu7GXPe2P8v9uf+RQked3Mx8he46G8txXiQIEQK5AmLDG9ypxtYH
	 H8ljaiYjkkM6w==
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/5] PCI: rockchip-host: Use macro PCIE_RESET_CONFIG_DEVICE_WAIT_MS
Date: Thu, 12 Jun 2025 13:49:28 +0200
Message-ID: <20250612114923.2074895-12-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612114923.2074895-7-cassel@kernel.org>
References: <20250612114923.2074895-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=cassel@kernel.org; h=from:subject; bh=GHuMuAeNK50IE8bnNq+YCIKQbjGZygjZTh2aEInq0qI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDK89p2UvyofNoNVg0tjwU/bUP9na6M0Tk9/nPntwe8tO mJFuzfmd5SyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiHBsZ/gefsdfU5LrbsXzZ svgHDRNEEkPdAk9eLH62n7nWk1vj+wGGf9paj28uLI+68GX+LK3oyrQk+09VzDk73ON5tvOVlKS lsAMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Macro PCIE_T_RRS_READY_MS was added to pci.h in commit 70a7bfb1e515 ("PCI:
rockchip-host: Wait 100ms after reset before starting configuration").

Later, in commit d5ceb9496c56 ("PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS
waiting time value"), PCIE_RESET_CONFIG_DEVICE_WAIT_MS was added to pci.h.

These macros represent the same thing.

Since the comment above PCIE_RESET_CONFIG_DEVICE_WAIT_MS is strictly more
correct than the comment above PCIE_T_RRS_READY_MS, change rockchip-host
to use PCIE_RESET_CONFIG_DEVICE_WAIT_MS, and remove PCIE_T_RRS_READY_MS,
as rockchip-host is the only user of this macro.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 2 +-
 drivers/pci/pci.h                           | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index b9e7a8710cf0..3d40daff98bd 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -325,7 +325,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	msleep(PCIE_T_PVPERL_MS);
 	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
 
-	msleep(PCIE_T_RRS_READY_MS);
+	msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);
 
 	/* 500ms timeout value should be enough for Gen1/2 training */
 	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..5a83338c8f99 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -35,13 +35,6 @@ struct pcie_tlp_log;
  */
 #define PCIE_T_PERST_CLK_US		100
 
-/*
- * End of conventional reset (PERST# de-asserted) to first configuration
- * request (device able to respond with a "Request Retry Status" completion),
- * from PCIe r6.0, sec 6.6.1.
- */
-#define PCIE_T_RRS_READY_MS	100
-
 /*
  * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
  * Recommends 1ms to 10ms timeout to check L2 ready.
-- 
2.49.0


