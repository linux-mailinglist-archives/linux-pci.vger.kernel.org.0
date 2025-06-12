Return-Path: <linux-pci+bounces-29541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24B0AD6F79
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1AD3A941A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F049223DCC;
	Thu, 12 Jun 2025 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRRcQ8YM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7956B219A8D
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728993; cv=none; b=GXIGg3SKJLfW0MsiLcNsET4G59iqNj0FTmNmLxxxsSHcrAB8Ybu10CoGmVjD+bYAqYO8+EtfbSTYd4F0oddWkbGqGSZv7vJGAkqfVLV4NMpEW/ytjb7zRWlxNVwKQBMTD+eKaVHT4Le3W5KA9Hdqh+fVlCcqWtDomqnBSBPrKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728993; c=relaxed/simple;
	bh=1Tm3QIXGlVl6CARF7272tS5RzBN9w6RAQBcJlB7/0jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALqo/P4cADoclcRXGLso0HAzd/f5eMN7ecxpma+pY02vR+xEmG2ghbZFnV+Eu+OhI7+mUy3AGnSG0qPUmZwlKE4q5CHKVBnnkxWblsdX176aesh65d5xVlJDkhb2kYtK2FP8UEsY/uGfIWG8t+o3w8K3rcVnt3QkNCnU5r6JPKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRRcQ8YM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E9EC4CEEA;
	Thu, 12 Jun 2025 11:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749728992;
	bh=1Tm3QIXGlVl6CARF7272tS5RzBN9w6RAQBcJlB7/0jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bRRcQ8YM2gAU5t9Lemw/hQFm408MLCtqkEtJUHThVAKb2G4jbAD9SKLC2Zejkp6ys
	 kNzrgZUH1EiZVAqSLoyAoCdstSopuNla0M9ZlBtIo4AVJTCFmMJEaB6jX5NVwChc6o
	 8sRTlme7axTi4rixFhFKF6CDAEpPilAG7pNGzgbEjf9U9noxqU8QC23Q+9Pchg31ZR
	 ZZGOvgwBU/yhHrHcFQfsZ+hmvX8K71rX2FnFYIwQgB6QBhEFAwvpyGSA0HPaCVwd4n
	 /Ywpg0U0PbWhONeEQ0/ieuhFHRZw8YZQ0Y3kE0bkiSDW5ZfVi6rgbKCQH+giXQxMT+
	 iLs45IxrX31Mw==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Simon Xue <xxm@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 1/5] PCI: dw-rockchip: Wait PCIE_RESET_CONFIG_DEVICE_WAIT_MS after link-up IRQ
Date: Thu, 12 Jun 2025 13:49:24 +0200
Message-ID: <20250612114923.2074895-8-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612114923.2074895-7-cassel@kernel.org>
References: <20250612114923.2074895-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; i=cassel@kernel.org; h=from:subject; bh=1Tm3QIXGlVl6CARF7272tS5RzBN9w6RAQBcJlB7/0jQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDK89h0Xvi9aP31JscEbvj+XlVs3r5M5OI9hm/SPf/ePS Umt0vC37ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEvE4wMjTIvctyj7qocH39 M+HgRabiHt5fp516y1+1Va94cswGyzBGhgNO6eUfj1w4Gh+quipd5VbIwlOMaRd/SUetf/A2JvH mGx4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Per PCIe r6.0, sec 6.6.1, software must generally wait a minimum of
100ms (PCIE_RESET_CONFIG_DEVICE_WAIT_MS) after Link training completes
before sending a Configuration Request.

Prior to ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since
we can detect Link Up"), dw-rockchip used dw_pcie_wait_for_link(),
which waited between 0 and 90ms after the link came up before we
enumerate the bus, and this was apparently enough for most devices.

After ec9fd499b9c6, rockchip_pcie_rc_sys_irq_thread() started
enumeration immediately when handling the link-up IRQ, and devices
(e.g., Laszlo Fiat's PLEXTOR PX-256M8PeGN NVMe SSD) may not be ready
to handle config requests yet.

Delay PCIE_RESET_CONFIG_DEVICE_WAIT_MS after the link-up IRQ before
starting enumeration.

Cc: Laszlo Fiat <laszlo.fiat@proton.me>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 93171a392879..8a068fd4f867 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -458,6 +458,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
 		if (rockchip_pcie_link_up(pci)) {
+			msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);
 			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
 			/* Rescan the bus to enumerate endpoint devices */
 			pci_lock_rescan_remove();
-- 
2.49.0


