Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79454D27E7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 05:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiCIEjA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Mar 2022 23:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCIEjA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2022 23:39:00 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659B35AA41;
        Tue,  8 Mar 2022 20:38:01 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2294bqpv118071;
        Tue, 8 Mar 2022 22:37:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646800672;
        bh=WGbku9FUkxZtK/LL7SBY1MK//mVyianmQOGT9iKKMuI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rHJpyuhC3g2VBKvgRHkBuQZ/z7ElJq0HHBpvbMs39cMZGwaozC0w5fLbwIyrEbUmP
         +MZWb4vx6ly5jJQojtOQwJp8uITCdXO4sA6kycPt2YM1DTJtXoj/dXR6ch/6DPveI+
         Ouz4lAJpCdxjf7iMFRS/BUgHwjuIG6BFkhDk3mH0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2294bqXF041740
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Mar 2022 22:37:52 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 8
 Mar 2022 22:37:52 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 8 Mar 2022 22:37:52 -0600
Received: from [10.250.233.186] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2294bmIh017591;
        Tue, 8 Mar 2022 22:37:49 -0600
Subject: Re: [PATCH v2] PCI: endpoint: Use blocking notifier instead of atomic
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <lorenzo.pieralisi@arm.com>, Vidya Sagar <vidyas@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <dmitry.baryshkov@linaro.org>
References: <20220228055240.24774-1-manivannan.sadhasivam@linaro.org>
 <e151083b-c15a-7baa-3423-84bd1881105a@ti.com>
 <20220228062830.GA37219@thinkpad>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a66ccea3-b854-75d7-dc3d-6c9bb2057a0d@ti.com>
Date:   Wed, 9 Mar 2022 10:07:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220228062830.GA37219@thinkpad>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mani,

On 28/02/22 11:58 am, Manivannan Sadhasivam wrote:
> Hi,
> 
> On Mon, Feb 28, 2022 at 11:46:52AM +0530, Kishon Vijay Abraham I wrote:
>> Hi Manivannan,
>>
>> On 28/02/22 11:22 am, Manivannan Sadhasivam wrote:
>>> The use of atomic notifier causes sleeping in atomic context bug when
>>> the EPC core functions are used in the notifier chain. This is due to the
>>> use of epc->lock (mutex) in core functions protecting the concurrent use of
>>> EPC.
>>
>> The notification from the controller to the function driver is used for
>> propagating interrupts to function driver and should be in interrupt context.
>> How it should be handled maybe left to the function driver. I don't prefer
>> moving everything to blocking notifier.
>>
> 
> I agree that we need to handle it quick enough but I don't see any other valid
> options to get rid of the issue. EPF driver may use a non-atomic notifier but
> that seems to be an overkill workaround for something that could be fixed in the
> EPC core.
> 
> And propagating interrupts is not going to work or needed all the time. Do you
> forsee any issue with blocking notifier?

I think any interrupt to the EP should be delivered to the function driver in
interrupt context, it could be function level reset interrupt, hot reset
interrupt, link state interrupt etc., These are right now not supported but it
will use the same notification mechanism to propagate interrupt from controller
driver to function driver.

Thanks,
Kishon

> 
>> I'm wondering how other users for CORE_INIT didn't see this issue.
> 
> This can be triggered with EPF test or NTB if CONFIG_DEBUG_ATOMIC_SLEEP is
> enabled.
> 
> Thanks,
> Mani
> 
>>
>> Thanks,
>> Kishon
>>
>>>
>>> So switch to blocking notifier for getting rid of the bug as it runs in
>>> non-atomic context and allows sleeping in notifier chain.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>
>>> Changes in v2:
>>>
>>> * Removed the changes related to non-upstreamed patches
>>>
>>>  drivers/pci/endpoint/pci-epc-core.c | 6 +++---
>>>  include/linux/pci-epc.h             | 4 ++--
>>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>>> index 3bc9273d0a08..c4347f472618 100644
>>> --- a/drivers/pci/endpoint/pci-epc-core.c
>>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>>> @@ -693,7 +693,7 @@ void pci_epc_linkup(struct pci_epc *epc)
>>>  	if (!epc || IS_ERR(epc))
>>>  		return;
>>>  
>>> -	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
>>> +	blocking_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
>>>  }
>>>  EXPORT_SYMBOL_GPL(pci_epc_linkup);
>>>  
>>> @@ -710,7 +710,7 @@ void pci_epc_init_notify(struct pci_epc *epc)
>>>  	if (!epc || IS_ERR(epc))
>>>  		return;
>>>  
>>> -	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
>>> +	blocking_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
>>>  }
>>>  EXPORT_SYMBOL_GPL(pci_epc_init_notify);
>>>  
>>> @@ -774,7 +774,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>>>  
>>>  	mutex_init(&epc->lock);
>>>  	INIT_LIST_HEAD(&epc->pci_epf);
>>> -	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
>>> +	BLOCKING_INIT_NOTIFIER_HEAD(&epc->notifier);
>>>  
>>>  	device_initialize(&epc->dev);
>>>  	epc->dev.class = pci_epc_class;
>>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>>> index a48778e1a4ee..04a2e74aed63 100644
>>> --- a/include/linux/pci-epc.h
>>> +++ b/include/linux/pci-epc.h
>>> @@ -149,7 +149,7 @@ struct pci_epc {
>>>  	/* mutex to protect against concurrent access of EP controller */
>>>  	struct mutex			lock;
>>>  	unsigned long			function_num_map;
>>> -	struct atomic_notifier_head	notifier;
>>> +	struct blocking_notifier_head	notifier;
>>>  };
>>>  
>>>  /**
>>> @@ -195,7 +195,7 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
>>>  static inline int
>>>  pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
>>>  {
>>> -	return atomic_notifier_chain_register(&epc->notifier, nb);
>>> +	return blocking_notifier_chain_register(&epc->notifier, nb);
>>>  }
>>>  
>>>  struct pci_epc *
>>>
