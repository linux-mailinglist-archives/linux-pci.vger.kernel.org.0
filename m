Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C21348619
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 01:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhCYAxR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 20:53:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14523 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbhCYAwt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Mar 2021 20:52:49 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F5RN70KM8zNqRl;
        Thu, 25 Mar 2021 08:50:15 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.117) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 08:52:39 +0800
Subject: Re: [PATCH] pci: fix memory leak when virtio pci hotplug
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <bhelgaas@google.com>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
References: <20210323182428.GA584698@bjorn-Precision-5520>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <e2e405d3-a9a6-807d-dc7a-d6596214fbe9@huawei.com>
Date:   Thu, 25 Mar 2021 08:52:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20210323182428.GA584698@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for your suggestion.

I will rewrite the commit log and send the v2 patch.


On 2021/3/24 2:24, Bjorn Helgaas wrote:
> On Sun, Mar 21, 2021 at 11:29:30PM +0800, Zhiqiang Liu wrote:
>> From: Feilong Lin <linfeilong@huawei.com>
>>
>> Repeated hot-plugging of pci devices for a virtual
>> machine driven by virtio, we found that there is a
>> leak in kmalloc-4k, which was confirmed as the memory
>> of the pci_device structure. Then we found out that
>> it was missing pci_dev_put() after pci_get_slot() in
>> enable_slot() of acpiphp_glue.c.
>>
>> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
>> Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Since this came from you, Zhiqiang, it needs a signed-off-by (not just
> a reviewed-by) from you.  See
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.11#n361
>
> Also see
> https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com
> and
>
>   - Wrap commit log to fill 80 columns
>   - s/pci/PCI/ (subject and commit log)
>   - Run "git log --oneline drivers/pci/hotplug/acpiphp_glue.c".  It's
>     not completely consistent, but at least match the style of one of
>     them.
>
> There is no "pci_device" structure.  I think you mean the "struct
> pci_dev".
>
> The commit log doesn't actually say what the patch does.  It's obvious
> from the patch, but it should say in the commit log.  Look at previous
> commit logs to see how they do it.
>
>> ---
>>  drivers/pci/hotplug/acpiphp_glue.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
>> index 3365c93abf0e..f031302ad401 100644
>> --- a/drivers/pci/hotplug/acpiphp_glue.c
>> +++ b/drivers/pci/hotplug/acpiphp_glue.c
>> @@ -533,6 +533,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>>  			slot->flags &= ~SLOT_ENABLED;
>>  			continue;
>>  		}
>> +		pci_dev_put(dev);
>>  	}
>>  }
>>
>> -- 
>> 2.19.1
>>
>>
> .

