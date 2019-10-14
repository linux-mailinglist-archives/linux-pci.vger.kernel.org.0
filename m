Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240B8D660A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 17:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbfJNPWu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 11:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733294AbfJNPWu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Oct 2019 11:22:50 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 580A120854;
        Mon, 14 Oct 2019 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571066569;
        bh=n26aaFdP+vRRPXVfTIgK+AIcfLKYxPZSZfP+Ajrf0WU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U593/WXYnnugsMLIw7TXBEbrirZmPVKnzWVFaAoYnqM6+psE6GsfFTYebK0qxxhCz
         ddI7uZwZ6jHNJ6sJ+3Jr0yh8+3ZheBrUMjiGKX8qb3SlXy9xOBwOb5Y7YicfpboOXr
         1GhNP4wtpSlXpfm/N0i6s9ORLwWXnog7Ex7SxlsM=
Date:   Mon, 14 Oct 2019 10:22:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH] PCI: Fix missing bridge dma_ranges resource list cleanup
Message-ID: <20191014152248.GA189282@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008012325.25700-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 07, 2019 at 08:23:25PM -0500, Rob Herring wrote:
> Commit e80a91ad302b ("PCI: Add dma_ranges window list") added a
> dma_ranges resource list, but failed to correctly free the list when
> devm_pci_alloc_host_bridge() is used.
> 
> Only the iproc host bridge driver is using the dma_ranges list.
> 
> Fixes: e80a91ad302b ("PCI: Add dma_ranges window list")
> Cc: Srinath Mannam <srinath.mannam@broadcom.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to pci/resource for v5.5, thanks!

> ---
>  drivers/pci/probe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3d5271a7a849..bdbc8490f962 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -572,6 +572,7 @@ static void devm_pci_release_host_bridge_dev(struct device *dev)
>  		bridge->release_fn(bridge);
>  
>  	pci_free_resource_list(&bridge->windows);
> +	pci_free_resource_list(&bridge->dma_ranges);
>  }
>  
>  static void pci_release_host_bridge_dev(struct device *dev)
> -- 
> 2.20.1
> 
