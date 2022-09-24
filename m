Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE69B5E86A9
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 02:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiIXATE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 20:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiIXASe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 20:18:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A5913B010;
        Fri, 23 Sep 2022 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663978712; x=1695514712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9KEVQgp8MCwDeUciNf14XJVl7Lj4A7PPEtyBWdQMqwE=;
  b=hfLSJiOSCiiP9wBUuHLoaIhDMu6zQMZzJ0DaPog0bSWhfVXFt05fDcjB
   wptjDAFFoZYcRi9c9aJOPAu6Pd6Z/ZQuGGMCEVTOXWfUBwDiG5Z84H0Df
   IjEb0xLe7Q7+DW8UZY/995z1y61K/4YI2P8Hb5HBH1W20gW0SCPM4qTAj
   roUdH8rDv1IpDjhSftsfC7KhSxG3X2/RtzG7gLIlu87ob67clXq6wRNBp
   QdfLdOrI8BiIS6ThxU3rtbUP07wWEz9PjWq+zxFy4oYWxSsYgcMA+6BRc
   rfP0sxk2Ynj3AaM0dX/uzEW28Y5Wng6gn2bB8EXqzP8RlTlecSshNOJ4e
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="281090424"
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="281090424"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 17:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="682856872"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2022 17:18:27 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v14 05/13] iommu: Add attach/detach_dev_pasid iommu interfaces
Date:   Sat, 24 Sep 2022 08:11:56 +0800
Message-Id: <20220924001204.4005613-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924001204.4005613-1-baolu.lu@linux.intel.com>
References: <20220924001204.4005613-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Attaching an IOMMU domain to a PASID of a device is a generic operation
for modern IOMMU drivers which support PASID-granular DMA address
translation. Currently visible usage scenarios include (but not limited):

 - SVA (Shared Virtual Address)
 - kernel DMA with PASID
 - hardware-assist mediated device

This adds the set_dev_pasid domain ops for setting the domain onto a
PASID of a device and remove_dev_pasid iommu ops for removing any setup
on a PASID of device. This also adds interfaces for device drivers to
attach/detach/retrieve a domain for a PASID of a device.

If multiple devices share a single group, it's fine as long the fabric
always routes every TLP marked with a PASID to the host bridge and only
the host bridge. For example, ACS achieves this universally and has been
checked when pci_enable_pasid() is called. As we can't reliably tell the
source apart in a group, all the devices in a group have to be considered
as the same source, and mapped to the same PASID table.

The DMA ownership is about the whole device (more precisely, iommu group),
including the RID and PASIDs. When the ownership is converted, the pasid
array must be empty. This also adds necessary checks in the DMA ownership
interfaces.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 include/linux/iommu.h |  32 ++++++++++
 drivers/iommu/iommu.c | 141 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 169 insertions(+), 4 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 72bb0531aa76..5d2b78ac5416 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -223,6 +223,9 @@ struct iommu_iotlb_gather {
  *		- IOMMU_DOMAIN_DMA: must use a dma domain
  *		- 0: use the default setting
  * @default_domain_ops: the default ops for domains
+ * @remove_dev_pasid: Remove any translation configurations of a specific
+ *                    pasid, so that any DMA transactions with this pasid
+ *                    will be blocked by the hardware.
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  */
@@ -256,6 +259,7 @@ struct iommu_ops {
 			     struct iommu_page_response *msg);
 
 	int (*def_domain_type)(struct device *dev);
+	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
@@ -266,6 +270,7 @@ struct iommu_ops {
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
  * @detach_dev: detach an iommu domain from a device
+ * @set_dev_pasid: set an iommu domain to a pasid of device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
  *             an iommu domain.
@@ -286,6 +291,8 @@ struct iommu_ops {
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
+			     ioasid_t pasid);
 
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
@@ -678,6 +685,13 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid);
+void iommu_detach_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid);
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
+			       unsigned int type);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1040,6 +1054,24 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 {
 	return false;
 }
+
+static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
+					    struct device *dev, ioasid_t pasid)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
+					     struct device *dev, ioasid_t pasid)
+{
+}
+
+static inline struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
+			       unsigned int type)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a94ec648c88b..bf22992beb98 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -43,6 +43,7 @@ struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
 	struct list_head devices;
+	struct xarray pasid_array;
 	struct mutex mutex;
 	void *iommu_data;
 	void (*iommu_data_release)(void *iommu_data);
@@ -723,6 +724,7 @@ struct iommu_group *iommu_group_alloc(void)
 	mutex_init(&group->mutex);
 	INIT_LIST_HEAD(&group->devices);
 	INIT_LIST_HEAD(&group->entry);
