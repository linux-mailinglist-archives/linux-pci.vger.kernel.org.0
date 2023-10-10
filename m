Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7C97C414C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 22:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbjJJUeQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 16:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344087AbjJJUeD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 16:34:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C5B10B
        for <linux-pci@vger.kernel.org>; Tue, 10 Oct 2023 13:33:53 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5334d78c5f6so10546958a12.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Oct 2023 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696970031; x=1697574831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnJq6DzywyYVanfwJUcmkx0jXABmVseLEk3CjBysolc=;
        b=go+doY9FCLFwyvz5g6T01XSBmftv+XkDQFFYHu0qnuHC4K0DLTKilk8VUMes9Ofr9s
         xlaig2kZoQlymDWLsBQ8oh3RRgx8EPRhBXHUqOI73UgLq+3ejlWvoINlKXC3NHGoZ+S+
         pLGwnhSOe7RLkyhSk4j48fPHEVrIFCs1LexIFNVVWGCjLdwJm/KCCYwuT+F3jXnO/5GU
         FdKBpV1o8eeJzGOGyr0W7hEw+b64z4NI2ejPjqdfbbXdoCcPFZuFUGxGJqt1VWXNQC9u
         6iB9r4wdEdCU+SLEkmAptgvjpYz6RXk/vGktumg3+rG2i8uirkQD7+ws5/tJOELMlW9l
         O02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970031; x=1697574831;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnJq6DzywyYVanfwJUcmkx0jXABmVseLEk3CjBysolc=;
        b=s5a/9ECokdC9zCgVbiMk1RMJVjLW7+QOjuYzHb1flzYjyEuWWgX/dWRfNfCUCcpDq8
         1wWzqMQcYm7/pOC0cFaBDeeaeHN5YpTDsc2bUyVjsWP+rlzmlrBusd7Y6+PCIvG/a6Lq
         onOvu3yR5cwGTjmILO/M14rMkKI80Q0NqTQIoBNu1xsIH/1rUoQSHvvNssqb4XeBEggU
         T9nEY++Z+nC5qvhkWMyheJ0xUaNspZU01zwqRcFQ+KxnosKO+437Pr7bAX31XhComQt0
         uW7CaezsMw6yF+8tSUnSB5O4V2NdfNkbckeoL60Ued97IkclCAz0FoAt3m/qjagMEVG0
         +QWw==
X-Gm-Message-State: AOJu0Yx+0vv0Am3PeYrUkWpfB/vLbq3ZZFgWVmNodfKJYcgin/Aitovt
        tMH4K7BCdHYUtxIJP4KlqYM=
X-Google-Smtp-Source: AGHT+IEoquSFdYpPtIJhftIbZ29ArewabmcuhII9WtH3SxrcCPw3GlaYHKlbZNYO8UKcRcMpypiFhg==
X-Received: by 2002:aa7:d6d8:0:b0:530:46c:8e36 with SMTP id x24-20020aa7d6d8000000b00530046c8e36mr15679766edr.17.1696970031202;
        Tue, 10 Oct 2023 13:33:51 -0700 (PDT)
Received: from ?IPV6:2a01:c22:73de:9300:a83b:58eb:138d:a089? (dynamic-2a01-0c22-73de-9300-a83b-58eb-138d-a089.c22.pool.telefonica.de. [2a01:c22:73de:9300:a83b:58eb:138d:a089])
        by smtp.googlemail.com with ESMTPSA id z24-20020aa7c658000000b005288f0e547esm8152987edr.55.2023.10.10.13.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 13:33:50 -0700 (PDT)
Message-ID: <007c67a0-2a15-455e-9718-063ae01f1d46@gmail.com>
Date:   Tue, 10 Oct 2023 22:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ASPM: fix unexpected behavior when re-enabling L1
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Lukas Wunner <lukas@wunner.de>
References: <20231002151452.GA560499@bhelgaas>
 <520298c9-eda0-4d6f-b14d-5681a6862bc6@linux.intel.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <520298c9-eda0-4d6f-b14d-5681a6862bc6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03.10.2023 05:33, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 10/2/2023 8:14 AM, Bjorn Helgaas wrote:
