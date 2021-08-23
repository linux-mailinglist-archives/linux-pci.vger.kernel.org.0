Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2463F4E1D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhHWQQS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 12:16:18 -0400
Received: from foss.arm.com ([217.140.110.172]:55018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhHWQQR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Aug 2021 12:16:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBB9F11D4;
        Mon, 23 Aug 2021 09:15:34 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F313E3F5A1;
        Mon, 23 Aug 2021 09:15:32 -0700 (PDT)
Date:   Mon, 23 Aug 2021 17:15:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip-dwc: Potential error pointer
 dereference in probe
Message-ID: <20210823161527.GA8289@lpieralisi>
References: <20210813141257.GB7722@kadam>
 <20210813142648.GA12057@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813142648.GA12057@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 05:26:48PM +0300, Dan Carpenter wrote:
> If devm_regulator_get_optional() returns -ENODEV then it would lead
> to an error pointer dereference on the next line and in the error
> handling code.
> 
> Fixes: e1229e884e19 ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: The -ENODEV from devm_regulator_get_optional() has to be handled
>     specially.
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

I squashed it in with the patch that is fixing, thanks a lot.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 20cef2e06f66..c9b341e55cbb 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -224,15 +224,17 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  
>  	/* DON'T MOVE ME: must be enable before PHY init */
>  	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> -	if (IS_ERR(rockchip->vpcie3v3))
> +	if (IS_ERR(rockchip->vpcie3v3)) {
>  		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
>  			return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
>  					"failed to get vpcie3v3 regulator\n");
> -
> -	ret = regulator_enable(rockchip->vpcie3v3);
> -	if (ret) {
> -		dev_err(dev, "failed to enable vpcie3v3 regulator\n");
> -		return ret;
> +		rockchip->vpcie3v3 = NULL;
> +	} else {
> +		ret = regulator_enable(rockchip->vpcie3v3);
> +		if (ret) {
> +			dev_err(dev, "failed to enable vpcie3v3 regulator\n");
> +			return ret;
> +		}
>  	}
>  
>  	ret = rockchip_pcie_phy_init(rockchip);
> @@ -255,7 +257,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  deinit_phy:
>  	rockchip_pcie_phy_deinit(rockchip);
>  disable_regulator:
> -	regulator_disable(rockchip->vpcie3v3);
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
>  
>  	return ret;
>  }
> -- 
> 2.20.1
> 
