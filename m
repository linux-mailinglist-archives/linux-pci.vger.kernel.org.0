Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B6248CAD5
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 19:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356142AbiALSUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 13:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242533AbiALSUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 13:20:19 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C753CC06173F;
        Wed, 12 Jan 2022 10:20:18 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so3482134otu.10;
        Wed, 12 Jan 2022 10:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZvB+CEdChURMXAHuDmOSkMpFFJ4X5ovH1jaxtFrvRrk=;
        b=g6V/QoTdykhGjHahjF7nqoFhNk7o8ZcOIqGYKfjh/i1uGnTmeCveiy2b7YjLkepvLt
         yqzq+BXTRlilwOFVZ4TGa0K+JZ1n8r1QdlOYC95PsZWFO251bAsBbx+Tp5ZQzm4AhyJb
         gkrdW4xfdRFajUvpjOuNXxbf+BXpRCDR3mBvulDCkTN05P3dfAZuPknii3VJ4dN9EVKp
         Neuhh9zrf/FShI67mZOz/3LtbNU5aec1Pq2yEieItEFNyteHZwK976E2hHeka8Nk4dNa
         /5FYc7qBZ2n44tlzRV90gb/2BcMAB0lX93RnlorKrirCXYohkuSf48AUEd1j4smjJkh0
         bqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZvB+CEdChURMXAHuDmOSkMpFFJ4X5ovH1jaxtFrvRrk=;
        b=Z4bUTP8N+oPO3B6OeahsTEZctKXWzbaxBuuySLjjJAQyUTqQNdxcWZRhtFceuy7RzJ
         3Rpmk/fXnEWSiQFpGfpzhW58zXGwlXOiRbmJwRjNWx039JX/D1JOwKdB7E7+vYRAcNcT
         WU1yQCMmW/DtLSk94j7q6lDf8gxfynyKaGq1x7vDtYLuXWQzCFxEb+3pwABkNeEzGrxg
         8+jTvDC4ShiP0cB/YW0tRN/UnlWwyiX0B8h/m4sJXtFDzeG8wHdB0s87wKVbNDr/7bUj
         rVy7nzqc6pUJICRFE/kxzNHxw8FRIShLZqAYKnEiYXA1spKi2fBuNBf+DDvVONCE2nW/
         GAPw==
X-Gm-Message-State: AOAM532qB9jfzPzJfltn97bmfYc8gd8hBi6ayG/hnIeGwBaKgQkGVfyU
        sY0o5Xl6PAIwbCRJtLvH+ntXBnfqXm0=
X-Google-Smtp-Source: ABdhPJyL0LdSxSZn72A1bC9Afu4lns83dD3YXCGphHtDfnvJfMeBy1Nu1Cjiw8vkvHOhXykmH58zBA==
X-Received: by 2002:a9d:74ca:: with SMTP id a10mr768819otl.222.1642011618160;
        Wed, 12 Jan 2022 10:20:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u10sm50601otk.0.2022.01.12.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:20:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Jan 2022 10:20:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] MIPS: ralink: implement
 'pcibios_root_bridge_prepare()'
Message-ID: <20220112182015.GA403047@roeck-us.net>
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
 <20211207104924.21327-3-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207104924.21327-3-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 07, 2021 at 11:49:21AM +0100, Sergio Paracuellos wrote:
> PCI core code call 'pcibios_root_bridge_prepare()' function inside function
> 'pci_register_host_bridge()'. This point is very good way to properly enter
> into this MIPS ralink specific code to properly setup I/O coherency units
> with PCI memory addresses.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

FWIW:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/mips/ralink/mt7621.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> index bd71f5b14238..d6efffd4dd20 100644
> --- a/arch/mips/ralink/mt7621.c
> +++ b/arch/mips/ralink/mt7621.c
> @@ -10,6 +10,8 @@
>  #include <linux/slab.h>
>  #include <linux/sys_soc.h>
>  #include <linux/memblock.h>
> +#include <linux/pci.h>
> +#include <linux/bug.h>
>  
>  #include <asm/bootinfo.h>
>  #include <asm/mipsregs.h>
> @@ -22,6 +24,35 @@
>  
>  static void *detect_magic __initdata = detect_memory_region;
>  
> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	struct resource_entry *entry;
> +	resource_size_t mask;
> +
> +	entry = resource_list_first_type(&bridge->windows, IORESOURCE_MEM);
> +	if (!entry) {
> +		pr_err("Cannot get memory resource\n");
> +		return -EINVAL;
> +	}
> +
> +	if (mips_cps_numiocu(0)) {
> +		/*
> +		 * Hardware doesn't accept mask values with 1s after
> +		 * 0s (e.g. 0xffef), so warn if that's happen
> +		 */
> +		mask = ~(entry->res->end - entry->res->start) & CM_GCR_REGn_MASK_ADDRMASK;
> +		WARN_ON(mask && BIT(ffz(~mask)) - 1 != ~mask);
> +
> +		write_gcr_reg1_base(entry->res->start);
> +		write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
> +		pr_info("PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
> +			(unsigned long long)read_gcr_reg1_base(),
> +			(unsigned long long)read_gcr_reg1_mask());
> +	}
> +
> +	return 0;
> +}
> +
>  phys_addr_t mips_cpc_default_phys_base(void)
>  {
>  	panic("Cannot detect cpc address");
> -- 
> 2.33.0
> 
