Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E98214F332
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 21:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgAaUbh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 15:31:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgAaUbd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jan 2020 15:31:33 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA42206D5;
        Fri, 31 Jan 2020 20:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580502692;
        bh=p827Q5rJt+Z3v7ehEotKL5YNiSbV7aRh7drRVCIBOAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t0Q/8nWEDHlpN1OsXFv3Xo4kuPpfSmZ3ivIMUQq60vsz2pl54a7XnyQ5X7Ru7X86H
         fAS66HjFchUnGOIsTDLFt62lDtGjxH+bgM0Detxu19Uj3pkdVHNS4KfMadqJI0JGvL
         x46QMeQLGHlK3ffEcmCBIilp0zl2Opa+fmEimtPM=
Date:   Fri, 31 Jan 2020 14:31:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>,
        linux@yadro.com
Subject: Re: [PATCH v7 17/26] PCI: hotplug: Ignore the MEM BAR offsets from
 BIOS/bootloader
Message-ID: <20200131203130.GA89598@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129152937.311162-18-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 29, 2020 at 06:29:28PM +0300, Sergei Miroshnichenko wrote:
> BAR allocation by BIOS/UEFI/bootloader/firmware may be non-optimal and
> it may even clash with the kernel's BAR assignment algorithm.
> 
> For example, sometimes BIOS doesn't reserve space for SR-IOV BARs, and
> this bridge window can neither extend (blocked by immovable BARs) nor
> move (the device itself is immovable).
> 
> With this patch the kernel will use its own methods of BAR allocating
> when possible, increasing the chances of successful boot and hotplug.
> 
> Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/probe.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bb584038d5b4..f8f643dac6d1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -306,6 +306,14 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  			 pos, (unsigned long long)region.start);
>  	}
>  
> +	if (pci_can_move_bars && res->start && !(res->flags & IORESOURCE_IO)) {
> +		pci_warn(dev, "ignore the current offset of BAR %llx-%llx\n",
> +			 l64, l64 + sz64 - 1);
> +		res->start = 0;
> +		res->end = sz64 - 1;
> +		res->flags |= IORESOURCE_SIZEALIGN;
> +	}
> +
>  	goto out;
>  
>  
> @@ -528,8 +536,10 @@ void pci_read_bridge_bases(struct pci_bus *child)
>  		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
>  
>  	pci_read_bridge_io(child);
> -	pci_read_bridge_mmio(child);
> -	pci_read_bridge_mmio_pref(child);
> +	if (!pci_can_move_bars) {
> +		pci_read_bridge_mmio(child);
> +		pci_read_bridge_mmio_pref(child);
> +	}

I mentioned this in another response, but I'll repeat it here to
comment on the code directly: I don't think we should have feature
tests like this "!pci_can_move_bars" scattered around, and I don't
want basic behaviors like reading bridge windows during enumeration to
depend on it.

There's no obvious reason why we should ignore bridge windows if we
support movable BARs.

>  	if (dev->transparent) {
>  		pci_bus_for_each_resource(child->parent, res, i) {
> @@ -2945,6 +2955,8 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>  		pci_bus_claim_resources(bus);
>  	} else {
>  		pci_bus_size_bridges(bus);
> +		if (pci_can_move_bars)
> +			pci_bus_update_realloc_range(bus);
>  		pci_bus_assign_resources(bus);
>  
>  		list_for_each_entry(child, &bus->children, node)
> -- 
> 2.24.1
> 
