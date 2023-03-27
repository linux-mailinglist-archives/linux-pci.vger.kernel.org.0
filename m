Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235976CA986
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjC0Ps2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 11:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjC0PsQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 11:48:16 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81314268C;
        Mon, 27 Mar 2023 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=vDrk33Y7eKL8Zg/U3tUvd9LY/tqvcIYZHqZm9L+BoQM=; b=cI+5QizYNwLaimU5zhNVJni79i
        PRtE5xVwF/pvgDljQulXrrkgymjXqnbwSMed8CvqYmhy4X2hXq81fonAIqUHRHNOgCJFs17OFIebr
        A6M9DUwwI2/YZyzxzRDm3FZxJFTN8fg96nJ3V50CjuqqppayLb7UhEIPyUngc4px7kqHkOkOe8z0B
        HUhybohZMkVfkU8XFw87h2q0fSf3JNuVirrN85aggFWjbFfkfz9c6sqN3nIV8svNOFLQ/1m0a8sD4
        q0YY3pcgcJR1VLpXWzchbKqOqeN75IH2U4fAmkz3duVAiTW+1EGRzQCXz2fyjeJihnLH69cbMwb+p
        qa4PFzWQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1pgp4r-00B4LD-T8; Mon, 27 Mar 2023 09:48:10 -0600
Message-ID: <eea970cd-d781-9d4c-e020-9086505a4ba7@deltatee.com>
Date:   Mon, 27 Mar 2023 09:48:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230327073604.5449-1-cai.huoqing@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230327073604.5449-1-cai.huoqing@linux.dev>
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
Subject: Re: [PATCH] PCI/P2PDMA: Fix the comments on pci_p2pmem_find_many()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-03-27 01:36, Cai Huoqing wrote:
> Use pci_p2pdma_map_segment() instead of pci_p2pmem_dma(),
> because pci_p2pmem_dma() is already removed.
> 
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>

Thanks for noticing this!

> ---
>  drivers/pci/p2pdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9e8205572830..4f1798ecf38f 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -747,7 +747,7 @@ EXPORT_SYMBOL_GPL(pci_has_p2pmem);
>  /**
>   * pci_p2pmem_find_many - find a peer-to-peer DMA memory device compatible with
>   *	the specified list of clients and shortest distance (as determined
> - *	by pci_p2pmem_dma())
> + *	by pci_p2pdma_map_segment())

Maybe we should just remove the reference to pci_p2pdma_map_segment()
completely. I don't see how that function helps the reader any more and
is really different section of the API anyway.

Logan
