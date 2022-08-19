Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0585995A8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 09:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbiHSG6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 02:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346469AbiHSG6Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 02:58:16 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950306330;
        Thu, 18 Aug 2022 23:58:15 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27J6w1ve037308;
        Fri, 19 Aug 2022 01:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660892281;
        bh=4hILr9mwysClVQmLXuoXs+Yh9Qr4uEAq3TEQk0aZ9TY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=xlJCz4L8ww8LLhJWZ29DVMHoVSA6+BGTGnckj3xI7LTm+lCnC7ADHlDrK+DoMeFXb
         wuHJkEvu0bdQiUSLMqi9QN3KMxLgjFM3kSH4WNkx8sq/9IiRRClc28BGp1yWPRRLYS
         lxxlKcmjzNETKUjQQGHsqoarcrcBlJGI2EbHQ7E4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27J6w1Hj001477
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Aug 2022 01:58:01 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 19
 Aug 2022 01:58:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 19 Aug 2022 01:58:00 -0500
Received: from [172.24.147.145] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27J6vwIw025185;
        Fri, 19 Aug 2022 01:57:58 -0500
Message-ID: <06015c8a-2dbe-bc5f-4b8e-2ee87ee5910c@ti.com>
Date:   Fri, 19 Aug 2022 12:27:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MAINTAINERS: add PCI Endpoint NTB drivers to NTB files
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jon Mason <jdmason@kudzu.us>
CC:     <ntb@lists.linux.dev>, Bjorn Helgaas <helgaas@kernel.org>,
        <Frank.Li@nxp.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220812194205.388967-1-jdmason@kudzu.us>
 <20220818060230.GA12008@thinkpad> <Yv5EA8uuhwn049jx@kudzu.us>
 <20220818145115.GA111116@thinkpad>
From:   Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <20220818145115.GA111116@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 18/08/22 20:21, Manivannan Sadhasivam wrote:
> On Thu, Aug 18, 2022 at 09:52:03AM -0400, Jon Mason wrote:
>> On Thu, Aug 18, 2022 at 11:32:30AM +0530, Manivannan Sadhasivam wrote:
>>> + Kishon (PCI EP Maintainer)
>>>
>>> On Fri, Aug 12, 2022 at 03:42:05PM -0400, Jon Mason wrote:
>>>> The PCI Endpoint NTB drivers are under the NTB umbrella.  Add an entry
>>>> there to allow for notification of changes for it.
>>>>
>>>> Signed-off-by: Jon Mason <jdmason@kudzu.us>
>>>
>>> Hi Jason,
>>
>> I assume you mean me.  Odd that you got my name wrong 2 lines below it
>> being properly written out.
>>
> 
> Terribly sorry about that! I was reading another thread just before this
> and misspelled your name.
> 
>>> I know that this patch is already in Linus's tree but I think this PCI Endpoint
>>> VNTB driver is not going in a correct path. First, Kishon is not convinced with
>>> the way the PCI Endpoint VNTB function driver is written currently. He prefers
>>> the VirtIO approach over the current one [1].
>>
>> To your point, this is already in Linus' tree.  If it is not the way
>> people want it, patches accepted.
>>
>> Kishon (in the thread) recommended doing it one way, and Frank
>> responded he liked doing it another.  Kishon didn't respond to that
>> last email.  To me, this is an acceptable technical disagreement that
>> can be addressed in the future and no need to prevent working patches
>> from being accepted.
>>
> 
> Kishon being the maintainer proposed an entirely different way of representing
> the driver. I agree that the patch is working but maintainer's view matters and
> if you don't hear from the maintainer for some time, you'll ping them (Frank
> did ping but there is something called RESEND).
> 
> I'm not sure that merging the patches without an ACK from the relevant subsystem
> maintainer is the right thing to do.
> 
>>> But while the conversation was still going on, the series got merged via NTB
>>> tree without any ACKs from the PCI/PCI_EP maintainers. Also, note that there
>>> was a patch touching the PCI Controller driver as well and that was also not
>>> ACKed [2].
>>
>> I put the series in my ntb-next branch, which was pulled into linux-next
>> for roughly 3 months, and he did not object then (though likely he did
>> not notice).  Multiple patches were submitted to the relevant mailing
>> lists to address minor issues in the series (from being in linux-next)
>> and most/all of those hit the PCI mailing list.  Bjorn responded to
>> all of them saying they needed to go through the ntb tree (because of
>> the dependency on Frank Li's original series).  So while not an
>> explicit ack, it was implicit to me in that he was aware of the
>> series.
Definitely take the blame for not registering my objection though I felt
I might be the odd one out for proposing a different way and rest are in
alignment to get it merged.

>>
>> Given the length of time and the public work on the series, how much
>> longer should I have waited for a nack?
>>
> 
> I'd argue that you should've waited for the ACK first. I've seen and
> experienced patch series hanging there for multiple releases. I'm not in favour
> of not responding to the patches, maintainers do have their own work to do but
> merging the patches touching the different subsystem without an ACK doesn't
> sound good to me.
> 
> I don't know why he didn't object when the series got merged in this manner :/
> 
>>> If this trend is going to continue in the coming days, then I'm afraid that NTB
>>> might end up being a backdoor for PCI/PCI_EP patches :(
>>
>> Completely unfounded, per Bjorn's comment on
>> https://lore.kernel.org/all/20220815183920.GA1960006@bhelgaas/
>>
> 

> It's now fine that NTB related PCI patches can be merged through NTB tree but
> please wait for an ACK for patches touching the non-NTB drivers. If you ask me
> how long you should wait, then I don't have an answer, but atleast give a
> notice before doing so that it can catch the proper eyes.

+1

Thanks,
Kishon

> 
> Thanks,
> Mani
> 
>> Thanks,
>> Jon
>>
>>>
>>> Thanks,
>>> Mani
>>>
>>> [1] https://lore.kernel.org/all/20220222162355.32369-4-Frank.Li@nxp.com
>>> [2] https://lore.kernel.org/all/20220222162355.32369-2-Frank.Li@nxp.com
>>>
>>>> ---
>>>>  MAINTAINERS | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 64379c699903..47e9f86bd712 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -14254,6 +14254,7 @@ W:	https://github.com/jonmason/ntb/wiki
>>>>  T:	git git://github.com/jonmason/ntb.git
>>>>  F:	drivers/net/ntb_netdev.c
>>>>  F:	drivers/ntb/
>>>> +F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
>>>>  F:	include/linux/ntb.h
>>>>  F:	include/linux/ntb_transport.h
>>>>  F:	tools/testing/selftests/ntb/
>>>> -- 
>>>> 2.30.2
>>>>
>>>
>>> -- 
>>> மணிவண்ணன் சதாசிவம்
> 
