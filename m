Return-Path: <linux-pci+bounces-13905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACE5992354
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55555281DCA
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1234430;
	Mon,  7 Oct 2024 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlCpVJk5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4DA3C2F
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273810; cv=none; b=trHvgQU49RR09ssYtXekWJpLY41prN30fr1WBXd5Wn4Oz+tg4y7FhdP027khcc4C9vFjk0grX0g9vDKGsepkY9J+DFoY38+OuxpwBOzQ5OrTthEqzIOigbTQVIagQzBB9gh5UsIiiqXMXazMfXZv1isfxGN/JNI7SyiBC/zxev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273810; c=relaxed/simple;
	bh=UUXdM1jQ/TU3bBVAZx9KnWiIMLvAC44zvvkJDss6DKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alpjdrdY64cvb5KWu20Er1yNgXP9uCqoQFmiD0w1SvlKe+Rb27J8SQwb9QI04k1rEAfoXt/tn6+xwcwb8233UraQUyc+80i/6n1P3cpkRIulUJtoCGaOlGy1IqP91uaH5haBqeO4sXVw0lQDeeLLTjpqYqB7VBXVoiGgomrWd8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlCpVJk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F8DC4CED2;
	Mon,  7 Oct 2024 04:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728273809;
	bh=UUXdM1jQ/TU3bBVAZx9KnWiIMLvAC44zvvkJDss6DKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QlCpVJk5GCM3bw1E72lsYZi3xx/burIXhxlDR5DVSR2tXwaTjYQoJgR+Y/+Ls+eoO
	 l9QG8+3bEmVK10Mf++p52FzqOHGaKtfdkjmUTvq8Zi61IcDJJF+MohPKquUGq0YaXz
	 QC9YGenArahxfce+yC/UdhS/zIClWwlEoZqa1kZ071zimhFCHNWgOuEd0FvViHg4eD
	 +prlTgELOdK0RntUkwFT0GqguhVONGOfjNsFEsbiAuLGLKxYcEx3ATgxJ7uDN0QntF
	 MY90iVOPwZwLSKSPVKw+YiQgm4ljNwYsGDMB0rrbnNInbeUWNbjHdjTmh2t1StHZAe
	 AhuO5C8iSuQCA==
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
Subject: [PATCH v4 3/7] PCI: endpoint: Introduce pci_epc_map_align()
Date: Mon,  7 Oct 2024 13:03:15 +0900
Message-ID: <20241007040319.157412-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007040319.157412-1-dlemoal@kernel.org>
References: <20241007040319.157412-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some endpoint controllers have requirements on the alignment of the
controller physical memory address that must be used to map a RC PCI
address region. For instance, the rockchip endpoint controller uses
at most the lower 20 bits of a physical memory address region as the
lower bits of an RC PCI address. For mapping a PCI address region of
size bytes starting from pci_addr, the exact number of address bits
used is the number of address bits changing in the address range
[pci_addr..pci_addr + size - 1].

For this example, this creates the following constraints:
1) The offset into the controller physical memory allocated for a
   mapping depends on the mapping size *and* the starting PCI address
   for the mapping.
2) A mapping size cannot exceed the controller windows size (1MB) minus
   the offset needed into the allocated physical memory, which can end
   up being a smaller size than the desired mapping size.

Handling these constraints independently of the controller being used
in an endpoint function driver is not possible with the current EPC
API as only the ->align field in struct pci_epc_features is provided
and used for BAR (inbound ATU mappings) mapping. A new API is needed
for function drivers to discover mapping constraints and handle
non-static requirements based on the RC PCI address range to access.

Introduce the function pci_epc_map_align() and the endpoint controller
operation ->map_align to allow endpoint function drivers to obtain the
size and the offset into a controller address region that must be
allocated and mapped to access an RC PCI address region. The size
of the mapping provided by pci_epc_map_align() can then be used as the
size argument for the function pci_epc_mem_alloc_addr().
The offset into the allocated controller memory provided can be used to
correctly handle data transfers.

For endpoint controllers that have PCI address alignment constraints,
pci_epc_map_align() may indicate upon return an effective PCI address
region mapping size that is smaller (but not 0) than the requested PCI
address region size. For such case, an endpoint function driver must
handle data accesses over the desired PCI address range in fragments,
by repeatedly using pci_epc_map_align() over the PCI address range.

