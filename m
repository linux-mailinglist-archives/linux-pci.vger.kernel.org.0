Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795D9468ED9
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 03:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhLFCEi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Dec 2021 21:04:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:22679 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232918AbhLFCEV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 5 Dec 2021 21:04:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="224483035"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="224483035"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 18:00:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="514542516"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2021 18:00:41 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Li Yang <leoyang.li@nxp.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 11/18] iommu: Expose group variants of dma ownership interfaces
Date:   Mon,  6 Dec 2021 09:58:56 +0800
Message-Id: <20211206015903.88687-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206015903.88687-1-baolu.lu@linux.intel.com>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The vfio needs to set DMA_OWNER_PRIVATE_DOMAIN_USER for the entire group
when attaching it to a vfio container. Expose group variants of setting/
releasing dma ownership for this purpose.

This also exposes the helper iommu_group_dma_owner_unclaimed() for vfio
to report to userspace if the group is viable to user assignment for
compatibility with VFIO_GROUP_FLAGS_VIABLE.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 21 ++++++++++++++++
 drivers/iommu/iommu.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 24676b498f38..afcc07bc8d41 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -701,6 +701,10 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle);
 int iommu_device_set_dma_owner(struct device *dev, enum iommu_dma_owner owner,
 			       void *owner_cookie);
 void iommu_device_release_dma_owner(struct device *dev, enum iommu_dma_owner owner);
+int iommu_group_set_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner,
+			      void *owner_cookie);
+void iommu_group_release_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner);
+bool iommu_group_dma_owner_unclaimed(struct iommu_group *group);
 
 #else /* CONFIG_IOMMU_API */
 
@@ -1117,6 +1121,23 @@ static inline void iommu_device_release_dma_owner(struct device *dev,
 						  enum iommu_dma_owner owner)
 {
 }
+
+static inline int iommu_group_set_dma_owner(struct iommu_group *group,
+					    enum iommu_dma_owner owner,
+					    void *owner_cookie)
+{
+	return -EINVAL;
+}
+
+static inline void iommu_group_release_dma_owner(struct iommu_group *group,
+						 enum iommu_dma_owner owner)
+{
+}
+
+static inline bool iommu_group_dma_owner_unclaimed(struct iommu_group *group)
+{
+	return false;
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0cba04a8ea3b..423197db99a9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3425,6 +3425,64 @@ static void __iommu_group_release_dma_owner(struct iommu_group *group,
 	}
 }
 
+/**
+ * iommu_group_set_dma_owner() - Set DMA ownership of a group
+ * @group: The group.
+ * @owner: DMA owner type.
+ * @owner_cookie: Caller specified pointer. Could be used for exclusive
+ *                declaration. Could be NULL.
+ *
+ * This is to support backward compatibility for legacy vfio which manages
+ * dma ownership in group level. New invocations on this interface should be
+ * prohibited. Instead, please turn to iommu_device_set_dma_owner().
+ */
+int iommu_group_set_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner,
+			      void *owner_cookie)
+{
+	int ret;
+
+	mutex_lock(&group->mutex);
+	ret = __iommu_group_set_dma_owner(group, owner, owner_cookie);
+	mutex_unlock(&group->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_group_set_dma_owner);
+
+/**
+ * iommu_group_release_dma_owner() - Release DMA ownership of a group
+ * @group: The group.
+ * @owner: DMA owner type.
+ *
+ * Release the DMA ownership claimed by iommu_group_set_dma_owner().
+ */
+void iommu_group_release_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner)
+{
+	mutex_lock(&group->mutex);
+	__iommu_group_release_dma_owner(group, owner);
+	mutex_unlock(&group->mutex);
+}
+EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
+
+/**
+ * iommu_group_dma_owner_unclaimed() - Is group dma ownership claimed
+ * @group: The group.
+ *
+ * This provides status check on a given group. It is racey and only for
+ * non-binding status reporting.
+ */
+bool iommu_group_dma_owner_unclaimed(struct iommu_group *group)
+{
+	enum iommu_dma_owner owner;
+
+	mutex_lock(&group->mutex);
+	owner = group->dma_owner;
+	mutex_unlock(&group->mutex);
+
+	return owner == DMA_OWNER_NONE;
+}
+EXPORT_SYMBOL_GPL(iommu_group_dma_owner_unclaimed);
+
 /**
  * iommu_device_set_dma_owner() - Set DMA ownership of a device
  * @dev: The device.
-- 
2.25.1

