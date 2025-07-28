Return-Path: <linux-pci+bounces-33039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB9DB13C2C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 15:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D6E165E5B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83CA270EA4;
	Mon, 28 Jul 2025 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSojXbb9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7906F273D71;
	Mon, 28 Jul 2025 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710798; cv=none; b=Pg6svSlcquQC13jRvW8gP12KVIq3FWwCEZF0xa2TuidU3e2BGVhoeoTDQ9ECrxTYNlprQfzX6TC+/XcxQ5WOk9T8yqYVq12/FBitAj88Q0ulbvxQUdUuzUcfHG0OkvJt/Ymh/rYwOpvcNQeWsyAc+tg6C+eVb0Ow89OZWfno9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710798; c=relaxed/simple;
	bh=0XY3diaRsG7pI3ZAlRxXSg0vozyit/SCU9/52C1YpTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Egj8dktJXFvjNkQcto9tbWxLPfVaIIRj5e7jQdnJUp024dOA8etfBcm+SUW/Z0ApLouQk0jyE2x9gmgbxag1mbkSfbvaLgaO/Q3/DV1lBgg5OAN7V+MAzJDi8D7LOzWbQfsG/3tvIebck8uPdUoJIUPeqb/gFXL0TE6lAwb4gnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSojXbb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27FFC4CEE7;
	Mon, 28 Jul 2025 13:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710798;
	bh=0XY3diaRsG7pI3ZAlRxXSg0vozyit/SCU9/52C1YpTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fSojXbb9VOqyrMvpbAZNMDhq/+cnD0gfvBZmp74Rs2EfSd72rpRsApZ3zhXoZSD9l
	 cypVLbdcc95sUZq/CYFFKEGmIWMcl5W7UzR91ua2fJPv3TtU0cJdOgbQsaTf5pRcIO
	 6FBvzgGbMLbx1G3W6gus9/cUbw5fZu3m5qQfmr0BF6OWbv9wSIUAbd5Y/vjf/VxcTJ
	 mjVyqcnP2+6+LzxQaKJMqhjtqKkfSgoP1op01djw9IhQbYrs9bL3eQVnV1fGAUT7V/
	 E4mzeaUtz5c0/NPZswAGegoQi/2vZKUrgTEuSUEKLixqsYqp/d8SKUe9VBR0nrYYlk
	 WS1UmuCzrQgeA==
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
Subject: [RFC PATCH v1 07/38] iommufd/viommu: Add support to associate viommu with kvm instance
Date: Mon, 28 Jul 2025 19:21:44 +0530
Message-ID: <20250728135216.48084-8-aneesh.kumar@kernel.org>
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

The associated kvm instance will be used in later patch by iommufd to
bind a tdi to kvm.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/viommu.c | 45 +++++++++++++++++++++++++++++++++-
 include/linux/iommufd.h        |  3 +++
 include/uapi/linux/iommufd.h   | 12 +++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 2ca5809b238b..59f1e1176f7f 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -2,6 +2,36 @@
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
+	struct file *filp;
+
+	filp = fget(kvm_vm_fd);
+
+	if (!file_is_kvm(filp))
+		goto err_out;
+
+	/* hold the kvm reference via file descriptor */
+	viommu->kvm_filp = filp;
+	return 0;
+err_out:
+	viommu->kvm_filp = NULL;
+	fput(filp);
+	return rc;
+}
+
+static void viommu_put_kvm(struct iommufd_viommu *viommu)
+{
+	fput(viommu->kvm_filp);
+	viommu->kvm_filp = NULL;
+}
+#endif
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
 {
@@ -12,6 +42,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 		viommu->ops->destroy(viommu);
 	refcount_dec(&viommu->hwpt->common.obj.users);
 	xa_destroy(&viommu->vdevs);
+
+	viommu_put_kvm(viommu);
 }
 
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
@@ -29,7 +61,9 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	size_t viommu_size;
 	int rc;
 
-	if (cmd->flags || cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT)
+	if (cmd->flags & ~IOMMU_VIOMMU_KVM_FD)
+		return -EOPNOTSUPP;
+	if (cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT)
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
@@ -100,8 +134,17 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_hwpt;
 	}
 
+	/* get the kvm details if specified. */
+	if (cmd->flags & IOMMU_VIOMMU_KVM_FD) {
+		rc = viommu_get_kvm(viommu, cmd->kvm_vm_fd);
+		if (rc)
+			goto out_put_hwpt;
+	}
+
 	cmd->out_viommu_id = viommu->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		viommu_put_kvm(viommu);
 
 out_put_hwpt:
 	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 55ae02581f9b..b7617ba7a536 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -12,6 +12,7 @@
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
+#include <linux/file.h>
 #include <uapi/linux/iommufd.h>
 
 struct device;
@@ -58,6 +59,7 @@ struct iommufd_object {
 	unsigned int id;
 };
 
+struct kvm;
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
@@ -102,6 +104,7 @@ struct iommufd_viommu {
 	struct iommufd_ctx *ictx;
 	struct iommu_device *iommu_dev;
 	struct iommufd_hwpt_paging *hwpt;
+	struct file *kvm_filp;
 
 	const struct iommufd_viommu_ops *ops;
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 548d4b5afcd4..9014c61a97d4 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1023,6 +1023,17 @@ struct iommu_viommu_tegra241_cmdqv {
 	__aligned_u64 out_vintf_mmap_length;
 };
 
+/**
+ * define IOMMU_VIOMMU_KVM_FD - Flag indicating a valid KVM VM file descriptor
+ *
+ * This flag must be set when allocating a viommu instance that will be
+ * associated with a specific KVM VM. When allocating a viommu instance for a
+ * KVM VM, this flag must be set to inform the initialization logic that
+ * @iommu_viommu_alloc::kvm_vm_fd is properly initialized. If this flag is not
+ * provided but @iommu_viommu_alloc::kvm_vm_fd field will be ignored.
+ */
+#define IOMMU_VIOMMU_KVM_FD	BIT(0)
+
 /**
  * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
  * @size: sizeof(struct iommu_viommu_alloc)
@@ -1057,6 +1068,7 @@ struct iommu_viommu_alloc {
 	__u32 data_len;
 	__u32 __reserved;
 	__aligned_u64 data_uptr;
+	__u32 kvm_vm_fd;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
 
-- 
2.43.0


