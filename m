Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4421F041B
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jun 2020 03:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgFFBJJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jun 2020 21:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgFFBJI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2020 21:09:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20220C08C5C2
        for <linux-pci@vger.kernel.org>; Fri,  5 Jun 2020 18:09:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 82so6859669lfh.2
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2020 18:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoVEQR6GPscTqlYvtSNOl7DmB4HK4kweQaFuT/04k/0=;
        b=S0hKb3Hscs1j9nZwdqwiRI2pSC3Mcwh4pRKKOJJnvBu3qJ17S8z5Zv8Z+BiPWoqO37
         5PvQCMpBpyTF5RXqoVbivFbe9zc2mr8rtDEG+DGZuKwC6iXhP6t6jtgcwpDZVTGBK3/N
         Cak+3VYL6Y8cMeCSa5Mc3AFgbx0cLoBqcojnoXPbYZb1HPfGhBGnMzKJgbNv9rrbtNHq
         frAmS1wxFNllUoTAiRqOITnG+uaElxWh+Xt1sLcQOCfKaLujJrOBzQ/pR8QbeE27cof2
         TJWhG7lnaHSfj4daoGX503jRnlRiRh99TOemXBm0ESloFJHzLeYtgXR5w+AKUhn9jljW
         kwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoVEQR6GPscTqlYvtSNOl7DmB4HK4kweQaFuT/04k/0=;
        b=FYXsAHcBcCtNN7cDkFGXoVON89jfAr3Hr44rj8qjw67Edk9doABEbPTA+/lCkRKEja
         dRaVoR5kTXgnfhVCvXE6D/yr1IEtEOsmcD78d3c5BY7ztUB6IEk/TnY8rZLbIJHXVVRR
         buWZGnrDIbXkOUSP4aWBTAccs8jT5WS14KLSiLVGD/l/6r5HvJs3OArvTy4QgtfUBK9q
         mz3x9LPuzPy+TJfmsxX6+olwWvqu/iaz2Wtv5LkvDQesGI4qIpNRYJPMSdYtO/ZIinrw
         f556IEfWDUrp7aOXqDpQDauzFGTaxhjlrEiwKnoe4MrBtHpeff54rGe4f/uDQCxl5eNb
         YAYw==
X-Gm-Message-State: AOAM531kV5x5d49tRA/oB0McJwHVms9/pt4sO3a7YYgteG9EX01tepcc
        9EVqjbBV6NbU1+qBAWq984cqaUfQ21iFoXtLP8w5rg==
X-Google-Smtp-Source: ABdhPJy9xjJGJUtZyrUmvXYeaMERXTqZPN9HY0IXQU8im9bJVICItGA9AmOgu8OQyU1BqDWpXDf0F7El+cfkrQm2HlM=
X-Received: by 2002:ac2:5473:: with SMTP id e19mr6638828lfn.21.1591405745700;
 Fri, 05 Jun 2020 18:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6F3jE-aE+N7hArV3iye+9c-COwbi3qPkRPxfrCnccnqrw@mail.gmail.com>
 <20200601232542.GA473883@bjorn-Precision-5520> <20200602050626.GA2174820@kroah.com>
 <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
 <20200603060751.GA465970@kroah.com> <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com> <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
 <20200605080229.GC2209311@kroah.com>
In-Reply-To: <20200605080229.GC2209311@kroah.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 5 Jun 2020 18:08:28 -0700
Message-ID: <CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatxjain@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Greg,

Thank you for continuing to work with me through this.

