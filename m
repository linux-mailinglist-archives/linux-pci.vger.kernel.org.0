Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D743D967D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 22:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhG1USe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 16:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231268AbhG1USe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 16:18:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F313861038;
        Wed, 28 Jul 2021 20:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627503512;
        bh=1ED6y3YxJU324Y8RqrYP/nxRNq8UxmVvZM4iuBgaSLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bPREx7m+u/T4ac4EuoTvz1nb41tmh306+KQdf3t+gZoHlv1w/mCy7D4hrcYrZt8d2
         4glsA6/h4hdpiMZqVAiGGsCGvkK3QC4dWhOJ9xChnX0kASfV8qMnmdla8YXqabe7I/
         Ayw85LCahi1p3ZKQOqXO0AtA+VEJRXbM1ZvHSUv6kkLftLgaKqDP5OuZ6tkPiY4LmY
         Gz0lrufbMBb+0TShlvThxKoWm/XTr5p6vzL3Rit6mOz8JiU49EZ86LySe7B5dOx+sj
         hzzUpA2nv1EBEHrJ9hr1ZGfvyxCRL++RbagfKOZ3HYHz1MKluv5Ib/Alp1ZTR+5U6R
         rqoRsJYPC8vsQ==
Date:   Wed, 28 Jul 2021 15:18:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210728201830.GA845737@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728185831.isdqa5t5oxxjfhnv@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 12:28:31AM +0530, Amey Narkhede wrote:
> On 21/07/28 01:13PM, Bjorn Helgaas wrote:
> > On Wed, Jul 28, 2021 at 11:29:50PM +0530, Amey Narkhede wrote:
> > > On 21/07/27 06:28PM, Bjorn Helgaas wrote:
> > > > On Fri, Jul 09, 2021 at 06:08:09PM +0530, Amey Narkhede wrote:
> > > > > Add reset_method sysfs attribute to enable user to query and set user
> > > > > preferred device reset methods and their ordering.
> > > > >
> > > > > Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > > > ---
> > > > >  Documentation/ABI/testing/sysfs-bus-pci |  19 +++++
> > > > >  drivers/pci/pci-sysfs.c                 | 103 ++++++++++++++++++++++++
> > > > >  2 files changed, 122 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > > > > index ef00fada2..43f4e33c7 100644
> > > > > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > > > > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > > > > @@ -121,6 +121,25 @@ Description:
> > > > >  		child buses, and re-discover devices removed earlier
> > > > >  		from this part of the device tree.
> > > > >
> > > > > +What:		/sys/bus/pci/devices/.../reset_method
> > > > > +Date:		March 2021
> > > > > +Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
> > > > > +Description:
> > > > > +		Some devices allow an individual function to be reset
> > > > > +		without affecting other functions in the same slot.
> > > > > +
> > > > > +		For devices that have this support, a file named
> > > > > +		reset_method will be present in sysfs. Initially reading
> > > > > +		this file will give names of the device supported reset
> > > > > +		methods and their ordering. After write, this file will
> > > > > +		give names and ordering of currently enabled reset methods.
> > > > > +		Writing the name or comma separated list of names of any of
> > > > > +		the device supported reset methods to this file will set
> > > > > +		the reset methods and their ordering to be used when
> > > > > +		resetting the device. Writing empty string to this file
> > > > > +		will disable ability to reset the device and writing
> > > > > +		"default" will return to the original value.
> > > > > +
> > > > >  What:		/sys/bus/pci/devices/.../reset
> > > > >  Date:		July 2009
> > > > >  Contact:	Michael S. Tsirkin <mst@redhat.com>
> > > >
> > > [...]
> > >
> > > > > +		int i;
> > > > > +
> > > > > +		if (sysfs_streq(name, ""))
> > > > > +			continue;
> > > > > +
> > > > > +		name = strim(name);
> > > > > +
> > > > > +		for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
> > > > > +			if (sysfs_streq(name, pci_reset_fn_methods[i].name) &&
> > > > > +			    !pci_reset_fn_methods[i].reset_fn(pdev, 1)) {
> > > > > +				reset_methods[n++] = i;
> > > >
> > > > Can we build this directly in pdev->reset_methods[] so we don't need
> > > > the memcpy() below?
> > > >
> > > This is to avoid writing partial values directly to dev->reset_methods.
> > > So for example if user writes flr,unsupported_value then
> > > dev->reset_methods should not be modified even though flr is valid reset
> > > method in this example to avoid partial writes. Either operation(in this
> > > case writing supported reset methods to reset_method attr) succeeds
> > > completely or it fails othewise.
> >
> > I guess the question is, if somebody writes
> >
> >   flr junk bus
> >
> > and we set the supported methods to "flr bus", is that OK?  It seems
> > OK to me; obviously we have to protect ourselves from attack, but
> > over-zealous checking can make things unnecessarily complicated.
>
> The problem is once we encounter "junk" we return -EINVAL so in your
> example we only set flr.

We're still talking about whether we need the memcpy().  We can decide
whether it's the right thing to return -EINVAL if we encounter "junk".

Maybe it's OK if we set it to "flr" and ignore everything after
"junk"?  Or maybe it's OK to ignore unsupported values and set it to
"flr bus"?
