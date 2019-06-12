Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F0A42328
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 12:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfFLK7D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 06:59:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:53013 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbfFLK7D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 06:59:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5CAwfco015991;
        Wed, 12 Jun 2019 05:58:43 -0500
Message-ID: <79e751a0f3bb05d0cbb97591e26040a6f45d98f6.camel@kernel.crashing.org>
Subject: Re: [PATCH/RESEND] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Date:   Wed, 12 Jun 2019 20:58:41 +1000
In-Reply-To: <20190612100826.GB6506@redmoon>
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
         <20190604014945.GE189360@google.com>
         <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
         <20190604124959.GF189360@google.com>
         <e520a4269224ac54798314798a80c080832e68b1.camel@kernel.crashing.org>
         <d53fc77e1e754ddbd9af555ed5b344c5fa523154.camel@kernel.crashing.org>
         <20190611145832.GB11736@redmoon>
         <5b5199b008d6c8831175018975f09599081dc5e4.camel@kernel.crashing.org>
         <20190612100826.GB6506@redmoon>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-06-12 at 11:08 +0100, Lorenzo Pieralisi wrote:
> 
> Nothing wrong, we have not understood each others. What I am asking
> is to write it like this:
> 
> if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0) {
> 	/* preserve existing resource assignment */
> 	pci_bus_claim_resources(bus);
> }
> 
> /* this code path should be common, indipendent of _DSM #5
> pci_assign_unassigned_root_bus_resources(bus);
> 
> There is no reason to have two distinct code paths, current code
> can call:
> 
> pci_assign_unassigned_root_bus_resources(bus);
> 
> instead of
> 
> pci_bus_size_bridges(bus);
> pci_bus_assign_resources(bus);
> 
> Actually, current code is *questionable* given that AFAICS it
> does not account for hotplug bridges additional memory window
> size.

Ah yes, I see, ok, I'll play with that in qemu a bit tomorrow
make sure we aren't missing something obvious & update the patch.

> > > That's how it should be I think:
> > > 
> > > 1) we do not want pci_assign_unassigned_root_bus_resources(bus) to
> > >    reallocate resources already claimed (see realloc parameter), do we ?
> > 
> > Well, realloc is useful to handle SR_IOV when the BIOS doesn't do it
> > right (common case). That said, at this point, we should be able to
> > honor IORESOURCE_PCI_FIXED for things that have _DSM #5 since they have
> > been claimed. I don't see that realloc logic being a problem for us,
> > and I want to avoid gratuitous differences with x86, but maybe I'm
> > missing something here...
> 
> See above. The conditions that make IORESOURCE_PCI_FIXED work are
> still unclear to me.

I more/less convinced myself it doesn't in the full-reassignment case
:-) As for the more traditional survey + assign, it can work if the
original survey led to reasonable values, mostly by preventing (I
*think*, I still need to convince myself) the realloc path for kicking
in, but this is all very fishy... At least x86 does use that flag at
least in one place from my grepping around...

> > > 2) pci_bus_size_bridges(bus) and pci_bus_assign_resources(bus) should
> > >    not interfere with resources already claimed so it *should* be safe
> > >    to call them anyway
> > 
> > Sure, *should* and here we introduce yet another way of doing things
> > though... Any reason we don't want to do what x86 does here ?
> 
> No, see above, keeping in mind that what x86 does is still not
> very well defined AFAICS.

It's not defined, it's grown through an evolutionary process :-) It's
still by far the most tested with the widest range of crazy PCI devices
and BIOSes I would think.

> > > Most importantly: I want everyone to agree that claiming is equivalent
> > > to making a resource immutable (except for realloc, see (1) above)
> > > because that's what we are doing by claiming on _DSM #5 == 0.
> > 
> > I think the combination of claiming *and* IORESOURCE_PCI_FIXED is what
> > makes it *really* immutable. I'm a bit confused by the realloc logic
> > right now, I'll need more quality time looking at it after ingesting
> > more caffeing but I'm under the impression that it will honor the flag.
> 
> Likewise, this requires some fuzzing because it is really hard to
> understand by perusing the code.

Yup.

> > > There are too many ways to make a resource immutable in the kernel
> > > and this is confusing and prone to bugs.
> > 
> > It is, but I don't want to create new ways of doing things, and what
> > you seem to propose is a new way imho :-)
> 
> No, see above. What I am saying is that we have IORESOURCE_PCI_FIXED,
> res->parent != NULL and Enhanced allocation to make a BAR immutable and
> before going any further it would be great if we understand their
> interaction given that we are starting from a pseudo clean slate.

> If we fail to do that it is quirks later (and I would rather avoid
> seeing x86 command line parameters to work around them).

Well.. while I would hate to have to *use* the x86 command line
parameters, I also don't like them not existing on all archs, as they
can actually be useful to help diagnose issues if anything (with of
course the intention of fixing things so they aren't needed in the long
run of course).

Cheers,
Ben.

> Cheers,
> Lorenzo
> 
> > Cheers,
> > Ben.
> > 
> > > Thanks,
> > > Lorenzo
> > > 
> > > > +	ACPI_FREE(obj);
> > > >  
> > > >  	list_for_each_entry(child, &bus->children, node)
> > > >  		pcie_bus_configure_settings(child);
> > > > diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> > > > index 8082b612f561..62b7fdcc661c 100644
> > > > --- a/include/linux/pci-acpi.h
> > > > +++ b/include/linux/pci-acpi.h
> > > > @@ -107,9 +107,10 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
> > > >  #endif
> > > >  
> > > >  extern const guid_t pci_acpi_dsm_guid;
> > > > -#define DEVICE_LABEL_DSM	0x07
> > > > -#define RESET_DELAY_DSM		0x08
> > > > -#define FUNCTION_DELAY_DSM	0x09
> > > > +#define IGNORE_PCI_BOOT_CONFIG_DSM	0x05
> > > > +#define DEVICE_LABEL_DSM		0x07
> > > > +#define RESET_DELAY_DSM			0x08
> > > > +#define FUNCTION_DELAY_DSM		0x09
> > > >  
> > > >  #else	/* CONFIG_ACPI */
> > > >  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
> > > > 
> > > > 

