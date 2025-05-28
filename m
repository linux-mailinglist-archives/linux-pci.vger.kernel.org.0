Return-Path: <linux-pci+bounces-28506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E61AC6906
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 14:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F03816A961
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54102283C9D;
	Wed, 28 May 2025 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbMl+EY6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951A27AC5A;
	Wed, 28 May 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748434667; cv=none; b=Ulw98f2JC9DRRvZ/rjMyfk5f7wbqzMND4z6+t5LUwkf0B7BIxjosBVjiRQHHy1kbjtEdHhfkW1QFv06JNSFXVA9KPHFYzcevmiRTS/l2LrAc+5hKmsNgVVdLNbt55aWc07s91PDqZvFTMV/R8zv/cD2Kyqlfun2unNrCZc7UXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748434667; c=relaxed/simple;
	bh=GMaRMH4NGfPpVpEbiw0a4wZBSujGM31YX1cJrZ6PKMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eE7eOlxYFoK7WSePwBgR0/Bvgk2h27LHIrUIBsgkwFjQ27s9vP+l5aaiP5xunoSH2iik1qoz3/QeYQiIubVaI8Ywc7gVGKnVLWEPDUfuddaakUGgKiC6abKdwH/yoR8Cyjb6rx8L0U69IBTNU0bpfVJ/BnwagAVvTXPhu+QfuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbMl+EY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA81C4CEE7;
	Wed, 28 May 2025 12:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748434665;
	bh=GMaRMH4NGfPpVpEbiw0a4wZBSujGM31YX1cJrZ6PKMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HbMl+EY6LNFUt2Eiy50uto4fq82ADQyLj8d5e/hLwvB+LVtxJMjz0RLeFcid+w8BB
	 xOsu0GUVN/WbJ4p5Ec+ZO/3oTUsiwpdsGNx05+6nfkcBa84jFfeG6r65VOSzxn2gxT
	 VYi/s1zd3qpV2kPhr8La8WY6TfhYCdYvUK3/ErjRlttY1e6wcA97m5bzj+WB+Ykqo0
	 U7dXTPu7oHqGM812FqtnuqYUzroD2NsR1pvWPPXoUYGJyfCCUX5sG6stiLv+VOj1+L
	 86DsFNYOXCD/G1nvgkLbyN1UkCj3UCq5LIBi/XXv6T+UHfJwedMOahMJpq6Bb0in2G
	 OQFd5h1Zd06QQ==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
In-Reply-To: <20250527144516.GO61950@nvidia.com>
References: <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050>
 <yq5awmab4uq6.fsf@kernel.org> <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
 <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
 <yq5abjres2a6.fsf@kernel.org> <20250527130610.GN61950@nvidia.com>
 <yq5a8qmiruym.fsf@kernel.org> <20250527144516.GO61950@nvidia.com>
Date: Wed, 28 May 2025 17:47:19 +0530
Message-ID: <yq5a8qmh53qo.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Tue, May 27, 2025 at 07:56:09PM +0530, Aneesh Kumar K.V wrote:
>> Jason Gunthorpe <jgg@nvidia.com> writes:
>> 
>> > On Tue, May 27, 2025 at 05:18:01PM +0530, Aneesh Kumar K.V wrote:
>> >> > yeah, I guess, there is a couple of places like this
>> >> >
>> >> > git grep pci_dev drivers/iommu/iommufd/
>> >> >
>> >> > drivers/iommu/iommufd/device.c:                 struct pci_dev *pdev = to_pci_dev(idev->dev);
>> >> > drivers/iommu/iommufd/eventq.c:         struct pci_dev *pdev = to_pci_dev(dev);
>> >> >
>> >> > Although I do not see any compelling reason to have pci_dev in the TSM API, struct device should just work and not spill any PCI details to IOMMUFD but whatever... Thanks,
>> >> 
>> >> Getting the kvm reference is tricky here.
>> >
>> > The KVM will come from the viommu object, passed in by userspace that
>> > is the plan at least.. If you are not presenting a viommu to the guest
>> > then I imagine we would still have some kind of NOP viommu object..
>> 
>> I assume you are not suggesting using IOMMU_VIOMMU_ALLOC? That would
>> break the ABI, which we need to maintain.
>
> Yes I am, what ABI are you talking about? CC is all new.
>
>> Instead, my approach uses VFIO_DEVICE_BIND_IOMMUFD to associate the KVM
>> context. The vfio device file descriptor had already been linked to the
>> KVM instance via KVM_DEV_VFIO_FILE_ADD.
>> 
>> Through VFIO_DEVICE_BIND_IOMMUFD, we inherit the necessary KVM details
>> and pass them along to iommufd_device, and subsequently to
>> iommufd_vdevice, using IOMMU_VDEVICE_ALLOC.
>
> It is not OK, we want this in the viommu not the device for a bunch of
> other reasons. I don't want two copies of the KVM running around
> inside iommfd..
>

