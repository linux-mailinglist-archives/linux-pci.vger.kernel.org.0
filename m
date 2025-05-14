Return-Path: <linux-pci+bounces-27686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD1DAB64BD
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 09:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7641B62FB4
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 07:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B772063F0;
	Wed, 14 May 2025 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf+cQSV8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FDB1F78E0;
	Wed, 14 May 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208613; cv=none; b=PlfbPbIzhzh3H3iaIKSkevS99sB/VPZgGxgcj9NoQC1ifv2ViHi4I3oQvvnEDmwXw9liFVhK4+mfHLLSeVOELaHo4fcf3ZTBgOVeSP2/FMMFjDHZY+ELtYPBTF1uj1/kMvOmPwBZGiYHjrDkSbKJ3Xx2Stm4XHvebWixIPNxYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208613; c=relaxed/simple;
	bh=6jYE/QhBsAcx+ZYl1Z+cocs3zxcnenWSWW3vW/Gl9xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtEbeOEOHkq6L3UvSBwzgLBAf/MYkseDDcV+sPUXzjIdP3jLf26u8oFKugv1Dv4Ljm4Ob/dj2bjF1SIFNL0Hp0SqnmzS7h3keRUBvr5XAJaXeqVGZ5l9oTdo43oTWtQnX5zaV6uIkpy9hFdkP1MpcCpgwuiYf4COrqUhwuW/4KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf+cQSV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37E4C4CEF3;
	Wed, 14 May 2025 07:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747208612;
	bh=6jYE/QhBsAcx+ZYl1Z+cocs3zxcnenWSWW3vW/Gl9xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lf+cQSV84hd27cDurfyYB0mP2Q39Kn+mXaFIPeoKYgSPGZhzLwz57eUKWl5G1cI8b
	 YbDYMaLZwJKEIi1OK4DSdKPpY4JIGgy8MuzFgShQedaZC6wpxKwrLACzo5mcUlYzbV
	 sv9jY1kGUxEn3ssU/5trnYxgl969ovkpqDpnAPOv0Y63L4Hlp/aLiaLK8C9Z2cmWtf
	 ClT/jaHZ+WQInylkPHPbiWQzDAyt8A7Kw0g/9nbflN0Yr54IuDcqctSZwAw/HPqxed
	 4Bi3J6sgHigYGiRb+xc7qamTusjrqlb0NCI7YvyJJtZeWiqOvlYqKaY18qr2jl3XZj
	 cPk+qtpQUUIQg==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Alan Douglas <adouglas@cadence.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 2/6] PCI: cadence-ep: Fix broken set_msix() callback
Date: Wed, 14 May 2025 09:43:15 +0200
Message-ID: <20250514074313.283156-10-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514074313.283156-8-cassel@kernel.org>
References: <20250514074313.283156-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2110; i=cassel@kernel.org; h=from:subject; bh=6jYE/QhBsAcx+ZYl1Z+cocs3zxcnenWSWW3vW/Gl9xI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJUPCfd/xg07fB0D7XMqawFaUzmf5cuj9Ge9/P0lS/ed T/Wvpt5rKOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATEdNl+GfMMOX0n25Fbo9v E11evFa86CMSb+go6St9RvXGNI3E1bcYGVpSGfeITNkWo/p+Aq950NMExwfKhrP+tXRp5Ak/jjg zgQkA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

While the set_msix() callback function in pcie-cadence-ep writes the
Table Size field correctly (N-1), the calculation of the PBA offset
is wrong because it calculates space for (N-1) entries instead of N.

This results in e.g. the following error when using QEMU with PCI
passthrough on a device which relies on the PCI endpoint subsystem:
failed to add PCI capability 0x11[0x50]@0xb0: table & pba overlap, or they don't fit in BARs, or don't align

Fix the calculation of PBA offset in the MSI-X capability.

Cc: stable@vger.kernel.org
Fixes: 3ef5d16f50f8 ("PCI: cadence: Add MSI-X support to Endpoint driver")
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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


