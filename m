Return-Path: <linux-pci+bounces-33041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F65B13C32
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 15:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC3718C0A60
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCFA26FA50;
	Mon, 28 Jul 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMZ38ZZW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4826F477;
	Mon, 28 Jul 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710810; cv=none; b=BUIAb2z2EsIWQybNm8Y/h1pz3I/gPtzoI5Ny7K+7Ey2t/OSRuNWKCCiKTTzETHX6/Jr9etlbzB6Ws5PHnI0f6vaXSAj5Wac7AovJUJCqr8fdQ4mCPop9zX6Yf0UdqHpoJ6HLM1h2gfW+SUclsjT6sCUrJNj4UTOs96oOm8yBMNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710810; c=relaxed/simple;
	bh=WA5m+a2dUJtMdyp7kjgPNPN6wCrN/6b+STzciuqotTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsRFwDIZsiUU4KfON4E+tmx0Gd0xgiglBaED8eLSjvUcN0/MOdrGuw+W5COlIUP22gm+H9Xz0ihA4aac+9EZetOvWyu/SroxOlCPxb+PyoSoBt3QQc+b3257DiTAchFI++85Hufw3Jp2nikeZjWjNqLMHxxooj3/gKTNHgPIyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMZ38ZZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A789DC4CEFA;
	Mon, 28 Jul 2025 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710810;
	bh=WA5m+a2dUJtMdyp7kjgPNPN6wCrN/6b+STzciuqotTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMZ38ZZWSjIdNK/1lEUDw/ERsqwPWeD4iNTLVSby00grYkV8/5mFFTe5De7yjYr4W
	 nHwQdPH3uAyMzFwD78KD+tsw74bTRkN5OVHSsLrUfUtmQJpZuwJwIiSGgHmOIJ1YnZ
	 cjK8dAdeVTccpVy7nRet9Kctll9GhUK48a7UbpPeeLzi7VtpEtOWVGuAy3lzaATS1n
	 5uwpUrvqMbZuliFQ3OiO/XLW6pkbp2z+Ci4TpvTGPZ30xYwVpY/ni2Vilv/WGdEfC1
	 gM+lJ/+Uy0nDce75mVdd8r/TxLWZSP07kf9JNzcrv/G6sp7xUcxChVpudBDim5056/
	 oP+r15U+ADGqw==
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
Subject: [RFC PATCH v1 09/38] iommufd/vdevice: Add TSM Guest request uAPI
Date: Mon, 28 Jul 2025 19:21:46 +0530
Message-ID: <20250728135216.48084-10-aneesh.kumar@kernel.org>
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

Add TSM Guest request uAPI against iommufd_vdevice to forward various
TSM attestation & acceptance requests from guest to TSM driver/secure
firmware. This uAPI takes function only after TSM Bind.

After a vPCI device is locked down by TSM Bind, CoCo VM should attest
and accept the device in its TEE. These operations needs interaction
with secure firmware and the device, but doesn't impact the device
management from host's POV. It doesn't change the fact that host should
not touch some part of the device (see TDISP spec) to keep the trusted
assignment, and host could exit trusted assignment and roll back
everything by TSM Unbind.

So the TSM Guest request becomes a passthrough channel for CoCo VM to
exchange request/response blobs with TSM driver/secure firmware. The
definition of this IOCTL illustates this idea.

Based on changes from: Alexey Kardashevskiy <aik@amd.com>

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  3 ++
 drivers/iommu/iommufd/viommu.c          | 40 +++++++++++++++++++++++++
 drivers/pci/tsm.c                       | 15 ++++++++--
 drivers/virt/coco/tsm-core.c            |  9 ++++++
 include/linux/pci-tsm.h                 | 30 ++-----------------
 include/linux/tsm.h                     | 23 ++++++++++++++
 include/uapi/linux/iommufd.h            | 28 +++++++++++++++++
 8 files changed, 120 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index e08186f1d102..0c0d96135432 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -698,6 +698,7 @@ void iommufd_vdevice_abort(struct iommufd_object *obj);
 int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_hw_queue_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd);
