Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF617D3D41
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 19:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjJWRTS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 13:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjJWRTR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 13:19:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E1EBD
        for <linux-pci@vger.kernel.org>; Mon, 23 Oct 2023 10:19:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D642C433C7;
        Mon, 23 Oct 2023 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698081554;
        bh=l4EsvDxN5O8Fu8tUL3suWkQEX002BW7JL7zgb/kJKto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nfvKKETCEfnvf+cBShaA2WwSpmvTpmvm+G/iZEFIetlUXxtJgtS4Dv7XHy3b+82ES
         cUqu9vOX8LrEm4J/SLbTebN3J+EV6EFmwQoviD7g2z/NIjH34VfMKyiFV3cjuArmcn
         IXXe329DwYhedMAibjm4eCBGago0RYZTXPkZB8EajFZDpcWqBv4SWKpzen+o0FFktj
         GEtaZrowyoC1R8lKveh5TvQmSoSkd0ZE4Se/3sHG0rmrx25X1ONOnKV3oglrpV4x4X
         Wo0RiZJtZKAlVK8NWUiqT8ZenfN15Iva3jZF5vCpSsLblN/y1uHibvr+iyAmNJeQwC
         P3AvA2ne3MfVQ==
Date:   Mon, 23 Oct 2023 12:19:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tadeusz Struk <tstruk@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, Tadeusz Struk <tstruk@gigaio.com>
Subject: Re: [PATCH] p2pdma: remove redundant goto
Message-ID: <20231023171912.GA1601951@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023084050.55230-1-tstruk@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 23, 2023 at 10:40:50AM +0200, Tadeusz Struk wrote:
> Remove redundant goto in pci_alloc_p2pmem()
> 
> Signed-off-by: Tadeusz Struk <tstruk@gmail.com>

Thanks, applied to pci/p2pdma with Logan's reviewed-by for v6.7.

Updated the subject line to:

  PCI/P2PDMA: Remove redundant goto

so it matches the history.

> ---
>  drivers/pci/p2pdma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index fa7370f9561a..a7776315996c 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -837,7 +837,6 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
>  	if (unlikely(!percpu_ref_tryget_live_rcu(ref))) {
>  		gen_pool_free(p2pdma->pool, (unsigned long) ret, size);
>  		ret = NULL;
> -		goto out;
>  	}
>  out:
>  	rcu_read_unlock();
> -- 
> 2.41.0
