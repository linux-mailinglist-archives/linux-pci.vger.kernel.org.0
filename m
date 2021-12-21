Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B54647C49C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 18:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhLURET (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 12:04:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231266AbhLURES (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 12:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640106258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yl3Vp8QjwavG3f+ohEPxYXZer5SzEY7eKto2Guu34dg=;
        b=EJ7fuezrdgBu3bR0mbQ2NxNW7/e+IJto4muBEWvGLqaVo6MT/8qZ/3WPIzjCFD/TyOuBCS
        1OGMp3jurM1EE5vA/UoUM3V1lpIfR+pg1fs74eaFxCqduwQzKmwSpGMo13DCI8ZUc8dxbU
        FEwLMD8lPpGSWalJ8t1wF8eZIhfvYjs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-gEQPQ6npMB-Uau9b3zTwUw-1; Tue, 21 Dec 2021 12:04:17 -0500
X-MC-Unique: gEQPQ6npMB-Uau9b3zTwUw-1
Received: by mail-ed1-f72.google.com with SMTP id s7-20020a056402520700b003f841380832so6564059edd.5
        for <linux-pci@vger.kernel.org>; Tue, 21 Dec 2021 09:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yl3Vp8QjwavG3f+ohEPxYXZer5SzEY7eKto2Guu34dg=;
        b=xB/7AZfV8mpb/sUSvM7mWPJwAo2y18UPzkFH+llXjImoUz/gF7va+9AR8PvVjKHvln
         AWdB1ACpiVFe/QwEpqrJMbZYFOgnMW8eWk3b3Lz68CSHGDA7TKVJtt7m4s54teXGFwiJ
         KSAPsmiZKvn0lSSDNsotLaWeweFYs6O4GcAFE5wFKwIynonaE+oX8Fb8mzBo9ryCqddw
         t4TdJVaeUBuSW2hXgzWimm2lPTw6/HSxwMklKLAfbFCzV6m+ei3NfgKb/U88gt9Ldyzk
         BcKtiFS1b51PlClNyqfsz3/m1/x4sl2uM7xGlxGP0QfB6U0Sc4H+n2/aDifscNmI2qZG
         6KOw==
X-Gm-Message-State: AOAM532KgXoCxLflqNZS4Nqna5ApEa02v3jjFQcBrQDEoDLrAnE4vA0u
        7A7eR+ilYsXFlN3IQ5wushtidFR7DufskkDHmx2WD7d9Lpa7Z2M3r5/Q8eosQgEtxF6LfQQmaka
        cgn3vrV40wMzCc+a2SZq7
X-Received: by 2002:a17:906:abc8:: with SMTP id kq8mr3305395ejb.643.1640106254746;
        Tue, 21 Dec 2021 09:04:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykzGfLApBGKkOJE2ylZ9A5UcRtimHTwwP3RPrPiKxQzVhnSXHE8vf9wsNFBRnLgzSevKdx6w==
X-Received: by 2002:a17:906:abc8:: with SMTP id kq8mr3305365ejb.643.1640106254488;
        Tue, 21 Dec 2021 09:04:14 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id cn8sm2564736edb.13.2021.12.21.09.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 09:04:12 -0800 (PST)
Message-ID: <3913dfd7-3872-7d69-24af-eba747a7a92d@redhat.com>
Date:   Tue, 21 Dec 2021 18:04:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RESEND V2 3/6] platform/x86/intel: Move intel_pmt from MFD
 to Auxiliary Bus
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
 <20211208015015.891275-4-david.e.box@linux.intel.com>
 <YbDbql39x7Kw6iAC@kroah.com>
 <7e78e6311cb0d261892f7361a1ef10130436f358.camel@linux.intel.com>
 <YbD1NsYHbU8FvtTN@kroah.com>
 <a70956e1c4da10603e29087e893cbae62ce82631.camel@linux.intel.com>
 <YbEFuN7fwdiNI8vW@kroah.com>
 <622887d53eaf6e6ae36354bfa0ed483df1cd9214.camel@linux.intel.com>
 <YcGEaH0oAAocziU2@kroah.com>
 <e9648546c3fb751954e411dfa392f0e0f90f0c85.camel@linux.intel.com>
 <YcIGwZqm2sfIixkH@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YcIGwZqm2sfIixkH@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 12/21/21 17:54, Greg KH wrote:
> On Tue, Dec 21, 2021 at 08:44:57AM -0800, David E. Box wrote:
>> On Tue, 2021-12-21 at 08:38 +0100, Greg KH wrote:
>>> On Wed, Dec 08, 2021 at 01:30:06PM -0800, David E. Box wrote:
>>>> On Wed, 2021-12-08 at 20:21 +0100, Greg KH wrote:
>>>>> On Wed, Dec 08, 2021 at 11:09:48AM -0800, David E. Box wrote:
>>>>>> On Wed, 2021-12-08 at 19:11 +0100, Greg KH wrote:
>>>>>>> On Wed, Dec 08, 2021 at 09:47:26AM -0800, David E. Box wrote:
>>>>>>>> On Wed, 2021-12-08 at 17:22 +0100, Greg KH wrote:
>>>>>>>>> On Tue, Dec 07, 2021 at 05:50:12PM -0800, David E. Box wrote:
>>>>>>>>>> +static struct pci_driver intel_vsec_pci_driver = {
>>>>>>>>>> +       .name = "intel_vsec",
>>>>>>>>>> +       .id_table = intel_vsec_pci_ids,
>>>>>>>>>> +       .probe = intel_vsec_pci_probe,
>>>>>>>>>> +};
>>>>>>>>>
>>>>>>>>> So when the PCI device is removed from the system you leak
>>>>>>>>> resources and
>>>>>>>>> have dangling devices?
>>>>>>>>
>>>>>>>> No.
>>>>>>>>
>>>>>>>>> Why no PCI remove driver callback?
>>>>>>>>
>>>>>>>> After probe all resources are device managed. There's nothing to
>>>>>>>> explicitly clean up. When
>>>>>>>> the
>>>>>>>> PCI
>>>>>>>> device is removed, all aux devices are automatically removed. This
>>>>>>>> is the case for the SDSi
>>>>>>>> driver
>>>>>>>> as well.
>>>>>>>
>>>>>>> Where is the "automatic cleanup" happening?  As this pci driver is
>>>>>>> bound
>>>>>>> to the PCI device, when the device is removed, what is called in this
>>>>>>> driver to remove the resources allocated in the probe callback?
>>>>>>>
>>>>>>> confused,
>>>>>>
>>>>>> devm_add_action_or_reset(&pdev->dev, intel_vsec_remove_aux, auxdev)
>>>>>
>>>>> Wow that is opaque.  Why not do it on remove instead?
>>>>
>>>> This code is common for auxdev cleanup. AFAICT most auxiliary bus code is
>>>> done by drivers that have
>>>> some other primary function. They clean up their primary function resources
>>>> in remove, but they
>>>> clean up the auxdev using the method above. In this case the sole purpose of
>>>> this driver is to
>>>> create the auxdev. There are no other resources beyond what the auxdev is
>>>> using.
>>>>
>>>> Adding runtime pm to the pci driver will change this. Remove will be needed
>>>> then.
>>>
>>> And who will notice that being required when that happens?
>>>
>>> Why is there no runtime PM for this driver?  Do you not care about power
>>> consumption?  :)
>>
>> Of course. :)
>>
>> There's a backlog of patches waiting for this series. One adds support for the
>> telemetry device (an auxdev) on the DG2 GPU. This device requires runtime pm in
>> order for the slot to go D3. But this also requires changes to the telemetry
>> driver in order for runtime pm to be handled correctly. These and other patches,
>> including a series to have all current aux drivers use the new drvdata helpers,
>> are waiting for this.
> 
> I can take the aux driver drvdata patch now, through my tree, if you
> want, no need to make it wait for this tiny driver.
> 
> Feel free to send it independant of the existing patchset, and with the
> cleanup patches at the same time, should be quite easy to get merged.

If you're going to take that one, can you perhaps take patches
1-3 for 5.17 through your tree as well (patch 3 depends on 2/it) ?

Note there is a v4 of this series, see please use that :)

I assume the follow up patches are also going to need patch 3
(the actual conversion of the driver to aux-bus).

Here is my Ack for the pdx86 bits in patch 3:

Acked-by: Hans de Goede <hdegoede@redhat.com>

And patch 1 and 3 also have acks from the PCI resp. MFD subsys maintainers,
so I guess taking this all upstream through your tree is fine.

That leaves patches 4-6, 4 is the patching adding the new
"Intel Software Defined Silicon driver" sysfs API and I would
like to take some time to thoroughly review the new
userspace API, which I don't see happening before the
Christmas Holidays, so I don't plan to merge 4-6 (which
depends on 3) until after 5.17-rc1.

Regards,

Hans

