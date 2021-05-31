Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FEC3959A6
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 13:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhEaL0A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 07:26:00 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3304 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhEaLZ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 07:25:59 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ftt9M4T2rz1BGBj;
        Mon, 31 May 2021 19:19:35 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 19:24:15 +0800
Received: from [10.174.185.226] (10.174.185.226) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 19:24:15 +0800
To:     Rob Herring <robh@kernel.org>
CC:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, <xieyingtai@huawei.com>
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
 <CAL_JsqJep2rpPN8r8PzT5fv32mmjMvg+k-=jzLp4S1QzC+LcLg@mail.gmail.com>
From:   Xingang Wang <wangxingang5@huawei.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
Message-ID: <12828bb9-7172-4efe-a6f2-5fb066d21ddb@huawei.com>
Date:   Mon, 31 May 2021 19:24:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJep2rpPN8r8PzT5fv32mmjMvg+k-=jzLp4S1QzC+LcLg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi everyone,

On 2021/5/22 3:03, Rob Herring wrote:
> On Thu, May 20, 2021 at 10:03 PM Wang Xingang <wangxingang5@huawei.com> wrote:
>>
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
>> ---
>>   drivers/iommu/of_iommu.c | 1 -
>>   drivers/pci/of.c         | 8 +++++++-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Ping, is this patch appropriate for mainline?

>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index a9d2df001149..54a14da242cc 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>                          .np = master_np,
>>                  };
>>
>> -               pci_request_acs();
>>                  err = pci_for_each_dma_alias(to_pci_dev(dev),
>>                                               of_pci_iommu_init, &info);
>>          } else {
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index da5b414d585a..2313c3f848b0 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>>
>>   int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>>   {
>> -       if (!dev->of_node)
>> +       struct device_node *node = dev->of_node;
>> +
>> +       if (!node)
>>                  return 0;
>>
>> +       /* Detect IOMMU and make sure ACS will be enabled */
>> +       if (of_property_read_bool(node, "iommu-map"))
>> +               pci_request_acs();
>> +
>>          bridge->swizzle_irq = pci_common_swizzle;
>>          bridge->map_irq = of_irq_parse_and_map_pci;
>>
>> --
>> 2.19.1
>>
> .
> 
