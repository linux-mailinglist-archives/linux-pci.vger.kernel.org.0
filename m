Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC6B4D5CC1
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 08:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbiCKHxp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 02:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347267AbiCKHxk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 02:53:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEFB431DD0
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646985155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOdafaJtse+8LgWXWQrqdTTqXMwIbmNc8kkDbRO4C2U=;
        b=JmPFq40oQK4L77dWhCcOAOZS1huusL3o5RMC6/gT7oWFzgaihrjthq2QTegu955jSI5E5W
        ioggAuMi6rK/BIWVFyVc3UySc0abql2ua0Qo08bZ0T73m+MwLeEYtmBj/OnTEZtLQLrDFH
        ziX5AVe8XfChogAfTnBarFtk0TIBkSE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-hEXO6vP8MwKPzi5xlTUWQA-1; Fri, 11 Mar 2022 02:52:34 -0500
X-MC-Unique: hEXO6vP8MwKPzi5xlTUWQA-1
Received: by mail-ed1-f70.google.com with SMTP id i17-20020aa7c711000000b00415ecaefd07so4408741edq.21
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 23:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=nOdafaJtse+8LgWXWQrqdTTqXMwIbmNc8kkDbRO4C2U=;
        b=wtbqTBZW+LNzJlXIDo8u8OJCO6vkg/Y757u6zTNd/NK872aynUzFF8103RMEfzT1m0
         ZOeeLD54sQMkoJmlg+d4gtreZQOu7mwIfhXk6b3bipxxL/vaN/Pjo/azyyWOo+066FPE
         PrqPfGDLXo9mU1E/qSQBy7qE4zEprJi5I7rNy6MSLpfxgcXrV3eVlD2e7At8ZiJEV/An
         W6to0oUwI5jVdYtECB3Ec+0i/AqmRt3tupewgveanYUtjvTo1+0GJTU7l4+H7E2YfuOs
         UWf0tFsYHeUxymylOB1HF74/RtbvwzdlHv7qpltVWYVlCwBcaRy5LPKs3bWc5blq/6BX
         1n0w==
X-Gm-Message-State: AOAM533QQvfQlcB5gjXdt62FBbCXwrV7ZxgF/eXv6xesRu4jnmJBPW5J
        c4/me7JK9ECTMvf59AIi4MQvrTElxqObe2+z/Mf2YCgCD8fdw3PdWPaCxGPXo9KXy6nadSKTWYI
        E1Lm1g2dPzZEw+T1fqqZr
X-Received: by 2002:a17:907:86a8:b0:6db:6c1c:d9c4 with SMTP id qa40-20020a17090786a800b006db6c1cd9c4mr7401989ejc.640.1646985152878;
        Thu, 10 Mar 2022 23:52:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoi4tVAbZEr4iaXAILaYiGbWBCMw/gOSBC7p2ecbnJ1XfcWwLWDBERuFBQjbG34JyrAe8X+w==
X-Received: by 2002:a17:907:86a8:b0:6db:6c1c:d9c4 with SMTP id qa40-20020a17090786a800b006db6c1cd9c4mr7401976ejc.640.1646985152657;
        Thu, 10 Mar 2022 23:52:32 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id r14-20020a1709067fce00b006db0edb8a80sm2639575ejs.225.2022.03.10.23.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 23:52:32 -0800 (PST)
Message-ID: <03675c75-ee6f-5da3-099c-2b82a1865455@redhat.com>
Date:   Fri, 11 Mar 2022 08:52:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] x86/PCI: Preserve host bridge windows completely
 covered by E820
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, wse@tuxedocomputers.com
References: <20220309181518.GA63422@bhelgaas>
 <b41cfd4d-3f55-168a-e96c-cf2d11d50f28@redhat.com>
In-Reply-To: <b41cfd4d-3f55-168a-e96c-cf2d11d50f28@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/10/22 13:28, Hans de Goede wrote:
> Hi Bjorn,
> 
> On 3/9/22 19:15, Bjorn Helgaas wrote:
>> On Sat, Mar 05, 2022 at 11:37:23AM +0100, Hans de Goede wrote:
>>> On 3/4/22 16:46, Hans de Goede wrote:
>>>> On 3/4/22 16:32, Bjorn Helgaas wrote:
>>>>> On Fri, Mar 04, 2022 at 03:16:42PM +0100, Hans de Goede wrote:
>>>>>> On 3/4/22 04:51, Bjorn Helgaas wrote:
>>>>>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>>>>>
>>>>>>> Many folks have reported PCI devices not working.  It could affect any
>>>>>>> device, but most reports are for Thunderbolt controllers on Lenovo Yoga and
>>>>>>> Clevo Barebone laptops and the touchpad on Lenovo IdeaPads.
>>>>>>> ...
>>
>>>>>>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
>>>>>>> index 7378ea146976..405f0af53e3d 100644
>>>>>>> --- a/arch/x86/kernel/resource.c
>>>>>>> +++ b/arch/x86/kernel/resource.c
>>>>>>> @@ -39,6 +39,17 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
>>>>>>>  		e820_start = entry->addr;
>>>>>>>  		e820_end = entry->addr + entry->size - 1;
>>>>>>>  
>>>>>>> +		/*
>>>>>>> +		 * If an E820 entry covers just part of the resource, we
>>>>>>> +		 * assume E820 is telling us about something like host
>>>>>>> +		 * bridge register space that is unavailable for PCI
>>>>>>> +		 * devices.  But if it covers the *entire* resource, it's
>>>>>>> +		 * more likely just telling us that this is MMIO space, and
>>>>>>> +		 * that doesn't need to be removed.
>>>>>>> +		 */
>>>>>>> +		if (e820_start <= avail->start && avail->end <= e820_end)
>>>>>>> +			continue;
>>>>>>> +
>>>>>>
>>>>>> IMHO it would be good to add some logging here, since hitting this is
>>>>>> somewhat of a special case. For the Fedora test kernels I did I changed
>>>>>> this to:
>>>>>>
>>>>>> 		if (e820_start <= avail->start && avail->end <= e820_end) {
>>>>>> 			dev_info(dev, "resource %pR fully covered by e820 entry [mem %#010Lx-%#010Lx]\n",
>>>>>> 				 avail, e820_start, e820_end);
>>>>>> 			continue;
>>>>>> 		}
>>>>>>
>>>>>> And I expect/hope to see this new info message on the ideapad with the
>>>>>> touchpad issue.
>>
>> I added this logging.
>>
>>> So I just got the first report back from the Fedora test 5.16.12 kernel
>>> with this series added. Good news on the ideapad this wotks fine to
>>> fix the touchpad issue (as expected).
>>
>> Any "Tested-by" I could add?  If we can, I'd really like to give some
>> credit to the folks who suffered through this and helped resolve it.
> 
> Good point, the reporter of:
> https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> 
> has done most of the ideapad with touchpad issues testing for me
> and has been very helpful. I agree he deserves credit for this.
> 
> I've asked him if he is ok with adding a Tested-by tag and if yes,
> which email we should use.

If you can add the following tag that would be great:

Tested-by: Matt Hansen <2lprbe78@duck.com>

Regards,

Hans

