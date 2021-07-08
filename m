Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222A63C16E7
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhGHQQd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhGHQQd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jul 2021 12:16:33 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B700C061574;
        Thu,  8 Jul 2021 09:13:50 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z9so3337129ljm.2;
        Thu, 08 Jul 2021 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=L79SJAnjkEQ4XmnZyjSoa+Biso4xOMpboqeiniJwlu0=;
        b=MEgBNmeqyv12qfNYpV9gw15Ayl1fH0d1En8IF25jT8zp2XGVaaroyQ3LKdFVnahWyj
         AD8sgLfEMUAW23uUlTTyTnJyxthqef5e8/N/FYX/HYGIp9P/Eij5yieVljRmWSyvuSvK
         r6iAHzQUGf7jqJy3ETRp/vAaH7zok5T2YuQTPFkV9kwb6exlRQWo2bo2V9SSX7XNzbw+
         M+6n+NPrxqand44H5etPUz5OR32/E9iJMDeDxRrPSmOFQ52/bPoV5W30j+L9KdqWaA+P
         MSQdhs4FFdox4EBsqlrAQTBKpZjdtDvGKxRMdohlRfUFOXr0bIJpxkSHEdeZGWaHLYJ8
         5/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=L79SJAnjkEQ4XmnZyjSoa+Biso4xOMpboqeiniJwlu0=;
        b=fPUPRe5mlm3pIAotFoKOjjV57+jT/SYNzgUYuNEtHVo9I2R51mXe3hYTlrK8PANKl8
         TJGFTfK1/wDd86m/U3ePLpg36TANFYbUEMlOie+avB6MMt/vfVdAkJZvvitodga47WE4
         EQcxfpxPa9AIYS5T6twzjdZMni/pm4tAlGlze6prs7MIgAf7gnWBFwr2c0HdnBxTyXm/
         vyaJa0oNjOTAaY0Z9SunBKfIuVd9JDc/BA3k83XF9u6iIfPlaZfYd/dlZfOQgM8gmIi1
         FIxi87A4sdTpXICXCP76/gkJ/f/KJobAWDY/g2WRDEExSgt5FVo09BRRzsOhHg6MTqxI
         Pg3w==
X-Gm-Message-State: AOAM533R8X2Eq52igRZTbvKgeYmfF0EEnKRxWrU1ka/tm2jkXh0wvlb5
        kVqzZ84eq+D+76v5rQuHQvM=
X-Google-Smtp-Source: ABdhPJwqF9TNW7DHwAQHsl3587BSwQm9vifyWtoMPYB/f6O+ZyKk1TyPio80EwSPjWU+P9cHhAOJag==
X-Received: by 2002:a2e:9bd1:: with SMTP id w17mr24638107ljj.316.1625760827360;
        Thu, 08 Jul 2021 09:13:47 -0700 (PDT)
Received: from [192.168.0.91] ([188.242.181.97])
        by smtp.googlemail.com with ESMTPSA id bn30sm277876ljb.87.2021.07.08.09.13.43
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 08 Jul 2021 09:13:44 -0700 (PDT)
Message-ID: <60E726E2.2050104@gmail.com>
Date:   Thu, 08 Jul 2021 19:25:06 +0300
From:   Nikolai Zhubr <zhubr.2@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/PCI: Handle PIRQ routing tables with no router
 device given
References: <alpine.DEB.2.21.2107061320570.1711@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2107061320570.1711@angie.orcam.me.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Maciej,

06.07.2021 14:30, Maciej W. Rozycki:
> Changes from v1:
>
> - preinitialise `dev' in `pirq_find_router' for `for_each_pci_dev',
>
> - avoid calling `pirq_try_router' with null `dev'.
> ---
>   arch/x86/pci/irq.c |   64 ++++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 44 insertions(+), 20 deletions(-)
>
> linux-x86-pirq-router-nodev.diff

Success!
Here is new log:

https://pastebin.com/QXaUsCV4

and --

# 8259A.pl
irq 0: 00, edge
irq 1: 00, edge
irq 2: 00, edge
irq 3: 00, edge
irq 4: 00, edge
irq 5: 00, edge
irq 6: 00, edge
irq 7: 00, edge
irq 8: 02, edge
irq 9: 02, level
irq 10: 02, edge
irq 11: 02, edge
irq 12: 02, edge
irq 13: 02, edge
irq 14: 02, edge
irq 15: 02, edge

