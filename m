Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD942D6AA3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 23:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394028AbgLJVYg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 16:24:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394009AbgLJVXh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Dec 2020 16:23:37 -0500
Date:   Thu, 10 Dec 2020 15:22:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607635377;
        bh=TOz09/Be4KaJAdEckZ6bX5dETMcE9pxq2g7yzIxBw60=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=c29tY261aNn7r2A2U6A3CanPIzaCva7CfX+EOKAD8VV/0N+cwt8mBFXk5sYldhOZe
         qgm0RkrZ/l4M2nJ1K1isLdePt9NcwqlWk5/clR8RVtPtaQApwT6hzXy/e1iOwXYn8m
         OdDHUTSGbidktRpNOWmo7rVVV9jKLrNgCCCFfBJlhz+XvWujcXc8Juz7W6gdWsFooU
         Uugs9Yv53zi8BwVEMuKZMm5rLVwjlSlrvavelbAj5oT6kSat3ehf8n/EfnBYrhdATk
         OgdNUD7X3gnPRZCsgp+G7sKHSE7pH0iK/EBetU9MMyvf9vOpmd9reSySUUwo4QPgxH
         Bz8gCUGgaAePA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 pci-next] PCI: Keep both device name and resource name
 for config space remaps
Message-ID: <20201210212255.GA56204@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <WbKfdybjZ6xNIUjcC5oC8NcuLqrJfkxQAlnO80ag@cp3-web-020.plabs.ch>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 19, 2020 at 09:26:33PM +0000, Alexander Lobakin wrote:
> Follow the rule taken in commit 35bd8c07db2c
> ("devres: keep both device name and resource name in pretty name")
> and keep both device and resource names while requesting memory
> regions for PCI config space to prettify e.g. /proc/iomem output:
> 
> Before (DWC Host Controller):
> 
> 18b00000-18b01fff : dbi
> 18b10000-18b11fff : config
> 18b20000-18b21fff : dbi
> 18b30000-18b31fff : config
> 
> After:
> 
> 18b00000-18b01fff : 18b00000.pci dbi
> 18b10000-18b11fff : 18b00000.pci config
> 18b20000-18b21fff : 18b20000.pci dbi
> 18b30000-18b31fff : 18b20000.pci config
> 
> Since v1 [0]:
>  - massage subject and commit message (Bjorn);
>  - no functional changes.
> 
> [0] https://lore.kernel.org/lkml/JvyOzv8K8n5CCdP1xfLOdOWh4AbFrXdMMOEExr6em8@cp4-web-036.plabs.ch
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Applied to pci/enumeration for v5.11, thanks!

> ---
>  drivers/pci/pci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e578d34095e9..0716691f7d14 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4188,7 +4188,14 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
>  	}
>  
>  	size = resource_size(res);
> -	name = res->name ?: dev_name(dev);
> +
> +	if (res->name)
> +		name = devm_kasprintf(dev, GFP_KERNEL, "%s %s", dev_name(dev),
> +				      res->name);
> +	else
> +		name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
> +	if (!name)
> +		return IOMEM_ERR_PTR(-ENOMEM);
>  
>  	if (!devm_request_mem_region(dev, res->start, size, name)) {
>  		dev_err(dev, "can't request region for resource %pR\n", res);
> -- 
> 2.29.2
> 
> 
