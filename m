Return-Path: <linux-pci+bounces-14779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FD69A238C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59604289118
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6092A1DDC24;
	Thu, 17 Oct 2024 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r70xhdwp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3341DDC23
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171271; cv=none; b=E8KmZ9xxLtD4ZcMy/hQijMpoP2svFeg/L67Sks/Kw7ojuyOKWegisRt5ht12azn/dHrryUFHnS7Cv/bxlUoxJso7fWo7vzJDxwoRGDusDZsZB80D/zl3PlSdq4zD78oL5BM9KVn1L6RCrDDzR+707+uDQEHPBlxXbL/h/ezce3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171271; c=relaxed/simple;
	bh=yWslHkUx6l1i6GOuEAQUNChrg7orIrbupz2/AEvguxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhPi7G+KBiSYyb74whFQNiJOKStWKJ/wJLOmVuZ+I9gA+GpoVjCmfoD3WTpeFpGbz5wxer3Nt7edyiGV/cD5zJkE3RD8pDWxSohmsgYf10qs9JB0iLy3kGFbImIcCa8hnmy6vwFN2slzPve+EqQdpOe2oK8xJwZJCMDuqozY0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r70xhdwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FED3C4CECD;
	Thu, 17 Oct 2024 13:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729171270;
	bh=yWslHkUx6l1i6GOuEAQUNChrg7orIrbupz2/AEvguxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r70xhdwpXMlu5UTFGKuApLEI5Yqifx+Qxa91qMzHKLxmrcLMH5iIbod/l5Vc+PLgT
	 CMIwsRi+lBQUSXRRbAmAPzpwlk8IVs7w4JDAijFCkLgbokT1XsnKp88y8xquPGzAqm
	 oZHhc7alcGimp0bUt1VgLAhhffvYeBi3uUgb4rzGc7lh2AOQ4PnfgBDw2xhmcm7cLf
	 Tv/8+xx58lA5N1Bpqb1FARlXm4zz2TANj1Tpshsb2siV6wifRf/IUVfpYMP1dM76KJ
	 M/Cuv319O69lITlmuWwghi68VeCG5RIbmPceqlqDYDmlkCnlYZvhZwWOC5fUXlTwv+
	 /sq5b3ycxNtQw==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: dwc: ep: Use align addr function for dw_pcie_ep_raise_{msi,msix}_irq()
Date: Thu, 17 Oct 2024 15:20:55 +0200
Message-ID: <20241017132052.4014605-6-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017132052.4014605-4-cassel@kernel.org>
References: <20241017132052.4014605-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=cassel@kernel.org; h=from:subject; bh=yWslHkUx6l1i6GOuEAQUNChrg7orIrbupz2/AEvguxU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIF+U3N9VR2GWceYbor2NbYs1mxrHf/si//fmSk7P18p zDsf4NKRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACaS6sbIsNPsp+R08f4+yZa9 ixkW2NhMNhByfDTt+soqx44uRd+fMYwMeycr3n2kxrApbQI7sxHXnIuMkvO+pzUn2bqJmLOI8no zAwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Use the dw_pcie_ep_align_addr() function to calculate the alignment in
dw_pcie_ep_raise_{msi,msix}_irq() instead of open coding the same.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 20f67fd85e83..9bafa62bed1d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -503,7 +503,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	u32 msg_addr_lower, msg_addr_upper, reg;
 	struct dw_pcie_ep_func *ep_func;
 	struct pci_epc *epc = ep->epc;
-	unsigned int aligned_offset;
+	size_t msi_mem_size = epc->mem->window.page_size;
+	size_t offset;
 	u16 msg_ctrl, msg_data;
 	bool has_upper;
 	u64 msg_addr;
@@ -531,14 +532,13 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
 
-	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
-	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
+	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
-				  epc->mem->window.page_size);
+				  msi_mem_size);
 	if (ret)
 		return ret;
 
-	writel(msg_data | (interrupt_num - 1), ep->msi_mem + aligned_offset);
+	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
 
 	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
 
@@ -589,8 +589,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct pci_epf_msix_tbl *msix_tbl;
 	struct dw_pcie_ep_func *ep_func;
 	struct pci_epc *epc = ep->epc;
+	size_t msi_mem_size = epc->mem->window.page_size;
+	size_t offset;
 	u32 reg, msg_data, vec_ctrl;
-	unsigned int aligned_offset;
 	u32 tbl_offset;
 	u64 msg_addr;
 	int ret;
@@ -615,14 +616,13 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 		return -EPERM;
 	}
 
-	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
-	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
+	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)
 		return ret;
 
-	writel(msg_data, ep->msi_mem + aligned_offset);
+	writel(msg_data, ep->msi_mem + offset);
 
 	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
 
-- 
2.47.0


