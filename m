Return-Path: <linux-pci+bounces-33065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E68B13C4A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C1E7A17C6
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1387280312;
	Mon, 28 Jul 2025 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGgI2aej"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862442741C6;
	Mon, 28 Jul 2025 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710953; cv=none; b=qbKLG2clpWm0dx9xfzWTgY8l3sjyWdN7IvIBO+qhp3H+e4Zv81q7voDgsm5NJjqy50eyUztjOq1F1Ca/YQAtIcZ1C45ej0SpaDG1lKSf7xt7WrmUiC1ev2v+6PGHmQDOKyu8gQFEdaPmUA4oFueaG76o3ieu/N3TN3myKmjPRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710953; c=relaxed/simple;
	bh=b2qi+JW50MnmkaO8ACOeTYJhbGQg2MNXTFbDlnbHVbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MW+8PkX5fsrtTddXhdcWv6LX4CewMfhEXGq5wx6ySHeF4oTBxakwZYeqNEEG5EVNUyMojKCCUaSMPa2coOT+pZRs0pNAZdPXpd89SGfV3CtgiO++Hv/zKvTRz4Y80ti6MiDqGKqB7HsX9d7NjOMbEnniPH/bSPL1jDc5qYau5j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGgI2aej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37024C4CEE7;
	Mon, 28 Jul 2025 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710953;
	bh=b2qi+JW50MnmkaO8ACOeTYJhbGQg2MNXTFbDlnbHVbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SGgI2aejizXQyYZ7XwB7uSgxedVfLzm0eIpVxqMS/xgrbDf9v8k11rufycOcX29zL
	 pI22oKsSpHJWqP/+G1WmEm+i56BLd1pJU1gFNoIHQXCQI57XwyXt1L5p+gpTHvy/5T
	 vRLU26PeIqCTxxDdOBzoar6N4T1PzRBa8yXo/qA41ld3YDIH4gtSkocTAx3KxYUuuB
	 scs4vfYW4lyHpdgD/zGOC/eFbyHpdJGqCA12EzESvIDtTKGNR/gBRIh6zXZ4McEyGO
	 WJDC3VpWfT0w+wAybbAuX/emezjXtMd9C8zOngia6CWyHcXbBlo9nKC9CsVsnaKar5
	 d2UlBZ+a5wv8w==
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
Subject: [RFC PATCH v1 33/38] KVM: arm64: CCA: handle dev mem map/unmap
Date: Mon, 28 Jul 2025 19:22:10 +0530
Message-ID: <20250728135216.48084-34-aneesh.kumar@kernel.org>
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

Handle VM exit on DEV_MEM_MAP

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_cmds.h |  40 +++++++
 arch/arm64/include/asm/rmi_smc.h  |   5 +
 arch/arm64/kvm/rme-exit.c         |  39 +++++-
 arch/arm64/kvm/rme.c              | 190 ++++++++++++++++++++++++++++--
 drivers/vfio/pci/vfio_pci_core.c  |   1 +
 5 files changed, 262 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
index fcf6b319e953..900e35dae740 100644
--- a/arch/arm64/include/asm/rmi_cmds.h
+++ b/arch/arm64/include/asm/rmi_cmds.h
@@ -638,4 +638,44 @@ static inline unsigned long rmi_vdev_complete(unsigned long rec_phys, unsigned l
 	return res.a0;
 }
 
+static inline int rmi_rtt_dev_mem_validate(unsigned long rd, unsigned long rec,
+					   unsigned long base, unsigned long top,
+					   unsigned long *out_top)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_RTT_DEV_MEM_VALIDATE, rd, rec, base, top, &res);
+
+	if (out_top)
+		*out_top = res.a1;
+
+	return res.a0;
+}
+
+static inline int rmi_dev_mem_map(unsigned long rd, unsigned long ipa,
+				  unsigned long level, unsigned long pa)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_DEV_MEM_MAP, rd, ipa, level, pa, &res);
+
+	return res.a0;
+}
+
+static inline int rmi_dev_mem_unmap(unsigned long rd, unsigned long ipa,
+				    unsigned long level, unsigned long *out_pa,
+				    unsigned long *out_ipa)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_DEV_MEM_UNMAP, rd, ipa, level, &res);
+
+	if (out_pa)
+		*out_pa = res.a1;
+	if (out_ipa)
+		*out_ipa = res.a2;
+
+	return res.a0;
+}
+
 #endif /* __ASM_RMI_CMDS_H */
diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index 7073eccaec5f..ab169b375198 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -39,6 +39,7 @@
 
 #define SMC_RMI_RTT_READ_ENTRY		SMC_RMI_CALL(0x0161)
 #define SMC_RMI_RTT_UNMAP_UNPROTECTED	SMC_RMI_CALL(0x0162)
