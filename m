Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105562B9B93
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 20:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgKSTff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 14:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgKSTff (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 14:35:35 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29B5122201;
        Thu, 19 Nov 2020 19:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605814534;
        bh=Th0cyt4YYbn1KfH1XyPGrc0EoMvuViVWq1FOPk9NPJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bOixT/3UwVfeX8klYWuIsFXoH6O0fkhQB42HxLZBAgImMpqYapfxTeevHjlBesukn
         efBMaZJGVRkVpBxCHqI6ajZhEmVWrwsbJcV491TEhYVoAUCTo+tJua1/zeHMl1+47g
         jcEIcc6VKpdIuvUpXyAxsUyBuQfDKiuoJoC4t2LU=
Date:   Thu, 19 Nov 2020 13:35:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH pci-next] pci: remap: keep both device name and resource
 name for config space
Message-ID: <20201119193532.GA195197@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JvyOzv8K8n5CCdP1xfLOdOWh4AbFrXdMMOEExr6em8@cp4-web-036.plabs.ch>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please look at the git history and follow the subject line convention.

On Thu, Nov 19, 2020 at 07:04:42PM +0000, Alexander Lobakin wrote:
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
> 19000000-19ffffff : pci@18b00000
>   19000000-190fffff : PCI Bus 0000:01
>     19000000-1900ffff : 0000:01:00.0
>   19100000-191fffff : PCI Bus 0000:01
> 1a000000-1affffff : pci@18b20000
>   1a000000-1a0fffff : PCI Bus 0001:01
>     1a000000-1a00ffff : 0001:01:00.0
>   1a100000-1a1fffff : PCI Bus 0001:01
> 
> After:
> 
> 18b00000-18b01fff : 18b00000.pci dbi
> 18b10000-18b11fff : 18b00000.pci config
> 18b20000-18b21fff : 18b20000.pci dbi
> 18b30000-18b31fff : 18b20000.pci config

Makes sense.  I would remove the rest of this output from the commit
log since it isn't relevant and doesn't change.

> 19000000-19ffffff : pci@18b00000
>   19000000-190fffff : PCI Bus 0000:01
>     19000000-1900ffff : 0000:01:00.0
>   19100000-191fffff : PCI Bus 0000:01
> 1a000000-1affffff : pci@18b20000
>   1a000000-1a0fffff : PCI Bus 0001:01
>     1a000000-1a00ffff : 0001:01:00.0
>   1a100000-1a1fffff : PCI Bus 0001:01
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
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
