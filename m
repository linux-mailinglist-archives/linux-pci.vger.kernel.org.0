Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415935A3652
	for <lists+linux-pci@lfdr.de>; Sat, 27 Aug 2022 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiH0J3l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Aug 2022 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiH0J3k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Aug 2022 05:29:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467E131341;
        Sat, 27 Aug 2022 02:29:38 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MFBFP2mrmzGpGr;
        Sat, 27 Aug 2022 17:27:53 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 17:29:36 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 17:29:35 +0800
Subject: Re: [PATCH -next 2/3] PCI: fix possible memory leak in error case in
 pci_register_host_bridge()
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh@kernel.org>
References: <20220826223810.GA2961041@bhelgaas>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <83f42399-6dc3-d227-bb48-891172e061f9@huawei.com>
Date:   Sat, 27 Aug 2022 17:29:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220826223810.GA2961041@bhelgaas>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


On 2022/8/27 6:38, Bjorn Helgaas wrote:
> [+cc Arnd, Rob]
>
> On Thu, Aug 25, 2022 at 08:27:52PM +0800, Yang Yingliang wrote:
>> If device_register() fails in pci_register_host_bridge(), the refcount
>> of bus device is leaked, so device name that set by dev_set_name() can
>> not be freed. Fix this by calling put_device() when device_register()
>> fails, so the device name will be freed in kobject_cleanup().
>>
>> Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/pci/probe.c | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index e500eb9d6468..292d9da146ce 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -948,8 +948,17 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>>   	name = dev_name(&bus->dev);
>>   
>>   	err = device_register(&bus->dev);
>> -	if (err)
>> -		goto unregister;
>> +	if (err) {
>> +		/*
>> +		 * release_pcibus_dev() will decrease the refcount of bridge
>> +		 * device and free the memory of bus.
>> +		 * The memory of bus device name will be freed when the refcount
>> +		 * get to zero.
>> +		 */
>> +		put_device(&bus->dev);
>> +		device_unregister(&bridge->dev);
>> +		return err;
>> +	}
> Calling put_device(X) after device_register(X) returns failure doesn't
> need explanation because that's the standard pattern.  I think that
> was just missing before.
>
> In this error case, we previously did called put_device() for the
> *bridge* instead of the bus.  That was likely a typo and seems like
> the important thing here.
put_device() for the bridge will be called in the callback of put for 
the bus.
So it doesn't call put bridge device here.

Thanks,
Yang
>>   	pcibios_add_bus(bus);
>>   
>> @@ -1025,10 +1034,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>>   
>>   	return 0;
>>   
>> -unregister:
>> -	put_device(&bridge->dev);
>> -	device_unregister(&bridge->dev);
>> -
>>   free:
>>   	kfree(bus);
>>   	return err;
>> -- 
>> 2.25.1
>>
> .
