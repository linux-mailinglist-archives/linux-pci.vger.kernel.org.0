Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFFB5A5918
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 04:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiH3CFE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 22:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiH3CFB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 22:05:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A35646E;
        Mon, 29 Aug 2022 19:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661825099; x=1693361099;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FkO4gN2dO3Abru4zYAilXuwSzG3zRLA+wKTAv2BwfCM=;
  b=aDVcs7uvl/EzFNPzgYxayBrMesANV7uoEYjmzqhUrlQdfwZD3Mzn6tX4
   K/yy8K6OUMoVfznBIS3x/z3wv/3GceqDQkyrMfUlJ77+k0jWqwyHJbExM
   B9Jf0V3KWs8YohmnznghGFRR3LqAleNKcGPZtm4yzxd2M4V0xlI7LQU7u
   xhYr7KpGJYKJoqvQtVbmKJH9JbywnygBCjIpUSqwsA3Mtilvwrntdcjyu
   6xr+RkR+2WbO6xR+bnRiLKRLFNx1EII3SEKyVif/GvoMlGV3R/1QxeX6d
   UDeEPuAPmzYQFQrEJxRquBjZ162/nSOLeqPoXQ0mQnVepd/j5XZl5PTDu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="282025444"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="282025444"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 19:04:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672627356"
Received: from hhuan14-mobl1.ccr.corp.intel.com (HELO [10.254.215.208]) ([10.254.215.208])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 19:04:54 -0700
Message-ID: <4911af2a-134c-bb3b-dfa4-3dc7b69e11a3@linux.intel.com>
Date:   Tue, 30 Aug 2022 10:04:52 +0800
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
Subject: Re: [PATCH v12 12/17] arm-smmu-v3/sva: Add SVA domain support
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-13-baolu.lu@linux.intel.com>
 <YwjfKsvKyXLdCJ/Z@nvidia.com>
 <fe5c459e-9992-73b6-35b4-59ef815f1f9a@linux.intel.com>
 <Ywz3aQ57PthSYycN@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Ywz3aQ57PthSYycN@nvidia.com>
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

On 2022/8/30 01:29, Jason Gunthorpe wrote:
> On Sun, Aug 28, 2022 at 09:57:21PM +0800, Baolu Lu wrote:
>> On 2022/8/26 22:56, Jason Gunthorpe wrote:
>>> On Fri, Aug 26, 2022 at 08:11:36PM +0800, Lu Baolu wrote:
>>>
>>>> +static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
>>>> +	.set_dev_pasid		= arm_smmu_sva_set_dev_pasid,
>>> Do we want to permit drivers to not allow a SVA domain to be set on a
>>> RID?
>>>
>>> It seems like a weird restriction to me
>> Conceptually as long as the page table is compatible and user pages are
>> pinned (or I/O page fault is supported), the device drivers are valid to
>> set SVA domain to a RID. But I don't see a real use case as far as I can
>> see.
> It may be interesting for something like DPDK type applications where
> having the entire process address space mapped SVA to the device could
> be quite nice.
> 
> You, currently, give up interrupts, but perhaps that is solvable in some
> way.
> 
> So, IDK.. I wouldn't dismiss it entirely but I wouldn't do a bunch of
> work to support it either.

Then we can do this through the set_dev callback, as it's the right
callback to set a domain to the RID, right? Not sure whether it worth a
new type of domain. The current implementation doesn't prevent us from
achieving this in the future anyway.

> 
>> A reasonable use case is sharing EPT between KVM and IOMMU. That demands
>> a new type of domain and implements its own .set_dev for page table
>> attachment.
> Not everything is virtualization:)

Yes. Fair enough. :-)

Best regards,
baolu
