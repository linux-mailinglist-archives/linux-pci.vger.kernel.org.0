Return-Path: <linux-pci+bounces-29689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A221AD8C7E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF5C189AD63
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692FA1805A;
	Fri, 13 Jun 2025 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY4I2aA6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4428A1A29A
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818953; cv=none; b=rysePlQzDE/PFu0Yl/2uJ92i9LvKZoJgANcL7Ip8kFXuefq5twT+DS5rqoM5De2uOeeppSUVbO3vFVmtav1SQR5GQ2jtZOIkrzq4EOA13DPtsqg9cPN7ZADfbpB0Lskkx4AmDHWHc/Zn3DjkjUcEFBl7BDp3OgnA4aSQNeiHuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818953; c=relaxed/simple;
	bh=wX1Jm2lYAIbPE66Dwi838XJj+Gobl7EuV/Pwtb/T0aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/bdo2iDkMD9RSUwp4dS6VI18dnKiaclwA+4bezZ6cbOWEYrhD0IQJM2DuJGZC86tqi+D/uiKL9bgUyl5jYUw4Lbka1lwWXLqtkVK/D3ODgqFt4Myt939Li9Kb8pShr/F/POUxDEJXYRVwRX2wfwtgt0yICyKaq3HtEvyIocoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY4I2aA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91142C4CEF0;
	Fri, 13 Jun 2025 12:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749818952;
	bh=wX1Jm2lYAIbPE66Dwi838XJj+Gobl7EuV/Pwtb/T0aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dY4I2aA6Z9SjXZtLDpYISinWj+O617Ldj351pF+kracLye+Kw9TIWvjn8uxIxuDp0
	 jkPS5lraJ9urY3aBbuZoG7j+UvdETTn2Dyo3x7mQF20QUfSbZzbINynOUxmWe+4l89
	 vEWo+AS8KtiBnTyCvbCY6J8i/Y/tK/Q5w5jTY59y7LF0Maed6VuMj5ra9ham/13ztQ
	 Jrqd/VZ3uT0IkKDYLUYfDmj22ZNXERHWCzHByusQORPfGsFQ7pAAnYW+80zAqNgCNQ
	 WHsijro6ETpxi8I/E0P4PzrA3u1woE47rr6jnPqSCILpPY2GSHYgmMf5thERAfCGPn
	 f3OoRpKpWIlqQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	Simon Xue <xxm@rock-chips.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v3 3/6] PCI: dw-rockchip: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
Date: Fri, 13 Jun 2025 14:48:42 +0200
Message-ID: <20250613124839.2197945-11-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613124839.2197945-8-cassel@kernel.org>
References: <20250613124839.2197945-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=cassel@kernel.org; h=from:subject; bh=wX1Jm2lYAIbPE66Dwi838XJj+Gobl7EuV/Pwtb/T0aU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ85HT4ufb1SDw2nubNbWhoUZR5dwprmb5Y8Z9bHLwRv m+3f+7pKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwES6djL84Y55rPPKPm2/gt75 XfLS0+Ze5ztoL5ies/y05yeJ5Q3MWQz/fY+8aFqUJysZ/eDl9/r2lScYWbnl/kp79sy/FyyT80y WBQA=
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


