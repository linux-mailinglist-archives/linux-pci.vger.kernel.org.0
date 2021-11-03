Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0793444854
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 19:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhKCShU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 14:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231381AbhKCShP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Nov 2021 14:37:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9265C6113B;
        Wed,  3 Nov 2021 18:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635964478;
        bh=/HBkBKVRCR9R7CC2CF8WeepbljA93UwkOPVWpSKe4nY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Q3eDk0C0iBz9g/sKeZnOAFbLf6jgpVvU9+aOspKoW3OkXZlP1/UWWI2MffwY9P7ub
         m5bzhVpizCisY9kej62fC0QeFBa34iz5FR8n8xD1IeCQ1Y31OsrqBAQSS8RNx/Ac29
         pbVgN3EU6UozdImhtvMgw8moK4wcHegidWfc/KmUexWNQUGJS2h5s984+kz3AXcsd9
         jUx60JaP0OEa9UVfge0ZDrsFsgspZFx+3QoXuBKiDxGo1dWOfpJD/jP7krzQ3eesS+
         iZ7aCNg9Z5Kst9kI1dVz2ZFsEDt99o6WBdZyfykLYPSGuGtcgbh5kHaXh2eE84BH7e
         uywjz08/NuKwA==
Date:   Wed, 3 Nov 2021 13:34:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     jonnyc@amazon.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH -next,resend] PCI: al: Remove redundant dev_err call in
 al_pcie_probe()
Message-ID: <20211103183437.GA705578@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608084913.1046606-1-chenxiaosong2@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof]

If this was a resend, the original got lost:
https://lore.kernel.org/linux-pci/?q=s%3A%22redundant+dev_err+call+in+al_pcie_probe%22

On Tue, Jun 08, 2021 at 04:49:13PM +0800, ChenXiaoSong wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
>  drivers/pci/controller/dwc/pcie-al.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
> index e8afa50129a8..fb4d1eed07ce 100644
> --- a/drivers/pci/controller/dwc/pcie-al.c
> +++ b/drivers/pci/controller/dwc/pcie-al.c
> @@ -346,11 +346,8 @@ static int al_pcie_probe(struct platform_device *pdev)
>  	controller_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>  						      "controller");
>  	al_pcie->controller_base = devm_ioremap_resource(dev, controller_res);
> -	if (IS_ERR(al_pcie->controller_base)) {
> -		dev_err(dev, "couldn't remap controller base %pR\n",
> -			controller_res);
> +	if (IS_ERR(al_pcie->controller_base))
>  		return PTR_ERR(al_pcie->controller_base);
> -	}

This is OK, but I think we could use devm_platform_ioremap_resource()
instead and simplify even a little more.

There are several other drivers that could use
devm_platform_ioremap_resource(),
devm_platform_ioremap_resource_byname(), or
devm_platform_get_and_ioremap_resource() for slight simplification.

>  	dev_dbg(dev, "From DT: controller_base: %pR\n", controller_res);
>  
> -- 
> 2.25.4
> 
