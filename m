Return-Path: <linux-pci+bounces-27046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F082AA4B33
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 14:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970C54C56C5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 12:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF125A334;
	Wed, 30 Apr 2025 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIrlYsql"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC625A642
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016338; cv=none; b=A9DVpvDwwNtC3OBqVDlbbYKgFQqjZpVQhvEAcZHPlXEoGU8p51+kQwR3gY8MTXyJ95zZQga6JSTvmQnWY8KeLlef3MvuqFiBBVxnrzWEp4M76U4EYEiZNx/MkshlQxKGXkJP8li3jH6OVJX7Cm+i+vdejXBg+fwBQu4+kfe3x6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016338; c=relaxed/simple;
	bh=fgkue8vEA+Xi36l4Uve1qRdP+ai21Fu/Py0N5wTfGqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxFXyv5MUrcxaBeKIymPhEaiLZRwjf1/kl+W0dViS9+AzxfnB6274QEvI8BOqAI1xyGdKCPVmXkxjIQI07y6cA77yRlu1cL7fUMOjPqGgHWb8uuiHSU7XplpwxGxtQUY2gdSjU4gy4KAB43cdeiTfPVRcGgL7uvAb9kdP/77psc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIrlYsql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF705C4CEEB;
	Wed, 30 Apr 2025 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746016338;
	bh=fgkue8vEA+Xi36l4Uve1qRdP+ai21Fu/Py0N5wTfGqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIrlYsqlURePnzJ4mjXhOOUdUHVlND3i6RH+vGkD/OJtQZSn9rfv549boO82oCieW
	 edJ0vjZbWY1HQYyjEw2mf6PKa4v2PhCxTUL0LbNc18sU8aEma8RBGvmC58AgEJ/Y6P
	 2RYiZAqaEo9M9Hn1HKo7lDDR9B4j9NlZ85QQi70an6hNXwAj4i3HjGFWHcQwDBzvKo
	 H/WkWp2M6f5Nex0h0tffGlJWMW9FJ5j9S+9CSNlbB4eQofTto8YxYSp9G0TjfIA5ou
	 8vjoJ/ZRge3IZY01G020+LNxg30KneKJymFl/h7NmADCZwMGNaf7jMCdS/4L0AP5Cb
	 iFNyfcP3H8CtQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Alan Douglas <adouglas@cadence.com>
Cc: dlemoal@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: cadence-ep: Fix broken set_msix() callback
Date: Wed, 30 Apr 2025 14:32:00 +0200
Message-ID: <20250430123158.40535-4-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430123158.40535-3-cassel@kernel.org>
References: <20250430123158.40535-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552; i=cassel@kernel.org; h=from:subject; bh=fgkue8vEA+Xi36l4Uve1qRdP+ai21Fu/Py0N5wTfGqk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKEJFxFbhx3ufgmrlG4d+2M/s+bDyhsku1nbZutZGxkp 6p15siajlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExEaQMjwz7TsKV/y7ckXpm9 aUrtEQaB6vmltQ9mrN3V755Rtp5t7QpGhiuTv9Y/KQzs9p2eKXXfr3PJzn7ebFW1lR+sDjx53NW gwQQA
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

While the set_msix() callback function in pcie-cadence-ep writes the
Table Size field correctly (N-1), the calculation of the PBA offset
is wrong because it calculates space for (N-1) entries instead of N.

This results in e.g. the following error when using QEMU with PCI
passthrough on a device which relies on the PCI endpoint subsystem:
failed to add PCI capability 0x11[0x50]@0xb0: table & pba overlap, or they don't fit in BARs, or don't align

Fix the calculation of PBA offset in the MSI-X capability.

Fixes: 3ef5d16f50f8 ("PCI: cadence: Add MSI-X support to Endpoint driver")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 599ec4b1223e..112ae200b393 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -292,13 +292,14 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct cdns_pcie *pcie = &ep->pcie;
 	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
 	u32 val, reg;
+	u16 actual_interrupts = interrupts + 1;
 
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	reg = cap + PCI_MSIX_FLAGS;
 	val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
-	val |= interrupts;
+	val |= interrupts; /* 0's based value */
 	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
 
 	/* Set MSI-X BAR and offset */
@@ -308,7 +309,7 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 
 	/* Set PBA BAR and offset.  BAR must match MSI-X BAR */
 	reg = cap + PCI_MSIX_PBA;
-	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = (offset + (actual_interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
 	return 0;
-- 
2.49.0


