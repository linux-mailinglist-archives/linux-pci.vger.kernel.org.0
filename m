Return-Path: <linux-pci+bounces-38916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9199BF7732
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78708188BEAA
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1B82F3602;
	Tue, 21 Oct 2025 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cA29zc+Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0833970C
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061410; cv=none; b=Q7VPqRGARwh99JqLfq4ELoLmG8pnbW8CMmG8Do59XkbVOwXSTVpUIFNo2JBa+PG4Rq9GC13f+LOiYQF+TqKCWkCpozmpK0N6+trb7n1BjYCGEuXV1mVPy5hAKerS6SW6OzWj5SYHSOR5i3VJ2oOfTtrJafnQIAKSKGtxiAurHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061410; c=relaxed/simple;
	bh=c03oTwFBQSEBiaihcTIwU7OVEhvmBnpOrFANvcX0NM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWW2HJRrf/Txntos/jcvZ7oe/eXs4TMrrLnQFAB2RB8Dn4iWd6KsTAu/tzMEl6JNGrOrst0aPOm0/bbk95UC9PHPoZYb3fSYIMPI8IR0rhIxDMKIzR2GTve5nHa9LowTRK2U0N1Ehpe4zeuwnPwTdF8X7O/25TQtK91w3NVDNFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cA29zc+Z; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4crc5S2PH5z9tkX;
	Tue, 21 Oct 2025 17:43:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761061404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DEiXUNqrxwhAoubTxf7AOfXPM2fdrp3xwSuMcbGNCAw=;
	b=cA29zc+ZV34lMEaOkNqnp+6KCwBLMMijDNCEg0zlglAHIKKguiokI+LI3gQxT0n89OKi3o
	ca1yoRo90Uv+j7ImdalrdQC7Z79ycG3hDmfv8WH5bkgSxuGKObfAZ0EzucX7lUrcIzIBD9
	UPDTd+ka6CALIHDH0ffmqr7n7Pp/WRG6nUQI/ON3nq5W+7pPOhAPzb7AdqbYnYzjeMyEpS
	ChTqAQfXHsbZLNMbCVIJ7OlkcmA5TqUO2sZUFye7Qd+Uff1Gafx9TZbwQvbJkpTeMLiERZ
	1DFrWge//h653PZRsPO2cxGMRNDymMz+/TPkTYM/rWjANGW2DOxVPC/x6KZXfw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: linux-pci@vger.kernel.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ravi Kumar Bandi <ravib@amazon.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] PCI: pcie-xilinx-dma-pl: Fix off-by-one INTx IRQ handling
Date: Tue, 21 Oct 2025 17:43:22 +0200
Message-ID: <20251021154322.973640-1-stefan.roese@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ae69867699a3dd26ca0
X-MBO-RS-META: 3qaghuje35tq8mdtqp13yhtpw7q1ffgf

While testing with NVMe drives connected to the Versal QDMA PL PCIe RP
on our platform I noticed that with MSI disabled (e.g. via pci=nomsi)
the NVMe interrupts are not delivered to the host CPU resulting in
timeouts while probing.

Debugging has shown, that the hwirq numbers passed to this device driver
(1...4, 1=INTA etc) need to get adjusted to match the numbers in the
controller registers bits (0...3).

This patch now adds pci_irqd_intx_xlate to the INTx IRQ domain ops,
handling this IRQ number translation correctly.

Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
Cc: Sean Anderson <sean.anderson@linux.dev>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Ravi Kumar Bandi <ravib@amazon.com>
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
v2:
- Use pci_irqd_intx_xlate to handle this IRQ number translation as suggested
  by Sean (thanks again)

 drivers/pci/controller/pcie-xilinx-dma-pl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index 84888eda990b2..80095457ec531 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -370,6 +370,7 @@ static int xilinx_pl_dma_pcie_intx_map(struct irq_domain *domain,
 /* INTx IRQ Domain operations */
 static const struct irq_domain_ops intx_domain_ops = {
 	.map = xilinx_pl_dma_pcie_intx_map,
+	.xlate = pci_irqd_intx_xlate,
 };
 
 static irqreturn_t xilinx_pl_dma_pcie_msi_handler_high(int irq, void *args)
-- 
2.51.1


