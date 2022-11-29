Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D5F63BD68
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 10:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiK2J5h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 04:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiK2J53 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 04:57:29 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F5965C777;
        Tue, 29 Nov 2022 01:57:26 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8990B92009C; Tue, 29 Nov 2022 10:57:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8221E92009B;
        Tue, 29 Nov 2022 09:57:25 +0000 (GMT)
Date:   Tue, 29 Nov 2022 09:57:25 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: Work around PCIe link training failures
In-Reply-To: <20221109050418.GA529724@bhelgaas>
Message-ID: <alpine.DEB.2.21.2211091300490.15287@angie.orcam.me.uk>
References: <20221109050418.GA529724@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 8 Nov 2022, Bjorn Helgaas wrote:

> >  That would be my expectation as well.  Is there a reliable way to request
> > that however without actually writing a piece of code to do so from inside 
> > the kernel?  Sadly our documentation is vague on the matter, in particular 
> > Documentation/ABI/testing/sysfs-bus-pci, but here's what I have obtained:
> > 
> > # lspci -t
> > -[0000:00]---00.0-[01-0b]----00.0-[02-0b]--+-00.0-[03]--
> >                                            +-02.0-[04]----00.0
> >                                            +-03.0-[05-09]----00.0-[06-09]--+-01.0-[07]--+-00.0
> >                                            |                               |            \-00.3
> >                                            |                               \-02.0-[08-09]----00.0-[09]--+-01.0
> >                                            |                                                            \-02.0
> >                                            +-04.0-[0a]----00.0
> >                                            \-08.0-[0b]--+-00.0
> >                                                         \-00.1
> > # for name in /sys/bus/pci/devices/0000\:??\:??.?/reset_method; do echo "$(basename $(dirname $name)): $(cat $name)"; done
> > 0000:01:00.0: pm bus
> > 0000:02:00.0: pm bus
> > 0000:02:02.0: pm
> > 0000:02:03.0: pm
> > 0000:02:04.0: pm
> > 0000:02:08.0: pm
> > 0000:04:00.0: bus
> > 0000:05:00.0: bus
> > 0000:06:01.0: bus
> > 0000:07:00.0: bus
> > 0000:08:00.0: bus
> > 0000:09:01.0: pm bus
> > 0000:0a:00.0: flr bus
> > 0000:0b:00.0: pm bus
> > 0000:0b:00.1: pm
> > # 
> > 
> > (mind that the problematic link is between 0000:02:03.0 and 0000:05:00.0), 
> > and then:
> > 
> > # echo 1 >/sys/bus/pci/devices/0000\:05\:00.0/reset
> > -sh: echo: write error: Inappropriate ioctl for device
> > # 
> > 
> > (which I gather is supposed to poke at 0000:02:03.0's SBR) so it doesn't 
> > seem to be effective.  
> 
> 05:00.0 supports the "bus" method, i.e., pci_reset_bus_function(),
> which tries pci_dev_reset_slot_function() followed by
> pci_parent_bus_reset().  Both of them return -ENOTTY if the device
> (05:00.0) has a secondary bus ("dev->subordinate"), so I think nothing
> happens here.
> 
> This was prompted by my question about whether the link comes up
> correctly after an SBR.  It looks like it's not a problem when 02:03.0
> and 05:00.0 are both switches because we don't use SBR in that case.
> 
> But if 05:00.0 were an endpoint instead of a switch, we *would* use
> SBR, and then (I think) the link would go down, and this quirk would
> not be applied.

 After an SBR the link goes down, but the situation is actually somewhat 
more complex than you describe.

 Mind that the Target Link Speed field in the Link Control 2 register is 
sticky.  Consequently if the link goes down with TLS set to 2.5GT/s then 
it comes back up just fine, because it's still clamped at 2.5GT/s after 
reset.  The U-Boot workaround takes advantage of this observation and 
leaves TLS at 2.5GT/s.  This way if an OS is booted that is unaware of 
this erratum and resets the PCI/e hierarchy then U-Boot's workaround 
remains in action and the link resumes operation.

 Now when TLS is reset back to 5GT/s or higher, then the link goes down 
and starts its infinite training dance again.  This happens when TLS has 
been reset by hand in U-boot and Linux is booted and resets the PCI/e 
hierarchy in the course (but then our quirk chimes in), or under running 
Linux with this change applied when an SBR is issued via `setpci' or by a 
modified kernel that has the `dev->subordinate' condition removed.

> > Needless to say:
> > 
> > # echo 1 >/sys/bus/pci/devices/0000\:02\:03.0/reset
> > # 
> > 
> > while apparently succeeds doesn't do anything spectacular.  Any 
> > suggestions?
> > 
> >  In any case I would expect resetting a bus tree to cause all the quirks 
> > required to be reapplied, preferably after bus re-enumeration even as the 
> > topology can change afterwards if not for the hardware erratum handled 
> > here, although indeed I would find it reasonable to only perform the 
> > actions on the bus subtree reset and not it's parent.  In that case the 
> > quirk would have to be applied by hand somehow.
> 
> A lot of things can change after a reset, especially if it makes a
> device reload updated firmware, but we don't actually re-enumerate or
> reapply quirks.  I'm looking at pci_reset_function(), where we
> basically save the parts of config space we know about, do the reset,
> and restore config space.

 Right.  That's what the debug messages I have observed indicated as well.  

 For the record, I made an experiment and with the `dev->subordinate'
condition removed I reset device 05:00.0 in my system via:

# echo 1 >/sys/bus/pci/devices/0000\:05\:00.0/reset

 With the TLS reset back to its 8GT/s default here the link did not come 
back up as expected and consequently no device from this bus subhierarchy 
was accessible anymore:

# lspci -s 05: -vnn
05:00.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch [12d8:2304] (rev ff) (prog-if ff)
	!!! Unknown header type 7f

Retraining by hand and then rescanning brought the subhierarchy back:

# setpci -s 02\:03.0 CAP_EXP+0x30.W=0061; setpci -s 02\:03.0 CAP_EXP+0x10.W=0020; sleep 1; setpci -s 02\:03.0 CAP_EXP+0x30.W=0063; setpci -s 02\:03.0 CAP_EXP+0x10.W=0020
# echo 1 >/sys/bus/pci/devices/0000\:02\:03.0/rescan
pci_bus 0000:03: busn_res: [bus 03] end is updated to 03
pci_bus 0000:04: busn_res: [bus 04] end is updated to 04
pci 0000:05:00.0: bridge configuration invalid ([bus ff-ff]), reconfiguring
pcieport 0000:06:01.0: bridge configuration invalid ([bus ff-ff]), reconfiguring
pcieport 0000:06:02.0: bridge configuration invalid ([bus ff-ff]), reconfiguring
pci_bus 0000:07: busn_res: [bus 07] end is updated to 07
pci 0000:08:00.0: bridge configuration invalid ([bus ff-ff]), reconfiguring
pci_bus 0000:09: busn_res: [bus 09] end is updated to 09
pci_bus 0000:08: busn_res: [bus 08-09] end is updated to 09
pci_bus 0000:06: busn_res: [bus 06-09] end is updated to 09
pci_bus 0000:05: busn_res: [bus 05-09] end is updated to 09
pci_bus 0000:0a: busn_res: [bus 0a] end is updated to 0a
pci_bus 0000:0b: busn_res: [bus 0b] end is updated to 0b
# lspci -s 05: -vnn
05:00.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch [12d8:2304] (rev 05) (prog-if 00 [Normal decode])
	Flags: fast devsel
	Bus: primary=00, secondary=00, subordinate=00, sec-latency=0
	I/O behind bridge: 00000000-00000fff [size=4K]
	Memory behind bridge: 00000000-000fffff [size=1M]
	Prefetchable memory behind bridge: 0000000000000000-00000000000fffff [size=1M]
	Capabilities: [40] Power Management version 3
	Capabilities: [5c] Vital Product Data
	Capabilities: [64] Vendor Specific Information: Len=34 <?>
	Capabilities: [b0] Subsystem: Device [0000:0000]
	Capabilities: [c0] Express Upstream Port, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [20c] Power Budgeting <?>
	Capabilities: [230] Latency Tolerance Reporting

(though bridge BARs aren't exactly correct anymore).

 With the TLS clamped at 2.5GT/s the link did come back up and the bus 
subhierarchy remained accessible except for a downstream conventional PCI 
bus:

# lspci -s 09: -vnn
09:01.0 FDDI network controller [0202]: Digital Equipment Corporation PCI-to-PDQ Interface Chip [PFI] FDDI (DEFPA) [1011:000f] (rev ff) (prog-if ff)
	!!! Unknown header type 7f
	Kernel driver in use: defxx

09:02.0 ATM network controller [0203]: Microsemi / PMC / IDT IDT77201/77211 155Mbps ATM SAR Controller [NICStAR] [111d:0001] (rev ff) (prog-if ff)
	!!! Unknown header type 7f
	Kernel driver in use: nicstar

which had to be restored by hand:

# echo 1 >/sys/bus/pci/devices/0000\:08\:00.0/rescan
pci_bus 0000:08: scanning bus
pci 0000:08:00.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:08:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:08:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:09: scanning bus
pci_bus 0000:09: bus scan returning with max=09
pci_bus 0000:09: busn_res: [bus 09] end is updated to 09
pci_bus 0000:08: bus scan returning with max=09
# lspci -s 09: -vnn
09:01.0 FDDI network controller [0202]: Digital Equipment Corporation PCI-to-PDQ Interface Chip [PFI] FDDI (DEFPA) [1011:000f] (rev 02)
	Subsystem: Digital Equipment Corporation FDDIcontroller/PCI (DEFPA) [1011:def1]
	Flags: bus master, medium devsel, latency 64, IRQ 24
	Memory at 60831000 (32-bit, non-prefetchable) [size=128]
	I/O ports at 2100 [size=128]
	Memory at 60820000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
        Kernel driver in use: defxx

09:02.0 ATM network controller [0203]: Microsemi / PMC / IDT IDT77201/77211 155Mbps ATM SAR Controller [NICStAR] [111d:0001] (rev 03)
	Flags: bus master, medium devsel, latency 64, IRQ 26
	I/O ports at 2000 [size=256]
	Memory at 60830000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 60800000 [virtual] [disabled] [size=128K]
	Kernel driver in use: nicstar

> >  I have chewed it over before choosing this approach and did this for what 
> > I think is a very good reason, first for U-Boot and then, when I figured 
> > out a feasible approach, also for Linux.  Bear in mind that we have a pair 
> > of devices that completely fail to negotiate link ever by default and we 
> > do not know whether it's the upstream device (which we can see) or the 
> > downstream device (which we can't, because the link is down) that is the 
> > culprit.  With that we have as follows.
> > 
> > 1. Both devices in question are PCIe switches, so they can be swapped with 
> >    each other.  In that case what is now the upstream device will become 
> >    the downstream device and vice versa.  Now the Pericom/Diodes switch 
> >    only has 2.5GT/s downstream ports, so the issue by definition cannot 
> >    trigger, but companies/designers tend to reuse hardware IP blocks, and 
> >    I am quite sure Pericom/Diodes has switches in its product line that 
> >    support rates beyond 2.5GT/s in their downstream ports.  So a swapped 
> >    scenario is in my opinion quite real.  Matching on the vendor:device ID 
> >    won't work then as the suspect ASMedia part will not be seen due to a 
> >    failed link.  If it's the Pericom/Diodes switch that is the culprit, 
> >    then it's even worse, as it is the downstream device already.
> > 
> > 2. We don't know really what the ultimate cause is and therefore whether 
> >    the issue can trigger with other vendor devices (and presumably one of 
> >    the two involved here).  And the nature of the failure is such, that I 
> >    think it is very unlikely a user will reach out to our (Linux kernel) 
> >    community for a workaround.  It does not look like a software problem 
> >    at all and neither like one that can be solved by software.
> > 
> >    Therefore they will most likely conclude hardware they have is broken 
> >    and throw it out causing frustration even though the hardware might be 
> >    (im)perfectly capable of working, just requiring a little poke to get 
> >    going.
> > 
> >    Just as I almost threw it out even though I dare say I am quite an 
> >    experienced engineer, reasonably familiar with odd hardware and the 
> >    Linux kernel and ultimately I was able to come up with a solution.  It 
> >    is only because I noticed by chance that 0000:02:03.0 device's Link 
> >    Training bit is flipping, combined with my imagination as to how to 
> >    possibly deal with such a situation that I succeeded in bringing the 
> >    link up.  I genuinely thought all was lost and I was exceedingly happy 
> >    when I overcame it as the PI7C9X2G304 switch module was key to my 
> >    project with no suitable alternative on the horizon.
> > 
> > 3. We apply this quirk to failed links only.  As a non-working link is a
> >    fatal condition, things cannot get worse by trying to retrain it by 
> >    hand at 2.5GT/s, as otherwise it doesn't work anyway.  So it's just a 
> >    last ditch attempt to make it run really.
> > 
> >    Can you think of a scenario where retraining a non-working link would 
> >    cause more damage than leaving it alone in the non-working state?  
> > 
> >    This quirk only uses generic PCIe features, common to all hardware, and 
> >    therefore I think it can be applied in a generic manner.  Now there 
> >    could be broken hardware that does not correctly handle the generic 
> >    features used here, but if it has a failed link too, then it will just 
> >    continue not to work.  So it won't be a regression.
> 
> The first big chunk of the quirk (that retrains the link) only runs on
> Downstream Ports, and only when PCI_EXP_LNKSTA_DLLLA is clear, i.e.,
> when the link is down.  What happens if this Downstream Port doesn't
> have anything below it, e.g., it leads to an empty slot?  Is there
> something that prevents us from attempting a retrain and waiting for
> the timeout?

 The conditions I came up with for the detection of a failed link 
negotiation are supposed to tell this situation apart from an absent 
endpoint on the other end of a link.

 Indeed in the system affected there is the 02:00.0 downstream port device 
within the same ASM2824 switch that is not connected to anything (no slot 
there or an onboard device; essentially just a wasted x2 downstream port 
the board designers could not come up with a use for) and the quirk just 
does not trigger for it, because the conditions it checks are not met for 
an unconnected link.  Specifically the Link Bandwidth Management Status 
bit in the Link Status register cannot be set to 1 for an unconnected 
link, because setting the bit requires a link to hold the DL_Up status and 
that does not happen when there is no component on the other side of the 
link.  That's at least my understanding.

 I have no immediate way to verify other ports, because I am away from my 
lab now and the system has its PCI/e hierarchy otherwise fully occupied, 
but the behaviour was consistent as I made extensive verification earlier 
on.

 The same condition is used by the U-Boot workaround BTW.

> I was about to say the second chunk is always run even when the link
> was up, but now I see that it's only for the ASMedia ASM2824.  So this
> part is more like a traditional quirk that could specify that device.
> 
> If we think the first part (attempting the retrain) is safe to do
> whenever the link is down, maybe we should do that more directly as
> part of the PCI core instead of as a quirk?

 At this point in my understanding of the situation I tend to agree.  
This will guarantee that device resets issued under our control will do 
the right thing (we can't do anything I suppose about requests issued by 
`setpci' behind our back) and is also what the U-Boot workaround I have 
come up with does.  I'll make v6 along these lines.

 Thank you for your inquisitiveness and the review.

  Maciej
