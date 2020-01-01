Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7503C12DD95
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jan 2020 05:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgAAEGi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 23:06:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:62808 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbgAAEGi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Dec 2019 23:06:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2019 20:06:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,381,1571727600"; 
   d="scan'208";a="244309244"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 31 Dec 2019 20:06:36 -0800
Cc:     baolu.lu@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC 2/5] iommu/vt-d: Unlink device if failed to add to group
To:     Jon Derrick <jonathan.derrick@intel.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
 <1577823863-3303-3-git-send-email-jonathan.derrick@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f63981a1-7fe3-d367-c2c1-060f9556f66c@linux.intel.com>
Date:   Wed, 1 Jan 2020 12:05:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577823863-3303-3-git-send-email-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/1/20 4:24 AM, Jon Derrick wrote:
> If the device fails to be added to the group, make sure to unlink the
> reference before returning.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

This fix looks reasonable to me.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-iommu.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index b2526a4..978d502 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5625,8 +5625,10 @@ static int intel_iommu_add_device(struct device *dev)
>   
>   	group = iommu_group_get_for_dev(dev);
>   
> -	if (IS_ERR(group))
> -		return PTR_ERR(group);
> +	if (IS_ERR(group)) {
> +		ret = PTR_ERR(group);
> +		goto unlink;
> +	}
>   
>   	iommu_group_put(group);
>   
> @@ -5652,7 +5654,8 @@ static int intel_iommu_add_device(struct device *dev)
>   				if (!get_private_domain_for_dev(dev)) {
>   					dev_warn(dev,
>   						 "Failed to get a private domain.\n");
> -					return -ENOMEM;
> +					ret = -ENOMEM;
> +					goto unlink;
>   				}
>   
>   				dev_info(dev,
> @@ -5667,6 +5670,10 @@ static int intel_iommu_add_device(struct device *dev)
>   	}
>   
>   	return 0;
> +
> +unlink:
> +	iommu_device_unlink(&iommu->iommu, dev);
> +	return ret;
>   }
>   
>   static void intel_iommu_remove_device(struct device *dev)
> 
