Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E81475F6B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 18:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhLORgP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 12:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbhLORgA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 12:36:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0FAC061751;
        Wed, 15 Dec 2021 09:36:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BC8DB82023;
        Wed, 15 Dec 2021 17:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DDAC36AE2;
        Wed, 15 Dec 2021 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639589757;
        bh=+PEUbCcnJjxmW6b62xG78kFVa8cCJ01ATRmyMBNcVBY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H/+9Dw6FpI1m6P3T/x1znAStygSkRfQeWSYLyfx2MqYjlYxyV0RWcMqBYXwmaFVOz
         A7qvQRaYKA5t+vbJYPLNgWA//MqkC+pdOaoFbxvnfcZsPP5sEHzVcYG1XCeNB8xWcr
         /k3aTjKsqcfcCvMtl8ilLRCwogESIvlScU0ldhgJUrIvt8h62e9g4KA6a4Jnc7MUxh
         V3EZ6EaF8l2D4AuA7WGoxNL5jJLJ7TZXUsKSWYPh8k9FE5WsezHJTRHMIqoRJqfRyM
         6KaQEhqgRkGsKbpAYn08aSxv1TXDP47xv6/qsz/u7aqodid7kt39zOi95Ya/HyzoU9
         KR1Arfl0By8oA==
Date:   Wed, 15 Dec 2021 11:35:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] PCI/P2PDMA: Save a few cycles in 'pci_alloc_p2pmem()'
Message-ID: <20211215173556.GA702194@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab80164f4d5b32f9e6240aa4863c3a147ff9c89f.1635974126.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Logan, Eric]

On Wed, Nov 03, 2021 at 10:16:53PM +0100, Christophe JAILLET wrote:
> Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
> save a few cycles when it is known that the rcu lock is already
> taken/released.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Added Logan and Eric since Logan is the author and de facto maintainer
of this file and Eric recently converted this to RCU.

Maybe we need a MAINTAINERS entry for P2PDMA?

> ---
>  drivers/pci/p2pdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 8d47cb7218d1..081c391690d4 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -710,7 +710,7 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
>  	if (!ret)
>  		goto out;
>  
> -	if (unlikely(!percpu_ref_tryget_live(ref))) {
> +	if (unlikely(!percpu_ref_tryget_live_rcu(ref))) {
>  		gen_pool_free(p2pdma->pool, (unsigned long) ret, size);
>  		ret = NULL;
>  		goto out;
> -- 
> 2.30.2
> 
