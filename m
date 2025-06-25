Return-Path: <linux-pci+bounces-30607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2ACAE7F15
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 12:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1383ABEE8
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091F429B22D;
	Wed, 25 Jun 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ4Wearl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857029AB0F
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847053; cv=none; b=jTcenJuL0uaI9L9mkcjQgngUM2ftXjSFiNeg6fwZqu36U4o0HCqKPGja7oE/53UZMy8Z7dx2e6ZD6CYKcC8BKGFHTuY4VkazGU4gwx4vs10r3ge4oMHR2xk/IFvTMNs/mbaM4LqxO66HClAK+BOREegSsTE1Wq87mRQTrPH0BD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847053; c=relaxed/simple;
	bh=F2ftyv+Q/EHTUyO7jIwBMNf62KBdMrEQKTlHC9NEFOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gf5vSnr90qv2GjVpZeNNMaOrPyUzy79uHyEeW5xf1HDeH1/E7kCCqFapOsw7wiaD8cOHNMBVrMKxdaSNE6mz4yHERkOQoUzTkmUqw5BYae8aNLuC2OhfLNCb8/HUutZPh7OSMT5K4G37Vmc/nBuHXsFpWAtAh1923wpvvlWFF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQ4Wearl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABC7C4CEF1;
	Wed, 25 Jun 2025 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750847053;
	bh=F2ftyv+Q/EHTUyO7jIwBMNf62KBdMrEQKTlHC9NEFOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQ4WearlTSgu+KRp7gt3QpzQdipavHkEEt4AAHZ1HbSpHdMMNEo8WdSQ3RXzwNYBf
	 07KZI3YHjgi2e9Olh7jQMsQQnv+v2reKQ+kKFw17K322jjE0OoBaUH7VN2tRGkkh+Z
	 dP7/JIarM3I3PEYnwbAVE0PnsL8lzGrkLJXVcxfBIRmDCurn2CEkF6UKqXO31Sq2SR
	 6XCkKdtYESboPHwRa3WgXwX5Zgpkc/hgJgbJ0KcjGkNXChuFVVTDf0Sc44kO1ZWpzZ
	 /0flIJysotNd0DKRktGbq2Sh8C0YlOP7fb+0pvf59DYSbh7L1qvrlK/50iYuyFpodr
	 zJ3YfNjC321rw==
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
Subject: [PATCH v4 2/7] PCI: rockchip-host: Use macro PCIE_RESET_CONFIG_WAIT_MS
Date: Wed, 25 Jun 2025 12:23:48 +0200
Message-ID: <20250625102347.1205584-11-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625102347.1205584-9-cassel@kernel.org>
References: <20250625102347.1205584-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2163; i=cassel@kernel.org; h=from:subject; bh=F2ftyv+Q/EHTUyO7jIwBMNf62KBdMrEQKTlHC9NEFOM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKiz1kobrN5bBI29VGoYV7nFy6XS3rqbbrCxV1H+fe8X rXjt5hLRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZSIsDIMD+uq1RE+1ZHs4aY h6/Fw4IyNWUm9nc7dns4nX8rnZw3g5HhSsn1X789np5lcTh9oqx94hOpv0FJM01+vyiR2dXeGrC FBQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Macro PCIE_RESET_CONFIG_DEVICE_WAIT_MS was added to pci.h in commit
d5ceb9496c56 ("PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time
value").

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


