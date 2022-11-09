Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BD1622351
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 06:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiKIFEX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 00:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKIFEW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 00:04:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DA715FEF;
        Tue,  8 Nov 2022 21:04:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1BCF617B5;
        Wed,  9 Nov 2022 05:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD431C433D6;
        Wed,  9 Nov 2022 05:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667970260;
        bh=ItjlVpSbxEq/aMaxmpIQJBJ5W3ryRWV9Hxx9vrGUQWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N04RyT3S5ShnL70ncD0kOZCnINE8BxxoxnhBEVry4B/9gMAdqhWx21ZtAz7XQMdv0
         TDc6HO1Vgs+81sP3aeqmg+B0qskiW3GbLPkfCpJln9ZFSdNqURxYj/0hy1bKWvgf/L
         nubLRuxTwWdXTceMtj7rYFjal/MdE/za28QZjTzj3xGn4YabvesrgJ6zR67o1JO/0w
         ZLhjGebS2bESHoJeIC5xmzneiT06I6YQZzcFG3NZWdevDQRw9uD6iIsWPCOduMrmYL
         tyqYfFM9b/Ia2SooGe0yE6c6tZ3MAQQhlf6jwl6IEQ1rJY4AfZn66qWzk2Qa1I4uTO
         kpe9qZuEqQxKA==
Date:   Tue, 8 Nov 2022 23:04:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: Work around PCIe link training failures
Message-ID: <20221109050418.GA529724@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2211090014500.15287@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, in case he has any reset-related comments]

