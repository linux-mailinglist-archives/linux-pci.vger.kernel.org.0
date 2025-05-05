Return-Path: <linux-pci+bounces-27214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A42AAA856
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 02:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A221F16302A
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 00:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7327229B8FD;
	Mon,  5 May 2025 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpkun8z/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A529B8F7;
	Mon,  5 May 2025 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484790; cv=none; b=rt6NIvtsq7AqaBN1BYPldEtjUvLd9hBRL0B7Gsn26yzQ4ASUlslqKEpTJVKxkHfD/eJZqD74QBinq9+AIPgLC/+EK43eW+89ggVC3Li0fPaOgvJFNjApX7zwM/VOOif2agoBCMgdWRSJJfLXzVO5L/ZSTkLHUgOOOfmK94lwVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484790; c=relaxed/simple;
	bh=gx+f2JnlMlN9IvhfTgnz6W6io2nmXicEhkcfqUxAJpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qMWJ/2Q4v4S/k26cpacelD7JM/nUkjW6XfM3Hr8oJQAEYAwnDqxkD6ngJ+JOlDNGtIPRrCO6XZL2U6PPW5qhbX5fp76Sr3E+O8EM2jKMZo5fZ42vPzjHR6YzFzmEeQwrEBS0ORyvRcLCojnrR+BGrbftSC8/ee1AyyarDvrWXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vpkun8z/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCB2C4CEED;
	Mon,  5 May 2025 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484790;
	bh=gx+f2JnlMlN9IvhfTgnz6W6io2nmXicEhkcfqUxAJpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vpkun8z/fTV8BZq5QxV6t0FI7iyAoI6Z0y1QOfrf5VE+4vdsyf82LW1WwhZuX9OrW
	 AzcBCwoNQ6a5WiMWA9WDSMmdxcH8FV9Mh2obZ2s2tAEax7bVyffU0u0rNaxSs8wok8
	 XnxnWhDYr1I65S1cmIYta/T+2vDDZH+U8rC17Hv4AWX+GMw1/U2H3ePHPDZ4VAHYAI
	 qS9GJxS6nnGtMm6yWNYse21ExMk7VxAW8krkGax1VzjSf9ufJyEUC7hpWGmjAjRlkY
	 QamOepwa/6ashzEDgofXniM0LuPYqoq0np58FMYZvVhQ47luvITzDbA/v9btqcPSSN
	 3TXHk987xpnCg==
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
Subject: [PATCH AUTOSEL 6.12 015/486] iommufd: Extend IOMMU_GET_HW_INFO to report PASID capability
Date: Mon,  5 May 2025 18:31:31 -0400
Message-Id: <20250505223922.2682012-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 3fd8920e79ffb..74480ae6bfc0b 100644
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
index 6afff1f1b1430..c331b108e71de 100644
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
index 8c4470742dcd9..41048271a0667 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -504,9 +504,17 @@ enum iommu_hw_info_type {
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
@@ -522,6 +530,9 @@ enum iommufd_hw_capabilities {
  *                 iommu_hw_info_type.
  * @out_capabilities: Output the generic iommu capability info type as defined
  *                    in the enum iommu_hw_capabilities.
+ * @out_max_pasid_log2: Output the width of PASIDs. 0 means no PASID support.
+ *                      PCI devices turn to out_capabilities to check if the
+ *                      specific capabilities is supported or not.
  * @__reserved: Must be 0
  *
  * Query an iommu type specific hardware information data from an iommu behind
@@ -545,7 +556,8 @@ struct iommu_hw_info {
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


