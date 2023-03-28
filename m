Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679606CC7AB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 18:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjC1QPg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 12:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjC1QP0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 12:15:26 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A653F74F;
        Tue, 28 Mar 2023 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=DIa//tqesq+okM3W9KzuD9kS6Wsulq7u13ktyLV/9P0=; b=oAbTZVWricJjawxSqQgLP10Eub
        ZcD+mJ4spWGfPVOsuisyybb7YKhtxLHAY/vn7r5Y3vnOk9QKHAauGth5/Ut143751Cffm5+dEDyGQ
        irFAEor7/UA9S1lPJyMbRE8tuMImoJ+NeW1OKkMCHpXxN/PzY+MPeLWGDVUnqii+SlSQrSWyCOXPa
        gmBXjPAIgskwvWZnNfH5cM5tEtM1PUzy9eJWd/iBS3RwuN+1mE2INoA4tkRGiILOjFR256U2pp36i
        Nj+iYFj0UPNzH4KAMwJ8bmmJGvVaIuJQEO6f6pm6eeuL/Bfe2xl6hProsOdjUac97I6eujNJSZYrB
        IUwLqZYQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1phBSC-00BxbA-Od; Tue, 28 Mar 2023 09:41:45 -0600
Message-ID: <adaf3376-6f4f-3b6c-1cdb-dfad9df204b8@deltatee.com>
Date:   Tue, 28 Mar 2023 09:41:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230328110610.3824-1-cai.huoqing@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230328110610.3824-1-cai.huoqing@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: cai.huoqing@linux.dev, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2] PCI/P2PDMA: Fix the comments on pci_p2pmem_find_many()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-03-28 05:06, Cai Huoqing wrote:
> Remove pci_p2pmem_dma() reference,
> because pci_p2pmem_dma() method is already removed.
> 
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>

Looks good to me, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
> v1->v2:
>   1.remove pci_p2pmem_dma() reference directly instead of
>     using pci_p2pdma_map_segment().
> 
> v1 link:
>   https://lore.kernel.org/lkml/eea970cd-d781-9d4c-e020-9086505a4ba7@deltatee.com/
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
