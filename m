Return-Path: <linux-pci+bounces-38901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9F0BF6D61
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B565C3A6A37
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4584D337B83;
	Tue, 21 Oct 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iTJ89IwC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84C338919
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054017; cv=none; b=aNFNr3WcOhLahCEym/rrzgPjOotlv0b3GYHl5w02ketANQXfTdBqg+e7fyjwTCNNWtc91Y3O7+E3uSGhiMq5PK4Vdc2j1XuAyaPpISS1qn/bHXlNPwz1WIRjOklmDdiI4MnqA0cAxR5WFxy+a0yvCWpMy7oaSy28khbRos3+5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054017; c=relaxed/simple;
	bh=quHBlOjW5FOE7F674RH51zp2o9xPSlQgNhInbpXd2ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uMumt9bmjrpbuNewy9U//ISlhLc9Pjwy19KjTSYSYdg4ztNUGChole0SCSFwIbqiBRpJPLrWiLy7/1B9Nzr6vDzn5RNuj8SnKUBUdpd8TAVqToA+430H+Ozd1qq8Jxhi28qUEeQJA31sR6g8/xEjTHJ9OnP6hC8s9RnLKCI2IOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iTJ89IwC; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4crYM63NXWz9tbv;
	Tue, 21 Oct 2025 15:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761054002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pRxUKp5Dk8n/F/9qpZs047jk1viLAu22xYdNA6aGKtM=;
	b=iTJ89IwCwrHBF2VxpYxaSj6Kk7IQYaPg7nZ0kuSWzULNpORcj1dbFZmZSPF677d6vacylg
	4PJci82Ec36rQh5RUZSw2adPgsTCkJY0u2yaTbZaMWcD3OllHdPlnUBxCuR6w/97EYUAsH
	leKThlIwEhZ9Qdauhw6BHv/SnrOFFIq4LkJW+lCRXS8NJ9lddPguCy7ZBM/T0hziCJSBLl
	BzK1ZO9lZ5O8nve+qSxxu16y3lATeWzqRW9+hjHUgIt79ti0wcCvIDVq8ZGFTNfR6VkuIl
	q+y6bWRCAXCOrXG8x74Fl+SUUEyjlkBkrokPWfyCvCLfSUjUtA0Dc/MLsQN7UA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: linux-pci@vger.kernel.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ravi Kumar Bandi <ravib@amazon.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: pcie-xilinx-dma-pl: Fix off-by-one INTx IRQ handling
Date: Tue, 21 Oct 2025 15:39:58 +0200
Message-ID: <20251021133958.802464-1-stefan.roese@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d6aa9af8b530beb5e5f
X-MBO-RS-META: kdmpnfadxchdzcq9cu47o6jitjtu7wsa

While testing with NVMe drives connected to the Versal QDMA PL PCIe RP
on our platform I noticed that with MSI disabled (e.g. via pci=nomsi)
the NVMe interrupts are not delivered to the host CPU resulting in
timeouts while probing.

Debugging has shown, that the hwirq numbers passed to this device driver
(1...4, 1=INTA etc) need to get adjusted to match the numbers in the
controller registers bits (0...3). This patch now correctly matches the
hwirq number to the PCIe controller register bits.

Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
Cc: Sean Anderson <sean.anderson@linux.dev>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Ravi Kumar Bandi <ravib@amazon.com>
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pcie-xilinx-dma-pl.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index 84888eda990b2..5cca9d018bc89 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -331,7 +331,12 @@ static void xilinx_mask_intx_irq(struct irq_data *data)
 	unsigned long flags;
 	u32 mask, val;
 
-	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
+	/*
+	 * INTx hwirq: 1=INTA, 2=INTB, 3=INTC, 4=INTD
+	 * In the controller regs this is represented in bits 0...3, so we need
+	 * to subtract 1 here
+	 */
+	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT - 1);
 	raw_spin_lock_irqsave(&port->lock, flags);
 	val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
 	pcie_write(port, (val & (~mask)), XILINX_PCIE_DMA_REG_IDRN_MASK);
@@ -344,7 +349,12 @@ static void xilinx_unmask_intx_irq(struct irq_data *data)
 	unsigned long flags;
 	u32 mask, val;
 
-	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
+	/*
+	 * INTx hwirq: 1=INTA, 2=INTB, 3=INTC, 4=INTD
+	 * In the controller regs this is represented in bits 0...3, so we need
+	 * to subtract 1 here
+	 */
+	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT - 1);
 	raw_spin_lock_irqsave(&port->lock, flags);
 	val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
 	pcie_write(port, (val | mask), XILINX_PCIE_DMA_REG_IDRN_MASK);
@@ -620,8 +630,13 @@ static irqreturn_t xilinx_pl_dma_pcie_intx_flow(int irq, void *args)
 	val = FIELD_GET(XILINX_PCIE_DMA_IDRN_MASK,
 			pcie_read(port, XILINX_PCIE_DMA_REG_IDRN));
 
+	/*
+	 * INTx hwirq: 1=INTA, 2=INTB, 3=INTC, 4=INTD
+	 * In the controller regs this is represented in bits 0...3, so we need
+	 * to add 1 here again for the registered handler
+	 */
 	for_each_set_bit(i, &val, PCI_NUM_INTX)
-		generic_handle_domain_irq(port->intx_domain, i);
+		generic_handle_domain_irq(port->intx_domain, i + 1);
 	return IRQ_HANDLED;
 }
 
-- 
2.51.1


