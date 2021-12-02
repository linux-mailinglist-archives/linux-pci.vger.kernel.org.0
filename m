Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23813465DA0
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 05:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbhLBE6f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 23:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbhLBE6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 23:58:34 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD5C061574;
        Wed,  1 Dec 2021 20:55:12 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 58B8741F28;
        Thu,  2 Dec 2021 04:55:08 +0000 (UTC)
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
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH] PCI: apple: Configure link speeds properly
Message-ID: <7f6928fc-97fd-cbe8-f7e9-954945b4574b@marcan.st>
Date:   Thu, 2 Dec 2021 13:55:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLMgkTdbKNP=kAvwKFQp+m330ztTX8v_UFmj2zvzsB-KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/11/2021 00.02, Rob Herring wrote:
>> Sure, it just means I have to reinvent the PCI capability lookup wheel
>> again. I'd love to use the regular accessors, but the infrastructure
>> isn't up to the point where we can do that yet yere. DWC also reinvents
>> this wheel, but we can't reuse that code because it pokes these
>> registers through a separate reg range, not config space (even though it
>> seems like they should be the same thing? I'm not sure what's going on
>> in the DWC devices... for the Apple controller it's just the ECAM).
> 
> Since it is just ECAM, can you use the regular config space accessors?

The problem is this is before the PCI objects are created, so those 
wouldn't work since they expect to be called on a pci_dev and such.

>>>> +       max_gen = of_pci_get_max_link_speed(port->np);
>>>> +       if (max_gen < 0) {
>>>> +               dev_err(port->pcie->dev, "max link speed not specified\n");
>>>
>>> Better to fail than limp along in gen1? Though you don't check the
>>> return value...
>>>
>>> Usually, the DT property is there to limit the speed when there's a
>>> board limitation.
>>
>> The default *setting* is actually Gen4, but without
>> PCIE_LINK_WIDTH_SPEED_CONTROL poked it always trains at Gen1. Might make
>> more sense to only set the LNKCTL field if max-link-speed is specified,
>> and unconditionally poke that bit. That'll get us Gen4 by default (or
>> even presumably Gen5 in future controllers, if everything else stays
>> compatible).
> 
> You already do some setup in firmware for ECAM, right? I think it
> would be better if you can do any default setup there and then
> max-link-speed is only an override for the kernel.

I thought the PCIE_LINK_WIDTH_SPEED_CONTROL thing had to be set later, 
but trying it now I realized we were missing a bit of initialization 
that was causing it not to work. Indeed it can be done there and we can 
drop it from the kernel.

We could even do the max-link-speed thing in m1n1 if we want. It has 
access to the value from the ADT directly, which to be correct we'd have 
to dynamically transplant to the DT, since there's at least one device 
that has different PCIe devices on one port depending on hardware 
variant, while sharing a devicetree. If we're okay with the kernel just 
not implementing this feature for now, we can say it's the bootloader's job.

Ultimately we ship the DTs along with m1n1, so there's an argument that 
if some day we need to override the max-link-speed for whatever reason 
over what the ADT says, well, we'd be shipping the updated DT along with 
m1n1 anyway, so we might as well make m1n1 do it... if so, it might make 
sense to drop those properties from the actual DTs we ship altogether, 
at least for now.

If we decide to make it m1n1's job entirely, we can drop this patch 
altogether, at least for now (I can't say how this will interact with 
suspend/resume and other power management, and hotplug... but we'll open 
that can of worms when we get there).

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
