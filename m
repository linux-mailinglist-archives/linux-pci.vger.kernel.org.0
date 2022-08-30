Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C645A5CEF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 09:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiH3HbS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 03:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiH3Hay (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 03:30:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1201785A2;
        Tue, 30 Aug 2022 00:30:35 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MGzSZ13jtzHnY8;
        Tue, 30 Aug 2022 15:28:46 +0800 (CST)
Received: from [10.174.178.41] (10.174.178.41) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 15:30:31 +0800
Message-ID: <47879368-fb4e-79aa-35f9-018d871f013c@huawei.com>
Date:   Tue, 30 Aug 2022 15:30:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v12 13/17] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, <iommu@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-14-baolu.lu@linux.intel.com>
From:   Yuan Can <yuancan@huawei.com>
In-Reply-To: <20220826121141.50743-14-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.41]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2022/8/26 20:11, Lu Baolu 写道:
> The existing iommu SVA interfaces are implemented by calling the SVA
> specific iommu ops provided by the IOMMU drivers. There's no need for
> any SVA specific ops in iommu_ops vector anymore as we can achieve
> this through the generic attach/detach_dev_pasid domain ops.
>
> This refactors the IOMMU SVA interfaces implementation by using the
> iommu_detach/detach_device_pasid interfaces and align them with the

Did you mean using the iommu_attach/detach_device_pasid interfaces here?

Thanks,

Yuan Can