Ok, I updated the changes as below.

5 files changed, 161 insertions(+), 2 deletions(-)
drivers/iommu/iommufd/iommufd_private.h |   3 +
drivers/iommu/iommufd/main.c            |   5 ++
drivers/iommu/iommufd/viommu.c          | 134 +++++++++++++++++++++++++++++++-
include/linux/iommufd.h                 |   5 +-
include/uapi/linux/iommufd.h            |  16 ++++

modified   drivers/iommu/iommufd/iommufd_private.h
@@ -606,6 +606,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
+int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd);
+int iommufd_vdevice_tsm_unbind_ioctl(struct iommufd_ucmd *ucmd);
 
 struct iommufd_vdevice {
 	struct iommufd_object obj;
@@ -613,6 +615,7 @@ struct iommufd_vdevice {
 	struct iommufd_viommu *viommu;
 	struct device *dev;
 	u64 id; /* per-vIOMMU virtual ID */
+	bool tsm_bound;
 };
 
 #ifdef CONFIG_IOMMUFD_TEST
modified   drivers/iommu/iommufd/main.c
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
modified   drivers/iommu/iommufd/viommu.c
@@ -2,6 +2,57 @@
 /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
  */
 #include "iommufd_private.h"
+#include "linux/tsm.h"
+
+#if IS_ENABLED(CONFIG_KVM)
+#include <linux/kvm_host.h>
+
+static void viommu_get_kvm_safe(struct iommufd_viommu *viommu, struct kvm *kvm)
+{
+	void (*put_fn)(struct kvm *kvm);
+	bool (*get_fn)(struct kvm *kvm);
+	bool ret;
+
+	if (!kvm)
+		return;
+
+	put_fn = symbol_get(kvm_put_kvm);
+	if (WARN_ON(!put_fn))
+		return;
+
+	get_fn = symbol_get(kvm_get_kvm_safe);
+	if (WARN_ON(!get_fn)) {
+		symbol_put(kvm_put_kvm);
+		return;
+	}
+
+	ret = get_fn(kvm);
+	symbol_put(kvm_get_kvm_safe);
+	if (!ret) {
+		symbol_put(kvm_put_kvm);
+		return;
+	}
+
+	viommu->put_kvm = put_fn;
+	viommu->kvm = kvm;
+}
+
+static void viommu_put_kvm(struct iommufd_viommu *viommu)
+{
+	if (!viommu->kvm)
+		return;
+
+	if (WARN_ON(!viommu->put_kvm))
+		goto clear;
+
+	viommu->put_kvm(viommu->kvm);
+	viommu->put_kvm = NULL;
+	symbol_put(kvm_put_kvm);
+
+clear:
+	viommu->kvm = NULL;
+}
+#endif
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
 {
@@ -12,6 +63,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 		viommu->ops->destroy(viommu);
 	refcount_dec(&viommu->hwpt->common.obj.users);
 	xa_destroy(&viommu->vdevs);
+
+	viommu_put_kvm(viommu);
 }
 
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
@@ -68,10 +121,32 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
 
+	/* get the kvm details if specified. */
+	if (cmd->kvm_vm_fd) {
+		struct kvm *kvm;
+		struct fd f = fdget(cmd->kvm_vm_fd);
+
+		if (!fd_file(f)) {
+			rc = -EBADF;
+			goto out_abort;
+		}
+
+		if (!file_is_kvm(fd_file(f))) {
+			rc = -EBADF;
+			fdput(f);
+			goto out_abort;
+		}
+		kvm = fd_file(f)->private_data;
+		viommu_get_kvm_safe(viommu, kvm);
+		fdput(f);
+	}
+
 	cmd->out_viommu_id = viommu->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
-	if (rc)
+	if (rc) {
+		viommu_put_kvm(viommu);
 		goto out_abort;
+	}
 	iommufd_object_finalize(ucmd->ictx, &viommu->obj);
 	goto out_put_hwpt;
 
@@ -90,6 +165,9 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
 
+	if (vdev->tsm_bound)
+		tsm_unbind(vdev->dev);
+
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
@@ -157,3 +235,57 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
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
+	rc = tsm_bind(vdev->dev, vdev->viommu->kvm, vdev->id);
+	if (rc) {
+		rc = -ENODEV;
+		goto out_put_vdev;
+	}
+
+	/* locking? */
+	vdev->tsm_bound = true;
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
+	/* locking ? */
+	vdev->tsm_bound = false;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_put_vdev:
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+	return rc;
+}
modified   include/linux/iommufd.h
@@ -51,8 +51,9 @@ struct iommufd_object {
 	unsigned int id;
 };
 
