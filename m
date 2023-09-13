Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B340979DE1A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 04:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjIMCNN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Sep 2023 22:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjIMCNN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 22:13:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC2E170A;
        Tue, 12 Sep 2023 19:13:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50A0C433C7;
        Wed, 13 Sep 2023 02:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694571189;
        bh=MSBBTkWjMvMbAwqOAt1bZnTxu6yL+zT3uFGtSny2Xu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pTmKTs7FGvuDD08VyDflLg/UAEVIn/Doje7GGvRC00hBBdL0W+jrWiXtFfPe38cQa
         WCmon7YDSux+P1cgNSiy6MT3ld7Jbo2l3ZbvV3N7ROCV8fDGJvZ6eUbM6NpdAxFoNc
         JkbTYHULjmlBXWF4WKsAJl4Z19dHSqr7xzngSLwbz55zoXgSnZjWunINU8Y5VvgR5a
         Izt4d/bneUJP+nOBVYGY95wkHyr35ZVlJGEt5jCn4yHRKhuwdzW1bk4HNQILQfqnn1
         /FdLERQ6eoT1W+EQAhIzf0peJJP/W9GGp+hObBZKHhqLq4fIimvLSDq7dMJpJ/r7BG
         cyKCaMJwEas3w==
Date:   Tue, 12 Sep 2023 21:13:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Message-ID: <20230913021306.GA418113@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417E04B52A553984D83540188F0A@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 01:24:26AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
> > which IDA
> > 
> > On Tue, Aug 15, 2023 at 09:37:44AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > When PCI node was created using an overlay and the overlay is
> > > reverted/destroyed, the "linux,pci-domain" property no longer exists,
> > > so of_get_pci_domain_nr will return failure.
> > 
> > I'm not familiar with how overlays work.  What's the call path
> > where the overlay is removed?  I see an of_overlay_remove(), but I
> > don't see any callers except test cases.
> 
> We are using an out of tree hypervisor driver:
> https://github.com/siemens/jailhouse/blob/master/driver/pci.c#L483
> > 
> > I guess the problem happens in a PCI host bridge remove path, e.g.,
> > 
> >   pci_host_common_remove
> >     pci_remove_root_bus
> >       pci_bus_release_domain_nr
> >         of_pci_bus_release_domain_nr
> > 
> > But I don't know how that's related to the overlay removal.
>
> When the overlay node got removed, the device removal will be invoked and
> the domain number indicated by linux,pci-domain should also get freed.
> 
> But actually the domain number not got freed because of bug as this patch
> shows. "of_pci_bus_release_domain_nr will actually use the dynamic IDA,
> even if the IDA was allocated in static IDA."
> 
> So after the overlay node got destroyed and our test recreate the overlay node
> with same domain number, issue triggered, the device could not be
> created.
> 
> > Is this an ordering issue?  It seems possibly problematic that the
> > OF overlay is destroyed before the device it describes (e.g., the
> > host
> 
> No. it is "of_pci_bus_release_domain_nr will actually use the
> dynamic IDA, even if the IDA was allocated in static IDA "

Yes, that's the *symptom*, to be sure.  My question was why the
overlay was removed before the host bridge.

The current ordering is this, where A happens before B:

  A overlay is removed
  B pci_host_common_remove
      pci_bus_release_domain_nr
        of_pci_bus_release_domain_nr
          of_get_pci_domain_nr      # fails because overlay is gone
          ida_free(&pci_domain_nr_dynamic_ida)

But if the host bridge were removed first, the ordering would be as
follows, and the problem would not occur:

  B pci_host_common_remove
      pci_bus_release_domain_nr
        of_pci_bus_release_domain_nr
          of_get_pci_domain_nr      # succeeds in this order
          ida_free(&pci_domain_nr_static_ida)
  A overlay is removed

Is there a reason the overlay should be removed before the host
bridge?

Obviously the overlay is loaded before the host bridge is created, and
symmetry would suggest that the overlay should be removed after the
host bridge is removed.

> > bridge) is removed.  I would expect the device to be removed before the
> > description of the device is removed.
> > 
> > > Then of_pci_bus_release_domain_nr will actually use the dynamic IDA,
> > > even if the IDA was allocated in static IDA.
> > >
> > > Introduce a static_nr field in pci_bus to indicate whether the IDA is
> > > a dynamic or static in order to free the correct one.
> > >
> > > Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V2:
> > >  Update commit message
> > >  Move static_nr:1 to stay besides others :1 fields.
> > >
> > >  drivers/pci/pci.c   | 22 ++++++++++++++--------
> > >  include/linux/pci.h |  1 +
> > >  2 files changed, 15 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index
> > > 60230da957e0..5c98502bcda6 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -6881,10 +6881,10 @@ static void
> > of_pci_reserve_static_domain_nr(void)
> > >  	}
> > >  }
> > >
> > > -static int of_pci_bus_find_domain_nr(struct device *parent)
> > > +static int of_pci_bus_find_domain_nr(struct pci_bus *bus, struct
> > > +device *parent)
> > >  {
> > >  	static bool static_domains_reserved = false;
> > > -	int domain_nr;
> > > +	int domain_nr, ret;
> > >
> > >  	/* On the first call scan device tree for static allocations. */
> > >  	if (!static_domains_reserved) {
> > > @@ -6892,6 +6892,8 @@ static int of_pci_bus_find_domain_nr(struct
> > device *parent)
> > >  		static_domains_reserved = true;
> > >  	}
> > >
> > > +	bus->static_nr = 0;
> > > +
> > >  	if (parent) {
> > >  		/*
> > >  		 * If domain is in DT, allocate it in static IDA.  This @@ -
> > 6899,10
> > > +6901,14 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
> > >  		 * in DT.
> > >  		 */
> > >  		domain_nr = of_get_pci_domain_nr(parent->of_node);
> > > -		if (domain_nr >= 0)
> > > -			return ida_alloc_range(&pci_domain_nr_static_ida,
> > > -					       domain_nr, domain_nr,
> > > -					       GFP_KERNEL);
> > > +		if (domain_nr >= 0) {
> > > +			ret = ida_alloc_range(&pci_domain_nr_static_ida,
> > > +					      domain_nr, domain_nr,
> > GFP_KERNEL);
> > > +			if (ret >= 0)
> > > +				bus->static_nr = 1;
> > > +
> > > +			return ret;
> > > +		}
> > >  	}
> > >
> > >  	/*
> > > @@ -6920,7 +6926,7 @@ static void of_pci_bus_release_domain_nr(struct
> > pci_bus *bus, struct device *par
> > >  		return;
> > >
> > >  	/* Release domain from IDA where it was allocated. */
> > > -	if (of_get_pci_domain_nr(parent->of_node) == bus->domain_nr)
> > > +	if (bus->static_nr)
> > >  		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
> > >  	else
> > >  		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
> > @@ -6928,7
> > > +6934,7 @@ static void of_pci_bus_release_domain_nr(struct pci_bus
> > > *bus, struct device *par
> > >
> > >  int pci_bus_find_domain_nr(struct pci_bus *bus, struct device
> > > *parent)  {
> > > -	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
> > > +	return acpi_disabled ? of_pci_bus_find_domain_nr(bus, parent) :
> > >  			       acpi_pci_bus_find_domain_nr(bus);  }
> > >
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > > eeb2e6f6130f..222a1729ea7e 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -677,6 +677,7 @@ struct pci_bus {
> > >  	struct bin_attribute	*legacy_mem;	/* Legacy mem */
> > >  	unsigned int		is_added:1;
> > >  	unsigned int		unsafe_warn:1;	/* warned about RW1C
> > config write */
> > > +	unsigned int		static_nr:1;
> > >  };
> > >
> > >  #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
> > > --
> > > 2.37.1
> > >
