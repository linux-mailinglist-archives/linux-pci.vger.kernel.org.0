Return-Path: <linux-pci+bounces-33038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6D3B13C2E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 15:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E634E2123
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB98727055A;
	Mon, 28 Jul 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax4vbWTp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCDC270EA4;
	Mon, 28 Jul 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710792; cv=none; b=ZzJKGbd+YPf81U2TU/KEZw1AsudYj3KLAfxyUdhdKJClnuZAnh7D3B2HUNv36aVy5HND5YmLcVHqiqjk9V5flbrlM01A2MWxsxg5YI3a1QNYVqfQvIV01k6BWwpoE4yHCitN4Fj/ikMJQwl4ZHgwilmy1nmyx/zWwED9I2yJ9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710792; c=relaxed/simple;
	bh=d+5HhA/RM0XRXjhVWrZjfkcucjv6dqn+ILMfw2/nkW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biNSFfL3Ecyw27GrCeM/fyjK2wGcNqYuD0xvIKByobkLpGBg/Mwux/bTifWOkTAzOmg3O2UlmKi5sZrPgAznCuzwk0fd8Hn6KMbq5thw91mZ5m/7qCSYH2CuRFV0g6zkbpHzqAkfr1EOvGMKJzPMu8tUbQ76N3o9up+Ionxlqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax4vbWTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22502C4CEE7;
	Mon, 28 Jul 2025 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710792;
	bh=d+5HhA/RM0XRXjhVWrZjfkcucjv6dqn+ILMfw2/nkW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ax4vbWTpAj5oWtKqPDHQunDjLBJJBQ+0swxGUvwfXst7+A/K6EUvr68gl9+GHSXLU
	 ELeFp1tUOVhj3KnS4tvDnvIE79f44R7Y+pppohRD0sAxFRB3dd7DwnOCnocnRLr4D8
	 L/ZWeiqyJgUjGI7NJF/klQO8oWSzXjwR2u68wYhJpsDCiz3pDIq2gKrWYQTNwLKsqQ
	 EBFEp0HZcZmdREobm0mqFVdHMZyUuozCsjMnxXh3RBeYzQdnePOTU14IUK7edD7Fft
	 JDFyTyxmcQnHjbbnF3vcHTKMt0MEBB+kDPEgrYhN2/STkijkkSzMRygoztdaXUtGoD
	 Uyrgiv66cZCGQ==
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
Subject: [RFC PATCH v1 06/38] iommufd: Add and option to request for bar mapping with IORESOURCE_EXCLUSIVE
Date: Mon, 28 Jul 2025 19:21:43 +0530
Message-ID: <20250728135216.48084-7-aneesh.kumar@kernel.org>
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

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/device.c          | 54 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  4 ++
 drivers/iommu/iommufd/main.c            |  3 ++
 drivers/vfio/pci/vfio_pci_core.c        |  9 ++++-
 include/linux/iommufd.h                 |  1 +
 include/uapi/linux/iommufd.h            |  1 +
 6 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 65fbd098f9e9..3bd6972836a1 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1660,3 +1660,57 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+static int iommufd_device_option_exclusive_ranges(struct iommu_option *cmd,
+					  struct iommufd_device *idev)
+{
+	if (cmd->op == IOMMU_OPTION_OP_GET) {
+		cmd->val64 = idev->flags & IOMMUFD_DEVICE_EXCLUSIVE_RANGE;
+		return 0;
+	}
+
+	if (cmd->op == IOMMU_OPTION_OP_SET) {
+		if (cmd->val64 == 0) {
+			idev->flags &= ~IOMMUFD_DEVICE_EXCLUSIVE_RANGE;
+			return 0;
+		} else if (cmd->val64 & IOMMUFD_DEVICE_EXCLUSIVE_RANGE) {
+			idev->flags |= IOMMUFD_DEVICE_EXCLUSIVE_RANGE;
+			return 0;
+		}
+		return -EINVAL;
+	}
+	return -EOPNOTSUPP;
+}
+bool iommufd_device_need_exclusive_range(struct iommufd_device *idev)
+{
+	return !!(idev->flags & IOMMUFD_DEVICE_EXCLUSIVE_RANGE);
+}
+
+int iommufd_device_option(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_option *cmd = ucmd->cmd;
+	struct iommufd_device *idev;
+	int rc = 0;
+
+	if (cmd->__reserved)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->object_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	mutex_lock(&idev->igroup->lock);
+
+
+	switch (cmd->option_id) {
+	case IOMMU_OPTION_EXCLUSIVE_RANGES:
+		rc = iommufd_device_option_exclusive_ranges(cmd, idev);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0da2a81eedfa..fce68714c80f 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -346,6 +346,7 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
+int iommufd_device_option(struct iommufd_ucmd *ucmd);
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 			       struct iommufd_ctx *ictx);
 
@@ -489,10 +490,13 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	unsigned long flags;
 	struct iommufd_vdevice *vdev;
 	bool destroying;
 };
 
+#define IOMMUFD_DEVICE_EXCLUSIVE_RANGE		BIT(0)
+
 static inline struct iommufd_device *
 iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 {
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 15af7ced0501..89830da8b418 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -376,6 +376,9 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 	case IOMMU_OPTION_HUGE_PAGES:
 		rc = iommufd_ioas_option(ucmd);
 		break;
+	case IOMMU_OPTION_EXCLUSIVE_RANGES:
+		rc = iommufd_device_option(ucmd);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6328c3a05bcd..bee3cf3226e9 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1753,8 +1753,15 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	 * we need to request the region and the barmap tracks that.
 	 */
 	if (!vdev->barmap[index]) {
-		ret = pci_request_selected_regions(pdev,
+
+		if (core_vdev->iommufd_device &&
+		    iommufd_device_need_exclusive_range(core_vdev->iommufd_device))
+			ret = pci_request_selected_regions_exclusive(pdev,
+							1 << index, "vfio-pci");
+		else
+			ret = pci_request_selected_regions(pdev,
 						   1 << index, "vfio-pci");
+
 		if (ret)
 			return ret;
 
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d..55ae02581f9b 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -70,6 +70,7 @@ void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid);
 
 struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev);
 u32 iommufd_device_to_id(struct iommufd_device *idev);
+bool iommufd_device_need_exclusive_range(struct iommufd_device *idev);
 
 struct iommufd_access_ops {
 	u8 needs_pin_pages : 1;
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c218c89e0e2e..548d4b5afcd4 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -310,6 +310,7 @@ struct iommu_ioas_unmap {
 enum iommufd_option {
 	IOMMU_OPTION_RLIMIT_MODE = 0,
 	IOMMU_OPTION_HUGE_PAGES = 1,
+	IOMMU_OPTION_EXCLUSIVE_RANGES = 2,
 };
 
 /**
-- 
2.43.0


