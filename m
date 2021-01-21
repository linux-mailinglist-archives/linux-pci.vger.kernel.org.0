Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC5C2FEFE2
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 17:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbhAUQMu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 11:12:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731699AbhAUQMf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 11:12:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 850CB23A23;
        Thu, 21 Jan 2021 16:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611245514;
        bh=OVEIUtuoedkG3hYog+0eKNwTMSkV3Iyaz4tQF4gL37s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDmjjmYc2BPSpXyZFdoZg8JVTFco3/YGBUCAyn/QQrkgOOBQcjmTjcb/h7iGHeggz
         K2bxCcc/CaRmmDGbJwKsrKuX8rK2S51/fvbDu7P6OiH9Dy/F10V3Of2BBIx0PLGi4R
         yH2TC9RpAVoMjTV9gfoL4JB8xGs2WyjkssWPUKdk=
Date:   Thu, 21 Jan 2021 17:11:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
Message-ID: <YAmnx2AkVc0rbibQ@kroah.com>
References: <1cf42837-bf98-944f-697c-8407a0ebd623@linux.ibm.com>
 <20210121155445.GA2657778@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121155445.GA2657778@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 21, 2021 at 09:54:45AM -0600, Bjorn Helgaas wrote:
> [Greg may be able to help compare/contrast this s390 UID with udev
> persistent names]
> 
> On Thu, Jan 21, 2021 at 04:31:55PM +0100, Niklas Schnelle wrote:
> > On 1/15/21 4:29 PM, Bjorn Helgaas wrote:
> > > On Fri, Jan 15, 2021 at 12:20:59PM +0100, Niklas Schnelle wrote:
> > >> On 1/14/21 5:14 PM, Greg Kroah-Hartman wrote:
> > >>> On Thu, Jan 14, 2021 at 04:51:17PM +0100, Niklas Schnelle wrote:
> > >>>> On 1/14/21 4:17 PM, Greg Kroah-Hartman wrote:
> > >>>>> On Thu, Jan 14, 2021 at 04:06:11PM +0100, Niklas Schnelle wrote:
> > >>>>>> On 1/14/21 2:58 PM, Greg Kroah-Hartman wrote:
> > >>>>>>> On Thu, Jan 14, 2021 at 02:44:53PM +0100, Christian Brauner wrote:
> > >>>>>>>> On Thu, Jan 14, 2021 at 02:20:10PM +0100, Niklas Schnelle wrote:
> > >>>>>>>>> On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
> > >>>>>>>>>> On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
> > >>>>>>>>>>> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
> > >> ... snip ...
> > >>
> > >>>
> > >>>> 	if (!zpci_global_kset)
> > >>>> 		return -ENOMEM;
> > >>>>
> > >>>> 	return sysfs_create_group(&zpci_global_kset->kobj, &zpci_attr_group_global);
> > >>>
> > >>> Huge hint, if in a driver, or bus subsystem, and you call sysfs_*,
> > >>> that's usually a huge clue that you are doing something wrong.
> > >>>
> > >>> Try the above again, with a simple attribute group, and name for it, and
> > >>> it should "just work".
> > >>
> > >> I'm probably missing something but I don't get how this could work
> > >> in this case. If I'm seeing this right the default attribute group
> > >> here is pci_bus_type.bus_groups and that is already set in
> > >> drivers/pci/pci-driver.c so I don't think I should set that.
> > >>
> > >> I did however find bus_create_file() which does work when using the
> > >> path /sys/bus/pci/uid_checking instead. This would work for us if
> > >> Bjorn is okay with that path and the code is really clean and simple
> > >> too.
> > >>
> > >> That said, I think we could also add something like
> > >> bus_create_group().  Then we could use that to also clean up
> > >> drivers/pci/slot.c:pci_slot_init() and get the original path
> > >> /sys/bus/pci/zpci/uid_checking.
> > > 
> > > I don't think "uid_checking" is quite the right name.  It says
> > > something about the *implementation*, but it doesn't convey what that
> > > *means* to userspace.  IIUC this file tells userspace something about
> > > whether a given PCI device always has the same PCI domain/bus/dev/fn
> > > address (or maybe just the same domain?)
> > > 
> > > It sounds like this feature could be useful beyond just s390, and
> > > other arches might implement it differently, without the UID concept.
> > > If so, I'm OK with something at the /sys/bus/pci/xxx level as long as
> > > the name is not s390-specific (and "uid" sounds s390-specific).
> > > 
> > > I assume it would also help with the udev/systemd end if you could
> > > make this less s390 dependent.
> > 
> > I've thought about this more and even implemented a proof of concept
> > patch for a global attribute using a pcibios_has_reproducible_addressing()
> > hook. 
> > 
> > However after implementing it I think as a more general and
> > future proof concept it makes more sense to do this as a per device
> > attribute, maybe as another flag in "stuct pci_dev" named something
> > like "reliable_address". My reasoning behind this can be best be seen
> > with a QEMU example. While I expect that QEMU can easily guarantee
> > that one can always use "0000:01:00.0" for a virtio-pci NIC and
> > thus enp1s0 interface name, the same might be harder to guarantee
> > for a SR-IOV VF passed through with vfio-pci in that same VM and
> > even less so if a thunderbolt controller is passed through and
> > enumeration may depend on daisy chaining. The QEMU example
> > also applies to s390 and maybe others will in the future.
> 
> I'm a little wary of using the PCI geographical address
> ("0000:01:00.0") as a stable name.  Even if you can make a way to use
> that to identify a specific device instance, regardless of how it is
> plugged in or passed through, it sounds like we could end up with
> "physical PCI addresses" and "virtual PCI addresses" that look the
> same and would cause confusion.

Agreed, as we all know, PCI addresses are never a stable name and can
change every boot on some systems.  Never rely on them, but you can use
them as a "hint" for something that you have to determine is different
from something else that is the same type of device.

> This concept sounds similar to the udev concept of a "persistent
> device name".  What advantages does this s390 UID have over the udev
> approach?
> 
> There are optional PCI device serial numbers that we currently don't
> really make use of.  Would that be a generic way to help with this?

Only if you can require that they be unique.  Is there such a
requirement and who enforces it?

For USB, it was only "required" to have unique serial numbers for one
class of devices (printers), and even then, it really wasn't enforced
that much so you can't rely on it being unique at all, which makes it
pretty useless :(

thanks,

greg k-h
