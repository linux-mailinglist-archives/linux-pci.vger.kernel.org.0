Return-Path: <linux-pci+bounces-33040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 828ECB13C30
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 15:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53346189FD02
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AC0270EBF;
	Mon, 28 Jul 2025 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK6GN05P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8B26F477;
	Mon, 28 Jul 2025 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710804; cv=none; b=gK0DuiDziAfm1LIAA83fDX6BQZ8dEjK91ku/YSkzU9cDG407QZQEuMQ6Uyq52M58CCEcSYo68Oh9HYRDKajkzxAYYDTjkSJcfQxNqWKIqU5b7FyTbaRuqFQtHum9R5n8HnWpfq0lSDq1mjzImd1CxpGXt1hutkCpvOezWxX/ldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710804; c=relaxed/simple;
	bh=r2X8xQvXTe2/rt3IYYSojQHGbzxLf/rj14w8bO/KdGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJQZH41Nw5ctlwVo+LI/Bw6sReH2BoZ0SldAr9h6KP77x2VnPxYn1dSc+bwnX3KoWRAuQ1kn1X8I4hj8vpcMmrqNUKtYU3DQAMsYFsddeyDsvxlJ6qK8FGRAArtnOWadet2czeavKbMS1ezO2cuh+zOk8/YSzJfxuobR9REXOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK6GN05P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB64BC4CEE7;
	Mon, 28 Jul 2025 13:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710804;
	bh=r2X8xQvXTe2/rt3IYYSojQHGbzxLf/rj14w8bO/KdGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PK6GN05PlcmyBbbuiiSpCSnkeMnqNg80hm05KVJXhu9JPDMGIr2puTifIPcJmGDRe
	 wLQyafhLNU+vaaFhmr/S/YGMklH2xDQzz0xP5w98mxCLBfB2N+cvt6rBas8Tpi0JKo
	 JzdciaYWDd4Zvhacj0EBoaMcwp4cQZebPY7ofhGA5oDTuZFw3Slk8eJ//1D9rmclNQ
	 G69RRStZ17/1/oHq4cMCJ7G/hNf9qx6eNYLvT+wJZAyoe3+4EmhE4tufHjqT02PJ2g
	 hA2nzdczhWXWovII7kJxmr3xZKajOjjl4nyYRBM/NCQ+Ab2mx/bwyZYBaydSxt6q25
	 YeYq2bpg6uBOw==
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
Subject: [RFC PATCH v1 08/38] iommufd/tsm: Add tsm_op iommufd ioctls
Date: Mon, 28 Jul 2025 19:21:45 +0530
Message-ID: <20250728135216.48084-9-aneesh.kumar@kernel.org>
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

Add operations bind and unbind used to bind a TDI to the secure guest.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  3 ++
 drivers/iommu/iommufd/viommu.c          | 50 +++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c        | 10 +++++
 include/uapi/linux/iommufd.h            | 18 +++++++++
 5 files changed, 82 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index fce68714c80f..e08186f1d102 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -697,6 +697,7 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj);
 void iommufd_vdevice_abort(struct iommufd_object *obj);
 int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_hw_queue_destroy(struct iommufd_object *obj);
+int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd);
 
 static inline struct iommufd_vdevice *
 iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 89830da8b418..4f2a1995bd1f 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -410,6 +410,7 @@ union ucmd_buffer {
 	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_vdevice_tsm_op tsm_op;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -471,6 +472,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VDEVICE_TSM_OP, iommufd_vdevice_tsm_op_ioctl,
+		 struct iommu_vdevice_tsm_op, vdevice_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 59f1e1176f7f..c934312e5397 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -162,6 +162,9 @@ void iommufd_vdevice_abort(struct iommufd_object *obj)
 
 	lockdep_assert_held(&idev->igroup->lock);
 
+#ifdef CONFIG_TSM
+	tsm_unbind(idev->dev);
+#endif
 	if (vdev->destroy)
 		vdev->destroy(vdev);
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
@@ -471,3 +474,50 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+#ifdef CONFIG_TSM
+int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vdevice_tsm_op *cmd = ucmd->cmd;
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
+		/*
+		 * tsm layer will make take care of parallel calls to tsm_bind/unbind
+		 */
+		if (cmd->op == IOMMU_VDEICE_TSM_BIND)
+			rc = tsm_bind(vdev->idev->dev, kvm, vdev->virt_id);
+		else if (cmd->op == IOMMU_VDEICE_TSM_UNBIND)
+			rc = tsm_unbind(vdev->idev->dev);
+
+		if (rc) {
+			rc = -ENODEV;
+			goto out_put_vdev;
+		}
+	} else {
+		goto out_put_vdev;
+	}
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_put_vdev:
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+	return rc;
+}
+#else /* !CONFIG_TSM */
+int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
+{
+	return -ENODEV;
+}
+#endif
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index bee3cf3226e9..afdb39c6aefd 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -694,6 +694,16 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 #if IS_ENABLED(CONFIG_EEH)
 	eeh_dev_release(vdev->pdev);
 #endif
+
+#if 0
+	/*
+	 * destroy vdevice which involves tsm unbind before we disable pci disable
+	 * A MSE/BME clear will transition the device to error state.
+	 */
+	if (core_vdev->iommufd_device)
+		iommufd_device_tombstone_vdevice(core_vdev->iommufd_device);
+#endif
+
 	vfio_pci_core_disable(vdev);
 
 	mutex_lock(&vdev->igate);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 9014c61a97d4..8b1fbf1ef25c 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -57,6 +57,7 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_VDEVICE_TSM_OP = 0x95,
 };
 
 /**
@@ -1127,6 +1128,23 @@ enum iommu_veventq_flag {
 	IOMMU_VEVENTQ_FLAG_LOST_EVENTS = (1U << 0),
 };
 
+/**
+ * struct iommu_vdevice_tsm_OP - ioctl(IOMMU_VDEVICE_TSM_OP)
+ * @size: sizeof(struct iommu_vdevice_tsm_OP)
+ * @op: Either TSM_BIND or TSM_UNBIMD
+ * @flags: Must be 0
+ * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
+ */
+struct iommu_vdevice_tsm_op {
+	__u32 size;
+	__u32 op;
+	__u32 flags;
+	__u32 vdevice_id;
+};
+#define IOMMU_VDEVICE_TSM_OP	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_OP)
+#define IOMMU_VDEICE_TSM_BIND		0x1
+#define IOMMU_VDEICE_TSM_UNBIND		0x2
+
 /**
  * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
  * @flags: Combination of enum iommu_veventq_flag
-- 
2.43.0