On Wed, Nov 09, 2022 at 02:57:57AM +0000, Maciej W. Rozycki wrote:
> Hi Bjorn,
> 
>  Thank you for coming back to this patch series.  I'll try to address your 
> concerns, but it may take a little.  The reason is I'm currently on site 
> at my lab until the end of the week and barring my day job, etc. I want to 
> focus on items to do (and I do have a bunch) that require local hardware 
> access.  The issue concerned with this patch series does not, so I'll get 
> to looking into it in more depth hopefully from next week.  For the time 
> being however please see below.
> 
> On Thu, 3 Nov 2022, Bjorn Helgaas wrote:
> 
> > > > > Also check for a 2.5GT/s speed restriction the firmware may have already 
> > > > > arranged and lift it too with ports of devices known to continue working 
> > > > > afterwards, currently the ASM2824 only, that already report their data 
> > > > > link being up.
> > > > 
> > > > This quirk is run at boot-time and resume-time.  What happens after a
> > > > Secondary Bus Reset, as is done by pci_reset_secondary_bus()?
> > > 
> > > Flipping SBR bit can be done on any PCI-to-PCI bridge device and in this
> > > topology there are following: PCIe Root Port, ASMedia PCIe Switch
> > > Upstream Port, ASMedia PCIe Switch Downstream Port, Pericom PCIe Switch
> > > Upstream Port, Pericom PCIe Switch Downstream Port.
> > > (Maciej, I hope that this is whole topology and there is not some other
> > > device of PCI-to-PCI bridge type in your setup; please correct me)
> 
>  There is actually a PCIe-to-PCI bridge device further downstream (device 
> 0000:08:00.0 in the listings below; bus 09 is conventional PCI), but it 
> doesn't matter for the issue concerned; the issue triggers whether the 
> bridge module has been plugged or not.
> 
> > > Bjorn, to make it clear, on which device you mean to issue secondary bus
> > > reset?
> > 
> > IIUC, the problem is observed on the link between the ASM2824
> > downstream port and the PI7C9X2G304 upstream port, so my question is
> > about asserting SBR on the ASM2824 downstream port.  I think that
> > should cause the link between ASM2824 and PI7C9X2G304 to go down and
> > back up.
> 
>  That would be my expectation as well.  Is there a reliable way to request
> that however without actually writing a piece of code to do so from inside 
> the kernel?  Sadly our documentation is vague on the matter, in particular 
> Documentation/ABI/testing/sysfs-bus-pci, but here's what I have obtained:
> 
> # lspci -t
> -[0000:00]---00.0-[01-0b]----00.0-[02-0b]--+-00.0-[03]--
>                                            +-02.0-[04]----00.0
>                                            +-03.0-[05-09]----00.0-[06-09]--+-01.0-[07]--+-00.0
>                                            |                               |            \-00.3
>                                            |                               \-02.0-[08-09]----00.0-[09]--+-01.0
>                                            |                                                            \-02.0
>                                            +-04.0-[0a]----00.0
>                                            \-08.0-[0b]--+-00.0
>                                                         \-00.1
> # for name in /sys/bus/pci/devices/0000\:??\:??.?/reset_method; do echo "$(basename $(dirname $name)): $(cat $name)"; done
> 0000:01:00.0: pm bus
> 0000:02:00.0: pm bus
> 0000:02:02.0: pm
> 0000:02:03.0: pm
> 0000:02:04.0: pm
> 0000:02:08.0: pm
> 0000:04:00.0: bus
> 0000:05:00.0: bus
> 0000:06:01.0: bus
> 0000:07:00.0: bus
> 0000:08:00.0: bus
> 0000:09:01.0: pm bus
> 0000:0a:00.0: flr bus
> 0000:0b:00.0: pm bus
> 0000:0b:00.1: pm
> # 
> 
> (mind that the problematic link is between 0000:02:03.0 and 0000:05:00.0), 
> and then:
> 
> # echo 1 >/sys/bus/pci/devices/0000\:05\:00.0/reset
> -sh: echo: write error: Inappropriate ioctl for device
> # 
> 
> (which I gather is supposed to poke at 0000:02:03.0's SBR) so it doesn't 
> seem to be effective.  

05:00.0 supports the "bus" method, i.e., pci_reset_bus_function(),
which tries pci_dev_reset_slot_function() followed by
pci_parent_bus_reset().  Both of them return -ENOTTY if the device
(05:00.0) has a secondary bus ("dev->subordinate"), so I think nothing
happens here.

This was prompted by my question about whether the link comes up
correctly after an SBR.  It looks like it's not a problem when 02:03.0
and 05:00.0 are both switches because we don't use SBR in that case.

But if 05:00.0 were an endpoint instead of a switch, we *would* use
SBR, and then (I think) the link would go down, and this quirk would
not be applied.

> Needless to say:
> 
> # echo 1 >/sys/bus/pci/devices/0000\:02\:03.0/reset
> # 
> 
> while apparently succeeds doesn't do anything spectacular.  Any 
> suggestions?
> 
>  In any case I would expect resetting a bus tree to cause all the quirks 
> required to be reapplied, preferably after bus re-enumeration even as the 
> topology can change afterwards if not for the hardware erratum handled 
> here, although indeed I would find it reasonable to only perform the 
> actions on the bus subtree reset and not it's parent.  In that case the 
> quirk would have to be applied by hand somehow.

A lot of things can change after a reset, especially if it makes a
device reload updated firmware, but we don't actually re-enumerate or
reapply quirks.  I'm looking at pci_reset_function(), where we
basically save the parts of config space we know about, do the reset,
and restore config space.

> > Thanks for the question; I didn't notice before that this quirk
> > applies to *all* devices.  I'm a little queasy about trying to fix
> > problems we have not observed.  In this case, I think the hardware is
> > *supposed* to establish a link at the highest supported speed
> > automatically.
> 
>  I believe hardware is supposed to establish a link at all in the first 
> place (i.e. initially at 2.5GT/s, and then possibly upgrade afterwards as 
> capabilities have been exchanged between the endpoints), however as this 
> case indicates this is not necessarily universally guaranteed.
> 
> > If we need to work around a hardware bug, that's fine, but I'm not
> > sure I want to blindly try to help things along.
> 
>  I have chewed it over before choosing this approach and did this for what 
> I think is a very good reason, first for U-Boot and then, when I figured 
> out a feasible approach, also for Linux.  Bear in mind that we have a pair 
> of devices that completely fail to negotiate link ever by default and we 
> do not know whether it's the upstream device (which we can see) or the 
> downstream device (which we can't, because the link is down) that is the 
> culprit.  With that we have as follows.
> 
> 1. Both devices in question are PCIe switches, so they can be swapped with 
>    each other.  In that case what is now the upstream device will become 
>    the downstream device and vice versa.  Now the Pericom/Diodes switch 
>    only has 2.5GT/s downstream ports, so the issue by definition cannot 
>    trigger, but companies/designers tend to reuse hardware IP blocks, and 
>    I am quite sure Pericom/Diodes has switches in its product line that 
>    support rates beyond 2.5GT/s in their downstream ports.  So a swapped 
>    scenario is in my opinion quite real.  Matching on the vendor:device ID 
>    won't work then as the suspect ASMedia part will not be seen due to a 
>    failed link.  If it's the Pericom/Diodes switch that is the culprit, 
>    then it's even worse, as it is the downstream device already.
> 
> 2. We don't know really what the ultimate cause is and therefore whether 
>    the issue can trigger with other vendor devices (and presumably one of 
>    the two involved here).  And the nature of the failure is such, that I 
>    think it is very unlikely a user will reach out to our (Linux kernel) 
>    community for a workaround.  It does not look like a software problem 
>    at all and neither like one that can be solved by software.
> 
>    Therefore they will most likely conclude hardware they have is broken 
>    and throw it out causing frustration even though the hardware might be 
>    (im)perfectly capable of working, just requiring a little poke to get 
>    going.
> 
>    Just as I almost threw it out even though I dare say I am quite an 
>    experienced engineer, reasonably familiar with odd hardware and the 
>    Linux kernel and ultimately I was able to come up with a solution.  It 
>    is only because I noticed by chance that 0000:02:03.0 device's Link 
>    Training bit is flipping, combined with my imagination as to how to 
>    possibly deal with such a situation that I succeeded in bringing the 
>    link up.  I genuinely thought all was lost and I was exceedingly happy 
>    when I overcame it as the PI7C9X2G304 switch module was key to my 
>    project with no suitable alternative on the horizon.
> 
> 3. We apply this quirk to failed links only.  As a non-working link is a
>    fatal condition, things cannot get worse by trying to retrain it by 
>    hand at 2.5GT/s, as otherwise it doesn't work anyway.  So it's just a 
>    last ditch attempt to make it run really.
> 
>    Can you think of a scenario where retraining a non-working link would 
>    cause more damage than leaving it alone in the non-working state?  
> 
>    This quirk only uses generic PCIe features, common to all hardware, and 
>    therefore I think it can be applied in a generic manner.  Now there 
>    could be broken hardware that does not correctly handle the generic 
>    features used here, but if it has a failed link too, then it will just 
>    continue not to work.  So it won't be a regression.

The first big chunk of the quirk (that retrains the link) only runs on
Downstream Ports, and only when PCI_EXP_LNKSTA_DLLLA is clear, i.e.,
when the link is down.  What happens if this Downstream Port doesn't
have anything below it, e.g., it leads to an empty slot?  Is there
something that prevents us from attempting a retrain and waiting for
the timeout?

I was about to say the second chunk is always run even when the link
was up, but now I see that it's only for the ASMedia ASM2824.  So this
part is more like a traditional quirk that could specify that device.

If we think the first part (attempting the retrain) is safe to do
whenever the link is down, maybe we should do that more directly as
part of the PCI core instead of as a quirk?

For anybody joining late, the patch is here:
https://lore.kernel.org/r/alpine.DEB.2.21.2209130050380.60554@angie.orcam.me.uk

>  Now if I made any mistake in getting the conditions wrong that are 
> supposed to determine that a link is non-working, than I'll be glad to 
> have the code corrected.  Such a case shouldn't determine the overall 
> validity of the approach I propose here though.
> 
>  NB I have included code to lift the 2.5GT/s restriction, matched by the 
> downstream port's vendor:device ID, but now that I've been thinking about 
> this issue again I suspect it might be too liberal, because we don't 
> really know if it is safe to do so if the downstream device is not a 
> PI7C9X2G304.  So perhaps we need to match on the vendor:device IDs of both 
> endpoints of such a broken link.  What do you think?
> 
>  I'll let you chew my reasoning over now too, as I have an issue with a
> non-working PCIe parallel port device to sort out (device 0000:07:00.0 
> above) and that actually requires flipping rocker switches in my lab, 
> which I cannot do remotely.  Thank you for your review.
> 
>   Maciej
