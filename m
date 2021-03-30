Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4BA34F183
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 21:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhC3TTa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 15:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233006AbhC3TT2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 15:19:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2E6961998;
        Tue, 30 Mar 2021 19:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617131968;
        bh=XBxHhXmWgSj4QgRnO4vvOh88DUWa5B1fPdpOmU7Kao4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nKR+gyj5umi3lc+byor8F0C6I4kPN3zODildT5lBj8ALRfxfkZTEcxQyEDCrxi1yU
         mwykLsUedWBKSgaZ1oRIgfSnJqwDdPjO8vbz3kSPxGX5zXEMtVJn2OEakQ8/ZasiCt
         RshA5pgyFBWItHnLDlJux9wgWYB6KdzeL7mxvS0069ccwcHZch3GVKZx6meFHnWe7j
         tmXok+pQK4smKKH1O3DgmjY02h/4ZbnXASf35+nND4gSrnijbAdqpSgZ+/sqDtmGjF
         uFQ9R1qKyrg9aRi0OfVRAlqg7bS/5hkUW57XF3JsUzTgKm/xlsg8rZGGktet6qE3aA
         YOgtDMw74Ou2Q==
Date:   Tue, 30 Mar 2021 14:19:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     toan@os.amperecomputing.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dann.frazier@canonical.com
Subject: Re: [PATCH] PCI: xgene: fix a mistake about cfg address
Message-ID: <20210330191926.GA1297928@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328144118.305074-1-zhengdejin5@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 28, 2021 at 10:41:18PM +0800, Dejin Zheng wrote:
> It has a wrong modification to the xgene driver by the commit
> e2dcd20b1645a. it use devm_platform_ioremap_resource_byname() to
> simplify codes and remove the res variable, But the following code
> needs to use this res variable, So after this commit, the port->cfg_addr
> will get a wrong address. Now, revert it.
> 
> Fixes: e2dcd20b1645a ("PCI: controller: Convert to devm_platform_ioremap_resource_byname()")
> Reported-by: dann.frazier@canonical.com
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

This looks right to me, but since e2dcd20b1645a appeared in v5.9-rc1,
I think it should have:

  Cc: stable@vger.kernel.org	# v5.9+

> ---
>  drivers/pci/controller/pci-xgene.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> index 2afdc865253e..7f503dd4ff81 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -354,7 +354,8 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
>  	if (IS_ERR(port->csr_base))
>  		return PTR_ERR(port->csr_base);
>  
> -	port->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	port->cfg_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(port->cfg_base))
>  		return PTR_ERR(port->cfg_base);
>  	port->cfg_addr = res->start;
> -- 
> 2.30.1
> 
