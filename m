Return-Path: <linux-pci+bounces-13799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B920198FCE6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 07:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829D9283B3B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 05:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3085474070;
	Fri,  4 Oct 2024 05:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRptTZ1j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23328F3
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018471; cv=none; b=BAPVpu5v3ArwA5LHexmh1bR1pAJASwmIuFLyWSHgXkffxPHtEwQm9DcBMpR+YUH5wg7S9d/oDS/BQtcFrL5rbSn4E/MFieng7Bijslmr6S5ZqZrqLljRSqGOqx7pSBs8QPcym1gU/3DYqayvTbichvzSSDkFGXD0RImWKQydj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018471; c=relaxed/simple;
	bh=oa8mRw8TDpxjvIkSC6a8Senr13Su2YagH/W9NdfmVXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMr1YERaOEz8P0nA2T/YHQ+rm1h7qfEQr+xp94AcoYndfrONxYDRNbD6NBaVpGA9LjIn55N4y3bioRmMwDJPLvSd8QqjCUDm70m5Za0PvB5N386cLq80AACKFloJJLAuqZPsh0iet5S8Rler8QzRu7RxGEZKvbpHCRtVcsBkfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRptTZ1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEC8C4CECD;
	Fri,  4 Oct 2024 05:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728018470;
	bh=oa8mRw8TDpxjvIkSC6a8Senr13Su2YagH/W9NdfmVXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRptTZ1jTYP8JgDPioviakGDajXR4Mlqb9nRGDrKoX+Ux4IzjEuOxVwKf/OywXkd2
	 O2kUCBfBQkNs5Zm/6VFkuOlMIvSs1oMfBohoTTLyngb3b/8yFP+5nbHq/PAIugNAGt
	 ksrbQ6kYPVMssyGpMXrVFJcuAwaMiJpggTBqrLD6m7IKNozD1MJCim0m35HCrWlSBO
	 7vFJcSaymTOa0E648ogcn7qBGTAAEa1WmjbIaHQmjmOI0jHh6XUJAxYPZvs7GfyUST
	 5FaeBlPBGgqt0hoe7a7qmNH2XUTXhSqWPk/3KNnINt1E1+/m55AI/nmK97nAFXof7b
	 lAGRUOLeCVKtg==
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
Subject: [PATCH v3 4/7] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
Date: Fri,  4 Oct 2024 14:07:39 +0900
Message-ID: <20241004050742.140664-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004050742.140664-1-dlemoal@kernel.org>
References: <20241004050742.140664-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function pci_epc_mem_map() to facilitate controller memory
address allocation and mapping to a RC PCI address region in endpoint
function drivers.

This function first uses pci_epc_map_align() to determine the controller
memory address size (and offset into) depending on the controller
address alignment constraints. The result of this function is used to
allocate a controller physical memory region using
pci_epc_mem_alloc_addr() and map that memory to the RC PCI address
space with pci_epc_map_addr().

Since pci_epc_map_align() may indicate that the effective mapping
of a PCI address region is smaller than the user requested size,
pci_epc_mem_map() may only partially map the RC PCI address region
specified. It is the responsibility of the caller (an endpoint function
driver) to handle such smaller mapping.

The counterpart of pci_epc_mem_map() to unmap and free the controller
memory address region is pci_epc_mem_unmap().

Both functions operate using a struct pci_epc_map data structure
Endpoint function drivers can use struct pci_epc_map to access the
mapped RC PCI address region using the ->virt_addr and ->pci_size
fields.

Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 78 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  4 ++
 2 files changed, 82 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 48dd3c28ac4c..5f3b0a86d6fe 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -522,6 +522,84 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_map_addr);
 
+/**
+ * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
+ * @epc: the EPC device on which the CPU address is to be allocated and mapped
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
+ * @pci_addr: PCI address to which the CPU address should be mapped
+ * @pci_size: the number of bytes to map starting from @pci_addr
+ * @map: where to return the mapping information
+ *
+ * Allocate a controller memory address region and map it to a RC PCI address
+ * region, taking into account the controller physical address mapping
+ * constraints using pci_epc_map_align().
+ * The effective size of the PCI address range mapped from @pci_addr is
+ * indicated by @map->pci_size. This size may be less than the requested
+ * @pci_size. The local virtual CPU address for the mapping is indicated by
+ * @map->virt_addr (@map->phys_addr indicates the physical address).
+ * The size and CPU address of the controller memory allocated and mapped are
+ * respectively indicated by @map->map_size and @map->virt_base (and
+ * @map->phys_base).
+ *
+ * Returns 0 on success and a negative error code in case of error.
+ */
+int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
+{
+	int ret;
+
+	ret = pci_epc_map_align(epc, func_no, vfunc_no, pci_addr, pci_size, map);
+	if (ret)
+		return ret;
+
+	map->virt_base = pci_epc_mem_alloc_addr(epc, &map->phys_base,
+						map->map_size);
+	if (!map->virt_base)
+		return -ENOMEM;
+
+	map->phys_addr = map->phys_base + map->map_ofst;
+	map->virt_addr = map->virt_base + map->map_ofst;
+
+	ret = pci_epc_map_addr(epc, func_no, vfunc_no, map->phys_base,
+			       map->map_pci_addr, map->map_size);
+	if (ret) {
+		pci_epc_mem_free_addr(epc, map->phys_base, map->virt_base,
+				      map->map_size);
+		map->virt_base = 0;
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epc_mem_map);
+
+/**
+ * pci_epc_mem_unmap() - unmap and free a CPU address region
+ * @epc: the EPC device on which the CPU address is allocated and mapped
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
+ * @map: the mapping information
+ *
+ * Unmap and free a CPU address region that was allocated and mapped with
+ * pci_epc_mem_map().
+ */
+void pci_epc_mem_unmap(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		       struct pci_epc_map *map)
+{
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+		return;
+
+	if (!map || !map->virt_base)
+		return;
+
+	pci_epc_unmap_addr(epc, func_no, vfunc_no, map->phys_base);
+	pci_epc_mem_free_addr(epc, map->phys_base, map->virt_base,
+			      map->map_size);
+	map->map_size = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epc_mem_unmap);
+
 /**
  * pci_epc_clear_bar() - reset the BAR
  * @epc: the EPC device for which the BAR has to be cleared
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 9df8a83e8d10..97d2fbb740fd 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -315,6 +315,10 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 				     phys_addr_t *phys_addr, size_t size);
 void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
 			   void __iomem *virt_addr, size_t size);
+int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map);
+void pci_epc_mem_unmap(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		       struct pci_epc_map *map);
 
 #else
 static inline void pci_epc_init_notify(struct pci_epc *epc)
-- 
2.46.2


