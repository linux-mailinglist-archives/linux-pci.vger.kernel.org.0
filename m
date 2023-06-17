Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8DF73406A
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jun 2023 13:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjFQLIg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Jun 2023 07:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFQLIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Jun 2023 07:08:36 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693991722
        for <linux-pci@vger.kernel.org>; Sat, 17 Jun 2023 04:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=s1; bh=kSdb/lHB+3ih+VSQlmzyh6XZ/NXli7OIBoYYuu8Cufw=;
        b=bcI0QuLnUJTOtgdZTqzhhLRruVnZqsfg/um4ov/DYhsAy/8cp32tX50BVPPTUAbRnJqF
        ddIYFxIvMpSHcxqglb0JX0arSLrNuvECS5djPQCr2k6aYZk85mzLdXjMHN5ksfZbefo89o
        SYEDMOJLBZvUSo4glYurft6Q2N9KnH0Mxm8gyZdXNTTqL4phiKRiz1iSyUp/zthMsScqJO
        JThmslEur6smyncwjfqPWd0WweLSJ/V33pdLt3S0Np3gGPmszBfNtwgUiuXffYCeI8nL89
        7kEObxdqPagK9Pcx4CGInapTnEbAlAMYljrLUK99S9Li8LyekCRBnXt3gXgf/5IQ==
Received: by filterdrecv-66949dbc98-2h875 with SMTP id filterdrecv-66949dbc98-2h875-1-648D9430-15
        2023-06-17 11:08:32.542967934 +0000 UTC m=+3238133.466406997
Received: from [192.168.1.50] (unknown)
        by geopod-ismtpd-6 (SG) with ESMTP
        id 1ayzDbPESH2MEknCWup2WQ
        Sat, 17 Jun 2023 11:08:32.109 +0000 (UTC)
Message-ID: <e62fc14e-f06b-e979-8f92-db1451695358@kwiboo.se>
Date:   Sat, 17 Jun 2023 11:08:32 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 4/4] arm64: dts: rockchip: rk3588: add PCIe2 support
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
 <20230616170022.76107-5-sebastian.reichel@collabora.com>
Content-Language: en-US
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230616170022.76107-5-sebastian.reichel@collabora.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h51CekI0YDjjeuLZk?=
 =?us-ascii?Q?1rLxEDrvM81hUy0jITzmLCj93Zvh1XjElbcsZKX?=
 =?us-ascii?Q?yL=2FEwnLgHvNPAL81M6wPxoQL4XXG3kVpIYOWFgV?=
 =?us-ascii?Q?zQHtno7zT=2FGfnV7=2FLwS6sK+AwkAstxkfRms5Zn+?=
 =?us-ascii?Q?p9aWByBXLDB6d52AkvDrZ5THOR21xoyb186Wrm?=
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?iso-8859-2?q?Wilczy=F1ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, Kever Yang <kever.yang@rock-chips.com>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sebastian,

