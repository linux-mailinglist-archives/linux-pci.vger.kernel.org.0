Return-Path: <linux-pci+bounces-19228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3F4A00A7D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 15:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AF2160BBC
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0710E1EE7BA;
	Fri,  3 Jan 2025 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogVam2JW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194D1494A7;
	Fri,  3 Jan 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735914350; cv=none; b=LUDbFuts3SdXQ0gOce4rVjFz8WUyPBK1MUcvLIICgr4ZWet3zVOMzAkJDrKoBiZV4XlXlVnnPh20mGapKQXko9q2xAWACBRp8wcCeqbPE/ElfKipy7r1PhEPp4VVcJVaJ7hucmJJ48pAOJddislo+FYsB0ksdVE+AzuKNxjDoec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735914350; c=relaxed/simple;
	bh=nh7JFxsfxQk/ZlfligC+BkTw6ydpwOx0Jol1iFdUeGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvNKp4lnfl7HW1Odyjp32YBNpFMpB5VTsCY9fAKJYyv25Mk6HMF+FOWXJ05Z7jyB9mPehyUlrzNImu6N8Eo2dCoy54WkfCXwjPqO7Mdy1PWq1ycEB2fCppMqX0/DmgQ9LPuZBmQueVjCCTppAOT7gNXD/BMgxA7mElJOtla0hVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogVam2JW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B28C4CECE;
	Fri,  3 Jan 2025 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735914350;
	bh=nh7JFxsfxQk/ZlfligC+BkTw6ydpwOx0Jol1iFdUeGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ogVam2JWPIRaE878ZGs/aogLDJfox/EtVWaAZuVw+Zxb9KIjuJtCNkoApK4nh8Ab8
	 UGaYuDRkJ1XJIA/Sqf4MOQXazdRELeumYKfDnfWnursfiEB6iWVXWg4kqnwi78aSmv
	 16LiUBac3t1IJ6VaKmA28f60l4aK81WtxgaIS8jVAoNzjazRZyjALUaH1FjVgw/heJ
	 8VwFJKbonb3+b/GHTbjLptdGr5cfHmB+z7DPajd/sPe4PHkQ//GaXhah07pXsPttVF
	 Q6hEq54Nn9bQNVicnILk0MbDI5x3sMk2Dgza2PI/KZ72mvF11p5VGftOKVJOC+tlAb
	 /ijFzh+Zv6LJQ==
Date: Fri, 3 Jan 2025 15:25:45 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <Z3fzad51PIxccDGX@ryzen>
References: <20240809073610.2517-1-linux.amoon@gmail.com>
 <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>

Hello Anand,

On Fri, Jan 03, 2025 at 07:24:07PM +0530, Anand Moon wrote:
> 
> Thanks for testing this patch.
> 
> This patch should have been tested on hardware that includes all the
> relevant controllers,
> such as PCI 2.0, PCI 3.0, and the SATA controller.
> I will test this patch again on all the Radxa devices I have.
> 
> This patch's dependency lies in deferring the probe until the PHY
> controller initializes.
> 
> CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=m


Note that the splat, as reported in this thread, and in:
https://lore.kernel.org/netdev/20250101235122.704012-1-francesco@valla.it/T/

is related to the network PHY (CONFIG_REALTEK_PHY) on the RTL8125 NIC,
which is connected to one of the PCIe Gen2 controllers, not the PCIe PHY
on the PCIe controller (CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY) itself.

For the record, I run with all the relevant drivers as built-in:
CONFIG_PCIE_ROCKCHIP_DW_HOST=y
CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=y (for the PCIe Gen2 controllers)
CONFIG_PHY_ROCKCHIP_SNPS_PCIE3=y (for the PCIe Gen3 controllers)
CONFIG_R8169=y
CONFIG_REALTEK_PHY=y


> 
> To my surprise, we have not enabled mdio on Rock-5B boards.
> can you check if these changes work on your end?

I think these changes are wrong, at least for rock5b.

On rock5b the RTL8125 NIC is connected via PCI, and PCI devices should not
be specified in device tree, as PCI is a bus that can be enumerated.


> 
> -----8<----------8<----------8<----------8<----------8<----------8<-----
> alarm@rock-5b:/media/nvme0/mainline/linux-rockchip-6.y-devel$ git diff
>    arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index c44d001da169..5008a05efd2a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -155,6 +155,19 @@ vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
>         };
>  };
> 
> +&mdio1 {
> +       rgmii_phy1: ethernet-phy@1 {
> +               /* RTL8211F */
> +               compatible = "ethernet-phy-id001c.c916";
> +               reg = <0x1>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&rtl8211f_rst>;
> +               reset-assert-us = <20000>;
> +               reset-deassert-us = <100000>;
> +               reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> +       };
> +};
> +
>  &combphy0_ps {
>         status = "okay";
>  };
> @@ -224,6 +237,21 @@ &hdptxphy_hdmi0 {
>         status = "okay";
>  };
> 
> +&gmac1 {
> +       clock_in_out = "output";
> +       phy-handle = <&rgmii_phy1>;
> +       phy-mode = "rgmii";
> +       pinctrl-0 = <&gmac1_miim
> +                    &gmac1_tx_bus2
> +                    &gmac1_rx_bus2
> +                    &gmac1_rgmii_clk
> +                    &gmac1_rgmii_bus>;
> +       pinctrl-names = "default";
> +       tx_delay = <0x3a>;
> +       rx_delay = <0x3e>;
> +       status = "okay";
> +};
> +
>  &i2c0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&i2c0m2_xfer>;
> @@ -419,6 +447,12 @@ pcie3_vcc3v3_en: pcie3-vcc3v3-en {
>                 };
>         };
> 
> +       rtl8211f {
> +               rtl8211f_rst: rtl8211f-rst {
> +                       rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
>         usb {
>                 vcc5v0_host_en: vcc5v0-host-en {
>                         rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> >
> > Kind regards,
> > Niklas
> 
> Can you check this on your end
> 
> alarm@rock-5b:~$ sudo cat /sys/kernel/debug/devices_deferred
> [sudo] password for alarm:
> fc400000.usb    dwc3: failed to initialize core
> alarm@rock-5b:~$ sudo cat /sys/kernel/debug/devices_deferred

Sure:
# cat /sys/kernel/debug/devices_deferred
fc400000.usb    dwc3: failed to initialize core


Kind regards,
Niklas

