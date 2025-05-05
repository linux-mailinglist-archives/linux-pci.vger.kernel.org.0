Return-Path: <linux-pci+bounces-27199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC10AA9F09
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 00:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C813B8EA8
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 22:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E567627CCC9;
	Mon,  5 May 2025 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttHZe6HJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B284F27CCC2;
	Mon,  5 May 2025 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483288; cv=none; b=FkA7N95TnQIgdlHxaERpBpHu8Zw1hdW892TxuSE2j3QtvniP0uNMtdazDv1F1XCnlRE/a38eyu3US2TS5U0mwaaOcy1tT240xXi42mta8lE7kyB51i3Yvt6paTyh+CMyAJOa9U1v2e9Ngh45F1pRgKUbvG/FtsQrzm2fUB3MXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483288; c=relaxed/simple;
	bh=B3IV8SySonOl1LXlQqByKfWy8EfZB/ZgTO5hbOZv3rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DRsyKPJcgjOmKYgi/xuOEo299Xtm8EuQN/6vQPyX2oiFkwo5q4Dtyl2UGa6CYBGz0fBCsNaPOKbt5sOxpaAtj5VtHLC+76eLFXvdZGCzYDW9COvDSp+uQB9bRBT+7wGUUXSlVQboWYRkTD7imOgQRMP1aks0KWfAXDnoXKWBHyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttHZe6HJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCAAC4CEED;
	Mon,  5 May 2025 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483288;
	bh=B3IV8SySonOl1LXlQqByKfWy8EfZB/ZgTO5hbOZv3rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ttHZe6HJJvD3KK30Dk6n1E4fmZi9kBrXFKdyMTwEzVL7aFzgSyqXNMIbUJR6REp2S
	 AewbQ8FamcfnFdejG/ucunSkESgpqgcvqiDgB6IwaVAJbHkwX5SzM9DCnK12LWbGZr
	 7PSrRdZ+N0ItOfltEyiKZ7JOZWphXTqyiYZr9fgy3NfRxICHDROTcEaOUfrkXj2LUT
	 Zavo4IYpbN722E0SEfP7B6U1gtg0J8Q89EcHlV9LiNpufNBFAFb0DlWnQnYqr46HC7
	 l9N8Qt2v7WjtnrL+X+WJKkF9OjRnzjlHZs1sthnktBVVLChDmt1/+CPiC1YcE5GFA/
	 H1FpkDpQkPy6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yi Liu <yi.l.liu@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 016/642] iommufd: Extend IOMMU_GET_HW_INFO to report PASID capability
Date: Mon,  5 May 2025 18:03:52 -0400
Message-Id: <20250505221419.2672473-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

[ Upstream commit 803f97298e7de9242eb677a1351dcafbbcc9117e ]

PASID usage requires PASID support in both device and IOMMU. Since the
iommu drivers always enable the PASID capability for the device if it
is supported, this extends the IOMMU_GET_HW_INFO to report the PASID
capability to userspace. Also, enhances the selftest accordingly.

Link: https://patch.msgid.link/r/20250321180143.8468-5-yi.l.liu@intel.com
Cc: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org> #aarch64 platform
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/device.c | 34 +++++++++++++++++++++++++++++++++-
 drivers/pci/ats.c              | 33 +++++++++++++++++++++++++++++++++
 include/linux/pci-ats.h        |  3 +++
 include/uapi/linux/iommufd.h   | 14 +++++++++++++-
 4 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3c7800d4ab622..66a6b7466820d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -3,6 +3,7 @@
  */
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
+#include <linux/pci-ats.h>
 #include <linux/slab.h>
 #include <uapi/linux/iommufd.h>
 
@@ -1304,7 +1305,8 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	void *data;
 	int rc;
 
-	if (cmd->flags || cmd->__reserved)
+	if (cmd->flags || cmd->__reserved[0] || cmd->__reserved[1] ||
+	    cmd->__reserved[2])
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
@@ -1361,6 +1363,36 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	if (device_iommu_capable(idev->dev, IOMMU_CAP_DIRTY_TRACKING))
 		cmd->out_capabilities |= IOMMU_HW_CAP_DIRTY_TRACKING;
 
