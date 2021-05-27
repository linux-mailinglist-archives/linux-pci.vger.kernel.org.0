Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC403939C3
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 01:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhE0X4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 19:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236899AbhE0X4W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 19:56:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71680613E6;
        Thu, 27 May 2021 23:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622159688;
        bh=hD8/N+fF2FkE4LluW3yq8kxRpk38PAPjA3KU3mn9Xt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ajk3u6/5kUvCA8Lb3RSDPrjQIeInnrxmedV2RMUhzStjfVv4/lAP8EJFFhqHY+D5F
         E3Mnkc6O/tpkGWNWEgwFB7asfLmnegDYfU1qdf9niXGUKCYkXZG0fx3cm+Kz2U+Wyd
         86afZhUHv8reDkgmispBqj7sjpqOpe/gejFGSwaQQz5uQY7XJs4/fVhcTh9iSQNA7f
         BSDKiaL1RiKKQ9/42IZKB4a28WBaUJoHU0IR6RbYHMTkXUUo2heTOFvDN2KxHMAZrO
         o55/NHO+PfU7v9o0jmVZ9jM6o/XeoRllA+77LtMcF4FBt7ni1Q4Q0g3qo3ehexNsZb
         x/ViV4QBti10w==
Date:   Thu, 27 May 2021 18:54:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] x86/pci: use true and false for bool variable
Message-ID: <20210527235447.GA1446759@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615794000-102771-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof]

On Mon, Mar 15, 2021 at 03:40:00PM +0800, Yang Li wrote:
> fixed the following coccicheck:
> ./arch/x86/pci/mmconfig-shared.c:464:9-10: WARNING: return of 0/1 in
> function 'is_mmconf_reserved' with return type bool
> ./arch/x86/pci/mmconfig-shared.c:493:5-6: WARNING: return of 0/1 in
> function 'is_mmconf_reserved' with return type bool
> ./arch/x86/pci/mmconfig-shared.c:501:9-10: WARNING: return of 0/1 in
> function 'is_mmconf_reserved' with return type bool
> ./arch/x86/pci/mmconfig-shared.c:522:5-6: WARNING: return of 0/1 in
> function 'is_mmconf_reserved' with return type bool
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied to pci/misc for v5.14, thanks!

Did you check all of drivers/pci/ for similar warnings, too?

> ---
>  arch/x86/pci/mmconfig-shared.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index de6bf0e..758cbfe 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -461,7 +461,7 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
>  	}
>  
>  	if (size < (16UL<<20) && size != old_size)
> -		return 0;
> +		return false;
>  
>  	if (dev)
>  		dev_info(dev, "MMCONFIG at %pR reserved in %s\n",
> @@ -493,7 +493,7 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
>  				&cfg->res, (unsigned long) cfg->address);
>  	}
>  
> -	return 1;
> +	return true;
>  }
>  
>  static bool __ref
> @@ -501,7 +501,7 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
>  {
>  	if (!early && !acpi_disabled) {
>  		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev, 0))
> -			return 1;
> +			return true;
>  
>  		if (dev)
>  			dev_info(dev, FW_INFO
> @@ -522,14 +522,14 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
>  	 * _CBA method, just assume it's reserved.
>  	 */
>  	if (pci_mmcfg_running_state)
> -		return 1;
> +		return true;
>  
>  	/* Don't try to do this check unless configuration
>  	   type 1 is available. how about type 2 ?*/
>  	if (raw_pci_ops)
>  		return is_mmconf_reserved(e820__mapped_all, cfg, dev, 1);
>  
> -	return 0;
> +	return false;
>  }
>  
>  static void __init pci_mmcfg_reject_broken(int early)
> -- 
> 1.8.3.1
> 
