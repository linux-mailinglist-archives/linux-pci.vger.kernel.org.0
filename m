Return-Path: <linux-pci+bounces-14386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0726A99B485
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 13:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63EE281DF5
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36B13B58E;
	Sat, 12 Oct 2024 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGYO5ur+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561B156C69
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732774; cv=none; b=U5d7yLuxcOwKwyCnkOpQdUcL96IgbvC9QALeYtyA8GFdoRvDkZKcgg1DMH1fKLfunYTMv0ZDLqQNBB3lUml0jdMgzM7HrL33DM6dacJJunn/LtbKzFykmYLInjujBMZKuP1poHtZ4ls4A2BY9p4yRd7jSq5S4i4cCutH/4Gib7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732774; c=relaxed/simple;
	bh=3/Q6iMt4UBIPfKQp2kQ8F/+cEx53rLxQV5sdtqLGP+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WF9i0qp7yDxM+IAuoVJGD3mDpCTMSUwSFi0ujiLk+qbc/IhLsw26SvApJRr1mrgOTuiDPz2OyTd8KiF6J+SbEUEPUTwiBvHGYAMUh0E07N0uriAJ4tlzMCmSw1Nv9uaA/2vT5342XuV2zzlcM/ReN1SWODFye5IoAl57z6jnvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGYO5ur+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F796C4CEC6;
	Sat, 12 Oct 2024 11:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732773;
	bh=3/Q6iMt4UBIPfKQp2kQ8F/+cEx53rLxQV5sdtqLGP+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGYO5ur+i7wfm3ihlmT53udb4bTJI8NJamvd3PLZZn5b9snk897cIlfR0P4l+VbAA
	 aV++H1Ksu2ciXNiLqo1w7663h3w0wYo8s4yBrR1E+zm6UUgaXxJYTz4VAXiWZ45bsS
	 JQ8PX6o863KGr8mfO3Cu/RIYWUE2yAUdD50rNE8i8GAGVReGDXsmrOnjpVlLfW/4Sw
	 QKXJrqQCA8zo8NhYHAQZJ1EkHJIFiO/3iNWe/hTbQINMF2t0vc+n8MpT38VWMgSsh2
	 M+TZncV6Q1f+UYSOwmpwoY7lgf0X9FERZefUCvtbT/ISEMJhup5Y1WHjXM2CTKnMEH
	 sDLcXYK4GxTtA==
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
Subject: [PATCH v6 3/6] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
Date: Sat, 12 Oct 2024 20:32:43 +0900
Message-ID: <20241012113246.95634-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241012113246.95634-1-dlemoal@kernel.org>
References: <20241012113246.95634-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some endpoint controllers have requirements on the alignment of the
controller physical memory address that must be used to map a RC PCI
address region. For instance, the endpoint controller of the RK3399 SoC
uses at most the lower 20 bits of a physical memory address region as
the lower bits of a RC PCI address region. For mapping a PCI address
region of size bytes starting from pci_addr, the exact number of
address bits used is the number of address bits changing in the address
range [pci_addr..pci_addr + size - 1]. For this example, this creates
the following constraints:
1) The offset into the controller physical memory allocated for a
   mapping depends on the mapping size *and* the starting PCI address
   for the mapping.
2) A mapping size cannot exceed the controller windows size (1MB) minus
   the offset needed into the allocated physical memory, which can end
   up being a smaller size than the desired mapping size.

Handling these constraints independently of the controller being used
in an endpoint function driver is not possible with the current EPC
API as only the ->align field in struct pci_epc_features is provided
but used for BAR (inbound ATU mappings) mapping only. A new API is
needed for function drivers to discover mapping constraints and handle
non-static requirements based on the RC PCI address range to access.

Introduce the endpoint controller operation ->align_addr() to allow
the EPC core functions to obtain the size and the offset into a
controller address region that must be allocated and mapped to access
a RC PCI address region. The size of the mapping provided by the
align_addr() operation can then be used as the size argument for the
function pci_epc_mem_alloc_addr() and the offset into the allocated
controller memory provided can be used to correctly handle data
transfers. For endpoint controllers that have PCI address alignment
constraints, the align_addr() operation may indicate upon return an
effective PCI address mapping size that is smaller (but not 0) than the
requested PCI address region size.

The controller ->align_addr() operation is optional: controllers that
do not have any alignment constraints for mapping RC PCI address regions
do not need to implement this operation. For such controllers, it is
always assumed that the mapping size is equal to the requested size of
the PCI region and that the mapping offset is 0.

The function pci_epc_mem_map() is introduced to use this new controller
operation (if it is defined) to handle controller memory allocation and
mapping to a RC PCI address region in endpoint function drivers.

This function first uses the ->align_addr() controller operation to
determine the controller memory address size (and offset into) needed
for mapping an RC PCI address region. The result of this operation is
used to allocate a controller physical memory region using
pci_epc_mem_alloc_addr() and then to map that memory to the RC PCI
address space with pci_epc_map_addr().

Since ->align_addr() () may indicate that not all of a RC PCI address
region can be mapped, pci_epc_mem_map() may only partially map the RC
PCI address region specified. It is the responsibility of the caller
(an endpoint function driver) to handle such smaller mapping by
repeatedly using pci_epc_mem_map() over the desried PCI address range.

The counterpart of pci_epc_mem_map() to unmap and free a mapped
controller memory address region is pci_epc_mem_unmap().

