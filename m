Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFC246570B
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 21:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbhLAU2E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 15:28:04 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37312 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbhLAU17 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 15:27:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C85CECE1DED;
        Wed,  1 Dec 2021 20:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19DBC53FAD;
        Wed,  1 Dec 2021 20:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638390275;
        bh=RfUDGA9Opcm0XRf6ZxK7XVniW39BZnCSqaVtSY+yyKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CxHoOAUsAB+JdbpHWTcfrHbOYM5A7fyIgVB03unYvl+lI00GSOnrQ2QSMiKNSLN8L
         XgspUzF4B6F5l/472NOs/AO4pWL8mFHk1chcCzyDyk5zGnd34RwLvQYp2W4f5qZa3H
         JoHSLHM9rUOsdOX6YYhT+5zuBxekthdEJSrFkq3Ih+HSGeAzxT1XZeQ0TQSm0ob5Jn
         PZ0Lv/DJq+FwcxlDSCz7ujKguwSYjXuCm+isLsdlO/K3nrDPZ3ZaF8VmS30qySMfFv
         1fjWoIcunqUd+/UHv4Aez+KpWfmsMgT03gBcKq5bnKJ7O4ZhNvhQ0AiOurrGjgwv/z
         gVvb1SW8Mqofg==
Date:   Wed, 1 Dec 2021 14:24:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/5] PCI: let 'pcibios_root_bridge_prepare()' access to
 'bridge->windows'
Message-ID: <20211201202433.GA2837547@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119232017.GA1981034@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 05:20:17PM -0600, Bjorn Helgaas wrote:
> [+cc Thierry]
> 
> In subject,
> 
>   PCI: Let pcibios_root_bridge_prepare() access bridge->windows
> 
> On Mon, Nov 15, 2021 at 08:08:05AM +0100, Sergio Paracuellos wrote:
> > When function 'pci_register_host_bridge()' is called, 'bridge->windows' are
> > already available. However this windows are being moved temporarily from
> > there. To let 'pcibios_root_bridge_prepare()' to have access to this windows
> > move this windows movement after call this function. This is interesting for
> > MIPS ralink mt7621 platform to be able to properly set I/O coherence units
> > with this information and avoid custom MIPs code in generic PCIe controller
> > drivers.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/pci/probe.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 087d3658f75c..372a70efccc6 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -898,8 +898,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >  
> >  	bridge->bus = bus;
> >  
> > -	/* Temporarily move resources off the list */
> > -	list_splice_init(&bridge->windows, &resources);
> 
> Arnd added this with 37d6a0a6f470 ("PCI: Add
> pci_register_host_bridge() interface") [1].
> 
> I can't remember why this was done, but we did go to some trouble to
> move things around, so there must have been a good reason.
> 
> Arnd or Thierry, do you remember?

Nobody seems to remember, so I think we should go ahead and make this
change after the usual due diligence (audit the code between the old
site and the new site to look for any uses of bridge->windows).

I think this would be material for v5.17.

> >  	bus->sysdata = bridge->sysdata;
> >  	bus->ops = bridge->ops;
> >  	bus->number = bus->busn_res.start = bridge->busnr;
> > @@ -925,6 +923,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >  	if (err)
> >  		goto free;
> >  
> > +	/* Temporarily move resources off the list */
> > +	list_splice_init(&bridge->windows, &resources);
> >  	err = device_add(&bridge->dev);
> >  	if (err) {
> >  		put_device(&bridge->dev);
> > -- 
> > 2.33.0
> > 
> 
> [1] https://git.kernel.org/linus/37d6a0a6f470