On 2023-06-16 19:00, Sebastian Reichel wrote:
> Add all three PCIe2 IP blocks to the RK3588 DT. Note, that RK3588
> also has two PCIe3 IP blocks, that will be handled separately.
> 
> Co-developed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588.dtsi  |  54 +++++++++++
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 108 ++++++++++++++++++++++
>  2 files changed, 162 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> index b9508cea34f1..40fee1367b34 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> @@ -80,6 +80,60 @@ i2s10_8ch: i2s@fde00000 {
>  		status = "disabled";
>  	};
>  
> +	pcie2x1l0: pcie@fe170000 {
> +		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x20 0x2f>;
> +		clocks = <&cru ACLK_PCIE_1L0_MSTR>, <&cru ACLK_PCIE_1L0_SLV>,
> +			 <&cru ACLK_PCIE_1L0_DBI>, <&cru PCLK_PCIE_1L0>,
> +			 <&cru CLK_PCIE_AUX2>, <&cru CLK_PCIE1L0_PIPE>;
> +		clock-names = "aclk_mst", "aclk_slv",
> +			      "aclk_dbi", "pclk",
> +			      "aux", "pipe";
> +		device_type = "pci";
> +		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie2x1l0_intc 0>,
> +				<0 0 0 2 &pcie2x1l0_intc 1>,
> +				<0 0 0 3 &pcie2x1l0_intc 2>,
> +				<0 0 0 4 &pcie2x1l0_intc 3>;
> +		linux,pci-domain = <2>;
> +		num-ib-windows = <8>;
> +		num-ob-windows = <8>;
> +		num-viewport = <4>;
> +		max-link-speed = <2>;
> +		msi-map = <0x2000 &its0 0x2000 0x1000>;
> +		num-lanes = <1>;
> +		phys = <&combphy1_ps PHY_TYPE_PCIE>;
> +		phy-names = "pcie-phy";
> +		power-domains = <&power RK3588_PD_PCIE>;
> +		ranges = <0x01000000 0x0 0xf2100000 0x0 0xf2100000 0x0 0x00100000>,
> +			 <0x02000000 0x0 0xf2200000 0x0 0xf2200000 0x0 0x00e00000>,
> +			 <0x03000000 0x9 0x80000000 0x9 0x80000000 0x0 0x40000000>;

For the RK356x [1] and for RK3588 in u-boot [2] the pci_addr range was
changed to be in 32-bit address space, start address at 0x40000000, to
make the 1 GB region available for 32-bit BARs. Something that possible
could/should be done here too?

E.g.:

  <0x03000000 0x0 0x40000000 0x9 0x80000000 0x0 0x40000000>

[1] https://lore.kernel.org/all/20230601132516.153934-1-frattaroli.nicolas@gmail.com/
[2] https://lore.kernel.org/u-boot/20230517100102.109855-1-eugen.hristev@collabora.com/

> +		reg = <0xa 0x40800000 0x0 0x00400000>,
> +		      <0x0 0xfe170000 0x0 0x00010000>,
> +		      <0x0 0xf2000000 0x0 0x00100000>;
> +		reg-names = "dbi", "apb", "config";
> +		resets = <&cru SRST_PCIE2_POWER_UP>, <&cru SRST_P_PCIE2>;
> +		reset-names = "pwr", "pipe";
> +		status = "disabled";
> +
> +		pcie2x1l0_intc: legacy-interrupt-controller {
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 240 IRQ_TYPE_EDGE_RISING 0>;
> +		};
> +	};
> +
>  	gmac0: ethernet@fe1b0000 {
>  		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
>  		reg = <0x0 0xfe1b0000 0x0 0x10000>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index a73b17f597af..b5fdc046d8f7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -1670,6 +1670,114 @@ qos_vop_m1: qos@fdf82200 {
>  		reg = <0x0 0xfdf82200 0x0 0x20>;
>  	};
>  
> +	pcie2x1l1: pcie@fe180000 {
> +		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x30 0x3f>;
> +		clocks = <&cru ACLK_PCIE_1L1_MSTR>, <&cru ACLK_PCIE_1L1_SLV>,
> +			 <&cru ACLK_PCIE_1L1_DBI>, <&cru PCLK_PCIE_1L1>,
> +			 <&cru CLK_PCIE_AUX3>, <&cru CLK_PCIE1L1_PIPE>;
> +		clock-names = "aclk_mst", "aclk_slv",
> +			      "aclk_dbi", "pclk",
> +			      "aux", "pipe";
> +		device_type = "pci";
> +		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie2x1l1_intc 0>,
> +				<0 0 0 2 &pcie2x1l1_intc 1>,
> +				<0 0 0 3 &pcie2x1l1_intc 2>,
> +				<0 0 0 4 &pcie2x1l1_intc 3>;
> +		linux,pci-domain = <3>;
> +		num-ib-windows = <8>;
> +		num-ob-windows = <8>;
> +		num-viewport = <4>;
> +		max-link-speed = <2>;
> +		msi-map = <0x3000 &its0 0x3000 0x1000>;
> +		num-lanes = <1>;
> +		phys = <&combphy2_psu PHY_TYPE_PCIE>;
> +		phy-names = "pcie-phy";
> +		power-domains = <&power RK3588_PD_PCIE>;
> +		ranges = <0x01000000 0x0 0xf3100000 0x0 0xf3100000 0x0 0x00100000>,
> +			 <0x02000000 0x0 0xf3200000 0x0 0xf3200000 0x0 0x00e00000>,
> +			 <0x03000000 0x9 0xc0000000 0x9 0xc0000000 0x0 0x40000000>;

And:

  <0x03000000 0x0 0x40000000 0x9 0xc0000000 0x0 0x40000000>

> +		reg = <0xa 0x40c00000 0x0 0x00400000>,
> +		      <0x0 0xfe180000 0x0 0x00010000>,
> +		      <0x0 0xf3000000 0x0 0x00100000>;
> +		reg-names = "dbi", "apb", "config";
> +		resets = <&cru SRST_PCIE3_POWER_UP>, <&cru SRST_P_PCIE3>;
> +		reset-names = "pwr", "pipe";
> +		status = "disabled";
> +
> +		pcie2x1l1_intc: legacy-interrupt-controller {
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 245 IRQ_TYPE_EDGE_RISING 0>;
> +		};
> +	};
> +
> +	pcie2x1l2: pcie@fe190000 {
> +		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x40 0x4f>;
> +		clocks = <&cru ACLK_PCIE_1L2_MSTR>, <&cru ACLK_PCIE_1L2_SLV>,
> +			 <&cru ACLK_PCIE_1L2_DBI>, <&cru PCLK_PCIE_1L2>,
> +			 <&cru CLK_PCIE_AUX4>, <&cru CLK_PCIE1L2_PIPE>;
> +		clock-names = "aclk_mst", "aclk_slv",
> +			      "aclk_dbi", "pclk",
> +			      "aux", "pipe";
> +		device_type = "pci";
> +		interrupts = <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie2x1l2_intc 0>,
> +				<0 0 0 2 &pcie2x1l2_intc 1>,
> +				<0 0 0 3 &pcie2x1l2_intc 2>,
> +				<0 0 0 4 &pcie2x1l2_intc 3>;
> +		linux,pci-domain = <4>;
> +		num-ib-windows = <8>;
> +		num-ob-windows = <8>;
> +		num-viewport = <4>;
> +		max-link-speed = <2>;
> +		msi-map = <0x4000 &its0 0x4000 0x1000>;
> +		num-lanes = <1>;
> +		phys = <&combphy0_ps PHY_TYPE_PCIE>;
> +		phy-names = "pcie-phy";
> +		power-domains = <&power RK3588_PD_PCIE>;
> +		ranges = <0x01000000 0x0 0xf4100000 0x0 0xf4100000 0x0 0x00100000>,
> +			 <0x02000000 0x0 0xf4200000 0x0 0xf4200000 0x0 0x00e00000>,
> +			 <0x03000000 0xa 0x00000000 0xa 0x00000000 0x0 0x40000000>;

And:

  <0x03000000 0x0 0x40000000 0xa 0x00000000 0x0 0x40000000>

Regards,
Jonas

> +		reg = <0xa 0x41000000 0x0 0x00400000>,
> +		      <0x0 0xfe190000 0x0 0x00010000>,
> +		      <0x0 0xf4000000 0x0 0x00100000>;
> +		reg-names = "dbi", "apb", "config";
> +		resets = <&cru SRST_PCIE4_POWER_UP>, <&cru SRST_P_PCIE4>;
> +		reset-names = "pwr", "pipe";
> +		status = "disabled";
> +
> +		pcie2x1l2_intc: legacy-interrupt-controller {
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 250 IRQ_TYPE_EDGE_RISING 0>;
> +		};
> +	};
> +
>  	gmac1: ethernet@fe1c0000 {
>  		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
>  		reg = <0x0 0xfe1c0000 0x0 0x10000>;

