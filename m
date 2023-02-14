Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F1669706F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 23:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjBNWIy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 17:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjBNWIx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 17:08:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73FB23858;
        Tue, 14 Feb 2023 14:08:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F7DC6193C;
        Tue, 14 Feb 2023 22:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C77C433D2;
        Tue, 14 Feb 2023 22:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676412531;
        bh=prcFuWx4Xr14c0+3/mZoX//3CQyLBA0Y2sg4l+NivoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fw3m/OLV8E59WGFBpaOIlT4HhkWhfYKOjE2KCS06OXR7TzGtuUk567OVkqv4IpmRu
         KdUBwxik3V5Up/o2XW6X5OBTAAt7iYTHhS72NQpSuL9A5H86Neh1kwbR8CIbhT3qsR
         dvpa/+UzSrTvWxs6YWQwmNQhRe3HbNgO1UCP53cjlojQmyH6ktrbLtWTrPWLDQD3k/
         CyNA4a3pquJF9rfylG2aFZ+HBGcM6Ljqn6TbwpnMn+89BRaOM8IZXW+LVEPX0OP7Sb
         xKqpT83luOx3tUOhrDUU4YWDnFndYMWusWeoPZFmZ5Dt7Fx8DJeh4NMfvJLnBRGyRb
         CG39qGSwJM0qw==
Date:   Tue, 14 Feb 2023 16:08:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] PCI/P2PDMA: Annotate RCU dereference
Message-ID: <20230214220849.GA3088019@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209172953.4597-1-logang@deltatee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 09, 2023 at 10:29:53AM -0700, Logan Gunthorpe wrote:
> A dereference of the __rcu pointer was noticed by sparse:
> 
>   drivers/pci/p2pdma.c:199:44: sparse: sparse: dereference of noderef expression
> 
> The __rcu pointer should be dereferenced using
> rcu_dereference_protected() instead of accessed directly. Its safe
> to use rcu_derference_protected() seeing a reference is held on
> the pgmap's percpu reference counter and thus it cannot disappear.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Applied with Chaitanya's reviewed-by to pci/p2pdma for v6.3, thanks!

> ---
> 
> Based on v6.2-rc7
> 
>  drivers/pci/p2pdma.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 86812d2073ea..9e8205572830 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -194,11 +194,13 @@ static const struct attribute_group p2pmem_group = {
>  static void p2pdma_page_free(struct page *page)
>  {
>  	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
> +	/* safe to dereference while a reference is held to the percpu ref */
> +	struct pci_p2pdma *p2pdma =
> +		rcu_dereference_protected(pgmap->provider->p2pdma, 1);
>  	struct percpu_ref *ref;
> 
> -	gen_pool_free_owner(pgmap->provider->p2pdma->pool,
> -			    (uintptr_t)page_to_virt(page), PAGE_SIZE,
> -			    (void **)&ref);
> +	gen_pool_free_owner(p2pdma->pool, (uintptr_t)page_to_virt(page),
> +			    PAGE_SIZE, (void **)&ref);
>  	percpu_ref_put(ref);
>  }
> 
> 
> base-commit: 4ec5183ec48656cec489c49f989c508b68b518e3
> --
> 2.30.2
