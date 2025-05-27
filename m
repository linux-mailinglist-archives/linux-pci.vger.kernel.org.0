Return-Path: <linux-pci+bounces-28446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D90FAC4DD9
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 13:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB404189FAA6
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBE025C80B;
	Tue, 27 May 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3cEJKBO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E41E5710;
	Tue, 27 May 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748346489; cv=none; b=DSTPNGAJB8madcqBeMwvi4VXUoV6FZnjgBRam/BZiIAs3sbvt+HUOgXZK4RtPabFYuDBTNFCL9ETZxMk+zK7DSciM/kgQOSJ4ZTEZmAg8+tnfV+sXK3VW7YyOqJOtmEduRTdNlKVeJMHGgXNR/gie2ya2yuXBEiVSTzdYgBNebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748346489; c=relaxed/simple;
	bh=v9lXOBARzVpo2IQ1xAOHG8PQvci/HwKxjxbOKnsGajk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WLUUyAf3w7C6xCIpx6De3pAMx0KiZOw8hfcMwUiCb91P6lpIuTMcyYvQ5Fte5qYqIqs347j/UUaLaFRGoUXD047W/mZnMWGiF0GBUHDBfAlHOsNwhCRbpnJG+3XDnrfyxGDTKulhIn7il0md/AzY8h8VfRgfdPZ3CdQQ9Os1wg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3cEJKBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FD1C4CEE9;
	Tue, 27 May 2025 11:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748346489;
	bh=v9lXOBARzVpo2IQ1xAOHG8PQvci/HwKxjxbOKnsGajk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=N3cEJKBOT0yNrfXCsOPKYdbi2dt4iNHuNWgB667h4ODU4Hu9ioKQSES9vQ2uuGfd2
	 3HiwljsEDEN7R6SingE+P0YBVAKWVGC16Wso8vOtQUbYD8++6yXEzXhSHYERPwbynM
	 Fior1kNwiGgnXzkW8qOgE4UbQinkrUUEaep6N0wEix6pwlkIBDTh/wrpr7VdCceA4q
	 FrNBI+pDK/Bh8w8VByV1ftFT3C+JadzEqAvlUDIEOIV3rXupn79MTkZJtWHc1dWu57
	 vmTMmvQGiwkID9/4B9fwRxup9cVG6a7uzyDQCkejlgS/+iHB4txx98YKiZ0UTVji18
	 ZP5zFLhYRMk9Q==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
In-Reply-To: <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050> <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050> <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
Date: Tue, 27 May 2025 17:18:01 +0530
Message-ID: <yq5abjres2a6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

