Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD75A73A1
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 03:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiHaBzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 21:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiHaBzW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 21:55:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A1618B1C;
        Tue, 30 Aug 2022 18:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661910920; x=1693446920;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l+v5nIzqNowIXrnsEe2OWOgaFIqkzsPW8wkup2CzvX4=;
  b=ArSlX/1fGB/Ic94c5sZ73PxXA1jcnJ16nIuknjQOwF5+OOUiZ0kOUu5J
   jvN74LBGQzBgxu8DvwetvZHzHBNtP7l1BaiAsSFJ5nUqo6MtG0ilgPubM
   QaRNvJtTteWQ65Cfu7DAfN9F6ubVLnjwufPsiOH2y4sgpErkQWnIvWOq8
   7oPiGo6yyUgQCnlfCxfQg8AHNmeOdu/xeiOm4rCabOcp0W4cxoaXcyT5F
   COy7YSsaAfqezu91G5OLp+c1mKrUKA3llvglPGdeAcd9HVXj0tdmzxy6T
   q1+nHR2bxlerGxu9M5jGIoWAh8ViMRFLDOZX1lnlzND2t5FFgOhipIVFf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296134231"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="296134231"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 18:55:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="608049835"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Aug 2022 18:55:15 -0700
Message-ID: <c46ec383-bd51-1d78-ff81-0bee064ce1cb@linux.intel.com>
Date:   Wed, 31 Aug 2022 09:49:44 +0800
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
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yw4Qzif8W53ykR6K@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/30/22 9:29 PM, Jason Gunthorpe wrote:
> On Tue, Aug 30, 2022 at 09:46:01AM +0800, Baolu Lu wrote:
>> On 2022/8/30 01:27, Jason Gunthorpe wrote:
>>> On Mon, Aug 29, 2022 at 11:40:24AM +0800, Baolu Lu wrote:
>>>> On 2022/8/26 22:52, Jason Gunthorpe wrote:
>>>>> On Fri, Aug 26, 2022 at 08:11:31PM +0800, Lu Baolu wrote:
>>>>>> Allocate the blocking domain when probing devices if the driver supports
>>>>>> blocking domain allocation. Otherwise, revert to the previous behavior,
>>>>>> that is, use UNMANAGED domain instead when the blocking domain is needed.
>>>>>>
>>>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>>>> Tested-by: Zhangfei Gao<zhangfei.gao@linaro.org>
>>>>>> Tested-by: Tony Zhu<tony.zhu@intel.com>
>>>>>> ---
>>>>>>     drivers/iommu/iommu.c | 29 +++++++++++++++++------------
>>>>>>     1 file changed, 17 insertions(+), 12 deletions(-)
>>>>> This seems like a lot of overhead to allocate these things for every
>>>>> group?
>>>>>
>>>>> Why not add a simple refcount on the blocking domain instead and
>>>>> allocate the domain on the pasid attach like we do for ownership?
>>>>
>>>> I am working towards implementing static instance of blocking domain for
>>>> each IOMMU driver, and then, there's no much overhead to allocate it in
>>>> the probing device path.
>>>
>>> Well, I thought about that and I don't think we can get
>>> there in a short order.
>>
>> Yes. Fair enough.
>>
>>> Would rather you progress this series without
>>> getting entangled in such a big adventure
>>
>> Agreed. I will drop this patch and add below code in the iommu
>> interface:
>>
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3219,6 +3219,26 @@ int iommu_attach_device_pasid(struct iommu_domain
>> *domain,
>>                  return -ENODEV;
>>
>>          mutex_lock(&group->mutex);
>> +
>> +       /*
>> +        * The underlying IOMMU driver needs to support blocking domain
>> +        * allocation and the callback to block DMA transactions with a
>> +        * specific PASID.
>> +        */
>> +       if (!group->blocking_domain) {
>> +               group->blocking_domain = __iommu_domain_alloc(dev->bus,
>> +                               IOMMU_DOMAIN_BLOCKED);
>> +               if (!group->blocking_domain) {
>> +                       ret = -ENODEV;
>> +                       goto out_unlock;
>> +               }
>> +       }
>> +
>> +       if (!group->blocking_domain->ops->set_dev_pasid) {
>> +               ret = -EOPNOTSUPP;
>> +               goto out_unlock;
>> +       }
>> +
>>          curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain,
>> GFP_KERNEL);
>>          if (curr) {
>>                  ret = xa_err(curr) ? : -EBUSY;
>>
>> Currently both ARM SMMUv3 and VT-d drivers use static blocking domain.
>> Hence I didn't use a refcount for blocking domain release here.
> 
> I don't think that works in the general case, you can't just destroy
> what is in group->blocking_domain..

If I understand you correctly, we can't just free the blocking domain
and forget about whether this domain is still set on any device?

> 
> Maybe all of this is just the good reason to go to a simple
> device->ops->remove_dev_pasid() callback and forget about blocking
> domain here.

Do you mean rolling back to what we did in v10?

--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -262,6 +262,8 @@ struct iommu_ops {
   * struct iommu_domain_ops - domain specific operations
   * @attach_dev: attach an iommu domain to a device
   * @detach_dev: detach an iommu domain from a device
+ * @set_dev_pasid: set an iommu domain to a pasid of device
+ * @block_dev_pasid: block pasid of device from using iommu domain
   * @map: map a physically contiguous memory region to an iommu domain
   * @map_pages: map a physically contiguous set of pages of the same 
size to
   *             an iommu domain.
@@ -282,6 +284,10 @@ struct iommu_ops {
  struct iommu_domain_ops {
         int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
         void (*detach_dev)(struct iommu_domain *domain, struct device 
*dev);
+       int (*set_dev_pasid)(struct iommu_domain *domain, struct device 
*dev,
+                            ioasid_t pasid);
+       void (*block_dev_pasid)(struct iommu_domain *domain, struct 
device *dev,
+                               ioasid_t pasid);

Best regards,
baolu
