Return-Path: <linux-pci+bounces-41414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA174C648FD
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B17C64EF778
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214E8334363;
	Mon, 17 Nov 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNUshUP9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B5D23ABBE;
	Mon, 17 Nov 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388068; cv=none; b=NySA+EZzATU5j0SJZy0yQSDXlEhqYZkM7RB+pVN+R/LfwM8Jg79pskjMAP/dz5kIEEHI3x4dq6AHLFDeEp63pyK3G3sLtTG/HogVGBNrh+VTCETYlpjaIVTsPXiJkhaJip3JEewzUiSVqd272hQ4rUcdXN4m1umhrK0wmnCfWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388068; c=relaxed/simple;
	bh=NqafC8oHuClp/7pmoR0NnAx7CBHhUjEvobX81XmOG+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKK6MyMoskYTkt4ubidM5GT24Szf3GZV8UvWi2VzHwe+3wqkEVnSlhhkU8I+hvk0Gkkq3Qw7IP0AJWPUeM22kn1i+4s7EsF4d6dgWZ2OjmI0WQDSpDusKk7fWli8LKcU93uldjxMMlfkwY71vIPOSZzidIZBQl8Bll2PzPMdtAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNUshUP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481AEC19421;
	Mon, 17 Nov 2025 14:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763388067;
	bh=NqafC8oHuClp/7pmoR0NnAx7CBHhUjEvobX81XmOG+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNUshUP9nFqyUINAruJLwcmBb0o11lWLiVwPToSjMhOtVaP3Ry9T+ZaMsiZncvvzK
	 LJT561Pq8uUG22M7e0Ho3//INWwJGx7Wk6w/rBQQC+/KPk/TnpnUlIP1OE1qvA0R7u
	 sZhqN0rHAJnzkwhCWI+b85RKcmGVCykD4O2WQVB0xxw2eqhskpHKrUffAmH87V1xkK
	 xSKO0CcGwc1MPICIS8eOW7LUi1rSwJcJWOr53cN5tDWLYxTMESkSniggF0X/k4jVZd
	 ByTp2c3qC4/ppuiOUkJSe+sImkeAZMmY+wDQMBpJAYa90nPhVu7F/pyi2KU0076Pi1
	 Bc7cELHbBy8VQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH v2 07/11] coco: guest: arm64: Validate Realm MMIO mappings from TDISP report
Date: Mon, 17 Nov 2025 19:30:03 +0530
Message-ID: <20251117140007.122062-8-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117140007.122062-1-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the TDISP device interface report and drive the RSI
RDEV_VALIDATE_MAPPING handshake for each Realm MMIO window. The new
helper walks the reported ranges, rejects malformed entries, and either
validates the IPA->PA mapping when the device transitions to RUN or tears
it down with RIPAS updates on unlock.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi_cmds.h         | 29 ++++++++
 arch/arm64/include/asm/rsi_smc.h          |  4 +
 drivers/virt/coco/arm-cca-guest/arm-cca.c |  9 +++
 drivers/virt/coco/arm-cca-guest/rsi-da.c  | 91 +++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.h  | 24 +++++-
 5 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index 18aa1b9efb9b..fe36dd2b96ac 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -185,4 +185,33 @@ static inline unsigned long rsi_host_call(phys_addr_t addr)
 	return res.a0;
 }
 
