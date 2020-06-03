Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F041EC74A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 04:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgFCC1s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 22:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgFCC1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 22:27:47 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5306EC08C5C0;
        Tue,  2 Jun 2020 19:27:46 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g28so736389qkl.0;
        Tue, 02 Jun 2020 19:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jm8UJEx6rps0P39ugr5HGoTfRN9zX4E7ZLdkUHVQLgg=;
        b=AvCLoq0fD23amYMD2YDdh6eVTxyR70zGd8Uttf/pLBtrgfnWcd7fgzPrB+JgK94Tnu
         njJd0SA9KQKMLbxvnP1qnMX0X48h5pouI1ZdXUsZOZ32U5oencl3GpipsPOLkTpfAur7
         C346PZz+e6EV2AwjbfZQrTUF8elG9/OCezPS2v7ff/+6alPiHQKA/OVeijc3sG0tq383
         U9FlqzbKODxfQBlMQV6phyPsV/Y4SeVmJ2Rqc+6L04LVrTRfU9aO/k1jYDLmR/Z7eOPq
         umbtxVXV+t3mHbcybit2JD5c8mFlrvH5DqcHixk7ORsee9Q4OJqFihLJom8DvI9QfjsV
         TXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jm8UJEx6rps0P39ugr5HGoTfRN9zX4E7ZLdkUHVQLgg=;
        b=QEJFxe0RPYJVAD9hWeVMMKp8O4ROLdDMuXpaC2bJlBB4EFJX1Efecde6M6q9Toljou
         jySliAyXNWB+KJ5WORcTFyzMx5ezk1fSdBVwi4lKfYvXyW7fqjbq6Ye1t9Gyzm3GV2r6
         OXtRyJxdNQ5/D9YYTELc9yKAEBGq1mCUouzxrqvIMrFeBDZ6AKCtRrlwuiRFXt84Zdbe
         CV184E46CGR4oNd2qW+OtPl8M8hOSHXy5R6/m/GvqkY5M6wcYhyNxok0k6f7Kq33+e13
         Qt52rg115VSMta21zXLDE3TAZmhA7kVTHUoJfy/59d8vEFt7zDRsbSMX/4MzSQy4q+oU
         ndCA==
X-Gm-Message-State: AOAM532KYdtbQHuaPBvLy6NFhcADJDTShJA9OswsyocZJwuzuZ/hFuem
        389NlzKdmUfPOTE9ZPI2zxX2QmKImDbNtqGgVqo=
X-Google-Smtp-Source: ABdhPJx1TwiTtEAtaOKlCKGfkPvBqaQhJfmNP6GJz9uLZW3xb5scvN4arrVeNU/AmkBqMf4yVq9NbeU0B22Xu/k14gY=
X-Received: by 2002:a37:7c6:: with SMTP id 189mr3990525qkh.24.1591151265129;
 Tue, 02 Jun 2020 19:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6F3jE-aE+N7hArV3iye+9c-COwbi3qPkRPxfrCnccnqrw@mail.gmail.com>
 <20200601232542.GA473883@bjorn-Precision-5520> <20200602050626.GA2174820@kroah.com>
In-Reply-To: <20200602050626.GA2174820@kroah.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Wed, 3 Jun 2020 02:27:33 +0000
Message-ID: <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
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

On Mon, Jun 1, 2020 at 10:06 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 01, 2020 at 06:25:42PM -0500, Bjorn Helgaas wrote:
> > [+cc Greg, linux-kernel for wider exposure]
>
> Thanks for the cc:, missed this...
>
> >
> > On Tue, May 26, 2020 at 09:30:08AM -0700, Rajat Jain wrote:
> > > On Thu, May 14, 2020 at 7:18 PM Rajat Jain <rajatja@google.com> wrote:
> > > > On Thu, May 14, 2020 at 12:13 PM Raj, Ashok <ashok.raj@intel.com> wrote:
> > > > > On Wed, May 13, 2020 at 02:26:18PM -0700, Rajat Jain wrote:
> > > > > > On Wed, May 13, 2020 at 8:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > On Fri, May 01, 2020 at 04:07:10PM -0700, Rajat Jain wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > Currently, the PCI subsystem marks the PCI devices as "untrusted", if
> > > > > > > > the firmware asks it to:
> > > > > > > >
> > > > > > > > 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> > > > > > > > 9cb30a71acd4 ("PCI: OF: Support "external-facing" property")
> > > > > > > >
> > > > > > > > An "untrusted" device indicates a (likely external facing) device that
> > > > > > > > may be malicious, and can trigger DMA attacks on the system. It may
> > > > > > > > also try to exploit any vulnerabilities exposed by the driver, that
> > > > > > > > may allow it to read/write unintended addresses in the host (e.g. if
> > > > > > > > DMA buffers for the device, share memory pages with other driver data
> > > > > > > > structures or code etc).
> > > > > > > >
> > > > > > > > High Level proposal
> > > > > > > > ===============
> > > > > > > > Currently, the "untrusted" device property is used as a hint to enable
> > > > > > > > IOMMU restrictions (on Intel), disable ATS (on ARM) etc. We'd like to
> > > > > > > > go a step further, and allow the administrator to build a list of
> > > > > > > > whitelisted drivers for these "untrusted" devices. This whitelist of
> > > > > > > > drivers are the ones that he trusts enough to have little or no
> > > > > > > > vulnerabilities. (He may have built this list of whitelisted drivers
> > > > > > > > by a combination of code analysis of drivers, or by extensive testing
> > > > > > > > using PCIe fuzzing etc). We propose that the administrator be allowed
> > > > > > > > to specify this list of whitelisted drivers to the kernel, and the PCI
> > > > > > > > subsystem to impose this behavior:
> > > > > > > >
> > > > > > > > 1) The "untrusted" devices can bind to only "whitelisted drivers".
> > > > > > > > 2) The other devices (i.e. dev->untrusted=0) can bind to any driver.
> > > > > > > >
> > > > > > > > Of course this behavior is to be imposed only if such a whitelist is
> > > > > > > > provided by the administrator.
> > >
> > > I haven't heard much on this proposal after the initial inputs (to
> > > which I responded). Essentially, I agree that IO-MMU and ACS
> > > restrictions need to be put in plcase. But I think we need this
> > > additionally. Does this look acceptable to you? I wanted to start
> > > spinning out the patches, but wanted to see if there are any pending
> > > comments or concerns.
> >
> > I think it makes sense to code this up and see what it would look
> > like.  The bare minimum seems like a driver "bind-to-external-devices"
> > bit that's visible in sysfs plus something in the driver probe path
> > that checks it.  Neither is inherently PCI-specific, but maybe the
> > right place will become obvious when implementing it.


