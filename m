Return-Path: <linux-pci+bounces-17403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E46E39DA5DA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A889B23B02
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 10:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD4819884B;
	Wed, 27 Nov 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKCYsJlG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A5919883C
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703442; cv=none; b=VKRRRM1KPKibeHuJHTlWiKgyzi6Crp/qHvkbXZJO4YPpieLVUF5PGkThd/zNmPpV5H/jbX70nXF86ogOx4eD0QrXEC6CT2gaSycVZAnLCn7vQnYNJ0l+0v7x44s84ujr7u+7LEs+z0Eujv3aID6rLabwgx6mkgIS8CnBESi4D2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703442; c=relaxed/simple;
	bh=wjELfxA42eHfRs0SsDqkNakU9ZOrveNgVLE1pGsZ14E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq2A/qLqrFcZczlxCM2B9biyIwue3WO+Gc85Yn9EC5yt1JjIa7MdaLDUp1G4ZDyg3rdtDTKZjvk4Ug6rZZgvEG8Doro8NagP9DqRrsnN7Kj1wVU4H9wX8eMoKmVIJXWb7FvA8m3NH/FcmBG9YHWvIM5tcLJ+6fIPXCGPWZih9Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKCYsJlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A659C4CECC;
	Wed, 27 Nov 2024 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732703440;
	bh=wjELfxA42eHfRs0SsDqkNakU9ZOrveNgVLE1pGsZ14E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKCYsJlGR3mX4rzM+IDLTQAa/JvJY22aXoGvy+lESpDzxUoY/koEe76o/+nnWo3CI
	 lZYfASKgDpMNWOjad1rGWToTs1eX21oSXFy8HAau218WKTfHMlKOhJa9JbEDRttBdl
	 ny5G0h4UuwDxWsZdggDR3gOmGe1xM3k1dvNJX+9cJ1rVgFvLMleqyvg+0I/1ccbW7p
	 Prr7Ps+eotw3uCYg3a7p93QIbmLRW5270ceFCmtmEbmtzGQJiVKCz92EcqBZGKmQO4
	 EPfg9OkJ57Lq0iHsQpfs5NqC9BISD7tR8J+KVZAh4YrmioWsmB6nu9ZCb7IUp80S2b
	 H5KWTQlN50zSw==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 3/6] PCI: dwc: ep: Add 'address' alignment to 'size' check in dw_pcie_prog_ep_inbound_atu()
Date: Wed, 27 Nov 2024 11:30:19 +0100
Message-ID: <20241127103016.3481128-11-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127103016.3481128-8-cassel@kernel.org>
References: <20241127103016.3481128-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4323; i=cassel@kernel.org; h=from:subject; bh=wjELfxA42eHfRs0SsDqkNakU9ZOrveNgVLE1pGsZ14E=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLdvuyV6S9oM5nVfz689wzTp1A2lj3mW6rs/B/E622av JLHNVCzo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABMp2cDwP2hCsUJn5/p/F9RS 3tabnfR8HmW9UeDRS3dLld8/2vuuPGZkeKl+8e4klRwn898Ffzy9nfbyO/hs3hN1aL32wmVCk3s ecAEA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

dw_pcie_prog_ep_inbound_atu() is used to program an inbound iATU in
"BAR Match Mode".

A memory address returned by e.g. kmalloc() is guaranteed to have natural
alignment (aligned to the size of the allocation). It is however not
guaranteed that pci_epc_set_bar() (and thus dw_pcie_prog_ep_inbound_atu())
is supplied an address that has natural alignment. (An EPF driver can send
in an arbitrary physical address to pci_epc_set_bar().)

The DWC Databook description for the LWR_TARGET_RW and LWR_TARGET_HW fields
in the IATU_LWR_TARGET_ADDR_OFF_INBOUND_i registers state that:
"Field size depends on log2(BAR_MASK+1) in BAR match mode."

I.e. only the upper bits are writable, and the number of writable bits is
dependent on the configured BAR_MASK.

Add a check to ensure that the physical address programmed in the iATU is
aligned to the size of the BAR (BAR_MASK+1), as without this, we can get
hard to debug errors, as we could write to bits that are read-only (without
getting a write error), which could cause the iATU to end up redirecting to
a physical address that is different from the address that we intended.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 8 +++++---
 drivers/pci/controller/dwc/pcie-designware.c    | 5 +++--
 drivers/pci/controller/dwc/pcie-designware.h    | 2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 01c739aaf61a..4914751950cb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -128,7 +128,8 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 
 static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
-				  dma_addr_t cpu_addr, enum pci_barno bar)
+				  dma_addr_t cpu_addr, enum pci_barno bar,
+				  size_t size)
 {
 	int ret;
 	u32 free_win;
@@ -145,7 +146,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	}
 
 	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
-					  cpu_addr, bar);
+					  cpu_addr, bar, size);
 	if (ret < 0) {
 		dev_err(pci->dev, "Failed to program IB window\n");
 		return ret;
@@ -265,7 +266,8 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	else
 		type = PCIE_ATU_TYPE_IO;
 
-	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
+	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar,
+				     size);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 6d6cbc8b5b2c..3c683b6119c3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -597,11 +597,12 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 }
 
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				int type, u64 cpu_addr, u8 bar)
+				int type, u64 cpu_addr, u8 bar, size_t size)
 {
 	u32 retries, val;
 
-	if (!IS_ALIGNED(cpu_addr, pci->region_align))
+	if (!IS_ALIGNED(cpu_addr, pci->region_align) ||
+	    !IS_ALIGNED(cpu_addr, size))
 		return -EINVAL;
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35a..fc0872711672 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -491,7 +491,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 			     u64 cpu_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				int type, u64 cpu_addr, u8 bar);
+				int type, u64 cpu_addr, u8 bar, size_t size);
 void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
 void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
-- 
2.47.0


