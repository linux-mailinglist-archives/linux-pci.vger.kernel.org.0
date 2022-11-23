Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7EE634DBC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 03:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiKWCSe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 21:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiKWCSd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 21:18:33 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80DFC0527
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 18:18:31 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NH4Xd6HxkzHw5Y;
        Wed, 23 Nov 2022 10:17:53 +0800 (CST)
Received: from [10.174.178.41] (10.174.178.41) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 10:18:30 +0800
Message-ID: <92523fb0-0df4-e0f9-d7ee-16e3c4cdc6ed@huawei.com>
Date:   Wed, 23 Nov 2022 10:18:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] PCI: cpqphp: Fix error handling in cpqhpc_init()
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <gregkh@suse.de>,
        <linux-pci@vger.kernel.org>
References: <20221122200551.GA212321@bhelgaas>
From:   Yuan Can <yuancan@huawei.com>
In-Reply-To: <20221122200551.GA212321@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.41]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2022/11/23 4:05, Bjorn Helgaas 写道:
> On Tue, Nov 22, 2022 at 10:13:46AM +0000, Yuan Can wrote:
>> The cpqhpc_init() returns the result of pci_register_driver() without
>> checking it, if pci_register_driver() failed, the debugfs created in
>> cpqhp_initialize_debugfs() is not removed, resulting the debugfs of
>> cpqhp can never be created later.
>> Fix by calling cpqhp_shutdown_debugfs() when pci_register_driver() failed.
> Add a blank line between paragraphs.
Ok.
>> Fixes: 9f3f4681291f ("[PATCH] PCI Hotplug: fix up the sysfs file in the compaq pci hotplug driver")
>> Signed-off-by: Yuan Can <yuancan@huawei.com>
>> ---
>>   drivers/pci/hotplug/cpqphp_core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
>> index c94b40e64baf..c47981ef92ea 100644
>> --- a/drivers/pci/hotplug/cpqphp_core.c
>> +++ b/drivers/pci/hotplug/cpqphp_core.c
>> @@ -1389,6 +1389,8 @@ static int __init cpqhpc_init(void)
>>   	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
>>   	cpqhp_initialize_debugfs();
>>   	result = pci_register_driver(&cpqhpc_driver);
>> +	if (result)
>> +		cpqhp_shutdown_debugfs();
> Is there some reason cpqhp_initialize_debugfs() needs to be called
> before pci_register_driver()?
>
> In other words, could we do this instead?
>
>    result = pci_register_driver(&cpqhpc_driver);
>    if (result)
>      return result;
>
>    cpqhp_initialize_debugfs();
>    return 0;
Thanks for the suggestion! I do not see any reason that the order must 
be kept, will change to this style in the next version.
> I assume this was found by code inspection?  I've never heard of
> anybody actually using this driver :)
Yes, you are right :)
>>   	dbg("pci_register_driver = %d\n", result);
>>   	return result;
>>   }
>> -- 
>> 2.17.1
>>
-- 
Best regards,
Yuan Can

