Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 471974A465
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 16:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfFROsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 10:48:40 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:41328 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfFROsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 10:48:40 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hdFPU-0008NL-GY; Tue, 18 Jun 2019 16:48:32 +0200
Message-ID: <cf64e3152cbf4c18bc8e91a14f24a0b845e90c28.camel@sipsolutions.net>
Subject: Re: [PATCH V4 22/28] PCI: tegra: Access endpoint config only if
 PCIe link is up
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-wireless@vger.kernel.org
Date:   Tue, 18 Jun 2019 16:48:30 +0200
In-Reply-To: <20190618134038.GA1397@ulmo> (sfid-20190618_154041_926571_316DC8D7)
References: <09bcc121-eaca-3866-d0ef-7806503e883f@nvidia.com>
         <ca34eb24-8696-576f-26bc-8d6141f81a41@nvidia.com>
         <20190613143946.GA30445@e121166-lin.cambridge.arm.com>
         <20190613154250.GA32713@ulmo>
         <a523a19c-fdfa-01f7-6f6d-2ca367a10a50@nvidia.com>
         <20190617114745.GL508@ulmo> <20190617193024.GC13533@google.com>
         <a7e0472d-f4a7-ed63-836a-b5e8b1360645@nvidia.com>
         <20190618104918.GA28892@ulmo>
         <9c0fb01f0dc6a193265297eaa100a35ff25413e7.camel@sipsolutions.net>
         <20190618134038.GA1397@ulmo> (sfid-20190618_154041_926571_316DC8D7)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2019-06-18 at 15:40 +0200, Thierry Reding wrote:
> On Tue, Jun 18, 2019 at 02:32:59PM +0200, Johannes Berg wrote:
> > I got to this thread really late I guess :-)
> > 
> > On Tue, 2019-06-18 at 12:49 +0200, Thierry Reding wrote:
> > 
> > > > > > > > > > > 1. WiFi devices provides power-off feature for power saving
> > > > > > > > > > > in mobiles.  When WiFi is turned off we shouldn't power on
> > > > > > > > > > > the HW back without user turning it back on.
> > 
> > But why would you disconnect the PCIe device just to power it down?!
> 
> It's a side-effect of asserting that W_DISABLE pin that the bus link
> basically goes down. We've had a similar case recently, one that we
> haven't quite solved either, where an RTL8169 Ethernet controller is
> hooked up to a GPIO that controls the ISOLATEB (I think that was the
> name) pin. If that pin is asserted, according to the documentation,
> the device stops sampling/driving the PCI signals. So for all intents
> and purposes it becomes disconnected.

Right.

> We could kind of deal with this if the ISOLATEB was deasserted at probe
> time, because that would mean that the device is at least enumerated on
> PCI. Then when we go into some power down mode (for example when the
> interface is taken down), the NIC driver could assert the GPIO and on
> resuming from the power down mode deassert it again. Logically the
> device would stay around, we just couldn't talk to it over PCI until the
> driver has deasserted the ISOLATEB GPIO.
> 
> The problem is that it's not exactly defined what the status of the pin
> would be at probe time. If it is asserted, the NIC will never show up on
> the PCI bus and hence no driver would be registered that could deassert
> the ISOLATEB signal. Well, unless we somehow created a "placeholder" PCI
> device based on a device tree node (containing a reference to the GPIO)
> so that the device would be enumerated (and probed) regardless of the
> PCI link. There's no infrastructure to do that currently, but perhaps
> worth investigating.
> 
> I think the W_DISABLE is somewhat similar. From what Manikanta was
> saying, the PCI link also goes down when the pin is asserted, so we
> loose any means of communicating with it over PCI.
> 
> The issue that Manikanta was trying to solve with this particular patch
> was that since the PCI device is part of the PCI device hierarchy, some
> userspace tools (X server, for example) will see it and try to discover
> whether it's a GPU or not. This in turn causes errors from the PCI host
> controller because it's trying to access a device behind a link that's
> down. That, I assume, could also happen for the ISOLATEB case that I was
> describing above, though it hasn't been brought up, I think.

