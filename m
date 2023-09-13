Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11479E758
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 13:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbjIML5o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 07:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240588AbjIML5n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 07:57:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C0D1996;
        Wed, 13 Sep 2023 04:57:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F75C433C8;
        Wed, 13 Sep 2023 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694606259;
        bh=ni8EdsyIaMOoJTwUMqc4jWnupbNY7F33IKQELHp2m+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KfZkCsIIPKOUc2N5H/7SjjnJD0hVIcef5K5b8vjRd3b22OWZGiFfSGXWWRJw40QS+
         WMnapiaXplumxGp15SCAWJ1KE86cgZ3ptGalPtSgzQ3vJ7BsUMgp6wxfXZJFA3vQUy
         +fgjZBgUAglbukYJAczetUAt1dZk0xiBk7VJyl5awQ5dz5QrNuaS6K/+dlwYOMWSrH
         OQ06v3hkymBOusTu8IXqsvzeM9cRXe8z3XktLUwLW+xpSxUMQQqrd50d6mHwJEICfn
         aulS2dCknYqkRKXokVt3lqUpatYrgfiTXskf8dSorxsnFQUVhqR2d7DiIqF67vFTM4
         hC41VBYT+Ln4w==
Date:   Wed, 13 Sep 2023 06:57:37 -0500
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
Message-ID: <20230913115737.GA426735@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB941790B85BCDD60ACA2601A588F0A@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 02:49:37AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
> > which IDA
> > 
> > On Wed, Sep 13, 2023 at 01:24:26AM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH V2] pci: introduce static_nr to indicate
> > > > domain_nr from which IDA
> > > >
> > > > On Tue, Aug 15, 2023 at 09:37:44AM +0800, Peng Fan (OSS) wrote:
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > When PCI node was created using an overlay and the overlay is
> > > > > reverted/destroyed, the "linux,pci-domain" property no longer
> > > > > exists, so of_get_pci_domain_nr will return failure.
> > > >
> > > > I'm not familiar with how overlays work.  What's the call path where
> > > > the overlay is removed?  I see an of_overlay_remove(), but I don't
> > > > see any callers except test cases.
> > >
> > > We are using an out of tree hypervisor driver:
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgith
> > >
> > ub.com%2Fsiemens%2Fjailhouse%2Fblob%2Fmaster%2Fdriver%2Fpci.c%23L
> > 483&d
> > >
> > ata=05%7C01%7Cpeng.fan%40nxp.com%7C1bf0364c585f42dae7f108dbb3fe
> > fcc4%7C
> > >
> > 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63830167996269745
> > 6%7CUnknow
> > >
> > n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > WwiLC
> > >
> > JXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=raIsz2HIH%2FQ0nmolBBwd81
> > WxQh2vmFeXN
> > > t3n6OIQaSU%3D&reserved=0
> > > >
> > > > I guess the problem happens in a PCI host bridge remove path, e.g.,
> > > >
> > > >   pci_host_common_remove
> > > >     pci_remove_root_bus
> > > >       pci_bus_release_domain_nr
> > > >         of_pci_bus_release_domain_nr
> > > >
> > > > But I don't know how that's related to the overlay removal.
> > >
> > > When the overlay node got removed, the device removal will be invoked
> > > and the domain number indicated by linux,pci-domain should also get freed.
> > >
> > > But actually the domain number not got freed because of bug as this
> > > patch shows. "of_pci_bus_release_domain_nr will actually use the
> > > dynamic IDA, even if the IDA was allocated in static IDA."
> > >
> > > So after the overlay node got destroyed and our test recreate the
> > > overlay node with same domain number, issue triggered, the device
> > > could not be created.
> > >
> > > > Is this an ordering issue?  It seems possibly problematic that the
> > > > OF overlay is destroyed before the device it describes (e.g., the
> > > > host
> > >
> > > No. it is "of_pci_bus_release_domain_nr will actually use the dynamic
> > > IDA, even if the IDA was allocated in static IDA "
> > 
> > Yes, that's the *symptom*, to be sure.  My question was why the overlay was
> > removed before the host bridge.
> 
> I am not sure.
> I added a dump_stack, would this help to understand?
> root@imx93evk:~# jailhouse disable
> [  595.150529] CPU: 1 PID: 582 Comm: jailhouse Tainted: G           O       6.5.0-rc4-next-20230804-05021-g3d4cc14b42ef-dirty #355
> [  595.161998] Hardware name: NXP i.MX93 11X11 EVK board (DT)
> [  595.167475] Call trace:
> [  595.169908]  dump_backtrace+0x94/0xec
> [  595.173573]  show_stack+0x18/0x24
> [  595.176884]  dump_stack_lvl+0x48/0x60
> [  595.180541]  dump_stack+0x18/0x24
> [  595.183843]  pci_bus_release_domain_nr+0x34/0x84
> [  595.188453]  pci_remove_root_bus+0xa0/0xa4
> [  595.192544]  pci_host_common_remove+0x28/0x40
> [  595.196895]  platform_remove+0x54/0x6c
> [  595.200641]  device_remove+0x4c/0x80
> [  595.204209]  device_release_driver_internal+0x1d4/0x230
> [  595.209430]  device_release_driver+0x18/0x24
> [  595.213691]  bus_remove_device+0xcc/0x10c
> [  595.217686]  device_del+0x15c/0x41c
> [  595.221170]  platform_device_del.part.0+0x1c/0x88
> [  595.225861]  platform_device_unregister+0x24/0x40
> [  595.230557]  of_platform_device_destroy+0xfc/0x10c
> [  595.235344]  of_platform_notify+0x13c/0x178
> [  595.239518]  blocking_notifier_call_chain+0x6c/0xa0
> [  595.244389]  __of_changeset_entry_notify+0x148/0x16c
> [  595.249346]  of_changeset_revert+0xa8/0xcc
> [  595.253437]  jailhouse_pci_virtual_root_devices_remove+0x50/0x74 [jailhouse]
> [  595.260484]  jailhouse_cmd_disable+0x70/0x1ac [jailhouse]
> [  595.265883]  jailhouse_ioctl+0x60/0xf0 [jailhouse]
> [  595.270674]  __arm64_sys_ioctl+0xac/0xf0
> [  595.274595]  invoke_syscall+0x48/0x114
> [  595.278336]  el0_svc_common.constprop.0+0xc4/0xe4
> > 
> > The current ordering is this, where A happens before B:
> > 
> >   A overlay is removed
> >   B pci_host_common_remove
> >       pci_bus_release_domain_nr
> >         of_pci_bus_release_domain_nr
> >           of_get_pci_domain_nr      # fails because overlay is gone
> >           ida_free(&pci_domain_nr_dynamic_ida)
> > 
> > But if the host bridge were removed first, the ordering would be as follows,
> > and the problem would not occur:
> > 
> >   B pci_host_common_remove
> >       pci_bus_release_domain_nr
> >         of_pci_bus_release_domain_nr
> >           of_get_pci_domain_nr      # succeeds in this order
> >           ida_free(&pci_domain_nr_static_ida)
> >   A overlay is removed
> > 
> > Is there a reason the overlay should be removed before the host bridge?
> > 
> > Obviously the overlay is loaded before the host bridge is created, and
> > symmetry would suggest that the overlay should be removed after the host
> > bridge is removed.
> 
> Hmm, I need check more. But do you think this patch is fix a real issue or
> If order is did as you say above, this patch is not required anymore?

It looks like you're using a notifier call chain to remove the devices
when the of_changeset is removed.  I think that's the wrong approach.
The only in-tree user of of_changeset_revert() is i2c-demux-pinctrl.c,
which uses the ordering I suggested:

  i2c_demux_activate_master
    of_changeset_apply               # add OF changeset
    i2c_add_adapter                  # add device

  i2c_demux_deactivate_master
    i2c_del_adapter                  # remove device
    of_changeset_revert              # remove OF changeset

> > > > bridge) is removed.  I would expect the device to be removed before
> > > > the description of the device is removed.
> > > >
> > > > > Then of_pci_bus_release_domain_nr will actually use the dynamic
> > > > > IDA, even if the IDA was allocated in static IDA.
> > > > >
> > > > > Introduce a static_nr field in pci_bus to indicate whether the IDA
> > > > > is a dynamic or static in order to free the correct one.
> > > > >
> > > > > Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > ---
> > > > >
> > > > > V2:
> > > > >  Update commit message
> > > > >  Move static_nr:1 to stay besides others :1 fields.
> > > > >
> > > > >  drivers/pci/pci.c   | 22 ++++++++++++++--------
> > > > >  include/linux/pci.h |  1 +
> > > > >  2 files changed, 15 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index
> > > > > 60230da957e0..5c98502bcda6 100644
> > > > > --- a/drivers/pci/pci.c
> > > > > +++ b/drivers/pci/pci.c
> > > > > @@ -6881,10 +6881,10 @@ static void
> > > > of_pci_reserve_static_domain_nr(void)
> > > > >  	}
> > > > >  }
> > > > >
> > > > > -static int of_pci_bus_find_domain_nr(struct device *parent)
> > > > > +static int of_pci_bus_find_domain_nr(struct pci_bus *bus, struct
> > > > > +device *parent)
> > > > >  {
> > > > >  	static bool static_domains_reserved = false;
> > > > > -	int domain_nr;
> > > > > +	int domain_nr, ret;
> > > > >
> > > > >  	/* On the first call scan device tree for static allocations. */
> > > > >  	if (!static_domains_reserved) {
> > > > > @@ -6892,6 +6892,8 @@ static int of_pci_bus_find_domain_nr(struct
> > > > device *parent)
> > > > >  		static_domains_reserved = true;
> > > > >  	}
> > > > >
> > > > > +	bus->static_nr = 0;
> > > > > +
> > > > >  	if (parent) {
> > > > >  		/*
> > > > >  		 * If domain is in DT, allocate it in static IDA.  This @@ -
> > > > 6899,10
> > > > > +6901,14 @@ static int of_pci_bus_find_domain_nr(struct device
> > > > > +*parent)
> > > > >  		 * in DT.
> > > > >  		 */
> > > > >  		domain_nr = of_get_pci_domain_nr(parent->of_node);
> > > > > -		if (domain_nr >= 0)
> > > > > -			return ida_alloc_range(&pci_domain_nr_static_ida,
> > > > > -					       domain_nr, domain_nr,
> > > > > -					       GFP_KERNEL);
> > > > > +		if (domain_nr >= 0) {
> > > > > +			ret = ida_alloc_range(&pci_domain_nr_static_ida,
> > > > > +					      domain_nr, domain_nr,
> > > > GFP_KERNEL);
> > > > > +			if (ret >= 0)
> > > > > +				bus->static_nr = 1;
> > > > > +
> > > > > +			return ret;
> > > > > +		}
> > > > >  	}
> > > > >
> > > > >  	/*
> > > > > @@ -6920,7 +6926,7 @@ static void
> > > > > of_pci_bus_release_domain_nr(struct
> > > > pci_bus *bus, struct device *par
> > > > >  		return;
> > > > >
> > > > >  	/* Release domain from IDA where it was allocated. */
> > > > > -	if (of_get_pci_domain_nr(parent->of_node) == bus->domain_nr)
> > > > > +	if (bus->static_nr)
> > > > >  		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
> > > > >  	else
> > > > >  		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
> > > > @@ -6928,7
> > > > > +6934,7 @@ static void of_pci_bus_release_domain_nr(struct pci_bus
> > > > > *bus, struct device *par
> > > > >
> > > > >  int pci_bus_find_domain_nr(struct pci_bus *bus, struct device
> > > > > *parent)  {
> > > > > -	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
> > > > > +	return acpi_disabled ? of_pci_bus_find_domain_nr(bus, parent) :
> > > > >  			       acpi_pci_bus_find_domain_nr(bus);  }
> > > > >
> > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > > > > eeb2e6f6130f..222a1729ea7e 100644
> > > > > --- a/include/linux/pci.h
> > > > > +++ b/include/linux/pci.h
> > > > > @@ -677,6 +677,7 @@ struct pci_bus {
> > > > >  	struct bin_attribute	*legacy_mem;	/* Legacy mem */
> > > > >  	unsigned int		is_added:1;
> > > > >  	unsigned int		unsafe_warn:1;	/* warned about RW1C
> > > > config write */
> > > > > +	unsigned int		static_nr:1;
> > > > >  };
> > > > >
> > > > >  #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
> > > > > --
> > > > > 2.37.1
> > > > >
