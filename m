Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80AAEA5446
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 12:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfIBKpz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 06:45:55 -0400
Received: from foss.arm.com ([217.140.110.172]:51944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730013AbfIBKpz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Sep 2019 06:45:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FC1D28;
        Mon,  2 Sep 2019 03:45:54 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636DA3F246;
        Mon,  2 Sep 2019 03:45:53 -0700 (PDT)
Date:   Mon, 2 Sep 2019 11:45:51 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 5/6] arm64: tegra: Add configuration for PCIe C5
 sideband signals
Message-ID: <20190902104551.GD9720@e119886-lin.cambridge.arm.com>
References: <20190828172850.19871-1-vidyas@nvidia.com>
 <20190828172850.19871-6-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828172850.19871-6-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 10:58:49PM +0530, Vidya Sagar wrote:
> Add support to configure PCIe C5's sideband signals PERST# and CLKREQ#
> as output and bi-directional signals respectively which unlike other
> PCIe controllers sideband signals are not configured by default.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> ---
> V3:
> * None
> 
> V2:
> * None
> 
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 38 +++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index adebbbf36bd0..3c0cf54f0aab 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -3,8 +3,9 @@
>  #include <dt-bindings/gpio/tegra194-gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/mailbox/tegra186-hsp.h>
> -#include <dt-bindings/reset/tegra194-reset.h>
> +#include <dt-bindings/pinctrl/pinctrl-tegra.h>
>  #include <dt-bindings/power/tegra194-powergate.h>
> +#include <dt-bindings/reset/tegra194-reset.h>
>  #include <dt-bindings/thermal/tegra194-bpmp-thermal.h>
>  
>  / {
> @@ -130,6 +131,38 @@
>  			};
>  		};
>  
> +		pinmux: pinmux@2430000 {
> +			compatible = "nvidia,tegra194-pinmux";
> +			reg = <0x2430000 0x17000
> +			       0xc300000 0x4000>;
> +
> +			status = "okay";
> +
> +			pex_rst_c5_out_state: pex_rst_c5_out {
> +				pex_rst {
> +					nvidia,pins = "pex_l5_rst_n_pgg1";
> +					nvidia,schmitt = <TEGRA_PIN_DISABLE>;
> +					nvidia,lpdr = <TEGRA_PIN_ENABLE>;
> +					nvidia,enable-input = <TEGRA_PIN_DISABLE>;
> +					nvidia,io-high-voltage = <TEGRA_PIN_ENABLE>;
> +					nvidia,tristate = <TEGRA_PIN_DISABLE>;
> +					nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> +				};
> +			};
> +
> +			clkreq_c5_bi_dir_state: clkreq_c5_bi_dir {
> +				clkreq {
> +					nvidia,pins = "pex_l5_clkreq_n_pgg0";
> +					nvidia,schmitt = <TEGRA_PIN_DISABLE>;
> +					nvidia,lpdr = <TEGRA_PIN_ENABLE>;
> +					nvidia,enable-input = <TEGRA_PIN_ENABLE>;
> +					nvidia,io-high-voltage = <TEGRA_PIN_ENABLE>;
> +					nvidia,tristate = <TEGRA_PIN_DISABLE>;
> +					nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> +				};
> +			};
> +		};
> +
>  		uarta: serial@3100000 {
>  			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
>  			reg = <0x03100000 0x40>;
> @@ -1365,6 +1398,9 @@
>  		num-viewport = <8>;
>  		linux,pci-domain = <5>;
>  
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pex_rst_c5_out_state>, <&clkreq_c5_bi_dir_state>;
> +
>  		clocks = <&bpmp TEGRA194_CLK_PEX1_CORE_5>,
>  			<&bpmp TEGRA194_CLK_PEX1_CORE_5M>;
>  		clock-names = "core", "core_m";
> -- 
> 2.17.1
> 
