Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AE42B796A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 09:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgKRIuC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 03:50:02 -0500
Received: from gloria.sntech.de ([185.11.138.130]:58934 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbgKRIuB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 03:50:01 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kfJ9o-00056u-Q4; Wed, 18 Nov 2020 09:49:40 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chen-Yu Tsai <wens@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI: rockchip: Make 'ep-gpios' DT property optional
Date:   Wed, 18 Nov 2020 09:49:40 +0100
Message-ID: <1737702.WCGJIqnLLh@diego>
In-Reply-To: <20201118071724.4866-2-wens@kernel.org>
References: <20201118071724.4866-1-wens@kernel.org> <20201118071724.4866-2-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Mittwoch, 18. November 2020, 08:17:21 CET schrieb Chen-Yu Tsai:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Rockchip PCIe controller DT binding clearly states that 'ep-gpios' is
> an optional property. And indeed there are boards that don't require it.
> 
> Make the driver follow the binding by using devm_gpiod_get_optional()
> instead of devm_gpiod_get().
> 
> Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
> Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
> Fixes: 964bac9455be ("PCI: rockchip: Split out rockchip_pcie_parse_dt() to parse DT")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de


I'll pick up patches 2-4 separately, after giving Rob a chance to look at
the simple binding.


Heiko

> ---
> Changes since v1:
> 
>   - Rewrite subject to match existing convention and reference
>     'ep-gpios' DT property instead of the 'ep_gpio' field
> ---
>  drivers/pci/controller/pcie-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 904dec0d3a88..c95950e9004f 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -118,7 +118,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	}
>  
>  	if (rockchip->is_rc) {
> -		rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
> +		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep", GPIOD_OUT_HIGH);
>  		if (IS_ERR(rockchip->ep_gpio)) {
>  			dev_err(dev, "missing ep-gpios property in node\n");
>  			return PTR_ERR(rockchip->ep_gpio);
> 




