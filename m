Return-Path: <linux-pci+bounces-14532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BB199E23E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 11:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5557B23177
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3911CFEB5;
	Tue, 15 Oct 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX+3Thez"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B161CF7D0
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983235; cv=none; b=jTRysjncmqS3KCBEd3uyL03VJkzf35ObRz/yNTYdLyMdrxFlR8/Nffcdnq1e27cMRlSTkkExo936RFmqSaZfEag3HNjZJL/Pz4Rm2AfYBfIxJfCjRA1PUWgb1k0jAEHoWiKV0W3bxSO/arKpzslPMixecaXa7HowLPvyuCMoufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983235; c=relaxed/simple;
	bh=tTlayWfDNZK0xxSKFWwFjKRJ81BplavlaBCSB/QoSaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSgTSTmbiL9XgUmbRbYzuGMqd7a/dW3rJnpfOs4S10VgqiNOBCqJZsD/2BfUq/eVLSbuBOF3VZyFvJpLccrqj77zrl4AQYZgp6Nur8M1dm3JQoW3NRVhA9/k8Jh8TFVnT1rhbW8gKBxnhfA0K3ndOBtKsNvfpk3KRolwn3Bf5MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX+3Thez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3A8C4CEC6;
	Tue, 15 Oct 2024 09:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728983235;
	bh=tTlayWfDNZK0xxSKFWwFjKRJ81BplavlaBCSB/QoSaE=;
	h=From:To:Cc:Subject:Date:From;
	b=dX+3ThezCzunOD/u084G061vWSpkDG/gZou9nB/xRhSFrg13SEQ9WxPCcN9//kYER
	 FZ3/9zQD1wIX3GG+2RB8vgz7a/0c6WNFVoIiimd1QNUq+2HMvRAAF+Ztnn7nzWeyIA
	 VtZpcYW6NCcbiWhLC/yWqBdQEAU9QWCwglIvKqh5tkhXAZ7yU6BEhLc94nTWkdpj8L
	 Fms5H71AuD9tmIbh8fW14DdiR66UaiszPXZLIA3fGL8WYvry+W/fn23/E296hZd7FH
	 lHVwTiQy4pgZ34dY8SbltBCirENBHCcO7JBF7hP4aRCOosOXqKr4t82ArsC/yDXS6H
	 b1Vw+xB2z0MaA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2] PCI: endpoint: Improve pci_epc_ops::align_addr() interface
Date: Tue, 15 Oct 2024 18:07:12 +0900
Message-ID: <20241015090712.112674-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI endpoint controller operation interface for the align_addr()
operation uses the phys_addr_t type for the PCI address argument and
return a value using this type. This is not ideal as PCI addresses are
bus addresses, not regular memory physical addresses. Replace the use of
phys_addr_t for this operation with the generic u64 type. To be
consistent with this change the Designware driver implementation of this
operation (function dw_pcie_ep_align_addr()) as well as the type of PCI
address fields of struct pci_epc_map are also changed.

Fixes: e98c99e2ccad ("PCI: endpoint: Introduce pci_epc_mem_map()/unmap()")
Fixes: cb6b7158fdf5 ("PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
Changes from v1:
 - Also updated the type of the pci_addr and map_pci_addr fields of
   struct pci_epc_map.

 drivers/pci/controller/dwc/pcie-designware-ep.c | 6 +++---
 include/linux/pci-epc.h                         | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0ada60487c25..df1460ed63d9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -268,12 +268,12 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	return -EINVAL;
 }
 
-static phys_addr_t dw_pcie_ep_align_addr(struct pci_epc *epc,
-			phys_addr_t pci_addr, size_t *pci_size, size_t *offset)
+static u64 dw_pcie_ep_align_addr(struct pci_epc *epc, u64 pci_addr,
+				 size_t *pci_size, size_t *offset)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	phys_addr_t mask = pci->region_align - 1;
+	u64 mask = pci->region_align - 1;
 	size_t ofst = pci_addr & mask;
 
 	*pci_size = ALIGN(ofst + *pci_size, ep->page_size);
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f4b8dc37e447..de8cc3658220 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -49,10 +49,10 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
  * @virt_addr: virtual address at which @pci_addr is mapped
  */
 struct pci_epc_map {
-	phys_addr_t	pci_addr;
+	u64		pci_addr;
 	size_t		pci_size;
 
-	phys_addr_t	map_pci_addr;
+	u64		map_pci_addr;
 	size_t		map_size;
 
 	phys_addr_t	phys_base;
@@ -93,8 +93,8 @@ struct pci_epc_ops {
 			   struct pci_epf_bar *epf_bar);
 	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			     struct pci_epf_bar *epf_bar);
-	phys_addr_t (*align_addr)(struct pci_epc *epc, phys_addr_t pci_addr,
-				  size_t *size, size_t *offset);
+	u64	(*align_addr)(struct pci_epc *epc, u64 pci_addr, size_t *size,
+			      size_t *offset);
 	int	(*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			    phys_addr_t addr, u64 pci_addr, size_t size);
 	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-- 
2.47.0


