Return-Path: <linux-pci+bounces-27045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE03AA4B31
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 14:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F874C5746
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 12:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A886258CC3;
	Wed, 30 Apr 2025 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DunsLNG7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B625A334
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016335; cv=none; b=XdczngqTIsveBFuuiTuouPaJEfX3VA5kc3Qy1mugMSsU1pKNS3p9hihJxxJTAdSzeVxs0do1pWHjOXjDRey37OgHcvV7NI+Ava0U5EDUpdzgbVikUDVPI5qNMjf6D/rjQ2QNWKuiwSlmUTOI7LzsxtRUBUGvtCXxpuBr0MYQBJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016335; c=relaxed/simple;
	bh=qIgoPY8a90SnQq9lGujk17v54XYTdFWi+HVjzQhfcsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spVyIrkDi+8euriTjfRcXpT0NTK92n/GIFewQSM3e5g7Ji38ooNS3nSrihboVyZUuepIpSPPMwfyvKOYkrJimVbTuYS4pKq1PJm0wH3/ffVlL2tLCWdjRhXfkqSWZD5O++HqupEnUtvLODayj3mX2GBXcrp5W0NgWwLy25awVrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DunsLNG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F94FC4CEE9;
	Wed, 30 Apr 2025 12:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746016335;
	bh=qIgoPY8a90SnQq9lGujk17v54XYTdFWi+HVjzQhfcsY=;
	h=From:To:Cc:Subject:Date:From;
	b=DunsLNG7/hVB/8aMguhvHvQgCiLyNDoLl0/5OQ1odIDC17l6kagpfSMf3TSzYb4EV
	 juKpXDou2UV0L/2h+8Zo9sqiDJbkEYtzz5odRFiDLJt8M5YKEoLVptXo2RLC0r/p0G
	 Ecw6e/qYLk4vrtbmyToteQHo94c+YXuq1AhrhPskCFqSjeDZUMTsj1AIYidpg8BCoM
	 vNFOLa6Emy47n2aTilQhQMnewz6fsVRsYBh7ub4DAmIBVGdVbZ/95cH3fF0kPmNJek
	 YU0KXwxZc5HVYSMiZ3Mi/FTFzY9WIlvIJTg7hPCjzpxJRlYeopKnrT7p7U+tVIcgeQ
	 mU7b34uMlIutg==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: dlemoal@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: dwc: ep: Fix broken set_msix() callback
Date: Wed, 30 Apr 2025 14:31:59 +0200
Message-ID: <20250430123158.40535-3-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2760; i=cassel@kernel.org; h=from:subject; bh=qIgoPY8a90SnQq9lGujk17v54XYTdFWi+HVjzQhfcsY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKEJOx2tJoLpO69t6H074TF53IuHVxTMPnWgYTCHu0LK o9Yd12c0lHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJSBkw/M89f077ZePy0MLI 7BLB7D2VRy7mbq1K4m7cJMZTo6j7U5ThD/+KprKu/f9FWVf6mCekx5xJqA3O/7C4Mvny6eUaN8y /MQEA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

While the parameter 'interrupts' to the functions pci_epc_set_msi() and
pci_epc_set_msix() represent the actual number of interrupts, and
pci_epc_get_msi() and pci_epc_get_msix() return the actual number of
interrupts.

These endpoint library functions just mentioned will however supply
"interrupts - 1" to the EPC callback functions pci_epc_ops->set_msi() and
pci_epc_ops->set_msix(), and likewise add 1 to return value from
pci_epc_ops->get_msi() and pci_epc_ops->get_msix(), even though the
parameter name for the callback function is also named 'interrupts'.

While the set_msix() callback function in pcie-designware-ep writes the
Table Size field correctly (N-1), the calculation of the PBA offset
is wrong because it calculates space for (N-1) entries instead of N.

This results in e.g. the following error when using QEMU with PCI
passthrough on a device which relies on the PCI endpoint subsystem:
failed to add PCI capability 0x11[0x50]@0xb0: table & pba overlap, or they don't fit in BARs, or don't align

Fix the calculation of PBA offset in the MSI-X capability.

Fixes: 83153d9f36e2 ("PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1a0bf9341542..24026f3f3413 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -585,6 +585,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_pcie_ep_func *ep_func;
 	u32 val, reg;
+	u16 actual_interrupts = interrupts + 1;
 
 	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	if (!ep_func || !ep_func->msix_cap)
@@ -595,7 +596,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	reg = ep_func->msix_cap + PCI_MSIX_FLAGS;
 	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
-	val |= interrupts;
+	val |= interrupts; /* 0's based value */
 	dw_pcie_writew_dbi(pci, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
@@ -603,7 +604,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_PBA;
-	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = (offset + (actual_interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
-- 
2.49.0


