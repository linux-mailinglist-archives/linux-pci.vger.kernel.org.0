Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E170C2FB87B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 15:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387820AbhASMpd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 07:45:33 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53038 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731838AbhASJMB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 04:12:01 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l1n2U-0004qx-Qk; Tue, 19 Jan 2021 10:11:02 +0100
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
Subject: Re: [PATCH v3 1/4] PCI: rockchip: Make 'ep-gpios' DT property optional
Date:   Tue, 19 Jan 2021 10:11:01 +0100
Message-ID: <12687142.y0N7aAr316@diego>
In-Reply-To: <20210106134617.391-2-wens@kernel.org>
References: <20210106134617.391-1-wens@kernel.org> <20210106134617.391-2-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Mittwoch, 6. Januar 2021, 14:46:14 CET schrieb Chen-Yu Tsai:
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
> ---
> Heiko, I dropped you reviewed-by due to the error message change
> 
> Changes since v2:
>   - Fix error message for failed GPIO
> 
> Changes since v1:
>   - Rewrite subject to match existing convention and reference
>     'ep-gpios' DT property instead of the 'ep_gpio' field
> ---
>  drivers/pci/controller/pcie-rockchip.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 904dec0d3a88..90c957e3bc73 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -118,9 +118,10 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	}
>  
>  	if (rockchip->is_rc) {
> -		rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
> +		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep", GPIOD_OUT_HIGH);
>  		if (IS_ERR(rockchip->ep_gpio)) {
> -			dev_err(dev, "missing ep-gpios property in node\n");
> +			dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
> +				      "failed to get ep GPIO\n");
>  			return PTR_ERR(rockchip->ep_gpio);

looking at [0] shouldn't that be just
	return dev_err_probe(dev, PTR_ERR(.....)...);
instead of dev_err_probe + additional return?

Heiko

[0] https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L4223

>  		}
>  	}
> 




