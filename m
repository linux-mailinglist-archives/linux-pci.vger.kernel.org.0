Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99004D0F70
	for <lists+linux-pci@lfdr.de>; Tue,  8 Mar 2022 06:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbiCHFse (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Mar 2022 00:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343696AbiCHFsa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2022 00:48:30 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E558C3C714;
        Mon,  7 Mar 2022 21:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646718443; x=1678254443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e4zKevnerCv3swR38QOP36pCi6FNMKl3EHNwss6IlEU=;
  b=gdrB9VixLNX2Jy8i+UZa0lYACHPx3bclNmNRIlh+cljcpfcQrViUMxok
   HfUGblqzsIptcqr/1UpfOyrNwf2LounkvG+j4kgHVCq+99kTOEc9HIfUn
   SXJIcQ4uHqBrT2N3cgMj2sOXUXoI+EGUJdZtx+Hm0FX8Qj5Nvxly3rsV4
   Lu2EKq/O+QUzohCUmhcYA9OYZbpHEvmFFsbuuL1zuBHOcPLJAgEj0QKns
   R1XDcPs/KdrSECzqmroPKShr/l75f1o+a8gIwKofEteWIpN8oSimuEazP
   j/Q/cYQ5xrXzCN9EyoeC2nDb7FvqCZ/NL5SLz4ejwgoIwwXezgwkgdCRH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="315314650"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="315314650"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:47:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="537430375"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 07 Mar 2022 21:47:16 -0800
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
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 11/11] iommu: Remove iommu group changes notifier
Date:   Tue,  8 Mar 2022 13:44:21 +0800
Message-Id: <20220308054421.847385-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308054421.847385-1-baolu.lu@linux.intel.com>
References: <20220308054421.847385-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The iommu group changes notifer is not referenced in the tree. Remove it
to avoid dead code.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/iommu.h | 23 -------------
 drivers/iommu/iommu.c | 75 -------------------------------------------
 2 files changed, 98 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 77972ef978b5..6ef2df258673 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -407,13 +407,6 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 	return dev->iommu->iommu_dev->ops;
 }
 
-#define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
-#define IOMMU_GROUP_NOTIFY_DEL_DEVICE		2 /* Pre Device removed */
-#define IOMMU_GROUP_NOTIFY_BIND_DRIVER		3 /* Pre Driver bind */
-#define IOMMU_GROUP_NOTIFY_BOUND_DRIVER		4 /* Post Driver bind */
-#define IOMMU_GROUP_NOTIFY_UNBIND_DRIVER	5 /* Pre Driver unbind */
-#define IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER	6 /* Post Driver unbind */
-
 extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern int bus_iommu_probe(struct bus_type *bus);
 extern bool iommu_present(struct bus_type *bus);
