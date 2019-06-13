Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2612244B84
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 21:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfFMTCw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 15:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbfFMTCw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 15:02:52 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 464E020B7C;
        Thu, 13 Jun 2019 19:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560452570;
        bh=E9qshPeU0DrWf0BKzElLpC7lnCoLhlxr4VBNHdi9leU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPy6zb2F0f8e9hHr0uEBkV9sBOMaGf3yERb1w7O8jHaSlQFgcFTHIfFP7YncRw09f
         cl/8hO2/v2eGBHqRptWz9mfkGyTZZR80ALcVvIJaJISq0BCngGVuFWLG7c27VtmVYA
         o247zxQSmAOte2nJgaQlZa2NOHOv0u69RDCSwxH4=
Date:   Thu, 13 Jun 2019 14:02:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
Message-ID: <20190613190248.GH13533@google.com>
References: <5783e36561bb77a1deb6ba67e5a9824488cc69c6.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5783e36561bb77a1deb6ba67e5a9824488cc69c6.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 05:54:56PM +1000, Benjamin Herrenschmidt wrote:
> The current arm64 PCI code for ACPI platforms will unconditionally
> reassign all resources.
> 
> This is not only suboptimal, it's also wrong for a number of cases, for
> example, this could invalidate a UEFI framebuffer address, or a runtime
> firmware could be using some of the devices in their original location.
> 
> There is an ACPI method defined today for P2P bridges (_DSM #5) that
> can indicate that a bridge resources set by firmware. There is current
> discussions to extend that method to cover host bridges, and define
> a value of "0" as meaning that the resources must be preserved.

The ECR does extend the r3.2 spec so the _DSM can apply to host
bridges.  Apart from that change, the ECR clarifies the language
without changing the sense.  The meaning of "0" doesn't change.

> This patch adds the resource assignment policy to struct
> pci_host_bridge and sets it based on the presence of that method and if
> present the value returned, and honors it on arm64.
> 
> No other architectures are currently affected, and the default is kept
> to "reassign everything" on arm64 for now via an #ifdef, though we do
> plan to get rid of that in a separate patch.
> 
> The setting in pci_host_bridge "looks" generic because I intend in
> subsquent work to consolidate the resource allocation policy accross
> architectures and I intend for that setting to be the canonical
> location used by the generic code to decide what to do.
> 
> This is based on some earlier work by
> Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
>  arch/arm64/kernel/pci.c  | 12 ++++++++++--
>  drivers/acpi/pci_root.c  | 42 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |  7 ++++---
>  include/linux/pci.h      | 10 ++++++++++
>  4 files changed, 66 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index bb85e2f4603f..b209a506f390 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -168,6 +168,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	struct acpi_pci_generic_root_info *ri;
>  	struct pci_bus *bus, *child;
>  	struct acpi_pci_root_ops *root_ops;
> +	struct pci_host_bridge *hb;

The only other use of "struct pci_host_bridge *" in this file uses
"bridge" as the variable, so I'd follow suit.

>  	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
>  	if (!ri)
> @@ -193,8 +194,15 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	if (!bus)
>  		return NULL;
>  
> -	pci_bus_size_bridges(bus);
> -	pci_bus_assign_resources(bus);
> +	hb = pci_find_host_bridge(bus);
> +
> +	/* If the policy is normal or probe only, claim existing resources */
> +	if (hb->rsrc_policy != pci_rsrc_reassign)
> +		pci_bus_claim_resources(bus);
> +
> +	/* If the policy is not probe only, assign what's left unassigned */
> +	if (hb->rsrc_policy != pci_rsrc_probe_only)
> +		pci_assign_unassigned_root_bus_resources(bus);
>  
>  	list_for_each_entry(child, &bus->children, node)
>  		pcie_bus_configure_settings(child);
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 39f5d172e84f..410f7f2b2587 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -881,6 +881,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	int node = acpi_get_node(device->handle);
>  	struct pci_bus *bus;
>  	struct pci_host_bridge *host_bridge;
> +	union acpi_object *obj;
>  
>  	info->root = root;
>  	info->bridge = device;
> @@ -917,6 +918,47 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
>  		host_bridge->native_ltr = 0;
>  
> +	/*
> +	 * Invoke the PCI device specific method (_DSM) #5 'Ignore PCI Boot
> +	 * Configuration', on the host bridge. This tells us whether the
> +	 * firmware wants us to preserve or reassign the configuration of
> +	 * the PCI resource tree for this root bridge.
> +	 *
> +	 * There are three possible outcomes here:
> +	 *
> +	 *  - _DSM #5 is absent. This is the default. Currently it will be
> +	 *    architecture specific in order to maintain existing behaviours
> +	 *    but the plan is to move arm64 into the fold: x86 and ia64 will
> +	 *    claim the existing config, and reassign if needed. arm64 will
> +	 *    always reassign.

The spec (PCI FW r3.2) says a _DSM that returns 0 means "OS must not
ignore config done by firmware".  The ECR in the works changes the
wording to something like "OS must preserve config done by firmware",
which is equivalent but clearer.

The r3.2 spec goes on to suggest that a missing _DSM means the same
thing ("OS must not ignore firmware config").  I think that part is
crap, and the ECR removes that wording.

I don't accept the _DSM #5 section in the PCI FW spec as being
normative about what a missing _DSM #5 means.  This section didn't
even exist until r3.2, and all it says is "this situation is the same
as the legacy situation where this _DSM is not provided".  That's just
hand-waving; it's not a requirement.

I'm not aware of any spec that says the OS can't change PCI resources
(if there is such a spec, please cite it).

So my opinion is that a missing _DSM means nothing, and the default
situation is that the OS can change PCI resources as necessary.

The ECR input from Windows was that in the absence of a _DSM #5, they
keep the boot configuration unless a FW bug causes an overlap, a
hot-add requires rebalancing, or the system includes external (e.g.,
Thunderbolt) devices.  That's what I think Linux should do, too: keep
the config from firmware unless we have a reason to change it.

> +	 *  - _DSM #5 exists and is 1. This is the FW telling us to ignore
> +	 *    the configuration it performed. This is currently only supported
> +	 *    on arm64.

The r3.2 spec actually says "the OS *may* ignore config done by
firmware".  There's no *requirement* that the OS change anything.

IMHO *this* is the same as the case where there's no _DSM at all.

> +	 *  - _DSM #5 exists and is 0. This should be the same as the default
> +	 *    (_DSM #5 absent). However there are some assumptions flying around
> +	 *    that this means we must keep the FW configuration intact. So we
> +	 *    treat that as "probe only" for the time being. This is currently
> +	 *    only supported on arm64.

PCI FW r3.2 says 0 means "the OS must not ignore config done by
firmware."  That means we must keep the FW configuration intact.

> +	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
> +	                        IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
> +	if (obj && obj->type == ACPI_TYPE_INTEGER) {
> +		if (obj->integer.value == 1)
> +			host_bridge->rsrc_policy = pci_rsrc_reassign;
> +		else
> +			host_bridge->rsrc_policy = pci_rsrc_probe_only;
> +	} else {
> +		/* Default is arch specific ... for now */
> +#ifdef CONFIG_ARM64
> +		host_bridge->rsrc_policy = pci_rsrc_reassign;
> +#else
> +		host_bridge->rsrc_policy = pci_rsrc_normal;
> +#endif
> +	}

