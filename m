Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C4D7526CF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjGMPZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjGMPZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 11:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DAC1FD6;
        Thu, 13 Jul 2023 08:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6706D61881;
        Thu, 13 Jul 2023 15:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB4CC433C7;
        Thu, 13 Jul 2023 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689261946;
        bh=7VIAFpE7UhHFxQZU5H0rEJICPl8n8m4rhnC5KAKiqgg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=prE5FLdbBTLejc0h1uZgpzQeMQtg3bhmc/2zA1Cu0h7FIQJXQevO52b8n1RvHbHeY
         CKEcO2OGbXUln72n8msQ8rMBVXjH9IFy/t3oE286Qt7kBtr7VAE3b7pvrqFeMjeB+2
         hrj7kIU7Lj/X+K3O0Cok7Wdc7HDIgWi+8EO4pKacFlybhRIBVNWA2sgaxcMBAVDkF+
         leKgIikWStHYai4U0OZJkkO6PG3ClerhWAWhY7TpqpdGMBaRcqn9blwFmUOw7n8i72
         t2dbuUs2WRGt5N2CSEyR6rSVPsjzDbo/KUqyzi1ULT4SBXnA2TXY5pRVD8K8HjV8Y2
         awqbN1w4lkvmQ==
Date:   Thu, 13 Jul 2023 10:25:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 1/1] range.h: Move resource API and constant to
 respective headers
Message-ID: <20230713152544.GA317144@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710131142.32284-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 10, 2023 at 04:11:42PM +0300, Andy Shevchenko wrote:
> range.h works with struct range data type. The resource_size_t
> is an alien here. Move the related pieces to the respective
> headers and rename MAX_RESOURCE using pattern ${TYPE}_MAX.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

No objection from me, although I might include more specifics in the
commit log, e.g., (1) move cap_resource() implementation into its only
user, and (2) rename and move RESOURCE_SIZE_MAX to limits.h.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  arch/mips/cavium-octeon/setup.c | 2 +-
>  arch/x86/pci/amd_bus.c          | 8 ++++++++
>  arch/x86/pci/bus_numa.c         | 2 +-
>  include/linux/limits.h          | 2 ++
>  include/linux/range.h           | 8 --------
>  5 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index c5561016f577..1ad2602a0383 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -1240,7 +1240,7 @@ static int __init octeon_no_pci_init(void)
>  	 */
>  	octeon_dummy_iospace = vzalloc(IO_SPACE_LIMIT);
>  	set_io_port_base((unsigned long)octeon_dummy_iospace);
> -	ioport_resource.start = MAX_RESOURCE;
> +	ioport_resource.start = RESOURCE_SIZE_MAX;
>  	ioport_resource.end = 0;
>  	return 0;
>  }
> diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
> index dd40d3fea74e..631512f7ec85 100644
> --- a/arch/x86/pci/amd_bus.c
> +++ b/arch/x86/pci/amd_bus.c
> @@ -51,6 +51,14 @@ static struct pci_root_info __init *find_pci_root_info(int node, int link)
>  	return NULL;
>  }
>  
> +static inline resource_size_t cap_resource(u64 val)
> +{
> +	if (val > RESOURCE_SIZE_MAX)
> +		return RESOURCE_SIZE_MAX;
> +
> +	return val;
> +}
> +
>  /**
>   * early_root_info_init()
>   * called before pcibios_scan_root and pci_scan_bus
> diff --git a/arch/x86/pci/bus_numa.c b/arch/x86/pci/bus_numa.c
> index 2752c02e3f0e..e4a525e59eaf 100644
> --- a/arch/x86/pci/bus_numa.c
> +++ b/arch/x86/pci/bus_numa.c
> @@ -101,7 +101,7 @@ void update_res(struct pci_root_info *info, resource_size_t start,
>  	if (start > end)
>  		return;
>  
> -	if (start == MAX_RESOURCE)
> +	if (start == RESOURCE_SIZE_MAX)
>  		return;
>  
>  	if (!merge)
> diff --git a/include/linux/limits.h b/include/linux/limits.h
> index f6bcc9369010..38eb7f6f7e88 100644
> --- a/include/linux/limits.h
> +++ b/include/linux/limits.h
> @@ -10,6 +10,8 @@
>  #define SSIZE_MAX	((ssize_t)(SIZE_MAX >> 1))
>  #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
>  
> +#define RESOURCE_SIZE_MAX	((resource_size_t)~0)
> +
>  #define U8_MAX		((u8)~0U)
>  #define S8_MAX		((s8)(U8_MAX >> 1))
>  #define S8_MIN		((s8)(-S8_MAX - 1))
> diff --git a/include/linux/range.h b/include/linux/range.h
> index 7efb6a9b069b..6ad0b73cb7ad 100644
> --- a/include/linux/range.h
> +++ b/include/linux/range.h
> @@ -31,12 +31,4 @@ int clean_sort_range(struct range *range, int az);
>  
>  void sort_range(struct range *range, int nr_range);
>  
> -#define MAX_RESOURCE ((resource_size_t)~0)
> -static inline resource_size_t cap_resource(u64 val)
> -{
> -	if (val > MAX_RESOURCE)
> -		return MAX_RESOURCE;
> -
> -	return val;
> -}
>  #endif
> -- 
> 2.40.0.1.gaa8946217a0b
> 