+	xa_init(&group->pasid_array);
 
 	ret = ida_alloc(&iommu_group_ida, GFP_KERNEL);
 	if (ret < 0) {
@@ -3106,7 +3108,8 @@ int iommu_device_use_default_domain(struct device *dev)
 
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {
-		if (group->owner || !iommu_is_default_domain(group)) {
+		if (group->owner || !iommu_is_default_domain(group) ||
+		    !xa_empty(&group->pasid_array)) {
 			ret = -EBUSY;
 			goto unlock_out;
 		}
@@ -3137,7 +3140,7 @@ void iommu_device_unuse_default_domain(struct device *dev)
 		return;
 
 	mutex_lock(&group->mutex);
-	if (!WARN_ON(!group->owner_cnt))
+	if (!WARN_ON(!group->owner_cnt || !xa_empty(&group->pasid_array)))
 		group->owner_cnt--;
 
 	mutex_unlock(&group->mutex);
@@ -3185,7 +3188,8 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
 		ret = -EPERM;
 		goto unlock_out;
 	} else {
-		if (group->domain && group->domain != group->default_domain) {
+		if ((group->domain && group->domain != group->default_domain) ||
+		    !xa_empty(&group->pasid_array)) {
 			ret = -EBUSY;
 			goto unlock_out;
 		}
@@ -3219,7 +3223,8 @@ void iommu_group_release_dma_owner(struct iommu_group *group)
 	int ret;
 
 	mutex_lock(&group->mutex);
-	if (WARN_ON(!group->owner_cnt || !group->owner))
+	if (WARN_ON(!group->owner_cnt || !group->owner ||
+		    !xa_empty(&group->pasid_array)))
 		goto unlock_out;
 
 	group->owner_cnt = 0;
@@ -3250,3 +3255,131 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 	return user;
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
+
+static int __iommu_set_group_pasid(struct iommu_domain *domain,
+				   struct iommu_group *group, ioasid_t pasid)
+{
+	struct group_device *device;
+	int ret = 0;
+
+	list_for_each_entry(device, &group->devices, list) {
+		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static void __iommu_remove_group_pasid(struct iommu_group *group,
+				       ioasid_t pasid)
+{
+	struct group_device *device;
+	const struct iommu_ops *ops;
+
+	list_for_each_entry(device, &group->devices, list) {
+		ops = dev_iommu_ops(device->dev);
+		ops->remove_dev_pasid(device->dev, pasid);
+	}
+}
+
+/*
+ * iommu_attach_device_pasid() - Attach a domain to pasid of device
+ * @domain: the iommu domain.
+ * @dev: the attached device.
+ * @pasid: the pasid of the device.
+ *
+ * Return: 0 on success, or an error.
+ */
+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid)
+{
+	struct iommu_group *group;
+	void *curr;
+	int ret;
+
+	if (!domain->ops->set_dev_pasid)
+		return -EOPNOTSUPP;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
+	mutex_lock(&group->mutex);
+	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
+	if (curr) {
+		ret = xa_err(curr) ? : -EBUSY;
+		goto out_unlock;
+	}
+
+	ret = __iommu_set_group_pasid(domain, group, pasid);
+	if (ret) {
+		__iommu_remove_group_pasid(group, pasid);
+		xa_erase(&group->pasid_array, pasid);
+	}
+out_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
+
+/*
+ * iommu_detach_device_pasid() - Detach the domain from pasid of device
+ * @domain: the iommu domain.
+ * @dev: the attached device.
+ * @pasid: the pasid of the device.
+ *
+ * The @domain must have been attached to @pasid of the @dev with
+ * iommu_attach_device_pasid().
+ */
+void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
+			       ioasid_t pasid)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+
+	mutex_lock(&group->mutex);
+	__iommu_remove_group_pasid(group, pasid);
+	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);
+	mutex_unlock(&group->mutex);
+
+	iommu_group_put(group);
+}
+EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
+
+/*
+ * iommu_get_domain_for_dev_pasid() - Retrieve domain for @pasid of @dev
+ * @dev: the queried device
+ * @pasid: the pasid of the device
+ * @type: matched domain type, 0 for any match
+ *
+ * This is a variant of iommu_get_domain_for_dev(). It returns the existing
+ * domain attached to pasid of a device. Callers must hold a lock around this
+ * function, and both iommu_attach/detach_dev_pasid() whenever a domain of
+ * type is being manipulated. This API does not internally resolve races with
+ * attach/detach.
+ *
+ * Return: attached domain on success, NULL otherwise.
+ */
+struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
+						    ioasid_t pasid,
+						    unsigned int type)
+{
+	struct iommu_domain *domain;
+	struct iommu_group *group;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return NULL;
+
+	xa_lock(&group->pasid_array);
+	domain = xa_load(&group->pasid_array, pasid);
+	if (type && domain && domain->type != type)
+		domain = ERR_PTR(-EBUSY);
+	xa_unlock(&group->pasid_array);
+	iommu_group_put(group);
+
+	return domain;
+}
+EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev_pasid);
-- 
2.34.1

