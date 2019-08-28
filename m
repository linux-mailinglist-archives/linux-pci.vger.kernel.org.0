Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB0A0C59
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 23:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfH1V07 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 17:26:59 -0400
Received: from foss.arm.com ([217.140.110.172]:36506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfH1V06 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 17:26:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03F4B337;
        Wed, 28 Aug 2019 14:26:58 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AFAD3F718;
        Wed, 28 Aug 2019 14:26:57 -0700 (PDT)
Date:   Wed, 28 Aug 2019 22:26:55 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] PCI: iproc: Properly handle optional PHYs
Message-ID: <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-5-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828163636.12967-5-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 06:36:36PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> devm_phy_get() can fail for a number of resides besides probe deferral.
> It can for example return -ENOMEM if it runs out of memory as it tries
> to allocate devres structures. Propagating only -EPROBE_DEFER is
> problematic because it results in these legitimately fatal errors being
> treated as "PHY not specified in DT".
> 
> What we really want is to ignore the optional PHYs only if they have not
> been specified in DT. devm_phy_optional_get() is a function that exactly
> does what's required here, so use that instead.
> 
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/controller/pcie-iproc-platform.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
> index 5a3550b6bb29..9ee6200a66f4 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -93,12 +93,9 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  	pcie->need_ib_cfg = of_property_read_bool(np, "dma-ranges");
>  
>  	/* PHY use is optional */
> -	pcie->phy = devm_phy_get(dev, "pcie-phy");
> -	if (IS_ERR(pcie->phy)) {
> -		if (PTR_ERR(pcie->phy) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -		pcie->phy = NULL;
> -	}
> +	pcie->phy = devm_phy_optional_get(dev, "pcie-phy");
> +	if (IS_ERR(pcie->phy))
> +		return PTR_ERR(pcie->phy);

Once you've applied Bjorn's feedback you can add:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

I initially thought that you forgot to check for -ENODEV - though I can see
that the implementation of devm_phy_optional_get very helpfully does this for
us and returns NULL instead of an error.

What is also confusing is that devm_regulator_get_optional, despite its
_optional suffix doesn't do this and returns an error. I wonder if
devm_phy_optional_get should be changed to return NULL instead of an error
instead of -ENODEV. I've copied Liam/Mark for feedback.

Thanks,

Andrew Murray

>  
>  	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &resources,
>  						    &iobase);
> -- 
> 2.22.0
> 