> On 27/5/25 01:44, Aneesh Kumar K.V wrote:
>> Alexey Kardashevskiy <aik@amd.com> writes:
>> 
>>> On 26/5/25 15:05, Aneesh Kumar K.V wrote:
>>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>>
>>>>> On Tue, May 20, 2025 at 12:47:05PM +0530, Aneesh Kumar K.V wrote:
>>>>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>>>>
>>>>>>> On Thu, May 15, 2025 at 10:47:31PM -0700, Dan Williams wrote:
>>>>>>>> From: Xu Yilun <yilun.xu@linux.intel.com>
>>>>>>>>
>>>>>>>> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
>>>>>>>>
>>>>>>>> pci_tsm_bind/unbind() are supposed to be called by kernel components
>>>>>>>> which manages the virtual device. The verb 'bind' means VMM does extra
>>>>>>>> configurations to make the assigned device ready to be validated by
>>>>>>>> CoCo VM as TDI (TEE Device Interface). Usually these configurations
>>>>>>>> include assigning device ownership and MMIO ownership to CoCo VM, and
>>>>>>>> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
>>>>>>>> TDISP message. The detailed operations are specific to platform TSM
>>>>>>>> firmware so need to be supported by vendor TSM drivers.
>>>>>>>>
>>>>>>>> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
>>>>>>>> to TSM firmware about further TDI operations after TDI is bound, e.g.
>>>>>>>> get device interface report, certifications & measurements. So this kAPI
>>>>>>>> is supposed to be called from KVM vmexit handler.
>>>>>>>
>>>>>>> To clarify, this commit message is staled. We are proposing existing to
>>>>>>> QEMU, then pass to TSM through IOMMUFD VDEVICE.
>>>>>>>
>>>>>>
>>>>>> Can you share the POC code/git repo implementing that? I am looking for
>>>>>> pci_tsm_bind()/pci_tsm_unbind() example usage.
>>>>>
>>>>> The usage of these kAPIs should be in IOMMUFD, that's what I'm doing for
>>>>> Stage 2 patchset. I need to rebase this series, adopt suggestions from
>>>>> Jason, and make TDX Connect work to verify, so need more time...
>>>>>
>>>>
>>>> Since the bind/unbind operations are PCI-specific callbacks, and iommufd
>>>
>>> Not really, it is PCI-specific in TSM (for DOE) but since IOMMUFD is not doing any of that, it can work with struct device (not pci_dev). Thanks,
>>>
>> 
>> Ok, something like this? and iommufd will call tsm_bind()?
>
> yeah, I guess, there is a couple of places like this
>
> git grep pci_dev drivers/iommu/iommufd/
>
> drivers/iommu/iommufd/device.c:                 struct pci_dev *pdev = to_pci_dev(idev->dev);
> drivers/iommu/iommufd/eventq.c:         struct pci_dev *pdev = to_pci_dev(dev);
>
> Although I do not see any compelling reason to have pci_dev in the TSM API, struct device should just work and not spill any PCI details to IOMMUFD but whatever... Thanks,

