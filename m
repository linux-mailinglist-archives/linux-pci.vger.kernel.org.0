Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A502C5B9A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 19:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391624AbgKZSJc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 13:09:32 -0500
Received: from foss.arm.com ([217.140.110.172]:42638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391523AbgKZSJc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Nov 2020 13:09:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4512431B;
        Thu, 26 Nov 2020 10:09:31 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D587E3F23F;
        Thu, 26 Nov 2020 10:09:27 -0800 (PST)
Subject: Re: [PATCH v8 4/9] of/iommu: Support dma-can-stall property
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org, lorenzo.pieralisi@arm.com, robh+dt@kernel.org
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        baolu.lu@linux.intel.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
 <20201112125519.3987595-5-jean-philippe@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d0a61d79-82fc-3af8-570e-e2ae3d485455@arm.com>
Date:   Thu, 26 Nov 2020 18:09:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201112125519.3987595-5-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-12 12:55, Jean-Philippe Brucker wrote:
> Copy the dma-can-stall property into the fwspec structure.

Can't we just handle this as a regular device property? It's not part of 
the actual IOMMU specifier, it doesn't need to be translated in any way, 
and AFAICS it's used a grand total of once, in a slow path. Simply 
treating it as the per-device property that it is should require zero 
additional code for DT, and a simple device_add_properties() call for IORT.

TBH that appears to be true of pasid-num-bits as well.

Robin.

> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   include/linux/iommu.h    | 2 ++
>   drivers/iommu/of_iommu.c | 5 ++++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a1c78c4cdeb1..9076fb592c8f 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -572,6 +572,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
>    * @iommu_fwnode: firmware handle for this device's IOMMU
>    * @iommu_priv: IOMMU driver private data for this device
>    * @num_pasid_bits: number of PASID bits supported by this device
> + * @can_stall: the device is allowed to stall
>    * @num_ids: number of associated device IDs
>    * @ids: IDs which this device may present to the IOMMU
>    */
> @@ -579,6 +580,7 @@ struct iommu_fwspec {
>   	const struct iommu_ops	*ops;
>   	struct fwnode_handle	*iommu_fwnode;
>   	u32			num_pasid_bits;
> +	bool			can_stall;
>   	unsigned int		num_ids;
>   	u32			ids[];
>   };
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e505b9130a1c..d6255ca823d8 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -212,9 +212,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   		err = of_iommu_configure_device(master_np, dev, id);
>   
>   		fwspec = dev_iommu_fwspec_get(dev);
> -		if (!err && fwspec)
> +		if (!err && fwspec) {
>   			of_property_read_u32(master_np, "pasid-num-bits",
>   					     &fwspec->num_pasid_bits);
> +			fwspec->can_stall = of_property_read_bool(master_np,
> +								  "dma-can-stall");
> +		}
>   	}
>   
>   	/*
> 
