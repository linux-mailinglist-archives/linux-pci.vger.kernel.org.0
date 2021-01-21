Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7662FF203
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 18:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbhAUR3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 12:29:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387915AbhAUR3X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 12:29:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AB8D206B5;
        Thu, 21 Jan 2021 17:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611250117;
        bh=94nwsIf4s2vJ0MSn5f5q0pKIoTv5OghevV69Z5I6SjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wNJ0eZ4XfUMBswNmWI7z8Lmeof4yD6KxXaTUwnzehagkdZvjboUB0Cb8/wKrF0Kel
         Kr78u5Jrab/pFFJWVYgvQn/yfgTg46OEdAu2s5yK6iE6Bh/WBwsQoNsskdXwuMskIU
         QDPsdkkSUU0dXJHZK1h0YqvBSqjHPq2PLBRrkmz8=
Date:   Thu, 21 Jan 2021 18:28:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
Message-ID: <YAm5w7Le1lMdiYTa@kroah.com>
References: <20210121155445.GA2657778@bjorn-Precision-5520>
 <ae24ccfb-9fb6-5fad-8495-538fab95066e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae24ccfb-9fb6-5fad-8495-538fab95066e@linux.ibm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 21, 2021 at 06:04:52PM +0100, Niklas Schnelle wrote:
> 
> 
> On 1/21/21 4:54 PM, Bjorn Helgaas wrote:
> > [Greg may be able to help compare/contrast this s390 UID with udev
> > persistent names]
> > 
> > On Thu, Jan 21, 2021 at 04:31:55PM +0100, Niklas Schnelle wrote:
> >> On 1/15/21 4:29 PM, Bjorn Helgaas wrote:
> >>> On Fri, Jan 15, 2021 at 12:20:59PM +0100, Niklas Schnelle wrote:
> >>>> On 1/14/21 5:14 PM, Greg Kroah-Hartman wrote:
> >>>>> On Thu, Jan 14, 2021 at 04:51:17PM +0100, Niklas Schnelle wrote:
> >>>>>> On 1/14/21 4:17 PM, Greg Kroah-Hartman wrote:
> >>>>>>> On Thu, Jan 14, 2021 at 04:06:11PM +0100, Niklas Schnelle wrote:
> >>>>>>>> On 1/14/21 2:58 PM, Greg Kroah-Hartman wrote:
> >>>>>>>>> On Thu, Jan 14, 2021 at 02:44:53PM +0100, Christian Brauner wrote:
> >>>>>>>>>> On Thu, Jan 14, 2021 at 02:20:10PM +0100, Niklas Schnelle wrote:
> >>>>>>>>>>> On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
> >>>>>>>>>>>> On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
> >>>>>>>>>>>>> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
> >>>> ... snip ...
> >>>>
> >>>>>
> >>>>>> 	if (!zpci_global_kset)
> >>>>>> 		return -ENOMEM;
> >>>>>>
> >>>>>> 	return sysfs_create_group(&zpci_global_kset->kobj, &zpci_attr_group_global);
> >>>>>
> >>>>> Huge hint, if in a driver, or bus subsystem, and you call sysfs_*,
> >>>>> that's usually a huge clue that you are doing something wrong.
> >>>>>
> >>>>> Try the above again, with a simple attribute group, and name for it, and
> >>>>> it should "just work".
> >>>>
> >>>> I'm probably missing something but I don't get how this could work
> >>>> in this case. If I'm seeing this right the default attribute group
> >>>> here is pci_bus_type.bus_groups and that is already set in
> >>>> drivers/pci/pci-driver.c so I don't think I should set that.
> >>>>
> >>>> I did however find bus_create_file() which does work when using the
> >>>> path /sys/bus/pci/uid_checking instead. This would work for us if
> >>>> Bjorn is okay with that path and the code is really clean and simple
> >>>> too.
> >>>>
> >>>> That said, I think we could also add something like
> >>>> bus_create_group().  Then we could use that to also clean up
> >>>> drivers/pci/slot.c:pci_slot_init() and get the original path
> >>>> /sys/bus/pci/zpci/uid_checking.
> >>>
> >>> I don't think "uid_checking" is quite the right name.  It says
> >>> something about the *implementation*, but it doesn't convey what that
> >>> *means* to userspace.  IIUC this file tells userspace something about
> >>> whether a given PCI device always has the same PCI domain/bus/dev/fn
> >>> address (or maybe just the same domain?)
> >>>
> >>> It sounds like this feature could be useful beyond just s390, and
> >>> other arches might implement it differently, without the UID concept.
> >>> If so, I'm OK with something at the /sys/bus/pci/xxx level as long as
> >>> the name is not s390-specific (and "uid" sounds s390-specific).
> >>>
> >>> I assume it would also help with the udev/systemd end if you could
> >>> make this less s390 dependent.
> >>
> >> I've thought about this more and even implemented a proof of concept
> >> patch for a global attribute using a pcibios_has_reproducible_addressing()
> >> hook. 
> >>
> >> However after implementing it I think as a more general and
> >> future proof concept it makes more sense to do this as a per device
> >> attribute, maybe as another flag in "stuct pci_dev" named something
> >> like "reliable_address". My reasoning behind this can be best be seen
> >> with a QEMU example. While I expect that QEMU can easily guarantee
> >> that one can always use "0000:01:00.0" for a virtio-pci NIC and
> >> thus enp1s0 interface name, the same might be harder to guarantee
> >> for a SR-IOV VF passed through with vfio-pci in that same VM and
> >> even less so if a thunderbolt controller is passed through and
> >> enumeration may depend on daisy chaining. The QEMU example
> >> also applies to s390 and maybe others will in the future.
> > 
> > I'm a little wary of using the PCI geographical address
> > ("0000:01:00.0") as a stable name.  Even if you can make a way to use
> > that to identify a specific device instance, regardless of how it is
> > plugged in or passed through, it sounds like we could end up with
> > "physical PCI addresses" and "virtual PCI addresses" that look the
> > same and would cause confusion.
> > 
> > This concept sounds similar to the udev concept of a "persistent
> > device name".  What advantages does this s390 UID have over the udev
> > approach?
> > 
> > There are optional PCI device serial numbers that we currently don't
> > really make use of.  Would that be a generic way to help with this?
> > 
> 
> As far as I understand systemd/udev uses the PCI geographical address
> by default ("enP<domain>p<bus>s<hotplug_slot_idx>...") for PCI attached
> network interfaces in many cases and a lot of users have already built
> their firewall/routing rules on these.

