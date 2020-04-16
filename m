Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371F61ACE2D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 18:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404320AbgDPQ5d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 12:57:33 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:60168 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404113AbgDPQ5c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2020 12:57:32 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 16 Apr 2020 19:57:25 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 03GGvPXq002050;
        Thu, 16 Apr 2020 19:57:25 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-pci@vger.kernel.org, hch@lst.de
Cc:     fbarrat@linux.ibm.com, clsoto@us.ibm.com, idanw@mellanox.com,
        maxg@mellanox.com, aneela@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 2/2] powerpc/powernv: Enable and setup PCI P2P
Date:   Thu, 16 Apr 2020 19:57:25 +0300
Message-Id: <20200416165725.206741-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200416165725.206741-1-maxg@mellanox.com>
References: <20200416165725.206741-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement the generic dma_map_resource callback on the PCI controller
for powernv. This will enable PCI P2P on POWER9 architecture. It will
allow catching a cross-PHB mmio mapping, which needs to be setup in
hardware by calling opal. Both the initiator and target PHBs need to be
configured, so we look for which PHB owns the mmio address being mapped.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
[maxg: added CONFIG_PCI_P2PDMA wrappers]
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 arch/powerpc/include/asm/opal.h            |   5 +-
 arch/powerpc/platforms/powernv/opal-call.c |   1 +
 arch/powerpc/platforms/powernv/pci-ioda.c  | 164 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h       |   9 ++
 4 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9986ac3..d1b35c4 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -284,7 +284,10 @@ int64_t opal_xive_set_queue_state(uint64_t vp, uint32_t prio,
 				  uint32_t qtoggle,
 				  uint32_t qindex);
 int64_t opal_xive_get_vp_state(uint64_t vp, __be64 *out_w01);
-
+#ifdef CONFIG_PCI_P2PDMA
+int64_t opal_pci_set_p2p(uint64_t phb_init, uint64_t phb_target,
+			 uint64_t desc, uint16_t pe_number);
+#endif
 int64_t opal_imc_counters_init(uint32_t type, uint64_t address,
 							uint64_t cpu_pir);
 int64_t opal_imc_counters_start(uint32_t type, uint64_t cpu_pir);
diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
index 5cd0f52..442d5445c 100644
--- a/arch/powerpc/platforms/powernv/opal-call.c
+++ b/arch/powerpc/platforms/powernv/opal-call.c
@@ -273,6 +273,7 @@ int64_t name(int64_t a0, int64_t a1, int64_t a2, int64_t a3,	\
 OPAL_CALL(opal_imc_counters_init,		OPAL_IMC_COUNTERS_INIT);
 OPAL_CALL(opal_imc_counters_start,		OPAL_IMC_COUNTERS_START);
 OPAL_CALL(opal_imc_counters_stop,		OPAL_IMC_COUNTERS_STOP);
+OPAL_CALL(opal_pci_set_p2p,			OPAL_PCI_SET_P2P);
 OPAL_CALL(opal_get_powercap,			OPAL_GET_POWERCAP);
 OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
 OPAL_CALL(opal_get_power_shift_ratio,		OPAL_GET_POWER_SHIFT_RATIO);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 57d3a6a..00a1dfc 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3706,6 +3706,166 @@ static void pnv_pci_ioda_dma_bus_setup(struct pci_bus *bus)
 	}
 }
 