+#define SMC_RMI_RTT_DEV_MEM_VALIDATE	SMC_RMI_CALL(0x0163)
 
 #define SMC_RMI_PSCI_COMPLETE		SMC_RMI_CALL(0x0164)
 #define SMC_RMI_FEATURES		SMC_RMI_CALL(0x0165)
@@ -47,6 +48,9 @@
 #define SMC_RMI_RTT_INIT_RIPAS		SMC_RMI_CALL(0x0168)
 #define SMC_RMI_RTT_SET_RIPAS		SMC_RMI_CALL(0x0169)
 
+#define SMC_RMI_DEV_MEM_MAP		SMC_RMI_CALL(0x0172)
+#define SMC_RMI_DEV_MEM_UNMAP		SMC_RMI_CALL(0x0173)
+
 #define SMC_RMI_PDEV_COMMUNICATE        SMC_RMI_CALL(0x0175)
 #define SMC_RMI_PDEV_CREATE             SMC_RMI_CALL(0x0176)
 #define SMC_RMI_PDEV_DESTROY		SMC_RMI_CALL(0x0177)
@@ -84,6 +88,7 @@ enum rmi_ripas {
 	RMI_EMPTY = 0,
 	RMI_RAM = 1,
 	RMI_DESTROYED = 2,
+	RMI_DEV = 3,
 };
 
 #define RMI_NO_MEASURE_CONTENT	0
diff --git a/arch/arm64/kvm/rme-exit.c b/arch/arm64/kvm/rme-exit.c
index 25948207fc5b..77829491805b 100644
--- a/arch/arm64/kvm/rme-exit.c
+++ b/arch/arm64/kvm/rme-exit.c
@@ -170,17 +170,44 @@ EXPORT_SYMBOL_GPL(realm_exit_dev_mem_map_handler);
 static int rec_exit_dev_mem_map(struct kvm_vcpu *vcpu)
 {
 	int ret;
+	struct kvm *kvm = vcpu->kvm;
+	struct realm *realm = &kvm->arch.realm;
 	struct realm_rec *rec = &vcpu->arch.rec;
+	unsigned long base = rec->run->exit.dev_mem_base;
+	unsigned long top = rec->run->exit.dev_mem_top;
+
+	if (!kvm_realm_is_private_address(realm, base) ||
+	    !kvm_realm_is_private_address(realm, top - 1)) {
+		vcpu_err(vcpu, "Invalid DEV_MEM_VALIDATE for %#lx - %#lx\n", base, top);
+		return -EINVAL;
+	}
 
+	/* See if coco driver want to look at the dev mem_map request */
 	if (realm_exit_dev_mem_map_handler) {
 		ret = (*realm_exit_dev_mem_map_handler)(rec);
-	} else {
-		kvm_pr_unimpl("Unsupported exit reason: %u\n",
-			      rec->run->exit.exit_reason);
-		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		ret = 0;
+		if (ret)
+			return ret;
 	}
-	return ret;
+
+#if 0
+	/* we don't need a memory fault exit for device mapping.
+	 * 1. On enter to rec, we map the device memory using dev_mem_map
+	   2. There is no fallocate, and we are not tracking this via memory attributes.
+	   If we need a fault exit, we need to differentiate it in VMM so that we don't
+	   map the private memory via tsm map ioctl.
+	 */
+	/*
+	 * Exit to VMM so that VMM can deny the validation, the actual
+	 * validation response is done on next entry
+	 */
+	kvm_prepare_memory_fault_exit(vcpu, base, top - base, false, false,
+				      true);
+
+	/* exit to hypervisor */
+	return -EFAULT;
+#else
+	return 1;
+#endif
 }
 
 static void update_arch_timer_irq_lines(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/rme.c b/arch/arm64/kvm/rme.c
index d1c147aba2ed..11c8d47e3e9b 100644
--- a/arch/arm64/kvm/rme.c
+++ b/arch/arm64/kvm/rme.c
@@ -445,18 +445,27 @@ void kvm_realm_destroy_rtts(struct kvm *kvm, u32 ia_bits)
 	WARN_ON(realm_tear_down_rtt_range(realm, 0, (1UL << ia_bits)));
 }
 
