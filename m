Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1ED5A94F1
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 12:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIAKod (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 06:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiIAKoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 06:44:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C93A50E2;
        Thu,  1 Sep 2022 03:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662029070; x=1693565070;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z0nHhpyQNt/z52vG9scDUVjFGYLIq163jnyWrsCmkKM=;
  b=E3arJ6qadWEYD0diCEPq6xV64YIKNgV2JiG1RU8ewLRtCzryM01OPcGg
   MIZx52ld0q0dDOP5eLa5Op82Ejlnz1YL3ClRY9qfR0ECE++qEJ4vr9KlN
   QkqgGUzdaupzBZm/q5HCYe+CtlQoFZNygLugkWt9xyjIePebV8Y4GTwKE
   eUZYDLZGb53NPc2e3+jbpbvNAnb53jT0b9Xl3RmK5NQCaisRFPUxnyYWp
   9YYFpwLscm/ZatzJMt8fs1JFG5Fuj9qZEAHpjqa1yqBykrHnEk5Tdz8x9
   cPpGHVpZAQRVYJ3QRJS1vOYM/+csFDGX87PAgCXcU1JtbWgbF3wPu8lM9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="278698819"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="278698819"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 03:44:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="673795597"
Received: from luli3-mobl.ccr.corp.intel.com (HELO [10.254.215.169]) ([10.254.215.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 03:44:25 -0700
Message-ID: <53837119-9348-f9c9-1f49-cad639fc6ecd@linux.intel.com>
Date:   Thu, 1 Sep 2022 18:44:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 07/17] iommu: Try to allocate blocking domain when
 probing device
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-8-baolu.lu@linux.intel.com>
 <YwjeL2SVmdRpoWb6@nvidia.com>
 <316f6575-59ea-08e3-aaaf-bc1e4f42a574@linux.intel.com>
 <Ywz3A3tHEzY+Sf7b@nvidia.com>
 <c7d71936-ea06-3a71-d13a-cedd108413b5@linux.intel.com>
 <Yw4Qzif8W53ykR6K@nvidia.com>
 <c46ec383-bd51-1d78-ff81-0bee064ce1cb@linux.intel.com>
 <Yw9rwktDY9Uca/cv@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yw9rwktDY9Uca/cv@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/8/31 22:10, Jason Gunthorpe wrote:
> On Wed, Aug 31, 2022 at 09:49:44AM +0800, Baolu Lu wrote:
>>> Maybe all of this is just the good reason to go to a simple
>>> device->ops->remove_dev_pasid() callback and forget about blocking
>>> domain here.
>>
>> Do you mean rolling back to what we did in v10?
> 
> Yeah, but it shouldn't be a domain_op, removing a pasid is a device op
> 
> Just
> 
> remove_dev_pasid(struct device *dev, ioasid_t pasid)

It's clear now. Thanks!

How about below iommu_attach/detach_device_pasid() code?

By the way, how about naming it "block_dev_pasid(dev, pasid)"?

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
+void iommu_detach_device_pasid(struct iommu_domain *domain, struct 
device *dev,
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

Best regards,
baolu