Agree. I'll try to code it up.

My proposal became PCI specific because

* The need for my proposal arrived out of the potentially malicious
*external* devices that can (NOW, with the advent of thunderbolt)
directly DMA into the CPU memory space. PCI (enabled by Thunderbolt 3
and USB4) is the only interface that fits the bill for laptops at
least (There are few more interfaces that allow DMA directly into host
memory such as LPC etc, but they are all internal so far).

* It hinges on the "untrusted" attribute (I see your concerns on this,
and more on this later) which is part of the "struct pci_dev". If we
can move that flag higher up to "struct device", then we can make this
proposal not PCI specific I think.

> >
> > I'm still not 100% sure the device "external/untrusted" bit is the
> > right thing to check.  If you don't trust a driver enough to expose it
> > to an external device, is it reasonable to trust it for internal
> > devices?  It seems like one could attack the driver of even an
> > internal device like a NIC by controlling the data fed to it.
> >
> > The existing use of "external/untrusted" for IOMMU protection is
> > different.  There we're acknowledging that the *device* itself is
> > unknown and we need to protect ourselves from malicious DMA.
> >
> > Here we're concerned about a *driver* that's completely under our
> > control.  If we don't trust the driver, we could (a) fix the problems
> > in the driver, (b) change the driver so it handles external/untrusted
> > devices differently, or (c) not ship the driver at all.

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

> >
> > I'm also not sure about the administrative details of this.  Certain
> > versions of the driver may be trusted while others are untrusted.
> > That would all have to be managed in userspace, so it's not really our
> > problem, but it sounds like a hassle.  Putting the information in the
> > driver itself would reduce that.

I agree to the points you are making. *

- Who do you think should certify the driver? The driver maintainer?
Do we really think driver authors / maintainers will responsibly
update this field? Also, how often?

- Also, this being a policy decision, and thus best left outside the kernel?

- You are correct that version 1 may be trusted and version 2 may not
be. But I think that provides more reason for this to be maintained by
administrators. They (are supposed to) consciously uprev kernels (or
not), or cherry-pick security patches and can decide whether or not to
uprev a driver, or whether to pick a patch for the entire kernel on
their systems. In other words, they have more control over versions of
what they run on their system. OTOH, if this is maintained within the
upstream kernel by a driver maintainer, he may have no control over
other parts of the kernel (that may have an impact on his driver) and
also his driver needs to move on. I feel this has a lot of room for
mistakes.

>
> What about taking what we have today for USB devices/drivers where we
> have different levels of "authorized"?  There's no reason that could not
> just move to the driver core and be available for all devices/drivers as
> that model has proven to work really well over time.
>
> See the "authorized" sysfs file documentation in
> Documentation/ABI/testing/sysfs-bus-usb for some details.  Lots of
> userspace tools have been built on top of that api to control how and
> when specific USB devices are "allowed" to be used by the kernel and
> userspace.

Thanks for the pointer! I'm still looking at the details yet, but a
quick look (usb_dev_authorized()) seems to suggest that this API is
"device based". The multiple levels of "authorized" seem to take shape
from either how it is wired or from userspace choice. Once authorized,
USB device or interface is authorized to be used by *anyone* (can be
attached to any drivers). Do I understand it right that it does not
differentiate between drivers?

Thanks & Best Regards,

Rajat


>
> thanks,
>
> greg k-h
