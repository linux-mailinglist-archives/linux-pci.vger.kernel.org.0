Return-Path: <linux-pci+bounces-13906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A53992356
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57677B22289
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AAB200DE;
	Mon,  7 Oct 2024 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaWrsK45"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901853C2F
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273811; cv=none; b=GjdxxkIg7A5zlrh1wi/vgjC0jolPl5RfkM7nePIIXNrQzyVylNTNji0bieSmTWHx6YHOR37443enf6UqKXrV1pIxAoDkSjqXroCndDOiwdIwUYEx9dw1royYJq4caIsMqN3U4BkaLrHShmgwxd2nux7F6X5ctER2alM+Yuh6/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273811; c=relaxed/simple;
	bh=KOlzri2s1hJeQueXMQVc7/f1GBi2mQLHYnXMS6K4sb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcD+tAFD44+UlzfnbKfdq7wfZCluXwAPtGO9yEGDbvcA0I5MEV993pj2Hrqz2qIpL6WPvsAAJDhbO5akRIiHPaLkRV1hSIyoyl/6wJE/Ssm/HoIPY7FberMpsSYAUoijXdUcZyhrSO1NG3zvKyavB4ddElJGifBS2jcNVNaeZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaWrsK45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1372C4CED4;
	Mon,  7 Oct 2024 04:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728273811;
	bh=KOlzri2s1hJeQueXMQVc7/f1GBi2mQLHYnXMS6K4sb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaWrsK45aZB0oP7egIxQlvGoj4+JyowvmL9hGmPst9hbhUy0FnnlZsHBf2DyXX2vD
	 TQjRRsttbMenZ8Br7RUNcGRIdNPcFzjcozu8hlP/sY1ST784BF1jwvSds5zexwA2Jj
	 gMe0uYNnXTt2xUhBnUOSCSLKMus1KFbCJfscO9lyNUa86hJuKueZyxNSuh8d7Ybi4a
	 rqSYOtY/43OkbqQqeVIpLGQ2NweX9BotLjblY5SdIQKek/qWBnBVf6e+nx/NyQyOzN
	 Vml3iR2B8ovEQ9M0//VqGLn2+J8Wf1l6wrZ08Tl5LarrNHNmxvzK/SnBtpKFKKh3er
	 +gETinZIhq2kA==
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
Subject: [PATCH v4 4/7] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
Date: Mon,  7 Oct 2024 13:03:16 +0900
Message-ID: <20241007040319.157412-5-dlemoal@kernel.org>
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
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 78 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  4 ++
 2 files changed, 82 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 1adccf07c33e..d03c753d0a53 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -532,6 +532,84 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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


