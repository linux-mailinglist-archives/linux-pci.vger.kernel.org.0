Return-Path: <linux-pci+bounces-28651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A05DAC7EEF
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 15:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF3B9E3FDB
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B3B227EA1;
	Thu, 29 May 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsoZGoCs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD444227E8F;
	Thu, 29 May 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525897; cv=none; b=uIX7idX7IL9uf9Or5s6FuybNVHw5FY5yGiqJRTroXVISKqC8JP8UcaaDlKwlUtMPnhms/5H4+vRdvpGfsviuWh93WuAWtfUurLm38BpOSSuXeErlcT54M5GMNfteLq1TohbG780i0Fs9ShtmOU3yEIf8RfCUc9EvFrRXcO4lRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525897; c=relaxed/simple;
	bh=sKr20AeYxYfK4uOv1ow0Sm8j0dEk7Prgi4fHSftNsuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMJSAPjzFPTUqVXNoe6+lf4ZpO3XZy0+JDrJ8mMFjGCDFIiPaOxUb1Ib+t5/D6wqIcaCqpTyAZ2QJi5VnQ5UOi2O/piqOQtv2JoXsbC/1jss4imNSVdV+keHa/x4TLDoqhD6QuHp9lsxuqGKXgllw/Tvu7lhVcMF8kFqDPWBTIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsoZGoCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32368C4CEEB;
	Thu, 29 May 2025 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748525896;
	bh=sKr20AeYxYfK4uOv1ow0Sm8j0dEk7Prgi4fHSftNsuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsoZGoCsyafP7p0A/WZXoLjlJgKw6mJP5kbD519gzmYRsWQqFf9Bd5mDG2bdB9CDe
	 H8hTeQUhK7iZZfzHbEaXw2eqpk2OR7tUKKL4/8h+0D6VAd+WBdwwcCwK3bdQI46TGh
	 b7dWt27IY6LpTqlrgfpZ8KzGBTocgSDzQt0m5xQB7m9HKqgiS0ZC8eLUxJqfk7iQUP
	 GIu2I1PCUgCfmzwUPM46MRCxYC36U4mOGoWr+WRRvitddnlH/1CE8vvtc2W/V7nL3D
	 Uhz/XoHgprNfn0AS5WqEytYfyNm5/srU/WYsf/lG375TpX5OqokvAoOqv+kILJzsId
	 v2mSkJ4hC9LXQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org,
	lukas@wunner.de,
	suzuki.poulose@arm.com,
	sameo@rivosinc.com,
	jgg@nvidia.com,
	zhiw@nvidia.com,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH 2/3] iommufd/viommu: Add support to associate viommu with kvm instance
Date: Thu, 29 May 2025 19:07:55 +0530
Message-ID: <20250529133757.462088-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529133757.462088-1-aneesh.kumar@kernel.org>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The associated kvm instance will be used in later patch by iommufd to
bind a tdi to kvm.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/viommu.c | 48 ++++++++++++++++++++++++++++++++--
 include/linux/iommufd.h        |  3 +++
 include/uapi/linux/iommufd.h   |  2 ++
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 01df2b985f02..10d343871fb2 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -2,6 +2,37 @@
 /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
  */
 #include "iommufd_private.h"
+#include "linux/tsm.h"
+
+#if IS_ENABLED(CONFIG_KVM)
+#include <linux/kvm_host.h>
+
+static int viommu_get_kvm(struct iommufd_viommu *viommu, int kvm_vm_fd)
+{
+	int rc = -EBADF;
+	struct kvm *kvm;
+	struct fd f = fdget(kvm_vm_fd);
+
+	if (!fd_file(f) || !file_is_kvm(fd_file(f)))
+		goto err_out;
+
+	kvm = fd_file(f)->private_data;
+	if (!kvm)
+		goto err_out;
+
+	/* hold the kvm reference via file descriptor */
+	viommu->kvm_fd = f;
+	return rc;
+err_out:
+	fdput(f);
+	return rc;
+}
+
+static void viommu_put_kvm(struct iommufd_viommu *viommu)
+{
+	fdput(viommu->kvm_fd);
+}
+#endif
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
 {
@@ -12,6 +43,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 		viommu->ops->destroy(viommu);
 	refcount_dec(&viommu->hwpt->common.obj.users);
 	xa_destroy(&viommu->vdevs);
+
+	viommu_put_kvm(viommu);
 }
 
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
@@ -23,7 +56,9 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	const struct iommu_ops *ops;
 	int rc;
 
-	if (cmd->flags || cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT)
+	if (cmd->flags & ~IOMMU_VIOMMU_KVM_FD)
+		return -EOPNOTSUPP;
+	if (cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT)
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
@@ -68,10 +103,19 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
 
+	/* get the kvm details if specified. */
+	if (cmd->flags & IOMMU_VIOMMU_KVM_FD) {
+		rc = viommu_get_kvm(viommu, cmd->kvm_vm_fd);
+		if (rc)
+			goto out_abort;
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
 
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 34b6e6ca4bfa..ed5c404f1b0b 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -12,6 +12,7 @@
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
+#include <linux/file.h>
 #include <uapi/linux/iommufd.h>
 
 struct device;
@@ -51,6 +52,7 @@ struct iommufd_object {
 	unsigned int id;
 };
 
+struct kvm;
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
@@ -94,6 +96,7 @@ struct iommufd_viommu {
 	struct iommufd_ctx *ictx;
 	struct iommu_device *iommu_dev;
 	struct iommufd_hwpt_paging *hwpt;
+	struct fd kvm_fd;
 
 	const struct iommufd_viommu_ops *ops;
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index f29b6c44655e..b3b962d857c7 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -957,6 +957,7 @@ enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
 };
 
+#define IOMMU_VIOMMU_KVM_FD	BIT(0)
 /**
  * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
  * @size: sizeof(struct iommu_viommu_alloc)
@@ -985,6 +986,7 @@ struct iommu_viommu_alloc {
 	__u32 dev_id;
 	__u32 hwpt_id;
 	__u32 out_viommu_id;
+	__u32 kvm_vm_fd;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
 
-- 
2.43.0


