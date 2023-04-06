Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618B66DA4CF
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 23:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbjDFVk6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 17:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjDFVk5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 17:40:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164DD83DC;
        Thu,  6 Apr 2023 14:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A608464A29;
        Thu,  6 Apr 2023 21:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6EBC433D2;
        Thu,  6 Apr 2023 21:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680817256;
        bh=LgnSIae7YGJHWtRuO7WL6nEoJG1bzMYjwFvmJ5IZleE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IgGHUTg9VrD+1cioqRvBRzw/M2FQRPieZPpJuKJGgUZ2+SBxZd4qdaqd3wAmDmvUE
         9fFeU0ULIVQO9VKEi4KOoRxmLb3twtZ5eHfL76p13z8Kjs8OCHxBxRfIr3/qHi/5mo
         I9oKfoSTAvndZzT0qRZewRi65cpmawjl/13vQNNbf/7Lk79tnEuXVcR7+RTZCzW0dU
         EuHYKRkQcCFxHkmUzmgZmkDUva3AmSuF8Npj7g7OF5TwdPZkbMt+LV8+6vMz0joSUc
         lU3GvoIPFxcoS93EgsKYoclTKxkSbwQry2QXRk/vaSZ2+H58shP40h7G1wNFG9rrgl
         XkAK2WvJ80+lw==
Date:   Thu, 6 Apr 2023 16:40:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/P2PDMA: Fix the comments on pci_p2pmem_find_many()
Message-ID: <20230406214054.GA3741302@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329024731.5604-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 29, 2023 at 10:47:31AM +0800, Cai Huoqing wrote:
> Remove pci_p2pmem_dma() reference,
> because pci_p2pmem_dma() method is not existed.
> 
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Applied with following subject/commit log to pci/p2pdma for v6.4, thanks!

    PCI/P2PDMA: Fix pci_p2pmem_find_many() kernel-doc

    Remove reference to pci_p2pmem_dma(), which has never existed.

> ---
> v2->v3:
>   Update commit log-pci_p2pmem_dma() method is not existed.
> 
> v2 link:
>   https://lore.kernel.org/lkml/20230328110610.3824-1-cai.huoqing@linux.dev/
> 
>  drivers/pci/p2pdma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9e8205572830..6cd98ffca198 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -746,8 +746,7 @@ EXPORT_SYMBOL_GPL(pci_has_p2pmem);
>  
>  /**
>   * pci_p2pmem_find_many - find a peer-to-peer DMA memory device compatible with
> - *	the specified list of clients and shortest distance (as determined
> - *	by pci_p2pmem_dma())
> + *	the specified list of clients and shortest distance
>   * @clients: array of devices to check (NULL-terminated)
>   * @num_clients: number of client devices in the list
>   *
> -- 
> 2.34.1
> 
