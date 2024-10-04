Return-Path: <linux-pci+bounces-13798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A75498FCE5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 07:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B601C21185
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 05:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B4D6F2F8;
	Fri,  4 Oct 2024 05:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpDMYsO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D9D28F3
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 05:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018469; cv=none; b=XEEhyeYDb+/wHiJeej5DPTGQhVoOTxniopNiWezqCZSQ4GrEtcb3vm026MKcbCWaBZ93MdLehF2ebtYNfQRVnuaemSWRS9pRjD5sC4zG3GlagEu3Kd8BGqF2TWzxhG+rQeI/KdJ3+A1xJDwlwiR8CdoGCsRT2rv5TgwLF7jr9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018469; c=relaxed/simple;
	bh=oT22oxE0jFfZHpFjv7TN6YXdBj9Itsrn2j8QJgZtGYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fj48ipM0SvDRIPrh9vuAD9Ev9xohGt0TMFg5A8UkDczvSRj1x8dIlfA11ZX/xJ3V7iPOdMu2gYbEf1le7miy9uXM01olbezuftHaMZ9u6ulZKp6++nOWybnOQUXmNsk3HjYFBRSUc1mDob36dcZl4kJMvNkmv/YBbc7HJUfhC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpDMYsO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F0EC4CED0;
	Fri,  4 Oct 2024 05:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728018469;
	bh=oT22oxE0jFfZHpFjv7TN6YXdBj9Itsrn2j8QJgZtGYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EpDMYsO8iFyCkUnLa+HqSrtDU9tuuRl7+gneuTHs2xV97Xnrz59E4S4W6aYuamI5r
	 S2a4CKL/TXGWG6CHl+pVWoOuQ3t9LI1G/Ar2+eQ8vHQXHcWAegrPRh1+Khtdv8GDXy
	 mJmwAcG7kwX8YMAvjJgptfmQVpjXK1Nzl+AUHrRX7/Oi5AY4f05SHbFbZHpphao6CC
	 dGWlpAUoTDrQ3rVsDcMIYwpU1S0hOPxJ/4zpduyI1K4k71reAdbPcVOKUop/nLZkuz
	 7uw4qs9hOUB/x9brtKgmNF/36DT4cY52cO/vbpfSQ7k/+QXlXpaCAbS0hrKNW6a47k
	 MmhU8JydCxAmg==
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
Subject: [PATCH v3 3/7] PCI: endpoint: Introduce pci_epc_map_align()
Date: Fri,  4 Oct 2024 14:07:38 +0900
Message-ID: <20241004050742.140664-4-dlemoal@kernel.org>
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
---
 drivers/pci/endpoint/pci-epc-core.c | 56 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 37 +++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index b854f1bab26f..48dd3c28ac4c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -435,6 +435,62 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
+	memset(map, 0, sizeof(*map));
+	map->pci_addr = pci_addr;
+	map->pci_size = pci_size;
+
+	if (!epc->ops->map_align) {
+		/* Assume that the EP controller has no alignment constraint */
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