+int iommufd_vdevice_tsm_guest_request_ioctl(struct iommufd_ucmd *ucmd);
 
 static inline struct iommufd_vdevice *
 iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 4f2a1995bd1f..65e60da9caef 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -411,6 +411,7 @@ union ucmd_buffer {
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
 	struct iommu_vdevice_tsm_op tsm_op;
+	struct iommu_vdevice_tsm_guest_request gr;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -474,6 +475,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_viommu_alloc, out_viommu_id),
 	IOCTL_OP(IOMMU_VDEVICE_TSM_OP, iommufd_vdevice_tsm_op_ioctl,
 		 struct iommu_vdevice_tsm_op, vdevice_id),
+	IOCTL_OP(IOMMU_VDEVICE_TSM_GUEST_REQUEST, iommufd_vdevice_tsm_guest_request_ioctl,
+		 struct iommu_vdevice_tsm_guest_request, resp_uptr),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index c934312e5397..9f4d4d69b82b 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -515,9 +515,49 @@ int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &vdev->obj);
 	return rc;
 }
+
+int iommufd_vdevice_tsm_guest_request_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vdevice_tsm_guest_request *cmd = ucmd->cmd;
+	struct tsm_guest_req_info info = {
+		.type = cmd->type,
+		.type_info = u64_to_user_ptr(cmd->type_info_uptr),
+		.type_info_len = cmd->type_info_len,
+		.req = u64_to_user_ptr(cmd->req_uptr),
+		.req_len = cmd->req_len,
+		.resp = u64_to_user_ptr(cmd->resp_uptr),
+		.resp_len = cmd->resp_len,
+	};
+	struct iommufd_vdevice *vdev;
+	int rc;
+
+	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
+					       IOMMUFD_OBJ_VDEVICE),
+			    struct iommufd_vdevice, obj);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
+
+	rc = tsm_guest_req(vdev->idev->dev, &info);
+	if (rc)
+		goto err_out;
+
+	cmd->resp_len = info.resp_len;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+err_out:
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+	return rc;
+}
+
 #else /* !CONFIG_TSM */
+
 int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
 {
 	return -ENODEV;
 }
+
+int iommufd_vdevice_tsm_guest_request_ioctl(struct iommufd_ucmd *ucmd)
+{
+	return -ENODEV;
+}
+
 #endif
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 80607082b7f0..896ef0f5fbe7 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -861,7 +861,7 @@ int pci_tsm_unbind(struct pci_dev *pdev)
 EXPORT_SYMBOL_GPL(pci_tsm_unbind);
 
 /**
- * pci_tsm_guest_req - VFIO/IOMMUFD helper to handle guest requests
+ * pci_tsm_guest_req - IOMMUFD helper to handle guest requests
  * @pdev: @pdev representing a bound tdi
  * @info: envelope for the request
  *
@@ -871,11 +871,12 @@ EXPORT_SYMBOL_GPL(pci_tsm_unbind);
  * posts to userspace (e.g. QEMU) that holds the host-to-guest RID
  * mapping.
  */
-int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info)
+static int __pci_tsm_guest_req(struct pci_dev *pdev, struct tsm_guest_req_info *info)
 {
 	struct pci_tdi *tdi;
 	int rc;
 
+
 	lockdep_assert_held_read(&pci_tsm_rwsem);
 
 	if (!pdev->tsm)
@@ -899,4 +900,14 @@ int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info)
 
 	return 0;
 }
+
+int pci_tsm_guest_req(struct pci_dev *pdev, struct tsm_guest_req_info *info)
+{
+	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
+	if (!lock)
+		return -EINTR;
+
+	return __pci_tsm_guest_req(pdev, info);
+}
+
 EXPORT_SYMBOL_GPL(pci_tsm_guest_req);
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index 0a7c9aa46c56..32b1235518b4 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -134,6 +134,15 @@ int tsm_unbind(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tsm_unbind);
 
+int tsm_guest_req(struct device *dev, struct tsm_guest_req_info *info)
+{
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	return pci_tsm_guest_req(to_pci_dev(dev), info);
+}
+EXPORT_SYMBOL_GPL(tsm_guest_req);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_core_dev *core = container_of(dev, typeof(*core), dev);
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 7639e7963681..530f8b3093f8 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -108,31 +108,7 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
 	return PCI_FUNC(pdev->devfn) == 0;
 }
 
