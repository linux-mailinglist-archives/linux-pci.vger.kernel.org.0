Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D398A4530FA
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 12:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhKPLlP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 06:41:15 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14751 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbhKPLkV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 06:40:21 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HtkW73C6CzZd79;
        Tue, 16 Nov 2021 19:34:59 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 19:37:21 +0800
Received: from [10.67.102.169] (10.67.102.169) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Tue, 16 Nov 2021 19:37:20 +0800
CC:     <yangyicong@hisilicon.com>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>, <zhangshaokun@hisilicon.com>,
        <liuqi115@huawei.com>
Subject: Re: [PATCH v2 2/6] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
To:     Robin Murphy <robin.murphy@arm.com>, <gregkh@linuxfoundation.org>,
        <helgaas@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <lorenzo.pieralisi@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>,
        <daniel.thompson@linaro.org>, <joro@8bytes.org>,
        <john.garry@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
References: <20211116090625.53702-1-yangyicong@hisilicon.com>
 <20211116090625.53702-3-yangyicong@hisilicon.com>
 <0b67745c-13dd-1fea-1b8b-d55212bad232@arm.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <3644ad6e-d800-c84b-9d62-6dda8462450f@hisilicon.com>
Date:   Tue, 16 Nov 2021 19:37:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <0b67745c-13dd-1fea-1b8b-d55212bad232@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/11/16 18:56, Robin Murphy wrote:
> On 2021-11-16 09:06, Yicong Yang via iommu wrote:
> [...]
>> +/*
>> + * Get RMR address if provided by the firmware.
>> + * Return 0 if the IOMMU doesn't present or the policy of the
>> + * IOMMU domain is passthrough or we get a usable RMR region.
>> + * Otherwise a negative value is returned.
>> + */
>> +static int hisi_ptt_get_rmr(struct hisi_ptt *hisi_ptt)
>> +{
>> +    struct pci_dev *pdev = hisi_ptt->pdev;
>> +    struct iommu_domain *iommu_domain;
>> +    struct iommu_resv_region *region;
>> +    LIST_HEAD(list);
>> +
>> +    /*
>> +     * Use direct DMA if IOMMU does not present or the policy of the
>> +     * IOMMU domain is passthrough.
>> +     */
>> +    iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
>> +    if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
>> +        return 0;
>> +
>> +    iommu_get_resv_regions(&pdev->dev, &list);
>> +    list_for_each_entry(region, &list, list)
>> +        if (region->type == IOMMU_RESV_DIRECT &&
>> +            region->length >= HISI_PTT_TRACE_BUFFER_SIZE) {
>> +            hisi_ptt->trace_ctrl.has_rmr = true;
>> +            hisi_ptt->trace_ctrl.rmr_addr = region->start;
>> +            hisi_ptt->trace_ctrl.rmr_length = region->length;
>> +            break;
>> +        }
>> +
>> +    iommu_put_resv_regions(&pdev->dev, &list);
>> +    return hisi_ptt->trace_ctrl.has_rmr ? 0 : -ENOMEM;
>> +}
> 
> No.
> 
> The whole point of RMRs is for devices that are already configured to access the given address range in a manner beyond the kernel's control. If you can do this, it proves that you should not have an RMR in the first place.
> 
> The notion of a kernel driver explicitly configuring its device to DMA into any random RMR that looks big enough is so egregiously wrong that I'm almost lost for words...
> 

our bios will reserve such a region and reported it through iort. the device will write to the region and in the driver we need to access the region
to get the traced data. the region is reserved exclusively and will not be accessed by kernel or other devices.

is it ok to let bios configure the address to the device and from CPU side we just read it?

Thanks,
Yicong