On Fri, Jun 5, 2020 at 1:02 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 04, 2020 at 12:38:18PM -0700, Rajat Jain wrote:
> > Hello,
> >
> > I spent some more thoughts into this...
> >
> > On Wed, Jun 3, 2020 at 5:16 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jun 03, 2020 at 04:51:18AM -0700, Rajat Jain wrote:
> > > > Hello,
> > > >
> > > > >
> > > > > > Thanks for the pointer! I'm still looking at the details yet, but a
> > > > > > quick look (usb_dev_authorized()) seems to suggest that this API is
> > > > > > "device based". The multiple levels of "authorized" seem to take shape
> > > > > > from either how it is wired or from userspace choice. Once authorized,
> > > > > > USB device or interface is authorized to be used by *anyone* (can be
> > > > > > attached to any drivers). Do I understand it right that it does not
> > > > > > differentiate between drivers?
> > > > >
> > > > > Yes, and that is what you should do, don't fixate on drivers.  Users
> > > > > know how to control and manage devices.  Us kernel developers are
> > > > > responsible for writing solid drivers and getting them merged into the
> > > > > kernel tree and maintaining them over time.  Drivers in the kernel
> > > > > should always be trusted, ...
> > > >
> > > > 1) Yes, I agree that this would be ideal, and this should be our
> > > > mission. I should clarify that I may have used the wrong term
> > > > "Trusted/Certified drivers". I didn't really mean that the drivers may
> > > > be malicious by intent. What I really meant is that a driver may have
> > > > an attack surface, which is a vulnerability that may be exploited.
> > >
> > > Any code has such a thing, proving otherwise is a tough problem :)
> > >
> > > > Realistically speaking, finding vulnerabilities in drivers, creating
> > > > attacks to exploit them, and fixing them is a never ending cat and
> > > > mouse game. At Least "identifying the vulnerabilities" part is better
> > > > performed by security folks rather than driver writers.
> > >
> > > Are you sure about that?  It's hard to prove a negative :)
> > >
> > > > Earlier in the
> > > > thread I had mentioned certain studies/projects that identified and
> > > > exploited such vulnerabilities in the drivers. I should have used the
> > > > term "Vetted Drivers" maybe to convey the intent better - drivers that
> > > > have been vetted by a security focussed team (admin). What I'm
> > > > advocating here is an administrator's right to control the drivers
> > > > that he wants to allow for external ports on his systems.
> > >
> > > That's an odd thing, but sure, if you want to write up such a policy for
> > > your systems, great.  But that policy does not belong in the kernel, it
> > > belongs in userspace.
> > >
> > > > 2) In addition to the problem of driver negligences / vulnerabilities
> > > > to be exploited, we ran into another problem with the "whitelist
> > > > devices only" approach. We did start with the "device based" approach
> > > > only initially - but quickly realized that anything we use to
> > > > whitelist an external device can only be based on the info provided by
> > > > *that device* itself. So until we have devices that exchange
> > > > certificates with kernel [1], it is easy for a malicious device to
> > > > spoof a whitelisted device (by presenting the same VID:DID or any
> > > > other data that is used by us to whitelist it).
> > > >
> > > > [1] https://www.intel.com/content/www/us/en/io/pci-express/pcie-device-security-enhancements-spec.html
> > > >
> > > > I hope that helps somewhat clarify how / why we reached here?
> > >
> > > Kind of, I still think all you need to do is worry about controling the
> > > devices and if a driver should bind to it or not.  Again, much like USB
> > > has been doing for a very long time now.  The idea of "spoofing" ids
> > > also is not new, and has been around for a very long time as well, and
> > > again, the controls that the USB core gives you allows you to make any
> > > type of policy decision you want to, in userspace.
> >
> > Er, *currently* it doesn't allow the userspace to make the particular
> > policy I want to, right? Specifically, today an administrator can not
> > control which USB *drivers* he wants to allow on an *external* USB
> > port.
>
> Not true, you can do that today with the explicit binding/unbinding of
> devices to drivers in userspace.  Been there for many decades :)

Not sure if I understood. Can you please elaborate how that helps
implement the policy I want?

>
> But, think this through, since when do you have _multiple_ drivers that
> have support to control the same type of device?  We almost never allow
> that in the kernel today as that way lies madness (no heiarchy of
> drivers to bind to what devices and so on.)
>
> We always strive to keep a one-to-one mapping of "this device is only
> allowed to be controlled by this one driver" today, why would you want
> to change that basic premise now?

No, I don't want to change that premise. Multiple drivers for a single
device is not the goal at all.

>
> > He can only control which USB devices he wants to authorize, but
> > once authorized, they are free to bind to any of the USB drivers.
>
> Since when do different drivers control the same type of USB device?  :)

Sorry, I should have used better wording:
"..., a malicious device can choose which (authorized/whitelisted)
device to spoof, and *thus* choose a driver to attach to"
Since the only data admin can use to decide to authorize the device,
is provided by device itself, authorization is really just a farce.

