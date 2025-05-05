Return-Path: <linux-pci+bounces-27140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 098F1AA8F82
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5EF1897BE3
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85C51FF1B3;
	Mon,  5 May 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imPINz/N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282C1FECDD
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437184; cv=none; b=mMfy/vu6j5iV60h6HgujW9L2gMthAn0UCr+v9OsMMhz5ibTbm1Y0ceeVDeQRdKRSYZYKjqkRuNweAhTcpKfibRb/sYetY80cFVGt61Uk7UI3ZuWkQkBkm+BD7TfGRplxHLs+k7QRK1JdflVVf1/KQCgnAUPt9vfgbNauzTzgm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437184; c=relaxed/simple;
	bh=DEEW58wS2e6R9G6RjworONmB4VHLR/BqqT0TK+62dZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WusuF4YVOY3x1jagTucvnMlFzD2B8r3jvnauQqS+yqrA45T6xSxOo+56wcBvicMsEc/D81yyF0t5J9Gm4kf2YEDRdLiVsSsgt7S+K0cNOvLYyV5dmEDe3v0pANZL626BTEC7bg2x6vDeM+y7Vq+Rt0DvsxiwntcqJlqssiz09tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imPINz/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB43C4CEE9;
	Mon,  5 May 2025 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746437184;
	bh=DEEW58wS2e6R9G6RjworONmB4VHLR/BqqT0TK+62dZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imPINz/N9p8vplGwTS77eut5TIULQ+m6785ixH9v9kr/5sb9bB5XdBNsrZ1Krd5zJ
	 6qC18PyPEjPKRMqaxJyUls6YTxoRt88oD6DDXIadjfXwIxOG0w1N+kQW84L1rPCKD7
	 Ib4yroTN4dB9IVbu2w/RWNTQ7h+Xd7rKpyaJnhsgtc3LwgTG/LjWTHmeRW/SxIIAZb
	 i64x4MKsNvLsz65gSDfnb/G4In3E4KuiZ0edtDdpmD7qgDchipOiUCkR01SZYp1bZb
	 hIcRArJKiPiwZdgLAHxqmm/q/4a+NebkIcEBtU6OmPbfuwn3Gosyk3BnjdytMqp7G3
	 iZ/FYfN78DThA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 1/4] PCI: dw-rockchip: Do not enumerate bus before endpoint devices are ready
Date: Mon,  5 May 2025 11:26:05 +0200
Message-ID: <20250505092603.286623-7-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505092603.286623-6-cassel@kernel.org>
References: <20250505092603.286623-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2712; i=cassel@kernel.org; h=from:subject; bh=DEEW58wS2e6R9G6RjworONmB4VHLR/BqqT0TK+62dZM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIkWnS4/k8Rfbtk+yTpqiwRJiZBPualC5odPFqTFTTqW 6b2TnbqKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwESufmFkeDNd9uLZ0gsaGZwv lolveH9fQD404NQLI7GmwpvHrAon6zMyHLk8x+Xng1W3ZnD+3WzwjD3B4IH9kfW+Pdw5BzRkfmd qswIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
and instead enumerate the bus when receiving a Link Up IRQ.

Laszlo Fiat reported (off-list) that his PLEXTOR PX-256M8PeGN NVMe SSD is
no longer functional, and simply reverting commit ec9fd499b9c6 ("PCI:
dw-rockchip: Don't wait for link since we can detect Link Up") makes his
SSD functional again.

It seems that we are enumerating the bus before the endpoint is ready.
Adding a msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in the
threaded IRQ handler makes the SSD functional once again.

What appears to happen is that before ec9fd499b9c6, we called
dw_pcie_wait_for_link(), and in the first iteration of the loop, the link
will never be up (because the link was just started),
dw_pcie_wait_for_link() will then sleep for LINK_WAIT_SLEEP_MS (90 ms),
before trying again.

This means that even if a driver was missing a msleep(PCIE_T_RRS_READY_MS)
(100 ms), because of the call to dw_pcie_wait_for_link(), enumerating the
bus would essentially be delayed by that time anyway (because of the sleep
LINK_WAIT_SLEEP_MS (90 ms)).

While we could add the msleep(PCIE_T_RRS_READY_MS) after deasserting PERST,
that would essentially bring back an unconditional delay during synchronous
probe (the whole reason to use a Link Up IRQ was to avoid an unconditional
delay during probe).

Thus, add the msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in the
IRQ handler. This way, we will not have an unconditional delay during boot
for unpopulated PCIe slots.

Cc: Laszlo Fiat <laszlo.fiat@proton.me>
Fixes: ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can detect Link Up")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Hello Laszlo,

I know you have already tested this, but could you please send
your Tested-by tag to this patch?

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 7a6a95dc877a..ed8e3dfe80e0 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -471,6 +471,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
 		if (rockchip_pcie_link_up(pci)) {
 			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
+			msleep(PCIE_T_RRS_READY_MS);
 			/* Rescan the bus to enumerate endpoint devices */
 			pci_lock_rescan_remove();
 			pci_rescan_bus(pp->bridge->bus);
-- 
2.49.0


