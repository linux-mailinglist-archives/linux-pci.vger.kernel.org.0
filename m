Return-Path: <linux-pci+bounces-33066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DCFB13C7D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554F2540961
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C402820C6;
	Mon, 28 Jul 2025 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC5mRm2N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0626B764;
	Mon, 28 Jul 2025 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710959; cv=none; b=M7/O+5IcB46V07nUA7IO71Q3t7y17WYdKVpoQQDXpsgv3aD467g1BsuGbV05CbzYN14B5qmJuol4wQUGMWNrgOVFW/VP4whdE3oHuhEgdnFZRwUTtJaBsgsNjOdvX4M6J8FRRVQHC6dUam0CW2RPoQBxKSvfeZo3AqESj4BV8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710959; c=relaxed/simple;
	bh=fLG0zNq+rkQS0AkmSrJIwAxcxEMl8AXx3l1V+ubQACY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2QQ1ee5ngiNAvJRnK6ZERvX7ItcRGmsr/NtOoOu52TQ6Em347HHWs9d6cGRpTaxZmPQG9H9HDdMtpEuGMWVNIgU+emAFk67vsPS4SGTP3YVqjn1ljBQtq42IA3F3UG4nNGaS5N7Lywe3rTUAvAyxZ0k4u4TJ9bRPXrkX+Pq+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pC5mRm2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F9EC4CEEF;
	Mon, 28 Jul 2025 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710959;
	bh=fLG0zNq+rkQS0AkmSrJIwAxcxEMl8AXx3l1V+ubQACY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pC5mRm2Nz7E+xrsouiNe/IeW8XD2Zw2F/Ay5Cpz4+fFJ/xGy48WcSps2Y87mTmPqD
	 8tFTb7uQJ3FUmlixbyyAalat4blllbbCKqUO0laYwTN6KVPPyigbz2MKFV2hrhw1gr
	 Ks//N6vIF9DZpszrnKQA5z4iOk9q1rhihWA/7L5LDFM8UbUOwLE0ZORai1NBWTV2CD
	 l6jYxhhM9Z2eajZysT/+Ps4elh+pvGT3+2Hf5+ibhfW+oMTtNA5QHVfcCsD7OHY29p
	 aRTl2OE2Z3lr9ERICGIJso4JLheoYprk5TZJ+Qpokk3o8bnJJxqRAmdA9GUEyxu6+F
	 v9Z8dvxxneBuw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH v1 34/38] coco: guest: arm64: Validate mmio range found in the interface report
Date: Mon, 28 Jul 2025 19:22:11 +0530
Message-ID: <20250728135216.48084-35-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728135216.48084-1-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This starts the sequence to transition the realm device to the TDISP RUN
state by writing 1 to 'tsm/accept'.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi_cmds.h         |  18 +++
 arch/arm64/include/asm/rsi_smc.h          |   4 +
 drivers/virt/coco/arm-cca-guest/arm-cca.c |   3 +
 drivers/virt/coco/arm-cca-guest/rsi-da.c  | 132 ++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.h  |  25 ++++
 5 files changed, 182 insertions(+)

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index 18fc4e1ce577..1cc00d404e53 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -228,4 +228,22 @@ static inline unsigned long rsi_host_call(phys_addr_t addr)
 	return res.a0;
 }
 
