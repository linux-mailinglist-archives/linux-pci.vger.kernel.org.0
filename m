Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3D73B3438
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbhFXQ6X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 12:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhFXQ6W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 12:58:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B495613DA;
        Thu, 24 Jun 2021 16:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624553763;
        bh=sPdX9JSZ1QoBwl0KfaUR+wv694Ee5eRmqS36z7b9xLE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Y8VKK6YfBzQJ5MhCmGisCYNGxAEJbmeCGqp6JDtqL1rHm6xMTH2ly+SR12Xg95ZRs
         L9LysdnV3xJDkEPmtFRvwPtSI5MKmyHfjcPuAwNpZ44IBM6fJTKC+HwRd3urc16v+m
         t20LiXv916JkNUd7ukxN9jFpOwCfvY1/RP9cIErSfEzpyqsIMK6coBcP7TjNVo16kn
         BIvtog8pJD1Uu33hPLOGEL1BlWo3dRljri26DLGj2RWrxjKrMqTDZXrpjoNVcccKEz
         71lZvicUQz0oyAQFU9oRaw3xLvr8xOnx/9Cm10gFGVwEU4beK6A6SnoqYWA+yoj07t
         +++fGisxNK/NQ==
Date:   Thu, 24 Jun 2021 11:56:01 -0500
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
Message-ID: <20210624165601.GA3535644@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624151242.ybew2z5rseuusj7v@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 24, 2021 at 08:42:42PM +0530, Amey Narkhede wrote:
> On 21/06/24 07:15AM, Bjorn Helgaas wrote:
> > On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> > > Add reset_method sysfs attribute to enable user to
> > > query and set user preferred device reset methods and
> > > their ordering.
> >
> > > +		Writing the name or comma separated list of names of any of
> > > +		the device supported reset methods to this file will set the
> > > +		reset methods and their ordering to be used when resetting
> > > +		the device.
> >
> > > +	while ((name = strsep(&options, ",")) != NULL) {
> > > +		if (sysfs_streq(name, ""))
> > > +			continue;
> > > +
> > > +		name = strim(name);
> > > +
> > > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> > > +			if (reset_methods[i] &&
> > > +			    sysfs_streq(name, pci_reset_fn_methods[i].name)) {
> > > +				reset_methods[i] = prio--;
> > > +				break;
> > > +			}
> > > +		}
> > > +
> > > +		if (i == PCI_RESET_METHODS_NUM) {
> > > +			kfree(options);
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> >
> > Asking again since we didn't get this clarified before.  The above
> > tells me that "reset_methods" allows the user to control the
> > *order* in which we try reset methods.
> >
> > Consider the following two uses:
> >
> >   (1) # echo bus,flr > reset_methods
> >
> >   (2) # echo flr,bus > reset_methods
> >
> > Do these have the same effect or not?
> >
> They have different effect.

I asked about this because Shanker's idea [1] of using two bitmaps
only keeps track of which resets are *enabled*.  It does not keep
track of the *ordering*.  Since you want to control the ordering, I
think we need more state than just the supported/enabled bitmaps.

> > If "reset_methods" allows control over the order, I expect them to
> > be different: (1) would try a bus reset and, if the bus reset
> > failed, an FLR, while (2) would try an FLR and, if the FLR failed,
> > a bus reset.
>
> Exactly you are right.
> 
> Now the point I was presenting was with new encoding we have to
> write list of *all of the supported reset methods* in order for
> example, in above example flr,bus or bus,flr. We can't just write
> 'flr' or 'bus' then switch back to writing flr,bus/bus,flr (these
> have different effect as mentioned earlier).

It sounds like you're saying this sequence can't work:

  # echo flr > reset_methods
  # echo bus,flr > reset_methods

But I'm afraid you'll have to walk me through the reasons why this
can't be made to work.

> Basically with new encoding an user can't write subset of reset
> methods they have to write list of *all* supported methods
> everytime.

Why does the user have to write all supported methods?  Is that to
preserve the fact that "cat reset_methods" always shows all the
supported methods so the user knows what's available?

I'm wondering why we can't do something like this (pidgin code):

  if (option == "default") {
    pci_init_reset_methods(dev);
    return;
  }

  n = 0;
  foreach method in option {
    i = lookup_reset_method(method);
    if (pci_reset_methods[i].reset_fn(dev, PROBE) == 0)
      dev->reset_methods[n++] = i;           # method i supported
  }
  dev->reset_methods[n++] = 0;               # end of supported methods

If we did something like the above, the user could always find the
list of all methods supported by a device by doing this:

  # echo default > reset_methods
  # cat reset_methods

Yes, this does call the "probe" methods several times.  I don't think
that's necessarily a problem.

Bjorn

[1] https://lore.kernel.org/r/1fb0a184-908c-5f98-ef6d-74edc602c2e0@nvidia.com