-enum pci_tsm_guest_req_type {
-	PCI_TSM_GUEST_REQ_TDXC,
-};
-
-/**
- * struct pci_tsm_guest_req_info - parameter for pci_tsm_ops.guest_req()
- * @type: identify the format of the following blobs
- * @type_info: extra input/output info, e.g. firmware error code
- * @type_info_len: the size of @type_info
- * @req: request data buffer filled by guest
- * @req_len: the size of @req filled by guest
- * @resp: response data buffer filled by host
- * @resp_len: for input, the size of @resp buffer filled by guest
- *	      for output, the size of actual response data filled by host
- */
-struct pci_tsm_guest_req_info {
-	enum pci_tsm_guest_req_type type;
-	void *type_info;
-	size_t type_info_len;
-	void *req;
-	size_t req_len;
-	void *resp;
-	size_t resp_len;
-};
-
+struct tsm_guest_req_info;
 /**
  * struct pci_tsm_ops - Low-level TSM-exported interface to the PCI core
  * @probe: probe/accept device for tsm operation, setup DSM context
@@ -160,7 +136,7 @@ struct pci_tsm_ops {
 				struct kvm *kvm, u64 tdi_id);
 	void (*unbind)(struct pci_tdi *tdi);
 	int (*guest_req)(struct pci_dev *pdev,
-			 struct pci_tsm_guest_req_info *info);
+			 struct tsm_guest_req_info *info);
 	int (*accept)(struct pci_dev *pdev);
 };
 
@@ -180,7 +156,7 @@ int pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm);
 int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm);
 int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id);
 int pci_tsm_unbind(struct pci_dev *pdev);
-int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info);
+int pci_tsm_guest_req(struct pci_dev *pdev, struct tsm_guest_req_info *info);
 #else
 static inline int pci_tsm_core_register(const struct pci_tsm_ops *ops,
 					const struct attribute_group *grp)
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 0aab8d037e71..497a3b4df5a0 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -123,4 +123,27 @@ int tsm_ide_stream_register(struct pci_dev *pdev, struct pci_ide *ide);
 void tsm_ide_stream_unregister(struct pci_ide *ide);
 int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id);
 int tsm_unbind(struct device *dev);
+
+/**
+ * struct tsm_guest_req_info - parameter for pci_tsm_ops.guest_req()
+ * @type: identify the format of the following blobs
+ * @type_info: extra input/output info, e.g. firmware error code
+ * @type_info_len: the size of @type_info
+ * @req: request data buffer filled by guest
+ * @req_len: the size of @req filled by guest
+ * @resp: response data buffer filled by host
+ * @resp_len: for input, the size of @resp buffer filled by guest
+ *	      for output, the size of actual response data filled by host
+ */
+struct tsm_guest_req_info {
+	u32 type;
+	void __user *type_info;
+	size_t type_info_len;
+	void __user *req;
+	size_t req_len;
+	void __user *resp;
+	size_t resp_len;
+};
+
+int tsm_guest_req(struct device *dev, struct tsm_guest_req_info *info);
 #endif /* __TSM_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 8b1fbf1ef25c..56542cfcfa38 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -58,6 +58,7 @@ enum {
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 	IOMMUFD_CMD_VDEVICE_TSM_OP = 0x95,
+	IOMMUFD_CMD_VDEVICE_TSM_GUEST_REQUEST = 0x96,
 };
 
 /**
@@ -1320,4 +1321,31 @@ struct iommu_hw_queue_alloc {
 	__aligned_u64 length;
 };
 #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
+
+/**
+ * struct iommu_vdevice_tsm_guest_request - ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
+ * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
+ * @vdevice_id: vDevice ID the guest request is for
+ * @type: identify the format of the following blobs
+ * @type_info_len: the blob size for @type_info_uptr
+ * @req_len: the blob size for @req_uptr, filled by guest
+ * @resp_len: for input, the blob size for @resp_uptr, filled by guest
+ *	      for output, the size of actual response data, filled by host
+ * @type_info_uptr: extra input/output info, e.g. firmware error code
+ * @req_uptr: request data buffer filled by guest
+ * @resp_uptr: response data buffer filled by host
+ */
+struct iommu_vdevice_tsm_guest_request {
+	__u32 size;
+	__u32 vdevice_id;
+	__u32 type;
+	__u32 type_info_len;
+	__u32 req_len;
+	__u32 resp_len;
+	__aligned_u64 type_info_uptr;
+	__aligned_u64 req_uptr;
+	__aligned_u64 resp_uptr;
+};
+#define IOMMU_VDEVICE_TSM_GUEST_REQUEST _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_GUEST_REQUEST)
+
 #endif
-- 
2.43.0


