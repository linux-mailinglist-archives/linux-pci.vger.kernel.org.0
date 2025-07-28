Return-Path: <linux-pci+bounces-33042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D6BB13C3B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 15:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD76F3BF650
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0797026AAB5;
	Mon, 28 Jul 2025 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kARqcFtN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AA26738C;
	Mon, 28 Jul 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710817; cv=none; b=fBwno8xtNSSpnf20mkR5lK9MdcKGgDJFwchFeVJ5MB10nTkk3u+RTx7yNH5Pl8+1uJl+hPeLQN4EjVjaPGSARV0iPhyNxrKLz1xPG7wHoHURX+Fzm8YvC4lRTJFlOZKSBlTJ8hJOBoNSLry3k9RuWE5wPCKvCRzHKHudUaYWIhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710817; c=relaxed/simple;
	bh=Thi9yU+6tSWyVmTIGO1nyLQl2Xw4SWgbWppOY/SS248=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGnrGM0u1KZWYXVAYJLO4yS3qpTl3uMC2kNtrelz3nUE+GiApAXNhGQTq7U6PWzrT2YawnTnIcckmWpm52Q2FkJBHlQrzGuvwnSEct8vF5Es4FJq7vBMa2OtsqiPObatMT0zN8WNbQIFHapneF5BetrGQ2QRrM5KCp+d9I0/aCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kARqcFtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BA0C4CEEF;
	Mon, 28 Jul 2025 13:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710816;
	bh=Thi9yU+6tSWyVmTIGO1nyLQl2Xw4SWgbWppOY/SS248=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kARqcFtNVkwBM+NMuWiZc8Qlv6o9fCqsdo85x6zkUq0i16+h2kbQz2FVS46G7XemG
	 8TIjRh28fORV2T/Vtj0GgmdXhi313CFD3Lg57YmjEE0DCPCF5hwHmQs2+kWxtuTaI8
	 SvIl59simJ+4BUPTMEzygptqH8/p7LPKF10D74NMdS+VmA/esFGeNHQqr76d/x3jeL
	 l7Hx7QvQu5Ywgnh8AtsUPWJRKKbS8+uiQWyi6RTUi1hZcsw3ybRfIca+NltzBUNxjM
	 ZIW08+9ESKKEXm+1NYyNHLgK8lig2woZH9GW9azt2giiyW2CnEdHLvcNASx81+sgxx
	 qe/oEzp5izalw==
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
Subject: [RFC PATCH v1 10/38] iommufd/vdevice: Add TSM map ioctl
Date: Mon, 28 Jul 2025 19:21:47 +0530
Message-ID: <20250728135216.48084-11-aneesh.kumar@kernel.org>
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

With passthrough devices, we need to make sure private memory is
allocated and assigned to the secure guest before we can issue the DMA.
For ARM RMM, we only need to map and the secure SMMU management is
internal to RMM. For shared IPA, vfio/iommufd DMA MAP/UNMAP interface
does the equivalent

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/kvm/mmu.c                    | 45 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  4 +++
 drivers/iommu/iommufd/viommu.c          | 43 +++++++++++++++++++++++
 include/linux/kvm_host.h                |  1 +
 include/uapi/linux/iommufd.h            | 10 ++++++
 6 files changed, 104 insertions(+)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c866891fd8f9..8788d24095d6 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1530,6 +1530,51 @@ static int realm_map_ipa(struct kvm *kvm, phys_addr_t ipa,
 	return realm_map_protected(realm, ipa, pfn, map_size, memcache);
 }
 
+int kvm_map_private_memory(struct kvm *kvm, phys_addr_t start_gpa,
+			   phys_addr_t end_gpa)
+{
+	struct kvm_mmu_memory_cache cache = { .gfp_zero = __GFP_ZERO };
+	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
+	struct kvm_memory_slot *memslot;
+	phys_addr_t addr;
+	struct page *page;
+	kvm_pfn_t pfn;
+	int ret = 0, idx;
+	gfn_t gfn;
+
+	idx = srcu_read_lock(&kvm->srcu);
+	for (addr = start_gpa; addr < end_gpa; addr += PAGE_SIZE) {
+
+		ret = kvm_mmu_topup_memory_cache(&cache,
+						 kvm_mmu_cache_min_pages(mmu));
+		if (ret)
+			break;
+
+		gfn = addr >> PAGE_SHIFT;
+
+		memslot = gfn_to_memslot(kvm, gfn);
+		if (!kvm_slot_can_be_private(memslot)) {
+			ret = -EINVAL;
+			break;
+		}
+		/* should we check if kvm_mem_is_private()? */
+		ret = kvm_gmem_get_pfn(kvm, memslot, gfn, &pfn, &page, NULL);
+		if (ret)
+			break;
+
+		/* should we hold kvm_fault_lock()? */
+		ret = realm_map_ipa(kvm, addr, pfn, PAGE_SIZE, KVM_PGTABLE_PROT_W,
+				    &cache);
+		if (ret) {
+			put_page(page);
+			break;
+		}
+	}
+	kvm_mmu_free_memory_cache(&cache);
+	srcu_read_unlock(&kvm->srcu, idx);
+	return ret;
+}
+
 static int private_memslot_fault(struct kvm_vcpu *vcpu,
 				 phys_addr_t fault_ipa,
 				 struct kvm_memory_slot *memslot)
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0c0d96135432..34f3ae0e0cd1 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -698,6 +698,7 @@ void iommufd_vdevice_abort(struct iommufd_object *obj);
 int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_hw_queue_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd);
