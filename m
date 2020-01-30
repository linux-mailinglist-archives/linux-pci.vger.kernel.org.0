Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3FAD14E4B3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2020 22:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgA3VO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jan 2020 16:14:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgA3VO4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jan 2020 16:14:56 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 821EA20708;
        Thu, 30 Jan 2020 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580418895;
        bh=2wnQ6Rrho4AngJz7Bc4Nb0XqZu72/TYXa3xrASVvrf0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JtgU+MeORY6h5cXL+BRlUGLdIHJVI3hXvmang9YdANpHKkkpTT1pQNvyPvzCZez1I
         v95t0MGRfsd5u/u9G2EmWWZ8NNfG99tJ3w13PS/U3OjM1UJ6LUYQ3xlju5t6gDkTj0
         f4c1tXWiEexHLrHxZb1Mbo/1pVBRDnVQTKcageKw=
Date:   Thu, 30 Jan 2020 15:14:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>,
        linux@yadro.com, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v7 20/26] PNP: Don't reserve BARs for PCI when enabled
 movable BARs
Message-ID: <20200130211453.GA127287@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129152937.311162-21-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 29, 2020 at 06:29:31PM +0300, Sergei Miroshnichenko wrote:
> When the Movable BARs feature is supported, the PCI subsystem is able to
> distribute existing BARs and allocate the new ones itself, without need to
> reserve gaps by BIOS.
> 
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pnp/system.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pnp/system.c b/drivers/pnp/system.c
> index 6950503741eb..16cd260a609d 100644
> --- a/drivers/pnp/system.c
> +++ b/drivers/pnp/system.c
> @@ -12,6 +12,7 @@
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> +#include <linux/pci.h>
>  #include <linux/kernel.h>
>  #include <linux/ioport.h>
>  
> @@ -58,6 +59,11 @@ static void reserve_resources_of_dev(struct pnp_dev *dev)
>  	struct resource *res;
>  	int i;
>  
> +#ifdef CONFIG_PCI
> +	if (pci_can_move_bars)
> +		return;
> +#endif

I don't understand this.  The reason this function exists is so we
keep track of the resources consumed by PNP devices and we can keep
from assigning those resources to other things like PCI devices.

Admittedly we currently only do this for PNP0C01 and PNP0C02 devices,
but we really should do it for all PNP devices.

Why does Movable BARs mean that we no longer need this information?
The whole point is that this information is needed *during* PCI
resource allocation, so I don't understand the idea that "because the
PCI subsystem is able to distribute existing BARs and allocate the new
ones itself", we don't need to know about PNP resources to avoid.

>  	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IO, i)); i++) {
>  		if (res->flags & IORESOURCE_DISABLED)
>  			continue;
> -- 
> 2.24.1
> 
