Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD6FEA0C2D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 23:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfH1VJS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 17:09:18 -0400
Received: from foss.arm.com ([217.140.110.172]:36378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1VJS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 17:09:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9202A337;
        Wed, 28 Aug 2019 14:09:17 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A72323F718;
        Wed, 28 Aug 2019 14:09:16 -0700 (PDT)
Date:   Wed, 28 Aug 2019 22:09:14 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH 2/5] PCI: imx6: Properly handle optional regulators
Message-ID: <20190828210914.GD14582@e119886-lin.cambridge.arm.com>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828163636.12967-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 06:36:33PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> regulator_get_optional() can fail for a number of reasons besides probe
> deferral. It can for example return -ENOMEM if it runs out of memory as
> it tries to allocate data structures. Propagating only -EPROBE_DEFER is
> problematic because it results in these legitimately fatal errors being
> treated as "regulator not specified in DT".
> 
> What we really want is to ignore the optional regulators only if they
> have not been specified in DT. regulator_get_optional() returns -ENODEV
> in this case, so that's the special case that we need to handle. So we
> propagate all errors, except -ENODEV, so that real failures will still
> cause the driver to fail probe.
> 
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: kernel@pengutronix.de
> Cc: linux-imx@nxp.com
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 8b8efa3063f5..acfbd34032a8 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1174,8 +1174,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  
>  	imx6_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
>  	if (IS_ERR(imx6_pcie->vpcie)) {
> -		if (PTR_ERR(imx6_pcie->vpcie) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> +		if (PTR_ERR(imx6_pcie->vpcie) != -ENODEV)
> +			return PTR_ERR(imx6_pcie->vpcie);

Once you've applied Bjorn's feedback you can add:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

>  		imx6_pcie->vpcie = NULL;
>  	}
>  
> -- 
> 2.22.0
> 