-static int realm_destroy_private_granule(struct realm *realm,
-					 unsigned long ipa,
+static int realm_destroy_private_granule(struct realm *realm, unsigned long ipa,
 					 unsigned long *next_addr,
-					 phys_addr_t *out_rtt)
+					 phys_addr_t *out_rtt,
+					 int *ripas)
 {
 	unsigned long rd = virt_to_phys(realm->rd);
 	unsigned long rtt_addr;
+	struct rtt_entry rtt_entry;
 	phys_addr_t rtt;
 	int ret;
 
+	ret = rmi_rtt_read_entry(rd, ipa, RMM_RTT_MAX_LEVEL, &rtt_entry);
+	if (ret != RMI_SUCCESS)
+		return -ENXIO;
+
 retry:
-	ret = rmi_data_destroy(rd, ipa, &rtt_addr, next_addr);
+	if (rtt_entry.ripas == RMI_DEV)
+		ret = rmi_dev_mem_unmap(rd, ipa, RMM_RTT_MAX_LEVEL, &rtt_addr, next_addr);
+	else
+		ret = rmi_data_destroy(rd, ipa, &rtt_addr, next_addr);
+
 	if (RMI_RETURN_STATUS(ret) == RMI_ERROR_RTT) {
 		if (*next_addr > ipa)
 			return 0; /* UNASSIGNED */
@@ -484,6 +493,7 @@ static int realm_destroy_private_granule(struct realm *realm,
 		return -ENXIO;
 
 	*out_rtt = rtt_addr;
+	*ripas = rtt_entry.ripas;
 
 	return 0;
 }
@@ -495,16 +505,16 @@ static int realm_unmap_private_page(struct realm *realm,
 	unsigned long end = ALIGN(ipa + 1, PAGE_SIZE);
 	unsigned long addr;
 	phys_addr_t out_rtt = PHYS_ADDR_MAX;
-	int ret;
+	int ret, ripas;
 
 	for (addr = ipa; addr < end; addr = *next_addr) {
 		ret = realm_destroy_private_granule(realm, addr, next_addr,
-						    &out_rtt);
+						    &out_rtt, &ripas);
 		if (ret)
 			return ret;
 	}
 
-	if (out_rtt != PHYS_ADDR_MAX) {
+	if (out_rtt != PHYS_ADDR_MAX && ripas != RMI_DEV) {
 		out_rtt = ALIGN_DOWN(out_rtt, PAGE_SIZE);
 		free_page((unsigned long)phys_to_virt(out_rtt));
 	}
@@ -1222,8 +1232,17 @@ static int realm_set_ipa_state(struct kvm_vcpu *vcpu,
 	struct kvm *kvm = vcpu->kvm;
 	int ret = ripas_change(kvm, vcpu, start, end, RIPAS_SET, top_ipa);
 
+#if 0
+	/*
+	 * We don't need to do this because a ripas change will take a memory
+	 * fault exit That results in stage2 invalidate which will take care of
+	 * unmap of both private and shared ipa.. IF we need to do this, we
+	 * should do it before ripas change, we look at ripas when unmapping the
+	 * private range.
+	 */
 	if (ripas == RMI_EMPTY && *top_ipa != start)
 		realm_unmap_private_range(kvm, start, *top_ipa, false);
+#endif
 
 	return ret;
 }
@@ -1492,6 +1511,159 @@ static void kvm_complete_ripas_change(struct kvm_vcpu *vcpu)
 	rec->run->exit.ripas_base = base;
 }
 
+/*
+ * Even though we can map larger block, since we need to delegate each granule.
+ * We map granule size and fold
+ */
+static int realm_dev_mem_map(struct kvm_vcpu *vcpu, unsigned long start_ipa,
+			     unsigned long end_ipa, phys_addr_t phys)
+{
+	int ret = 0;
+	unsigned long ipa;
+	struct kvm *kvm = vcpu->kvm;
+	struct realm *realm = &kvm->arch.realm;
+	phys_addr_t rd = virt_to_phys(realm->rd);
+	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
+
+	for (ipa = start_ipa ; ipa < end_ipa; ipa += PAGE_SIZE) {
+
+		if (rmi_granule_delegate(phys))
+			return -EINVAL;
+
+		ret = rmi_dev_mem_map(rd, ipa, RMM_RTT_MAX_LEVEL, phys);
+
+		if (RMI_RETURN_STATUS(ret) == RMI_ERROR_RTT) {
+			/* Create missing RTTs and retry */
+			int level = RMI_RETURN_INDEX(ret);
+
+			ret = realm_create_rtt_levels(realm, ipa, level,
+						      RMM_RTT_MAX_LEVEL,
+						      memcache);
+			WARN_ON(ret);
+			if (ret)
+				goto err_undelegate;
+
+			ret = rmi_dev_mem_map(rd, ipa, RMM_RTT_MAX_LEVEL, phys);
+		}
+		WARN_ON(ret);
+
+		if (ret)
+			goto err_undelegate;
+
+		phys += PAGE_SIZE;
+	}
+
+	/* : ipa = ALIGN(start_ipa, RMM_L2_BLOCK_SIZE) to be safer ?  */
+	for (ipa = start_ipa; ((ipa + RMM_L2_BLOCK_SIZE) < end_ipa); ipa += RMM_L2_BLOCK_SIZE)
+		fold_rtt(realm, ipa, RMM_RTT_BLOCK_LEVEL);
+
+	return 0;
+
+err_undelegate:
+	WARN_ON(rmi_granule_undelegate(phys));
+
+	while (ipa > start_ipa) {
+		unsigned long out_pa;
+
+		phys -= PAGE_SIZE;
+		ipa -= PAGE_SIZE;
+
+		WARN_ON(rmi_dev_mem_unmap(rd, ipa, RMM_RTT_MAX_LEVEL, &out_pa, NULL));
+
+		WARN_ON(phys != out_pa);
+		WARN_ON(rmi_granule_undelegate(out_pa));
+	}
+	return -ENXIO;
+}
+
+static int realm_dev_mem_validate(struct kvm_vcpu *vcpu,
+				  unsigned long start, unsigned long end,
+				  unsigned long *top_ipa)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct realm *realm = &kvm->arch.realm;
+	struct realm_rec *rec = &vcpu->arch.rec;
+	phys_addr_t rd_phys = virt_to_phys(realm->rd);
+	phys_addr_t rec_phys = virt_to_phys(rec->rec_page);
+	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
+	unsigned long ipa = start;
+	int ret = 0;
+
+	while (ipa < end) {
+		unsigned long next;
+
+		ret = rmi_rtt_dev_mem_validate(rd_phys, rec_phys, ipa, end, &next);
+
+		if (RMI_RETURN_STATUS(ret) == RMI_ERROR_RTT) {
+			/*
+			 * FIXME!! We can't find the RTT error here, because
+			 * things are already setup by dev_mem_map before
+			 */
+			int walk_level = RMI_RETURN_INDEX(ret);
+			int level = find_map_level(realm, ipa, end);
+
+			/*
+			 * If the RMM walk ended early then more tables are
+			 * needed to reach the required depth to set the RIPAS.
+			 */
+			if (walk_level < level) {
+				ret = realm_create_rtt_levels(realm, ipa,
+							      walk_level,
+							      level,
+							      memcache);
+				/* Retry with RTTs created */
+				if (!ret)
+					continue;
+			} else {
+				ret = -EINVAL;
+			}
+
+			break;
+		} else if (RMI_RETURN_STATUS(ret) != RMI_SUCCESS) {
+			WARN(1, "Unexpected error in %s: %#x\n", __func__,
+			     ret);
+			ret = -EINVAL;
+			break;
+		}
+		ipa = next;
+	}
+
+	*top_ipa = ipa;
+
+	return ret;
+}
+
+static void kvm_complete_dev_mem_change(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct realm_rec *rec = &vcpu->arch.rec;
+	unsigned long base = rec->run->exit.dev_mem_base;
+	unsigned long top = rec->run->exit.dev_mem_top;
+	unsigned long pa = rec->run->exit.dev_mem_pa;
+	unsigned long top_ipa;
+	int ret;
+
+	do {
+		kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_page_cache,
+					   kvm_mmu_cache_min_pages(vcpu->arch.hw_mmu));
+		write_lock(&kvm->mmu_lock);
+		/*
+		 * FIXME!! we need validate these values. Also PA need to be tied to the life cycle
+		 * of vfio device/file descriptor.
+		 */
+		ret = realm_dev_mem_map(vcpu, base, top, pa);
+		if (!ret)
+			ret = realm_dev_mem_validate(vcpu, base, top, &top_ipa);
+		write_unlock(&kvm->mmu_lock);
+		if (ret)
+			break;
+
+		base = top_ipa;
+	} while (top_ipa < top);
+
+	WARN(ret, "Unable to satisfy DEV_MEM_CHANGE for %#lx - %#lx\n", base, top);
+}
+
 /*
  * kvm_rec_pre_enter - Complete operations before entering a REC
  *
@@ -1520,6 +1692,10 @@ int kvm_rec_pre_enter(struct kvm_vcpu *vcpu)
 	case RMI_EXIT_RIPAS_CHANGE:
 		kvm_complete_ripas_change(vcpu);
 		break;
+	case RMI_EXIT_DEV_MEM_MAP:
+		kvm_complete_dev_mem_change(vcpu);
+		break;
+
 	}
 
 	return 1;
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index afdb39c6aefd..264ee84d7ecd 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1718,6 +1718,7 @@ static const struct vm_operations_struct vfio_pci_mmap_ops = {
 #endif
 };
 
+/* FIXME!! don't allow mmap once the device is TDISP locked and we did dev mem_map. */
 int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma)
 {
 	struct vfio_pci_core_device *vdev =
-- 
2.43.0


