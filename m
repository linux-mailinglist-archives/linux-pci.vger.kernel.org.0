Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB9A56C60B
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 04:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiGICu6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 22:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGICu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 22:50:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13F17AB1A;
        Fri,  8 Jul 2022 19:50:55 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lfvgl3RtRzTgtg;
        Sat,  9 Jul 2022 10:47:15 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Jul 2022 10:50:53 +0800
Received: from [127.0.0.1] (10.67.111.83) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 9 Jul
 2022 10:50:53 +0800
Message-ID: <cdaf434f-90d5-696f-2a60-5946ecefcf0b@huawei.com>
Date:   Sat, 9 Jul 2022 10:50:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] PCI: endpoint: Fix Kconfig dependency
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Mason <jdmason@kudzu.us>
CC:     <kishon@ti.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <Frank.Li@nxp.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220627202528.GA1775049@bhelgaas>
 <687deec4-b799-0abc-5cf1-c65021c36ebd@infradead.org>
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <687deec4-b799-0abc-5cf1-c65021c36ebd@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn and jon

Just a friendly ping ...

Is this patch be merged or squashed?

在 2022/6/30 2:51, Randy Dunlap 写道:
>
> On 6/27/22 13:25, Bjorn Helgaas wrote:
>> On Mon, Jun 27, 2022 at 03:07:50PM -0500, Bjorn Helgaas wrote:
>>> On Mon, Jun 27, 2022 at 02:57:14PM -0500, Bjorn Helgaas wrote:
>>>> On Fri, Jun 24, 2022 at 09:19:11AM +0800, Ren Zhijie wrote:
>>>>> If CONFIG_NTB is not set and CONFIG_PCI_EPF_VNTB is y.
>>>>>
>>>>> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:
>>>>>
>>>>> drivers/pci/endpoint/functions/pci-epf-vntb.o: In function `epf_ntb_cmd_handler':
>>>>> pci-epf-vntb.c:(.text+0x95e): undefined reference to `ntb_db_event'
>>>>> pci-epf-vntb.c:(.text+0xa1f): undefined reference to `ntb_link_event'
>>>>> pci-epf-vntb.c:(.text+0xa42): undefined reference to `ntb_link_event'
>>>>> drivers/pci/endpoint/functions/pci-epf-vntb.o: In function `pci_vntb_probe':
>>>>> pci-epf-vntb.c:(.text+0x1250): undefined reference to `ntb_register_device'
>>>>>
>>>>> The functions ntb_*() are defined in drivers/ntb/core.c, which need CONFIG_NTB setting y to be build-in.
>>>>> To fix this build error, add depends on NTB.
>>>>>
>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>>> Fixes: ff32fac00d97("NTB: EPF: support NTB transfer between PCI RC and EP connection")
>>>>> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
>>>>> Acked-by: Frank Li <frank.li@nxp.com>
>>>> Am I missing something?
>>>>
>>>>    02:54:01 ~/linux (next)$ git checkout -b wip/ren-endpoint-ntb v5.19-rc1
>>>>    Switched to a new branch 'wip/ren-endpoint-ntb'
>>>>    02:54:23 ~/linux (wip/ren-endpoint-ntb)$ b4 am -om/ https://lore.kernel.org/r/20220624011911.164146-1-renzhijie2@huawei.com
>>>>    02:54:47 ~/linux (wip/ren-endpoint-ntb)$ git am m/20220624_renzhijie2_pci_endpoint_fix_kconfig_dependency.mbx
>>>>    Applying: PCI: endpoint: Fix Kconfig dependency
>>>>    error: patch failed: drivers/pci/endpoint/functions/Kconfig:29
>>>>
>>>> Obviously I could fix this manually, but if there's something wrong
>>>> with your patch posting process, we should fix it.
>>> Oh, I see the problem.  This patch depends on some other VNTB patch
>>> that hasn't been merged yet.  That means this fix should be squashed
>>> into the VNTB patch that adds "config PCI_EPF_VNTB".
>> Well, I saw *part* of the problem.  This fixes something that is in
>> -next, added by ff32fac00d97 ("NTB: EPF: support NTB transfer between
>> PCI RC and EP connection") [1], which was merged by Jon.
>>
>> So I guess Jon will squash and update his branch or merge the
>> fixup(s).
>>
>> (Jon, if you squash, note there are several typos in the commit log:
>> s/Virtual NTB/virtual NTB/, s/include/includes/, s/3 part/3 parts/,
>> s/virutal/virtual, s/pci/PCI/, s/BUS/Bus/)
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ff32fac00d97
>>
>>>>> ---
>>>>> v2: Fix some commit message errors
>>>>> ---
>>>>>   drivers/pci/endpoint/functions/Kconfig | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
>>>>> index 362555b024e8..9beee4f0f4ee 100644
>>>>> --- a/drivers/pci/endpoint/functions/Kconfig
>>>>> +++ b/drivers/pci/endpoint/functions/Kconfig
>>>>> @@ -29,6 +29,7 @@ config PCI_EPF_NTB
>>>>>   config PCI_EPF_VNTB
>>>>>           tristate "PCI Endpoint NTB driver"
>>>>>           depends on PCI_ENDPOINT
>>>>> +        depends on NTB
>>>>>           select CONFIGFS_FS
>>>>>           help
>>>>>             Select this configuration option to enable the Non-Transparent
>>>>> -- 
> Works for me. Thanks.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
>
> maybe even
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> (see https://lore.kernel.org/linux-next/835b844b-9d9d-615c-af11-44154c2a8102@infradead.org/)
>

