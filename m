Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D37FB44ED5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 23:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfFMV7k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 17:59:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:39398 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfFMV7k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 17:59:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5DLxLbL012284;
        Thu, 13 Jun 2019 16:59:23 -0500
Message-ID: <2b5302fead4075fd73e7821af27ccd16a0e487ae.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 14 Jun 2019 07:59:20 +1000
In-Reply-To: <20190613190248.GH13533@google.com>
References: <5783e36561bb77a1deb6ba67e5a9824488cc69c6.camel@kernel.crashing.org>
         <20190613190248.GH13533@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-06-13 at 14:02 -0500, Bjorn Helgaas wrote:
> > +	/*
> > +	 * Invoke the PCI device specific method (_DSM) #5 'Ignore PCI Boot
> > +	 * Configuration', on the host bridge. This tells us whether the
> > +	 * firmware wants us to preserve or reassign the configuration of
> > +	 * the PCI resource tree for this root bridge.
> > +	 *
> > +	 * There are three possible outcomes here:
> > +	 *
> > +	 *  - _DSM #5 is absent. This is the default. Currently it will be
> > +	 *    architecture specific in order to maintain existing behaviours
> > +	 *    but the plan is to move arm64 into the fold: x86 and ia64 will
> > +	 *    claim the existing config, and reassign if needed. arm64 will
> > +	 *    always reassign.
> 
> The spec (PCI FW r3.2) says a _DSM that returns 0 means "OS must not
> ignore config done by firmware".  The ECR in the works changes the
> wording to something like "OS must preserve config done by firmware",
> which is equivalent but clearer.
>
> The r3.2 spec goes on to suggest that a missing _DSM means the same
> thing ("OS must not ignore firmware config").  I think that part is
> crap, and the ECR removes that wording.
> 
> I don't accept the _DSM #5 section in the PCI FW spec as being
> normative about what a missing _DSM #5 means.  This section didn't
> even exist until r3.2, and all it says is "this situation is the same
> as the legacy situation where this _DSM is not provided".  That's just
> hand-waving; it's not a requirement.
> 
> I'm not aware of any spec that says the OS can't change PCI resources
> (if there is such a spec, please cite it).
> 
> So my opinion is that a missing _DSM means nothing, and the default
> situation is that the OS can change PCI resources as necessary.

Sure, but what do you think of my wording in the patch ? This is pretty
much what I've done: Keep the current (default) behaviour, which on
x86/ia64 is to claim what's there if it looks sensible and change thing
as deemed fit (reassigned what's not sensible, extent HP bridge
resources etc...).

This patch doesn't change the arm64 behaviour in that case which is to
currently reallocate everything but Lorenzo seems to agree that this
isn't great and we should change towards a more x86-like default, which
I'm working on, but I want to keep that change separate from this
patch, if anything for bisectability of potential regressions.

> The ECR input from Windows was that in the absence of a _DSM #5, they
> keep the boot configuration unless a FW bug causes an overlap, a
> hot-add requires rebalancing, or the system includes external (e.g.,
> Thunderbolt) devices.  That's what I think Linux should do, too: keep
> the config from firmware unless we have a reason to change it.

Right, and this is what x86 does, and this is what we'll eventually do
on arm64 as above.

> > +	 *  - _DSM #5 exists and is 1. This is the FW telling us to ignore
> > +	 *    the configuration it performed. This is currently only supported
> > +	 *    on arm64.
> 
> The r3.2 spec actually says "the OS *may* ignore config done by
> firmware".  There's no *requirement* that the OS change anything.
> 
> IMHO *this* is the same as the case where there's no _DSM at all.

May or may not be. Seattle platforms here tells us explicitely that we
should ignore the configuration, unless I'm mistaken. Lorenzo do you
know better here ?

> > +	 *  - _DSM #5 exists and is 0. This should be the same as the default
> > +	 *    (_DSM #5 absent). However there are some assumptions flying around
> > +	 *    that this means we must keep the FW configuration intact. So we
> > +	 *    treat that as "probe only" for the time being. This is currently
> > +	 *    only supported on arm64.
> 
> PCI FW r3.2 says 0 means "the OS must not ignore config done by
> firmware."  That means we must keep the FW configuration intact.

So "must not ignore" doesn't mean "keep intact" in my book. In fact, to
be honest, the wording in the spec pretty much means the same for all 3
cases, ie, you "may ignore" or "must not ignore" is bullshit. I can
perfectly "not ignore but decide it's bad and change it anyway". This
is all a terrible wording.

Like all firmware specs, it's designed for people to misinterpret it
and get things wrong :-)

What we know is that there is one platform that implements _DSM #5
today and returns 1 with the intention, unless I misread what I was
told, to tell us to explicitly ignore what FW did.

> > +	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
> > +	                        IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
> > +	if (obj && obj->type == ACPI_TYPE_INTEGER) {
> > +		if (obj->integer.value == 1)
> > +			host_bridge->rsrc_policy = pci_rsrc_reassign;
> > +		else
> > +			host_bridge->rsrc_policy = pci_rsrc_probe_only;
> > +	} else {
> > +		/* Default is arch specific ... for now */
> > +#ifdef CONFIG_ARM64
> > +		host_bridge->rsrc_policy = pci_rsrc_reassign;
> > +#else
> > +		host_bridge->rsrc_policy = pci_rsrc_normal;
> > +#endif
> > +	}
> 
> I think this needs to be a single bit, not a 3-choice thing. 

