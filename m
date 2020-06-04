Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571AD1EE089
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 11:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgFDJHZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 05:07:25 -0400
Received: from foss.arm.com ([217.140.110.172]:41890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbgFDJHY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jun 2020 05:07:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DCBA55D;
        Thu,  4 Jun 2020 02:07:24 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 605653F6CF;
        Thu,  4 Jun 2020 02:07:23 -0700 (PDT)
Date:   Thu, 4 Jun 2020 10:07:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: uniphier: Fix some error handling in
 uniphier_pcie_ep_probe()
Message-ID: <20200604090717.GA28503@e121166-lin.cambridge.arm.com>
References: <20200603175207.GB18931@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603175207.GB18931@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 03, 2020 at 08:52:07PM +0300, Dan Carpenter wrote:
> This code is checking the wrong variable.  It should be checking
> "clk_gio" instead of "clk".  The "priv->clk" pointer is NULL at this
> point so the condition is false.
> 
> Fixes: 006564dee8253 ("PCI: uniphier: Add Socionext UniPhier Pro5 PCIe endpoint controller driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Squashed in the commit it is fixing, thanks !

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> index 0f36aa33d2e50..1483559600610 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> @@ -324,8 +324,8 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->base);
>  
>  	priv->clk_gio = devm_clk_get(dev, "gio");
> -	if (IS_ERR(priv->clk))
> -		return PTR_ERR(priv->clk);
> +	if (IS_ERR(priv->clk_gio))
> +		return PTR_ERR(priv->clk_gio);
>  
>  	priv->rst_gio = devm_reset_control_get_shared(dev, "gio");
>  	if (IS_ERR(priv->rst_gio))
> -- 
> 2.26.2
> 