> concept of the SVA iommu domain. Put the new SVA code in the SVA
> related file in order to make it self-contained.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>   include/linux/iommu.h         |  43 ++++++-------
>   drivers/iommu/iommu-sva-lib.c | 110 ++++++++++++++++++++++++++++++++++
>   drivers/iommu/iommu.c         |  91 ----------------------------
>   3 files changed, 133 insertions(+), 111 deletions(-)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 836aa480961c..5b1e0f81eebb 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -643,6 +643,7 @@ struct iommu_fwspec {
>    */
>   struct iommu_sva {
>   	struct device			*dev;
> +	struct iommu_domain		*domain;
>   };
>   
>   int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
> @@ -684,11 +685,6 @@ void iommu_release_device(struct device *dev);
>   int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
>   int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
>   
> -struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> -					struct mm_struct *mm);
> -void iommu_sva_unbind_device(struct iommu_sva *handle);
> -u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> -
>   int iommu_device_use_default_domain(struct device *dev);
>   void iommu_device_unuse_default_domain(struct device *dev);
>   
> @@ -1029,21 +1025,6 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
>   	return -ENODEV;
>   }
>   
> -static inline struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> -{
> -	return NULL;
> -}
> -
> -static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
> -{
> -}
> -
> -static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	return IOMMU_PASID_INVALID;
> -}
> -
>   static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
>   {
>   	return NULL;
> @@ -1121,4 +1102,26 @@ void iommu_debugfs_setup(void);
>   static inline void iommu_debugfs_setup(void) {}
>   #endif
>   
> +#ifdef CONFIG_IOMMU_SVA
> +struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> +					struct mm_struct *mm);
> +void iommu_sva_unbind_device(struct iommu_sva *handle);
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> +#else
> +static inline struct iommu_sva *
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> +{
> +	return NULL;
> +}
> +
> +static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
> +{
> +}
> +
> +static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> +{
> +	return IOMMU_PASID_INVALID;
> +}
> +#endif /* CONFIG_IOMMU_SVA */
> +
>   #endif /* __LINUX_IOMMU_H */
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 106506143896..197f68602439 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -4,6 +4,7 @@
>    */
>   #include <linux/mutex.h>
>   #include <linux/sched/mm.h>
> +#include <linux/iommu.h>
>   
>   #include "iommu-sva-lib.h"
>   
> @@ -69,3 +70,112 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>   	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_find);
> +
> +/**
> + * iommu_sva_bind_device() - Bind a process address space to a device
> + * @dev: the device
> + * @mm: the mm to bind, caller must hold a reference to mm_users
> + *
> + * Create a bond between device and address space, allowing the device to access
> + * the mm using the returned PASID. If a bond already exists between @device and
> + * @mm, it is returned and an additional reference is taken. Caller must call
> + * iommu_sva_unbind_device() to release each reference.
> + *
> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> + * initialize the required SVA features.
> + *
> + * On error, returns an ERR_PTR value.
> + */
> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_sva *handle;
> +	ioasid_t max_pasids;
> +	int ret;
> +
> +	max_pasids = dev->iommu->max_pasids;
> +	if (!max_pasids)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	/* Allocate mm->pasid if necessary. */
> +	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> +	if (!handle)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_lock(&iommu_sva_lock);
> +	/* Search for an existing domain. */
> +	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
> +						IOMMU_DOMAIN_SVA);
> +	if (IS_ERR(domain)) {
> +		ret = PTR_ERR(domain);
> +		goto out_unlock;
> +	}
> +
> +	if (domain) {
> +		domain->users++;
> +		goto out;
> +	}
> +
> +	/* Allocate a new domain and set it on device pasid. */
> +	domain = iommu_sva_domain_alloc(dev, mm);
> +	if (!domain) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
> +	if (ret)
> +		goto out_free_domain;
> +	domain->users = 1;
> +out:
> +	mutex_unlock(&iommu_sva_lock);
> +	handle->dev = dev;
> +	handle->domain = domain;
> +
> +	return handle;
> +
> +out_free_domain:
> +	iommu_domain_free(domain);
> +out_unlock:
> +	mutex_unlock(&iommu_sva_lock);
> +	kfree(handle);
> +
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
> +
> +/**
> + * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
> + * @handle: the handle returned by iommu_sva_bind_device()
> + *
> + * Put reference to a bond between device and address space. The device should
> + * not be issuing any more transaction for this PASID. All outstanding page
> + * requests for this PASID must have been flushed to the IOMMU.
> + */
> +void iommu_sva_unbind_device(struct iommu_sva *handle)
> +{
> +	struct iommu_domain *domain = handle->domain;
> +	ioasid_t pasid = domain->mm->pasid;
> +	struct device *dev = handle->dev;
> +
> +	mutex_lock(&iommu_sva_lock);
> +	if (--domain->users == 0) {
> +		iommu_detach_device_pasid(domain, dev, pasid);
> +		iommu_domain_free(domain);
> +	}
> +	mutex_unlock(&iommu_sva_lock);
> +	kfree(handle);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
> +
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> +{
> +	struct iommu_domain *domain = handle->domain;
> +
> +	return domain->mm->pasid;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 630e1b64ed89..1119fe39e842 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2785,97 +2785,6 @@ int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
>   }
>   EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
>   
> -/**
> - * iommu_sva_bind_device() - Bind a process address space to a device
> - * @dev: the device
> - * @mm: the mm to bind, caller must hold a reference to it
> - *
> - * Create a bond between device and address space, allowing the device to access
> - * the mm using the returned PASID. If a bond already exists between @device and
> - * @mm, it is returned and an additional reference is taken. Caller must call
> - * iommu_sva_unbind_device() to release each reference.
> - *
> - * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> - * initialize the required SVA features.
> - *
> - * On error, returns an ERR_PTR value.
> - */
> -struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> -{
> -	struct iommu_group *group;
> -	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> -	if (!ops->sva_bind)
> -		return ERR_PTR(-ENODEV);
> -
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		return ERR_PTR(-ENODEV);
> -
> -	/* Ensure device count and domain don't change while we're binding */
> -	mutex_lock(&group->mutex);
> -
> -	/*
> -	 * To keep things simple, SVA currently doesn't support IOMMU groups
> -	 * with more than one device. Existing SVA-capable systems are not
> -	 * affected by the problems that required IOMMU groups (lack of ACS
> -	 * isolation, device ID aliasing and other hardware issues).
> -	 */
> -	if (iommu_group_device_count(group) != 1)
> -		goto out_unlock;
> -
> -	handle = ops->sva_bind(dev, mm);
> -
> -out_unlock:
> -	mutex_unlock(&group->mutex);
> -	iommu_group_put(group);
> -
> -	return handle;
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
> -
> -/**
> - * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
> - * @handle: the handle returned by iommu_sva_bind_device()
> - *
> - * Put reference to a bond between device and address space. The device should
> - * not be issuing any more transaction for this PASID. All outstanding page
> - * requests for this PASID must have been flushed to the IOMMU.
> - */
> -void iommu_sva_unbind_device(struct iommu_sva *handle)
> -{
> -	struct iommu_group *group;
> -	struct device *dev = handle->dev;
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> -	if (!ops->sva_unbind)
> -		return;
> -
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		return;
> -
> -	mutex_lock(&group->mutex);
> -	ops->sva_unbind(handle);
> -	mutex_unlock(&group->mutex);
> -
> -	iommu_group_put(group);
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
> -
> -u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	const struct iommu_ops *ops = dev_iommu_ops(handle->dev);
> -
> -	if (!ops->sva_get_pasid)
> -		return IOMMU_PASID_INVALID;
> -
> -	return ops->sva_get_pasid(handle);
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> -
>   /*
>    * Changes the default domain of an iommu group that has *only* one device
>    *
