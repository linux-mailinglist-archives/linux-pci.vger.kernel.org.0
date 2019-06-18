Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3CE4A0DA
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 14:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfFRMdM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 08:33:12 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:39112 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRMdL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 08:33:11 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hdDIL-0005tO-An; Tue, 18 Jun 2019 14:33:01 +0200
Message-ID: <9c0fb01f0dc6a193265297eaa100a35ff25413e7.camel@sipsolutions.net>
Subject: Re: [PATCH V4 22/28] PCI: tegra: Access endpoint config only if
 PCIe link is up
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-wireless@vger.kernel.org
Date:   Tue, 18 Jun 2019 14:32:59 +0200
In-Reply-To: <20190618104918.GA28892@ulmo> (sfid-20190618_124921_930194_6A075FC5)
References: <20190516055307.25737-23-mmaddireddy@nvidia.com>
         <20190604131436.GS16519@ulmo>
         <09bcc121-eaca-3866-d0ef-7806503e883f@nvidia.com>
         <ca34eb24-8696-576f-26bc-8d6141f81a41@nvidia.com>
         <20190613143946.GA30445@e121166-lin.cambridge.arm.com>
         <20190613154250.GA32713@ulmo>
         <a523a19c-fdfa-01f7-6f6d-2ca367a10a50@nvidia.com>
         <20190617114745.GL508@ulmo> <20190617193024.GC13533@google.com>
         <a7e0472d-f4a7-ed63-836a-b5e8b1360645@nvidia.com>
         <20190618104918.GA28892@ulmo> (sfid-20190618_124921_930194_6A075FC5)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I got to this thread really late I guess :-)

On Tue, 2019-06-18 at 12:49 +0200, Thierry Reding wrote:

> > > > > > > > > 1. WiFi devices provides power-off feature for power saving
> > > > > > > > > in mobiles.  When WiFi is turned off we shouldn't power on
> > > > > > > > > the HW back without user turning it back on.

But why would you disconnect the PCIe device just to power it down?!

> > > > > > The problem that Manikanta is trying to solve here occurs in
> > > > > > this situation (Manikanta, correct me if I've got this wrong):
> > > > > > on some setups, a WiFi module connected over PCI will toggle a
> > > > > > power GPIO as part of runtime suspend. This effectively causes
> > > > > > the module to disappear from the PCI bus (i.e. it can no longer
> > > > > > be accessed until the power GPIO is toggled again).
> > > > > 
> > > > > GPIO is toggled as part of WiFi on/off, can be triggered from
> > > > > network manager UI.

That's kinda icky, IMHO.

> > > > > Correct, rfkill switch should handle the GPIO.
> > > > > Sequence will be,
> > > > >  - WiFi ON
> > > > >    - rfkill switch enables the WiFi GPIO
> > > > >    - Tegra PCIe receives hot plug event
> > > > >    - Tegra PCIe hot plug driver rescans PCI bus and enumerates the device
> > > > >    - PCI client driver is probed, which will create network interface
> > > > >  - WiFi OFF
> > > > >    - rfkill switch disables the WiFi GPIO
> > > > >    - Tegra PCIe receives hot unplug event
> > > > >    - Tegra PCIe hot plug driver removes PCI devices under the bus
> > > > >    - PCI client driver remove is executed, which will remove
> > > > >      network interface
> > > > > We don't need current patch in this case because PCI device is not
> > > > > present in the PCI hierarchy, so there cannot be EP config access
> > > > > with link down.  However Tegra doesn't support hot plug and unplug
> > > > > events. I am not sure if we have any software based hot plug event
> > > > > trigger.

Looks reasonable to me.

I guess if you absolutely know in software when the device is present or
not, you don't need "real" PCIe hotplug, just need to tickle the
software right?

> > > How does rfkill work?  It sounds like it completely removes power from
> > > the wifi device, putting it in D3cold.  Is there any software
> > > notification other than the "Slot present pin change" (which looks
> > > like a Tegra-specific thing)?

Well, they said above it's a GPIO that controls it, so the software
already knows and doesn't really need an event?

> > The rfkill subsystem provides a generic interface for disabling any radio
> > transmitter in the system. WiFi M.2 form factor cards provide W_DISABLE
> > GPIO to control the radio transmitter

But it depends on the hardware how this is handled, Intel NICs for
example just trigger an IRQ to the host and don't turn off much, for
them the W_DISABLE pin is just a GPIO in input mode, with edge triggered
interrupt to the driver.

> > and I have seen some cards provide
> > control to turn off complete chip through this GPIO. 

I never heard of this. Which NICs are we talking about?

> Perhaps what we need here is some sort of mechanism to make rfkill and
> the PCI host controller interoperate? I could imagine for example that
> the PCI host controller would get a new "rfkill" property in device
> tree that points at the rfkill device via phandle.

But you don't know which the rfkill device is, do you?

I mean, fundamentally, you just have a GPIO that turns on and off the
W_DISABLE pin. NICs will not generally disappear from the bus when
that's turned on, so you need a NIC driver integration.

I guess you also have an rfkill-gpio driver assigned to this GPIO, which
gets assigned there via DT/platform code?

Ah, but then I guess you could have a phandle in the DT or so that ties
the W_DISABLE-GPIO with the PCIe slot that it controls.

> The driver could then get a reference to it using something like:
> 
> 	rfkill = rfkill_get(dev);
> 	if (IS_ERR(rfkill)) {
> 		...
> 	}
> 
> and register for notification:
> 
> 	err = rfkill_subscribe(rfkill, callback);
> 	if (err < 0) {
> 		...
> 	}
> 
> rfkill_unsubscribe() and rfkill_put() would then be used upon driver
> unload to detach from the rfkill.

This I don't understand.

> I noticed that there's an rfkill-gpio driver (net/rfkill/rfkill-gpio.c)
> that already does pretty much everything that we need, except that it
> doesn't support DT yet, but I suspect that that's pretty easy to add.

Oh, good point, no DT support here - so how *do* you actually
instantiate the rfkill today??

> Johannes, any thoughts on this. In a nutshell what we're trying to solve
> here is devices that get removed from/added to PCI based on an rfkill-
> type of device. The difference to other implementations is that we have
> no way of detecting when the device has gone away (PCI hotplug does not
> work). So we'd need some software-triggered mechanism to let the PCI
> host controller know when the device is presumably going away or being
> added back, so that the PCI bus can be rescanned and the PCI device
> removed or added at that point).

Right.

So, I'm not even sure we need the *driver* to do anything other than say
"I know the device will drop off the bus when rfkill is enabled", right?


But do we actually need rfkill to be involved here?

I mean, let's say first we make rfkill-gpio DT-aware, rather than just
ACPI. This should be simple. Then it drives a GPIO (it can actually
drive two and a clock, not sure I know why).

Now, next we need something that says that the device should be treated
as hotplug/unplug. We could make this in the driver somehow like you
suggested, but that seems like a lot of effort?

Couldn't we put this into the *GPIO* subsystem instead?

I mean - conceivably there could be GPIOs that just power down a device
for example. Not even through something like W_DISABLE, but just having
a GPIO hooked up to a transistor on the voltage pin of the device. That
would have very similar semantics?

So why not just attach the PCIe device/port to the GPIO, and have the
GPIO implementation here call the detach/attach (or detach/rescan?) when
they are toggled?

Not that I'd mind having it in rfkill! But it seems like a special case
to have it there, when you can do so much more with GPIOs.

johannes

