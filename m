Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE83452F94
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 11:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhKPK7r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 05:59:47 -0500
Received: from foss.arm.com ([217.140.110.172]:43518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234409AbhKPK7q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Nov 2021 05:59:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F3E01FB;
        Tue, 16 Nov 2021 02:56:49 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E2673F766;
        Tue, 16 Nov 2021 02:56:45 -0800 (PST)
Message-ID: <0b67745c-13dd-1fea-1b8b-d55212bad232@arm.com>
Date:   Tue, 16 Nov 2021 10:56:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 2/6] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
Content-Language: en-GB
To:     Yicong Yang <yangyicong@hisilicon.com>, gregkh@linuxfoundation.org,
        helgaas@kernel.org, alexander.shishkin@linux.intel.com,
        lorenzo.pieralisi@arm.com, will@kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, daniel.thompson@linaro.org,
        joro@8bytes.org, john.garry@huawei.com,
        shameerali.kolothum.thodi@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     prime.zeng@huawei.com, linuxarm@huawei.com,
        zhangshaokun@hisilicon.com, liuqi115@huawei.com
References: <20211116090625.53702-1-yangyicong@hisilicon.com>
 <20211116090625.53702-3-yangyicong@hisilicon.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211116090625.53702-3-yangyicong@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-11-16 09:06, Yicong Yang via iommu wrote:
[...]
> +/*
> + * Get RMR address if provided by the firmware.
> + * Return 0 if the IOMMU doesn't present or the policy of the
> + * IOMMU domain is passthrough or we get a usable RMR region.
> + * Otherwise a negative value is returned.
> + */
> +static int hisi_ptt_get_rmr(struct hisi_ptt *hisi_ptt)
> +{
> +	struct pci_dev *pdev = hisi_ptt->pdev;
> +	struct iommu_domain *iommu_domain;
> +	struct iommu_resv_region *region;
> +	LIST_HEAD(list);
> +
> +	/*
> +	 * Use direct DMA if IOMMU does not present or the policy of the
> +	 * IOMMU domain is passthrough.
> +	 */
> +	iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
> +	if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
> +		return 0;
> +
> +	iommu_get_resv_regions(&pdev->dev, &list);
> +	list_for_each_entry(region, &list, list)
> +		if (region->type == IOMMU_RESV_DIRECT &&
> +		    region->length >= HISI_PTT_TRACE_BUFFER_SIZE) {
> +			hisi_ptt->trace_ctrl.has_rmr = true;
> +			hisi_ptt->trace_ctrl.rmr_addr = region->start;
> +			hisi_ptt->trace_ctrl.rmr_length = region->length;
> +			break;
> +		}
> +
> +	iommu_put_resv_regions(&pdev->dev, &list);
> +	return hisi_ptt->trace_ctrl.has_rmr ? 0 : -ENOMEM;
> +}

No.

The whole point of RMRs is for devices that are already configured to 
access the given address range in a manner beyond the kernel's control. 
If you can do this, it proves that you should not have an RMR in the 
first place.

The notion of a kernel driver explicitly configuring its device to DMA 
into any random RMR that looks big enough is so egregiously wrong that 
I'm almost lost for words...

Robin.