+#ifdef CONFIG_PCI_P2PDMA
+static DEFINE_MUTEX(p2p_mutex);
+
+static int pnv_pci_ioda_set_p2p(struct pci_dev *initiator,
+				struct pnv_phb *phb_target,
+				u64 desc)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb_init;
+	struct pnv_ioda_pe *pe_init;
+	int rc;
+
+	if (!opal_check_token(OPAL_PCI_SET_P2P))
+		return -ENXIO;
+
+	hose = pci_bus_to_host(initiator->bus);
+	phb_init = hose->private_data;
+
+	pe_init = pnv_ioda_get_pe(initiator);
+	if (!pe_init)
+		return -ENODEV;
+
+	/*
+	 * Configuring the initiator's PHB requires to adjust its
+	 * TVE#1 setting. Since the same device can be an initiator
+	 * several times for different target devices, we need to keep
+	 * a reference count to know when we can restore the default
+	 * bypass setting on its TVE#1 when disabling. Opal is not
+	 * tracking PE states, so we add a reference count on the PE
+	 * in linux.
+	 *
+	 * For the target, the configuration is per PHB, so we keep a
+	 * target reference count on the PHB.
+	 */
+	mutex_lock(&p2p_mutex);
+
+	if (desc & OPAL_PCI_P2P_ENABLE) {
+		/* always go to opal to validate the configuration */
+		rc = opal_pci_set_p2p(phb_init->opal_id, phb_target->opal_id,
+				      desc, pe_init->pe_number);
+
+		if (rc != OPAL_SUCCESS) {
+			rc = -EIO;
+			goto out;
+		}
+
+		pe_init->p2p_initiator_count++;
+		phb_target->p2p_target_count++;
+	} else {
+		if (!pe_init->p2p_initiator_count ||
+		    !phb_target->p2p_target_count) {
+			rc = -EINVAL;
+			goto out;
+		}
+
+		if (--pe_init->p2p_initiator_count == 0)
+			pnv_pci_ioda2_set_bypass(pe_init, true);
+
+		if (--phb_target->p2p_target_count == 0) {
+			rc = opal_pci_set_p2p(phb_init->opal_id,
+					      phb_target->opal_id, desc,
+					      pe_init->pe_number);
+			if (rc != OPAL_SUCCESS) {
+				rc = -EIO;
+				goto out;
+			}
+		}
+	}
+	rc = 0;
+out:
+	mutex_unlock(&p2p_mutex);
+	return rc;
+}
+
+static bool pnv_pci_controller_owns_addr(struct pci_controller *hose,
+					 phys_addr_t addr, size_t size)
+{
+	struct resource *r;
+	int i;
+
+	/*
+	 * it seems safe to assume the full range is under the same
+	 * PHB, so we can ignore the size
+	 */
+	for (i = 0; i < 3; i++) {
+		r = &hose->mem_resources[i];
+		if (r->flags && (addr >= r->start) && (addr < r->end))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * find the phb owning a mmio address if not owned locally
+ */
+static struct pnv_phb *pnv_pci_find_owning_phb(struct pci_dev *pdev,
+					       phys_addr_t addr, size_t size)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb;
+
+	/* fast path */
+	if (pnv_pci_controller_owns_addr(hose, addr, size))
+		return NULL;
+
+	list_for_each_entry(hose, &hose_list, list_node) {
+		phb = hose->private_data;
+		if (phb->type != PNV_PHB_NPU_NVLINK &&
+		    phb->type != PNV_PHB_NPU_OCAPI) {
+			if (pnv_pci_controller_owns_addr(hose, addr, size))
+				return phb;
+		}
+	}
+	return NULL;
+}
+
+static int pnv_pci_dma_map_resource(struct pci_dev *pdev,
+				    phys_addr_t phys_addr, size_t size,
+				    enum dma_data_direction dir)
+{
+	struct pnv_phb *target_phb;
+	int rc;
+	u64 desc;
+
+	target_phb = pnv_pci_find_owning_phb(pdev, phys_addr, size);
+	if (target_phb) {
+		desc = OPAL_PCI_P2P_ENABLE;
+		if (dir == DMA_TO_DEVICE)
+			desc |= OPAL_PCI_P2P_STORE;
+		else if (dir == DMA_FROM_DEVICE)
+			desc |= OPAL_PCI_P2P_LOAD;
+		else if (dir == DMA_BIDIRECTIONAL)
+			desc |= OPAL_PCI_P2P_LOAD | OPAL_PCI_P2P_STORE;
+		rc = pnv_pci_ioda_set_p2p(pdev, target_phb, desc);
+		if (rc) {
+			dev_err(&pdev->dev, "Failed to setup PCI peer-to-peer for address %llx: %d\n",
+				phys_addr, rc);
+			return rc;
+		}
+	}
+	return 0;
+}
+
+static void pnv_pci_dma_unmap_resource(struct pci_dev *pdev,
+				       dma_addr_t addr, size_t size,
+				       enum dma_data_direction dir)
+{
+	struct pnv_phb *target_phb;
+	int rc;
+
+	target_phb = pnv_pci_find_owning_phb(pdev, addr, size);
+	if (target_phb) {
+		rc = pnv_pci_ioda_set_p2p(pdev, target_phb, 0);
+		if (rc)
+			dev_err(&pdev->dev, "Failed to undo PCI peer-to-peer setup for address %llx: %d\n",
+				addr, rc);
+	}
+}
+#endif
+
 static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 	.dma_dev_setup		= pnv_pci_ioda_dma_dev_setup,
 	.dma_bus_setup		= pnv_pci_ioda_dma_bus_setup,
@@ -3718,6 +3878,10 @@ static void pnv_pci_ioda_dma_bus_setup(struct pci_bus *bus)
 	.setup_bridge		= pnv_pci_setup_bridge,
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
 	.shutdown		= pnv_pci_ioda_shutdown,
+#ifdef CONFIG_PCI_P2PDMA
+	.dma_map_resource	= pnv_pci_dma_map_resource,
+	.dma_unmap_resource	= pnv_pci_dma_unmap_resource,
+#endif
 };
 
 static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index d3bbdea..5f85d9c 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -79,6 +79,10 @@ struct pnv_ioda_pe {
 	struct pnv_ioda_pe	*master;
 	struct list_head	slaves;
 
+#ifdef CONFIG_PCI_P2PDMA
+	/* PCI peer-to-peer*/
+	int			p2p_initiator_count;
+#endif
 	/* Link in list of PE#s */
 	struct list_head	list;
 };
@@ -168,6 +172,11 @@ struct pnv_phb {
 	/* PHB and hub diagnostics */
 	unsigned int		diag_data_size;
 	u8			*diag_data;
+
+#ifdef CONFIG_PCI_P2PDMA
+	/* PCI peer-to-peer*/
+	int			p2p_target_count;
+#endif
 };
 
 extern struct pci_ops pnv_pci_ops;
-- 
1.8.3.1

