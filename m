Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68EC3B3519
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 19:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhFXSBf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 14:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhFXSBf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 14:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB35A613C5;
        Thu, 24 Jun 2021 17:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624557556;
        bh=xpXE1TP1jsJRvYTsfkb6duwlS1QeIAIixaUeKvmTCvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QrK51EWNK8noEsl5rgWQ/xOdpgMGyZ2cd8nlM5hRwz6wqQ8/ZG+9a1ceATTlV00i5
         15MYIG3wcCqnFhFIYT+CQ2x7A/pbuf9vL89UYZevYB31wckieoyHxVOWpksYWoBShO
         9132EieRo29zX9Zl9wMs4DzmUv8T+a2shj/uQ8hzo8gahSXvC8ZFK3oZ8qjAUmSR29
         xAkqINNwMRiO3w7+Xjx9wH81ncjt6JoEnGXM0YFYeivQDyBlrepb4Oo53emcEVsTve
         rfUaQzdtAReXiI36ZG8efJTzSqmM3vlC+VDwYo2JShC8PnhXJooo91o3KZjA+EoCCt
         aRfH1p8URpCtA==
Date:   Thu, 24 Jun 2021 12:59:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210624175909.GA3542781@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624172806.ay6dak2wdtv3nruj@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 24, 2021 at 10:58:06PM +0530, Amey Narkhede wrote:
> On 21/06/24 11:56AM, Bjorn Helgaas wrote:
> > On Thu, Jun 24, 2021 at 08:42:42PM +0530, Amey Narkhede wrote:
> > > On 21/06/24 07:15AM, Bjorn Helgaas wrote:
> > > > On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> > > > > Add reset_method sysfs attribute to enable user to
> > > > > query and set user preferred device reset methods and
> > > > > their ordering.
> > > >
> > > > > +		Writing the name or comma separated list of names of any of
> > > > > +		the device supported reset methods to this file will set the
> > > > > +		reset methods and their ordering to be used when resetting
> > > > > +		the device.
> > > >
> > > > > +	while ((name = strsep(&options, ",")) != NULL) {
> > > > > +		if (sysfs_streq(name, ""))
> > > > > +			continue;
> > > > > +
> > > > > +		name = strim(name);
> > > > > +
> > > > > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> > > > > +			if (reset_methods[i] &&
> > > > > +			    sysfs_streq(name, pci_reset_fn_methods[i].name)) {
> > > > > +				reset_methods[i] = prio--;
> > > > > +				break;
> > > > > +			}
> > > > > +		}
> > > > > +
> > > > > +		if (i == PCI_RESET_METHODS_NUM) {
> > > > > +			kfree(options);
> > > > > +			return -EINVAL;
> > > > > +		}
> > > > > +	}
> > > >
> > > > Asking again since we didn't get this clarified before.  The above
> > > > tells me that "reset_methods" allows the user to control the
> > > > *order* in which we try reset methods.
> > > >
> > > > Consider the following two uses:
> > > >
> > > >   (1) # echo bus,flr > reset_methods
> > > >
> > > >   (2) # echo flr,bus > reset_methods
> > > >
> > > > Do these have the same effect or not?
> > > >
> > > They have different effect.
> >
> > I asked about this because Shanker's idea [1] of using two bitmaps
> > only keeps track of which resets are *enabled*.  It does not keep
> > track of the *ordering*.  Since you want to control the ordering, I
> > think we need more state than just the supported/enabled bitmaps.
> >
> > > > If "reset_methods" allows control over the order, I expect them to
> > > > be different: (1) would try a bus reset and, if the bus reset
> > > > failed, an FLR, while (2) would try an FLR and, if the FLR failed,
> > > > a bus reset.
> > >
> > > Exactly you are right.
> > >
> > > Now the point I was presenting was with new encoding we have to
> > > write list of *all of the supported reset methods* in order for
> > > example, in above example flr,bus or bus,flr. We can't just write
> > > 'flr' or 'bus' then switch back to writing flr,bus/bus,flr (these
> > > have different effect as mentioned earlier).
> >
> > It sounds like you're saying this sequence can't work:
> >
> >   # echo flr > reset_methods
>
> # dev->reset_methods = [3, 0, 0, ..]
>
> >   # echo bus,flr > reset_methods
>
> # to get dev->reset_methods = [6, 3, 0, ...]
> we'll need to probe reset methods here.
>
> > But I'm afraid you'll have to walk me through the reasons why this
> > can't be made to work.
>
> I wrote incomplete description. It can work but we'll need to probe
> everytime which involves reading different capabilities(PCI_CAP_ID_AF,
> PCI_PM_CTRL etc) from device. With current encoding we just have to
> probe at the begining.
>
> > > Basically with new encoding an user can't write subset of reset
> > > methods they have to write list of *all* supported methods
> > > everytime.
> >
> > Why does the user have to write all supported methods?  Is that to
> > preserve the fact that "cat reset_methods" always shows all the
> > supported methods so the user knows what's available?
> >
> > I'm wondering why we can't do something like this (pidgin code):
> >
> >   if (option == "default") {
> >     pci_init_reset_methods(dev);
> >     return;
> >   }
> >
> >   n = 0;
> >   foreach method in option {
> >     i = lookup_reset_method(method);
> >     if (pci_reset_methods[i].reset_fn(dev, PROBE) == 0)
>
> Repeatedly calling probe might have some impact as it involves reading
> device registers as explained earlier.
>
> >       dev->reset_methods[n++] = i;           # method i supported
> >   }
> >   dev->reset_methods[n++] = 0;               # end of supported methods
> >
> > If we did something like the above, the user could always find the
> > list of all methods supported by a device by doing this:
> >
> >   # echo default > reset_methods
> >   # cat reset_methods
>
> This is one solution for current problem with new encoding.
>
> > Yes, this does call the "probe" methods several times.  I don't think
> > that's necessarily a problem.
>
> I thought this would be a problem because of your earlier suggestion
> of caching flr capability to avoid probing multiple times. In this case
> we'll need to read different device registers multiple times. With
> current encoding we don't have to do that multiple times.

I don't think it's a problem to run "probe" methods when we're setting
the enabled reset methods (either at enumeration-time or when we write
to "reset_methods").  These are low-frequency events and I don't think
there's any performance issue.

I don't think we should have to run "probe" methods every time we call
pci_reset_function().

I suggested a dev->has_flr bit for two reasons:

  1) It avoids reading PCI_EXP_DEVCAP every time a driver calls
     pcie_reset_flr(), and

  2) It gives a nice opportunity for quirks to disable FLR for devices
     where it's broken.

> > [1] https://lore.kernel.org/r/1fb0a184-908c-5f98-ef6d-74edc602c2e0@nvidia.com