From Documentation/usb/authorization.rst:
"Just checking if the class, type and protocol match something is the worse
security verification you can make (or the best, for someone willing
to break it). If you need something secure, use crypto and Certificate
Authentication or stuff like that."

Truth be told, there is nothing else really available today. While
certificate exchanges may be the future, the challenge is to deal with
devices at hand.

> > So if I want to allow the administrator to implement a policy that
> > allows him to control the drivers for external ports, we'll need to
> > enhance the current code (whether we want to do it specific to a bus,
> > or more generically in the driver core). Are we on the same page?
> >
> > To implement the policy that I want to in the driver core, what is
> > missing today in driver core is a distinction between "internal" and
> > "external" devices. Some buses have this knowledge locally today (PCI
> > has "untrusted" flag which can be used, USB uses hcd->wireless and
> > hub->port->connect_type) but it is not shared with the core.
>
> Note the wireless USB code should now be gone from the tree.  If you see
> any remants of it floating around, let me know and I will remove them, I
> think there might be a few bits left that I missed.
>
> > So just to make sure if I'm thinking in the right direction, this is
> > what I'm thinking:
> >
> > 1) The device core needs a notion of internal vs external devices (a
> > flag) - a knowledge that needs to be filled in by the bus as it
> > discovers the device.
>
> Nope, don't go down this path.  We tried to do this for USB where the
> BIOS tells us that a device is "internal" vs. "external" but in reality,
> BIOSes get this wrong and it's not always all that useful.
>
> And why would you somehow "trust" a device that is in your system more
> than one is not?  The same driver binds to it no matter what (as I state
> above), so you should be able to trust it the same.

There are multiple reasons for trust level to be different for
"internal" vs "external" devices. Speaking for the laptop world at
least (and I suspect same is true for most of OEM products):

1) The hardware, firmware, and in some cases even the supply chain is
quite tightly controlled and audited for "internal devices". OTOH, we
don't even know what an "external device" may look like.

2) Most of the internal devices are soldered on board, and can't be
accessed by a malicious person, atleast without the owner knowing.
OTOH, external device attack is very easy (Imagine malicious user
plugging in a USB stick on an unattended laptop / internet cafes /
airports etc) - the owner wouldn't even know.

3) Internal devices do not physically travel to another system. OTOH,
external devices, even if not malicious, may get infected since they
travel between multiple systems.

4) New devices' support (new drivers) keeps on getting added in the
kernel (which is a good thing!). But that means while the "internal
device space" is fixed at product release, the "external device space"
is unbounded and keeps on increasing. It is good from a functionality
point of view, but not from a security point of view.

>
> > 2) The driver core needs to allow an admin to provide a whitelist of
> > drivers for external devices. (Via Command line or a driver flag.
> > Default = everything is whitelisted).
>
> Again, nope, no difference, see above.
>
> > 3) While matching a driver to a device, the driver core needs to
> > impose the whitelist if the device is external, and if the
> > administrator has provided a whitelist.
>
> Ick, no, again, work on a per-device authorized setting.  That way it
> works the same all across the system.  Don't get stuck in a "external
> vs. internal" discussion as this will get messy really quickly (think
> about "internal" devices with "external" links to them like PCI
> "drawers" of devices that we currently support on large systems.  Or
> things like thunderbolt hubs with "internal" devices like I have on my
> desktop right now.

Good point. I'm not good at terminologies - by "external", I meant
anything that is not in the physical boundary of the host system as
shipped. It should be defined by the individual buses who learn it
from the platform (BIOS / Device tree / Discovery process etc).

>
> In summary, if a driver is "trusted enough" to control an internal
> device, it should be "trusted enough" to control an external device.  If
> not, then fix that driver so that you do "trust" it.

That is indeed our goal, and we do intend to inspect and send patch
fixes upstream. However the problem is inspecting drivers for security
and finding and fixing issues is a long drawn process - and has a lot
of dependencies on different maintainers. It is not possible to front
load all the effort and release the product only when *all* drivers
are fixed (We want to begin with a *NULL* whitelist of drivers and
then build it *slowly*). OTOH, it would be unfair to block a product
because not all drivers could be inspected or fixed in time for
security issues.

I feel that I have failed to explain the problems clearly. I'm copying
a blurb earlier from this thread, which explains the context and the
problem we're trying to solve.

