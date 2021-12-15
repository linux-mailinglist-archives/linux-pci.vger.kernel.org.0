Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D964476504
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 22:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhLOV6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 16:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhLOV6J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 16:58:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A48C061574;
        Wed, 15 Dec 2021 13:58:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA9AEB8217A;
        Wed, 15 Dec 2021 21:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F122C36AE3;
        Wed, 15 Dec 2021 21:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639605486;
        bh=nchXuFOEZ74zP/WUDKzNOFwt6qwVenVdikw6UEEHyoY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Hx8MG9R3l4gbF3/lvxOpidX0bf50UlZHf1XPmo3Xu5PJhL1WkcUtigkz6wrWUBsks
         qkgEgeMtCGajJesVelcoWejO1Oki2xk0yur7UC+t5HTYCTWZgfFMmssxImQGqj3wwQ
         oMUn/Vm1kHkaSzUKSKvizXyrVTw1//qLlYNyMnLlXGaWTktpuCwmh76TbgO8vFvP6u
         e6GhCOdsBcRvNn8Bj3TpBw9tge38bsCAxAziQ2MEg0JlEGXDp17y1/gbf1+J3qfJZs
         8zcy+UOhZbjOKnTIKzzeSnJMxZlC9d/vKh52loNwEIUJSc7P7hlN49DvIIX98EEPje
         KcnePjmZ+vZEg==
Date:   Wed, 15 Dec 2021 15:58:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Save a few cycles in 'pci_alloc_p2pmem()'
Message-ID: <20211215215804.GA716028@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab80164f4d5b32f9e6240aa4863c3a147ff9c89f.1635974126.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 03, 2021 at 10:16:53PM +0100, Christophe JAILLET wrote:
> Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
> save a few cycles when it is known that the rcu lock is already
> taken/released.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to pci/p2pdma for v5.17, thanks!

  PCI/P2PDMA: Use percpu_ref_tryget_live_rcu() inside RCU critical section

  Since pci_alloc_p2pmem() has already called rcu_read_lock(), we're in an
  RCU read-side critical section and don't need to take the lock again.  Use
  percpu_ref_tryget_live_rcu() instead of percpu_ref_tryget_live() to save a
  few cycles.

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
