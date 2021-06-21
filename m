Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771223AE991
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFUNDz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 09:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhFUNDy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 09:03:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8344A600D4;
        Mon, 21 Jun 2021 13:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624280500;
        bh=W8gtyl5OdibdzPJ1NCZxh+AcF0YQC6Y2zW4xUTjbnVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rkaSMW08nmJNa2IGQeZFlp3m9VTMGuYz+tJwHa7njfwLre9V+uAbo1asBtfcAdUDO
         mUnYSg/Zh8ebP4tXcnZ8twrUU33g11JLyU1djKCRkre10DiSRfCtg2QpaUrtmdo7mn
         MrgHS++4Xod2kAo2vc9OW8QLvpLqu7zmFjDl9nwg1CDQhLQiidtz+FAlK3Q6CMKYGs
         ACIPGTlGXdQ5PO+Mkzn50OyoCrt0ZiKT0S5w7lAZysJDuyII8gK1HFjpi55AKQ3x9D
         W9dJj9cnR5ZjBIXJ7Ff3XebP4fJpWvROdygVh2SxXUgp5xbduBoKbn8XziopUuA2eS
         ERH5If9N7WB4A==
Date:   Mon, 21 Jun 2021 08:01:35 -0500
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
Message-ID: <20210621130135.GA3288360@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210619135920.h42gp5ie5c2eutfq@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 19, 2021 at 07:29:20PM +0530, Amey Narkhede wrote:
> On 21/06/18 03:00PM, Bjorn Helgaas wrote:
> > On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> > > Add reset_method sysfs attribute to enable user to
> > > query and set user preferred device reset methods and
> > > their ordering.

> > > +	if (sysfs_streq(options, "default")) {
> > > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
> > > +			reset_methods[i] = reset_methods[i] ? prio-- : 0;
> > > +		goto set_reset_methods;
> > > +	}
> >
> > If you use pci_init_reset_methods() here, you can also get this case
> > out of the way early.
> >
> The problem with alternate encoding is we won't be able to know if
> one of the reset methods was disabled previously. For example,
> 
> # cat reset_methods
> flr,bus 			# dev->reset_methods = [3, 5, 0, ...]
> # echo bus > reset_methods 	# dev->reset_methods = [5, 0, 0, ...]
> # cat reset_methods
> bus
> 
> Now if an user wants to enable flr
> 
> # echo flr > reset_methods 	# dev->reset_methods = [3, 0, 0, ...]
> OR
> # echo bus,flr > reset_methods 	# dev->reset_methods = [5, 3, 0, ...]
> 
> either they need to write "default" first then flr or we will need to
> reprobe reset methods each time when user writes to reset_method attribute.

Not sure I completely understand the problem here.  I think relying on
previous state that is invisible to the user is a little problematic
because it's hard for the user to predict what will happen.

If the user enables a method that was previously "disabled" because
the probe failed, won't the reset method itself just fail with
-ENOTTY?  Is that a problem?

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
> > > +
> > > +	if (reset_methods[0] &&
> > > +	    reset_methods[0] != PCI_RESET_METHODS_NUM)
> > > +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
> >
> > Is there a specific reason for this warning?  Is it just telling the
> > user that he might have shot himself in the foot?  Not sure that's
> > necessary.
> >
> I think generally presence of device specific reset method means other
> methods are potentially broken. Is it okay to skip this?

We might want a warning at reset-time if all the methods failed,
because that means we may leak state between users.  Maybe we also
want one here, if *all* reset methods are disabled.  I don't really
like special treatment of device-specific methods here because it
depends on the assumption that "device-specific means all other resets
are broken."  That's hard to maintain.

Bjorn