Agree, sounds like it.

> > > > > > > > The problem that Manikanta is trying to solve here occurs in
> > > > > > > > this situation (Manikanta, correct me if I've got this wrong):
> > > > > > > > on some setups, a WiFi module connected over PCI will toggle a
> > > > > > > > power GPIO as part of runtime suspend. This effectively causes
> > > > > > > > the module to disappear from the PCI bus (i.e. it can no longer
> > > > > > > > be accessed until the power GPIO is toggled again).
> > > > > > > 
> > > > > > > GPIO is toggled as part of WiFi on/off, can be triggered from
> > > > > > > network manager UI.
> > 
> > That's kinda icky, IMHO.
> 
> Isn't that kind of the point of rfkill? I seem to remember having a
> notebook where this was done exactly the same way. There was also a
> button/switch that you could push which would result in the WiFi device
> either going away completely or at the least loosing the WiFi link. It
> seems like that's exactly what Manikanta is describing.

Right.

So ... rfkill has some terminology issues sometimes. Let me clarify what
typically happens.

Usually, you have the rfkill instance "wiphy-xyz" which is on the
wireless NIC (through cfg80211). This has two things:

 1) software rfkill *control*
 2) hardware rfkill *reporting*

So a device like iwlwifi has software rfkill control through rfkill
"wiphy-phy0", which is really just implemented as "bring down all the
netdevs etc.". And then you have "HW rfkill reporting", where our NIC
just reports the current status of the W_DISABLE pin. This again causes
the software to turn off all the netdevs etc.

This is how it looks like for the *device* side.

Now, for the *platform* side, which we're really looking at now, we
usually have the rfkill be a bit differently:

hardware rfkill *reporting* isn't used at all here.

software rfkill *control*, instead of directly controlling the netdevs
etc. like the instances in cfg80211 do, this just controls the GPIO.


Now, in a typical platform with an Intel NIC, you have something like

platform rfkill device
 --> controls GPIO
  W_DISABLE pin
   --> reported as HW rfkill
    --> rfkill-wiphy0 device

In some other platforms, you literally just have a hardware button:

hardware button
 --> controls GPIO
  ... as before ...

Now, this all works great, but is basically software only, just using
the hardware pins as a communication mechanism.


Now, with some platforms, and particularly with BT USB devices where
I've seen this a lot (but never saw it with PCIe before), you have what
you're describing here, that the device just drops off the bus for an
rfkill.

Again, though, the actual cause of this might be a GPIO control (through
an rfkill instance) or something else like a literal hardware button
(not uncommon for Bluetooth).


> > Well, they said above it's a GPIO that controls it, so the software
> > already knows and doesn't really need an event?
> 
> We still need to communicate from rfkill to the PCI host controller that
> something happened, since they are two different entities.

Yeah, but the question is if we really need it from *rfkill* rather than
the GPIO as I described below?

> > > > The rfkill subsystem provides a generic interface for disabling any radio
> > > > transmitter in the system. WiFi M.2 form factor cards provide W_DISABLE
> > > > GPIO to control the radio transmitter
> > 
> > But it depends on the hardware how this is handled, Intel NICs for
> > example just trigger an IRQ to the host and don't turn off much, for
> > them the W_DISABLE pin is just a GPIO in input mode, with edge triggered
> > interrupt to the driver.
> 
> Okay, so does this mean you have some input device connected to the WiFi
> device that will be used (without software intervention) to disable the
> transmitter and then the WiFi device will signal using the W_DISABLE pin
> that the transmitter was indeed disabled?

See above.

> This was just an example of what I was imagining. The network driver
> would get an rfkill (looked up via device tree phandle) and subscribe to
> receive events from it, so that it could be notified when the rfkill is
> "blocked" and rescan the bus to get the WiFi device unplugged. Once
> unblocked it would be notified again and rescan the bus so that the
> device would reappear.

Ok. Not sure we need much involvement of the driver and/or the rfkill
even though.

