Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE2F4EFD3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 22:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfFUUHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 16:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfFUUHg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 16:07:36 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E41EC20673;
        Fri, 21 Jun 2019 20:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561147655;
        bh=ukqowutmuU9gyBHIE/U8gJR8BfHRqDbWkLUfnaFsZmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EjqIYCl4osDDBf7dIOMPMUNFIkc5UKLXN07I6qSsORITlGdgHlWmPe/r9hq7bmf06
         NFIngFeCQK8wC1v8XkpZV3XdF2L0BiUVgBegsGHqNCctUT1j07to9jvh94CBqQUeU2
         iZuNAcuWuSWfx8TvmqGZMBaNLCxSl/rRcYv0UAUo=
Date:   Fri, 21 Jun 2019 15:07:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] pci: acpi: Read _DSM #5 from ACPI on root bridges
Message-ID: <20190621200733.GC127746@google.com>
References: <20190615002359.29577-1-benh@kernel.crashing.org>
 <20190615002359.29577-2-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615002359.29577-2-benh@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Match the subject line convention for this file, e.g.,

  PCI/ACPI: Evaluate PCI Boot Configuration _DSM

On Sat, Jun 15, 2019 at 10:23:57AM +1000, Benjamin Herrenschmidt wrote:
> This reads _DSM #5 value on root bridges, and when 0, sets a "preserve_config"
> flag in the host bridge structure indicating that the FW has requested that
> the existing configuration be preserved.

Wrap to 75 or so, so this doesn't overflow 80 columns when "git log" adds
its indentation.

> The upcoming spec change to define _DSM #5 for host bridges states that
> this should be the default behaviour, however doing so would be very
> intrusive and break existing setups. So we leave the default to be
> the existing behaviour.

This paragraph is incorrect.  Just remove it completely.

I would silently fix stuff like this if I applied these, but you can
do it if you repost these.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/acpi/pci_root.c  | 23 +++++++++++++++++++++++
>  include/linux/pci-acpi.h |  7 ++++---
>  include/linux/pci.h      |  2 ++
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 39f5d172e84f..217b3916f0f1 100644
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
> @@ -917,6 +918,28 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
>  		host_bridge->native_ltr = 0;
>  
> +	/*
> +	 * Invoke the PCI device specific method (_DSM) #5 'Ignore PCI Boot
> +	 * Configuration', on the host bridge. This tells us whether the
> +	 * firmware wants us to preserve or reassign the configuration of
> +	 * the PCI resource tree for this root bridge.
> +	 *
> +	 * For now, we only care about the function being present and returning
> +	 * 0, which we use to set a flag indicating that we'll preserve the
> +	 * FW configuration.
> +	 *
> +	 * This diverges from the spec which states that 0 is also the default
> +	 * in absence of _DSM #5. We do that today to work around the fact that
> +	 * our arm64 code doesn't implement the right defaults otherwise. This
> +	 * will be superseeded by a more thorough handling of _DSM #5 once the
> +	 * resource survey code has been consolidated further.
> +	 */
> +	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
> +	                        IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
> +	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0)
> +		host_bridge->preserve_config = 1;
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
> index dd436da7eccc..c50389b8df3c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -506,6 +506,8 @@ struct pci_host_bridge {
>  	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
>  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>  	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
> +        unsigned int    preserve_config:1;	/* Preserve FW resources setup */
> +
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>  			const struct resource *res,
> -- 
> 2.17.1
> 
