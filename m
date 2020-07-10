Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F79521C0C6
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 01:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgGJXcb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 19:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgGJXcb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 19:32:31 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BC232077D;
        Fri, 10 Jul 2020 23:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594423950;
        bh=qZFv1CX9d18PwooaFPG3Jn4rphAd/kDDIDOqrn0KUvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0gruNDRG210kwjnDK21/f2TTB84PP+1SoJzPn2oHQjCi5tKSmk9riPN1Myy0i3I5S
         YWdS/bxoFGEx24/CerkDpFJtz6mgMM5kk328PHgXMiZWCtcCUR3yjvCF34MA8YJhpj
         C8GLha9a3p03gOkAEoDi5hHNz3yANGR8dPMazz7Q=
Date:   Fri, 10 Jul 2020 18:32:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for
 untrusted/external-facing devices
Message-ID: <20200710233229.GA92058@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACK8Z6F-8OZNJU8wqWuZq=moCaOi+3W=CzBeppfO31VZnkqBrg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 10, 2020 at 03:53:59PM -0700, Rajat Jain wrote:
> On Fri, Jul 10, 2020 at 2:29 PM Raj, Ashok <ashok.raj@intel.com> wrote:
> > On Fri, Jul 10, 2020 at 03:29:22PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Jul 07, 2020 at 03:46:04PM -0700, Rajat Jain wrote:
> > > > When enabling ACS, enable translation blocking for external facing ports
> > > > and untrusted devices.
> > > >
> > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > ---
> > > > v4: Add braces to avoid warning from kernel robot
> > > >     print warning for only external-facing devices.
> > > > v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
> > > >     Minor code comments fixes.
> > > > v2: Commit log change
> > > >
> > > >  drivers/pci/pci.c    |  8 ++++++++
> > > >  drivers/pci/quirks.c | 15 +++++++++++++++
> > > >  2 files changed, 23 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 73a8627822140..a5a6bea7af7ce 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -876,6 +876,14 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> > > >     /* Upstream Forwarding */
> > > >     ctrl |= (cap & PCI_ACS_UF);
> > > >
> > > > +   /* Enable Translation Blocking for external devices */
> > > > +   if (dev->external_facing || dev->untrusted) {
> > > > +           if (cap & PCI_ACS_TB)
> > > > +                   ctrl |= PCI_ACS_TB;
> > > > +           else if (dev->external_facing)
> > > > +                   pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
> > > > +   }
> > >
> > > IIUC, this means that external devices can *never* use ATS
> > and can
> > > never cache translations.
> 
> Yes, but it already exists today (and this patch doesn't change that):
> 521376741b2c2 "PCI/ATS: Only enable ATS for trusted devices"

If you get in the habit of using the commit reference style from
Documentation/process/submitting-patches.rst it saves me the trouble
of fixing them.  I use this:

  gsr is aliased to `git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'

> IMHO any external device trying to send ATS traffic despite having
> ATS disabled should count as a bad intent. And this patch is trying
> to plug that loophole, by blocking the AT traffic from devices that
> we do not expect to see AT from anyway.

That's exactly the sort of assertion I was looking for.  If we can get
something like this explanation into the commit log, and if Ashok and
Alex are OK with this, we'll be much closer.

It sounds like this is just enforcing a restriction we already have,
i.e., enabling PCI_ACS_TB blocks translated requests from devices that
aren't supposed to be generating them.

> Do you see any case where this is not true?
> 
> >  And (I guess, I'm not an expert) it can
> > > also never use the Page Request Services?
> >
> > Yep, sounds like it.
> 
> Yes, from spec "Address Translation Services" Rev 1.1:
> "...a device that supports ATS need not support PRI, but PRI is
> dependent on ATS’s capabilities."
> (So no ATS = No PRI).
> 
> > > Is this what we want?  Do we have any idea how many external
> > > devices this will affect or how much of a performance impact
> > > they will see?
> > >
> > > Do we need some kind of override or mechanism to authenticate
> > > certain devices so they can use ATS and PRI?
> >
> > Sounds like we would need some form of an allow-list to start with
> > so we can have something in the interim.
> 
> I assume what is being referred to, is an escape hatch to enable ATS
> on certain given "external-facing" ports (and devices downstream on
> that port). Do we really think a *per-port* control for ATS may be
> needed? I can add if there is consensus about this.
> 
> > I suppose a future platform might have a facilty to ensure ATS is
> > secure and authenticated we could enable for all of devices in the
> > system, in addition to PCI CMA/IDE.
> >
> > I think having a global override to enable all devices so platform
> > can switch to current behavior, or maybe via a cmdline switch.. as
> > much as we have a billion of those, it still gives an option in
> > case someone needs it.
> 
> Currently:
> 
> pci.noats => No ATS on all PCI devices.
> (Absense of pci.noats): ATS on all PCI devices, EXCEPT external devices.

You mean the "pci=noats" kernel command line parameter, right?

> I can look to add another parameter that is synonymous to
> "trust-external-pci-devices" that can keep ATS enabled on external
> ports as well. I think this is better than an allow-list of only
> certain ports, because most likely an admin will trust all its
> external ports, or not. Also, we can add this global override and
> may be add a more granular control later, if and when really needed.

I think this would be new functionality that we don't have today, and
we don't have anything that actually *needs* it AFAIK, so I wouldn't
bother.

Bjorn
