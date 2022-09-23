Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0645E71D4
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 04:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiIWCWA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 22:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiIWCV7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 22:21:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132581181CF;
        Thu, 22 Sep 2022 19:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663899719; x=1695435719;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=UwDG7pDg4q+ikiSIyDkSSay/EkxC20ZvQE0rFh71LXs=;
  b=iSwyTWNSeLffzQzp5pTUMUGSvqDdVDcvuUdNhPYhKCrD4W3DTx9Z2tx8
   EHVDDUPdrE9sTmwqPWPPecC2IKgZQ4BHNJhzcE9tSl7ybqCkjFjDM5TGx
   RClO5kGjCoDuyN9eXWfD+kz+E0xvjVh2QvKmIIZAjJWURQ/cvOjJ26Bum
   3IclQio2IIR5n0BfsQGnD5Pg58Ay6uSXSpA323hFX0Q0IMIm9l5TpnXed
   OGcjvKJb/Qsy19mlSts+GzfhJ0cVNjPCqYksAjdAIDT4fSlJ88mcUWfWR
   iTSqxwN1jeLk2tVcjj9PJBPvwC+jaB4CPNGRGx/CCVdua3J5zjrzRe1Vz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="298089181"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="298089181"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:21:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="653238520"
Received: from ningqu-mobl1.ccr.corp.intel.com (HELO [10.254.210.156]) ([10.254.210.156])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:21:53 -0700
Message-ID: <075278e0-77ce-2361-8ded-6cd6bb20216f@linux.intel.com>
Date:   Fri, 23 Sep 2022 10:21:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
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
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-8-baolu.lu@linux.intel.com>
 <YyyECCbmfsaDpDgJ@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v13 07/13] iommu/vt-d: Add SVA domain support
In-Reply-To: <YyyECCbmfsaDpDgJ@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/9/22 23:49, Jason Gunthorpe wrote:
> On Tue, Sep 06, 2022 at 08:44:52PM +0800, Lu Baolu wrote:
>> +static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>> +{
>> +	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
>> +	struct iommu_domain *domain;
>> +
>> +	/* Domain type specific cleanup: */
>> +	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>> +	if (domain) {
>> +		switch (domain->type) {
>> +		case IOMMU_DOMAIN_SVA:
>> +			intel_svm_remove_dev_pasid(dev, pasid);
>> +			break;
>> +		default:
>> +			/* should never reach here */
>> +			WARN_ON(1);
>> +			break;
> 
> This is eventually going to need a lot more cleaning up to split out
> the PASID from the SVM stuff.
> 
> SVA should *only* be a set of predefined handlers (in the core code!)
> for the generic PRI mechanism, it shouldn't be entangled deeply into
> PASID or the drivers like this.
> 
> When we get done with this, the flow should have the core code attach
> a SVA domain to a PASID with PRI enabled and the core code should
> supply a generic PRI implementation that does the mmu_notifier
> stuff.

Yes. Agreed.

At the beginning of this project, I wanted to consolidate the mm
notifications into the core. However, ARM SMMUv3 and Intel handle the mm
notifications a little differently. Then I decided to do this work
separately from the current series.

> 
> Also, stuff like this:
> 
> 				/* We mandate that no page faults may be outstanding
> 				 * for the PASID when intel_svm_unbind_mm() is called.
> 				 * If that is not obeyed, subtle errors will happen.
> 				 * Let's make them less subtle... */
> 
> Are going to be problematic for VFIO as well. In a VFIO world the
> entire RID and its entire PASID table has to be owned by VFIO and
> never shared - so these sequencing issues should be solvable.
> 
> But this is all for further series..

Yes. All these sound interesting future series.

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I'm very appreciated for your time.

Best regards,
baolu
