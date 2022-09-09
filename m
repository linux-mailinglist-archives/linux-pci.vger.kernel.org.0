Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7CC5B2BE0
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 03:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIIByS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 21:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiIIByP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 21:54:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0A7A50F9;
        Thu,  8 Sep 2022 18:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662688455; x=1694224455;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=V8rWhGS1JBuyEKj5MooRa936Kyq13co5hPOuxZW39vo=;
  b=jHfzaO81jgHc6/5uJglCGPcyTEIgqS2UZSXShlrEF7xfLvrO6RbFJk+P
   IQTGVVDBZxbmPtWaLKElAEbkMwyQpVbt0xsi1qLJNHTwfuoB4vrwCjODf
   xfoWYjubHKmRv4oShe0o5NwBXxGPZnGeoM3cDwI5FjxnEX4YALTPtXfUz
   PwWP/A4LNItQuwt/PK5pS9aWoMQVArCFoEUdKmZi+6Bb+T6xKiN9XNssx
   t4DDqG26b23yg+xAGDNUH8XyC+ftp/dFtHDU9hER6Dc+YRFEF+2TTabRS
   B8zwLQ/iairKPZqWcddazd+9b01TC0uYCYD+pxqN+Tc+ZZVnmcor4napB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="277760452"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="277760452"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 18:54:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="676961624"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.159]) ([10.254.214.159])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 18:54:09 -0700
Message-ID: <a4402d04-0920-59ff-5dd3-a374c84d64b0@linux.intel.com>
Date:   Fri, 9 Sep 2022 09:54:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
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
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-10-baolu.lu@linux.intel.com> <Yxd2+d/VOjdOgrR2@myrica>
 <682d8922-200d-8c89-7142-83e7b3754b8d@linux.intel.com>
 <YxhqbhMmWLeFS512@myrica> <YxjV1y/FF0nCI/WO@nvidia.com>
 <YxoXfCQcD3yC5ppn@myrica> <YxobR/brG9VlxPvX@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v13 09/13] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
In-Reply-To: <YxobR/brG9VlxPvX@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/9/9 0:41, Jason Gunthorpe wrote:
> On Thu, Sep 08, 2022 at 05:25:32PM +0100, Jean-Philippe Brucker wrote:
>> On Wed, Sep 07, 2022 at 02:33:11PM -0300, Jason Gunthorpe wrote:
>>> On Wed, Sep 07, 2022 at 10:54:54AM +0100, Jean-Philippe Brucker wrote:
>>>
>>>> Is iommu_domain still going to represent both a device context (whole
>>>> PASID table) and individual address spaces, or are you planning to move
>>>> away from that?  What happens when a driver does:
>>>>
>>>>    d1 = iommu_domain_alloc()
>>>>    iommu_attach_device(d1)
>>>>    d2 = iommu_sva_bind_device()
>>>>    iommu_detach_device(d1)
>>>>
>>>> Does detach
>>>> (a) only disable the non-PASID address space?
>>>> (b) disable everything?
>>>> (c) fail because the driver didn't unbind first?
>>> I think it must be (a), considering how everything is defined and the
>>> needs for vIOMMU emulation.
>> Yes (a) is probably better. The SMMU driver currently implements (c) to
>> ensure that you can't switch device driver without unbinding everything
>> first, and we should keep that check somewhere
> Yes, the owner stuff is a logical place to put that, when ownership
> is all released the PASID table of the group must be empty. Lu?

I agree. The ownership is about the whole device (more precisely,
group), including the RID and PASIDs. When the ownership is converted,
the pasid array must be empty. I will add code in this series to enforce
this. Thanks for pointing out this.

Best regards,
baolu
