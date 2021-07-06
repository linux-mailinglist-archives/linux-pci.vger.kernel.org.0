Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A623BC95D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 12:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhGFKT6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 06:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhGFKT5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jul 2021 06:19:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C36C061574;
        Tue,  6 Jul 2021 03:17:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p16so9945356lfc.5;
        Tue, 06 Jul 2021 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=X2D7Bt2IdjBq2a78rwwkGP6XebZQeXoiwYkPeKto0j8=;
        b=Lt4R+kCCujrQVA3cpbS67lwcxc2vIlxnul/nibztyaAEU3duKuC2Y936IM6k6SMDMz
         svzSv/0uCnPJU/lqmSh7oOsW/FE4jhRGs4jCwPDI6Sn9Ogvpr5I1Eiv3EZHxW7rFn7AS
         uJ10bRE5pZJ/R5mkLRiA7XHQFK/sAHGYtCdGri2h5SzKnsyBT6CtYUtvYMWG3R8vW4jf
         7Ajof+7uCJZfWuxU5E086A4+7pkS3JPMGICEbJzHsqOtVcPn7mWYFD1rQHM40yIGv9Zh
         3NDTidg/h9UeScPw+i0MKKXv09r9oO6gBlBM2Sbv6qIwqPNup799mEQtd44d79tRs1TY
         hzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=X2D7Bt2IdjBq2a78rwwkGP6XebZQeXoiwYkPeKto0j8=;
        b=MKggpyLVWk19WaJmmPd/h2wofD0bV7dDmDAiNob8tJomSba2wXjzAA/tBafqsnM4L/
         GUdGQ69+mRlyf3uPcPSqn8L17iKo77hVLa7piOpPgmZt8wjbhSnwqerB1uKr9eSFZAN9
         1qC2l0V9gwngxeGbjNX+QRh43zaDFpmVvk07zTGIvhCaKmwEujGAsezp1xqO1tYjdAq+
         Kcbqhq9tpwJK2BUmO616NdQmQzeX3V8yIdFmvQ/rfXvE8wqiVDfmTIkQPdlWMzJaEKdH
         n95GsntsQj35VqPF2YkfCXjHsWPtowSc5vbL6iezsOl62Pv471LjUQuS+ZzSm/Mu6Dlr
         nonw==
X-Gm-Message-State: AOAM532Ya3+192rjnwYmD6gXRUXayatBepD8wwBYzis+Fyoj8RhjB+TT
        IVNtkPoZEYO90NyEXpsmouU=
X-Google-Smtp-Source: ABdhPJzMkogRCYNUrvuPKFu422vA1OVRU//FC11GeAGypRdDxEhgIxaL0z1gX2o5C7SMQJRYv1oBEw==
X-Received: by 2002:a19:c752:: with SMTP id x79mr14393053lff.644.1625566636268;
        Tue, 06 Jul 2021 03:17:16 -0700 (PDT)
Received: from [192.168.0.91] ([188.242.181.97])
        by smtp.googlemail.com with ESMTPSA id i6sm1352589lfe.164.2021.07.06.03.17.15
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 06 Jul 2021 03:17:15 -0700 (PDT)
Message-ID: <60E43052.8040802@gmail.com>
Date:   Tue, 06 Jul 2021 13:28:34 +0300
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
Subject: Re: [PATCH] x86/PCI: Handle PIRQ routing tables with no router device
 given
References: <alpine.DEB.2.21.2107051133010.33206@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2107051133010.33206@angie.orcam.me.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Maciej,

05.07.2021 13:46, Maciej W. Rozycki:
> PIRQ routing tables provided by the PCI BIOS usually specify the PCI
> vendor:device ID as well as the bus address of the device implementing
> the PIRQ router, e.g.:
[...]
> linux-x86-pirq-router-nodev.diff

This one throws a panic in bus_find_device() here.
I can not yet get a good printout because scrollback does not work.
Maybe it is because of 4.14 kernel, and in order to apply it I had to 
change pci_get_domain_bus_and_slot back to pci_get_bus_and_slot.
I'll try to also test with 5.x kernel later today.


Thank you,

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
> @@ -930,27 +952,28 @@ static void __init pirq_find_router(stru
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
> +		if (pirq_try_router(r, rt, dev))
> +			pirq_router_dev = dev;
> +	} else {
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

