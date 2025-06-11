Return-Path: <linux-pci+bounces-29426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D76EAD530C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 13:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA72C460945
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7285283FEF;
	Wed, 11 Jun 2025 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRWqPvJc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2023283FE7
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639222; cv=none; b=cITfzE/nppv6KDAemy2QYYjNNleQnVzLThiiojp3fvPoC/F4xSmawE/k4TJXKIAV7Rn/0H2fGmMRqM3LQX67ZSiouA/GCj4Bh7HtncnWkYtih6S/MCTUavaMmF8WwP86IviiITqgzM2ZQGNO4z5gBmbqFCgsHys73DDiPT5zdrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639222; c=relaxed/simple;
	bh=RjGMQwNSWCZEFnr1KtbG8zsYIWeufEBEVG9ZPVbFPDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9G8WVRxUHWkLlXSj2t+dfLnW1TY6YVOOpGIV/1P1sMHd0KAzDhh6ptc/4atrfR4Lxrkt8g7GiY3XAGma1ps3vNimqmiU8hwysusVsXOsvlenU1Tntuo7mN0k6LOaeNQhn/btJU6cZ91+/YgdYXX1Ysx+SaiRx6OZbJBO+dUeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRWqPvJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F3CC4CEF2;
	Wed, 11 Jun 2025 10:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639222;
	bh=RjGMQwNSWCZEFnr1KtbG8zsYIWeufEBEVG9ZPVbFPDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRWqPvJcRunolzJQuBXOV/kXT0wuyLr38cocFfFQYWlHioHigw7fskH/9nZ1XTmV4
	 zbzHAU5rcoNMmnjaNWv7w41tr6KyDG29eS5ZQ2FVmmoDn4v1toFRfjujIdXSu8yYmm
	 MC+WFaNvHgOOdOuSKKeaTcYZCtaIUshrQvVL1b6Zun7sX1sgUECHtkvMba7yQlYSX9
	 EqpukKd2r04MQsVDtEyNrDS3LU0tuvB6d2WFkF138C8bDJFAdnEWrh5kPFrWX0AbEd
	 akaRsNUj+EJ9wHMJ1+cemihTmV5oBbt41A1w23ye6dXMveltSr2msMn/bAgYBJLLSb
	 91c/F0v/IL6LQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 1/4] PCI: dw-rockchip: Do not enumerate bus before endpoint devices are ready
Date: Wed, 11 Jun 2025 12:51:42 +0200
Message-ID: <20250611105140.1639031-7-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611105140.1639031-6-cassel@kernel.org>
References: <20250611105140.1639031-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179; i=cassel@kernel.org; h=from:subject; bh=RjGMQwNSWCZEFnr1KtbG8zsYIWeufEBEVG9ZPVbFPDw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI84/fm7D7B80R4OZ9Gz6Ivf4IrLP2zansvVimoTE07E hRckvuzo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABPpesvwP5mpPNqxjcfh76x5 Rk5V67WjNjOo9R5MEdj3zPH2y1kfGBkZVky5ntBz7FCZ78q1nsvmfZtylOfDmWbuTc+yt0m4fBQ JZgQA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
and instead enumerate the bus directly after receiving the Link Up IRQ.

This means that there is no longer any delay between link up and the bus
getting enumerated.

As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
training completes before sending a Configuration Request.

Add this delay in the threaded link up IRQ handler in order to satisfy
the requirements of the PCIe spec.

Laszlo Fiat reported (off-list) that his PLEXTOR PX-256M8PeGN NVMe SSD is
no longer functional, and simply reverting commit ec9fd499b9c6 ("PCI:
dw-rockchip: Don't wait for link since we can detect Link Up") makes his
SSD functional again. Adding the 100 ms delay as required by the spec also
makes the SSD functional again.

Cc: Laszlo Fiat <laszlo.fiat@proton.me>
Fixes: ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can detect Link Up")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 93171a392879..a941a239cbfc 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -459,6 +459,13 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
 		if (rockchip_pcie_link_up(pci)) {
 			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
+			/*
+			 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
+			 * supports Link speeds greater than 5.0 GT/s, software
+			 * must wait a minimum of 100 ms after Link training
+			 * completes before sending a Configuration Request.
+			 */
+			msleep(PCIE_T_RRS_READY_MS);
 			/* Rescan the bus to enumerate endpoint devices */
 			pci_lock_rescan_remove();
 			pci_rescan_bus(pp->bridge->bus);
-- 
2.49.0


