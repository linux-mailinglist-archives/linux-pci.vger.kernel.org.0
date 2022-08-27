Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9D5A3638
	for <lists+linux-pci@lfdr.de>; Sat, 27 Aug 2022 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiH0JPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Aug 2022 05:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiH0JPa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Aug 2022 05:15:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3641E1DA47;
        Sat, 27 Aug 2022 02:15:28 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MF9t157M3zYcsy;
        Sat, 27 Aug 2022 17:11:05 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 17:15:26 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 17:15:25 +0800
Subject: Re: [PATCH -next 1/3] PCI: fix double put_device() in error case in
 pci_create_root_bus()
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, Rob Herring <robh@kernel.org>
References: <20220826211401.GA2959769@bhelgaas>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <e901ef8c-e580-ba89-f161-bd0e6959483f@huawei.com>
Date:   Sat, 27 Aug 2022 17:15:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220826211401.GA2959769@bhelgaas>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2022/8/27 5:14, Bjorn Helgaas wrote:
> [+cc Rob]
>
> On Thu, Aug 25, 2022 at 08:27:51PM +0800, Yang Yingliang wrote:
>> If device_add() fails in pci_register_host_bridge(), the brigde device will
>> be put once, and it will be put again in error path of pci_create_root_bus().
>> Move the put_device() from pci_create_root_bus() to pci_register_host_bridge()
>> to fix this problem. And use device_unregister() instead of del_device() and
>> put_device().
> s/brigde/bridge/
>
>> Fixes: 9885440b16b8 ("PCI: Fix pci_host_bridge struct device release/free handling")
> If you're fixing a commit from somebody else, please always cc: the
> author because the author can help review the change.
OK.
>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/pci/probe.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index c5286b027f00..e500eb9d6468 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1027,7 +1027,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>>   
>>   unregister:
>>   	put_device(&bridge->dev);
>> -	device_del(&bridge->dev);
>> +	device_unregister(&bridge->dev);
> I don't understand this part.  device_unregister() looks like this:
>
>    void device_unregister(struct device *dev)
>    {
>      device_del(dev);
>      put_device(dev);
>    }
>
> So this calls put_device(&bridge->dev) twice, doesn't it?
>
> The "unregister" label looks poorly named.  We only get there if
> device_register() *failed*.  We shouldn't need to unregister anything
> in that case.
If it goes to the 'unregister' label, the bridge->dev has been register 
sucessfully (device_initialize() called from pci_alloc_host_bridge()
and device_add() called from pci_register_host_bridge()), so it need be 
unregister, and another put_device() is for decreasing
refcount of 'bus->bridge'.

Thanks,
Yang
>
>>   free:
>>   	kfree(bus);
>> @@ -3037,13 +3037,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>>   
>>   	error = pci_register_host_bridge(bridge);
>>   	if (error < 0)
>> -		goto err_out;
>> +		return NULL;
>>   
>>   	return bridge->bus;
>> -
>> -err_out:
>> -	put_device(&bridge->dev);
>> -	return NULL;
> This part looks right to me.  The get_device() is in
> pci_register_host_bridge(), and if pci_register_host_bridge() returns
> failure, I think it should first do the corresponding put_device().
>
>>   }
>>   EXPORT_SYMBOL_GPL(pci_create_root_bus);
>>   
>> -- 
>> 2.25.1
>>
> .