+static inline long
+rsi_vdev_validate_mapping(unsigned long vdev_id,
+			  phys_addr_t ipa_base, phys_addr_t ipa_top,
+			  phys_addr_t pa_base, phys_addr_t *next_ipa,
+			  unsigned long flags, unsigned long lock_nonce,
+			  unsigned long meas_nonce, unsigned report_nonce)
+{
+	struct arm_smccc_1_2_regs res;
+	struct arm_smccc_1_2_regs regs = {
+		.a0 = SMC_RSI_VDEV_VALIDATE_MAPPING,
+		.a1 = vdev_id,
+		.a2 = ipa_base,
+		.a3 = ipa_top,
+		.a4 = pa_base,
+		.a5 = flags,
+		.a6 = lock_nonce,
+		.a7 = meas_nonce,
+		.a8 = report_nonce,
+	};
+
+	arm_smccc_1_2_invoke(&regs, &res);
+	*next_ipa = res.a1;
+
+	if (res.a2 != RSI_ACCEPT)
+		return -EPERM;
+
+	return res.a0;
+}
+
 #endif /* __ASM_RSI_CMDS_H */
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index 4dbd87a27d9b..26aaa97469e8 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -183,6 +183,10 @@ struct realm_config {
  */
 #define SMC_RSI_IPA_STATE_GET			SMC_RSI_FID(0x198)
 
+#define RSI_DEV_MEM_COHERENT		BIT(0)
+#define RSI_DEV_MEM_LIMITED_ORDER	BIT(1)
+#define SMC_RSI_VDEV_VALIDATE_MAPPING		SMC_RSI_FID(0x19F)
+
 struct rsi_host_call {
 	union {
 		u16 imm;
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
index 7988ff6d4b2e..e86c3ad355f8 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -223,10 +223,19 @@ static struct pci_tsm *cca_tsm_lock(struct tsm_dev *tsm_dev, struct pci_dev *pde
 
 static void cca_tsm_unlock(struct pci_tsm *tsm)
 {
+	long ret;
 	struct cca_guest_dsc *cca_dsc = to_cca_guest_dsc(tsm->pdev);
 
+	/* invalidate dev mapping based on interface report */
+	ret = cca_apply_interface_report_mappings(tsm->pdev, false);
+	if (ret) {
+		pci_err(tsm->pdev, "failed to invalidate the interface report\n");
+		goto err_out;
+	}
+
 	cca_device_unlock(tsm->pdev);
 
+err_out:
 	kfree(cca_dsc);
 }
 
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
index aa6e13e4c0ea..c70fb7dd4838 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -105,3 +105,94 @@ int cca_update_device_object_cache(struct pci_dev *pdev, struct cca_guest_dsc *d
 	}
 	return 0;
 }
+
+static inline int
+rsi_validate_dev_mapping(unsigned long vdev_id, phys_addr_t start_ipa,
+			 phys_addr_t end_ipa, phys_addr_t io_pa,
+			 unsigned long flags, unsigned long lock_nonce,
+			 unsigned long meas_nonce, unsigned long report_nonce)
+{
+	unsigned long ret;
+	phys_addr_t next_ipa;
+
+	while (start_ipa < end_ipa) {
+		ret = rsi_vdev_validate_mapping(vdev_id, start_ipa, end_ipa,
+						io_pa, &next_ipa, flags,
+						lock_nonce, meas_nonce, report_nonce);
+		if (ret || next_ipa <= start_ipa || next_ipa > end_ipa)
+			return -EINVAL;
+		io_pa += next_ipa - start_ipa;
+		start_ipa = next_ipa;
+	}
+	return 0;
+}
+
+static inline int rsi_invalidate_dev_mapping(phys_addr_t start_ipa, phys_addr_t end_ipa)
+{
+	return rsi_set_memory_range(start_ipa, end_ipa, RSI_RIPAS_EMPTY,
+				    RSI_CHANGE_DESTROYED);
+}
+
+int cca_apply_interface_report_mappings(struct pci_dev *pdev, bool validate)
+{
+	int ret;
+	struct resource *r;
+	unsigned int range_id;
+	phys_addr_t mmio_start_phys;
+	struct pci_tdisp_mmio_range *mmio_range;
+	phys_addr_t ipa_start, ipa_end, bar_offset;
+	struct pci_tdisp_device_interface_report *interface_report;
+	struct cca_guest_dsc *dsc = to_cca_guest_dsc(pdev);
+
+	interface_report = (struct pci_tdisp_device_interface_report *)dsc->interface_report;
+	mmio_range = (struct pci_tdisp_mmio_range *)(interface_report + 1);
+
+
+	for (int i = 0; i < interface_report->mmio_range_count; i++, mmio_range++) {
+
+		range_id = FIELD_GET(TSM_INTF_REPORT_MMIO_RANGE_ID, mmio_range->range_attributes);
+
+		if (range_id >= PCI_NUM_RESOURCES) {
+			pci_warn(pdev, "Skipping broken range [%d] #%d %d\n",
+				 i, range_id, mmio_range->num_pages);
+			continue;
+		}
+
+		r = pci_resource_n(pdev, range_id);
+
+		if (r->end == r->start ||
+		    resource_size(r) & ~PAGE_MASK || !mmio_range->num_pages) {
+			pci_warn(pdev, "Skipping broken range [%d] #%d %d pages, %llx..%llx\n",
+				i, range_id, mmio_range->num_pages, r->start, r->end);
+			continue;
+		}
+
+		if (FIELD_GET(TSM_INTF_REPORT_MMIO_IS_NON_TEE, mmio_range->range_attributes)) {
+			pci_info(pdev, "Skipping non-TEE range [%d] #%d %d pages, %llx..%llx\n",
+				 i, range_id, mmio_range->num_pages, r->start, r->end);
+			continue;
+		}
+
+		/* No secure interrupts, we should not find this set, ignore for now. */
+		if (FIELD_GET(TSM_INTF_REPORT_MMIO_MSIX_TABLE, mmio_range->range_attributes) ||
+		    FIELD_GET(TSM_INTF_REPORT_MMIO_PBA, mmio_range->range_attributes)) {
+			pci_info(pdev, "Skipping MSIX (%ld/%ld) range [%d] #%d %d pages, %llx..%llx\n",
+				 FIELD_GET(TSM_INTF_REPORT_MMIO_MSIX_TABLE, mmio_range->range_attributes),
+				 FIELD_GET(TSM_INTF_REPORT_MMIO_PBA, mmio_range->range_attributes),
+				 i, range_id, mmio_range->num_pages, r->start, r->end);
+			continue;
+		}
+
+		/* units in 4K size*/
+		mmio_start_phys = mmio_range->first_page << 12;
+		bar_offset = mmio_start_phys & (pci_resource_len(pdev, range_id) - 1);
+		ipa_start = r->start + bar_offset;
+		ipa_end = ipa_start + (mmio_range->num_pages << 12);
+
+		if (!validate)
+			ret = rsi_invalidate_dev_mapping(ipa_start, ipa_end);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
index fa9cc01095da..32cf90beb55e 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -12,6 +12,28 @@
 
 #define MAX_CACHE_OBJ_SIZE	SZ_16M
 
+struct pci_tdisp_device_interface_report {
+	u16 interface_info;
+	u16 reserved;
+	u16 msi_x_message_control;
+	u16 lnr_control;
+	u32 tph_control;
+	u32 mmio_range_count;
+} __packed;
+
+struct pci_tdisp_mmio_range {
+	u64 first_page;
+	u32 num_pages;
+	u32 range_attributes;
+} __packed;
+
+#define TSM_INTF_REPORT_MMIO_MSIX_TABLE		BIT(0)
+#define TSM_INTF_REPORT_MMIO_PBA		BIT(1)
+#define TSM_INTF_REPORT_MMIO_IS_NON_TEE		BIT(2)
+#define TSM_INTF_REPORT_MMIO_IS_UPDATABLE	BIT(3)
+#define TSM_INTF_REPORT_MMIO_RESERVED		GENMASK(15, 4)
+#define TSM_INTF_REPORT_MMIO_RANGE_ID		GENMASK(31, 16)
+
 struct cca_guest_dsc {
 	struct pci_tsm_devsec pci;
 	void *interface_report;
@@ -42,5 +64,5 @@ int cca_device_unlock(struct pci_dev *pdev);
 int cca_update_device_object_cache(struct pci_dev *pdev, struct cca_guest_dsc *dsc);
 struct page *alloc_shared_pages(int nid, gfp_t gfp_mask, unsigned long min_size);
 int free_shared_pages(struct page *page, unsigned long min_size);
-
+int cca_apply_interface_report_mappings(struct pci_dev *pdev, bool validate);
 #endif
-- 
2.43.0


