Return-Path: <linux-pci+bounces-23176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B87EA57640
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 00:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76256177D0B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 23:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5F821505E;
	Fri,  7 Mar 2025 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTVoSv90"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEDE21504D;
	Fri,  7 Mar 2025 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390685; cv=none; b=egY5HiVNphTWpOFlF6ePHsSyZ8h1f1hlnjLJp29Rb69YFtK6BOyl0VbOvSNqf5tThzk2L4dvacqSm7PhMdonOf46SWMJlneA9og7PeEyRlCnhDVg+YOXmSUu+1tdQsbBr/b7rDLCUmQt3E9bPksnYkciJjd4Zd3C1S0OFvI2ixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390685; c=relaxed/simple;
	bh=awyxVGLYLrPGk2ph0vC9xWww4UwkrrLl5cXRfJqJlA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWXuyJREzcnRtiq624hd5bmR/J+rxp0wzZCg4R0vRBZeLaTpIXLwjFBwJo1hMm4lvco5A4JH7MUtnKV40CNKZGgP4NOOlB65D6pdRpL4Cn3VB7LSHaXlVn2HUzKNG6yAp/cc1Si/Bu2OPWE2w8EfCVyPoM7kc8plG7JvQtPc/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTVoSv90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CD0C4CEE9;
	Fri,  7 Mar 2025 23:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741390684;
	bh=awyxVGLYLrPGk2ph0vC9xWww4UwkrrLl5cXRfJqJlA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CTVoSv901qPSH0kq0SRi45h38A2I+kzNId6N7kN8mUDSfb6d97vw8m4klIvm5tqeU
	 GAAPZ5h8bTAR47cLw04L8I7NjH5O/CDqd25IsGFixaVCi5ZEhO4yXYmreSFZzmYMrK
	 XaHNENqH+Q/S6PlDJq0DxFh0/6b+0WoOEf2ZXcZhM2du4yDrJASDBW4+8oX8QNwjdN
	 p54qwFQwhzKPPTNYZw6cjZYMCH1dPSzf3d1OomHr3NmfONYvc+Yfozq1yDf9csiFzw
	 uL8QR7UnDcubB4ogUeQwavpsm9bsM3+0DxVajnJXq4IXlJIuaAT4Ry1NxjECm27jxA
	 wcuiivr40Jl9w==
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
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/4] PCI: dwc: Use parent_bus_offset
Date: Fri,  7 Mar 2025 17:37:44 -0600
Message-Id: <20250307233744.440476-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307233744.440476-1-helgaas@kernel.org>
References: <20250307233744.440476-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

We know the parent_bus_offset, either computed from a DT reg property (the
offset is the CPU physical addr - the 'config' address on the parent bus)
or from a .cpu_addr_fixup() (which may have used a host bridge window
offset).

Apply that parent_bus_offset instead of calling .cpu_addr_fixup() again.

This assumes that all intermediate addresses are at the same offset from
the CPU physical addresses.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
 drivers/pci/controller/dwc/pcie-designware.c      |  3 ---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e22f650ada5a..3378f905b3bd 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -670,7 +670,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 		type = PCIE_ATU_TYPE_CFG1;
 
 	atu.type = type;
-	atu.parent_bus_addr = pp->cfg0_base;
+	atu.parent_bus_addr = pp->cfg0_base - pp->parent_bus_offset;
 	atu.pci_addr = busdev;
 	atu.size = pp->cfg0_size;
 
@@ -695,7 +695,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.parent_bus_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base - pp->parent_bus_offset;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -721,7 +721,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.parent_bus_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base - pp->parent_bus_offset;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -790,7 +790,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 		atu.index = i;
 		atu.type = PCIE_ATU_TYPE_MEM;
-		atu.parent_bus_addr = entry->res->start;
+		atu.parent_bus_addr = entry->res->start - pp->parent_bus_offset;
 		atu.pci_addr = entry->res->start - entry->offset;
 
 		/* Adjust iATU size if MSG TLP region was allocated before */
@@ -812,7 +812,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows > ++i) {
 			atu.index = i;
 			atu.type = PCIE_ATU_TYPE_IO;
-			atu.parent_bus_addr = pp->io_base;
+			atu.parent_bus_addr = pp->io_base - pp->parent_bus_offset;
 			atu.pci_addr = pp->io_bus_addr;
 			atu.size = pp->io_size;
 
@@ -956,7 +956,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	atu.size = resource_size(pci->pp.msg_res);
 	atu.index = pci->pp.msg_atu_index;
 
-	atu.parent_bus_addr = pci->pp.msg_res->start;
+	atu.parent_bus_addr = pci->pp.msg_res->start - pci->pp.parent_bus_offset;
 
 	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 9d0a5f75effc..640caf4a084f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -474,9 +474,6 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	u32 retries, val;
 	u64 limit_addr;
 
-	if (pci->ops && pci->ops->cpu_addr_fixup)
-		parent_bus_addr = pci->ops->cpu_addr_fixup(pci, parent_bus_addr);
-
 	limit_addr = parent_bus_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
-- 
2.34.1


