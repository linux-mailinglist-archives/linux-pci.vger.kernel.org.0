Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8233B59E44F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 15:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiHWNP6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiHWNPT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 09:15:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B3B1394D7;
        Tue, 23 Aug 2022 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661249723; x=1692785723;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sDYY2LnWuh3m43TrqMEx9DBucjZdzzerN457gMjLxLU=;
  b=N+0UcoMGiqHaeyV5moMreiwiHs+rRuIPPXLrHVq8r+dJq18p6Qe4ePQO
   pK1MB4rl0AygHHM/0uxKaiDa+xBhBY+FzqjQneYuuaD260jddd8zmYtDa
   clvcDWzUT1P9lHFpDXiTRH+a1EM2w3K1UxSwpw1GPhOpizHd2K8m8j2A3
   L6ykwrdVYA2d3HMr24pWL6BNgOD2mKRJxNPRf1Crq3KDBVlw+kRQA00G8
   0H3YGe7Ajdz6BgZyn3fU1hxndj8jLy6uAxD71E74Zdx7P3vOxSNDH/Ftt
   B/ptqVATYMoGp+ergGkHOOX/8TnOxjoz7lvfPMjhA3xmTbPZqQDr7+m7I
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="319690909"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="319690909"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 03:12:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="669966785"
Received: from xlin15-mobl2.ccr.corp.intel.com (HELO [10.254.208.88]) ([10.254.208.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 03:12:46 -0700
Message-ID: <83069b7d-3dc8-8b72-246b-264389cac072@linux.intel.com>
Date:   Tue, 23 Aug 2022 18:12:44 +0800
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
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v11 09/13] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
 <20220817012024.3251276-10-baolu.lu@linux.intel.com>
 <Yv5Bf7+59po6K/1h@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yv5Bf7+59po6K/1h@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/8/18 21:41, Jason Gunthorpe wrote:
> On Wed, Aug 17, 2022 at 09:20:20AM +0800, Lu Baolu wrote:
>> +
>> +/**
>> + * iommu_sva_bind_device() - Bind a process address space to a device
>> + * @dev: the device
>> + * @mm: the mm to bind, caller must hold a reference to mm_users
>> + *
>> + * Create a bond between device and address space, allowing the device to access
>> + * the mm using the returned PASID. If a bond already exists between @device and
>> + * @mm, it is returned and an additional reference is taken. Caller must call
>> + * iommu_sva_unbind_device() to release each reference.
>> + *
>> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
>> + * initialize the required SVA features.
>> + *
>> + * On error, returns an ERR_PTR value.
>> + */
>> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct iommu_sva *bond;
> 
> This is called handle below, pick one name please

Updated.

> 
>> +	ioasid_t max_pasids;
>> +	int ret;
>> +
>> +	max_pasids = dev->iommu->max_pasids;
>> +	if (!max_pasids)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>> +	/* Allocate mm->pasid if necessary. */
>> +	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
>> +	if (!bond)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	mutex_lock(&iommu_sva_lock);
>> +	/* Search for an existing domain. */
>> +	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid);
>> +	if (domain) {
> 
> This isn't safe, or sane. A driver could have attached something to
> this PASID that is not a SVA domain and thus not protected by the
> iommu_sva_lock.
> 
> At a minimum you should add a type match to
> iommu_get_domain_for_dev_pasid(), eg to confirm it is a SVA domain and
> do that check under the xa_lock of the pasid xarray.
> 
> And then the general idea is that SVA domain attach/detach must hold
> this janky global lock.

Make sense. I will add this logic.

> 
>> +		refcount_inc(&domain->users);
> 
> This atomic is always processed under the iommu_sva_lock, so it
> doesn't need to be an atomic anymore.

Will change it to an integer.

> 
> Otherwise this design looks OK to me too

Thank you very much for your suggestions.

Best regards,
baolu

