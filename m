Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E17417CED
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 23:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbhIXVSs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 17:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhIXVSr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 17:18:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0076EC061571;
        Fri, 24 Sep 2021 14:17:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id bx4so41143920edb.4;
        Fri, 24 Sep 2021 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ku0F7ZGp1w78UA6g0SI9hawfp+gfs+pURjPXFl7geYU=;
        b=JlQHJJ2tAqd8BdbaypXAsBY1tTTf0C/lg4WwxGfNzuNeOJFeIEDFQkFmklHRYPcWe8
         gooXdDYK6jfjHqhWt6hJGGULMxpq0WVHa478sWAxGezE63gxe1qDXbj6dRYnuR+cSonU
         PfWweSWXSw1gg9MKsxaTHhM9pSyLlLXkAh/0fT8xEMD9himCtUG9XYRo4uVeHXC5tbAj
         OO4GaatYaWzeFe83ek3TmOsAmI3XydjKLc7lksMrQreqK1GXOS6bKY1Dscj6gWBVIoLD
         lkMfF1JM7adKNIDxKB0loL5qoYbI0li/xBcFlAurr6qrMEZIonlAPLFo9NwO5pfIu1HZ
         8Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ku0F7ZGp1w78UA6g0SI9hawfp+gfs+pURjPXFl7geYU=;
        b=gQelQJnb7CYq37BBaFd7s6fXZGczLtHMujZcnQTSiDgfL5cx9+Ipq6Qn789vPKYeUu
         6Gf5bv2q3vEBVWiWrvY05y36WU1y7KFy4w1cdIWBJsovsUCXvQdlWW+NJqcOrLP4+Jju
         NjsAZ0W4vmqgR6thh+KhLB5/qIf7+gcF0gKgvAPKyq24RgWidbXLkWe+TPdckW4vw3tL
         GMQ9tm0n+JoyxdpnIFiAfi7xDcEjVH2azeir2cmqoJ2qljSQ517MF8X3K3e9ksF2E1dZ
         Fk4iH0ZEpNSVUddRXK/c7jTxXgRdtQm9u1tEsPUI4lWOi+7917FVRPS5jDe6mx9cy3Xn
         F0SQ==
X-Gm-Message-State: AOAM532uqcQus6HvaR+wLPnlbQHfAsgq+pXNkN1Zqp1uD59CIvpc9AH0
        cjt2tUdom6t4v/yDbYDum2s=
X-Google-Smtp-Source: ABdhPJwLh8fBAVl8cLd3lk44YVX7BtGY0V3leOMvx1GTyirzhLVSR3stKmqPdzLdam/pV4snR3HmZg==
X-Received: by 2002:a17:906:3fc8:: with SMTP id k8mr13286423ejj.217.1632518232534;
        Fri, 24 Sep 2021 14:17:12 -0700 (PDT)
Received: from ?IPv6:2001:981:6fec:1:aeed:20a8:8105:9a95? ([2001:981:6fec:1:aeed:20a8:8105:9a95])
        by smtp.gmail.com with ESMTPSA id u14sm6020442edx.52.2021.09.24.14.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 14:17:12 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] PCI: ACPI: PM: Do not use pci_platform_pm_ops for
 ACPI
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1800633.tdWV9SEqCh@kreacher> <8879480.rMLUfLXkoz@kreacher>
 <069444f7-d623-fae2-5cd0-83cbbc919aff@gmail.com>
 <CAJZ5v0gpodPPXTagy5gFFf6mp_jCAdc864CE_giaue72ke7UyQ@mail.gmail.com>
 <ab803fb5-045d-98dd-2754-688a916f8944@gmail.com>
 <d151c91c-cb65-2830-2453-a02057137400@gmail.com>
 <CAJZ5v0howP_PudCf-43_HqgW48ydc29SeFVRC-wCm_RNKPBMtA@mail.gmail.com>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <24c2c653-4087-fba1-5745-a62a8ae715c6@gmail.com>
Date:   Fri, 24 Sep 2021 23:17:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0howP_PudCf-43_HqgW48ydc29SeFVRC-wCm_RNKPBMtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

