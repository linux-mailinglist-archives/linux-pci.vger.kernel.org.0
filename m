Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7067C3D00E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfFKO6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 10:58:37 -0400
Received: from foss.arm.com ([217.140.110.172]:35406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbfFKO6h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jun 2019 10:58:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29FC5346;
        Tue, 11 Jun 2019 07:58:36 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 080393F246;
        Tue, 11 Jun 2019 07:58:34 -0700 (PDT)
Date:   Tue, 11 Jun 2019 15:58:32 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Subject: Re: [PATCH/RESEND] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
Message-ID: <20190611145832.GB11736@redmoon>
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
 <20190604014945.GE189360@google.com>
 <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
 <20190604124959.GF189360@google.com>
 <e520a4269224ac54798314798a80c080832e68b1.camel@kernel.crashing.org>
 <d53fc77e1e754ddbd9af555ed5b344c5fa523154.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d53fc77e1e754ddbd9af555ed5b344c5fa523154.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 06, 2019 at 07:00:12PM +1000, Benjamin Herrenschmidt wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> On arm64 ACPI systems, we unconditionally reconfigure the entire PCI
> hierarchy at boot. This is a departure from what is customary on ACPI
> systems, and may break assumptions in some places (e.g., EFIFB), that
> the kernel will leave BARs of enabled PCI devices where they are.
> 
> Given that PCI already specifies a device specific ACPI method (_DSM)
> for PCI root bridge nodes that tells us whether the firmware thinks
> the configuration should be left alone, let's sidestep the entire
> policy debate about whether the PCI configuration should be preserved
> or not, and put it under the control of the firmware instead.
> 
> [BenH: Added pci_assign_unassigned_root_bus_resources()]
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> So I would like this variant rather than mucking around with
> IORESOURCE_PCI_FIXED at this stage to fix the problem with our platforms.
> 
> See my other email, IORESOURCE_PCI_FIXED doesn't really work terribly well
> when using pci_bus_size_bridges and pci_bus_assign_resources, and the
> resulting patches are ugly and add more mess.
> 
> Long run, I propose to start working on consolidating all those various
> resource survey mechanisms around what x86 does, unless people strongly
> object... (with the addition of the probe only and force reassign quirks
> so platforms can still chose that).
> 
> Note: I haven't tested the effect of pci_assign_unassigned_root_bus_resources
> as our platforms don't leave anything unassigned. I'm not entirely sure how
> well pci_bus_claim_resources() will deal with a partially assigned setup...
> 
> We do want to support partial assignment by BIOS though, it's a trend to
> reduce boot time, people seem to want BIOSes to only assign what's critical
> for booting.
> 
> Bjorn: I haven't made the claim path the default in absence of _DSM #5 yet.
> I suggest we do that as a separate patch in case it breaks somebody, thus
> making bisection more meaningful. It will also make this one more palatable
> to distros since it won't change the behaviour on systems without _DSM #5,
> and we verified nobody has it except Seattle which returns 1. 
> 
>  arch/arm64/kernel/pci.c  | 23 +++++++++++++++++++++--
>  include/linux/pci-acpi.h |  7 ++++---
>  2 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index bb85e2f4603f..6358e1cb4f9f 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -168,6 +168,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	struct acpi_pci_generic_root_info *ri;
>  	struct pci_bus *bus, *child;
>  	struct acpi_pci_root_ops *root_ops;
> +	union acpi_object *obj;
>  
>  	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
>  	if (!ri)
> @@ -193,8 +194,26 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	if (!bus)
>  		return NULL;
>  
> -	pci_bus_size_bridges(bus);
> -	pci_bus_assign_resources(bus);
> +	/*
> +	 * Invoke the PCI device specific method (_DSM) #5 'Ignore PCI Boot
> +	 * Configuration', which tells us whether the firmware wants us to
> +	 * preserve the configuration of the PCI resource tree for this root
> +	 * bridge.
> +	 */
> +	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
> +	                        IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
> +	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0) {
> +		/* preserve existing resource assignment */
> +		pci_bus_claim_resources(bus);
> +
> +		/* Assign anything that might have been left out */
> +		pci_assign_unassigned_root_bus_resources(bus);
> +	} else {
> +		/* reconfigure the resource tree from scratch */
> +		pci_bus_size_bridges(bus);
> +		pci_bus_assign_resources(bus);
> +	}

	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0) {
		/* preserve existing resource assignment */
		pci_bus_claim_resources(bus);
	}

	pci_bus_size_bridges(bus);
	pci_bus_assign_resources(bus);

That's how it should be I think:

1) we do not want pci_assign_unassigned_root_bus_resources(bus) to
   reallocate resources already claimed (see realloc parameter), do we ?
2) pci_bus_size_bridges(bus) and pci_bus_assign_resources(bus) should
   not interfere with resources already claimed so it *should* be safe
   to call them anyway

Most importantly: I want everyone to agree that claiming is equivalent
to making a resource immutable (except for realloc, see (1) above)
because that's what we are doing by claiming on _DSM #5 == 0.

There are too many ways to make a resource immutable in the kernel
and this is confusing and prone to bugs.

Thanks,
Lorenzo

> +	ACPI_FREE(obj);
>  
>  	list_for_each_entry(child, &bus->children, node)
>  		pcie_bus_configure_settings(child);
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
> 
> 
