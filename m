Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28797256416
	for <lists+linux-pci@lfdr.de>; Sat, 29 Aug 2020 04:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgH2CDz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Aug 2020 22:03:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbgH2CDy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Aug 2020 22:03:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1DF10736A7399FD57229;
        Sat, 29 Aug 2020 10:03:48 +0800 (CST)
Received: from [127.0.0.1] (10.67.103.235) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 29 Aug 2020
 10:03:45 +0800
Subject: Re: [PATCH] lspci: Decode 10-Bit Tag Requester Enable
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200828164931.GA2161257@bjorn-Precision-5520>
CC:     <mj@ucw.cz>, <linux-pci@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <e83a7f8d-8eed-b222-4f21-7333876330b7@huawei.com>
Date:   Sat, 29 Aug 2020 10:03:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200828164931.GA2161257@bjorn-Precision-5520>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn

Many thanks for your review.
On 2020/8/29 0:49, Bjorn Helgaas wrote:
> On Sat, Aug 01, 2020 at 03:21:20PM +0800, Dongdong Liu wrote:
>> Decode 10-Bit Tag Requester Enable bit in Device Control 2 Register.
>>
>> Sample output changes:
>>
>>   - DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
>>   + DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled, ARIFwd-
>>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> ---
>>  lib/header.h | 1 +
>>  ls-caps.c    | 3 ++-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/header.h b/lib/header.h
>> index 472816e..eaf6517 100644
>> --- a/lib/header.h
>> +++ b/lib/header.h
>> @@ -898,6 +898,7 @@
>>  #define  PCI_EXP_DEVCAP2_64BIT_ATOMICOP_COMP	0x0100	/* 64bit AtomicOp Completer Supported */
>>  #define  PCI_EXP_DEVCAP2_128BIT_CAS_COMP	0x0200	/* 128bit CAS Completer Supported */
>>  #define  PCI_EXP_DEV2_LTR		0x0400	/* LTR enabled */
>> +#define  PCI_EXP_DEV2_10BIT_TAG_REQ	0x1000 /* 10 Bit Tag Requester enabled */
>
> Looks OK to me (but I don't maintain lspci, of course).
>
> And we have a bit of a mess in the names here.  There are a bunch of
> "PCI_EXP_DEV2_*" names that would be "PCI_EXP_DEVCTL2_*" if they
> followed the convention.  You didn't start that trend, so I'm just
> pointing it out in case you or Martin want to clean it up.  When I add
> names I try to use the same name between the Linux kernel source [1]
> and lspci.

Will do in next patch.

Thanks,
Dongdong
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/pci_regs.h#n651
>
>>  #define  PCI_EXP_DEV2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
>>  #define PCI_EXP_DEVSTA2			0x2a	/* Device Status */
>>  #define PCI_EXP_LNKCAP2			0x2c	/* Link Capabilities */
>> diff --git a/ls-caps.c b/ls-caps.c
>> index a09b0cf..d17cbad 100644
>> --- a/ls-caps.c
>> +++ b/ls-caps.c
>> @@ -1134,10 +1134,11 @@ static void cap_express_dev2(struct device *d, int where, int type)
>>      }
>>
>>    w = get_conf_word(d, where + PCI_EXP_DEVCTL2);
>> -  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c LTR%c OBFF %s,",
>> +  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c LTR%c 10BitTagReq%c OBFF %s,",
>>  	cap_express_dev2_timeout_value(PCI_EXP_DEV2_TIMEOUT_VALUE(w)),
>>  	FLAG(w, PCI_EXP_DEV2_TIMEOUT_DIS),
>>  	FLAG(w, PCI_EXP_DEV2_LTR),
>> +	FLAG(w, PCI_EXP_DEV2_10BIT_TAG_REQ),
>>  	cap_express_devctl2_obff(PCI_EXP_DEV2_OBFF(w)));
>>    if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
>>      printf(" ARIFwd%c\n", FLAG(w, PCI_EXP_DEV2_ARI));
>> --
>> 1.9.1
>>
>
> .
>

