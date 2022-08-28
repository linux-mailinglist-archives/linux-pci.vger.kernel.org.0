Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E305A3D9A
	for <lists+linux-pci@lfdr.de>; Sun, 28 Aug 2022 14:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiH1M4G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Aug 2022 08:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiH1M4D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Aug 2022 08:56:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1540E11A22;
        Sun, 28 Aug 2022 05:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661691361; x=1693227361;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FLrVUspMTdiVkIGP7G50w5Lr795N0ps5SA1lUprfsoQ=;
  b=LT9hMWA+0io21pjxHdJygiJy1wMw7eVTxRpVRpPjY4GQK3rfYJnqi5Vt
   0ZXfTXZcEgisavTYTP+TiCz+j13MsHPVgG0ieVy4b1Gf94qN20S1/0nbM
   Qw8XoMFiU66l1VOimXbAJcrYvgzfLrZY5N1LVo0aGd1+TVxmmFAzi3nBW
   8MuWoAghLmF3EN2F9n90ohcmehCqj2aV5kYpeQ6XSwaNMj9Ey7aRIT+o0
   Qu/zoEEVI4oIi/p5pSe3lo7JOgIKRYdk97w/BrD80ZnGWHDdvDkabCKW1
   DVQq5hzB7vaVZnVELG9BwwfF/WplcnLMVmzb38G6FLCk4fq58j+uvXKL/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="274487311"
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="274487311"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 05:56:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="672052008"
Received: from cyue-mobl1.ccr.corp.intel.com (HELO [10.254.209.98]) ([10.254.209.98])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 05:55:56 -0700
Message-ID: <18e43d40-577d-2878-5673-706defd699d5@linux.intel.com>
Date:   Sun, 28 Aug 2022 20:55:55 +0800
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
Subject: Re: [PATCH v12 09/17] iommu/vt-d: Add blocking domain support
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-10-baolu.lu@linux.intel.com>
 <YwjetO21TWkhN6KH@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YwjetO21TWkhN6KH@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/8/26 22:54, Jason Gunthorpe wrote:
> On Fri, Aug 26, 2022 at 08:11:33PM +0800, Lu Baolu wrote:
>> The Intel IOMMU hardwares support blocking DMA transactions by clearing
>> the translation table entries. This implements a real blocking domain to
>> avoid using an empty UNMANAGED domain. The detach_dev callback of the
>> domain ops is not used in any path. Remove it to avoid dead code as well.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Tested-by: Tony Zhu <tony.zhu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 25 ++++++++++++++++++-------
>>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> At this point I'd suggest to make a little series that does all the
> blocking domain stuff in one shot
> 
> The removal of detach_dev callbacks is pretty nice for clarity.

Yes. As you saw, I have a separated series for above purpose.

Best regards,
baolu
