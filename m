Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09F437FF79
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 22:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhEMUwr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 16:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233005AbhEMUwr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 May 2021 16:52:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 059D661358;
        Thu, 13 May 2021 20:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620939097;
        bh=yjTfN3kihchh/45GfrBY13d752eyb1X/H7dX/dFp3FM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UNHFrJBGfm65WY+TcmMBA59ZXKRQbtB1y6pf7N3inYTU4NUQIRqAm1ehP96ueLWd9
         JwMLzgu5/It0UGKsHwDJxEubF11HOVQ+ZPkE2cNGXXn9lNVg8oUx+HdhwYXK+nv+y5
         5DGUgv10SM61Us+CsOBdIBdR4S7+0rxsxuw4ZMtyQ9uz3VRbpw8NumuTHoB167Yx3Y
         hU0VHMLG15IfAqugLFk6acaTewjMHSfDaCPxyR3/wcekop3J23leVe8Mpl064VAcHI
         yDJsmpydRssC0y/nDmseTuC1h0aVPjXpKuQFoHVWdYG4sOIqJ7oyeC0nNzyP+EQAfC
         ObzrUogeYYMtQ==
Date:   Thu, 13 May 2021 15:51:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Subject: Re: [PATCH v3 2/2] PCI: Add sysfs "removable" attribute
Message-ID: <20210513205135.GA2611013@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6HENcAR-rKnQUVWU4jmqYqzsg95kbYRv3o5Gk7C+eXa-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 01:34:23PM -0700, Rajat Jain wrote:
> On Thu, May 13, 2021 at 1:05 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Thu, May 13, 2021 at 11:02:10AM -0700, Rajat Jain wrote:
> > > On Wed, May 12, 2021 at 2:35 PM Rajat Jain <rajatja@google.com> wrote:
> > > >
> > > > A PCI device is "external_facing" if it's a Root Port with the ACPI
> > > > "ExternalFacingPort" property or if it has the DT "external-facing"
> > > > property.  We consider everything downstream from such a device to
> > > > be removable by user.
> > > >
> > > > We're mainly concerned with consumer platforms with user accessible
> > > > thunderbolt ports that are vulnerable to DMA attacks, and we expect those
> > > > ports to be identified as "ExternalFacingPort". Devices in traditional
> > > > hotplug slots can technically be removed, but the expectation is that
> > > > unless the port is marked with "ExternalFacingPort", such devices are less
> > > > accessible to user / may not be removed by end user, and thus not exposed
> > > > as "removable" to userspace.
> >
> > s/thunderbolt/Thunderbolt/ since I think it's a trademark
> > s/identified as/identified by firmware as/
> 
> Ack, will do.
> 
> >
> > > > Set pci_dev_type.supports_removable so the device core exposes the
> > > > "removable" file in sysfs, and tell the device core about removable
> > > > devices.
> > > >
> > > > This can be used by userspace to implment any policies it wants to,
> > > > tailored specifically for user removable devices. Eg usage:
> > > > https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2591812
> > > > https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2795038
> > > > (code uses such an attribute to remove external PCI devicces or disable
> > > > features on them as needed by the policy desired)
> >
> > s/implment/implement/
> > s/devicces/devices/
> >
> > Or maybe something like:
> >
> >   This can be used to implement userspace policies tailored for
> >   user-removable devices.
> 
> Ack, will do.
> 
> >
> > Not sure exactly what "remove external PCI devices" means.  You're
> > talking about the *code* doing something, so I don't think it means
> > physically unplugging the device from the system.  Maybe preventing a
> > driver from binding to it or something similar?
> 
> echo 1 > /sys/bus/pci/devices/<device>/remove
> 
> >
> > I hesitate slightly to rely on URLs like googlesource.com in commit
> > logs because we don't know how long they will remain valid.  But I
> > guess there's no real alternative here, since this code probably
> > hasn't been posted to any public mailing lists like the ones archived
> > at https://lore.kernel.org/lists.html, right?
> 
> Yes, chromium reviews (userspace code that shall use the new
> attribute) happen over gerrit, and so the publicly available links
> would be googlesource.com.
> 
> >
> > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> >
> > > > +static void pci_set_removable(struct pci_dev *dev)
> > > > +{
> > > > +       struct pci_dev *parent = pci_upstream_bridge(dev);
> > > > +       if (parent &&
> > > > +           (parent->external_facing || dev_is_removable(&parent->dev)))
> > > > +               dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> > > > +       else
> > > > +               dev_set_removable(&dev->dev, DEVICE_FIXED);
> > > > +}
> > >
> > > Copying comments from Krzysztof from another thread:
> > >
> > > [Krzysztof] We were also wondering if we should only set DEVICE_REMOVABLE for
> > > devices known to be behind an external-facing port, and let everything
> > > else be set to "unknown" (or whatever the default would be).
> > >
> > > [Rajat]: I think I'm fine with this proposal if Bjorn & PCI community
> > > also sees this as a better idea. Essentially the question here is,
> > > would it be better for the non-removable PCI devices to be shown as
> > > "fixed" or "unknown"?
> >
> > I think I would rather see this as:
> >
> >   struct pci_dev *parent = pci_upstream_bridge(dev);
> >
> >   if (parent &&
> >       (parent->external_facing || dev_is_removable(&parent->dev)))
> >           dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> >
> > In other words, assume only that everything below an "external-facing"
> > device is removable.
> >
> > In the absence of an "external-facing" property, we don't know
> > anything about the connection, and I'd rather use the default
> > (probably "unknown") instead of assuming "fixed."
> 
> Ack, will do.
> 
> One question: Under Greg's latest suggestion, the decision to show
> this attribute does not have to be bus wide / device_type wide i.e.
> subsystem can choose for this attribute to show up only under certain
> devices. So if it is more preferable, I can have this attribute show
> under ONLY PCI devices that attach below "external-facing" PCI devices
> (and any other PCI devices will not have this attribute show up at
> all). I guess this sounds better than having "unknown" show up on the
> rest of the devices that are not removable?

If you can make the file appear only for removable devices, that
sounds even better.

> > I don't think we have anything that depends on "fixed," so I don't
> > think there's value in setting it.
> >
> > (Note the blank line between local variables and the "if"; maybe
> > that's what Greg hinted at?)
> 
> Ack, will remove the blank line (didn't know that blank lines between
> variables and code is not preferred).

The blank line *is* preferred, but your patch didn't include one.

Bjorn