Getting the kvm reference is tricky here. Also the locking while
updating vdevice->tsm_bound needs some solution. Here is what I am
improving. Are you also planning something similar?

 drivers/iommu/iommufd/device.c          |  4 +-
 drivers/iommu/iommufd/iommufd_private.h |  5 ++
 drivers/iommu/iommufd/main.c            |  5 ++
 drivers/iommu/iommufd/viommu.c          | 62 +++++++++++++++++++++++++
 drivers/vfio/iommufd.c                  |  2 +-
 include/linux/iommufd.h                 |  3 +-
 include/uapi/linux/iommufd.h            | 16 +++++++
 7 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2111bad72c72..79d669064044 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -165,7 +165,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
  * The caller must undo this with iommufd_device_unbind()
  */
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
-					   struct device *dev, u32 *id)
+					   struct device *dev, struct kvm *kvm, u32 *id)
 {
 	struct iommufd_device *idev;
 	struct iommufd_group *igroup;
@@ -221,6 +221,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	refcount_inc(&idev->obj.users);
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
+	idev->kvm = kvm;
 	mutex_init(&idev->iopf_lock);
 
 	/*
@@ -1009,6 +1010,7 @@ void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid)
 	if (!hwpt)
 		return;
 	iommufd_hw_pagetable_put(idev->ictx, hwpt);
+	idev->kvm = NULL;
 	refcount_dec(&idev->obj.users);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, "IOMMUFD");
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 80e8c76d25f2..dd1c87500a74 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -424,6 +424,7 @@ struct iommufd_device {
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
+	struct kvm *kvm;
 	bool enforce_cache_coherency;
 	/* protect iopf_enabled counter */
 	struct mutex iopf_lock;
@@ -606,13 +607,17 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
+int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd);
+int iommufd_vdevice_tsm_unbind_ioctl(struct iommufd_ucmd *ucmd);
 
 struct iommufd_vdevice {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_viommu *viommu;
 	struct device *dev;
+	struct kvm *kvm;
 	u64 id; /* per-vIOMMU virtual ID */
+	bool tsm_bound;
 };
 
 #ifdef CONFIG_IOMMUFD_TEST
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3df468f64e7d..9959436d0d42 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -320,6 +320,7 @@ union ucmd_buffer {
 	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_vdevice_id vdev_id;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -379,6 +380,10 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VDEVICE_TSM_BIND, iommufd_vdevice_tsm_bind_ioctl,
+		 struct iommu_vdevice_id, vdevice_id),
+	IOCTL_OP(IOMMU_VDEVICE_TSM_UNBIND, iommufd_vdevice_tsm_unbind_ioctl,
+		 struct iommu_vdevice_id, vdevice_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 01df2b985f02..9182353f7069 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
  */
 #include "iommufd_private.h"
+#include "linux/tsm.h"
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
 {
@@ -90,6 +91,9 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
 
+	if (vdev->tsm_bound)
+		tsm_unbind(vdev->dev);
+
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
@@ -134,6 +138,8 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	vdev->dev = idev->dev;
 	get_device(idev->dev);
 	vdev->viommu = viommu;
+	vdev->kvm = idev->kvm;
+	pr_info("Assigning kvm 0x%lx\n", vdev->kvm);
 	refcount_inc(&viommu->obj.users);
 
 	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
@@ -157,3 +163,59 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vdevice_id *cmd = ucmd->cmd;
+	struct iommufd_vdevice *vdev;
+	int rc = 0;
+
+	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
+					       IOMMUFD_OBJ_VDEVICE),
+			    struct iommufd_vdevice, obj);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
+
+	rc = tsm_bind(vdev->dev, vdev->kvm, vdev->id);
+	if (rc) {
+		rc = -ENODEV;
+		goto out_put_vdev;
+	}
+
+	/* locking? */
+	vdev->tsm_bound = true;
+	refcount_inc(&vdev->obj.users);
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_put_vdev:
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+	return rc;
+}
+
+int iommufd_vdevice_tsm_unbind_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vdevice_id *cmd = ucmd->cmd;
+	struct iommufd_vdevice *vdev;
+	int rc = 0;
+
+	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
+					       IOMMUFD_OBJ_VDEVICE),
+			    struct iommufd_vdevice, obj);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
+
+	rc = tsm_unbind(vdev->dev);
+	if (rc) {
+		rc = -ENODEV;
+		goto out_put_vdev;
+	}
+
+	refcount_dec(&vdev->obj.users);
+	/* locking ? */
+	vdev->tsm_bound = false;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_put_vdev:
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+	return rc;
+}
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index c8c3a2d53f86..3441d24538a8 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -115,7 +115,7 @@ int vfio_iommufd_physical_bind(struct vfio_device *vdev,
 {
 	struct iommufd_device *idev;
 
-	idev = iommufd_device_bind(ictx, vdev->dev, out_device_id);
+	idev = iommufd_device_bind(ictx, vdev->dev, vdev->kvm, out_device_id);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 	vdev->iommufd_device = idev;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 34b6e6ca4bfa..79a9bb0a7a00 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -51,8 +51,9 @@ struct iommufd_object {
 	unsigned int id;
 };
 
+struct kvm;
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
-					   struct device *dev, u32 *id);
+					   struct device *dev, struct kvm *kvm, u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
 
 int iommufd_device_attach(struct iommufd_device *idev, ioasid_t pasid,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index f29b6c44655e..abcdad90bfba 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -56,6 +56,8 @@ enum {
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
+	IOMMUFD_CMD_VDEVICE_TSM_BIND = 0x94,
+	IOMMUFD_CMD_VDEVICE_TSM_UNBIND = 0x95,
 };
 
 /**
@@ -1038,6 +1040,20 @@ enum iommu_veventq_flag {
 	IOMMU_VEVENTQ_FLAG_LOST_EVENTS = (1U << 0),
 };
 
+/**
+ * struct iommu_vdevice_tsm_unbind - ioctl(IOMMU_VDEVICE_TSM_UNBIND)
+ * @size: sizeof(struct iommu_vdevice_tsm_unbind)
+ * @vdevice_id:
+ *
+ */
+struct iommu_vdevice_id {
+	__u32 size;
+	__u32 vdevice_id;
+} __packed;
+#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_BIND)
+#define IOMMU_VDEVICE_TSM_UNBIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_UNBIND)
+
+
 /**
  * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
  * @flags: Combination of enum iommu_veventq_flag
-- 
2.43.0


