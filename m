Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8925C1C9BE5
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 22:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGUPr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 16:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGUPr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 16:15:47 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F613216FD;
        Thu,  7 May 2020 20:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588882546;
        bh=Nn0Un6aRpakEtuYOCqVgYcTF+qUJFwkYBRemF7H3LDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HsihGvs9E1JHhScXJwwRqnIX05f4Gdr8v3nBGOynUPJrvFOAzHEhc1KMZokZz1hY/
         4VrhsP5Yu/fkBU7y44yj8nwf5D+4WsA8KLiL4yP9EprqkrlAQZzsh2GQCU9lYe5Lkb
         5hvvOlgjmqu9I9o4lT3nTIMjrjaZQoGGyAKguDqQ=
Date:   Thu, 7 May 2020 15:15:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Replace zero-length array with flexible-array
Message-ID: <20200507201544.GA23633@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507190544.GA15633@embeddedor>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 07, 2020 at 02:05:44PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to pci/misc for v5.8, thanks!

I assume this takes care of everything in drivers/pci/, right?  I'd
like to do them all at once, so if there are others, send another
patch and I'll squash them.  I took a quick look but didn't see any.

> ---
>  drivers/pci/pci.c   |    2 +-
>  include/linux/pci.h |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 595fcf59843f..bb78f580814e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1578,7 +1578,7 @@ EXPORT_SYMBOL(pci_restore_state);
>  
>  struct pci_saved_state {
>  	u32 config_space[16];
> -	struct pci_cap_saved_data cap[0];
> +	struct pci_cap_saved_data cap[];
>  };
>  
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 83ce1cdf5676..0453ee458ab1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -279,7 +279,7 @@ struct pci_cap_saved_data {
>  	u16		cap_nr;
>  	bool		cap_extended;
>  	unsigned int	size;
> -	u32		data[0];
> +	u32		data[];
>  };
>  
>  struct pci_cap_saved_state {
> @@ -532,7 +532,7 @@ struct pci_host_bridge {
>  			resource_size_t start,
>  			resource_size_t size,
>  			resource_size_t align);
> -	unsigned long	private[0] ____cacheline_aligned;
> +	unsigned long	private[] ____cacheline_aligned;
>  };
>  
>  #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
> 
