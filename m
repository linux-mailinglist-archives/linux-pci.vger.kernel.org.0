Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9052F7F8D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jan 2021 16:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbhAOP3q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jan 2021 10:29:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbhAOP3q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Jan 2021 10:29:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 850942388B;
        Fri, 15 Jan 2021 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610724544;
        bh=4Ze9w1yOFMD6KQ1DewNu9ryv221NesFpnk2fZBb7Dbo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PAMHD1N3ijp89tbcU0XDP6LMNwvBg4azeMc5UpuX57/PbcCdGAzlBphbg/Mvd/PIc
         BFSUo23PxJALBtoRjJ1Gu/xMlO4raj3W1Sn9CA0v2VtVWkeXOcPhwcdh4rqQp3YIez
         IIdNbiz4kW2mIqREPBXNoKrPlAro9oMen0xAcb5wOxeye7QNIWMvCss8GhxKtfFphP
         Q0EYKuLQ0XIF3c14qECzjRTP7KO2Zj4o3TtWqm7g/3INnzfEI+CVfECO6iw4SYLX47
         5SRjESC0SN9dAsMuL38Y8d9aTwPb1cT92z7OQ037mrhBNTiI9p1lIti4i+mCVU+QGb
         YetmPj27UsUjQ==
Date:   Fri, 15 Jan 2021 09:29:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
Message-ID: <20210115152903.GA2086339@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeae8e23-0263-dfe7-d068-ec925432a4a2@linux.ibm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 15, 2021 at 12:20:59PM +0100, Niklas Schnelle wrote:
> On 1/14/21 5:14 PM, Greg Kroah-Hartman wrote:
> > On Thu, Jan 14, 2021 at 04:51:17PM +0100, Niklas Schnelle wrote:
> >> On 1/14/21 4:17 PM, Greg Kroah-Hartman wrote:
> >>> On Thu, Jan 14, 2021 at 04:06:11PM +0100, Niklas Schnelle wrote:
> >>>> On 1/14/21 2:58 PM, Greg Kroah-Hartman wrote:
> >>>>> On Thu, Jan 14, 2021 at 02:44:53PM +0100, Christian Brauner wrote:
> >>>>>> On Thu, Jan 14, 2021 at 02:20:10PM +0100, Niklas Schnelle wrote:
> >>>>>>> On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
> >>>>>>>> On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
> >>>>>>>>> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
> ... snip ...
> >>>>>>
> >>>>>> Hey Niklas et al. :)
> >>>>>>
> >>>>>> I think this will need input from Greg. He should be best versed in
> >>>>>> sysfs attributes. The problem with KERNEL_ATTR_* to me seems that it's
> >>>>>> supposed to be kernel internal. Now, that might just be a matter of
> >>>>>> renaming the macro but let's see whether Greg has any better idea or
> >>>>>> more questions. :)
> >>>>>
> >>>>> The big question is, why are you needing this?
> >>>>>
> >>>>> No driver or driver subsystem should EVER be messing with a "raw"
> >>>>> kobject like this.  Just use the existing DEVICE_* macros instead
> >>>>> please.
> >>>>>
> >>>>> If you are using a raw kobject, please ask me how to do this properly,
> >>>>> as that is something that should NEVER show up in the /sys/devices/*
> >>>>> tree.  Otherwise userspace tools will break.
> >>>>>
> >>>>> thanks,
> >>>>>
> >>>>> greg k-h
> >>>>
> >>>> Hi Greg,
> >>>>
> >>>> this is for an architecture specific but global i.e. not device bound PCI
> >>>> attribute. That's why DEVICE_ATTR_* does not work. BUS_ATTR_* would work
> >>>> but only if we place the attribute directly under /sys/bus/pci/new_attr.
> >>>
> >>> Then you are doing something wrong :)
> >>
> >> That is very possible.
> >>
> >>>
> >>> Where _exactly_ are you wanting to put this attribute?
> >>
> >> I'm trying for /sys/bus/pci/zpci/uid_checking, I'm using
> >> the below code and the attribute even shows up but reading
> >> it gives me two 0 bytes only.
> >> The relevant code is only a slight alteration of the original patch
> >> as follows:
> >>
> >> static ssize_t uid_checking_show(struct bus_type *bus, char *buf)
> >> {
> >> 	return sprintf(buf, "%i\n", zpci_unique_uid);
> >> }
> >> static BUS_ATTR_RO(uid_checking);
> >>
> >> static struct kset *zpci_global_kset;
> >>
> >> static struct attribute *zpci_attrs_global[] = {
> >> 	&bus_attr_uid_checking.attr,
> >> 	NULL,
> >> };
> >>
> >> static struct attribute_group zpci_attr_group_global = {
> >> 	.attrs = zpci_attrs_global,
> >> };
> > 
> > Name your attribute group, and then you do not have to mess with a
> > "raw" kobject like you are below:
> 
> Thanks for this tip and sorry for bothering you again.
> 
> > 
> >>
> >> int __init zpci_sysfs_init(void)
> >> {
> >> 	struct kset *pci_bus_kset;
> >>
> >> 	pci_bus_kset = bus_get_kset(&pci_bus_type);
> >>
> >> 	zpci_global_kset = kset_create_and_add("zpci", NULL, &pci_bus_kset->kobj);
> > 
> > No, do not mess with at kset, just set the default attribute group for
> > the bus to the above, and you should be fine.
> 
> Oh ok, I got this idea from the code adding /sys/bus/pci/slots/ in
> drivers/pci/slot.c:pci_slot_init(). See below maybe we can clean that up too.
> 
> > 
> >> 	if (!zpci_global_kset)
> >> 		return -ENOMEM;
> >>
> >> 	return sysfs_create_group(&zpci_global_kset->kobj, &zpci_attr_group_global);
> > 
> > Huge hint, if in a driver, or bus subsystem, and you call sysfs_*,
> > that's usually a huge clue that you are doing something wrong.
> > 
> > Try the above again, with a simple attribute group, and name for it, and
> > it should "just work".
> 
> I'm probably missing something but I don't get how this could work
> in this case. If I'm seeing this right the default attribute group
> here is pci_bus_type.bus_groups and that is already set in
> drivers/pci/pci-driver.c so I don't think I should set that.
> 
> I did however find bus_create_file() which does work when using the
> path /sys/bus/pci/uid_checking instead. This would work for us if
> Bjorn is okay with that path and the code is really clean and simple
> too.
> 
> That said, I think we could also add something like
> bus_create_group().  Then we could use that to also clean up
> drivers/pci/slot.c:pci_slot_init() and get the original path
> /sys/bus/pci/zpci/uid_checking.

I don't think "uid_checking" is quite the right name.  It says
something about the *implementation*, but it doesn't convey what that
*means* to userspace.  IIUC this file tells userspace something about
whether a given PCI device always has the same PCI domain/bus/dev/fn
address (or maybe just the same domain?)

It sounds like this feature could be useful beyond just s390, and
other arches might implement it differently, without the UID concept.
If so, I'm OK with something at the /sys/bus/pci/xxx level as long as
the name is not s390-specific (and "uid" sounds s390-specific).

I assume it would also help with the udev/systemd end if you could
make this less s390 dependent.

Bjorn
