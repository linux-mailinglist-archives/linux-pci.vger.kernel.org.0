Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EADD3FD74D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 11:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhIAJ7d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 05:59:33 -0400
Received: from foss.arm.com ([217.140.110.172]:35330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhIAJ7c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Sep 2021 05:59:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 176E61042;
        Wed,  1 Sep 2021 02:58:36 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A5AC3F766;
        Wed,  1 Sep 2021 02:58:34 -0700 (PDT)
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Wang Xingang <wangxingang5@huawei.com>, robh@kernel.org,
        will@kernel.org, joro@8bytes.org, helgaas@kernel.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, xieyingtai@huawei.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
 <CGME20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2@eucas1p2.samsung.com>
 <01314d70-41e6-70f9-e496-84091948701a@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f3087045-1f0e-aa1a-d3f7-9e88bccca925@arm.com>
Date:   Wed, 1 Sep 2021 10:58:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <01314d70-41e6-70f9-e496-84091948701a@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-09-01 09:59, Marek Szyprowski wrote:
> On 21.05.2021 05:03, Wang Xingang wrote:
>> From: Xingang Wang <wangxingang5@huawei.com>
>>
>> When booting with devicetree, the pci_request_acs() is called after the
>> enumeration and initialization of PCI devices, thus the ACS is not
>> enabled. And ACS should be enabled when IOMMU is detected for the
>> PCI host bridge, so add check for IOMMU before probe of PCI host and call
>> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
>> devices.
>>
>> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
>> configuring IOMMU linkage")
>> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> 
> This patch landed in linux-next as commit 57a4ab1584e6 ("iommu/of: Fix
> pci_request_acs() before enumerating PCI devices"). Sadly it breaks PCI
> operation on ARM Juno R1 board (arch/arm64/boot/dts/arm/juno-r1.dts). It
> looks that the IOMMU controller is not probed for some reasons:
> 
> # cat /sys/kernel/debug/devices_deferred
> 2b600000.iommu

That IOMMU belongs to the CoreSight debug subsystem and often gets stuck 
waiting for a power domain (especially if you have a mismatch of 
SCPI/SCMI expectations between the DT and SCP firmware). Unless you're 
trying to use CoreSight trace that shouldn't matter.

The PCIe on Juno doesn't support ACS anyway, so I'm puzzled why this 
should make any difference :/

Robin.

> Reverting this patch on top of current linux-next fixes this issue. If
> you need more information to debug this issue, just let me know.
> 
>> ---
>>    drivers/iommu/of_iommu.c | 1 -
>>    drivers/pci/of.c         | 8 +++++++-
>>    2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index a9d2df001149..54a14da242cc 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>    			.np = master_np,
>>    		};
>>    
>> -		pci_request_acs();
>>    		err = pci_for_each_dma_alias(to_pci_dev(dev),
>>    					     of_pci_iommu_init, &info);
>>    	} else {
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index da5b414d585a..2313c3f848b0 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>>    
>>    int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>>    {
>> -	if (!dev->of_node)
>> +	struct device_node *node = dev->of_node;
>> +
>> +	if (!node)
>>    		return 0;
>>    
>> +	/* Detect IOMMU and make sure ACS will be enabled */
>> +	if (of_property_read_bool(node, "iommu-map"))
>> +		pci_request_acs();
>> +
>>    	bridge->swizzle_irq = pci_common_swizzle;
>>    	bridge->map_irq = of_irq_parse_and_map_pci;
>>    
> 
> Best regards
> 
