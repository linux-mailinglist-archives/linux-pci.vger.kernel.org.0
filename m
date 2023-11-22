Return-Path: <linux-pci+bounces-93-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA8D7F3DDD
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565171C20D93
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8112156D9;
	Wed, 22 Nov 2023 06:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRMUn3mS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92022154B3
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C033EC433C7;
	Wed, 22 Nov 2023 06:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633063;
	bh=FOItfK0/TleRXZ8c4i5tcrXPO+r2f9Ha8yqtGdMWaLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRMUn3mS6uYKq7BSnEUEEL7kfQ9IOFskSQQd+d+wnIQj61Eozbr3Y58+u/wQSTwrm
	 NEVzW5Wvfg+DazJcffx+kdJsvL9ZusFPyVK3UYrctU92RTwZLauWAdh48oHD33nDUF
	 Lz0/NA7g6j2khvme9gZklaHbXB6IpzrADzn/xKBO0WXw/3JDY/waoVWiGqdg7SbY8P
	 DQZbigPO6pVy4TnPv2NpOtdxjojACooVA9is6cZLmUXrD9Obz/K/mSkqbTfceYaM7Y
	 tFHkipFjchnRclG1u28A5j98JomSK7cSQOPrwLXmz1/WNo03cauhakZZI5l9E9Ihx7
	 nxVMJv5SgE3lQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 08/16] PCI: cadence: Use INTX instead of legacy
Date: Wed, 22 Nov 2023 15:03:58 +0900
Message-ID: <20231122060406.14695-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the Cadence endpoint controller driver, rename the function
cdns_pcie_ep_send_legacy_irq() to cdns_pcie_ep_send_intx_irq() to match
the macro PCI_IRQ_INTX name. Related comments and messages mentioning
"legacy" are also changed to refer to "intx".

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 10 +++++-----
 drivers/pci/controller/cadence/pcie-cadence.h    | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 3d71d687ea64..2d0a8d78bffb 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -360,8 +360,8 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
 	writel(0, ep->irq_cpu_addr + offset);
 }
 
-static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
-					u8 intx)
+static int cdns_pcie_ep_send_intx_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
+				      u8 intx)
 {
 	u16 cmd;
 
@@ -371,7 +371,7 @@ static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 
 	cdns_pcie_ep_assert_intx(ep, fn, intx, true);
 	/*
-	 * The mdelay() value was taken from dra7xx_pcie_raise_legacy_irq()
+	 * The mdelay() value was taken from dra7xx_pcie_raise_intx_irq()
 	 */
 	mdelay(1);
 	cdns_pcie_ep_assert_intx(ep, fn, intx, false);
@@ -541,10 +541,10 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 	switch (type) {
 	case PCI_IRQ_INTX:
 		if (vfn > 0) {
-			dev_err(dev, "Cannot raise legacy interrupts for VF\n");
+			dev_err(dev, "Cannot raise INTX interrupts for VF\n");
 			return -EINVAL;
 		}
-		return cdns_pcie_ep_send_legacy_irq(ep, fn, vfn, 0);
+		return cdns_pcie_ep_send_intx_irq(ep, fn, vfn, 0);
 
 	case PCI_IRQ_MSI:
 		return cdns_pcie_ep_send_msi_irq(ep, fn, vfn, interrupt_num);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 373cb50fcd15..03b96798f858 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -347,16 +347,16 @@ struct cdns_pcie_epf {
  * @max_regions: maximum number of regions supported by hardware
  * @ob_region_map: bitmask of mapped outbound regions
  * @ob_addr: base addresses in the AXI bus where the outbound regions start
- * @irq_phys_addr: base address on the AXI bus where the MSI/legacy IRQ
+ * @irq_phys_addr: base address on the AXI bus where the MSI/INTX IRQ
  *		   dedicated outbound regions is mapped.
  * @irq_cpu_addr: base address in the CPU space where a write access triggers
- *		  the sending of a memory write (MSI) / normal message (legacy
+ *		  the sending of a memory write (MSI) / normal message (INTX
  *		  IRQ) TLP through the PCIe bus.
- * @irq_pci_addr: used to save the current mapping of the MSI/legacy IRQ
+ * @irq_pci_addr: used to save the current mapping of the MSI/INTX IRQ
  *		  dedicated outbound region.
  * @irq_pci_fn: the latest PCI function that has updated the mapping of
- *		the MSI/legacy IRQ dedicated outbound region.
- * @irq_pending: bitmask of asserted legacy IRQs.
+ *		the MSI/INTX IRQ dedicated outbound region.
+ * @irq_pending: bitmask of asserted INTX IRQs.
  * @lock: spin lock to disable interrupts while modifying PCIe controller
  *        registers fields (RMW) accessible by both remote RC and EP to
  *        minimize time between read and write
@@ -374,7 +374,7 @@ struct cdns_pcie_ep {
 	u64			irq_pci_addr;
 	u8			irq_pci_fn;
 	u8			irq_pending;
-	/* protect writing to PCI_STATUS while raising legacy interrupts */
+	/* protect writing to PCI_STATUS while raising INTX interrupts */
 	spinlock_t		lock;
 	struct cdns_pcie_epf	*epf;
 	unsigned int		quirk_detect_quiet_flag:1;
-- 
2.42.0


