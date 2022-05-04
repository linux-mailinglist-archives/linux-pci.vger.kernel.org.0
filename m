Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D3519608
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 05:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbiEDDjq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 23:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiEDDjp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 23:39:45 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C1D27FE1;
        Tue,  3 May 2022 20:36:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DCF9041982;
        Wed,  4 May 2022 03:36:04 +0000 (UTC)
Message-ID: <57e47786-0b99-646e-9e73-694e47d14cf5@marcan.st>
Date:   Wed, 4 May 2022 12:36:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: es-ES
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220502093832.32778-1-marcan@marcan.st>
 <20220502093832.32778-4-marcan@marcan.st>
 <CAL_Jsq+_cWZUXtJVXC_cwhmADj0NQc95v1sqgFioMsfEX6OqGg@mail.gmail.com>
 <0ccc44cd-21aa-3670-24b3-4ee051dd3c12@marcan.st>
 <2615501d-7569-41cb-7039-46e690689f1f@marcan.st>
 <YnHJ2ZKd2CqhNWrX@robh.at.kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 3/3] PCI: apple: Add support for optional PWREN GPIO
In-Reply-To: <YnHJ2ZKd2CqhNWrX@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/05/2022 09.33, Rob Herring wrote:
> On Tue, May 03, 2022 at 12:20:48PM +0900, Hector Martin wrote:
>> Thinking about this some more, I think it still makes sense to have the
>> power enable GPIO in the PCI root port node. A generic power enable GPIO
>> still makes sense there (think "slot power"). The PCI core could handle
>> it properly by default, including turning it on prior to initial probing
>> and shutting it down when the device should go into whatever the PCI
>> core's idea of D3cold is. AIUI this already happens on some platforms
>> via firmware, right? Since D3cold is supposed to be a state where the
>> device receives no power after all.
> 
> We have put slot stuff in the bridge node. That's because PCI child 
> nodes already have a definition and we didn't define slot nodes up 
> front. We often have started without a slot/connector and then 
> retrofitted nodes in.
> 
> I can think of lots of ways to implement 'slot power' with a single GPIO 
> being just one way. If it's not defined by PCIe specs or defacto 
> standards then I don't think we want to try to do something generic.

The first question is whether it should go in the slot/port node for
apcie or the device node, the second question is whether it should be
generic or just specific to apcie :)

But the d3cold concept *is* defined by PCIe specs. See PCIe 4.0
5.3.1.4.2. "D3cold State".

> The other way to model power gpios is as a GPIO regulator. We probably 
> already have PCI examples doing that.

Could certainly do it as a regulator, yes, though that still leaves the
question of what node to put it in. If it goes in the device node we
still have the chicken and egg problem with device probing.

>> Obviously this can't handle funky power sequencing requirements, but we
>> don't have any of those here and we don't know if we ever will (at least
>> Apple seems to be a fan of throwing little CPLDs on their boards for
>> fine grained power sequencing, driven by a single IO). If we do, then
>> that would be the time to have GPIOs in the device node.
>>
>> In addition, sometimes a single power enable is shared between multiple
>> functions of one device. This is the case with WiFi/BT, which is a combo
>> chip with two functions. Coordinating GPIO usage between both drivers
>> would be problematic if they both try to own it.
> 
> A GPIO regulator solves this problem as it is reference counted.

Right, that it does.

>> The individual device drivers still need to have some kind of API to be
>> able to put devices into a low-power state. For example, the WiFi driver
>> could outright power down the device when it is wholly unused and the
>> interface is down (same for BT, and the PCI core should only put the
>> slot GPIO into powerdown if both functions say they should be off).
>> Similarly, the SD driver needs to support an external SD detect GPIO,
>> and have a mode where it tells the PCI core to shut down the device when
>> no SD is inserted, and power it back up on insertion. This all allows
>> the devices to behave a users might expect, with the device nodes
>> existing and the PCI devices "visible" even when they are powered down
>> behind the scenes, until they are needed. AIUI this is already how e.g.
>> hybrid graphics power management works, where power is outright yanked
>> from the secondary card when it is not needed even though it is still
>> visible from the userspace point of view (and it is automatically
>> powered and reinitialized on use).
> 
> Can it detect a card insertion when powered down?

The card detect is also hooked up to a PMU GPIO accessible via SMC which
has interrupt capability (which is not in that driver yet but I will add
that :-)). We can use that in conjunction with or in replacement of the
internal card detect.

> 
>> I'm not super familiar with PCI device power states (making brcmfmac
>> sleep work properly on these platforms is on my TODO list...) so I'd
>> love to get some feedback from the PCI folks on what they think about
>> this whole issue.
> 
> I'm not either. I know there's some backlog of work to rework PCI power 
> management to be more inline with how the rest of kernel drivers work.
>  
> Isn't D3cold an ACPI thing, not PCI?

It's a PCI thing. See Documentation/power/pci.txt for a discussion of
the various PCI power states. This is already part of the API, e.g.
pci_d3cold_enable and friends. Given how d3cold works today on existing
ACPI systems, I think it makes a lot more sense to add that to the PCI
port nodes (whether as a GPIO or a regulator, I don't really care) and
hook it up to that plumbing, rather than try to make the downstream
device driver reinvent that wheel. The PCI core needs to know about
d3cold transitions to save/restore certain config space registers. And
as far as I know this is all hooked up to runtime-pm, so if a driver
enables d3cold and runtime-pm the device can be powered down by the PCI
core when not in use.

So it'd go something like this:

- apcie driver, on slot activation, sees a pwren gpio/reg and powers it
on prior to bringing up the link (and marks that port as d3cold supported)
- sdhci-pci driver, on probe, sees an external card detect GPIO declared
and considers that license to call pci_d3cold_enable and enable
runtime-pm (since it won't need the internal card detect IRQ/GPIO)
- No SD card is inserted, so SD driver goes into runtime suspend and
saves whatever controller state it needs
- PCI core saves whatever config space stuff it needs to save, SD
controller is powered down via GPIO
- SD card is inserted, SMC GPIO IRQ notifies SD driver
- SD driver goes out of runtime suspend
- PCI core powers on controller, re-establishes link, restores config space
- SD driver restores host controller registers and discovers the new card

No new APIs, this is all existing kernel stuff. PCI manages slot power
same as it does on ACPI systems (that support it), driver interacts with
it via runtime-pm and the d3cold control stuff.

I'm tempted to prototype this today and see how it goes...

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
