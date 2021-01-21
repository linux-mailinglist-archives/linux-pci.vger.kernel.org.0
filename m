Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86A22FF117
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 17:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbhAUQxi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 11:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729842AbhAUPzk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 10:55:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D06BA23A1D;
        Thu, 21 Jan 2021 15:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611244487;
        bh=hhZx/Ee+Xm9H79fb1J5cDRefS6ThbB9mATSkmjREweo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bXnfeDo0omSMD3KJcPgmF+Vo69xhpAs9l+5o/Mwk2G1Jx0DbNZ846sA7HqfoZgNaD
         Swan94fkPGc49EqGESxX0Nt/zUWTLHgppmDaJ2wRKTPYBizX9CB1tcGPSX6Is2dlE9
         V5Q5F8QkFtHi77fmW5p/ms7iZqMrXHEtXgcIKbiZtcnZL0Oc3myUi8t/dK5r84pBnB
         8xHU7Sen+5VhCX+xeAu7o5OMWGQ75gam6m5AuOfnfsC88oPWtYQjd+Lk+zIlwqRc1b
         9OspZsssgr1C7gi3n3GNuTdtPj1ZC0bakGJDkk2D4vmMw7eD3ipoUCjG5VBbzZXOWI
         hCgOHN1Uz/kjA==
Date:   Thu, 21 Jan 2021 09:54:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
Message-ID: <20210121155445.GA2657778@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cf42837-bf98-944f-697c-8407a0ebd623@linux.ibm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Greg may be able to help compare/contrast this s390 UID with udev
persistent names]

On Thu, Jan 21, 2021 at 04:31:55PM +0100, Niklas Schnelle wrote:
> On 1/15/21 4:29 PM, Bjorn Helgaas wrote:
> > On Fri, Jan 15, 2021 at 12:20:59PM +0100, Niklas Schnelle wrote:
> >> On 1/14/21 5:14 PM, Greg Kroah-Hartman wrote:
> >>> On Thu, Jan 14, 2021 at 04:51:17PM +0100, Niklas Schnelle wrote:
> >>>> On 1/14/21 4:17 PM, Greg Kroah-Hartman wrote:
> >>>>> On Thu, Jan 14, 2021 at 04:06:11PM +0100, Niklas Schnelle wrote:
> >>>>>> On 1/14/21 2:58 PM, Greg Kroah-Hartman wrote:
> >>>>>>> On Thu, Jan 14, 2021 at 02:44:53PM +0100, Christian Brauner wrote:
> >>>>>>>> On Thu, Jan 14, 2021 at 02:20:10PM +0100, Niklas Schnelle wrote:
> >>>>>>>>> On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
> >>>>>>>>>> On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
> >>>>>>>>>>> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
> >> ... snip ...
> >>
> >>>
> >>>> 	if (!zpci_global_kset)
> >>>> 		return -ENOMEM;
> >>>>
> >>>> 	return sysfs_create_group(&zpci_global_kset->kobj, &zpci_attr_group_global);
> >>>
> >>> Huge hint, if in a driver, or bus subsystem, and you call sysfs_*,
> >>> that's usually a huge clue that you are doing something wrong.
> >>>
> >>> Try the above again, with a simple attribute group, and name for it, and
> >>> it should "just work".
> >>
> >> I'm probably missing something but I don't get how this could work
> >> in this case. If I'm seeing this right the default attribute group
> >> here is pci_bus_type.bus_groups and that is already set in
> >> drivers/pci/pci-driver.c so I don't think I should set that.
> >>
> >> I did however find bus_create_file() which does work when using the
> >> path /sys/bus/pci/uid_checking instead. This would work for us if
> >> Bjorn is okay with that path and the code is really clean and simple
> >> too.
> >>
> >> That said, I think we could also add something like
> >> bus_create_group().  Then we could use that to also clean up
> >> drivers/pci/slot.c:pci_slot_init() and get the original path
> >> /sys/bus/pci/zpci/uid_checking.
> > 
> > I don't think "uid_checking" is quite the right name.  It says
> > something about the *implementation*, but it doesn't convey what that
> > *means* to userspace.  IIUC this file tells userspace something about
> > whether a given PCI device always has the same PCI domain/bus/dev/fn
> > address (or maybe just the same domain?)
> > 
> > It sounds like this feature could be useful beyond just s390, and
> > other arches might implement it differently, without the UID concept.
> > If so, I'm OK with something at the /sys/bus/pci/xxx level as long as
> > the name is not s390-specific (and "uid" sounds s390-specific).
> > 
> > I assume it would also help with the udev/systemd end if you could
> > make this less s390 dependent.
> 
> I've thought about this more and even implemented a proof of concept
> patch for a global attribute using a pcibios_has_reproducible_addressing()
> hook. 
> 
> However after implementing it I think as a more general and
> future proof concept it makes more sense to do this as a per device
> attribute, maybe as another flag in "stuct pci_dev" named something
> like "reliable_address". My reasoning behind this can be best be seen
> with a QEMU example. While I expect that QEMU can easily guarantee
> that one can always use "0000:01:00.0" for a virtio-pci NIC and
> thus enp1s0 interface name, the same might be harder to guarantee
> for a SR-IOV VF passed through with vfio-pci in that same VM and
> even less so if a thunderbolt controller is passed through and
> enumeration may depend on daisy chaining. The QEMU example
> also applies to s390 and maybe others will in the future.

I'm a little wary of using the PCI geographical address
("0000:01:00.0") as a stable name.  Even if you can make a way to use
that to identify a specific device instance, regardless of how it is
plugged in or passed through, it sounds like we could end up with
"physical PCI addresses" and "virtual PCI addresses" that look the
same and would cause confusion.

This concept sounds similar to the udev concept of a "persistent
device name".  What advantages does this s390 UID have over the udev
approach?

There are optional PCI device serial numbers that we currently don't
really make use of.  Would that be a generic way to help with this?
