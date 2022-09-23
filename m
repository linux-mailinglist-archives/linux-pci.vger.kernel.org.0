Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09D25E71E9
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 04:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiIWCbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 22:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiIWCbl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 22:31:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED65EF08B;
        Thu, 22 Sep 2022 19:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663900300; x=1695436300;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pYyYBUYMtYbcujhE22C27QXzCyOfAQYZ1tOZo9rAkuU=;
  b=C2h/eN5EkPYsjx/D0qZ9gZ5tRTNeMdKdZsBzKJKMIAvqacrPQmshhs2v
   lvjOF6aV1sXCD+zTbkNoGxeEpYdEbBgUJmSJ5N3mFZDXUCOcOcO0D2c2J
   8WB0YdGmlJojypMM0mOaJ2mcNYGRboewYmHLwIKn7phyIgQLwg/Yj8MTo
   A1XAdIYI5UDwhCKTiQp00/LNh3LCohrrRJqL3e63Q7a5MOLXmmuDcnAWT
   ZVE22YchdkzISQor3Ji9RV7ebvheSeev9weSkzNVaN58zrYf1Vr865hpz
   t1XYX6P/zYx9xLLBmtGMn61pObLxKosHojVmZXcXYq64qzZUsoi1EZ81S
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="287602465"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="287602465"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:31:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="620051445"
Received: from ningqu-mobl1.ccr.corp.intel.com (HELO [10.254.210.156]) ([10.254.210.156])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:31:35 -0700
Message-ID: <ca854564-f231-1010-92e3-69acabde2bd1@linux.intel.com>
Date:   Fri, 23 Sep 2022 10:31:32 +0800
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v13 09/13] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-10-baolu.lu@linux.intel.com>
 <YyyGqDP8AgjsFAkM@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YyyGqDP8AgjsFAkM@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/9/23 0:00, Jason Gunthorpe wrote:
> On Tue, Sep 06, 2022 at 08:44:54PM +0800, Lu Baolu wrote:
> 
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
> Thsi is something else that needs cleaning up. IOMMU_DEV_FEAT_SVA
> shouldn't exist.
> 
> We need to figure out an appropriate way to allow PRI. IMHO the domain
> attach should do this, domains that require PRI should be distinct
> from domains that don't. When a PRI domain is attached the HW should
> be enabled to do PRI. The domain itself should carry the fault ops/etc
> that the caller supplies to respond to the PRI.
> 
> That is something to address in the PRI series though..

 From Intel IOMMU driver's point of view, with above done,
IOMMU_DEV_FEAT_SVA could be removed. However, it will take more time to
consider other needs.

> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>

Best regards,
baolu
