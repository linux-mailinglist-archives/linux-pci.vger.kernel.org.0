Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF1B49D2B8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 20:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244539AbiAZTvC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 14:51:02 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:46865 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231611AbiAZTvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jan 2022 14:51:01 -0500
X-IronPort-AV: E=Sophos;i="5.88,319,1635174000"; 
   d="scan'208";a="107766003"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Jan 2022 04:51:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C97AF4008541;
        Thu, 27 Jan 2022 04:50:57 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 1/5] PCI: endpoint: Add ops and flag to support internal DMAC
Date:   Wed, 26 Jan 2022 19:50:39 +0000
Message-Id: <20220126195043.28376-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add flag to indicate if PCIe EP supports internal DMAC and also add a
wrapper function which invokes dmac_transfer() callback which lands
in the PCIe EP driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 32 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  8 ++++++++
 include/linux/pci-epf.h             |  7 +++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 9ed556936f48..f70576d0d4b2 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -239,6 +239,38 @@ void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
 }
 EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
 
+/**
+ * pci_epf_internal_dmac_xfr() - transfer data between EPC and remote PCIe RC
+ * @epf: the EPF device that performs the data transfer operation
+ * @dma_dst: The destination address of the data transfer. It can be a physical
+ *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
+ * @dma_src: The source address of the data transfer. It can be a physical
+ *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
+ * @len: The size of the data transfer
+ *
+ * Invoke to transfer data between EPC and remote PCIe RC using internal dmac.
+ */
+int pci_epf_internal_dmac_xfr(struct pci_epf *epf, dma_addr_t dma_dst,
+			      dma_addr_t dma_src, size_t len,
+			      enum pci_epf_xfr_direction dir)
+{
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (IS_ERR_OR_NULL(epc) || IS_ERR_OR_NULL(epf))
+		return -EINVAL;
+
+	if (!epc->ops->dmac_transfer)
+		return -EINVAL;
+
+	mutex_lock(&epf->lock);
+	ret = epc->ops->dmac_transfer(epc, epf, dma_dst, dma_src, len, dir);
+	mutex_unlock(&epf->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_internal_dmac_xfr);
+
 /**
  * pci_epf_free_space() - free the allocated PCI EPF register space
  * @epf: the EPF device from whom to free the memory
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index a48778e1a4ee..b55dacd09e1e 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -58,6 +58,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
  * @map_msi_irq: ops to map physical address to MSI address and return MSI data
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
+ * @dmac_transfer: ops to transfer data using internal DMAC
  * @get_features: ops to get the features supported by the EPC
  * @owner: the module owner containing the ops
  */
@@ -86,6 +87,9 @@ struct pci_epc_ops {
 			       u32 *msi_addr_offset);
 	int	(*start)(struct pci_epc *epc);
 	void	(*stop)(struct pci_epc *epc);
+	int	(*dmac_transfer)(struct pci_epc *epc, struct pci_epf *epf,
+				 dma_addr_t dma_dst, dma_addr_t dma_src,
+				 size_t len, enum pci_epf_xfr_direction dir);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
 	struct module *owner;
@@ -159,6 +163,8 @@ struct pci_epc {
  *			for initialization
  * @msi_capable: indicate if the endpoint function has MSI capability
  * @msix_capable: indicate if the endpoint function has MSI-X capability
+ * @internal_dmac: indicate if the endpoint function has internal DMAC
+ * @internal_dmac_mask: indicates the DMA mask to be applied for the device
  * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
  * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
  * @bar_fixed_size: Array specifying the size supported by each BAR
@@ -169,6 +175,8 @@ struct pci_epc_features {
 	unsigned int	core_init_notifier : 1;
 	unsigned int	msi_capable : 1;
 	unsigned int	msix_capable : 1;
+	unsigned int	internal_dmac : 1;
+	u64		internal_dmac_mask;
 	u8	reserved_bar;
 	u8	bar_fixed_64bit;
 	u64	bar_fixed_size[PCI_STD_NUM_BARS];
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 009a07147c61..78d661db085d 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -32,6 +32,11 @@ enum pci_barno {
 	BAR_5,
 };
 
+enum pci_epf_xfr_direction {
+	PCIE_TO_INTERNAL,
+	INTERNAL_TO_PCIE,
+};
+
 /**
  * struct pci_epf_header - represents standard configuration header
  * @vendorid: identifies device manufacturer
@@ -209,6 +214,8 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
+int pci_epf_internal_dmac_xfr(struct pci_epf *epf, dma_addr_t dma_dst, dma_addr_t dma_src,
+			      size_t len, enum pci_epf_xfr_direction dir);
 struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
 					  struct config_group *group);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
-- 
2.25.1