Some notes:
- please ignore the backtrace from 8139too, it is expected and will be 
worked on later;
- the message line " -> edge" looks somewhat strange, my guess is it 
might be a small unintentional leftover of some bigger and more detailed 
message/debugging, anyway, I'd humbly suppose "Triggering mode adjusted" 
would look better.

Thank you!


Regards,
Nikolai


> Index: linux-macro-ide-tty/arch/x86/pci/irq.c
> ===================================================================
> --- linux-macro-ide-tty.orig/arch/x86/pci/irq.c
> +++ linux-macro-ide-tty/arch/x86/pci/irq.c
> @@ -908,10 +908,32 @@ static struct pci_dev *pirq_router_dev;
>    *	chipset" ?
>    */
>
> +static bool __init pirq_try_router(struct irq_router *r,
> +				   struct irq_routing_table *rt,
> +				   struct pci_dev *dev)
> +{
> +	struct irq_router_handler *h;
> +
> +	DBG(KERN_DEBUG "PCI: Trying IRQ router for [%04x:%04x]\n",
> +	    dev->vendor, dev->device);
> +
> +	for (h = pirq_routers; h->vendor; h++) {
> +		/* First look for a router match */
> +		if (rt->rtr_vendor == h->vendor&&
> +		    h->probe(r, dev, rt->rtr_device))
> +			return true;
> +		/* Fall back to a device match */
> +		if (dev->vendor == h->vendor&&
> +		    h->probe(r, dev, dev->device))
> +			return true;
> +	}
> +	return false;
> +}
> +
>   static void __init pirq_find_router(struct irq_router *r)
>   {
>   	struct irq_routing_table *rt = pirq_table;
> -	struct irq_router_handler *h;
> +	struct pci_dev *dev;
>
>   #ifdef CONFIG_PCI_BIOS
>   	if (!rt->signature) {
> @@ -930,27 +952,29 @@ static void __init pirq_find_router(stru
>   	DBG(KERN_DEBUG "PCI: Attempting to find IRQ router for [%04x:%04x]\n",
>   	    rt->rtr_vendor, rt->rtr_device);
>
> -	pirq_router_dev = pci_get_domain_bus_and_slot(0, rt->rtr_bus,
> -						      rt->rtr_devfn);
> -	if (!pirq_router_dev) {
> -		DBG(KERN_DEBUG "PCI: Interrupt router not found at "
> -			"%02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
> -		return;
> +	/* Use any vendor:device provided by the routing table or try all.  */
> +	if (rt->rtr_vendor) {
> +		dev = pci_get_domain_bus_and_slot(0, rt->rtr_bus,
> +						  rt->rtr_devfn);
> +		if (dev&&  pirq_try_router(r, rt, dev))
> +			pirq_router_dev = dev;
> +	} else {
> +		dev = NULL;
> +		for_each_pci_dev(dev) {
> +			if (pirq_try_router(r, rt, dev)) {
> +				pirq_router_dev = dev;
> +				break;
> +			}
> +		}
>   	}
>
> -	for (h = pirq_routers; h->vendor; h++) {
> -		/* First look for a router match */
> -		if (rt->rtr_vendor == h->vendor&&
> -			h->probe(r, pirq_router_dev, rt->rtr_device))
> -			break;
> -		/* Fall back to a device match */
> -		if (pirq_router_dev->vendor == h->vendor&&
> -			h->probe(r, pirq_router_dev, pirq_router_dev->device))
> -			break;
> -	}
> -	dev_info(&pirq_router_dev->dev, "%s IRQ router [%04x:%04x]\n",
> -		 pirq_router.name,
> -		 pirq_router_dev->vendor, pirq_router_dev->device);
> +	if (pirq_router_dev)
> +		dev_info(&pirq_router_dev->dev, "%s IRQ router [%04x:%04x]\n",
> +			 pirq_router.name,
> +			 pirq_router_dev->vendor, pirq_router_dev->device);
> +	else
> +		DBG(KERN_DEBUG "PCI: Interrupt router not found at "
> +		    "%02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
>
>   	/* The device remains referenced for the kernel lifetime */
>   }
>