+int iommufd_vdevice_tsm_map_ioctl(struct iommufd_ucmd *ucmd);
 int iommufd_vdevice_tsm_guest_request_ioctl(struct iommufd_ucmd *ucmd);
 
 static inline struct iommufd_vdevice *
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 65e60da9caef..388d11334994 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -411,6 +411,7 @@ union ucmd_buffer {
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
 	struct iommu_vdevice_tsm_op tsm_op;
+	struct iommu_vdevice_tsm_map tsm_map;
 	struct iommu_vdevice_tsm_guest_request gr;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
@@ -475,6 +476,9 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_viommu_alloc, out_viommu_id),
 	IOCTL_OP(IOMMU_VDEVICE_TSM_OP, iommufd_vdevice_tsm_op_ioctl,
 		 struct iommu_vdevice_tsm_op, vdevice_id),
+	IOCTL_OP(IOMMU_VDEVICE_TSM_MAP, iommufd_vdevice_tsm_map_ioctl,
+		 struct iommu_vdevice_tsm_map, vdevice_id),
+
 	IOCTL_OP(IOMMU_VDEVICE_TSM_GUEST_REQUEST, iommufd_vdevice_tsm_guest_request_ioctl,
 		 struct iommu_vdevice_tsm_guest_request, resp_uptr),
 #ifdef CONFIG_IOMMUFD_TEST
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 9f4d4d69b82b..1ffc996caa3e 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -516,6 +516,44 @@ int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+int __weak kvm_map_private_memory(struct kvm *kvm, phys_addr_t start_gpa,
+				  phys_addr_t end_gpa)
+{
+	return -EINVAL;
+}
+
+int iommufd_vdevice_tsm_map_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vdevice_tsm_map *cmd = ucmd->cmd;
+	struct iommufd_vdevice *vdev;
+	struct kvm *kvm;
+	int rc = -ENODEV;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
+					       IOMMUFD_OBJ_VDEVICE),
+			    struct iommufd_vdevice, obj);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
+
+	kvm = vdev->viommu->kvm_filp->private_data;
+	if (kvm) {
+		rc = kvm_map_private_memory(kvm, cmd->start_gpa, cmd->end_gpa);
+		if (rc)
+			goto out_put_vdev;
+
+	} else {
+		goto out_put_vdev;
+	}
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_put_vdev:
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+	return rc;
+}
+
 int iommufd_vdevice_tsm_guest_request_ioctl(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_vdevice_tsm_guest_request *cmd = ucmd->cmd;
@@ -555,6 +593,11 @@ int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
 	return -ENODEV;
 }
 
+int iommufd_vdevice_tsm_map_ioctl(struct iommufd_ucmd *ucmd)
+{
+	return -ENODEV;
+}
+
 int iommufd_vdevice_tsm_guest_request_ioctl(struct iommufd_ucmd *ucmd)
 {
 	return -ENODEV;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3bde4fb5c6aa..bfdfb4f32d28 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2602,4 +2602,5 @@ static inline int kvm_enable_virtualization(void) { return 0; }
 static inline void kvm_disable_virtualization(void) { }
 #endif
 
+int kvm_map_private_memory(struct kvm *kvm, phys_addr_t start_gpa, phys_addr_t end_gpa);
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 56542cfcfa38..75056d1f141d 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -59,6 +59,7 @@ enum {
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 	IOMMUFD_CMD_VDEVICE_TSM_OP = 0x95,
 	IOMMUFD_CMD_VDEVICE_TSM_GUEST_REQUEST = 0x96,
+	IOMMUFD_CMD_VDEVICE_TSM_MAP = 0x97,
 };
 
 /**
@@ -1146,6 +1147,15 @@ struct iommu_vdevice_tsm_op {
 #define IOMMU_VDEICE_TSM_BIND		0x1
 #define IOMMU_VDEICE_TSM_UNBIND		0x2
 
+struct iommu_vdevice_tsm_map {
+	__u32 size;
+	__u32 flags;
+	__u64 start_gpa;
+	__u64 end_gpa;
+	__u32 vdevice_id;
+};
+#define IOMMU_VDEVICE_TSM_MAP	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_MAP)
+
 /**
  * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
  * @flags: Combination of enum iommu_veventq_flag
-- 
2.43.0


