Return-Path: <linux-pci+bounces-28652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B6AC7EEE
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 15:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A9316AA72
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFF6227E82;
	Thu, 29 May 2025 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeZY0FHf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0C1CD2C;
	Thu, 29 May 2025 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525901; cv=none; b=hCdpzrsFiCvBZ2gwi8+YulMua5ak6IbunGf9n2Ntun61oN3GfzegkefVEe9ShYgd9niSIj+pKOvJZLKmAGNv8SEbcwXO66bLFPy7J5lh7VEzNstbIrrSZ1GL8FUrbMlU9UKuYYmURLeD937TiN4ThcpvW2YR4UH6l7PADFzWkeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525901; c=relaxed/simple;
	bh=T/r/LoSc3A9u0cOq9W3IDxKmchbcUQzvFCTFW7CUYOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sv7zinDPlhRjcMLnjdIh/cR2e+CCUYid8WJACnjuQOlQEdOhztC/o2pD2H/uz6NWQh2+J9c4DwgGoK7tzeKAzT5kZCCTDTXUf92YVje1mTIdtTk0Xke4pA8v25O11sQpBRqfBfjPaENgTnDBH+Q9Q+tEhTcZozG5ZDUxod6ppf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeZY0FHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1ACC4CEE7;
	Thu, 29 May 2025 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748525900;
	bh=T/r/LoSc3A9u0cOq9W3IDxKmchbcUQzvFCTFW7CUYOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oeZY0FHfq33dUBFlr7sagvL/0CTOAcwVaqGneU1Y8Gzll+4e+wHWR9ltIW2DkvZCa
	 1xkOf7wIYDJ39z5KkYd5ezuEXjZfIRLGdURFYakB/TKQ9lBEPArPs3xx+sp3pQX6VV
	 W5BSDLxSlfHMcRC6ngB1JIKFDqTjO3V9PMLNXnZsebgGuscFj1AfM4CoSGlMKoHku5
	 914qbruolwfdpjnEN+bAKlit/PnntteUDsTj5w8D5URijziv4bldavoe/8wn28Y+f9
	 aqtSTVo/Oiw6tyteigi6F3RmK/JHJIx9DhMPSJGGSixVpSmIQuZZV8tcLint+Z9UzL
	 3MxKoZwvS9bdQ==
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
Subject: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Date: Thu, 29 May 2025 19:07:56 +0530
Message-ID: <20250529133757.462088-3-aneesh.kumar@kernel.org>
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

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/iommufd_private.h |  3 +
 drivers/iommu/iommufd/main.c            |  5 ++
 drivers/iommu/iommufd/viommu.c          | 78 +++++++++++++++++++++++++
 include/uapi/linux/iommufd.h            | 15 +++++
 4 files changed, 101 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 80e8c76d25f2..a323e8b18125 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
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
index 10d343871fb2..841cbadfb259 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -134,6 +134,9 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
 
+	if (vdev->tsm_bound)
+		tsm_unbind(vdev->dev);
+
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
@@ -201,3 +204,78 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+static struct mutex *vdev_lock(struct iommufd_vdevice *vdev)
+{
+
+	if (device_lock_interruptible(vdev->dev) != 0)
+		return NULL;
+	return &vdev->dev->mutex;
+}
+DEFINE_FREE(vdev_unlock, struct mutex *, if (_T) mutex_unlock(_T))
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
+
+	struct mutex *lock __free(vdev_unlock) = vdev_lock(vdev);
+	if (!lock)
+		return -EINTR;
+
+	if (!vdev->tsm_bound) {
+		struct kvm *kvm;
+
+		kvm = fd_file(vdev->viommu->kvm_fd)->private_data;
+		rc = tsm_bind(vdev->dev, kvm, vdev->id);
+		if (rc) {
+			rc = -ENODEV;
+			goto out_put_vdev;
+		}
+		vdev->tsm_bound = true;
+	}
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
+	struct mutex *lock __free(vdev_unlock) = vdev_lock(vdev);
+	if (!lock)
+		return -EINTR;
+
+	if (vdev->tsm_bound) {
+		rc = tsm_unbind(vdev->dev);
+		if (rc) {
+			rc = -ENODEV;
+			goto out_put_vdev;
+		}
+		vdev->tsm_bound = false;
+	}
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_put_vdev:
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+	return rc;
+}
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index b3b962d857c7..a080a64d7fda 100644
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
@@ -1040,6 +1042,19 @@ enum iommu_veventq_flag {
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
-- 
2.43.0