Well, no :-)

The enum in host_bridge needs to be 3 choices because it's meant to
represent the 3 policies that Linux has today sprinkled accross
architectures in rather inconsistent ways, but I'm not going to break
that in one patch and there are reasons for all 3 to exist. We can
discuss that separately if you want.

I plan to start cleaning up code to use that field to represent the
policies properly accross the board as I also consolidate code accross
archs/platforms.

However, what can possibly be debated here is how _DSM #5 maps to those
3. You think it should map to only two of them, I tend to disagree with
your arguments above but short of sitting on the spec commitee and
clarifying the wording, it's a matter of how has the pointiest hat and
the rounder crystal ball here.

>  I don't
> think it's possible to clearly explain how pci_rsrc_normal is
> different from pci_rsrc_reassign.  We either need to preserve the
> config or we don't.

No. "reassign" is "must reassign" or "must ignore FW settings". It may
not be what we want to do with ACPI _DSM #5 = 1, but it's definitely
what all current ARM32, powerpc4xx, and in general most embedded
platforms want today. In fact we have more platforms in the tree who
want just that.

Now you may want to make the argument that those platforms shouldn't
want that, but changing it would probably break a good half of them in
one go, that's what they've always done and I'm not here to mess around
with this.

Once I've consolidated more code, it might become easier on a per
platform basis to chose to switch to the "use what's there and reassign
what's broken or missing" model (ie, "pci_rsrc_normal"), but that will
have to be done on a case by case basis with appropriate testing etc..

> A middle ground of "we don't need to preserve the config and in fact
> we *must* reassign resources" is pointless because we don't know *why*
> we have to reassign things, and we don't know what sort of change
> would be correct.

For the ACPI case, maybe ... for all the other cases this is pretty
moot. Reassign all is what they do today, and changing it will probably
break them.

Cheers,
Ben.


> > +	ACPI_FREE(obj);
> > +
> >  	pci_scan_child_bus(bus);
> >  	pci_set_host_bridge_release(host_bridge, acpi_pci_root_release_info,
> >  				    info);
> > diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> > index 8082b612f561..62b7fdcc661c 100644
> > --- a/include/linux/pci-acpi.h
> > +++ b/include/linux/pci-acpi.h
> > @@ -107,9 +107,10 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
> >  #endif
> >  
> >  extern const guid_t pci_acpi_dsm_guid;
> > -#define DEVICE_LABEL_DSM	0x07
> > -#define RESET_DELAY_DSM		0x08
> > -#define FUNCTION_DELAY_DSM	0x09
> > +#define IGNORE_PCI_BOOT_CONFIG_DSM	0x05
> > +#define DEVICE_LABEL_DSM		0x07
> > +#define RESET_DELAY_DSM			0x08
> > +#define FUNCTION_DELAY_DSM		0x09
> >  
> >  #else	/* CONFIG_ACPI */
> >  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index dd436da7eccc..7ff5cedb30cf 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -486,6 +486,12 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
> >  	return (pdev->error_state != pci_channel_io_normal);
> >  }
> >  
> > +enum pci_host_rsrc_policy {
> > +	pci_rsrc_normal,	/* Probe and (re)assign what's missing/broken */
> > +	pci_rsrc_probe_only,	/* Probe only */
> > +	pci_rsrc_reassign,	/* Reassign resources */
> > +};
> > +
> >  struct pci_host_bridge {
> >  	struct device	dev;
> >  	struct pci_bus	*bus;		/* Root bus */
> > @@ -506,6 +512,10 @@ struct pci_host_bridge {
> >  	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
> >  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
> >  	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
> > +
> > +	/* Resource assignment/allocation policy */
> > +	enum pci_host_rsrc_policy rsrc_policy;
> > +
> >  	/* Resource alignment requirements */
> >  	resource_size_t (*align_resource)(struct pci_dev *dev,
> >  			const struct resource *res,
> > 
> > 

