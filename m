Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9497C558CB4
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 03:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiFXBPx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 21:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFXBPx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 21:15:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8875456770;
        Thu, 23 Jun 2022 18:15:51 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LTfHD16ZjzShC2;
        Fri, 24 Jun 2022 09:12:24 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 09:15:49 +0800
Received: from [127.0.0.1] (10.67.111.83) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 24 Jun
 2022 09:15:49 +0800
Message-ID: <cf645f1f-9368-3466-6e6d-09ea48a9c3a0@huawei.com>
Date:   Fri, 24 Jun 2022 09:15:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXT] Re: [PATCH -next] NTB: EPF: Fix Kconfig dependency
To:     Frank Li <frank.li@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <PAXPR04MB91861EE0E20E9EC71F4C494288B59@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <20220623155524.GA1452766@bhelgaas>
 <PAXPR04MB91865EE1D156F47DB8D9EE4B88B59@PAXPR04MB9186.eurprd04.prod.outlook.com>
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <PAXPR04MB91865EE1D156F47DB8D9EE4B88B59@PAXPR04MB9186.eurprd04.prod.outlook.com>
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

在 2022/6/23 23:58, Frank Li 写道:
>
>> -----Original Message-----
>> From: Bjorn Helgaas <helgaas@kernel.org>
>> Sent: Thursday, June 23, 2022 10:55 AM
>> To: Frank Li <frank.li@nxp.com>
>> Cc: Ren Zhijie <renzhijie2@huawei.com>; kishon@ti.com;
>> lpieralisi@kernel.org; kw@linux.com; bhelgaas@google.com;
>> jdmason@kudzu.us; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [EXT] Re: [PATCH -next] NTB: EPF: Fix Kconfig dependency
>>
>> Caution: EXT Email
>>
>> On Thu, Jun 23, 2022 at 03:36:38PM +0000, Frank Li wrote:
>>>> -----Original Message-----
>>>> From: Ren Zhijie <renzhijie2@huawei.com>
>>>> Sent: Thursday, June 23, 2022 3:46 AM
>>>> To: kishon@ti.com; lpieralisi@kernel.org; kw@linux.com;
>>>> bhelgaas@google.com; jdmason@kudzu.us; Frank Li <frank.li@nxp.com>
>>>> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Ren Zhijie
>>>> <renzhijie2@huawei.com>
>>>> Subject: [PATCH -next] NTB: EPF: Fix Kconfig dependency
>> @Ren, please use a typical subject line for the file, e.g.,
>>
>>    PCI: endpoint: ...
>>
>>>> If CONFIG_NTB is not set and CONFIG_PCI_EPF_VNTB is y.
>>>>
>>>> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed,
>> like
>>>> this:
>>>>
>>>> drivers/pci/endpoint/functions/pci-epf-vntb.o: In function
>>>> `epf_ntb_cmd_handler':
>>>> pci-epf-vntb.c:(.text+0x95e): undefined reference to `ntb_db_event'
>>>> pci-epf-vntb.c:(.text+0xa1f): undefined reference to `ntb_link_event'
>>>> pci-epf-vntb.c:(.text+0xa42): undefined reference to `ntb_link_event'
>>>> drivers/pci/endpoint/functions/pci-epf-vntb.o: In function
>> `pci_vntb_probe':
>>>> pci-epf-vntb.c:(.text+0x1250): undefined reference to
>> `ntb_register_device'
>>>> The functions ntb_*() are defined in drivers/ntb/core.c, which need
>>>> CONFIG_NTB setting y to be build-in.
>>>> To fix this build error, add depends on NTB.
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Fixes: ff32fac00d97("NTB: EPF: support NTB transfer between PCI RC and
>> EP
>>>> connection")
>>>> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
>>>> ---
>>> [Frank Li] Acked
>> @Frank: if you use the conventional style, e.g.,
>> "Acked-by: Frank Li <frank.li@nxp.com>", tooling like b4 will
>> automatically pick it up.  Just saying "Acked" is likely to get missed
>> or ignored.
> Thanks.
> Acked-by: Frank Li <frank.li@nxp.com>

sure, will fix it in patch v2.


Thanks,

Ren Zhijie

>>>>   drivers/pci/endpoint/functions/Kconfig | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/pci/endpoint/functions/Kconfig
>>>> b/drivers/pci/endpoint/functions/Kconfig
>>>> index 362555b024e8..9beee4f0f4ee 100644
>>>> --- a/drivers/pci/endpoint/functions/Kconfig
>>>> +++ b/drivers/pci/endpoint/functions/Kconfig
>>>> @@ -29,6 +29,7 @@ config PCI_EPF_NTB
>>>>   config PCI_EPF_VNTB
>>>>           tristate "PCI Endpoint NTB driver"
>>>>           depends on PCI_ENDPOINT
>>>> +        depends on NTB
>>>>           select CONFIGFS_FS
>>>>           help
>>>>             Select this configuration option to enable the Non-Transparent
>>>> --
>>>> 2.17.1
> .

