Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01A43CBE35
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 23:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhGPVLK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 17:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234129AbhGPVLJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 17:11:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF820613D8;
        Fri, 16 Jul 2021 21:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626469692;
        bh=1OuRSZMukpUPn6yWC0ivcwqWoT7Psb+QZ1P/W4VwbW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gBFBqaz8LVGz4ZDU3iPcueWkVTHPWPgOQpsP0Y2H3nqhDfOwoVPHBzv6JuTDOoRnE
         pI4iZKgRcOQry6EQelUKjFI9jAGZUJy2/Naj5H2hL8QAD9ux53jhU6XNTFqGX3+PS1
         asBgXX1KxkSrqRb1/ijPljRP/0qDLYIMtXHPeAv07OF3bt/KeFQRxkt/dMfSH/+7Dd
         bUoGbzd3KDq1u4I7Y6QL5R6JI28X2lyK55gUTLrMOBDK3Zh69wmWp2ECaf2jjOY4bA
         PvwwuxGxqqA4jDWIcvkTD2g+PdLidv8EEqJRPdjAh2p9oWb+rZY2Ydne4tOTF+m8JM
         UCII9w4WR5Z7A==
Date:   Fri, 16 Jul 2021 16:08:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Refactor pci_ioremap_bar() and pci_ioremap_wc_bar()
Message-ID: <20210716210810.GA2142315@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210713102436.304693-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 13, 2021 at 10:24:36AM +0000, Krzysztof Wilczyński wrote:
> Currently, functions pci_ioremap_bar() and pci_ioremap_wc_bar() share
> similar implementation details as both functions were almost identical
> in the past, especially when the latter was initially introduced in the
> commit c43996f4001d ("PCI: Add pci_ioremap_wc_bar()") as somewhat exact
> copy of the function pci_ioremap_bar().
> 
> However, function pci_ioremap_bar() received several updates that were
> never introduced to the function pci_ioremap_wc_bar().
> 
> Thus, to align implementation of both functions and reduce the need to
> duplicate code between them, introduce a new internal function called
> __pci_ioremap_resource() as a helper with a shared codebase intended to
> be called from functions pci_ioremap_bar() and pci_ioremap_wc_bar().
> 
> The  __pci_ioremap_resource() function will therefore include a check
> for the IORESOURCE_UNSET flag that has previously been added to the
> function pci_ioremap_bar() in the commit 646c0282df04 ("PCI: Fail
> pci_ioremap_bar() on unassigned resources") and otherwise has been
> missing from function pci_ioremap_wc_bar().
> 
> Additionally, function __pci_ioremap_resource() will retire the usage of
> the WARN_ON() macro and replace it with pci_err() to show information
> such as the driver name, the BAR number and resource details in case of
> a failure, instead of printing a complete backtrace. The WARN_ON() has
> already been replaced with pci_warn() in the commit 1f7bf3bfb5d6 ("PCI:
> Show driver, BAR#, and resource on pci_ioremap_bar() failure") which
> sadly didn't include an update to the function pci_ioremap_wc_bar() at
> that time.
> 
> Finally, a direct use of functions ioremap() and ioremap_wc() in the
> function __pci_ioremap_resource() will be replaced with calls to the
> pci_iomap_range() and pci_iomap_wc_range() functions respectively.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Nice cleanup, thanks!

Applied to pci/resource for v5.15.

I reverted to using plain ioremap() since pci_iomap_range() doesn't
seem to add anything except overhead.

> ---
>  drivers/pci/pci.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e3bb0d073352..4bae55f0700b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -206,7 +206,8 @@ int pci_status_get_and_clear_errors(struct pci_dev *pdev)
>  EXPORT_SYMBOL_GPL(pci_status_get_and_clear_errors);
>  
>  #ifdef CONFIG_HAS_IOMEM
> -void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
> +static void __iomem *__pci_ioremap_resource(struct pci_dev *pdev, int bar,
> +					    bool write_combine)
>  {
>  	struct resource *res = &pdev->resource[bar];
>  
> @@ -214,24 +215,25 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
>  	 * Make sure the BAR is actually a memory resource, not an IO resource
>  	 */
>  	if (res->flags & IORESOURCE_UNSET || !(res->flags & IORESOURCE_MEM)) {
> -		pci_warn(pdev, "can't ioremap BAR %d: %pR\n", bar, res);
> +		pci_err(pdev, "can't ioremap BAR %d: %pR\n", bar, res);
>  		return NULL;
>  	}
> -	return ioremap(res->start, resource_size(res));
> +
> +	if (write_combine)
> +		return pci_iomap_wc_range(pdev, bar, 0, 0);
> +
> +	return pci_iomap_range(pdev, bar, 0, 0);
> +}
> +
> +void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
> +{
> +	return __pci_ioremap_resource(pdev, bar, false);
>  }
>  EXPORT_SYMBOL_GPL(pci_ioremap_bar);
>  
>  void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar)
>  {
> -	/*
> -	 * Make sure the BAR is actually a memory resource, not an IO resource
> -	 */
> -	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
> -		WARN_ON(1);
> -		return NULL;
> -	}
> -	return ioremap_wc(pci_resource_start(pdev, bar),
> -			  pci_resource_len(pdev, bar));
> +	return __pci_ioremap_resource(pdev, bar, true);
>  }
>  EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
>  #endif
> -- 
> 2.32.0
> 