@@ -478,10 +471,6 @@ extern int iommu_group_for_each_dev(struct iommu_group *group, void *data,
 extern struct iommu_group *iommu_group_get(struct device *dev);
 extern struct iommu_group *iommu_group_ref_get(struct iommu_group *group);
 extern void iommu_group_put(struct iommu_group *group);
-extern int iommu_group_register_notifier(struct iommu_group *group,
-					 struct notifier_block *nb);
-extern int iommu_group_unregister_notifier(struct iommu_group *group,
-					   struct notifier_block *nb);
 extern int iommu_register_device_fault_handler(struct device *dev,
 					iommu_dev_fault_handler_t handler,
 					void *data);
@@ -878,18 +867,6 @@ static inline void iommu_group_put(struct iommu_group *group)
 {
 }
 
-static inline int iommu_group_register_notifier(struct iommu_group *group,
-						struct notifier_block *nb)
-{
-	return -ENODEV;
-}
-
-static inline int iommu_group_unregister_notifier(struct iommu_group *group,
-						  struct notifier_block *nb)
-{
-	return 0;
-}
-
 static inline
 int iommu_register_device_fault_handler(struct device *dev,
 					iommu_dev_fault_handler_t handler,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index eba8e8ccf19d..0c42ece25854 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -18,7 +18,6 @@
 #include <linux/errno.h>
 #include <linux/iommu.h>
 #include <linux/idr.h>
-#include <linux/notifier.h>
 #include <linux/err.h>
 #include <linux/pci.h>
 #include <linux/bitops.h>
@@ -40,7 +39,6 @@ struct iommu_group {
 	struct kobject *devices_kobj;
 	struct list_head devices;
 	struct mutex mutex;
-	struct blocking_notifier_head notifier;
 	void *iommu_data;
 	void (*iommu_data_release)(void *iommu_data);
 	char *name;
@@ -632,7 +630,6 @@ struct iommu_group *iommu_group_alloc(void)
 	mutex_init(&group->mutex);
 	INIT_LIST_HEAD(&group->devices);
 	INIT_LIST_HEAD(&group->entry);
-	BLOCKING_INIT_NOTIFIER_HEAD(&group->notifier);
 
 	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
@@ -905,10 +902,6 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	if (ret)
 		goto err_put_group;
 
-	/* Notify any listeners about change to group. */
-	blocking_notifier_call_chain(&group->notifier,
-				     IOMMU_GROUP_NOTIFY_ADD_DEVICE, dev);
-
 	trace_add_device_to_group(group->id, dev);
 
 	dev_info(dev, "Adding to iommu group %d\n", group->id);
@@ -950,10 +943,6 @@ void iommu_group_remove_device(struct device *dev)
 
 	dev_info(dev, "Removing from iommu group %d\n", group->id);
 
-	/* Pre-notify listeners that a device is being removed. */
-	blocking_notifier_call_chain(&group->notifier,
-				     IOMMU_GROUP_NOTIFY_DEL_DEVICE, dev);
-
 	mutex_lock(&group->mutex);
 	list_for_each_entry(tmp_device, &group->devices, list) {
 		if (tmp_device->dev == dev) {
@@ -1075,36 +1064,6 @@ void iommu_group_put(struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_group_put);
 
-/**
- * iommu_group_register_notifier - Register a notifier for group changes
- * @group: the group to watch
- * @nb: notifier block to signal
- *
- * This function allows iommu group users to track changes in a group.
- * See include/linux/iommu.h for actions sent via this notifier.  Caller
- * should hold a reference to the group throughout notifier registration.
- */
-int iommu_group_register_notifier(struct iommu_group *group,
-				  struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&group->notifier, nb);
-}
-EXPORT_SYMBOL_GPL(iommu_group_register_notifier);
-
-/**
- * iommu_group_unregister_notifier - Unregister a notifier
- * @group: the group to watch
- * @nb: notifier block to signal
- *
- * Unregister a previously registered group notifier block.
- */
-int iommu_group_unregister_notifier(struct iommu_group *group,
-				    struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&group->notifier, nb);
-}
-EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
-
 /**
  * iommu_register_device_fault_handler() - Register a device fault handler
  * @dev: the device
@@ -1650,14 +1609,8 @@ static int remove_iommu_group(struct device *dev, void *data)
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data)
 {
-	unsigned long group_action = 0;
 	struct device *dev = data;
-	struct iommu_group *group;
 
-	/*
-	 * ADD/DEL call into iommu driver ops if provided, which may
-	 * result in ADD/DEL notifiers to group->notifier
-	 */
 	if (action == BUS_NOTIFY_ADD_DEVICE) {
 		int ret;
 
@@ -1668,34 +1621,6 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 		return NOTIFY_OK;
 	}
 
-	/*
-	 * Remaining BUS_NOTIFYs get filtered and republished to the
-	 * group, if anyone is listening
-	 */
-	group = iommu_group_get(dev);
-	if (!group)
-		return 0;
-
-	switch (action) {
-	case BUS_NOTIFY_BIND_DRIVER:
-		group_action = IOMMU_GROUP_NOTIFY_BIND_DRIVER;
-		break;
-	case BUS_NOTIFY_BOUND_DRIVER:
-		group_action = IOMMU_GROUP_NOTIFY_BOUND_DRIVER;
-		break;
-	case BUS_NOTIFY_UNBIND_DRIVER:
-		group_action = IOMMU_GROUP_NOTIFY_UNBIND_DRIVER;
-		break;
-	case BUS_NOTIFY_UNBOUND_DRIVER:
-		group_action = IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER;
-		break;
-	}
-
-	if (group_action)
-		blocking_notifier_call_chain(&group->notifier,
-					     group_action, dev);
-
-	iommu_group_put(group);
 	return 0;
 }
 
-- 
2.25.1

