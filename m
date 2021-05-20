Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8DB389BDC
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 05:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhETDbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 23:31:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4690 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhETDbL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 23:31:11 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlwCB1z6mz16QGL;
        Thu, 20 May 2021 11:27:02 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 11:29:48 +0800
Received: from [10.174.185.226] (10.174.185.226) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 11:29:48 +0800
Subject: Re: [PATCH v2] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
To:     Rob Herring <robh@kernel.org>
CC:     <will@kernel.org>, <joro@8bytes.org>, <frowand.list@gmail.com>,
        <helgaas@kernel.org>, <gregkh@linuxfoundation.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <xieyingtai@huawei.com>
References: <1621257425-37856-1-git-send-email-wangxingang5@huawei.com>
 <20210519191450.GA3469078@robh.at.kernel.org>
From:   Xingang Wang <wangxingang5@huawei.com>
Message-ID: <cd453893-3e3b-93ec-b826-9103677ac4f5@huawei.com>
Date:   Thu, 20 May 2021 11:29:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210519191450.GA3469078@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/5/20 3:14, Rob Herring wrote:
> On Mon, May 17, 2021 at 01:17:05PM +0000, Wang Xingang wrote:
>> From: Xingang Wang <wangxingang5@huawei.com>
>>
>> When booting with devicetree, the pci_request_acs() is called after the
>> enumeration and initialization of PCI devices, thus the ACS is not
>> enabled. This patch add check for IOMMU in of_core_init(), and call
>> pci_request_acs() when iommu is detected, making sure that the ACS will
>> be enabled.
>>
>> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
>> configuring IOMMU linkage")
>> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
>> ---
>>   drivers/iommu/of_iommu.c | 1 -
>>   drivers/of/base.c        | 9 ++++++++-
>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> Change log:
>> v1->v2:
>>   - remove pci_request_acs() in of_iommu_configure
>>   - check and call pci_request_acs() in of_core_init()
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index a9d2df001149..54a14da242cc 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>   			.np = master_np,
>>   		};
>>   
>> -		pci_request_acs();
>>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>>   					     of_pci_iommu_init, &info);
>>   	} else {
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 48e941f99558..95cd8f0e5435 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_device.h>
>>   #include <linux/of_graph.h>
>> +#include <linux/pci.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/slab.h>
>>   #include <linux/string.h>
>> @@ -166,7 +167,7 @@ void __of_phandle_cache_inv_entry(phandle handle)
>>   void __init of_core_init(void)
>>   {
>>   	struct device_node *np;
>> -
>> +	bool of_iommu_detect = false;
>>   
>>   	/* Create the kset, and register existing nodes */
>>   	mutex_lock(&of_mutex);
>> @@ -180,6 +181,12 @@ void __init of_core_init(void)
>>   		__of_attach_node_sysfs(np);
>>   		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
>>   			phandle_cache[of_phandle_cache_hash(np->phandle)] = np;
>> +
>> +		/* Detect IOMMU and make sure ACS will be enabled */
>> +		if (!of_iommu_detect && of_get_property(np, "iommu-map", NULL)) {
>> +			of_iommu_detect = true;
>> +			pci_request_acs();
>> +		}
> 
> Private DT internal init code doesn't seem like the right place for
> this. If this needs to be ordered WRT PCI device enumeration, then
> somewhere in the PCI host bridge or bus init code seems like the right
> place to me.
> 
> Also, shouldn't this be conditional on 'iommu-map' being in the host
> bridge or a parent or ??? rather than just any iommu-map anywhere in the
> DT.
> 

Thanks for your suggestion, I will fix this and move the modification to 
procedure of pci_host_common_probe(), and before pci_host_probe().

>>   	}
>>   	mutex_unlock(&of_mutex);
>>   
>> -- 
>> 2.19.1
>>
> .
> 
