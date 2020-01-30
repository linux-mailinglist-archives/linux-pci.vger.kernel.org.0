Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9309E14DCE4
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2020 15:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgA3Ojk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jan 2020 09:39:40 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52824 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3Ojk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2020 09:39:40 -0500
Received: from 79.184.253.19.ipv4.supernova.orange.pl (79.184.253.19) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 7a66a180fdbaa80f; Thu, 30 Jan 2020 15:39:38 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Stefan Roese <sr@denx.de>, linux@yadro.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v7 20/26] PNP: Don't reserve BARs for PCI when enabled movable BARs
Date:   Thu, 30 Jan 2020 15:39:37 +0100
Message-ID: <47893157.JDNA6rlMKs@kreacher>
In-Reply-To: <20200129152937.311162-21-s.miroshnichenko@yadro.com>
References: <20200129152937.311162-1-s.miroshnichenko@yadro.com> <20200129152937.311162-21-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, January 29, 2020 4:29:31 PM CET Sergei Miroshnichenko wrote:
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

Would it be a problem to define pci_can_move_bars() as a static inline
returning 'false' when CONFIG_PCI is unset?

The #ifdef wouldn't be needed here then.

> +
>  	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IO, i)); i++) {
>  		if (res->flags & IORESOURCE_DISABLED)
>  			continue;
> 




