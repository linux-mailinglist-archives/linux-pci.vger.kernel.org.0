Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0A32D939F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 08:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgLNHZ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 02:25:27 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9435 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgLNHZ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2020 02:25:27 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CvXvN2j1szhsDs;
        Mon, 14 Dec 2020 15:24:16 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 15:24:42 +0800
Subject: Re: [PATCH] PCI: fix use-after-free in pci_register_host_bridge
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201120074848.31418-1-miaoqinglang@huawei.com>
 <20201211154652.GA313883@robh.at.kernel.org>
From:   Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <db2c9d2f-29b1-2bff-1261-7da6f5baaf4a@huawei.com>
Date:   Mon, 14 Dec 2020 15:24:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201211154652.GA313883@robh.at.kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



ÔÚ 2020/12/11 23:46, Rob Herring Ð´µÀ:
> On Fri, Nov 20, 2020 at 03:48:48PM +0800, Qinglang Miao wrote:
>> When put_device(&bridge->dev) being called, kfree(bridge) is inside
>> of release function, so the following device_del would cause a
>> use-after-free bug.
>>
>> Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
> 
> That commit did have some problems, but this patch doesn't apply to that
> commit. See commits 1b54ae8327a4 and 9885440b16b8.
> 
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>> ---
>>   drivers/pci/probe.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 4289030b0..82292e87e 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -991,8 +991,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>>   	return 0;
>>   
>>   unregister:
>> -	put_device(&bridge->dev);
>>   	device_del(&bridge->dev);
>> +	put_device(&bridge->dev);
> 
> I don't think this is right.
> 
> Let's look at pci_register_host_bridge() with only the relevant
> sections:
> 
> static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> {
> 	...
> 
> 	err = device_add(&bridge->dev);
> 	if (err) {
> 		put_device(&bridge->dev);
> 		goto free;
> 	}
> 	bus->bridge = get_device(&bridge->dev);
> 
>          ...
> 	if (err)
> 		goto unregister;
> 	...
> 
> 	return 0;
> 
> unregister:
> 	put_device(&bridge->dev);
> 	device_del(&bridge->dev);
> 
> free:
> 	kfree(bus);
> 	return err;
> }
> 
> The documentation for device_add says this:
>   * Rule of thumb is: if device_add() succeeds, you should call
>   * device_del() when you want to get rid of it. If device_add() has
>   * *not* succeeded, use *only* put_device() to drop the reference
>   * count.
> 
> The put_device at the end is to balance the get_device after device_add.
> It will *only* decrement the use count. Then we call device_del as the
> documentation says.
> 
> Rob
> .
Hi, Rob

Your words make sence to me: the code is *logicly* correct here and 
won't raise a use-after-free bug. I do hold a misunderstanding of this 
one, sorry for that ~

But I still think this patch should be reconsidered:

The kdoc of device_unregister explicitly mentions the possibility that 
other refs might continue to exist after device_unregister was called, 
and *del_device* is first part of it.

By the way, 'del_device() called before put_device()' is everywhere in 
kernel code, like device_unregister(), pci_destroy_dev() or 
switchtec_pci_remove()

In fact, I can't find another place in kernel code looks like:
	put_device(x);
  	device_del(x);

So I guess put_device() ought to be the last time we touch the object 
(I don't find evidence strong enough in kdoc to prove this) and putting 
put_device after device_del is a more natural logic.

Qinglang
.

> 
