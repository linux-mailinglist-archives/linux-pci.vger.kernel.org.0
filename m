Return-Path: <linux-pci+bounces-29688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82CEAD8C7D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45233B55E0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6407E125B9;
	Fri, 13 Jun 2025 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="st6dNrs+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E53A1CD
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818949; cv=none; b=ZC7I1qkHCJLBzhrLuxCQKR4FCdpt0y0PFNXdVeSw0u3QTY6sz07LrVi2J7IuFL5ZDPP2Qq9iVgwOz06ocg0WaWwMvA/QAo1vBK72MmUFMETlkwyff1qRnrpBfC3OUzGUhIYvC4DEG849xjU4A7UX2VJYGxJaogXOotI+U6ESrUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818949; c=relaxed/simple;
	bh=b4dI36+7QZrufn62jpx3nCwsgQ+MzFpAS9kwu6KrqjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKs5lswO6LLxZaqw0mHoqonm2TxT6H6vHICHW8tM3whpDgwcBJkKlv4ffyXZOykS98ZVclYDcIZeDXlA9+Bkq1vMk6koIh2Wx3fG3mgezluFKwHWE2icD4aotNeV2xgbqWPu4wp4+zIijeNqyUgJyD81a+8YX/YgazurNXOGV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=st6dNrs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3BAC4CEEF;
	Fri, 13 Jun 2025 12:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749818948;
	bh=b4dI36+7QZrufn62jpx3nCwsgQ+MzFpAS9kwu6KrqjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=st6dNrs+clIM0Xs+sDPIYqnFZJUgdbbF+07JBuLONi+zTuAZ8K9a+giRzTNKwq3/p
	 I8U+4Pef/v1MCQAfERX4Ej8w/N0S29+6ubqaUJC0EqR/qy8OOVtoSPZ/153LES6q7t
	 G6afEq4eb61e6ae/xlK54EHPIk7nSnpOeh4yQgF35yUMy6v6Ax7bzSdIcX7tyH5IHK
	 g/LElfxTgrE+th/kVxysQVuqvHAjFX5orQxuog8LFFajxk/yiJk++uR2uFt0TTcXWR
	 gtOP20twmwhV1mghT9S5tw/L+eZmuouqRKDXYJuqgM2UcTKFPiN1oxM+UwTc5BS/yA
	 KTHrrzs7bD9EQ==
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
Subject: [PATCH v3 2/6] PCI: rockchip-host: Use macro PCIE_RESET_CONFIG_WAIT_MS
Date: Fri, 13 Jun 2025 14:48:41 +0200
Message-ID: <20250613124839.2197945-10-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613124839.2197945-8-cassel@kernel.org>
References: <20250613124839.2197945-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2155; i=cassel@kernel.org; h=from:subject; bh=b4dI36+7QZrufn62jpx3nCwsgQ+MzFpAS9kwu6KrqjQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ85LR1d7x7b5p98mOW6IpK38Ve2XfO+h1dvCyWpYlvu lxGWMf8jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenANzkHYwMP74b7TX3Xn5hJ3vy obNvjj7Z6r/1Xeh6hj7ulloDlZIqH4b/yVITGkqklBqWPJ4b06M/K7XywuJ3LVZOzL0udrzzfik yAAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Macro PCIE_RESET_CONFIG_WAIT_MS was added to pci.h in commit d5ceb9496c56
("PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value").

Later, in commit 70a7bfb1e515 ("PCI: rockchip-host: Wait 100ms after reset
before starting configuration"), PCIE_T_RRS_READY_MS was added to pci.h.

These macros are duplicates, and represent the exact same delay in the
PCIe specification.

Since the comment above PCIE_RESET_CONFIG_WAIT_MS is strictly more correct
than the comment above PCIE_T_RRS_READY_MS, change rockchip-host to use
PCIE_RESET_CONFIG_WAIT_MS, and remove PCIE_T_RRS_READY_MS, as
rockchip-host is the only user of this macro.

Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 2 +-
 drivers/pci/pci.h                           | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index b9e7a8710cf0..c11ed45c25f6 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -325,7 +325,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	msleep(PCIE_T_PVPERL_MS);
 	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
 
-	msleep(PCIE_T_RRS_READY_MS);
+	msleep(PCIE_RESET_CONFIG_WAIT_MS);
 
 	/* 500ms timeout value should be enough for Gen1/2 training */
 	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 98d6fccb383e..819833e57590 100644
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


