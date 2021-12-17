Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34AD478526
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 07:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhLQGis (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 01:38:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:50426 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233421AbhLQGis (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Dec 2021 01:38:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300467728"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="300467728"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 22:38:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="519623361"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 16 Dec 2021 22:38:39 -0800
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
Subject: [PATCH v4 09/13] vfio: Remove use of vfio_group_viable()
Date:   Fri, 17 Dec 2021 14:37:04 +0800
Message-Id: <20211217063708.1740334-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As DMA USER ownership is claimed for the iommu group when a vfio group is
added to a vfio container, the vfio group viability is guaranteed as long
as group->container_users > 0. Remove those unnecessary group viability
checks which are only hit when group->container_users is not zero.

The only remaining reference is in GROUP_GET_STATUS, which could be called
at any time when group fd is valid. Here we just replace the
vfio_group_viable() by directly calling iommu core to get viability status.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index b75ba7551079..241756b85705 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1316,12 +1316,6 @@ static int vfio_group_set_container(struct vfio_group *group, int container_fd)
 	return ret;
 }
 
-static bool vfio_group_viable(struct vfio_group *group)
-{
-	return (iommu_group_for_each_dev(group->iommu_group,
-					 group, vfio_dev_viable) == 0);
-}
-
 static int vfio_group_add_container_user(struct vfio_group *group)
 {
 	if (!atomic_inc_not_zero(&group->container_users))
@@ -1331,7 +1325,7 @@ static int vfio_group_add_container_user(struct vfio_group *group)
 		atomic_dec(&group->container_users);
 		return -EPERM;
 	}
-	if (!group->container->iommu_driver || !vfio_group_viable(group)) {
+	if (!group->container->iommu_driver) {
 		atomic_dec(&group->container_users);
 		return -EINVAL;
 	}
@@ -1349,7 +1343,7 @@ static int vfio_group_get_device_fd(struct vfio_group *group, char *buf)
 	int ret = 0;
 
 	if (0 == atomic_read(&group->container_users) ||
-	    !group->container->iommu_driver || !vfio_group_viable(group))
+	    !group->container->iommu_driver)
 		return -EINVAL;
 
 	if (group->type == VFIO_NO_IOMMU && !capable(CAP_SYS_RAWIO))
@@ -1441,11 +1435,11 @@ static long vfio_group_fops_unl_ioctl(struct file *filep,
 
 		status.flags = 0;
 
-		if (vfio_group_viable(group))
-			status.flags |= VFIO_GROUP_FLAGS_VIABLE;
-
 		if (group->container)
-			status.flags |= VFIO_GROUP_FLAGS_CONTAINER_SET;
+			status.flags |= VFIO_GROUP_FLAGS_CONTAINER_SET |
+					VFIO_GROUP_FLAGS_VIABLE;
+		else if (iommu_group_dma_owner_unclaimed(group->iommu_group))
+			status.flags |= VFIO_GROUP_FLAGS_VIABLE;
 
 		if (copy_to_user((void __user *)arg, &status, minsz))
 			return -EFAULT;
-- 
2.25.1

