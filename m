Return-Path: <linux-pci+bounces-23865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5560A63268
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28EF1897268
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 20:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44782066E9;
	Sat, 15 Mar 2025 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3FvEGl8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400B2066DA;
	Sat, 15 Mar 2025 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742069774; cv=none; b=twdR/ATV2/8pJ+TsKEV9oda6nQ8e5SuhFgG2hgZOxTYNHJLYWAlNkguzLU/LDexEIY7vgYaL7QPbxeCWwxTIEep658L02tZ5AEGy+rOPSMuFcx86B68KofFqgnnRRiOkn8H+opVOLecIDJiVGffzh8BEZTZsBl3uJddxYPymRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742069774; c=relaxed/simple;
	bh=XAdlaYzjQoosyPBD0jLktaFmMhD16smqlC6i/QRL9zQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gnrsE06y6iIrqnRDHcsZm9xS98J8urBj72dqa/EFbtG3b0Qp9HVJdfLSyZIMZ5fdfwUfkDCsht2nLVQB9xZpXh9D6vJTw6dLgmSDs5Z1IWxo2NkuHxaFqfrLvmWngtRNTBHs9ChuD6QX2olouV13yWe6TOB7lrJfzoeJPWAjcGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3FvEGl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1BDC4CEE5;
	Sat, 15 Mar 2025 20:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742069774;
	bh=XAdlaYzjQoosyPBD0jLktaFmMhD16smqlC6i/QRL9zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3FvEGl81nS7A40m+2KG5ZddWD1/06Svf1mmASBOyFwaUhXZ7ZRj9OF1XJCf/3/q4
	 5Kk00axEgxfhKLY9Lr729RByry0acwrXCEbA2sogmqpyNI1SExTwOUIBC361pmOjFj
	 +aVNVNQcOTCKOvJXwe8RK7klRXAQN7xEKCD5db+YK5DryoBVipbmfnm1cc4RQriBg3
	 djHZ9L/NeoqRMM/ljEQzgMtM44CHEpYSsajRYG2NhIXsq7kslzErl6crWcMcWjvuJV
	 TL3dmjsvaQ89osskOFroM7I6wc8GLV4RVsEuNDPWNt60Pa5joSSElwhWXdv2KA/AWa
	 cIXiW943rMAfQ==
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
Subject: [PATCH v12 12/13] PCI: dwc: Use parent_bus_offset to remove need for .cpu_addr_fixup()
Date: Sat, 15 Mar 2025 15:15:47 -0500
Message-Id: <20250315201548.858189-13-helgaas@kernel.org>
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

We know the parent_bus_offset, either computed from a DT reg property (the
offset is the CPU physical addr - the 'config'/'addr_space' address on the
parent bus) or from a .cpu_addr_fixup() (which may have used a host bridge
window offset).

Apply that parent_bus_offset instead of calling .cpu_addr_fixup() when
programming the ATU.

This assumes all intermediate addresses are at the same offset from the CPU
physical addresses.

Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-9-01d2313502ab@nxp.com
Signed-off-by: Frank Li <Frank.Li@nxp.com>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  5 +++--
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
 drivers/pci/controller/dwc/pcie-designware.c      |  3 ---
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 2ef9964fa080..c1feaadb046a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -314,7 +314,8 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	ret = dw_pcie_find_index(ep, addr, &atu_index);
+	ret = dw_pcie_find_index(ep, addr - pci->parent_bus_offset,
+				 &atu_index);
 	if (ret < 0)
 		return;
 
@@ -333,7 +334,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.parent_bus_addr = addr;
+	atu.parent_bus_addr = addr - pci->parent_bus_offset;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9e38ac7d1bcb..d760abcbb785 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -635,7 +635,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 		type = PCIE_ATU_TYPE_CFG1;
 
 	atu.type = type;
-	atu.parent_bus_addr = pp->cfg0_base;
+	atu.parent_bus_addr = pp->cfg0_base - pci->parent_bus_offset;
 	atu.pci_addr = busdev;
 	atu.size = pp->cfg0_size;
 
@@ -660,7 +660,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.parent_bus_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -686,7 +686,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.parent_bus_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -755,7 +755,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 		atu.index = i;
 		atu.type = PCIE_ATU_TYPE_MEM;
-		atu.parent_bus_addr = entry->res->start;
+		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
 		atu.pci_addr = entry->res->start - entry->offset;
 
 		/* Adjust iATU size if MSG TLP region was allocated before */
@@ -777,7 +777,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows > ++i) {
 			atu.index = i;
 			atu.type = PCIE_ATU_TYPE_IO;
-			atu.parent_bus_addr = pp->io_base;
+			atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 			atu.pci_addr = pp->io_bus_addr;
 			atu.size = pp->io_size;
 
@@ -921,7 +921,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	atu.size = resource_size(pci->pp.msg_res);
 	atu.index = pci->pp.msg_atu_index;
 
-	atu.parent_bus_addr = pci->pp.msg_res->start;
+	atu.parent_bus_addr = pci->pp.msg_res->start - pci->parent_bus_offset;
 
 	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 985264c88b92..d9d2090f380c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -475,9 +475,6 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	u32 retries, val;
 	u64 limit_addr;
 
-	if (pci->ops && pci->ops->cpu_addr_fixup)
-		parent_bus_addr = pci->ops->cpu_addr_fixup(pci, parent_bus_addr);
-
 	limit_addr = parent_bus_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
-- 
2.34.1


