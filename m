Return-Path: <linux-pci+bounces-18503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E029F319E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 14:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76E4188A1A1
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBB0205AA7;
	Mon, 16 Dec 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI6RXtT+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766C8204597
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356047; cv=none; b=ASYwvHBE3X5SfUtry8+H9lrYi+tsX6EgLqDxol08GHY4393XAPuNX4XUz3SqromZ3JzTf25hdZWWjQCWsdG8nLXKhavl2r38cTR+j+dMSwWg/QMOE/lhtBOcXhDlnh5GuFzTthvpJIcNl4P3uvDgan7tQPoKrWVvqA+3bdfKWNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356047; c=relaxed/simple;
	bh=aVPfQEFKL+WfSXiGb62W4d7FMVnQGVx6W7koXWJ+C7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pB0dEFSVIWXAuaXLN99cQg/g00cmJb3ia2DbaUAg9lilg6ysmmvkEqDx8NyBblacL49Os8uuo9LrvVnN9MRrA5tQa8tHQhj5v8h+1Fnfuli036dsWvt+j4ebRP0FkhtQNzMBNoFE/wAgUgNFZTvUt++Nm7+OCTJhYepWmoEnNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI6RXtT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F178C4CED0;
	Mon, 16 Dec 2024 13:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734356046;
	bh=aVPfQEFKL+WfSXiGb62W4d7FMVnQGVx6W7koXWJ+C7g=;
	h=From:To:Cc:Subject:Date:From;
	b=dI6RXtT+Ma3oCbMsc7XVg5hWeF3LqNkc+vXVh44BCC5dMTrgRFC4SHJnQEom40UYe
	 9v3Q/u1IbkNRHtbvvZadLMYOJcHgd5EpjFrLz+CMzGUiijY63VNYYB/N/wdGjtinIo
	 40eUutOxCwyxi4JV9r40VudAdhd/jPJkNIH0Keq8AHNj5pUuHMU0rYfC4IyJgmxyuC
	 9O3KCuRuWyhwU4VEYtO25uGdxojk0D91DMbLRy/ggqclp3mDDcCvAN16/vgcgfj4S3
	 Sh3rsvPZcq2NEph86iwpM1al+c7F2/xDkBkJkVd5lFb2LKrAN2uxJkC0vltzV3gSGA
	 Zl5VypKsOhF3g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2] PCI: rockchip: Add missing fields descriptions for struct rockchip_pcie_ep
Date: Mon, 16 Dec 2024 22:34:04 +0900
Message-ID: <20241216133404.540736-1-dlemoal@kernel.org>
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
Changes from v1:
 - Addressed Manivannan's comments

 drivers/pci/controller/pcie-rockchip-ep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 1064b7b06cef..4f978a17fdbb 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -40,6 +40,10 @@
  * @irq_pci_fn: the latest PCI function that has updated the mapping of
  *		the MSI/INTX IRQ dedicated outbound region.
  * @irq_pending: bitmask of asserted INTX IRQs.
+ * @perst_irq: IRQ used for the PERST# signal.
+ * @perst_asserted: True if the PERST# signal was asserted.
+ * @link_up: True if the PCI link is up.
+ * @link_training: Work item to execute PCI link training.
  */
 struct rockchip_pcie_ep {
 	struct rockchip_pcie	rockchip;
-- 
2.47.1


