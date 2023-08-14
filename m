Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD9F77BC8C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjHNPLh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 11:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjHNPLf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 11:11:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC31B5;
        Mon, 14 Aug 2023 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692025891; x=1723561891;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yrI8FgN2t7/HwyhAJHFV6S5+hGMcqJPvVP2RKY6i5Ck=;
  b=DHYNafpK4qQXf/7UJj0wxITE5dVW+/MWHVafaBRW63gF5USV3bPAhdZP
   Rcv0IiMc1c+X8//z+ujunDFfngyykRVFsyp32lNuG2K8TdquLD4L0MxeI
   Bwsc3Fu+QfkouX/XXfay4W3b+cFNDFLV/LEaTT1Y3jHtPkvS0+pzlpIre
   M4t42L8XqsMFpjRGB+q9SdlmkmNIHX2JzPkqv3iVrrQMBhUeDp0U8AR4O
   1Da5uWqDb+Xtx+HIEUn4E02MyqNNGRyu9goeofWsdvbY76Mo3bLwVkrbZ
   71mwdlxH6eQ44Q0SnAvhV5gs3j+zrtgF6+ZZ2calvHFLzuAMhou5daFkD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="375773437"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="375773437"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 08:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="798850255"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="798850255"
Received: from lgarello-mobl.ger.corp.intel.com ([10.249.40.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 08:11:27 -0700
Date:   Mon, 14 Aug 2023 18:11:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
cc:     bhelgaas@google.com, pali@kernel.org, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] pci: introduce static_nr to indicate domain_nr from
 which IDA
In-Reply-To: <20230812122128.3409733-1-peng.fan@oss.nxp.com>
Message-ID: <ae888d-67c2-768-6985-e5cca038987e@linux.intel.com>
References: <20230812122128.3409733-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 12 Aug 2023, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
> 
> When pci node is created used an overlay, when the overlay is

pci -> PCI
created used -> created using

is created -> was created ? The current form with "is created" + "is 
reverted/destroyed" is contradictory.

Double "when" makes it hard to understand what you say. Perhaps convert 
the second when to "and".

> reverted/destroyed, the "linux,pci-domain" property is no longer
> existed

property no longer exists

>, so of_get_pci_domain_nr will return failure. Then
> of_pci_bus_release_domain_nr will actually use the dynamic IDA,
> even if the IDA was allocated in static IDA.
> 
> Introduce a static_nr field in pci_bus to indicate the IDA
> is in dynamic or static IDA to address the upper issue.

I'd say:

... to indicated whether the IDA is a dynamic or static in order to
free the correct one.

> Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
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
> index eeb2e6f6130f..6dd16e069ab8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -665,6 +665,7 @@ struct pci_bus {
>  	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  	int		domain_nr;
> +	unsigned int	static_nr:1;
>  #endif
>  
>  	char		name[48];

If you put it into where the other unsigned int xx:1's are in the struct, 
it won't increase the size of the struct (but the downside is that they're 
no longer next to each other).

-- 
 i.

