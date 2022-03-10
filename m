Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1424D46ED
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 13:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbiCJM3p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 07:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241997AbiCJM3o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 07:29:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 209538189D
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 04:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646915322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/VafedsefDAeccwtNNOU8Qnj3l5Nry7zWypwpz3i1HM=;
        b=EEACC+tmW0IjLpkmLW6wP8niLRjizn/LSTt6KHLxuN5xHFgvGTo0cPzVYmjDph3XJvJnKE
        iDmGjHJovFUFTs2hLDLSCfch/FIbwJttBXla2B9NvEvrBruTm8uUXZNc/AQdvbOsS/aLU+
        GKOlQj9I6nubZuYf1P5SUCdd2XiLCgU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-C86I3ocwPfKkWZZYUOwJIg-1; Thu, 10 Mar 2022 07:28:41 -0500
X-MC-Unique: C86I3ocwPfKkWZZYUOwJIg-1
Received: by mail-ej1-f70.google.com with SMTP id lf15-20020a170906ae4f00b006da86a43346so3012165ejb.14
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 04:28:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/VafedsefDAeccwtNNOU8Qnj3l5Nry7zWypwpz3i1HM=;
        b=0QfZdBOF8jpSR/1udJI3Mx0SsbDdIEXpdQFNvXnhC3nbvV35GG9NWoNje4dXOA7Uvn
         oPsHOQKA8qJdJfRa2p5Rdh6Z0V5R7dek707armcxwzON5fz803VnXBtqIgVyKNGAlzPD
         6tVJQIMz2BZDvP2+xKy7dQ5K+a1J5W1p9bjcC2DtIoCyJXa90t0DuuJSojc7AQpxgQCK
         UZI682M3jz0+jMj2m3TCuqAVKDVlR1IgCdae+ObW4SQk/dzgAzXEHcBhgHElBtkalLLP
         o38auIjPuRlA+VLkRMLFOKVyezVGTwLQG3ymZtTUBj6SlA+o8a5zUqGYPzdkUq92atpe
         UWHw==
X-Gm-Message-State: AOAM530YE4bb/dY+U/s0mDo17EkGyNuVUEyXO6hyCSEBmP4AvsEug9j4
        2mkJTAk5xsQWixcclDF8LuOBiZ+gQNjQIpm1i1olb1nwQ33zRrw4G40z50wgckKR8hEFw4fj6HM
        /Bzj8U2dMkgxp2hcoVbmS
X-Received: by 2002:a17:907:d03:b0:6da:9618:7ddd with SMTP id gn3-20020a1709070d0300b006da96187dddmr4042985ejc.341.1646915319856;
        Thu, 10 Mar 2022 04:28:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyeXf6u9l7+3+snGK+VBlx3Qlyb60nhABu8yvzpWxOMJf6ZWsZGZlrftndTf4/C7nBxoCi4gQ==
X-Received: by 2002:a17:907:d03:b0:6da:9618:7ddd with SMTP id gn3-20020a1709070d0300b006da96187dddmr4042967ejc.341.1646915319596;
        Thu, 10 Mar 2022 04:28:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id k3-20020a05640212c300b0041605b2d9c1sm1871774edx.58.2022.03.10.04.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:28:39 -0800 (PST)
Message-ID: <b41cfd4d-3f55-168a-e96c-cf2d11d50f28@redhat.com>
Date:   Thu, 10 Mar 2022 13:28:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] x86/PCI: Preserve host bridge windows completely
 covered by E820
Content-Language: en-US
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220309181518.GA63422@bhelgaas>
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

On 3/9/22 19:15, Bjorn Helgaas wrote:
> On Sat, Mar 05, 2022 at 11:37:23AM +0100, Hans de Goede wrote:
>> On 3/4/22 16:46, Hans de Goede wrote:
>>> On 3/4/22 16:32, Bjorn Helgaas wrote:
>>>> On Fri, Mar 04, 2022 at 03:16:42PM +0100, Hans de Goede wrote:
>>>>> On 3/4/22 04:51, Bjorn Helgaas wrote:
>>>>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>>>>
>>>>>> Many folks have reported PCI devices not working.  It could affect any
>>>>>> device, but most reports are for Thunderbolt controllers on Lenovo Yoga and
>>>>>> Clevo Barebone laptops and the touchpad on Lenovo IdeaPads.
>>>>>> ...
> 
>>>>>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
>>>>>> index 7378ea146976..405f0af53e3d 100644
>>>>>> --- a/arch/x86/kernel/resource.c
>>>>>> +++ b/arch/x86/kernel/resource.c
>>>>>> @@ -39,6 +39,17 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
>>>>>>  		e820_start = entry->addr;
>>>>>>  		e820_end = entry->addr + entry->size - 1;
>>>>>>  
>>>>>> +		/*
>>>>>> +		 * If an E820 entry covers just part of the resource, we
>>>>>> +		 * assume E820 is telling us about something like host
>>>>>> +		 * bridge register space that is unavailable for PCI
>>>>>> +		 * devices.  But if it covers the *entire* resource, it's
>>>>>> +		 * more likely just telling us that this is MMIO space, and
>>>>>> +		 * that doesn't need to be removed.
>>>>>> +		 */
>>>>>> +		if (e820_start <= avail->start && avail->end <= e820_end)
>>>>>> +			continue;
>>>>>> +
>>>>>
>>>>> IMHO it would be good to add some logging here, since hitting this is
>>>>> somewhat of a special case. For the Fedora test kernels I did I changed
>>>>> this to:
>>>>>
>>>>> 		if (e820_start <= avail->start && avail->end <= e820_end) {
>>>>> 			dev_info(dev, "resource %pR fully covered by e820 entry [mem %#010Lx-%#010Lx]\n",
>>>>> 				 avail, e820_start, e820_end);
>>>>> 			continue;
>>>>> 		}
>>>>>
>>>>> And I expect/hope to see this new info message on the ideapad with the
>>>>> touchpad issue.
> 
> I added this logging.
> 
>> So I just got the first report back from the Fedora test 5.16.12 kernel
>> with this series added. Good news on the ideapad this wotks fine to
>> fix the touchpad issue (as expected).
> 
> Any "Tested-by" I could add?  If we can, I'd really like to give some
> credit to the folks who suffered through this and helped resolve it.

Good point, the reporter of:
https://bugzilla.redhat.com/show_bug.cgi?id=1868899

has done most of the ideapad with touchpad issues testing for me
and has been very helpful. I agree he deserves credit for this.

I've asked him if he is ok with adding a Tested-by tag and if yes,
which email we should use.

Regards,

Hans

