Return-Path: <linux-pci+bounces-99-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C817F3DE3
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E09B21A06
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262FF154AD;
	Wed, 22 Nov 2023 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/N272Zi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38E156E8
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72DEC433C9;
	Wed, 22 Nov 2023 06:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633073;
	bh=6ghmqRFWH1Y0lEzCAZ7p7dph9KbHBs2uX1weoyt+5tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/N272Ziqqcs35u+SfV5G6LEgMMFqe+LdmJKdA38Es1AnZ+gVee9gs9dnU3czrCfL
	 BsZoaqJ3BRLMkMihGCwWz41MQig359pY9Znd1Kh5GSZyzkelj1wPE/Jg1AVgAxj93E
	 qGmGouWfDEHDEkeAh6v9dU41GAWANEG5aZMlVCj7mk7cf+glUrByC6T3nucI+OsysE
	 Skxizw1bPtD6Bq4Z1M3fc7r+R/G9VWK7WcmjiEnpb5FWd8fl4ZlMLMVVZixaOuOvru
	 m6HI3fatbKRaGcXsJVAHhLHEH/bZwLr4U0bmGBnEc6YA5y7Hi+U4yXRLjMSwTHowec
	 gW01OyzS07RsQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 14/16] PCI: rockchip-ep: Use INTX instead of legacy
Date: Wed, 22 Nov 2023 15:04:04 +0900
Message-ID: <20231122060406.14695-15-dlemoal@kernel.org>
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

Rename the function rockchip_pcie_ep_send_legacy_irq() of the rockchip
endpoint driver to rockchip_pcie_ep_send_intx_irq(). Uses of the term
"legacy" are also replaced with "INTX" in comments.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 95b1c8ef59c3..c9046e97a1d2 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -26,16 +26,16 @@
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
  */
 struct rockchip_pcie_ep {
 	struct rockchip_pcie	rockchip;
@@ -325,8 +325,8 @@ static void rockchip_pcie_ep_assert_intx(struct rockchip_pcie_ep *ep, u8 fn,
 	}
 }
 
-static int rockchip_pcie_ep_send_legacy_irq(struct rockchip_pcie_ep *ep, u8 fn,
-					    u8 intx)
+static int rockchip_pcie_ep_send_intx_irq(struct rockchip_pcie_ep *ep, u8 fn,
+					  u8 intx)
 {
 	u16 cmd;
 
@@ -413,7 +413,7 @@ static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 
 	switch (type) {
 	case PCI_IRQ_INTX:
-		return rockchip_pcie_ep_send_legacy_irq(ep, fn, 0);
+		return rockchip_pcie_ep_send_intx_irq(ep, fn, 0);
 	case PCI_IRQ_MSI:
 		return rockchip_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
 	default:
-- 
2.42.0