Which is fine as "normally" that does not change.  But on some machines,
it is quite volatile so users pick a different naming scheme.

And this is all done in userspace, I really don't understand what you
want to do in the kernel here.  If you want to expose another unique
thing that the hardware knows about, wonderful, userspace can then use
that if it wants to in how it names specific devices.  But don't put
that naming in the kernel, that's not where it belongs.

> Now taking this beyond s390 my idea is that under some circumstances
> just as with UID Uniqueness for us, the platform can tell if a PCI
> geographical address is a reliable identifier thus sytemd/udev
> has more information about the quality of existing naming schemes
> incorporating information from the geographical address.

The platform does not "know" if this is reliable or not, sorry.  That's
not how PCI or UEFI works.

> Looking at my personal KVM guests (Ubuntu, Arch Linux, Ubuntu ARM64)
> as well as my workstation (Arch Linux) all of them use a scheme
> with parts of the geographical address.

Because for the most part, yes, this works.  Until you plug another
device into the system.  Or remove one.  Or plug a hotplug device in and
then cold boot with it plugged in (or removed).  Or, my favorite system,
just decide to renumber the PCI bus every other boot "just because".

None of that variability can be known by the kernel, that's only known by
the user of that system, so again, they can make the best decision as to
how to name their devices.  If you want to use the systemd default,
wonderful, but know that it does not work for everyone, so systemd
allows you to do whatever you want.

> So in essence my idea is all about either choosing the best existing
> default name or making sure we at least know if it may not be reliable.

There is no reliability "score" here, sorry.  Hardware is fun :)

good luck!

greg k-h
