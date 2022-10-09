Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801F15F8BA7
	for <lists+linux-pci@lfdr.de>; Sun,  9 Oct 2022 16:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJIOCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Oct 2022 10:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJIOCx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Oct 2022 10:02:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E696428E04;
        Sun,  9 Oct 2022 07:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75328B80BA8;
        Sun,  9 Oct 2022 14:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFC7C433D6;
        Sun,  9 Oct 2022 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665324168;
        bh=+nfmJBgPfpmYDYDY1mmCMXb9tJJ1JiaUdeMma+s8ydo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NpkUxHWNi8vI75rPIdE926HN5ANRMZHHQJOQHgEw5YhJlZ6SZXbCjmU1RWmdxPQHn
         TwlGtUwDQmmHIYLK904CuXIAQhW3ZpiCZq1+6oBexdlg9RtVqqtPA2IghUIyKveF4M
         mvzvbgGNcmDcvVqHMdeD9gRdmwVT39IbcS2KuRGxiypSsgPDtRYs4m8wKCrLTl3Yr+
         jtkYUYxWRZWN7+rhQRFXhFufKQZ1kTGD87pwyznzfpRIjruWEUjfZw53hK67b5vs+u
         +dWAIbFZcb+FyTOy0Ez8ev3R/mGVDvRA8oMHjmfz7YeEQLORIK9g6HP7t0jhlyaFs8
         N992p4D/xIiQA==
Received: by pali.im (Postfix)
        id 22EC47C1; Sun,  9 Oct 2022 16:02:45 +0200 (CEST)
Date:   Sun, 9 Oct 2022 16:02:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Assign PCI domain by ida_alloc()
Message-ID: <20221009140245.4ho7bwxc2klkuonb@pali>
References: <20220702204737.7719-1-pali@kernel.org>
 <20220714184130.5436-1-pali@kernel.org>
 <bde17d7f-21f8-3a53-c104-31baf1c8e3d2@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bde17d7f-21f8-3a53-c104-31baf1c8e3d2@wanadoo.fr>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 09 October 2022 15:36:32 Christophe JAILLET wrote:
> Le 14/07/2022 à 20:41, Pali Rohár a écrit :
> > Replace assignment of PCI domain from atomic_inc_return() to ida_alloc().
> > 
> > Use two IDAs, one for static domain allocations (those which are defined in
> > device tree) and second for dynamic allocations (all other).
> > 
> > During removal of root bus / host bridge release also allocated domain id.
> > So released id can be reused again, for example in situation when
> > dynamically loading and unloading native PCI host bridge drivers.
> > 
> > This change also allows to mix static device tree assignment and dynamic by
> > kernel as all static allocations are reserved in dynamic pool.
> > 
> 
> Hi,
> 
> A few comments below related to error handling.
> Take them as a naive review from s.o. with limited knowledge of PCI ;-)
> 
> CJ

Hello and thank you!

> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> > Idea of this patch comes from the following discussion:
> > https://lore.kernel.org/linux-pci/20210412123936.25555-1-pali@kernel.org/t/#u
> > 
> > Changes in v2:
> > * Fix broken compilation
> > ---
> >   drivers/pci/pci.c    | 103 +++++++++++++++++++++++++------------------
> >   drivers/pci/probe.c  |   5 +++
> >   drivers/pci/remove.c |   6 +++
> >   include/linux/pci.h  |   1 +
> >   4 files changed, 72 insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index cfaf40a540a8..34fdcee6634a 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6762,60 +6762,70 @@ static void pci_no_domains(void)
> >   }
> >   #ifdef CONFIG_PCI_DOMAINS_GENERIC
> > -static atomic_t __domain_nr = ATOMIC_INIT(-1);
> > +static DEFINE_IDA(pci_domain_nr_static_ida);
> > +static DEFINE_IDA(pci_domain_nr_dynamic_ida);
> > -static int pci_get_new_domain_nr(void)
> > +static void of_pci_reserve_static_domain_nr(void)
> >   {
> > -	return atomic_inc_return(&__domain_nr);
> > +	struct device_node *np;
> > +	int domain_nr;
> > +
> > +	for_each_node_by_type(np, "pci") {
> > +		domain_nr = of_get_pci_domain_nr(np);
> > +		if (domain_nr < 0)
> > +			continue;
> > +		/*
> > +		 * Permanently allocate domain_nr in dynamic_ida
> > +		 * to prevent it from dynamic allocation.
> > +		 */
> > +		ida_alloc_range(&pci_domain_nr_dynamic_ida,
> > +				domain_nr, domain_nr, GFP_KERNEL);
> 
> IIUC, if the DT is broken, 'domain_nr' could have several times the same
> value. In such a case ida_alloc_range() would return -ENOSPC.
> 
> Should this be handled here, maybe at least with a error message?

This code is gathering all domain ids which must not be used by dynamic
domain id allocator. It does it by looking for domain ids in device
tree. And in case one domain id is in device tree more times then it is
not issue for this code -- because the only purpose is to build a list
of "forbidden" ids. So duplicate domain ids here is not error and I
think it is not even warning (as id is already reserved and avoided in
dynamic allocator).

Also it is possible that in device tree is one domain id specified
multiple times, but device tree structure for specific board is written
in the way that exactly one of node with duplicate domain ids would be
registered. This can be achieved e.g. by status = "disabled" or some
other way how subnodes are bind to kernel drivers.

So I think this is not an issue and possible duplicates and error are
handled below...

> > +	}
> >   }
> >   static int of_pci_bus_find_domain_nr(struct device *parent)
> >   {
> > -	static int use_dt_domains = -1;
> > -	int domain = -1;
> > +	static bool static_domains_reserved = false;
> > +	int domain_nr;
> > -	if (parent)
> > -		domain = of_get_pci_domain_nr(parent->of_node);
> > +	/* On the first call scan device tree for static allocations. */
> > +	if (!static_domains_reserved) {
> > +		of_pci_reserve_static_domain_nr();
> > +		static_domains_reserved = true;
> > +	}
> > +
> > +	if (parent) {
> > +		/*
> > +		 * If domain is in DT then allocate it in static IDA.
> > +		 * This prevent duplicate static allocations in case
> > +		 * of errors in DT.
> > +		 */
> > +		domain_nr = of_get_pci_domain_nr(parent->of_node);
> > +		if (domain_nr >= 0)
> > +			return ida_alloc_range(&pci_domain_nr_static_ida,
> > +					       domain_nr, domain_nr,
> > +					       GFP_KERNEL);
> 
> Same here. Can ida_alloc_range() fail with -ENOSPC?
> If yes, what should be done in such a case?

Yes, it can. And caller needs to handle it. If in device tree is
specified that PCI host bridge must use specific domain number (e.g.
because of static allocation in firmware, bootloader, etc...) and kernel
cannot achieve it (e.g. because of error in device tree or somewhere
else) then kernel cannot register this PCI host bridge. Hence there is
immediate return with possible -ENOSPC (or any other negative error
code) to the caller; which prevents future registration of PCI host
bridge.

> > +	}
> >   	/*
> > -	 * Check DT domain and use_dt_domains values.
> > -	 *
> > -	 * If DT domain property is valid (domain >= 0) and
> > -	 * use_dt_domains != 0, the DT assignment is valid since this means
> > -	 * we have not previously allocated a domain number by using
> > -	 * pci_get_new_domain_nr(); we should also update use_dt_domains to
> > -	 * 1, to indicate that we have just assigned a domain number from
> > -	 * DT.
> > -	 *
> > -	 * If DT domain property value is not valid (ie domain < 0), and we
> > -	 * have not previously assigned a domain number from DT
> > -	 * (use_dt_domains != 1) we should assign a domain number by
> > -	 * using the:
> > -	 *
> > -	 * pci_get_new_domain_nr()
> > -	 *
> > -	 * API and update the use_dt_domains value to keep track of method we
> > -	 * are using to assign domain numbers (use_dt_domains = 0).
> > -	 *
> > -	 * All other combinations imply we have a platform that is trying
> > -	 * to mix domain numbers obtained from DT and pci_get_new_domain_nr(),
> > -	 * which is a recipe for domain mishandling and it is prevented by
> > -	 * invalidating the domain value (domain = -1) and printing a
> > -	 * corresponding error.
> > +	 * If domain was not specified in DT then choose free id from dynamic
> > +	 * allocations. All domain numbers from DT are permanently in dynamic
> > +	 * allocations to prevent assigning them to other DT nodes without
> > +	 * static domain.
> >   	 */
> > -	if (domain >= 0 && use_dt_domains) {
> > -		use_dt_domains = 1;
> > -	} else if (domain < 0 && use_dt_domains != 1) {
> > -		use_dt_domains = 0;
> > -		domain = pci_get_new_domain_nr();
> > -	} else {
> > -		if (parent)
> > -			pr_err("Node %pOF has ", parent->of_node);
> > -		pr_err("Inconsistent \"linux,pci-domain\" property in DT\n");
> > -		domain = -1;
> > -	}
> > +	return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
> 
> Same here, even if un-likelly.

Then again, caller of this function has to check return value and reject
registration of PCI host bridge if kernel cannot allocate PCI domain id
for it (for whatever reason). See below...

> 
> > +}
> > -	return domain;
> > +static void of_pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent)
> > +{
> > +	if (bus->domain_nr < 0)
> > +		return;
> > +
> > +	/* Release domain from ida in which was it allocated. */
> > +	if (of_get_pci_domain_nr(parent->of_node) == bus->domain_nr)
> > +		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
> > +	else
> > +		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
> >   }
> >   int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
> > @@ -6823,6 +6833,13 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
> >   	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
> >   			       acpi_pci_bus_find_domain_nr(bus);
> >   }
> > +
> > +void pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent)
> > +{
> > +	if (!acpi_disabled)
> > +		return;
> > +	of_pci_bus_release_domain_nr(bus, parent);
> > +}
> >   #endif
> >   /**
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 17a969942d37..12092d238403 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -906,6 +906,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >   		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> >   	else
> >   		bus->domain_nr = bridge->domain_nr;
> > +	if (bus->domain_nr < 0)
> > +		goto free;

And here is the place where _caller_ do this check. If allocation fails
then PCI core code stops registration.

> >   #endif
> >   	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
> > @@ -1030,6 +1032,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >   	device_del(&bridge->dev);
> >   free:
> > +#ifdef CONFIG_PCI_DOMAINS_GENERIC
> > +	pci_bus_release_domain_nr(bus, parent);
> > +#endif
> >   	kfree(bus);
> >   	return err;
> >   }
> > diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> > index 4c54c75050dc..0145aef1b930 100644
> > --- a/drivers/pci/remove.c
> > +++ b/drivers/pci/remove.c
> > @@ -160,6 +160,12 @@ void pci_remove_root_bus(struct pci_bus *bus)
> >   	pci_remove_bus(bus);
> >   	host_bridge->bus = NULL;
> > +#ifdef CONFIG_PCI_DOMAINS_GENERIC
> > +	/* Release domain_nr if it was dynamically allocated */
> > +	if (host_bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
> > +		pci_bus_release_domain_nr(bus, host_bridge->dev.parent);
> > +#endif
> > +
> >   	/* remove the host bridge */
> >   	device_del(&host_bridge->dev);
> >   }
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 81a57b498f22..6c7f27e62bcc 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1723,6 +1723,7 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
> >   { return 0; }
> >   #endif
> >   int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
> > +void pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent);
> >   #endif
> >   /* Some architectures require additional setup to direct VGA traffic */
> 
