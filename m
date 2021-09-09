Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47D1405C15
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 19:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbhIIRaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 13:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232940AbhIIRaC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Sep 2021 13:30:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E05E361100;
        Thu,  9 Sep 2021 17:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631208533;
        bh=Umswx7+uonqXD36E95PpN0EL1S7smPEf/QAyAdE3hqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Nui7oIhXJ+N/OsBXgzWi/sXccwelVq4VXDEKB5HeBUtJEnLK6n6Au580d63TXW51J
         JAbdt6Swi1PO9pjMWFNnc2YG+Wr/Dgpa0pkvc3cKA18aa4NeDop+CQ3ybfzR0J1htv
         +cIUisrmLfzaUBPLbg2yMuBK0xtsftPz7cSC/cUUK+vfW9M3d+XnpPhjcWog24BDeT
         Rru6aOPYL/x5jODoZ+wyXa9dd2cdM0boDFx48/ReCLCPuZYIYAFxFXGe5FGvnVAqXt
         s2w6r7lMh4rwmxAFuJVwwZiYyNyjmLQ38fBabqg4OzLj/4cGU18yQPnw/SKnPT7RB0
         ipyRIdU4c47Hg==
Date:   Thu, 9 Sep 2021 12:28:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wang Lu <wanglu@dapustor.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] PCI/P2PDMA: fix the wrong dma address calculation when
 map sg
Message-ID: <20210909172851.GA993207@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909032528.24517-1-wanglu@dapustor.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 09, 2021 at 11:25:28AM +0800, Wang Lu wrote:
> The bus offset is bus address - physical address,
> so the calculation in __pci_p2pdma_map_sg should be:
> bus address = physical address + bus offset.
> 
> Signed-off-by: Wang Lu <wanglu@dapustor.com>

Applied with Logan's reviewed-by to pci/p2pdma for v5.16, thanks!

I fixed the subject line and commit log for you to follow the usual
conventions.

> ---
>  drivers/pci/p2pdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 50cdde3e9a8b..327882638b30 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -874,7 +874,7 @@ static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
>  	int i;
>  
>  	for_each_sg(sg, s, nents, i) {
> -		s->dma_address = sg_phys(s) - p2p_pgmap->bus_offset;
> +		s->dma_address = sg_phys(s) + p2p_pgmap->bus_offset;
>  		sg_dma_len(s) = s->length;
>  	}
>  
> -- 
> 2.17.1
> 
> 
> 
