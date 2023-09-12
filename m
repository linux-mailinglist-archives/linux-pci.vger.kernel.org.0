Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C33B79DBCC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 00:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjILWWX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Sep 2023 18:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjILWWW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 18:22:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7778010C9;
        Tue, 12 Sep 2023 15:22:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C761AC433C7;
        Tue, 12 Sep 2023 22:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694557338;
        bh=7KAGH2JgSasd3CprQgU/M614YHilY5u3Q+EE4tUlaqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QeXQFOPGQZjInp9aMBFSk8tzNJ1fMB88/ThfyhE3oU3qJrqghIu3WGhGZkznSzZyh
         n+sBYVsVUa4vuFqanZikE0ZbN53sHL/zxY+rxbH+vjC5wBLKk212CU9AqPvRpB5lZ+
         t5TcTup9tfEBE9uGG2Smy9ifPbUJic5B8IuIcT1YRTjqZNjwdWM1nNiPFrpnruQNCv
         qPh71bcz2GAdl0BFvNLB0ICBftl9pp/HVm6AuFerfveliWv/LkNy8DRtj4NY9cT5jf
         Y4XUIY/B6K9Nw9qN59iHIje+4qMczWgGjRVTXlwrEeAoiIc0rU5/BjFm8/FlEMFmnj
         Gprdowurx8njg==
Date:   Tue, 12 Sep 2023 17:22:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bhelgaas@google.com, pali@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Message-ID: <20230912222215.GA412293@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815013744.45652-1-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 15, 2023 at 09:37:44AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When PCI node was created using an overlay and the overlay is
> reverted/destroyed, the "linux,pci-domain" property no longer
> exists, so of_get_pci_domain_nr will return failure.

I'm not familiar with how overlays work.  What's the call path where
the overlay is removed?  I see an of_overlay_remove(), but I don't see
any callers except test cases.

I guess the problem happens in a PCI host bridge remove path, e.g.,

  pci_host_common_remove
    pci_remove_root_bus
      pci_bus_release_domain_nr
        of_pci_bus_release_domain_nr

But I don't know how that's related to the overlay removal.

Is this an ordering issue?  It seems possibly problematic that the OF
overlay is destroyed before the device it describes (e.g., the host
bridge) is removed.  I would expect the device to be removed before
the description of the device is removed.

> Then of_pci_bus_release_domain_nr will actually use the dynamic IDA,
> even if the IDA was allocated in static IDA.
>
> Introduce a static_nr field in pci_bus to indicate whether the
> IDA is a dynamic or static in order to free the correct one.
> 
> Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Update commit message
>  Move static_nr:1 to stay besides others :1 fields.
> 
>  drivers/pci/pci.c   | 22 ++++++++++++++--------
>  include/linux/pci.h |  1 +
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..5c98502bcda6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6881,10 +6881,10 @@ static void of_pci_reserve_static_domain_nr(void)
>  	}
>  }
>  
> -static int of_pci_bus_find_domain_nr(struct device *parent)
> +static int of_pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
>  {
>  	static bool static_domains_reserved = false;
> -	int domain_nr;
> +	int domain_nr, ret;
>  
>  	/* On the first call scan device tree for static allocations. */
>  	if (!static_domains_reserved) {
> @@ -6892,6 +6892,8 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
>  		static_domains_reserved = true;
>  	}
>  
> +	bus->static_nr = 0;
> +
>  	if (parent) {
>  		/*
>  		 * If domain is in DT, allocate it in static IDA.  This
> @@ -6899,10 +6901,14 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
>  		 * in DT.
>  		 */
>  		domain_nr = of_get_pci_domain_nr(parent->of_node);
> -		if (domain_nr >= 0)
> -			return ida_alloc_range(&pci_domain_nr_static_ida,
> -					       domain_nr, domain_nr,
> -					       GFP_KERNEL);
> +		if (domain_nr >= 0) {
> +			ret = ida_alloc_range(&pci_domain_nr_static_ida,
> +					      domain_nr, domain_nr, GFP_KERNEL);
> +			if (ret >= 0)
> +				bus->static_nr = 1;
> +
> +			return ret;
> +		}
>  	}
>  
>  	/*
> @@ -6920,7 +6926,7 @@ static void of_pci_bus_release_domain_nr(struct pci_bus *bus, struct device *par
>  		return;
>  
>  	/* Release domain from IDA where it was allocated. */
> -	if (of_get_pci_domain_nr(parent->of_node) == bus->domain_nr)
> +	if (bus->static_nr)
>  		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
>  	else
>  		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
> @@ -6928,7 +6934,7 @@ static void of_pci_bus_release_domain_nr(struct pci_bus *bus, struct device *par
>  
>  int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
>  {
> -	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
> +	return acpi_disabled ? of_pci_bus_find_domain_nr(bus, parent) :
>  			       acpi_pci_bus_find_domain_nr(bus);
>  }
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index eeb2e6f6130f..222a1729ea7e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -677,6 +677,7 @@ struct pci_bus {
>  	struct bin_attribute	*legacy_mem;	/* Legacy mem */
>  	unsigned int		is_added:1;
>  	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
> +	unsigned int		static_nr:1;
>  };
>  
>  #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
> -- 
> 2.37.1
> 
