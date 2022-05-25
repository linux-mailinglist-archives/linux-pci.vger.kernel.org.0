Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CA65340CA
	for <lists+linux-pci@lfdr.de>; Wed, 25 May 2022 17:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiEYPx2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 11:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiEYPx2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 11:53:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58889403DB;
        Wed, 25 May 2022 08:53:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cs3-20020a17090af50300b001e0808b5838so4542490pjb.1;
        Wed, 25 May 2022 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=AoNvuKNojUkIN9rTU0d/T+skMmKYpLiILH0Q+8N5x8c=;
        b=qdLV6nnVrWzqXkbfgBHahNZgl9uFcAQcA9NzmJfYKNkAbCrWRuR+x4YaOpbqy6X1/U
         fyfVBlkPb55Y5B3A8AD6V3P+yvQ12nYMEOJYNuzuy4YAl8bNuNh6DX/gQZ7ZnXw9Ncup
         w0xf+phg1dkx9NGFk8MDA3UW6TrJdCf0b9SuTdzqN6rkOeW+lh8KuRKTt0CFsBSIIocl
         OO9CvwjHpobfU21TekafAXeqsNotcNEx4i7LYIRUx/+XPWWUWDyG0mTOjTvaJjp3XqMA
         Ghv4lC3ugEgqsBgHfQw6zp6cYgfc02xOMU40UyPD3IeqmoQwLALR9+otiVDwn49HKLxs
         vl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AoNvuKNojUkIN9rTU0d/T+skMmKYpLiILH0Q+8N5x8c=;
        b=6bwXuIMxvQbom4VXnc+yY1NwykWliSL6/62QuS0e7JFb09zy+3SSGSu4UPJHlMd+L/
         uY0nPXoLt0qXpm5ojcwltVVSuJTKb/miSLVi4zPK26r1PAzY36144aGOoIdAwCSm4HBK
         a3wRWP60XpGycrFWHc1Yia4Z17P7OD30Kitvxr/mYVp79lmr9zaXiNFrAU9CS0R3EHyx
         Poc1S5MLAiMl+23xz0Gyvt6PYTV9x4X6vIh83nWjyzdClCqSmQqYYDxV0xPX3/fMPD1c
         Tvb7JfT47OWalgD35ZSNM5FfswP7buP2HZH6KCgPjBMjnZktw2g6kGksR6qqe4hgGP1H
         /6XA==
X-Gm-Message-State: AOAM5300VjeWsgFKGnIvLxr3o0hj3RHoRo9y7cHgrpy6rIo1aR2OLszn
        tz5nYAFqI/2FjsNi22Yveko=
X-Google-Smtp-Source: ABdhPJxS/Z84HFyYwFBGT/UsNbXdj3wDEkYi5aBaB/xJTKcOhHhK+kv7leF+l35T4y7LYDx64MiMBA==
X-Received: by 2002:a17:902:db11:b0:163:53b3:493a with SMTP id m17-20020a170902db1100b0016353b3493amr4543543plx.96.1653494006898;
        Wed, 25 May 2022 08:53:26 -0700 (PDT)
Received: from [0.0.0.0] ([192.109.233.222])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b0015f086e4aa5sm9675557plh.291.2022.05.25.08.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 08:53:26 -0700 (PDT)
Message-ID: <8baed9ba-bb50-d4cf-c8c0-78d7d36f0cd2@gmail.com>
Date:   Wed, 25 May 2022 23:53:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RESEND PATCH v5] PCI: Make sure the bus bridge powered on when
 scanning bus
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20220525141930.GA290827@bhelgaas>
From:   Yicong Yang <yangyccccc@gmail.com>
In-Reply-To: <20220525141930.GA290827@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

在 2022/5/25 22:19, Bjorn Helgaas 写道:
> On Wed, May 25, 2022 at 01:27:21PM +0200, Rafael J. Wysocki wrote:
>> On Tue, May 24, 2022 at 10:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Tue, May 17, 2022 at 08:43:19PM +0800, Yicong Yang wrote:
>>>> When the bus bridge is runtime suspended, we'll fail to rescan
>>>> the devices through sysfs as we cannot access the configuration
>>>> space correctly when the bridge is in D3hot.
>>> Is the "D3hot" above a typo?  I think devices are supposed to respond
>>> to config accesses when in D3hot.  PCIe r6.0, sec 5.3.1.4.1:
>>>
>>>   Configuration and Message requests are the only TLPs accepted by a
>>>   Function in the D3Hot state. ...
>>>
>>>   Functions that are in D3Hot are permitted to be transitioned by
>>>   software (writing to their PMCSR PowerState field) to the D0active
>>>   state or the D0uninitialized state. Functions that are in D3Hot must
>>>   respond to Configuration Space accesses as long as power and clock
>>>   are supplied so that they can be returned to D0 by software.
>> That applies to the device itself, though, and not to the bus under it.
>>
>> In general, a bridge in D3hot causes the bus segment on the other side
>> of it to be inaccessible even for config space accesses AFAICS.
> Oh, thank you!  That was the piece I was missing.  I'll tweak the
> commit log to say something like:
>
>   A bridge in a non-D0 power state does not forward config accesses to
>   its secondary side (PCIe r6.0, sec 5.3.1).  Make sure the bridge is
>   in D0 while we enumerate devices below it.

Thanks for the illustration and tweaking of this. I should have qualified
the "devices" in the commit with downstream or secondary to make it
less ambiguous.

>>>> It can be reproduced like:
>>>>
>>>> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
>>>> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan
>>>>
>>>> 0000:80:00.0 is a Root Port and it is runtime-suspended, so
>>>> 0000:81:00.1 is unreachable after a rescan.
>>>>
>>>> Power up the bridge when scanning the child bus and allow it to
>>>> suspend again by adding pm_runtime_get_sync()/pm_runtime_put()
>>>> in pci_scan_child_bus_extend().
>>>>
>>>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>>>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>>> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> ---
>>>>  drivers/pci/probe.c | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index 17a969942d37..b108e72b6586 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -2859,11 +2859,20 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>>>>       unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
>>>>       unsigned int start = bus->busn_res.start;
>>>>       unsigned int devfn, fn, cmax, max = start;
>>>> +     struct pci_dev *bridge = bus->self;
>>>>       struct pci_dev *dev;
>>>>       int nr_devs;
>>>>
>>>>       dev_dbg(&bus->dev, "scanning bus\n");
>>>>
>>>> +     /*
>>>> +      * Make sure the bus bridge is powered on, otherwise we may not be
>>>> +      * able to scan the devices as we may fail to access the configuration
>>>> +      * space of subordinates.
>>>> +      */
>>>> +     if (bridge)
>>>> +             pm_runtime_get_sync(&bridge->dev);
>>>> +
>>>>       /* Go find them, Rover! */
>>>>       for (devfn = 0; devfn < 256; devfn += 8) {
>>>>               nr_devs = pci_scan_slot(bus, devfn);
>>>> @@ -2976,6 +2985,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>>>>               }
>>>>       }
>>>>
>>>> +     if (bridge)
>>>> +             pm_runtime_put(&bridge->dev);
>>>> +
>>>>       /*
>>>>        * We've scanned the bus and so we know all about what's on
>>>>        * the other side of any bridges that may be on this bus plus
>>>> --
>>>> 2.24.0
>>>>
