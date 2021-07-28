Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529213D94C3
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 19:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhG1R7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 13:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhG1R7P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 13:59:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D22B560E09;
        Wed, 28 Jul 2021 17:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627495153;
        bh=KmSuc9Pd93lOTIGMQxTWSAYFqcwC3Y4fLLqNgjxx34g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F/q9vUaVHZThHQrQL+D8P6qefjBuVmrFR2sHv2QsbkeubJWgta10TAjdUKbnoBCKA
         GH0XrsJ7eSAfgchWQXudLYNHROjBLP2wh5VyKY7HfOT03xYYRwikI14M/KKadNmtDM
         1TAOzoXxYIQpFSujyrdR4EC+jpZFOUEEzNzwum0/hNKQZR1hLaJ6tAefyqTuYzvhhl
         MLmg0WiRzwOtWFciEJ9uSdeyNbwaR/INIs/jAapoDEWb1f4TMMFhXczBrGr6VP2Uh+
         eP+YnvTUE3Jg7dDWq6MSlA3VF71McuWo2cWkua5Gac98vH0e50TPI6MbmsGmkfl17E
         SVZqJwSYj/n7g==
Date:   Wed, 28 Jul 2021 12:59:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
Message-ID: <20210728175911.GA835695@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728174519.has5xvy6rksbukup@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 28, 2021 at 11:15:19PM +0530, Amey Narkhede wrote:
> On 21/07/27 05:59PM, Bjorn Helgaas wrote:
> > On Fri, Jul 09, 2021 at 06:08:07PM +0530, Amey Narkhede wrote:
> > > Introduce a new array reset_methods in struct pci_dev to keep track of
> > > reset mechanisms supported by the device and their ordering.
> > >
> > > Also refactor probing and reset functions to take advantage of calling
> > > convention of reset functions.
> > >
> > > Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > ---
> > >  drivers/pci/pci.c   | 92 ++++++++++++++++++++++++++-------------------
> > >  drivers/pci/pci.h   |  9 ++++-
> > >  drivers/pci/probe.c |  5 +--
> > >  include/linux/pci.h |  7 ++++
> > >  4 files changed, 70 insertions(+), 43 deletions(-)
> > >
> >
> [...]
> > > +	BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_NUM_RESET_METHODS);
> > >
> > >  	might_sleep();
> > >
> > > -	rc = pci_dev_specific_reset(dev, 1);
> > > -	if (rc != -ENOTTY)
> > > -		return rc;
> > > -	rc = pcie_reset_flr(dev, 1);
> > > -	if (rc != -ENOTTY)
> > > -		return rc;
> > > -	rc = pci_af_flr(dev, 1);
> > > -	if (rc != -ENOTTY)
> > > -		return rc;
> > > -	rc = pci_pm_reset(dev, 1);
> > > -	if (rc != -ENOTTY)
> > > -		return rc;
> > > +	for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
> > > +		rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
> > > +		if (!rc)
> > > +			reset_methods[n++] = i;
> >
> > Why do we need this local reset_methods[] array?  Can we just fill
> > in dev->reset_methods[] directly and skip the memcpy() below?
> >
> This is for avoiding caching of previously supported reset methods.
> Is it okay if I use memset(dev->reset_methods, 0,
> sizeof(dev->reset_methods)) instead to clear the values in
> dev->reset_methods?

I don't think there's ever a case where you look at a
dev->reset_methods[] element past a zero value, so we shouldn't care
about any previously-supported methods left in the array.

If we *do* look at something past a zero value, why do we do that?  It
sounds like it would be a bug.

> > > +		else if (rc != -ENOTTY)
> > > +			break;
> > > +	}
> > >
> > > -	return pci_reset_bus_function(dev, 1);
> > > +	memcpy(dev->reset_methods, reset_methods, sizeof(reset_methods));
> > >  }
> > >
> > >  /**
> [...]