I think this needs to be a single bit, not a 3-choice thing.  I don't
think it's possible to clearly explain how pci_rsrc_normal is
different from pci_rsrc_reassign.  We either need to preserve the
config or we don't.

A middle ground of "we don't need to preserve the config and in fact
we *must* reassign resources" is pointless because we don't know *why*
we have to reassign things, and we don't know what sort of change
would be correct.

> +	ACPI_FREE(obj);
> +
>  	pci_scan_child_bus(bus);
>  	pci_set_host_bridge_release(host_bridge, acpi_pci_root_release_info,
>  				    info);
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 8082b612f561..62b7fdcc661c 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -107,9 +107,10 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
>  #endif
>  
>  extern const guid_t pci_acpi_dsm_guid;
> -#define DEVICE_LABEL_DSM	0x07
> -#define RESET_DELAY_DSM		0x08
> -#define FUNCTION_DELAY_DSM	0x09
> +#define IGNORE_PCI_BOOT_CONFIG_DSM	0x05
> +#define DEVICE_LABEL_DSM		0x07
> +#define RESET_DELAY_DSM			0x08
> +#define FUNCTION_DELAY_DSM		0x09
>  
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index dd436da7eccc..7ff5cedb30cf 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -486,6 +486,12 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
>  	return (pdev->error_state != pci_channel_io_normal);
>  }
>  
> +enum pci_host_rsrc_policy {
> +	pci_rsrc_normal,	/* Probe and (re)assign what's missing/broken */
> +	pci_rsrc_probe_only,	/* Probe only */
> +	pci_rsrc_reassign,	/* Reassign resources */
> +};
> +
>  struct pci_host_bridge {
>  	struct device	dev;
>  	struct pci_bus	*bus;		/* Root bus */
> @@ -506,6 +512,10 @@ struct pci_host_bridge {
>  	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
>  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>  	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
> +
> +	/* Resource assignment/allocation policy */
> +	enum pci_host_rsrc_policy rsrc_policy;
> +
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>  			const struct resource *res,
> 
> 
