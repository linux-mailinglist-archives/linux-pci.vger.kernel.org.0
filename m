Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3179A544C
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 12:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfIBKr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 06:47:59 -0400
Received: from foss.arm.com ([217.140.110.172]:52000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729806AbfIBKr7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Sep 2019 06:47:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9561928;
        Mon,  2 Sep 2019 03:47:58 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D76F03F246;
        Mon,  2 Sep 2019 03:47:57 -0700 (PDT)
Date:   Mon, 2 Sep 2019 11:47:56 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 6/6] arm64: tegra: Add PCIe slot supply information in
 p2972-0000 platform
Message-ID: <20190902104756.GE9720@e119886-lin.cambridge.arm.com>
References: <20190828172850.19871-1-vidyas@nvidia.com>
 <20190828172850.19871-7-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828172850.19871-7-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 10:58:50PM +0530, Vidya Sagar wrote:
> Add 3.3V and 12V supplies regulators information of x16 PCIe slot in
> p2972-0000 platform which is owned by C5 controller and also enable C5
> controller.
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
>  .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 24 +++++++++++++++++++
>  .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  4 +++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> index 62e07e1197cc..4c38426a6969 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> @@ -289,5 +289,29 @@
>  			gpio = <&gpio TEGRA194_MAIN_GPIO(A, 3) GPIO_ACTIVE_HIGH>;
>  			enable-active-high;
>  		};
> +
> +		vdd_3v3_pcie: regulator@2 {
> +			compatible = "regulator-fixed";
> +			reg = <2>;
> +
> +			regulator-name = "PEX_3V3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio TEGRA194_MAIN_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
> +			regulator-boot-on;
> +			enable-active-high;
> +		};
> +
> +		vdd_12v_pcie: regulator@3 {
> +			compatible = "regulator-fixed";
> +			reg = <3>;
> +
> +			regulator-name = "VDD_12V";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			gpio = <&gpio TEGRA194_MAIN_GPIO(A, 1) GPIO_ACTIVE_LOW>;
> +			regulator-boot-on;
> +			enable-active-low;
> +		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index 23597d53c9c9..d47cd8c4dd24 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -93,9 +93,11 @@
>  	};
>  
>  	pcie@141a0000 {
> -		status = "disabled";
> +		status = "okay";
>  
>  		vddio-pex-ctl-supply = <&vdd_1v8ao>;
> +		vpcie3v3-supply = <&vdd_3v3_pcie>;
> +		vpcie12v-supply = <&vdd_12v_pcie>;
>  
>  		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
>  		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
> -- 
> 2.17.1
> 
