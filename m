Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7B1393D2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 15:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgAMOkX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 09:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgAMOkX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 09:40:23 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2248420678;
        Mon, 13 Jan 2020 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578926422;
        bh=vg49eb33S7fB+YG6QOf85ALdklLUxkNgUhOPmtQJdfU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dcqjER0pKm/a8hvvJ0IAa/r1keer220JoZ8XO7qQhUppX4J6DNTGGK08+0dEx7EpR
         ILVWUHni397ITRJc1sRPX6I5Y8FyfeZWhEn25v5yvnkqY24yFcy9ktYTfVM6BPjeHK
         rTewfSQ9qrckYfoWqn9IlHWdHz136mMBDX2jSTx4=
Date:   Mon, 13 Jan 2020 08:40:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 1/5] x86/pci: Add a to_pci_sysdata helper
Message-ID: <20200113144020.GA71652@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578676873-6206-2-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 10, 2020 at 10:21:09AM -0700, Jon Derrick wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Various helpers need the pci_sysdata just to dereference a single field
> in it.  Add a little helper that returns the properly typed sysdata
> pointer to require a little less boilerplate code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [jonathan.derrick: added un-const cast]
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  arch/x86/include/asm/pci.h | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 90d0731..cf680c5 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -35,12 +35,15 @@ struct pci_sysdata {
>  
>  #ifdef CONFIG_PCI
>  
> +static inline struct pci_sysdata *to_pci_sysdata(struct pci_bus *bus)
> +{
> +	return bus->sysdata;
> +}
> +
>  #ifdef CONFIG_PCI_DOMAINS
>  static inline int pci_domain_nr(struct pci_bus *bus)
>  {
> -	struct pci_sysdata *sd = bus->sysdata;
> -
> -	return sd->domain;
> +	return to_pci_sysdata(bus)->domain;
>  }
>  
>  static inline int pci_proc_domain(struct pci_bus *bus)
> @@ -52,23 +55,20 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
>  static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
>  {
> -	struct pci_sysdata *sd = bus->sysdata;
> -
> -	return sd->fwnode;
> +	return to_pci_sysdata(bus)->fwnode;
>  }
>  
>  #define pci_root_bus_fwnode	_pci_root_bus_fwnode
>  #endif
>  
> +#if IS_ENABLED(CONFIG_VMD)
>  static inline bool is_vmd(struct pci_bus *bus)
>  {
> -#if IS_ENABLED(CONFIG_VMD)
> -	struct pci_sysdata *sd = bus->sysdata;
> -
> -	return sd->vmd_domain;
> +	return to_pci_sysdata(bus)->vmd_domain;
> +}
>  #else
> -	return false;
> -#endif
> +#define is_vmd(bus)		false
> +#endif /* CONFIG_VMD */
>  }

I think this patch leaves this stray close brace here (it's cleaned up
in the next patch, but looks like it will break bisection).

Also, when you fix this, can you update the subject lines?  There's a
mix of "x86/PCI" and "x86/pci" (the convention per "git log --oneline"
is "x86/PCI").

>  /* Can be used to override the logic in pci_scan_bus for skipping
> @@ -124,9 +124,7 @@ static inline void early_quirks(void) { }
>  /* Returns the node based on pci bus */
>  static inline int __pcibus_to_node(const struct pci_bus *bus)
>  {
> -	const struct pci_sysdata *sd = bus->sysdata;
> -
> -	return sd->node;
> +	return to_pci_sysdata((struct pci_bus *) bus)->node;
>  }
>  
>  static inline const struct cpumask *
> -- 
> 1.8.3.1
> 