Op 24-09-2021 om 14:02 schreef Rafael J. Wysocki:
> On Thu, Sep 23, 2021 at 10:32 PM Ferry Toth <fntoth@gmail.com> wrote:
>> Hi
>>
>> Op 23-09-2021 om 15:51 schreef Ferry Toth:
>>> Repost (with formatting removed, sorry for the noise)
>>> Op 23-09-2021 om 13:30 schreef Rafael J. Wysocki:
>>>> On Wed, Sep 22, 2021 at 11:31 PM Ferry Toth<fntoth@gmail.com>  wrote:
>>>>> Hi,
>>>>> Op 20-09-2021 om 21:17 schreef Rafael J. Wysocki:
>>>>>> From: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
>>>>>>
>>>>>> Using struct pci_platform_pm_ops for ACPI adds unnecessary
>>>>>> indirection to the interactions between the PCI core and ACPI PM,
>>>>>> which is also subject to retpolines.
>>>>>>
>>>>>> Moreover, it is not particularly clear from the current code that,
>>>>>> as far as PCI PM is concerned, "platform" really means just ACPI
>>>>>> except for the special casess when Intel MID PCI PM is used or when
>>>>>> ACPI support is disabled (through the kernel config or command line,
>>>>>> or because there are no usable ACPI tables on the system).
>>>>>>
>>>>>> To address the above, rework the PCI PM code to invoke ACPI PM
>>>>>> functions directly as needed and drop the acpi_pci_platform_pm
>>>>>> object that is not necessary any more.
>>>>>>
>>>>>> Accordingly, update some of the ACPI PM functions in question to do
>>>>>> extra checks in case the ACPI support is disabled (which previously
>>>>>> was taken care of by avoiding to set the pci_platform_ops pointer
>>>>>> in those cases).
>>>>>>
>>>>>> Signed-off-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
>>>>>> ---
>>>>>>
>>>>>> v1 -> v2:
>>>>>>        * Rebase on top of the new [1/7] and move dropping struct
>>>>>>          pci_platform_pm_ops to a separate patch.
>>>>> I wanted to test this series on 5.15-rc2 but this patch 2/7 doesn't
>>>>> apply (after 1/7 applied). Should I apply this on another tree?
>>>> This is on top of
>>>> https://patchwork.kernel.org/project/linux-acpi/patch/2793105.e9J7NaK4W3@kreacher/
>>>>
>>>> which is not yet in any tree.
>>>>
>>>> Sorry for the confusion.
>>> No problem at all. If I can I will try to report back tonight. Else,
>>> will be delayed 2 due to a short break.
>> With those 3 extra patches followed by 7 from this series it builds. But
>> on boot I get:
>> dwc3 dwc3.0.auto: this is not a DesignWare USB3 DRD Core
>> Then after this it reboots. Nothing in the logs. Nothing else on
>> console, I guess something goes wrong early.
> It appears so.
>
> Can you please try just the 3 extra patches this series is on top of?
> The problem is more likely to be located in one of them.
Boots fine with just the 3 so up to and including "ACPI: glue: Look for 
ACPI bus type only if ACPI companion is not known". From the log I get:


Intel MID platform detected, using MID PCI ops
PCI: Using configuration type 1 for base access
..
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" 
and report a bug
..
PCI: Probing PCI hardware
PCI: root bus 00: using default resources
PCI: Probing PCI hardware (bus 00)
PCI: pci_cache_line_size set to 64 bytes
..
pnp: PnP ACPI init
..
pnp: PnP ACPI: found 2 devices
..
xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
xhci-hcd xhci-hcd.1.auto: hcc params 0x0220f06c hci version 0x100 quirks 
0x0000000002010010
xhci-hcd xhci-hcd.1.auto: irq 14, io mem 0xf9100000
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, 
bcdDevice= 5.15
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: xHCI Host Controller
usb usb1: Manufacturer: Linux 5.15.0-rc2-edison-acpi-standard xhci-hcd
usb usb1: SerialNumber: xhci-hcd.1.auto
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected

I continued up to "PCI: ACPI: PM: Do not use pci_platform_pm_ops for 
ACPI", still boots.

In the logs I still see "Intel MID platform detected, using MID PCI ops".

Unfortunately no more time today, and tomorrow short holiday starts. I 
will continue after returning next Sat.