The controller operation ->map_align is optional: controllers that do
not have any alignment constraints for mapping a RC PCI address region
do not need to implement this operation. For such controllers,
pci_epc_map_align() always returns the mapping size as equal to the
requested size of the PCI region and an offset equal to 0.

The new structure struct pci_epc_map is introduced to represent a
mapping start PCI address, mapping effective size, the size and offset
into the controller memory needed for mapping the PCI address region as
well as the physical and virtual CPU addresses of the mapping (phys_base
and virt_base fields). For convenience, the physical and virtual CPU
addresses within that mapping to access the target RC PCI address region
are also provided (phys_addr and virt_addr fields).

Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 66 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 37 ++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index b854f1bab26f..1adccf07c33e 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -435,6 +435,72 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
 
+/**
+ * pci_epc_map_align() - Get the offset into and the size of a controller memory
+ *			 address region needed to map a RC PCI address region
+ * @epc: the EPC device on which address is allocated
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
+ * @pci_addr: The RC PCI address to map
+ * @pci_size: the number of bytes to map starting from @pci_addr
+ * @map: populate here the actual size and offset into the controller memory
+ *       that must be allocated for the mapping
+ *
+ * If defined, invoke the controller map_align operation to obtain the size and
+ * the offset into a controller address region that must be allocated to map
+ * @pci_size bytes of the RC PCI address space starting from @pci_addr.
+ *
+ * On return, @map->pci_size indicates the effective size of the mapping that
+ * can be handled by the controller. This size may be smaller than the requested
+ * @pci_size. In such case, the endpoint function driver must handle the mapping
+ * using several fragments. The offset into the controller memory for the
+ * effective mapping of the RC PCI address range
+ * @pci_addr..@pci_addr+@map->pci_size is indicated by @map->map_ofst.
+ *
+ * If the target controller does not define a map_align operation, it is assumed
+ * that the controller has no PCI address mapping alignment constraint.
+ */
+int pci_epc_map_align(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		      u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
+{
+	int ret;
+
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+		return -EINVAL;
+
+	if (!pci_size || !map)
+		return -EINVAL;
+
+	/*
+	 * Initialize and remember the PCI address region to be mapped. The
+	 * controller ->map_align() operation may change the map->pci_size to a
+	 * smaller value.
+	 */
+	memset(map, 0, sizeof(*map));
+	map->pci_addr = pci_addr;
+	map->pci_size = pci_size;
+
+	if (!epc->ops->map_align) {
+		/*
+		 * Assume that the EP controller has no alignment constraint,
+		 * that is, that the PCI address to map and the size of the
+		 * controller memory needed for the mapping are the same as
+		 * specified by the caller.
+		 */
+		map->map_pci_addr = pci_addr;
+		map->map_size = pci_size;
+		map->map_ofst = 0;
+		return 0;
+	}
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->map_align(epc, func_no, vfunc_no, map);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_map_align);
+
 /**
  * pci_epc_map_addr() - map CPU address to PCI address
  * @epc: the EPC device on which address is allocated
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 42ef06136bd1..9df8a83e8d10 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -32,11 +32,44 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
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
+ * @map_ofst: offset into the mapped controller memory to access @pci_addr
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
+	phys_addr_t	map_ofst;
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
+ * @map_align: operation to get the size and offset into a controller memory
+ *             window needed to map an RC PCI address region
  * @map_addr: ops to map CPU address to PCI address
  * @unmap_addr: ops to unmap CPU address and PCI address
  * @set_msi: ops to set the requested number of MSI interrupts in the MSI
@@ -61,6 +94,8 @@ struct pci_epc_ops {
 			   struct pci_epf_bar *epf_bar);
 	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			     struct pci_epf_bar *epf_bar);
+	int	(*map_align)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			    struct pci_epc_map *map);
 	int	(*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			    phys_addr_t addr, u64 pci_addr, size_t size);
 	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
@@ -241,6 +276,8 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		    struct pci_epf_bar *epf_bar);
 void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		       struct pci_epf_bar *epf_bar);
+int pci_epc_map_align(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		      u64 pci_addr, size_t size, struct pci_epc_map *map);
 int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		     phys_addr_t phys_addr,
 		     u64 pci_addr, size_t size);
-- 
2.46.2


