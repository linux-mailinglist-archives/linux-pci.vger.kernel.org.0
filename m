Return-Path: <linux-pci+bounces-30608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BE0AE7F18
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 12:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25B9189B029
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE85129ACF3;
	Wed, 25 Jun 2025 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTmem3Fj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD452882CA
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847058; cv=none; b=oeMBhZnOZf2X9OHvmnt1cdjzYTb7Br2P5mIoQwIQpHpZxq05a/GuLi+J6xcTsDFhQH6JRZJdo7smKoCo0DeNDn+t96hFSx8uELJFqiY8eYvrSqed7+IbW3hwYe+ObX7jCZ0uePpC0zO8C3we8O1IUprhgJmqIQR+1Ci25rsAwyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847058; c=relaxed/simple;
	bh=wX1Jm2lYAIbPE66Dwi838XJj+Gobl7EuV/Pwtb/T0aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7I7LS/RZGy7ruzIYenI964voeRo44QNaGR4BUlmcXuOiCNvkTGAZE/+XNftRr2NKWA1p3cUWNZqCnaMgB+OMf81AqicG4P4F+B8QdaZ1QzT5rdghbVCOlrQAkX+3TPYO+gFGI4ew9baErYTo0v4UWXIhPvvKncUbecYQqKIFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTmem3Fj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5B7C4CEEA;
	Wed, 25 Jun 2025 10:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750847057;
	bh=wX1Jm2lYAIbPE66Dwi838XJj+Gobl7EuV/Pwtb/T0aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTmem3FjeByuxN3AFYV8SvH4Jp6ywYl31k89fVhpLW0EPgAJobotpohjk3GlPLd4n
	 kYL+YDqYfjlr2I+bDaZsZrX+0aNmH+nwsWLJQX0RTi9SJavPkIpVBh9ynnx8X7xzM5
	 Wr02Lcg35Kf5y/KHFQaafbduDZXvAti/mGA+EkP7OX8XDuza7FwICuYcYDwpDsOGkM
	 St503jNuj7piVGM/T8kWrTbG6tu78LPdizjK8caC6p8228zgJT9z3a7eyxPKkI6AqT
	 G1VuSR6Q63E7CtSZsASdxtKAcmWbf3S9WYPuZS1NGELPdfUrHN3VvavxwR7qdV4VmU
	 Kij7n8/qUJjzA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v4 3/7] PCI: dw-rockchip: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
Date: Wed, 25 Jun 2025 12:23:49 +0200
Message-ID: <20250625102347.1205584-12-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625102347.1205584-9-cassel@kernel.org>
References: <20250625102347.1205584-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=cassel@kernel.org; h=from:subject; bh=wX1Jm2lYAIbPE66Dwi838XJj+Gobl7EuV/Pwtb/T0aU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKiz1nwc+3rkXhsPM2b29DQoijz7hTWMn2x4j+3OHgjf N9u/9zTUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIlMXMnI8Jp9W+It7TOTv29s yVplsObnXT4H5oaga5PfF1/T8dmbXsnwV1ztVuf106+WH1BsnbLryO0pvcp8/pvylvMu2dN14nn bFQ4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Per PCIe r6.0, sec 6.6.1, software must generally wait a minimum of
100ms (PCIE_RESET_CONFIG_WAIT_MS) after Link training completes before
sending a Configuration Request.

Prior to ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since
we can detect Link Up"), dw-rockchip used dw_pcie_wait_for_link(),
which waited between 0 and 90ms after the link came up before we
enumerate the bus, and this was apparently enough for most devices.

After ec9fd499b9c6, rockchip_pcie_rc_sys_irq_thread() started
enumeration immediately when handling the link-up IRQ, and devices
(e.g., Laszlo Fiat's PLEXTOR PX-256M8PeGN NVMe SSD) may not be ready
to handle config requests yet.

Delay PCIE_RESET_CONFIG_WAIT_MS after the link-up IRQ before starting
enumeration.

Cc: Laszlo Fiat <laszlo.fiat@proton.me>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 93171a392879..108d30637920 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -458,6 +458,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
 		if (rockchip_pcie_link_up(pci)) {
+			msleep(PCIE_RESET_CONFIG_WAIT_MS);
 			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
 			/* Rescan the bus to enumerate endpoint devices */
 			pci_lock_rescan_remove();
-- 
2.49.0


