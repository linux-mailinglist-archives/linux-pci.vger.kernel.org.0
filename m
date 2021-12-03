Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4432B467964
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 15:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381423AbhLCOaq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 09:30:46 -0500
Received: from marcansoft.com ([212.63.210.85]:34386 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232082AbhLCOap (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Dec 2021 09:30:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 337B941E96;
        Fri,  3 Dec 2021 14:27:17 +0000 (UTC)
Subject: Re: [PATCH] PCI: apple: Configure link speeds properly
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211122111332.72264-1-marcan@marcan.st>
 <CAL_Jsq+vFbFN+WQhi3dRicW+kaP1Oi9JPSmnAFL7XAc0eCvgrA@mail.gmail.com>
 <8e881b80-614c-dccf-ddaf-895d1acf26c7@marcan.st>
 <CAL_JsqLMgkTdbKNP=kAvwKFQp+m330ztTX8v_UFmj2zvzsB-KA@mail.gmail.com>
 <7f6928fc-97fd-cbe8-f7e9-954945b4574b@marcan.st>
 <CAL_Jsq+2svQ+1GOw2HcxR88dHog7V=5dbCVgi37Dw6ariZsiqQ@mail.gmail.com>
 <f3c5f961-d06c-47e2-453f-ec48e758a684@marcan.st>
 <CAL_JsqK5_iy0b4ayj26-V+r3i_E9RbxCGKhY_ssBW2bjbCn98A@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <5355b493-fa4b-8641-235c-37d6d3f72f60@marcan.st>
Date:   Fri, 3 Dec 2021 23:27:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK5_iy0b4ayj26-V+r3i_E9RbxCGKhY_ssBW2bjbCn98A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/12/2021 23.21, Rob Herring wrote:
> On Fri, Dec 3, 2021 at 7:47 AM Hector Martin <marcan@marcan.st> wrote:
>>
>> On 02/12/2021 23.33, Rob Herring wrote:
>>>>>>>> +       max_gen = of_pci_get_max_link_speed(port->np);
>>>>>>>> +       if (max_gen < 0) {
>>>>>>>> +               dev_err(port->pcie->dev, "max link speed not specified\n");
>>>>>>>
>>>>>>> Better to fail than limp along in gen1? Though you don't check the
>>>>>>> return value...
>>>>>>>
>>>>>>> Usually, the DT property is there to limit the speed when there's a
>>>>>>> board limitation.
>>>>>>
>>>>>> The default *setting* is actually Gen4, but without
>>>>>> PCIE_LINK_WIDTH_SPEED_CONTROL poked it always trains at Gen1. Might make
>>>>>> more sense to only set the LNKCTL field if max-link-speed is specified,
>>>>>> and unconditionally poke that bit. That'll get us Gen4 by default (or
>>>>>> even presumably Gen5 in future controllers, if everything else stays
>>>>>> compatible).
>>>>>
>>>>> You already do some setup in firmware for ECAM, right? I think it
>>>>> would be better if you can do any default setup there and then
>>>>> max-link-speed is only an override for the kernel.
>>>>
>>>> I thought the PCIE_LINK_WIDTH_SPEED_CONTROL thing had to be set later,
>>>> but trying it now I realized we were missing a bit of initialization
>>>> that was causing it not to work. Indeed it can be done there and we can
>>>> drop it from the kernel.
>>>>
>>>> We could even do the max-link-speed thing in m1n1 if we want. It has
>>>> access to the value from the ADT directly, which to be correct we'd have
>>>> to dynamically transplant to the DT, since there's at least one device
>>>> that has different PCIe devices on one port depending on hardware
>>>> variant, while sharing a devicetree. If we're okay with the kernel just
>>>> not implementing this feature for now, we can say it's the bootloader's job.
>>>>
>>>> Ultimately we ship the DTs along with m1n1, so there's an argument that
>>>> if some day we need to override the max-link-speed for whatever reason
>>>> over what the ADT says, well, we'd be shipping the updated DT along with
>>>> m1n1 anyway, so we might as well make m1n1 do it... if so, it might make
>>>> sense to drop those properties from the actual DTs we ship altogether,
>>>> at least for now.
>>>>
>>>> If we decide to make it m1n1's job entirely, we can drop this patch
>>>> altogether, at least for now (I can't say how this will interact with
>>>> suspend/resume and other power management, and hotplug... but we'll open
>>>> that can of worms when we get there).
>>>
>>> Shouldn't you be setting PCI_EXP_LNKCAP_SLS and/or PCI_EXP_LNKCAP2 if
>>> you need to limit the max speed and then you can use that instead of
>>> max-link-speed? If that's lost in low power modes, the driver just has
>>> to save and restore it.
>>
>> Those registers aren't writable as far as I can tell. All we can do is
>> set LNKCTL2 to tell the hardware what actual max speed to use, the same
>> thing this patch does.
> 
> I believe they are if you set the PCIE_DBI_RO_WR_EN bit. Multiple DWC
> drivers write PCI_EXP_LNKCAP.

Oh, indeed, that works. I figured that DBI stuff was only for the higher 
registers, not the core PCIe ones. Sounds like a plan then! We might 
still want to set LNKCTL2 though, since there's no point in that 
specifying a higher speed than what we are now claiming the hardware 
supports.

We can drop this patch then, and probably the max-link-speed props in 
the DTs altogether. More stuff in m1n1 is good, makes it easier to keep 
older kernel support with new hardware :)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