>> [+cc Sathy, Lukas]
>>
>> On Sat, Aug 26, 2023 at 01:10:35PM +0200, Heiner Kallweit wrote:
>>> After the referenced commit we may see L1 sub-states being active
>>> unexpectedly. Following scenario as an example:
>>> r8169 disables L1 because of known hardware issues on a number of
>>> systems. Implicitly L1.1 and L1.2 are disabled too.
>>> On my system L1 and L1.1 work fine, but L1.2 causes missed
>>> rx packets. Therefore I write 1 to aspm_l1_1.
>>> This removes ASPM_STATE_L1 from the disabled modes and therefore
>>> unexpectedly enables also L1.2. So return to the old behavior.
> 
> IIUC, the above-mentioned SysFS issue will be fixed by your change to
> aspm_attr_store_common(), right?
> 
In my use case the driver uses pci_disable_link_state() to disable L1
and implicitly also L1.1 and L1.2. The following change is needed so
that L1.2 remains disabled if L1 is removed from the list of disabled
states later. That's the revert we're talking about.

> Can you elaborate why you need the following change?
> 
>>> @@ -1063,7 +1063,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>>>  	if (state & PCIE_LINK_STATE_L1)
>>> -		link->aspm_disable |= ASPM_STATE_L1;
>>> +		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> 
>>>
>>> A comment in the commit message of the referenced change correctly points
>>> out that this behavior is inconsistent with aspm_attr_store_common().
>>> So change aspm_attr_store_common() accordingly.
>>
>> I think we should split this into a pure revert of fb097dcd5a28 with
>> the description of the unintended consequence, followed by another
>> patch to change aspm_attr_store_common().
>>
> 
> I agree, the revert and new change should be split into two patches.
> 
>> I guess the existing aspm_attr_store_common() behavior allows a
>> similar unexpected behavior?  For example, in this sequence:
>>
>>   - Write 0 to "l1_aspm" to disable L1
>>   - Write 1 to "l1_1_aspm" to enable L1.1
>>
>> does L1.2 get implicitly enabled as well even though that's clearly
>> not what the user intended?
>>
>> There's also the separate question of how the sysfs file and the
>> pci_disable_link_state() API should interact.  Drivers use that API
>> when they know about a defect in their device, but the user can
>> override that via syfs.
>>
>> In [1], we have a similar situation with D3cold support, where we're
>> thinking that we should not allow a user to use sysfs to override that
>> driver knowledge.
>>
>> Bjorn
>>
>> [1] https://lore.kernel.org/r/b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de
>>
>>> Fixes: fb097dcd5a28 ("PCI/ASPM: Disable only ASPM_STATE_L1 when driver disables L1")
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/pci/pcie/aspm.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>> index 3dafba0b5..6d3788257 100644
>>> --- a/drivers/pci/pcie/aspm.c
>>> +++ b/drivers/pci/pcie/aspm.c
>>> @@ -1063,7 +1063,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>>>  	if (state & PCIE_LINK_STATE_L0S)
>>>  		link->aspm_disable |= ASPM_STATE_L0S;
>>>  	if (state & PCIE_LINK_STATE_L1)
>>> -		link->aspm_disable |= ASPM_STATE_L1;
>>> +		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
>>>  	if (state & PCIE_LINK_STATE_L1_1)
>>>  		link->aspm_disable |= ASPM_STATE_L1_1;
>>>  	if (state & PCIE_LINK_STATE_L1_2)
>>> @@ -1251,6 +1251,8 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>>>  			link->aspm_disable &= ~ASPM_STATE_L1;
>>>  	} else {
>>>  		link->aspm_disable |= state;
>>> +		if (state & ASPM_STATE_L1)
>>> +			link->aspm_disable |= ASPM_STATE_L1SS;
>>>  	}
>>>  
>>>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>>> -- 
>>> 2.42.0
>>>
> 

