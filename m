Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6054D3B1990
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 14:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhFWMIn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 08:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhFWMIm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 08:08:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DE7F6102A;
        Wed, 23 Jun 2021 12:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624449985;
        bh=pRjRyRfLrESTWmV+JAD0jFiz2kLDegDFhdIBtqzV2a8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lDS22IWujCGbBwr2H+FZidYVi2ctHxtn0bg2GUVranYGqe2eU1rgevF8BVIdbq1vm
         PI7PRruiW+g42S+f+unuo5+ui34MXUbQLowbXFTHHLQBeXdVcv1DtFJvpRPGk6uF7S
         vWLhY2gyaX5jXQVvgbA7bTYtTwe9Q+TLqimYZhGaTWyfN9wmLgL3kQj/vkZuBGDXyF
         AUf7GnRC0SWsjXQrLB1+1uu4j8QPuKN+nrh7OfoMVTf4Jl45HUErFbF3w1fQlihZGD
         1FyBE3O3Cf1qSrhIuyPi9MJj4k0PRQc8Ru2fzfTQc3q2Tmf0jcf5285xcS+q3p6BML
         i639rYdjo/gyw==
Date:   Wed, 23 Jun 2021 07:06:23 -0500
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
Message-ID: <20210623120623.GA3295394@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621193307.gt7iwwg6gqqojhfc@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 22, 2021 at 01:03:07AM +0530, Amey Narkhede wrote:
> On 21/06/21 02:07PM, Bjorn Helgaas wrote:
> > On Mon, Jun 21, 2021 at 10:58:54PM +0530, Amey Narkhede wrote:
> > > On 21/06/21 08:01AM, Bjorn Helgaas wrote:
> > > > On Sat, Jun 19, 2021 at 07:29:20PM +0530, Amey Narkhede wrote:
> > > > > On 21/06/18 03:00PM, Bjorn Helgaas wrote:
> > > > > > On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> > > > > > > Add reset_method sysfs attribute to enable user to
> > > > > > > query and set user preferred device reset methods and
> > > > > > > their ordering.
> > > >
> > > > > > > +	if (sysfs_streq(options, "default")) {
> > > > > > > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
> > > > > > > +			reset_methods[i] = reset_methods[i] ? prio-- : 0;
> > > > > > > +		goto set_reset_methods;
> > > > > > > +	}
> > > > > >
> > > > > > If you use pci_init_reset_methods() here, you can also get this case
> > > > > > out of the way early.
> > > > > >
> > > > > The problem with alternate encoding is we won't be able to know if
> > > > > one of the reset methods was disabled previously. For example,
> > > > >
> > > > > # cat reset_methods
> > > > > flr,bus 			# dev->reset_methods = [3, 5, 0, ...]
> > > > > # echo bus > reset_methods 	# dev->reset_methods = [5, 0, 0, ...]
> > > > > # cat reset_methods
> > > > > bus
> > > > >
> > > > > Now if an user wants to enable flr
> > > > >
> > > > > # echo flr > reset_methods 	# dev->reset_methods = [3, 0, 0, ...]
> > > > > OR
> > > > > # echo bus,flr > reset_methods 	# dev->reset_methods = [5, 3, 0, ...]
> > > > >
> > > > > either they need to write "default" first then flr or we will need to
> > > > > reprobe reset methods each time when user writes to reset_method attribute.
> > > >
> > > > Not sure I completely understand the problem here.  I think relying on
> > > > previous state that is invisible to the user is a little problematic
> > > > because it's hard for the user to predict what will happen.
> > > >
> > > > If the user enables a method that was previously "disabled" because
> > > > the probe failed, won't the reset method itself just fail with
> > > > -ENOTTY?  Is that a problem?
> > > >
> > > I think I didn't explain this correctly. With current implementation
> > > its not necessary to explicitly set *order of availabe* reset methods.
> > > User can directly write a single supported reset method only and then perform
> > > the reset. Side effect of that is other methods are disabled if user
> > > writes single or less than available number of supported reset method.
> > > Current implementation is able to handle this case but with new encoding
> > > we'll need to reprobe reset methods everytime because we have no way
> > > of distingushing supported and currently enabled reset method.
> >
> > I'm confused.  I thought the point of the nested loops to find the
> > highest priority enabled reset method was to allow the user to control
> > the order.  The sysfs doc says writing "reset_method" sets the "reset
> > methods and their ordering."
> >
> > It seems complicated to track "supported" and "enabled" separately,
> > and I don't know what the benefit is.  If we write "reset_method" to
> > enable reset X, can we just probe reset X to see if it's supported?
>
> Although final result is same whether user writes a supported reset method or
> their ordering that is,
> # echo bus > reset_methods
> and
> # echo bus,flr > reset_methods
> 
> are the same but in the first version, users don't have to explicitly
> set the ordering if they just want to perform bus reset.
> Current implementation allows the flexibility for switching between
> first and second option.

Sorry, I can't quite make sense of the above.

Your doc implies the following are different:

  # echo bus,flr > reset_methods
  # echo flr,bus > reset_methods

Are they?  If you don't need to provide control over the order of
trying resets, this can all be simplified quite a bit.

Bjorn