================ BEGIN ============================
So here is our dilemma. In the laptop world:

1) Today (Pre-Thunderbolt 3 / Pre-USB4), there is a mix of trusted /
untrusted drivers that we (or any OEMs) are shipping on their laptops.
Yes, there is some (calculated) risk that everyone is taking - because
currently PCI bus does not extend outside the laptop *easily*. Yes I
understand systems may have external PCI slots, but that is rather
rare in the laptop world I think. The risks of the existing drivers
are limited to the devices that were built into the system, and since
the drivers, firmware updates, (and supply chain in some cases) are
controlled by us, such internal devices are conceivably more secure
than something random that the user may plug in. If the user opens the
chassis to replace a piece of hardware with something else, all bets
are off. Yes, we're still susceptible to the NIC driver attacks that
you talk about it along with other potential vulnerabilities, but this
is just convey our current baseline level of risk/security.

2) Now, we want to enable technology of tomorrow :-) (Thunderbolt 3 /
USB4) on laptops, which allows to very *easily* extend the internal
PCI bus to the outside devices. Note it doesn't require to open a
laptop, and anyone can plug a device onto a port. This throws the
system open to a lot of DMA attacks now, which it did not have to deal
with earlier. Essentially with the advent of technology to expand PCIe
outside of system chassis, the attacks have become much more easier,
we can no longer control or monitor device hardware or firmware, and
thus the level of risk has clearly increased. So what we are trying to
find here, is a good path to enable these new technologies, that keeps
keeps our baseline level of risk/security unchanged, and to also not
regress in functionality in supporting devices as much as possible.

3) Now you are certainly right that one path could be a binary
decision to ship or not ship a driver, or fix any issues with the
driver, or change the driver to differentiate between external and
internal ports. However, there are multiple factors that pose
practical problems (why regress internal devices that we tightly
control? Why regress systems that don't have such external ports? Need
to front load all effort in vetting the drivers before hand before the
first release. Work with each and individual driver etc).

4) The other path that this proposal aims to take is that by applying
a whitelist of drivers to external ports only, we're going to be able
to *slowly* build this whitelist. We can start with a NULL whitelist.
Which means that existing internal devices continue to work, and
external devices on PCI don't pose a risk. With ACS and IOMMU
restrictions in place, the security/risk baseline remains unchanged.
The existing devices are not regressed. As we vet and whitelist the
drivers, we start supporting more and more USB4 and Thunderbolt3
devices. Until then, those devices when plugged, can continue to work
in the "USB / legacy mode" (I forgot what it is called).

5) To give an example, assume we don't trust the PCI nvme driver and
don't want to whitelist it for external devices given there are so
many off the shelf devices with questionable firmware. But we
certainly need to enable it for internal NVME devices (that we may
have audited the firmware for, and control our supply chain) in order
to boot. With my proposal, until we whitelist it, the internal devices
continue to work, the external NVMEs switch to "USB storage device"
mode and thus go via a USB bridge so they cannot directly DMA into
host memory directly. Keep in mind that whitelisting a driver may be
handled by a separate security team, and may take long time depending
on the driver. The proposal allows us to release laptops with
Thunderbolt3/USB4 support and add peripheral support as we go.

6) Also small nit: consider the other scenario (I think this may not
be as important but still worth a thought). Assume the security team
finds a new vulnerability in a whitelisted driver, and want to take it
out of whitelist. Now, this really isn't possible if there was no
distinction between internal / external devices, and an internal
device uses that driver to boot.

================ END ============================

I feel I've described a problem, looked around to see what is
available, and tried to explain why it doesn't work for us given the
constraints. When it comes to security, the world is far from ideal.
Though in principle a "driver vulnerability" applies equally to any
device, in reality the threat vector is different for "internal" vs
"external" devices.

I feel a lot of resistance to the proposal, however, I'm not hearing
any realistic solutions that may help us to move forward. We want to
go with a solution that is acceptable upstream as that is our mission,
and also helps the community, however the behemoth task of "inspect
all drivers and fix them" before launching a product is really an
unfair ask I feel :-(. Can you help us by suggesting a proposal that
does not require us to trust a driver equally for internal / external
devices?

Looking for some guidance here.

Thanks & Best Regards,

Rajat

>
> thanks,
>
> greg k-h
