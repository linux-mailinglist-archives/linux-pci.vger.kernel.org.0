Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D29E3AF5D2
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 21:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhFUTJV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 15:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhFUTJV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 15:09:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D54D61245;
        Mon, 21 Jun 2021 19:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624302426;
        bh=5w5FYExhURARib2zDGu8RhTwXUdk9VQQuuKXuSDSgoU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NPtb7NYV6Kr75n1coa71GrHpCCG5O8RZJybyw52a+F432PB2fxhMgHeCPMOsFyi+E
         aRrKGOmDnL9y0ZTZPP/B2O5vtk5TmWnW9gQAjJSFNCiKuTEkAZEnWbXQ60z6xVWij2
         60SSUgJfgiLNNnNIWqDkLUYvIFLTRpVnUPzsWHyLSmZUwBuUOEC+raNGrQ6UDs8/7l
         lVgj7b52xA9Wd7HvQan7z4um5/BJUBvLeiBqneJ5xz/oGV6UkRmP9t8xoEKN7HCbQY
         F7Pm8sz0Y6IZ1Omj4o5ekpsWe45Gv0OFN8XBmzU1u804GhG5l8TxILr7hD4Dlk8lu2
         iCGmzsrQehY4Q==
Date:   Mon, 21 Jun 2021 14:07:05 -0500
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
Message-ID: <20210621190705.GA3292470@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621172854.3ycsprg2wwx45xgm@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 21, 2021 at 10:58:54PM +0530, Amey Narkhede wrote:
> On 21/06/21 08:01AM, Bjorn Helgaas wrote:
> > On Sat, Jun 19, 2021 at 07:29:20PM +0530, Amey Narkhede wrote:
> > > On 21/06/18 03:00PM, Bjorn Helgaas wrote:
> > > > On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> > > > > Add reset_method sysfs attribute to enable user to
> > > > > query and set user preferred device reset methods and
> > > > > their ordering.
> >
> > > > > +	if (sysfs_streq(options, "default")) {
> > > > > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
> > > > > +			reset_methods[i] = reset_methods[i] ? prio-- : 0;
> > > > > +		goto set_reset_methods;
> > > > > +	}
> > > >
> > > > If you use pci_init_reset_methods() here, you can also get this case
> > > > out of the way early.
> > > >
> > > The problem with alternate encoding is we won't be able to know if
> > > one of the reset methods was disabled previously. For example,
> > >
> > > # cat reset_methods
> > > flr,bus 			# dev->reset_methods = [3, 5, 0, ...]
> > > # echo bus > reset_methods 	# dev->reset_methods = [5, 0, 0, ...]
> > > # cat reset_methods
> > > bus
> > >
> > > Now if an user wants to enable flr
> > >
> > > # echo flr > reset_methods 	# dev->reset_methods = [3, 0, 0, ...]
> > > OR
> > > # echo bus,flr > reset_methods 	# dev->reset_methods = [5, 3, 0, ...]
> > >
> > > either they need to write "default" first then flr or we will need to
> > > reprobe reset methods each time when user writes to reset_method attribute.
> >
> > Not sure I completely understand the problem here.  I think relying on
> > previous state that is invisible to the user is a little problematic
> > because it's hard for the user to predict what will happen.
> >
> > If the user enables a method that was previously "disabled" because
> > the probe failed, won't the reset method itself just fail with
> > -ENOTTY?  Is that a problem?
> >
> I think I didn't explain this correctly. With current implementation
> its not necessary to explicitly set *order of availabe* reset methods.
> User can directly write a single supported reset method only and then perform
> the reset. Side effect of that is other methods are disabled if user
> writes single or less than available number of supported reset method.
> Current implementation is able to handle this case but with new encoding
> we'll need to reprobe reset methods everytime because we have no way
> of distingushing supported and currently enabled reset method.

I'm confused.  I thought the point of the nested loops to find the
highest priority enabled reset method was to allow the user to control
the order.  The sysfs doc says writing "reset_method" sets the "reset
methods and their ordering."

It seems complicated to track "supported" and "enabled" separately,
and I don't know what the benefit is.  If we write "reset_method" to
enable reset X, can we just probe reset X to see if it's supported?

Bjorn