+	cmd->out_max_pasid_log2 = 0;
+	/*
+	 * Currently, all iommu drivers enable PASID in the probe_device()
+	 * op if iommu and device supports it. So the max_pasids stored in
+	 * dev->iommu indicates both PASID support and enable status. A
+	 * non-zero dev->iommu->max_pasids means PASID is supported and
+	 * enabled. The iommufd only reports PASID capability to userspace
+	 * if it's enabled.
+	 */
+	if (idev->dev->iommu->max_pasids) {
+		cmd->out_max_pasid_log2 = ilog2(idev->dev->iommu->max_pasids);
+
+		if (dev_is_pci(idev->dev)) {
+			struct pci_dev *pdev = to_pci_dev(idev->dev);
+			int ctrl;
+
+			ctrl = pci_pasid_status(pdev);
+
+			WARN_ON_ONCE(ctrl < 0 ||
+				     !(ctrl & PCI_PASID_CTRL_ENABLE));
+
+			if (ctrl & PCI_PASID_CTRL_EXEC)
+				cmd->out_capabilities |=
+						IOMMU_HW_CAP_PCI_PASID_EXEC;
+			if (ctrl & PCI_PASID_CTRL_PRIV)
+				cmd->out_capabilities |=
+						IOMMU_HW_CAP_PCI_PASID_PRIV;
+		}
+	}
+
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 out_free:
 	kfree(data);
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c6b266c772c81..ec6c8dbdc5e9c 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -538,4 +538,37 @@ int pci_max_pasids(struct pci_dev *pdev)
 	return (1 << FIELD_GET(PCI_PASID_CAP_WIDTH, supported));
 }
 EXPORT_SYMBOL_GPL(pci_max_pasids);
+
+/**
+ * pci_pasid_status - Check the PASID status
+ * @pdev: PCI device structure
+ *
+ * Returns a negative value when no PASID capability is present.
+ * Otherwise the value of the control register is returned.
+ * Status reported are:
+ *
+ * PCI_PASID_CTRL_ENABLE - PASID enabled
+ * PCI_PASID_CTRL_EXEC - Execute permission enabled
+ * PCI_PASID_CTRL_PRIV - Privileged mode enabled
+ */
+int pci_pasid_status(struct pci_dev *pdev)
+{
+	int pasid;
+	u16 ctrl;
+
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
+	pasid = pdev->pasid_cap;
+	if (!pasid)
+		return -EINVAL;
+
+	pci_read_config_word(pdev, pasid + PCI_PASID_CTRL, &ctrl);
+
+	ctrl &= PCI_PASID_CTRL_ENABLE | PCI_PASID_CTRL_EXEC |
+		PCI_PASID_CTRL_PRIV;
+
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(pci_pasid_status);
 #endif /* CONFIG_PCI_PASID */
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 0e8b74e63767a..75c6c86cf09dc 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -42,6 +42,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features);
 void pci_disable_pasid(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
+int pci_pasid_status(struct pci_dev *pdev);
 #else /* CONFIG_PCI_PASID */
 static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
 { return -EINVAL; }
@@ -50,6 +51,8 @@ static inline int pci_pasid_features(struct pci_dev *pdev)
 { return -EINVAL; }
 static inline int pci_max_pasids(struct pci_dev *pdev)
 { return -EINVAL; }
+static inline int pci_pasid_status(struct pci_dev *pdev)
+{ return -EINVAL; }
 #endif /* CONFIG_PCI_PASID */
 
 #endif /* LINUX_PCI_ATS_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 78747b24bd0fb..9495604e40b06 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -608,9 +608,17 @@ enum iommu_hw_info_type {
  *                                   IOMMU_HWPT_GET_DIRTY_BITMAP
  *                                   IOMMU_HWPT_SET_DIRTY_TRACKING
  *
+ * @IOMMU_HW_CAP_PCI_PASID_EXEC: Execute Permission Supported, user ignores it
+ *                               when the struct
+ *                               iommu_hw_info::out_max_pasid_log2 is zero.
+ * @IOMMU_HW_CAP_PCI_PASID_PRIV: Privileged Mode Supported, user ignores it
+ *                               when the struct
+ *                               iommu_hw_info::out_max_pasid_log2 is zero.
  */
 enum iommufd_hw_capabilities {
 	IOMMU_HW_CAP_DIRTY_TRACKING = 1 << 0,
+	IOMMU_HW_CAP_PCI_PASID_EXEC = 1 << 1,
+	IOMMU_HW_CAP_PCI_PASID_PRIV = 1 << 2,
 };
 
 /**
@@ -626,6 +634,9 @@ enum iommufd_hw_capabilities {
  *                 iommu_hw_info_type.
  * @out_capabilities: Output the generic iommu capability info type as defined
  *                    in the enum iommu_hw_capabilities.
+ * @out_max_pasid_log2: Output the width of PASIDs. 0 means no PASID support.
+ *                      PCI devices turn to out_capabilities to check if the
+ *                      specific capabilities is supported or not.
  * @__reserved: Must be 0
  *
  * Query an iommu type specific hardware information data from an iommu behind
@@ -649,7 +660,8 @@ struct iommu_hw_info {
 	__u32 data_len;
 	__aligned_u64 data_uptr;
 	__u32 out_data_type;
-	__u32 __reserved;
+	__u8 out_max_pasid_log2;
+	__u8 __reserved[3];
 	__aligned_u64 out_capabilities;
 };
 #define IOMMU_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_HW_INFO)
-- 
2.39.5


