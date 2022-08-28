Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A395A3D95
	for <lists+linux-pci@lfdr.de>; Sun, 28 Aug 2022 14:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiH1MwW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Aug 2022 08:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiH1MwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Aug 2022 08:52:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03085EE25;
        Sun, 28 Aug 2022 05:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661691140; x=1693227140;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YaVpDFcSktopVayCz3BxH2mKjkt04+621MmiMmMBYRs=;
  b=QYHyo0pqljdwou6lblZmg4Mr1X8jcrNONL92NxoJ+IHc597f0KGC0Gk+
   10PHhzz6ndtmCKPPifTPPbDy0pJbs8K/ZNNUwYL5bszrgLJImRCg+xFiG
   ff6LGud8YS4yjCrbdsX2iLIJyzr9/+CAUdVHFqPAU22h1MaWLV5ztYwng
   O0AYyG8rJx33eXEAd0jShMcF7tUbI+gDo93ybDk0Sy/LP6DqXUjyOGoDx
   h8FGcr+bV3ghSUsSBxEywsh0j4NRmvJmI98vmmUzFHH67Cwhg9vWGfGnZ
   oIjGps61cMXLFC7FnvbmGX3cOLs9wEBPgQkBNwFmf5uvBKKfdFMvS1eH4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="294746106"
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="294746106"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 05:52:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="672051439"
Received: from cyue-mobl1.ccr.corp.intel.com (HELO [10.254.209.98]) ([10.254.209.98])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 05:52:16 -0700
Message-ID: <e56c8c79-4f09-3706-c66f-726e5c78b413@linux.intel.com>
Date:   Sun, 28 Aug 2022 20:52:14 +0800
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v12 05/17] iommu: Add attach/detach_dev_pasid iommu
 interface
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-6-baolu.lu@linux.intel.com>
 <YwjauaF1sTP6l2j9@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YwjauaF1sTP6l2j9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/8/26 22:37, Jason Gunthorpe wrote:
> On Fri, Aug 26, 2022 at 08:11:29PM +0800, Lu Baolu wrote:
> 
>> + * iommu_get_domain_for_dev_pasid() - Retrieve domain for @pasid of @dev
>> + * @dev: the queried device
>> + * @pasid: the pasid of the device
>> + * @type: matched domain type, 0 for any match
>> + *
>> + * This is a variant of iommu_get_domain_for_dev(). It returns the existing
>> + * domain attached to pasid of a device. It's only for internal use of the
>> + * IOMMU subsystem.
> 
> If it is only for external use then why is it exported?
> 
> I would add something like:
> 
>   Callers must hold a lock around this function, and both
>   iommu_attach/detach_dev_pasid() whenever a domain of type is being
>   manipulated. This API does not internally resolve races with
>   attach/detach.

Yes. Updated. This is what this API expected.

> 
>> + * detaching from the device PASID.
>> + *
>> + * Return: attached domain on success, NULL otherwise.
>> + */
>> +struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
>> +						    ioasid_t pasid,
>> +						    unsigned int type)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct iommu_group *group;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return NULL;
>> +	/*
>> +	 * The xarray protects its internal state with RCU. Hence the domain
>> +	 * obtained is either NULL or fully formed.
>> +	 */
> 
> This has nothing to do with RCU
> 
> xa_lock() is used to ensure that the domain pointer remains valid
> while we check the type since it blocks concurrent xa_erase().

With xa_lock() added, this comment is not needed anymore.

Best regards,
baolu
