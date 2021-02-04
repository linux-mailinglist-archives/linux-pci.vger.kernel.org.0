Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2449330F403
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 14:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbhBDNju (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 08:39:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236314AbhBDNj3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 08:39:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADD2364F51;
        Thu,  4 Feb 2021 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612445927;
        bh=/vMj2ElIAY5QBQ/A7h2cgJR0XVTGKsD9U/MoAjjyImo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P0CylK1rd+DfXEfCKpU0+E8R3/wdNJYV+yEIQSjyDpkjUf0mVFC8gzTyKP2AYto7G
         IZ83+afkTx5bhGD2ctUqDuIRFZstt2FkAXydGxrEC9nT9HL6sDhDKx1ppPMzIMUap1
         hAJBualufN6psFbdbRAjNwcAT5z6a4M1r0nXJR+Y=
Date:   Thu, 4 Feb 2021 14:38:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [RFC v2 1/1] PCI: Add s390 specific UID uniqueness attribute
Message-ID: <YBv45HFPe109GT9e@kroah.com>
References: <20210204094353.63819-1-schnelle@linux.ibm.com>
 <20210204094353.63819-2-schnelle@linux.ibm.com>
 <YBvPBD+fCtQkCFFD@kroah.com>
 <7b85c218-88a4-b6db-e5de-7004475564ee@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b85c218-88a4-b6db-e5de-7004475564ee@linux.ibm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 04, 2021 at 01:02:51PM +0100, Niklas Schnelle wrote:
> 
> 
> On 2/4/21 11:40 AM, Greg Kroah-Hartman wrote:
> > On Thu, Feb 04, 2021 at 10:43:53AM +0100, Niklas Schnelle wrote:
> >> The global UID uniqueness attribute exposes whether the platform
> >> guarantees that the user-defined per-device UID attribute values
> >> (/sys/bus/pci/device/<dev>/uid) are unique and can thus be used as
> >> a global identifier for the associated PCI device. With this commit
> >> it is exposed at /sys/bus/pci/zpci/unique_uids
> >>
> >> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> >> ---
> >>  Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
> >>  drivers/pci/pci-sysfs.c                 | 21 +++++++++++++++++++++
> >>  2 files changed, 30 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> >> index 25c9c39770c6..812dd9d3f80d 100644
> >> --- a/Documentation/ABI/testing/sysfs-bus-pci
> >> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> >> @@ -375,3 +375,12 @@ Description:
> >>  		The value comes from the PCI kernel device state and can be one
> >>  		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
> >>  		The file is read only.
> >> +What:		/sys/bus/pci/zpci/unique_uids
> > 
> > No blank line before this new line?
> 
> Good catch, thanks!
> 
> > 
> > And why "zpci"?
> 
> There doesn't seem to be a precedent for arch specific attributes under
> /sys/bus/pci so I went with a separate group for the RFC.

Why?  There's nothing arch-specific here, right?  Either the file is
present or not.

> "zpci" since that's what we've been calling the s390 specific PCI.
> I'm not attached to that name or having a separate group, from
> my perspective /sys/bus/pci/unique_uids would actually be ideal
> if Bjorn is okay with that, we don't currently foresee any additional
> global attributes and no one else seems to have them but
> one never knows and a separate group would then of course,
> well group them.

Why not just a simple file, no need for arch-specific names if this
really can show up under other arches?

> >> +Date:		February 2021
> >> +Contact:	Niklas Schnelle <schnelle@linux.ibm.com>
> >> +Description:
> >> +		This attribute exposes the global state of UID Uniqueness on an
> >> +		s390 Linux system. If this file contains '1' the per-device UID
> >> +		attribute is guaranteed to provide a unique user defined
> >> +		identifier for that PCI device. If this file contains '0' UIDs
> >> +		may collide and do not provide a unique identifier.
> > 
> > What are they "colliding" with?  And where does the UID come from, the
> > device itself or somewhere else?
> 
> If this attribute is 0 multiple PCI devices seen by Linux may have the same UID i.e.
> they may collide with each other on the same Linux instance.

So can't userspace figure this out on its own?

> The
> UIDs are exposed under /sys/bus/pci/devices/<dev>/uid. Even if the attribute is 1
> multiple Linux instances will often see the same UID. The main use case
> we currently envision is naming PCI based network interfaces "eno<UID>"
> which of course only works if the UIDs are unique for that Linux.
> On the same mainframe multiple Linux instances may then e.g. use the same
> UID for VFs from the same physical PCI network card or different cards
> but the same physical network all defined by an administrator/management
> system.
> 
> The UIDs come from the platform/firmware/hypervisor and are provided
> for each device by the CLP List PCI Functions "instruction" that is used
> on s390x where an OS can't probe the physical PCI bus but instead
> that is done by firmware. On QEMU/KVM they can be set on the QEMU cli,
> on our machine hypervisor they are defined by the machine administrator/management
> software as part of the definition of VMs/Partitions on that mainframe which includes
> everything from the number of CPUs, memory, I/O devices etc. With the exposed UID uniqueness
> attribute the platform then certifies that it will ensure that a UID is set to
> a unique non-zero value. I can of course add more of this explanation
> in the documentation too.

Please explain it more, but why would userspace care about this?  If
userspace sees a UID "collision" then it just adds something else to the
end of the name to make it unique.

What is it supposed to do differently based on the value/presense of
this file?

> Both the uniqueness guarantee (this attribute) as well as the UIDs themselves
> are part of the Z (s390x) architecture so fall under the mainframe typical
> backwards compatibility considerations.

So what can userspace do with this?  What tool is going to rely on this?

thanks,

greg k-h
