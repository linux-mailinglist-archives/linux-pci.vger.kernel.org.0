Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5851DD76C
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 21:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgEUTlS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 15:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgEUTlS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 15:41:18 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74A8A2065F;
        Thu, 21 May 2020 19:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590090077;
        bh=V7Rxedh2MenOwI8XK4KoWriB9ieXIxOg9p/fYNUmu6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DGrKWPYF4T61W/bPMJjljuNf8dXTHk0f6MkZK2ldwJgILEIsVJksvKR9Ef0tXf/Mm
         /v1VApdxpv0cJTjhytbqfnysZVkWTwx8Gte2VacSGA8MWFcyB34b+jg8pX6rCQInJz
         56CdXIhZgakIXA9UioojzKLvEfweY5Zp+71czsoo=
Date:   Thu, 21 May 2020 14:41:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Xen Development List <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, x86@kernel.org,
        sstabellini@kernel.org, Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] x86/xen: drop an unused parameter gsi_override
Message-ID: <20200521194115.GA1169412@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428153640.76476-1-wei.liu@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 28, 2020 at 03:36:40PM +0000, Wei Liu wrote:
> All callers within the same file pass in -1 (no override).
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>

Applied to pci/virtualization for v5.8, thanks!

I don't see anything else in linux-next that touches this file, but if
somebody wants to merge this via another tree, just let me know.

> ---
>  arch/x86/pci/xen.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index 91220cc25854..e3f1ca316068 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -60,8 +60,7 @@ static int xen_pcifront_enable_irq(struct pci_dev *dev)
>  }
>  
>  #ifdef CONFIG_ACPI
> -static int xen_register_pirq(u32 gsi, int gsi_override, int triggering,
> -			     bool set_pirq)
> +static int xen_register_pirq(u32 gsi, int triggering, bool set_pirq)
>  {
>  	int rc, pirq = -1, irq = -1;
>  	struct physdev_map_pirq map_irq;
> @@ -94,9 +93,6 @@ static int xen_register_pirq(u32 gsi, int gsi_override, int triggering,
>  		name = "ioapic-level";
>  	}
>  
> -	if (gsi_override >= 0)
> -		gsi = gsi_override;
> -
>  	irq = xen_bind_pirq_gsi_to_irq(gsi, map_irq.pirq, shareable, name);
>  	if (irq < 0)
>  		goto out;
> @@ -112,12 +108,12 @@ static int acpi_register_gsi_xen_hvm(struct device *dev, u32 gsi,
>  	if (!xen_hvm_domain())
>  		return -1;
>  
> -	return xen_register_pirq(gsi, -1 /* no GSI override */, trigger,
> +	return xen_register_pirq(gsi, trigger,
>  				 false /* no mapping of GSI to PIRQ */);
>  }
>  
>  #ifdef CONFIG_XEN_DOM0
> -static int xen_register_gsi(u32 gsi, int gsi_override, int triggering, int polarity)
> +static int xen_register_gsi(u32 gsi, int triggering, int polarity)
>  {
>  	int rc, irq;
>  	struct physdev_setup_gsi setup_gsi;
> @@ -128,7 +124,7 @@ static int xen_register_gsi(u32 gsi, int gsi_override, int triggering, int polar
>  	printk(KERN_DEBUG "xen: registering gsi %u triggering %d polarity %d\n",
>  			gsi, triggering, polarity);
>  
> -	irq = xen_register_pirq(gsi, gsi_override, triggering, true);
> +	irq = xen_register_pirq(gsi, triggering, true);
>  
>  	setup_gsi.gsi = gsi;
>  	setup_gsi.triggering = (triggering == ACPI_EDGE_SENSITIVE ? 0 : 1);
> @@ -148,7 +144,7 @@ static int xen_register_gsi(u32 gsi, int gsi_override, int triggering, int polar
>  static int acpi_register_gsi_xen(struct device *dev, u32 gsi,
>  				 int trigger, int polarity)
>  {
> -	return xen_register_gsi(gsi, -1 /* no GSI override */, trigger, polarity);
> +	return xen_register_gsi(gsi, trigger, polarity);
>  }
>  #endif
>  #endif
> @@ -491,7 +487,7 @@ int __init pci_xen_initial_domain(void)
>  		if (acpi_get_override_irq(irq, &trigger, &polarity) == -1)
>  			continue;
>  
> -		xen_register_pirq(irq, -1 /* no GSI override */,
> +		xen_register_pirq(irq,
>  			trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE,
>  			true /* Map GSI to PIRQ */);
>  	}
> -- 
> 2.20.1
> 
