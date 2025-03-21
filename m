Return-Path: <linux-pci+bounces-24373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341BDA6C02C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4243AD526
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9C922CBF6;
	Fri, 21 Mar 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BR3nkK7k"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E461EBA1E;
	Fri, 21 Mar 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575115; cv=none; b=t/hgvn5Rgfm6UW2wAIGBVu+YK+QNtsv+2q5KREwa/SLB0nijX2S9AuXfgCrPKysDBB4d2S7GzvuxwjN08OgdyDD6IDq8arl2+UMsXhwNBFq2Ay+yG4IHb3SVWTap76XfPzbm11kLi45DXH2pYHO1VWEq11iWN7RU3oR7f6W8i78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575115; c=relaxed/simple;
	bh=JR7S2MATXfTvx5Wz5SjALIQV6FkE1ItKtQhPH4ZewVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XkEEod3rbox05IjnGixxU78sBYmEp6Zf3zsZPCDI/Sf578tvmCjVCXdXj/2CWHwqXNmKARGbYm67QRklhrUxmOMda2V7CUw8My+JwDyN7ssBQvQKr2uWybclghAA4lghmDokGtHqullV5Nk88t0nA9//LojXlyKfeb8kXUFfRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BR3nkK7k; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=E9xEI
	IzUtkwTOd4IZJeKT0N33skdMdQSQIBmezuP4jU=; b=BR3nkK7krfQK9WDHPEd/J
	HS3abq6LlhO7n4BOB/ui5RsJgNQwW1TaQ9r3ryr2JxJr/JKNBzGKDykcnnPtDum9
	YuxcioiJQzAL5Ptlzs45uklinyKBECeoVcr9hUi8JlyN+LOMEhparpicj9Rw9gDq
	QnD/X6IKHtDPABQaKeKnqo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wC30e7sld1nnmPrAw--.48109S6;
	Sat, 22 Mar 2025 00:38:07 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v5 4/4] PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode.
Date: Sat, 22 Mar 2025 00:38:03 +0800
Message-Id: <20250321163803.391056-5-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250321163803.391056-1-18255117159@163.com>
References: <20250321163803.391056-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC30e7sld1nnmPrAw--.48109S6
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF1xAFy3Jw43GF17ur18AFb_yoWxAw47pF
	Z8ua4SkF40qrW7uFsrAa15ZrnxtFnIv347Aa92kw1fuF129FyUGFyIva43KF1akrs7uF17
	XrWDtrsa9a13trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pNsjUsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhsXo2fdjwDO-AAEsW

The PCIe capability/extended capability offsets are not guaranteed to be
the same across all SoCs integrating the Cadence PCIe IP. Hence, use the
cdns_pcie_find_{ext}_capability() APIs for finding them.

This avoids hardcoding the offsets in the driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v4:
https://lore.kernel.org/linux-pci/20250321101710.371480-5-18255117159@163.com/

- The patch subject and commit message were modified.
---
 .../pci/controller/cadence/pcie-cadence-ep.c  | 40 +++++++++++--------
 drivers/pci/controller/cadence/pcie-cadence.h |  5 ---
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index e0cc4560dfde..aea53ddcaf9b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -19,12 +19,13 @@
 
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
@@ -36,10 +37,11 @@ static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
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
@@ -224,9 +226,10 @@ static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 mmc)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
-	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
 	u16 flags;
+	u8 cap;
 
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	/*
@@ -246,9 +249,10 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
-	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
 	u16 flags, mme;
+	u8 cap;
 
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	/* Validate that the MSI feature is actually enabled. */
@@ -269,9 +273,10 @@ static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
-	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
 	u32 val, reg;
+	u8 cap;
 
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
 	func_no = cdns_pcie_get_fn_from_vfn(pcie, func_no, vfunc_no);
 
 	reg = cap + PCI_MSIX_FLAGS;
@@ -290,9 +295,10 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
-	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
 	u32 val, reg;
+	u8 cap;
 
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	reg = cap + PCI_MSIX_FLAGS;
@@ -379,11 +385,11 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
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
@@ -431,14 +437,14 @@ static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
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
@@ -481,16 +487,16 @@ static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
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
@@ -564,7 +570,9 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	int max_epfs = sizeof(epc->function_num_map) * 8;
 	int ret, epf, last_fn;
 	u32 reg, value;
+	u8 cap;
 
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
 	/*
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
 	 * and can't be disabled anyway.
@@ -588,12 +596,10 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 				continue;
 
 			value = cdns_pcie_ep_fn_readl(pcie, epf,
-					CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
-					PCI_EXP_DEVCAP);
+						      cap + PCI_EXP_DEVCAP);
 			value &= ~PCI_EXP_DEVCAP_FLR;
-			cdns_pcie_ep_fn_writel(pcie, epf,
-					CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
-					PCI_EXP_DEVCAP, value);
+			cdns_pcie_ep_fn_writel(pcie, epf, cap + PCI_EXP_DEVCAP,
+					       value);
 		}
 	}
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 6f4981fccb94..d0fcf1b3549c 100644
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


