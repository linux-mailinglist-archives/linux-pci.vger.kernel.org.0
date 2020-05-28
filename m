Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637331E581B
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 09:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgE1HCW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 03:02:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:59782 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgE1HCV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 03:02:21 -0400
IronPort-SDR: d4EZJHe3AW5PIIfF384ThT9IPp4zawY3eKtt9CLx+HKpDInbbBYYLq71YhqhMUnbnstMMQoapR
 VPfddpUsG83A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 00:02:20 -0700
IronPort-SDR: qZ8B6ItD35NidF6MB+sge5PnxSUDRGtBKhVxFvGTgB9/+ES3McGrWsQYatYsq8+dk5MESuqRJf
 2GC48z3wIa1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="442845633"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.30.232]) ([10.255.30.232])
  by orsmga005.jf.intel.com with ESMTP; 28 May 2020 00:02:17 -0700
Cc:     baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v1 3/3] iommu/vt-d: Remove real DMA lookup in find_domain
To:     Jon Derrick <jonathan.derrick@intel.com>,
        iommu@lists.linux-foundation.org
References: <20200527165617.297470-1-jonathan.derrick@intel.com>
 <20200527165617.297470-4-jonathan.derrick@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6e94b90c-f849-d206-0b0e-f1c8253ac939@linux.intel.com>
Date:   Thu, 28 May 2020 15:02:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527165617.297470-4-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/5/28 0:56, Jon Derrick wrote:
> By removing the real DMA indirection in find_domain(), we can allow
> sub-devices of a real DMA device to have their own valid
> device_domain_info. The dmar lookup and context entry removal paths have
> been fixed to account for sub-devices.
> 
> Fixes: 2b0140c69637 ("iommu/vt-d: Use pci_real_dma_dev() for mapping")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207575
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-iommu.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6d39b9b..5767882 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2436,9 +2436,6 @@ struct dmar_domain *find_domain(struct device *dev)
>   	if (unlikely(attach_deferred(dev) || iommu_dummy(dev)))
>   		return NULL;
>   
> -	if (dev_is_pci(dev))
> -		dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
> -
>   	/* No lock here, assumes no domain exit in normal case */
>   	info = get_domain_info(dev);
>   	if (likely(info))
> 
