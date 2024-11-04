Return-Path: <linux-pci+bounces-15999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAD29BBF09
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 21:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88745B20BDA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F511E630C;
	Mon,  4 Nov 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc2bL662"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D54C1E3DCF
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730753518; cv=none; b=BA4Lnx7AuduqH+qk6xShJnJfTGfaXvJYkpw40g/u6tVRq9DDCX2URMLl1N903LXnXfZlDj7UqKcLH9qxqYouIuQZYei8Su5ARqv3l0o/WhCuCKFXx7WNKMeabGjW5P1MD3YDAILI/I9jvURyTpcZwMhngEEIlGLmtz0pSIwhXZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730753518; c=relaxed/simple;
	bh=zK0TlQn3rCcklJ9jLCVhxwMAEE8ZghlF27imXLuJbdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=laYOUNjVzIK50/tMN4UrvdjKj6BufJsBE74rac8Rk+hqatoQ8IYU91u1r4UPnVKmIaEe8HmL0gknckrIDzFR7XQAJxLphByXr+MY9BoFLJEyuAyVTVuZQXBnOzde7JNACf36EXbvw67srUhAYpEJLvvoP9gR1Ogxme2xFBwGiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sc2bL662; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA8FC4CECE;
	Mon,  4 Nov 2024 20:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730753517;
	bh=zK0TlQn3rCcklJ9jLCVhxwMAEE8ZghlF27imXLuJbdA=;
	h=From:To:Cc:Subject:Date:From;
	b=Sc2bL662VrEE5EBfJzv66lN1cIebDQyEBequpUQI2FmHjwf6Gt7iLIl6S7v3lZpie
	 6d+rFHdkrKs+U93gTw8aQNNNiLg5bVQqCm3+mq53dL1SaQYKdfTIPEn9PETyxqyzZB
	 JXqNJBvmrCf0eoY7DGbfMvSO3m6iB/204bQq1T7NNFwWzSyx+1jYWHLoy0LajTQk4K
	 JfHu9zN87huCA55IBlZ1gQneXbCyogZzVzbY+w2iKyH9SXEHy7zyBSliaYcAfC75kg
	 +oANuyPVBZlEGKft0AmBsOooaJaWizYPkNirZpNO4n0wYmhgXGvFXCx3potEHs3aEm
	 sfJCQu2AeRu3A==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: ep: Do not map more memory than needed to raise a MSI/MSI-X IRQ
Date: Mon,  4 Nov 2024 21:51:44 +0100
Message-ID: <20241104205144.409236-2-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3743; i=cassel@kernel.org; h=from:subject; bh=zK0TlQn3rCcklJ9jLCVhxwMAEE8ZghlF27imXLuJbdA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI1jR9MiUx1z9e++MzkCt+CH3UcdRO5r1dtP5Jp2Wi9n D/g4hy9jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEyk6wvDX+mkem5ObtmwU9v5 VM7wXhL69FHI7OhWyYwPHx83x8ne+sjI8OA5/7+tHFEzhS7ln/Dp4Y+dUOFV4C7D8so4v+VO29k DzAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

In dw_pcie_ep_init() we allocate memory from the EPC address space that we
will later use to raise a MSI/MSI-X IRQ. This memory is only freed in
dw_pcie_ep_deinit().

Performing this allocation in dw_pcie_ep_init() is to ensure that we will
not fail to allocate memory from the EPC address space when trying to raise
a MSI/MSI-X IRQ.

We still map/unmap this memory every time we raise an IRQ, in order to not
constantly occupy an iATU, especially for controllers with few iATUs.
(So we can still fail to raise an MSI/MSI-X IRQ if all iATUs are occupied.)

When allocating this memory in dw_pcie_ep_init(), we allocate
epc->mem->window.page_size memory, which is the smallest unit that we can
allocate from the EPC address space.

However, when writing/sending the msg data, which is only 2 bytes for MSI,
4 bytes for MSI-X, in either case a single writel() is sufficient. Thus,
the size that we need to map is a single PCI DWORD (4 bytes).

This is the size that we should send in to the pci_epc_ops::align_addr()
API. It is align_addr()'s responsibility to return a size that is aligned
to the EPC page size, for platforms that need a special alignment.

Modify the align_addr() call to send in the proper size that we need to
map.

Before this patch on a system with a EPC page size 64k, we would
incorrectly map 128k (which is larger than our allocation) instead of 64k.

After this patch, we will correctly map 64k (a single page). (We should
never need to map more than a page to write a single DWORD.)

Fixes: f68da9a67173 ("PCI: dwc: ep: Use align addr function for dw_pcie_ep_raise_{msi,msix}_irq()")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Feel free to squash this with the patch that it fixes, if you so prefer.

 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 9bafa62bed1dc..507e40bd18c8f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -503,7 +503,7 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	u32 msg_addr_lower, msg_addr_upper, reg;
 	struct dw_pcie_ep_func *ep_func;
 	struct pci_epc *epc = ep->epc;
-	size_t msi_mem_size = epc->mem->window.page_size;
+	size_t map_size = sizeof(u32);
 	size_t offset;
 	u16 msg_ctrl, msg_data;
 	bool has_upper;
@@ -532,9 +532,9 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
 
-	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
+	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
-				  msi_mem_size);
+				  map_size);
 	if (ret)
 		return ret;
 
@@ -589,7 +589,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct pci_epf_msix_tbl *msix_tbl;
 	struct dw_pcie_ep_func *ep_func;
 	struct pci_epc *epc = ep->epc;
-	size_t msi_mem_size = epc->mem->window.page_size;
+	size_t map_size = sizeof(u32);
 	size_t offset;
 	u32 reg, msg_data, vec_ctrl;
 	u32 tbl_offset;
@@ -616,9 +616,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 		return -EPERM;
 	}
 
-	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
+	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
-				  epc->mem->window.page_size);
+				  map_size);
 	if (ret)
 		return ret;
 
-- 
2.47.0


