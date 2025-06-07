Return-Path: <linux-pci+bounces-29147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 879F3AD0E73
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C12188C882
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7C0202962;
	Sat,  7 Jun 2025 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ep0Z8LKq"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720901F4C9F;
	Sat,  7 Jun 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312877; cv=none; b=dFI9Hq2jrnKU+VrytVXmzsZoGdo1JP7E+rd++66EfF8JsQ8TFMAJgcri0Ln4A7M6ff4FZ26aUcLnK1YAuSU7TMX2dW+hIEae+4uV5vT8DpD4wEeFIZbETuSfA1WGwPQq+1APFgXscNXvf6YO7mQ2UwDaGHTeYdHfOkXMTvL6F8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312877; c=relaxed/simple;
	bh=0HGkOROzrc1t6m5ZlZrUGH4pQqTXgYdy3wvu88glQqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeUPhf76rSHzkhGT/oAufgOCLPCpfLWzAtI8fguqAuFYl+/afiGSAN4NjsZlF4AbMaZCRAtmb3kuY6ToED7I98fqpr63kzM85YJsUs3SAtY5RDp2Eg5Ey8keJwdgKo7QV/HrXCdyA9Dfempt36zbQp+sFCx2u9+nbypKa2j9u3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ep0Z8LKq; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=1W1tAbgZUnt8jbduKKbjk27wH9BA7ym7ER7B78e/SV4=;
	b=Ep0Z8LKq2hK59aoSXCy1QzfmHDSmsZHMJpsLSlSP4FpM6CU0SrH8tGJS5YHhMc
	5EBVqegf6puTVhNnSHw5FNmShWR92fbe/ttVGoSv+c7syhciQqp9jZYjE8VhdPFM
	QhrNp4GBlYxvAMaiuku93bCeeIT3jLkYnRrf153N634js=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHuXJPZURoL9paGw--.4161S8;
	Sun, 08 Jun 2025 00:14:13 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v13 6/6] PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode
Date: Sun,  8 Jun 2025 00:14:05 +0800
Message-Id: <20250607161405.808585-7-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250607161405.808585-1-18255117159@163.com>
References: <20250607161405.808585-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=n
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHuXJPZURoL9paGw--.4161S8
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4R-AwVDUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDx9lo2hEY-4hNgAAsw

The PCIe capability/extended capability offsets are not guaranteed to be
the same across all SoCs integrating the Cadence PCIe IP. Hence, use the
cdns_pcie_find_{ext}_capability() APIs for finding them.

This avoids hardcoding the offsets in the driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes since v8 ~ v12:
- None

Changes since v7:
- Resolve compilation errors.

Changes since v6:
https://lore.kernel.org/linux-pci/20250323164852.430546-4-18255117159@163.com/

- The patch commit message were modified.

Changes since v5:
https://lore.kernel.org/linux-pci/20250321163803.391056-4-18255117159@163.com

- Kconfig add "select PCI_HOST_HELPERS"
---
 .../pci/controller/cadence/pcie-cadence-ep.c  | 38 +++++++++++--------
 drivers/pci/controller/cadence/pcie-cadence.h |  5 ---
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 8ab6cf70c18e..4f0d2ee5e513 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -21,12 +21,13 @@
 
 static u8 cdns_pcie_get_fn_from_vfn(struct cdns_pcie *pcie, u8 fn, u8 vfn)
 {
-	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
 	u32 first_vf_offset, stride;
+	u16 cap;
 
 	if (vfn == 0)
 		return fn;
 
+	cap = cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_SRIOV);
 	first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_SRIOV_VF_OFFSET);
 	stride = cdns_pcie_ep_fn_readw(pcie, fn, cap +  PCI_SRIOV_VF_STRIDE);
 	fn = fn + first_vf_offset + ((vfn - 1) * stride);
@@ -38,10 +39,11 @@ static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
 				     struct pci_epf_header *hdr)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
-	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
 	struct cdns_pcie *pcie = &ep->pcie;
 	u32 reg;
+	u16 cap;
 
+	cap = cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_SRIOV);
 	if (vfn > 1) {
 		dev_err(&epc->dev, "Only Virtual Function #1 has deviceID\n");
 		return -EINVAL;
@@ -227,9 +229,10 @@ static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 nr_irqs)
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
 	u8 mmc = order_base_2(nr_irqs);
-	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
 	u16 flags;
+	u8 cap;
 
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	/*
@@ -249,9 +252,10 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
-	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
 	u16 flags, mme;
+	u8 cap;
 
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	/* Validate that the MSI feature is actually enabled. */
@@ -272,9 +276,10 @@ static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
-	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
 	u32 val, reg;
+	u8 cap;
 
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
 	func_no = cdns_pcie_get_fn_from_vfn(pcie, func_no, vfunc_no);
 
 	reg = cap + PCI_MSIX_FLAGS;
@@ -292,9 +297,10 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
-	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
 	u32 val, reg;
+	u8 cap;
 
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	reg = cap + PCI_MSIX_FLAGS;
@@ -380,11 +386,11 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 				     u8 interrupt_num)
 {
 	struct cdns_pcie *pcie = &ep->pcie;
-	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
 	u16 flags, mme, data, data_mask;
-	u8 msi_count;
 	u64 pci_addr, pci_addr_mask = 0xff;
+	u8 msi_count, cap;
 
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	/* Check whether the MSI feature has been enabled by the PCI host. */
@@ -432,14 +438,14 @@ static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 				    u32 *msi_addr_offset)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
-	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
 	struct cdns_pcie *pcie = &ep->pcie;
 	u64 pci_addr, pci_addr_mask = 0xff;
 	u16 flags, mme, data, data_mask;
-	u8 msi_count;
+	u8 msi_count, cap;
 	int ret;
 	int i;
 
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	/* Check whether the MSI feature has been enabled by the PCI host. */
@@ -482,16 +488,16 @@ static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 				      u16 interrupt_num)
 {
-	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
 	u32 tbl_offset, msg_data, reg;
 	struct cdns_pcie *pcie = &ep->pcie;
 	struct pci_epf_msix_tbl *msix_tbl;
 	struct cdns_pcie_epf *epf;
 	u64 pci_addr_mask = 0xff;
 	u64 msg_addr;
+	u8 bir, cap;
 	u16 flags;
-	u8 bir;
 
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
 	epf = &ep->epf[fn];
 	if (vfn > 0)
 		epf = &epf->epf[vfn - 1];
@@ -565,7 +571,9 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	int max_epfs = sizeof(epc->function_num_map) * 8;
 	int ret, epf, last_fn;
 	u32 reg, value;
+	u8 cap;
 
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
 	/*
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
 	 * and can't be disabled anyway.
@@ -589,12 +597,10 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 				continue;
 
 			value = cdns_pcie_ep_fn_readl(pcie, epf,
-					CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
-					PCI_EXP_DEVCAP);
+						      cap + PCI_EXP_DEVCAP);
 			value &= ~PCI_EXP_DEVCAP_FLR;
 			cdns_pcie_ep_fn_writel(pcie, epf,
-					CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
-					PCI_EXP_DEVCAP, value);
+					       cap + PCI_EXP_DEVCAP, value);
 		}
 	}
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 38f7a8cdf7f1..f0fdeb3863f1 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -125,11 +125,6 @@
  */
 #define CDNS_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
 
-#define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
-#define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET	0xb0
-#define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
-#define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
-
 /*
  * Endpoint PF Registers
  */
-- 
2.25.1


