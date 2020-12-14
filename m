Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421472D9AC4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 16:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbgLNPUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 10:20:00 -0500
Received: from foss.arm.com ([217.140.110.172]:48952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgLNPTc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Dec 2020 10:19:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BF4E30E;
        Mon, 14 Dec 2020 07:18:44 -0800 (PST)
Received: from [10.57.33.60] (unknown [10.57.33.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A02D3F66E;
        Mon, 14 Dec 2020 07:18:42 -0800 (PST)
Subject: Re: [PATCH v2 3/4] arm64: dts: rockchip: nanopi4: Move ep-gpios
 property to nanopc-t4
To:     Chen-Yu Tsai <wens@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Johan Jonker <jbx6244@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20201118071724.4866-1-wens@kernel.org>
 <20201118071724.4866-4-wens@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1e41aefe-6875-d319-1922-210fb865631c@arm.com>
Date:   Mon, 14 Dec 2020 15:18:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201118071724.4866-4-wens@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-18 07:17, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Only the NanoPC T4 hs the PCIe reset pin routed to the SoC. For the
> NanoPi M4 family, no such signal is routed to the expansion header on
> the base board.
> 
> As the schematics for the expansion board were not released, it is
> unclear how this is handled, but the likely answer is that the signal
> is always pulled high.
> 
> Move the ep-gpios property from the common nanopi4.dtsi file to the
> board level nanopc-t4.dts file. This makes the nanopi-m4 lack ep-gpios,
> matching the board design.
> 
> A companion patch "PCI: rockchip: make ep_gpio optional" for the Linux
> driver is required, as the driver currently requires the property to be
> present.

I concur that this is a more correct description per the schematics (the 
SOM-RK3399 Dev Kit carrier board is the only other thing showing PERST# 
wired up like this), and whatever the M4 hats are doing they clearly 
aren't doing it with GPIO2_A4 either way.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: e7a095908227 ("arm64: dts: rockchip: Add devicetree for NanoPC-T4")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts | 1 +
>   arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi  | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
> index e0d75617bb7e..452728b82e42 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
> @@ -95,6 +95,7 @@ map3 {
>   };
>   
>   &pcie0 {
> +	ep-gpios = <&gpio2 RK_PA4 GPIO_ACTIVE_HIGH>;
>   	num-lanes = <4>;
>   	vpcie3v3-supply = <&vcc3v3_sys>;
>   };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> index 76a8b40a93c6..48ed4aaa37f3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> @@ -504,7 +504,6 @@ &pcie_phy {
>   };
>   
>   &pcie0 {
> -	ep-gpios = <&gpio2 RK_PA4 GPIO_ACTIVE_HIGH>;
>   	max-link-speed = <2>;
>   	num-lanes = <2>;
>   	vpcie0v9-supply = <&vcca0v9_s3>;
> 
