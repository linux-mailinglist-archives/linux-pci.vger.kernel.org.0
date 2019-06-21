Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE054EB52
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFUO54 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 10:57:56 -0400
Received: from foss.arm.com ([217.140.110.172]:33990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfFUO54 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 10:57:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC8D728;
        Fri, 21 Jun 2019 07:57:55 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC1B63F575;
        Fri, 21 Jun 2019 07:57:54 -0700 (PDT)
Date:   Fri, 21 Jun 2019 15:57:52 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] arm64: pci: acpi: Preserve PCI resources
 configuration when asked by ACPI
Message-ID: <20190621145752.GC21807@e121166-lin.cambridge.arm.com>
References: <20190615002359.29577-1-benh@kernel.crashing.org>
 <20190615002359.29577-4-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615002359.29577-4-benh@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 15, 2019 at 10:23:59AM +1000, Benjamin Herrenschmidt wrote:
> When _DSM #5 returns 0 for a host bridge, we need to claim the existing

Nit: technically we do not know whether it is a _DSM #5 setting
hb->preserve_config or not, it is just a matter of rewording the log.

> resources rather than reassign everything.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/arm64/kernel/pci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1419b1b4e9b9..a2c608a3fc41 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -168,6 +168,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	struct acpi_pci_generic_root_info *ri;
>  	struct pci_bus *bus, *child;
>  	struct acpi_pci_root_ops *root_ops;
> +	struct pci_host_bridge *hb;
>  
>  	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
>  	if (!ri)
> @@ -193,6 +194,16 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	if (!bus)
>  		return NULL;
>  
> +	hb = pci_find_host_bridge(bus);

to_pci_host_bridge(bus->bridge) would do but it is probably better to
leave it as-is.

> +
> +	/* If ACPI tells us to preserve the resource configuration, claim now */
> +	if (hb->preserve_config)
> +		pci_bus_claim_resources(bus);
> +
> +	/*
> +	 * Assign whatever was left unassigned. If we didn't claim above, this will
> +	 * reassign everything.
> +	 */
>  	pci_assign_unassigned_root_bus_resources(bus);
>  
>  	list_for_each_entry(child, &bus->children, node)

This is fine as far as we acknowledge that claiming resources
on a bus is what should be done to make them immutable.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
