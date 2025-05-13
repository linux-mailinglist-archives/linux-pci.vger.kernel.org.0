Return-Path: <linux-pci+bounces-27613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 935F4AB4CBA
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 09:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710C23A536A
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 07:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F70D3FBA7;
	Tue, 13 May 2025 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZRyLHmB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667B918EAB;
	Tue, 13 May 2025 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121474; cv=none; b=Bc0TgUKsgqqTAP+QbQvufr4+yn2jl1nkK6qXWLG48OTBnYVW6pbcxF4UQ+Xixzyod6hJANqgFz/UhrWP/BPoIWzIFNYj3zjT3MKcn0UdQpep9STJwvJS7zK+n1/S+8VUCXxrqHKunorm9UdeAufLpsTvxrtUU4mBEQ3EhysDG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121474; c=relaxed/simple;
	bh=0p4WvW8RaRImKPzubhYqD9RMNzWJQrE9S1OPZn9D3uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRUJ5ttK93Ir7KQvtR6isPZ5bGBj1FqWS/fFG9lqk7JUp3sNnGyU+Oy7kVr+TptKtyaOOqpImmV+wz/R/yANSw5hvtdJaLeJcUnc9EVbQeM+xYIJ1z3gG9AFkU4prINzw4YiM4liJJvwuce3aLrYTWYOMGqc4c4Tjl89l2RvzEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZRyLHmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81254C4CEEF;
	Tue, 13 May 2025 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747121473;
	bh=0p4WvW8RaRImKPzubhYqD9RMNzWJQrE9S1OPZn9D3uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZRyLHmBW+eB+aibbXdpLyUKQUnIyTMtdZzrub34+8RXu47ksHM/RhRgWItlln5bl
	 /Kg8g3AGhds3afMc47xOcEsAMZNu6/lxEwRG18K22xSqTYmwQ0RNgcwM9ghYDsycWd
	 fnIadsJ44OyuT62lNT2CDBrqv+4OtZ9e717L2IW03JNW6n4E69d+ZHoi3pPJN6apj8
	 INts434b9a/+UOkNLrCYfa6aV78jgxpyskmaCeAwhw2+TpyTMP2Tyb8vsAbElJP580
	 ycIxrP5NzTxE4aQNKSixPWdwHTNnVIE0CUwUT0Cu6Ae6WpCE5Qm6ScJ44fM7nhEOfu
	 mjlrcOTPkGRtw==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/6] PCI: dwc: ep: Fix broken set_msix() callback
Date: Tue, 13 May 2025 09:30:56 +0200
Message-ID: <20250513073055.169486-9-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513073055.169486-8-cassel@kernel.org>
References: <20250513073055.169486-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2318; i=cassel@kernel.org; h=from:subject; bh=0p4WvW8RaRImKPzubhYqD9RMNzWJQrE9S1OPZn9D3uk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKUvhpoa8+JFSz7Ez8jW6NYc1H944lSp/+l2WtU5jO+V e8u2Xa1o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABMRyGFk2G7k8lHpxE+NLSps SRsnpCQpL2fU0j9l1WxrK6+uZWqdwPCbXXlXEN/jm6+YX5gf4W7Ieu1nmvGyO8Pg7ppLXdta8r8 wAAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

While the set_msix() callback function in pcie-designware-ep writes the
Table Size field correctly (N-1), the calculation of the PBA offset
is wrong because it calculates space for (N-1) entries instead of N.

This results in e.g. the following error when using QEMU with PCI
passthrough on a device which relies on the PCI endpoint subsystem:
failed to add PCI capability 0x11[0x50]@0xb0: table & pba overlap, or they don't fit in BARs, or don't align

Fix the calculation of PBA offset in the MSI-X capability.

Cc: stable@vger.kernel.org
Fixes: 83153d9f36e2 ("PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments")
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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


