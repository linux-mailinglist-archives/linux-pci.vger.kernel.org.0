Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919EE635131
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 08:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiKWHmy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 02:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiKWHmw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 02:42:52 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A1C7018A
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 23:42:50 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NHCkx6Ktwz15MnT;
        Wed, 23 Nov 2022 15:42:17 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 15:42:48 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 15:42:47 +0800
Subject: Re: [PATCH] PCI: fix double put_device() in error case in
 pci_create_root_bus()
To:     Thierry Reding <treding@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <arnd@arndb.de>, <yangyingliang@huawei.com>
References: <20221018035134.2016891-1-yangyingliang@huawei.com>
 <Y06CE+xz2h6dBpC6@orome>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <2f69e347-a5c8-a04c-f131-bbc9bc9c5a38@huawei.com>
Date:   Wed, 23 Nov 2022 15:42:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y06CE+xz2h6dBpC6@orome>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Helgaas,

On 2022/10/18 18:38, Thierry Reding wrote:
> On Tue, Oct 18, 2022 at 11:51:34AM +0800, Yang Yingliang wrote:
>> If device_add() fails in pci_register_host_bridge(), the bridge device will
>> be put once, and it will be put again in error path of pci_create_root_bus().
>> Fix this by removing put_device() after device_add() is failed.
I think it's a obvious problem.
Is this patch look good to you or any suggestion?

Thanks,
Yang
>>
>> Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/pci/probe.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
> Seems fine. All callers, as far as I can tell, of this end up invoking
> pci_free_host_bridge() which does the corresponding put_device() itself:
>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
