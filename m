Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683DF465833
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 22:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbhLAVQE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbhLAVQB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 16:16:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE86C061574;
        Wed,  1 Dec 2021 13:12:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25A3EB82137;
        Wed,  1 Dec 2021 21:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864ADC53FAD;
        Wed,  1 Dec 2021 21:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638393157;
        bh=weR7DSWQIKqO4WPQpQqKqGFcuCYo8x3XUhLSP/EHQK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JNdasUmMTcDCPq5S/47tyL2s4HVZG8g7P0WVjWozWqGG0fn7nYUkyFHRB4d3r1PZ2
         XjjQtnCouXXk88j+hby9dNOwwcPBgGoqkqKo3cryAX05sC8NEfmtx9/Nk2SEgLUq/d
         VuIDyFNwqEKM/2FJF2GE0urovVHgp7SKVQ9g6arvtwAY1UCd+jVBWyJ4RjLHM5NsZg
         YphlE7dXnbqd6yC4K+Nb9DfUBRYCe7NefKkoZDrsWMMEhh41+hoPC9qb9S4c79R3n/
         RNbauI5EmDBEEhZphouk0MeXOqrsSMuHwFrWzEmTTq+QsUtfhH6nh3kqQY8Mv4XdtT
         VFh6fNCGhoQqg==
Date:   Wed, 1 Dec 2021 15:12:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/5] PCI: let 'pcibios_root_bridge_prepare()' access to
 'bridge->windows'
Message-ID: <20211201211236.GA2841879@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H-NkL4=hcVfBvT0ZeBOfg8bmPYv1urJ1JVWtcA2tbtfjA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Guenter from other thread:
https://lore.kernel.org/r/20211129015909.GA921717@roeck-us.net]

On Wed, Dec 01, 2021 at 09:56:22PM +0100, Sergio Paracuellos wrote:
> On Wed, Dec 1, 2021 at 9:24 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Nov 19, 2021 at 05:20:17PM -0600, Bjorn Helgaas wrote:
> > > [+cc Thierry]
> > >
> > > In subject,
> > >
> > >   PCI: Let pcibios_root_bridge_prepare() access bridge->windows
> > >
> > > On Mon, Nov 15, 2021 at 08:08:05AM +0100, Sergio Paracuellos wrote:
> > > > When function 'pci_register_host_bridge()' is called, 'bridge->windows' are
> > > > already available. However this windows are being moved temporarily from
> > > > there. To let 'pcibios_root_bridge_prepare()' to have access to this windows
> > > > move this windows movement after call this function. This is interesting for
> > > > MIPS ralink mt7621 platform to be able to properly set I/O coherence units
> > > > with this information and avoid custom MIPs code in generic PCIe controller
> > > > drivers.
> > > >
> > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > ---
> > > >  drivers/pci/probe.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > > index 087d3658f75c..372a70efccc6 100644
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > @@ -898,8 +898,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> > > >
> > > >     bridge->bus = bus;
> > > >
> > > > -   /* Temporarily move resources off the list */
> > > > -   list_splice_init(&bridge->windows, &resources);
> > >
> > > Arnd added this with 37d6a0a6f470 ("PCI: Add
> > > pci_register_host_bridge() interface") [1].
> > >
> > > I can't remember why this was done, but we did go to some trouble to
> > > move things around, so there must have been a good reason.
> > >
> > > Arnd or Thierry, do you remember?
> >
> > Nobody seems to remember, so I think we should go ahead and make this
> > change after the usual due diligence (audit the code between the old
> > site and the new site to look for any uses of bridge->windows).
> 
> It seems any user of the pcibios_root_bridge_prepare() does nothing
> with 'bridge->windows'. But I don't get the point of passing around a
> complete bridge pointer if windows are temporarily removed from there.
> That is an incomplete bridge and after parsing  windows from dts are
> supposed to be there... What do you mean with 'audit the code between
> the old and new site'?

I mean "look at all the code that is run between the old site and the
new site to make sure that none of that code depends on
bridge->windows being temporarily emptied."

> > I think this would be material for v5.17.
> 
> Do you prefer me to parse dts again inside
> pcibios_root_bridge_prepare() for ralink mt7621?. Not real sense since
> 'windows' should be already there, but it would be a way to get this
> patchset added for v5.16. Something like (not tested yet but it should
> work):

This is definitely too big for v5.16, regardless of which way you go.
For v5.16, the only thing that's practical is to avoid building as a
module.  It'd be *nice* if it could be built as a module, but it is
not a requirement.

Bjorn
