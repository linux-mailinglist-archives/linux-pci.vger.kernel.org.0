Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413D2466A96
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 20:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbhLBTsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 14:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhLBTsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 14:48:36 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEB1C06174A;
        Thu,  2 Dec 2021 11:45:13 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id u74so1253872oie.8;
        Thu, 02 Dec 2021 11:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WxtPRLoNzb7XOofD4otzT5BRH1oRsN0RIGLelSLEoYE=;
        b=agPbuVjWrpnnuyNMHrejcGCS7/0ZqKl9bXZFAjD2zoQsiFXKKMkwEDh7fgtuTpwzNi
         nCvsxrx6VizSmmxsl2bVeXhtwPfX70nQLIrLPjsMCFgfQY6DChOv843sTdufH+sAeM4O
         VIxkBq5EdqyXbus5msfR/CayKElSBm2On0bB3D+zAhSEA7sZwumealLjjhDq9QXALoIH
         V6/+r1vCyIh4R6BmoRkOnVRuVI3nGIOU2IV5X4xXhe+z9lHNReiVoKku6bBGZGkRq+mO
         eyLOUGeQUblNuEUVw8+29qPyZtFPCDgExIqli0fDhsFDJ3KNDnO3s4dhDB+5gq+3oTCX
         9PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WxtPRLoNzb7XOofD4otzT5BRH1oRsN0RIGLelSLEoYE=;
        b=Zzw1VMmlP/PDfSEikhLfb5gY1WKNgMnqnl4lTy2OiV8vEWlkAd8vzba+lKIOIVQMyz
         mqEVvzO4tkZpsp50MY8l/O+gftpMOC25/gHt8YRhpv0HZ8QhC9d4jZQF6bcF5jrZv+Vo
         dsH/EmvmD69QdHVSicNVCuPyZuL2ATHR0YlSgchsuB5ZCx4BAhncReLyof8mP6mnMC0S
         J4pRnqcbhKEsMvMuIyTmTcwenW8zxKUXiaEh5y7XJQqp1KVKOt2f3O+2cZ/4hGaJ0M0a
         okFKuCl6/J13ysXkKrpNS8CZ+xwOECu9gsLoDduJXGzwAfdpqoPi0zi/mEGUl+FcsMbk
         bN7g==
X-Gm-Message-State: AOAM532NvAqVsIhJbvGpmDGDa95c9Otan1dwxXFgAOoAaVhdLCqFCbfZ
        VkmBjBMcqlxlT9p1NUR1d+oc5YiGU1A=
X-Google-Smtp-Source: ABdhPJyZKTNuzkSDqju9BkqxVrqjF/GatXDZ9TNKDeS1BbNyidiemq0VLr+3L9FKrWlSac4aLaVBNw==
X-Received: by 2002:aca:4b11:: with SMTP id y17mr6175821oia.170.1638474311741;
        Thu, 02 Dec 2021 11:45:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x16sm195368ott.8.2021.12.02.11.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 11:45:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
References: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
 <20211201215127.23550-3-sergio.paracuellos@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/5] MIPS: ralink: implement
 'pcibios_root_bridge_prepare()'
Message-ID: <6ebd3d77-e012-4b27-f0dc-a81c59d76fe4@roeck-us.net>
Date:   Thu, 2 Dec 2021 11:45:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201215127.23550-3-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/1/21 1:51 PM, Sergio Paracuellos wrote:
> PCI core code call 'pcibios_root_bridge_prepare()' function inside function
> 'pci_register_host_bridge()'. This point is very good way to properly enter
> into this MIPS ralink specific code to properly setup I/O coherency units
> with PCI memory addresses.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>   arch/mips/ralink/mt7621.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> index bd71f5b14238..7649416c1cd7 100644
> --- a/arch/mips/ralink/mt7621.c
> +++ b/arch/mips/ralink/mt7621.c
> @@ -10,6 +10,7 @@
>   #include <linux/slab.h>
>   #include <linux/sys_soc.h>
>   #include <linux/memblock.h>
> +#include <linux/pci.h>
>   
>   #include <asm/bootinfo.h>
>   #include <asm/mipsregs.h>
> @@ -22,6 +23,35 @@
>   
>   static void *detect_magic __initdata = detect_memory_region;
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
> +		 * FIXME: hardware doesn't accept mask values with 1s after
> +		 * 0s (e.g. 0xffef), so it would be great to warn if that's
> +		 * about to happen
> +		 */
> +		mask = ~(entry->res->end - entry->res->start);
> +

One more comment: From the include file,

#define CM_GCR_REGn_MASK_ADDRMASK               GENMASK(31, 16)

suggests that only the upper 16 bit are valid (relevant ?) for the mask.
Given that, it might make sense to make sure that the lower 16 bit are not set,
maybe with
		mask = ~(entry->res->end - entry->res->start) & CM_GCR_REGn_MASK_ADDRMASK;

Thanks,
Guenter

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
>   phys_addr_t mips_cpc_default_phys_base(void)
>   {
>   	panic("Cannot detect cpc address");
> 

