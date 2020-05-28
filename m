Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA7F1E5810
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 09:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgE1HBx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 03:01:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:32836 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgE1HBx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 03:01:53 -0400
IronPort-SDR: CDWL0wagJ/EegsaBY0nv2gErT6Fv/gjqso5I8xiI6jiU2XJZCBUKJcxGo0u4v20UVQZBNxSupz
 oI2dBtz+oDwA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 00:01:52 -0700
IronPort-SDR: QxMrdvgNvNyuSjUzMPCQZ5expSmieD5eAN8q7YlgMDlyceH3tEl4ICoitZLcUX/cnIdOtUOyoV
 tf2gyWM6Yo3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="442845507"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.30.232]) ([10.255.30.232])
  by orsmga005.jf.intel.com with ESMTP; 28 May 2020 00:01:49 -0700
Cc:     baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v1 2/3] iommu/vt-d: Allocate domain info for real DMA
 sub-devices
To:     Jon Derrick <jonathan.derrick@intel.com>,
        iommu@lists.linux-foundation.org
References: <20200527165617.297470-1-jonathan.derrick@intel.com>
 <20200527165617.297470-3-jonathan.derrick@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fd4b5313-efd0-90bf-5841-80a97ce5f652@linux.intel.com>
Date:   Thu, 28 May 2020 15:01:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527165617.297470-3-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/5/28 0:56, Jon Derrick wrote:
> Sub-devices of a real DMA device might exist on a separate segment than
> the real DMA device and its IOMMU. These devices should still have a
> valid device_domain_info, but the current dma alias model won't
> allocate info for the subdevice.
> 
> This patch adds a segment member to struct device_domain_info and uses
> the sub-device's BDF so that these sub-devices won't alias to other
> devices.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-iommu.c | 19 +++++++++++++++----
>   include/linux/intel-iommu.h |  1 +
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 1ff45b2..6d39b9b 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2463,7 +2463,7 @@ static void do_deferred_attach(struct device *dev)
>   	struct device_domain_info *info;
>   
>   	list_for_each_entry(info, &device_domain_list, global)
> -		if (info->iommu->segment == segment && info->bus == bus &&
> +		if (info->segment == segment && info->bus == bus &&
>   		    info->devfn == devfn)
>   			return info;
>   
> @@ -2520,8 +2520,18 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>   	if (!info)
>   		return NULL;
>   
> -	info->bus = bus;
> -	info->devfn = devfn;
> +	if (!dev_is_real_dma_subdevice(dev)) {
> +		info->bus = bus;
> +		info->devfn = devfn;
> +		info->segment = iommu->segment;
> +	} else {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		info->bus = pdev->bus->number;
> +		info->devfn = pdev->devfn;
> +		info->segment = pci_domain_nr(pdev->bus);
> +	}
> +
>   	info->ats_supported = info->pasid_supported = info->pri_supported = 0;
>   	info->ats_enabled = info->pasid_enabled = info->pri_enabled = 0;
>   	info->ats_qdep = 0;
> @@ -2561,7 +2571,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>   
>   	if (!found) {
>   		struct device_domain_info *info2;
> -		info2 = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
> +		info2 = dmar_search_domain_by_dev_info(info->segment, info->bus,
> +						       info->devfn);
>   		if (info2) {
>   			found      = info2->domain;
>   			info2->dev = dev;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 21633ce..4100bd2 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -609,6 +609,7 @@ struct device_domain_info {
>   	struct list_head auxiliary_domains; /* auxiliary domains
>   					     * attached to this device
>   					     */
> +	u32 segment;		/* PCI segment number */
>   	u8 bus;			/* PCI bus number */
>   	u8 devfn;		/* PCI devfn number */
>   	u16 pfsid;		/* SRIOV physical function source ID */
> 
