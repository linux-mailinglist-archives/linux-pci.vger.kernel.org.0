Return-Path: <linux-pci+bounces-18449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223B09F21C3
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 03:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502971655E6
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 02:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB349653;
	Sun, 15 Dec 2024 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb1gRtGe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A63101DE
	for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734229695; cv=none; b=sgJJ2ci7xZE/MSrG6me52SSxClvA6FjF/fZ8WVFgsizTGGC9oI5zOaBqy6Ep42BrsNZ7kFy67QeKjcskN/SDhTiyAYGbwoMnVm8iBvzsj7pMFMGWw2mT9YzaXPdi5qIlur8IT0w3JUqg6Glcul7FWOEErnzQcD85H+foSAcQZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734229695; c=relaxed/simple;
	bh=qru+AOS/8uuKmmmZjpWrY3Rjsz2wmCGiju9BgTCmTRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMcY49ij1gmX4jCQfx8tQ+xJoBLVd5DDhHMr33Dqka3uEMBDHcKfAEgE7SaDn2vlYjJenWDjkqjVJmY8RZ3eRds6t7tztE1jIOV+KFjurflm8fpxM191Nves+PkNoXy+xX++ew5sxlHnE3+Gg8Y2ZhPjIb9/6rH4XRORWq+fSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb1gRtGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C511FC4CED1;
	Sun, 15 Dec 2024 02:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734229695;
	bh=qru+AOS/8uuKmmmZjpWrY3Rjsz2wmCGiju9BgTCmTRY=;
	h=From:To:Cc:Subject:Date:From;
	b=Hb1gRtGePuEmApeK1HIcnxcey/ZaJMMm9lp74CFl6gc6NZqUzuvhLLBLBIFw1IOHd
	 h0rRm6p6pvEsif6sLfpckDsW2D5bG3wM7iGnV5FPBdwqeN3p4DHe6E6mWpMzkABUUS
	 BSZyvQ8F2Z4Kd5oC0wkW13oXjDVRBsYTFu03HtU8z2gSlJEWnkqp6+dwywqTMqguQ0
	 06KZEYBJUyFMGxD4DObay2w9L6/6WhZeQro6sMdNPA/qcVATMMCBe2LbmcB5AKe7Mb
	 5ubSLZHR7lsBHgFvbH6TpRRPYxGnNy6jqWwxzo49/3jz4yh0WFuBkcqon3AlRDRpfA
	 cLC4hgGMzqqxw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH] PCI: rockchip: Add missing fields descriptions for struct rockchip_pcie_ep
Date: Sun, 15 Dec 2024 11:28:13 +0900
Message-ID: <20241215022813.35381-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling the rockchip endpoint driver with -W=1, gcc output the
following warnings:

drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'perst_irq' not described in 'rockchip_pcie_ep'
drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'perst_asserted' not described in 'rockchip_pcie_ep'
drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'link_up' not described in 'rockchip_pcie_ep'
drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'link_training' not described in 'rockchip_pcie_ep'

Avoid these warnings by adding the missing field descriptions in
struct rockchip_pcie_ep kdoc comment.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Fixes: a7137cbf6bd5 ("PCI: rockchip-ep: Handle PERST# signal in EP mode")
Fixes: bd6e61df4b2e ("PCI: rockchip-ep: Improve link training")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 1064b7b06cef..36b868530769 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -40,6 +40,10 @@
  * @irq_pci_fn: the latest PCI function that has updated the mapping of
  *		the MSI/INTX IRQ dedicated outbound region.
  * @irq_pending: bitmask of asserted INTX IRQs.
+ * @perst_irq: IRQ used for perst# signal.
+ * @perst_asserted: perst# signal state (true if perst# was asserted).
+ * @link_up: PCI link state (true if the link is up).
+ * @link_training: Work item to execute link training.
  */
 struct rockchip_pcie_ep {
 	struct rockchip_pcie	rockchip;
-- 
2.47.1