+struct kvm;
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
-					   struct device *dev, u32 *id);
+					   struct device *dev, struct kvm *kvm, u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
 
 int iommufd_device_attach(struct iommufd_device *idev, ioasid_t pasid,
@@ -94,6 +95,8 @@ struct iommufd_viommu {
 	struct iommufd_ctx *ictx;
 	struct iommu_device *iommu_dev;
 	struct iommufd_hwpt_paging *hwpt;
+	struct kvm *kvm;
+	void (*put_kvm)(struct kvm *kvm);
 
 	const struct iommufd_viommu_ops *ops;
 
modified   include/uapi/linux/iommufd.h
@@ -56,6 +56,8 @@ enum {
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
+	IOMMUFD_CMD_VDEVICE_TSM_BIND = 0x94,
+	IOMMUFD_CMD_VDEVICE_TSM_UNBIND = 0x95,
 };
 
 /**
@@ -985,6 +987,7 @@ struct iommu_viommu_alloc {
 	__u32 dev_id;
 	__u32 hwpt_id;
 	__u32 out_viommu_id;
+	__u32 kvm_vm_fd;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
 
@@ -1038,6 +1041,19 @@ enum iommu_veventq_flag {
 	IOMMU_VEVENTQ_FLAG_LOST_EVENTS = (1U << 0),
 };
 
+/**
+ * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
+ * @size: sizeof(struct iommu_vdevice_id)
+ * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
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



>
>> >> +	if (rc) {
>> >> +		rc = -ENODEV;
>> >> +		goto out_put_vdev;
>> >> +	}
>> >> +
>> >> +	/* locking? */
>> >> +	vdev->tsm_bound = true;
>> >> +	refcount_inc(&vdev->obj.users);
>> >
>> > This refcount isn't going to work, it will make an error close()
>> > crash..
>> >
>> > You need to auto-unbind on destruction I think.
>> 
>> Can you elaborate on that? if vdevice is tsm_bound,
>> iommufd_vdevice_destroy() do call tsm_unbind in the changes I shared.
>
> You are driving it from the vfio side? Then you don't need the
> refcount at all here because the vfio facing APIs already take one.

I am using iommufd ioctl to bind/unbind. The goal was to call tsm_unbind
when we close the iommu file descriptor( So when a vdevice object is
destroyed).

-aneesh

