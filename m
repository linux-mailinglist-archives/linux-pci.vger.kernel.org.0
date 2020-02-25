Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5990416BF4F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 12:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgBYLI3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 06:08:29 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60992 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbgBYLI3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 06:08:29 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01PB8NSa067869;
        Tue, 25 Feb 2020 05:08:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582628903;
        bh=uoMbkCSIoLLqj6dt4hwCMJGT3Flkqz8R3jYK/C0whnw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NeLcGKoR3RzYswwPTe6IX3bwX3wc3LzMxOc8HcU7xrEtY7XHfZAm5pcOc0RYhiPCm
         4i6/TQ7L/PJZxu/YmKZMIVVoICwuPPQghe4yNmbfi6/rnL/j/QAKavHFxgRaNW+heY
         04gVDfycTysZ2qCM1wEXZ8qIk5VfU/nSwzttATVY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01PB8NXa013010;
        Tue, 25 Feb 2020 05:08:23 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 05:08:23 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 05:08:23 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01PB8LJL024869;
        Tue, 25 Feb 2020 05:08:21 -0600
Subject: Re: [PATCH RESEND] PCI: endpoint: Fix clearing start entry in
 configfs
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1576844677-24933-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20200221141553.GA15440@e121166-lin.cambridge.arm.com>
 <20200225190506.7DFA.4A936039@socionext.com>
 <20200225101825.GA4029@e121166-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4d45a8c2-c9db-6e2e-b223-69df26687e32@ti.com>
Date:   Tue, 25 Feb 2020 16:42:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225101825.GA4029@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 25/02/20 3:48 pm, Lorenzo Pieralisi wrote:
> On Tue, Feb 25, 2020 at 07:05:07PM +0900, Kunihiko Hayashi wrote:
>> Hi Lorenzo,
>>
>> On Fri, 21 Feb 2020 14:15:53 +0000 <lorenzo.pieralisi@arm.com> wrote:
>>
>>> On Fri, Dec 20, 2019 at 09:24:37PM +0900, Kunihiko Hayashi wrote:
>>>> The value of 'start' entry is no change whenever writing 0 to configfs.
>>>> So the endpoint that stopped once can't restart.
>>>>
>>>> The following command lines are an example restarting endpoint and
>>>> reprogramming configurations after receiving bus-reset.
>>>>
>>>>     echo 0 > controllers/66000000.pcie-ep/start
>>>>     rm controllers/66000000.pcie-ep/func1
>>>>     ln -s functions/pci_epf_test/func1 controllers/66000000.pcie-ep/
>>>>     echo 1 > controllers/66000000.pcie-ep/start
>>>>
>>>> However, the first 'echo' can't set 0 to 'start', so the last 'echo' can't
>>>> restart endpoint.
>>>
>>> I think your description is not correct - pci_epc_group->start is
>>> just used to check if an endpoint has been started or not (in
>>> pci_epc_epf_unlink() and that's a WARN_ON) but nonetheless this
>>> looks like a bug and ought to be fixed.
>>
>> When pci_epc_group->start keeps 1 after starting this controller with
>> 'echo 1 > start', we can never unlink the func1 from the controller
>> because of WARN_ON.
> 
> To me "I can never unlink" means that it can't be done, which
> is not what's happening. What's happening is that unlinking triggers
> a warning, which is different.
> 
>> I think that unlink/re-link play initialization role of configfs
>> through 'unbind' and 'bind' functions. However, we can't re-initialize
>> configfs.
>>
>> If this is the intended behavior, my patch will make no sense.
> 
> Your patch makes sense, your commit log does not, see above.
> 
>>> I need Kishon's ACK to proceed.
> 
> Yes - then I am happy to merge this patch with a rewritten
> commit log.

I think all this patch does is fixes an in-correct WARN_ON. The start
and stop of endpoint should happen irrespective of this patch. Once the
commit log is fixed to indicate that

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
> 
> Thanks,
> Lorenzo
> 
>> I think so, too.
>>
>> Thank you,
>>
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>>> Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
>>>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>> ---
>>>>  drivers/pci/endpoint/pci-ep-cfs.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
>>>> index d1288a0..4fead88 100644
>>>> --- a/drivers/pci/endpoint/pci-ep-cfs.c
>>>> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
>>>> @@ -58,6 +58,7 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
>>>>  
>>>>  	if (!start) {
>>>>  		pci_epc_stop(epc);
>>>> +		epc_group->start = 0;
>>>>  		return len;
>>>>  	}
>>>>  
>>>> -- 
>>>> 2.7.4
>>>>
>>
>> ---
>> Best Regards,
>> Kunihiko Hayashi
>>