> > I mean, let's say first we make rfkill-gpio DT-aware, rather than just
> > ACPI. This should be simple. Then it drives a GPIO (it can actually
> > drive two and a clock, not sure I know why).
> > 
> > Now, next we need something that says that the device should be treated
> > as hotplug/unplug. We could make this in the driver somehow like you
> > suggested, but that seems like a lot of effort?
> > 
> > Couldn't we put this into the *GPIO* subsystem instead?
> > 
> > I mean - conceivably there could be GPIOs that just power down a device
> > for example. Not even through something like W_DISABLE, but just having
> > a GPIO hooked up to a transistor on the voltage pin of the device. That
> > would have very similar semantics?
> > 
> > So why not just attach the PCIe device/port to the GPIO, and have the
> > GPIO implementation here call the detach/attach (or detach/rescan?) when
> > they are toggled?
> > 
> > Not that I'd mind having it in rfkill! But it seems like a special case
> > to have it there, when you can do so much more with GPIOs.
> 
> Yeah, that's where things become a little muddy. For the ISOLATEB case
> there was initially a similar proposal. 

OK.

> The problem is that on one hand
> we can have different semantics for these pins. On one platform this
> could be a kind of "power" GPIO, on others it could be ISOLATE/DISABLE,
> and on yet others it would be more like a reset. In order to make the
> PCIe port aware of the differences we'd have to expose multiple GPIOs in
> DT for context.

Right, but does it matter?

I mean - does this have a different impact on the software? It seems to
me one way or the other all you really need to do is hot-unplug a device
on the right signal one way, and rescan for devices on the other signal?

> The other problem with this is that, in order to avoid the chicken-and-
> egg problem, we need to associate these GPIOs with the root ports,
> because those are the only ones that exist at probe time. All downstream
> devices may not be available because the power/reset/disable pin is not
> asserted/deasserted yet. Now, you could potentially have a switch in the
> downstream hierarchy, so it becomes completely unclear what exact device
> the GPIO is associated with.

Hmm, sort of I guess. I think you need *both* associations really.

On the "disappear" transition, you need it to be linked to a very
specific device. On the "appear" transition, you need the rescan of the
root port right?

> Related to that, a GPIO like this is really only useful if you can make
> use of it. For example you want to assert/deassert this GPIO in order to
> put the WiFi/Ethernet/whatever device into a low-power mode when it is
> not used, right? But in order to do so, the driver for that device needs
> to be able to handle the GPIO, because it is the only one that knows the
> right point in time to toggle it. Conversely, if this was associated
> with the root port, the only point in time where the root port driver
> could toggle it is on a suspend/resume of the entire bus, which makes it
> rather useless.

Depends. If you're talking about rfkill, you have a completely separate
rfkill-gpio device (the "platform rfkill device" I was talking about
earlier), and the driver for the actual wifi NIC isn't actually involved
at all.

> But then we're back to square one where we basically have to associate
> the GPIO with the specific device. I think that's the right thing to do
> because, well, that's what reality is. The GPIO is directly routed to a
> pin on the chip. It's not something that goes over the PCI connector or
> anything. However, we're also back to the chicken-and-egg problem since
> without toggling the GPIO the device might not even get enumerated.
> 
> rfkill-gpio has the advantage that it decouples this and gets us out of
> the chicken-and-egg situation. It also has fairly well-defined semantics
> and fits the use-case, so it's a very appealing option.

Sure, I get that, but I still don't understand why we should link it to
the rfkill rather than the GPIO?

I mean, if we have these things in the platform/DT:

 WIFI-WDISABLE-GPIO
 WIFI-NIC-PCIE
 PCIE-ROOT-PORT
 PLATFORM-WIFI-RFKILL

then we'd describe the

  PLATFORM-WIFI-RFKILL as an rfkill-gpio using the WIFI-WDISABLE-GPIO

and make some sort of link:

 WIFI-WDISABLE-GPIO --enable-rescan-- PCIE-ROOT-PORT
                    --unplug-device-- WIFI-NIC-PCIE

or not?

johannes