Both functions operate using the new struct pci_epc_map data structure.
This new structure represents a mapping PCI address, mapping effective
size, the size of the controller memory needed for the mapping as well
as the physical and virtual CPU addresses of the mapping (phys_base and
virt_base fields). For convenience, the physical and virtual CPU
addresses within that mapping to use to access the target RC PCI address
region are also provided (phys_addr and virt_addr fields).

Endpoint function drivers can use struct pci_epc_map to access the
mapped RC PCI address region using the ->virt_addr and ->pci_size
fields.

Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 103 ++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  38 ++++++++++
 2 files changed, 141 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index b854f1bab26f..04a85d2f7e2a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -466,6 +466,109 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
+ * constraints using the controller operation align_addr(). If this operation is
+ * not defined, we assume that there are no alignment constraints for the
+ * mapping.
+ *
+ * The effective size of the PCI address range mapped from @pci_addr is
+ * indicated by @map->pci_size. This size may be less than the requested
+ * @pci_size. The local virtual CPU address for the mapping is indicated by
+ * @map->virt_addr (@map->phys_addr indicates the physical address).
+ * The size and CPU address of the controller memory allocated and mapped are
+ * respectively indicated by @map->map_size and @map->virt_base (and
+ * @map->phys_base for the physical address of @map->virt_base).
+ *
+ * Returns 0 on success and a negative error code in case of error.
+ */
+int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
+{
+	size_t map_size = pci_size;
+	size_t map_offset = 0;
+	int ret;
+
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+		return -EINVAL;
+
+	if (!pci_size || !map)
+		return -EINVAL;
+
+	/*
+	 * Align the PCI address to map. If the controller defines the
+	 * .align_addr() operation, use it to determine the PCI address to map
+	 * and the size of the mapping. Otherwise, assume that the controller
+	 * has no alignment constraint.
+	 */
+	memset(map, 0, sizeof(*map));
+	map->pci_addr = pci_addr;
+	if (epc->ops->align_addr)
+		map->map_pci_addr =
+			epc->ops->align_addr(epc, pci_addr,
+					     &map_size, &map_offset);
+	else
+		map->map_pci_addr = pci_addr;
+	map->map_size = map_size;
+	if (map->map_pci_addr + map->map_size < pci_addr + pci_size)
+		map->pci_size = map->map_pci_addr + map->map_size - pci_addr;
+	else
+		map->pci_size = pci_size;
+
+	map->virt_base = pci_epc_mem_alloc_addr(epc, &map->phys_base,
+						map->map_size);
+	if (!map->virt_base)
+		return -ENOMEM;
+
+	map->phys_addr = map->phys_base + map_offset;
+	map->virt_addr = map->virt_base + map_offset;
+
+	ret = pci_epc_map_addr(epc, func_no, vfunc_no, map->phys_base,
+			       map->map_pci_addr, map->map_size);
+	if (ret) {
+		pci_epc_mem_free_addr(epc, map->phys_base, map->virt_base,
+				      map->map_size);
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
+}
+EXPORT_SYMBOL_GPL(pci_epc_mem_unmap);
+
 /**
  * pci_epc_clear_bar() - reset the BAR
  * @epc: the EPC device for which the BAR has to be cleared
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 42ef06136bd1..f4b8dc37e447 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -32,11 +32,43 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
 	}
 }
 
+/**
+ * struct pci_epc_map - information about EPC memory for mapping a RC PCI
+ *                      address range
+ * @pci_addr: start address of the RC PCI address range to map
+ * @pci_size: size of the RC PCI address range mapped from @pci_addr
+ * @map_pci_addr: RC PCI address used as the first address mapped (may be lower
+ *                than @pci_addr)
+ * @map_size: size of the controller memory needed for mapping the RC PCI address
+ *            range @pci_addr..@pci_addr+@pci_size
+ * @phys_base: base physical address of the allocated EPC memory for mapping the
+ *             RC PCI address range
+ * @phys_addr: physical address at which @pci_addr is mapped
+ * @virt_base: base virtual address of the allocated EPC memory for mapping the
+ *             RC PCI address range
+ * @virt_addr: virtual address at which @pci_addr is mapped
+ */
+struct pci_epc_map {
+	phys_addr_t	pci_addr;
+	size_t		pci_size;
+
+	phys_addr_t	map_pci_addr;
+	size_t		map_size;
+
+	phys_addr_t	phys_base;
+	phys_addr_t	phys_addr;
+	void __iomem	*virt_base;
+	void __iomem	*virt_addr;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
  * @set_bar: ops to configure the BAR
  * @clear_bar: ops to reset the BAR
+ * @align_addr: operation to get the mapping address, mapping size and offset
+ *		into a controller memory window needed to map an RC PCI address
+ *		region
  * @map_addr: ops to map CPU address to PCI address
  * @unmap_addr: ops to unmap CPU address and PCI address
  * @set_msi: ops to set the requested number of MSI interrupts in the MSI
@@ -61,6 +93,8 @@ struct pci_epc_ops {
 			   struct pci_epf_bar *epf_bar);
 	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			     struct pci_epf_bar *epf_bar);
+	phys_addr_t (*align_addr)(struct pci_epc *epc, phys_addr_t pci_addr,
+				  size_t *size, size_t *offset);
 	int	(*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			    phys_addr_t addr, u64 pci_addr, size_t size);
 	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
@@ -278,6 +312,10 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
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
2.47.0


