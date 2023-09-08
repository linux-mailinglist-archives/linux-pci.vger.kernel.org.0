Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FC1799269
	for <lists+linux-pci@lfdr.de>; Sat,  9 Sep 2023 00:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbjIHWtL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 18:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344249AbjIHWtK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 18:49:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5091FFA;
        Fri,  8 Sep 2023 15:49:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C72AC433C7;
        Fri,  8 Sep 2023 22:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694213340;
        bh=btnIsvilFbOoH30ASsTBGjOV/60yoK1+Mby6aAehNGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bbiA1FQluRk2v7MTczGdx3LpMVqsUilc6G/cEpDWaIRu0NQ4PUsOiqu3YFFc8jI9v
         1R7mBWxaTKNEz3/Nt0YKb8vTbDJk4sC+kRhHX8LdOVrQKQeWRsB5ZxjqTepLpljZt6
         lzfobxxdL0SN2KQS7ygY4tIRPjxXIhahZaY5COA/douDQoWN0KqbL9JxSqPo337jjr
         pYbRnQeb/dYdzwmea8EpcgwXCuhfyRtBvf+xDJLu4qwditnI/AhXSqawr0Y6bOj4fU
         QUKHVTOsO0N8obwByx3jvmOvQXO0cfy0p5AHOdewbpztHHAPf/pAChlOiBuptgtfAl
         V2r6Fh/GXzcGw==
Date:   Fri, 8 Sep 2023 17:48:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bhelgaas@google.com, pali@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Message-ID: <20230908224858.GA306960@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815013744.45652-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, run "git log --oneline drivers/pci/pci.c" and match the
capitalization style.

On Tue, Aug 15, 2023 at 09:37:44AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When PCI node was created using an overlay and the overlay is
> reverted/destroyed, the "linux,pci-domain" property no longer
> exists, so of_get_pci_domain_nr will return failure. Then
> of_pci_bus_release_domain_nr will actually use the dynamic IDA,
> even if the IDA was allocated in static IDA.

Is there any user-visible effect of this issue?  For example, is there
any hint in the dmesg log?  If so, we should include that hint here.

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

There are a couple things that make this a little messy:

  1) The "static_nr" name isn't great because the struct pci_bus
  declaration doesn't have any clue about what it's for.  "nr" doesn't
  suggest "PCI domain".

  2) More importantly, the "static_nr = 1" assignment here doesn't fit
  with the design where pci_bus_find_domain_nr() allocates the domain
  number and pci_register_host_bridge() stores it in the struct
  pci_bus.  The bus->domain_nr assignment and the bus->static_nr
  assignment really should be in the same place.

  I do see the problem that it's hard to return the "static alloc"
  info back up the call chain to pci_register_host_bridge() where
  bus->domain_nr is assigned, but setting bus->static_nr here in
  of_pci_bus_find_domain_nr() seems a little kludgy.  I don't have any
  good ideas yet, but I'll think about it.

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
