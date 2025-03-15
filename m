Return-Path: <linux-pci+bounces-23855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EF9A6324D
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5177F1896F46
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 20:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B909B1A3166;
	Sat, 15 Mar 2025 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5HYG25E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856EB1A2C25;
	Sat, 15 Mar 2025 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742069759; cv=none; b=M5+G5fvtS7O71qG3y/2oB0UYK4u+M6J+QRRdJJHni0+Sv6RKCAFzsAlDiFSc/e2d+HjoE7FmQj+jhPN2xqVCVAAukPucvIWhHh9S3LBEv3Em6y5GeSwskzNdxUKcCkInCWAsg3mcDRuNFjX/dmKhj/ZU94WgLyYGbT0Fy/mTL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742069759; c=relaxed/simple;
	bh=rOlsc+GGzB2aYXZ49m6zU2To6v3eliDaWnvb/ilsx14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sqMbUQfmQEaz2/YMgtSgci8LRadpKak8shE31pvGgqKd9NsuwAR/PHJA6mhfv4SjMJ5uWQmgfNvBG4VuYKTICjLKvYTGAexfHfK8G4rxC+qwmcqCIx3zi4rLpPHPLqt1+c3LvvDaP6k0Qo/KnGSqxLWhFgDppcNARNBYLnpbFJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5HYG25E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34E7C4CEF0;
	Sat, 15 Mar 2025 20:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742069759;
	bh=rOlsc+GGzB2aYXZ49m6zU2To6v3eliDaWnvb/ilsx14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5HYG25EBU4jr0G4lhZjmVbRFXMZN96cfKNGuD+Z8g4PG2QJ1+Ug5vztVtZoSdMKO
	 wdkTOhhKsVhjnZva8rx7IHyuvx5YcS7tvP+8rNCnHu6vBSRxe4cWEp8ettGPblHPkr
	 SPaMfUt64MXKLMoHX8YAZQgKukr9IY/42RDnIrIW31ujhhj6nNpvRmSeIvod2RXWfk
	 /ICiyOY0oEJ4AmnUTwDRHv2kNB6g8yYFeQiluEbQW6wS6e5eFOu5M1yMFP78jo6jgj
	 c+E2KEKIfB2kgQvowj6bB0wB5OK/QSDhs54LDm+4XhE/xeIQ5hJlVK+OeKRTQFzIa/
	 nTr3A+84njcJA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 02/13] PCI: dwc: Rename cpu_addr to parent_bus_addr for ATU configuration
Date: Sat, 15 Mar 2025 15:15:37 -0500
Message-Id: <20250315201548.858189-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250315201548.858189-1-helgaas@kernel.org>
References: <20250315201548.858189-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

Rename 'cpu_addr' to 'parent_bus_addr' in the DesignWare ATU configuration.

The ATU translates parent bus addresses to PCI addresses, which are often
the same as CPU addresses but can differ in systems where the bus fabric
translates addresses before passing them to the PCIe controller. This
renaming clarifies the purpose and avoids confusion.

Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-2-01d2313502ab@nxp.com
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   |  8 ++---
 .../pci/controller/dwc/pcie-designware-host.c | 12 +++----
 drivers/pci/controller/dwc/pcie-designware.c  | 34 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  |  7 ++--
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8e07d432e74f..80ac2f9e88eb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -128,7 +128,7 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 
 static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
-				  dma_addr_t cpu_addr, enum pci_barno bar,
+				  dma_addr_t parent_bus_addr, enum pci_barno bar,
 				  size_t size)
 {
 	int ret;
@@ -146,7 +146,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	}
 
 	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
-					  cpu_addr, bar, size);
+					  parent_bus_addr, bar, size);
 	if (ret < 0) {
 		dev_err(pci->dev, "Failed to program IB window\n");
 		return ret;
@@ -181,7 +181,7 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
 		return ret;
 
 	set_bit(free_win, ep->ob_window_map);
-	ep->outbound_addr[free_win] = atu->cpu_addr;
+	ep->outbound_addr[free_win] = atu->parent_bus_addr;
 
 	return 0;
 }
@@ -333,7 +333,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.cpu_addr = addr;
+	atu.parent_bus_addr = addr;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ae3fd2a5dbf8..1206b26bff3f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -616,7 +616,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 		type = PCIE_ATU_TYPE_CFG1;
 
 	atu.type = type;
-	atu.cpu_addr = pp->cfg0_base;
+	atu.parent_bus_addr = pp->cfg0_base;
 	atu.pci_addr = busdev;
 	atu.size = pp->cfg0_size;
 