+static inline unsigned long
+rsi_rdev_validate_mapping(unsigned long vdev_id, unsigned long inst_id,
+			  phys_addr_t start_ipa, phys_addr_t end_ipa,
+			  phys_addr_t io_pa, phys_addr_t *next_ipa, unsigned long flags)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_RDEV_VALIDATE_MAPPING, vdev_id,
+			     inst_id, start_ipa, end_ipa, io_pa, flags, &res);
+	*next_ipa = res.a1;
+
+	if (res.a2 != RSI_ACCEPT)
+		return -EPERM;
+
+	if (res.a0 != RSI_SUCCESS)
+		return -EINVAL;
+	return 0;
+}
 #endif /* __ASM_RSI_CMDS_H */
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index 1d762fe3777b..a28b41cf01ca 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -204,4 +204,8 @@ struct rsi_host_call {
 
 #define SMC_RSI_RDEV_LOCK			SMC_RSI_FID(0x1a9)
 
+#define RSI_DEV_MEM_COHERENT		BIT(0)
+#define RSI_DEV_MEM_LIMITED_ORDER	BIT(1)
+#define SMC_RSI_RDEV_VALIDATE_MAPPING		SMC_RSI_FID(0x1ac)
+
 #endif /* __ASM_RSI_SMC_H_ */
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
index de70fba09e92..c1cefb983ac7 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -247,6 +247,9 @@ static void cca_tsm_unlock(struct pci_dev *pdev)
 	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
 		PCI_DEVID(pdev->bus->number, pdev->devfn);
 
+	/* invalidate dev mapping based on interface report */
+	rsi_update_interface_report(pdev, false);
+
 	ret = rhi_da_vdev_set_tdi_state(vdev_id, RHI_DA_TDI_CONFIG_UNLOCKED);
 	if (ret) {
 		pci_err(pdev, "failed to TSM unbind the device (%ld)\n", ret);
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
index 47b379318e7c..936f844880de 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -215,3 +215,135 @@ int rsi_device_lock(struct pci_dev *pdev)
 
 	return ret;
 }
+
+static inline unsigned long
+rsi_validate_dev_mapping(unsigned long vdev_id, unsigned long inst_id,
+			 phys_addr_t start_ipa, phys_addr_t end_ipa,
+			 phys_addr_t io_pa, unsigned long flags)
+{
+	unsigned long ret;
+	phys_addr_t next_ipa;
+
+	while (start_ipa < end_ipa) {
+		ret = rsi_rdev_validate_mapping(vdev_id, inst_id,
+						start_ipa, end_ipa,
+						io_pa, &next_ipa, flags);
+		if (ret || next_ipa < start_ipa || next_ipa > end_ipa)
+			return -EINVAL;
+		io_pa += next_ipa - start_ipa;
+		start_ipa = next_ipa;
+	}
+	return 0;
+}
+
+static int rsi_invalidate_dev_mapping(phys_addr_t start_ipa, phys_addr_t end_ipa)
+{
+	return rsi_set_memory_range(start_ipa, end_ipa, RSI_RIPAS_EMPTY,
+				    RSI_CHANGE_DESTROYED);
+}
+
+static int get_msix_bar(struct pci_dev *pdev, int cap)
+{
+	int bar;
+	u32 table_offset;
+	unsigned long flags;
+
+	pci_read_config_dword(pdev, pdev->msix_cap + cap, &table_offset);
+	bar = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
+	flags = pci_resource_flags(pdev, bar);
+	if (!flags || (flags & IORESOURCE_UNSET))
+		return -1;
+
+	return bar;
+}
+
+int rsi_update_interface_report(struct pci_dev *pdev, bool validate)
+{
+	int ret;
+	struct resource *r;
+	int msix_tbl_bar, msix_pba_bar;
+	unsigned int range_id;
+	unsigned long mmio_start_phys;
+	unsigned long mmio_flags = 0; /* non coherent, not limited order */
+	struct pci_tdisp_mmio_range *mmio_range;
+	struct pci_tdisp_device_interface_report *interface_report;
+	struct cca_guest_dsc *dsm = to_cca_guest_dsc(pdev);
+	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
+		PCI_DEVID(pdev->bus->number, pdev->devfn);
+
+
+	interface_report = (struct pci_tdisp_device_interface_report *)dsm->interface_report;
+	mmio_range = (struct pci_tdisp_mmio_range *)(interface_report + 1);
+
+
+	msix_tbl_bar = get_msix_bar(pdev, PCI_MSIX_TABLE);
+	msix_pba_bar = get_msix_bar(pdev, PCI_MSIX_PBA);
+
+	for (int i = 0; i < interface_report->mmio_range_count; i++, mmio_range++) {
+
+		/*FIXME!! units in 4K size*/
+		range_id = FIELD_GET(TSM_INTF_REPORT_MMIO_RANGE_ID, mmio_range->range_attributes);
+
+		/* no secure interrupts */
+		if (msix_tbl_bar != -1 && range_id == msix_tbl_bar) {
+			pr_info("Skipping misx table\n");
+			continue;
+		}
+
+		if (msix_pba_bar != -1 && range_id == msix_pba_bar) {
+			pr_info("Skipping misx pba\n");
+			continue;
+		}
+
+		r = pci_resource_n(pdev, range_id);
+
+		if (r->end == r->start ||
+		    ((r->end - r->start + 1) & ~PAGE_MASK) || !mmio_range->num_pages) {
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
+		mmio_start_phys = mmio_range->first_page;
+		if (validate)
+			ret = rsi_validate_dev_mapping(vdev_id, dsm->instance_id,
+						       r->start, r->end + 1,
+						       mmio_start_phys << 12, mmio_flags);
+		else
+			ret = rsi_invalidate_dev_mapping(r->start, r->end + 1);
+		if (ret) {
+			pci_err(pdev, "failed to set protection attributes for the address range\n");
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+int rsi_device_start(struct pci_dev *pdev)
+{
+	int ret;
+
+	ret = rsi_update_interface_report(pdev, true);
+	if (ret) {
+		pci_err(pdev, "failed validate the interface report\n");
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
index bd565785ff4b..0d6e1c0ada4a 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -11,6 +11,28 @@
 #include <asm/rsi_smc.h>
 #include <asm/rhi.h>
 
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
 	struct pci_tsm_pf0 pci;
 	unsigned long instance_id;
@@ -29,5 +51,8 @@ static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
 	return container_of(tsm, struct cca_guest_dsc, pci.tsm);
 }
 
+int rsi_update_interface_report(struct pci_dev *pdev, bool validate);
 int rsi_device_lock(struct pci_dev *pdev);
+int rsi_device_start(struct pci_dev *pdev);
+
 #endif
-- 
2.43.0