@@ -641,7 +641,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.cpu_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -667,7 +667,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.cpu_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -736,7 +736,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 		atu.index = i;
 		atu.type = PCIE_ATU_TYPE_MEM;
-		atu.cpu_addr = entry->res->start;
+		atu.parent_bus_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
 
 		/* Adjust iATU size if MSG TLP region was allocated before */
@@ -758,7 +758,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows > ++i) {
 			atu.index = i;
 			atu.type = PCIE_ATU_TYPE_IO;
-			atu.cpu_addr = pp->io_base;
+			atu.parent_bus_addr = pp->io_base;
 			atu.pci_addr = pp->io_bus_addr;
 			atu.size = pp->io_size;
 
@@ -902,7 +902,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	atu.size = resource_size(pci->pp.msg_res);
 	atu.index = pci->pp.msg_atu_index;
 
-	atu.cpu_addr = pci->pp.msg_res->start;
+	atu.parent_bus_addr = pci->pp.msg_res->start;
 
 	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072..9d0a5f75effc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -470,25 +470,25 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      const struct dw_pcie_ob_atu_cfg *atu)
 {
-	u64 cpu_addr = atu->cpu_addr;
+	u64 parent_bus_addr = atu->parent_bus_addr;
 	u32 retries, val;
 	u64 limit_addr;
 
 	if (pci->ops && pci->ops->cpu_addr_fixup)
-		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
+		parent_bus_addr = pci->ops->cpu_addr_fixup(pci, parent_bus_addr);
 
-	limit_addr = cpu_addr + atu->size - 1;
+	limit_addr = parent_bus_addr + atu->size - 1;
 
-	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
-	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
+	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
+	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
 	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
 		return -EINVAL;
 	}
 
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
-			      lower_32_bits(cpu_addr));
+			      lower_32_bits(parent_bus_addr));
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
-			      upper_32_bits(cpu_addr));
+			      upper_32_bits(parent_bus_addr));
 
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
 			      lower_32_bits(limit_addr));
@@ -502,7 +502,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      upper_32_bits(atu->pci_addr));
 
 	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
-	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
+	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
 	if (dw_pcie_ver_is(pci, 490A))
@@ -545,13 +545,13 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 index, u32 reg
 }
 
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
-			     u64 cpu_addr, u64 pci_addr, u64 size)
+			     u64 parent_bus_addr, u64 pci_addr, u64 size)
 {
 	u64 limit_addr = pci_addr + size - 1;
 	u32 retries, val;
 
 	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
-	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
+	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
 	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
 		return -EINVAL;
 	}
@@ -568,9 +568,9 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 				      upper_32_bits(limit_addr));
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(cpu_addr));
+			      lower_32_bits(parent_bus_addr));
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(cpu_addr));
+			      upper_32_bits(parent_bus_addr));
 
 	val = type;
 	if (upper_32_bits(limit_addr) > upper_32_bits(pci_addr) &&
@@ -597,18 +597,18 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 }
 
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				int type, u64 cpu_addr, u8 bar, size_t size)
+				int type, u64 parent_bus_addr, u8 bar, size_t size)
 {
 	u32 retries, val;
 
-	if (!IS_ALIGNED(cpu_addr, pci->region_align) ||
-	    !IS_ALIGNED(cpu_addr, size))
+	if (!IS_ALIGNED(parent_bus_addr, pci->region_align) ||
+	    !IS_ALIGNED(parent_bus_addr, size))
 		return -EINVAL;
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(cpu_addr));
+			      lower_32_bits(parent_bus_addr));
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(cpu_addr));
+			      upper_32_bits(parent_bus_addr));
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL1, type |
 			      PCIE_ATU_FUNC_NUM(func_no));
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 501d9ddfea16..d0d8c622a6e8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -343,7 +343,7 @@ struct dw_pcie_ob_atu_cfg {
 	u8 func_no;
 	u8 code;
 	u8 routing;
-	u64 cpu_addr;
+	u64 parent_bus_addr;
 	u64 pci_addr;
 	u64 size;
 };
@@ -491,9 +491,10 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci);
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      const struct dw_pcie_ob_atu_cfg *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
-			     u64 cpu_addr, u64 pci_addr, u64 size);
+			     u64 parent_bus_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				int type, u64 cpu_addr, u8 bar, size_t size);
+				int type, u64 parent_bus_addr,
+				u8 bar, size_t size);
 void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
 void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
-- 
2.34.1


