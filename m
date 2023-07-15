Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7965C754A2D
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jul 2023 18:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjGOQp1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jul 2023 12:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOQp0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Jul 2023 12:45:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5341720;
        Sat, 15 Jul 2023 09:45:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fd32e611e0so1547199e87.0;
        Sat, 15 Jul 2023 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689439523; x=1692031523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwMjCMmgFy+bMl1QJUCT4Klvjl5MSrobMO0CXLv/rL0=;
        b=AM1M8mOZjpDYu0Mp1emKj57echxJen7yUrTluBU8QOKNMDqGadR/nImML+xWrYKNKe
         G79/7KJAvQUDuqK6pF1N9n0yABzg3LVUQVIF2sMWxqhG0EmIqGHjKn561KTeL4cf/o4j
         EYXR0Y4Csgdrn4Z5U2Dt+CnsJ4NMU/cmk8FiKBOQ3leLXk45UY29qfZOPVeW7HZdSaQD
         cLLnUpYU1E0lUbspouZDgJBp1BlWJ1Jw0pOp0vh1cVHi5HvaLlwjDYMZENAHf/bgoABS
         GoI0f9BONy4Ud/ZnouQPndIj+XDuNI10kFVhByIC9+g6fa41P4DBMLSAFQBP3Nwbojm9
         FwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689439523; x=1692031523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwMjCMmgFy+bMl1QJUCT4Klvjl5MSrobMO0CXLv/rL0=;
        b=lJuejaN0vSzTOUMsKtQk9GcehJk5zEypzyqjeya3Ufydw2lPVv4hacsiDrkDN222oU
         Z2V/idzOPd+K/rrkZ28Z96Ib4MSfnnELSKXAq5+FZ5RoDtPKnQA06oKCwvCDTbSVu/q+
         02sJjw8PM6OsvA6s4DyJ4bPw01ge/OZPKeXVSghpYzeJOm/i3voPllfisntnTkzaCJ/Z
         wvGOqNOK4S8q9f+NmPSCOZdjrTxQyfcgnU6h/RzNJvV763u05rLjgcPLYmNg227HMk2G
         seSS1oQgsvQjGTuMieEmOyJvVRlhD7troKkDU6ri28VXfAbgxdqEZFzPuDeO8PN+EBmp
         zOgg==
X-Gm-Message-State: ABy/qLY2kwfQp5GK7JVZSS9ZA36XAf78qs6qRUdU3BSI8I1mW/Ny67zV
        +IIum9BASCZiDNOQb02vPXA=
X-Google-Smtp-Source: APBJJlGykHR1KvoejifoTKBZ04W1CPB9vcJDULQA1JDvD+8gffcDEF1Tbfbi2KwGO78902M25vRQEw==
X-Received: by 2002:a05:6512:15a2:b0:4f9:5807:aba7 with SMTP id bp34-20020a05651215a200b004f95807aba7mr2155118lfb.27.1689439522939;
        Sat, 15 Jul 2023 09:45:22 -0700 (PDT)
Received: from mobilestation ([85.249.20.164])
        by smtp.gmail.com with ESMTPSA id p17-20020a19f011000000b004fbb2080185sm1921535lfc.213.2023.07.15.09.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 09:45:22 -0700 (PDT)
Date:   Sat, 15 Jul 2023 19:45:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, John Clark <inindev@gmail.com>,
        Qu Wenruo <wqu@suse.com>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 2/2] arm64: dts: rockchip: rk3588: add PCIe3 support
Message-ID: <ypdmpxzpl7plcxzlgyhtx7zmyx4u25y7enivu2om3n3rtm4eas@o4xpm2guoope>
References: <20230714175331.112923-1-sebastian.reichel@collabora.com>
 <20230714175331.112923-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714175331.112923-3-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 14, 2023 at 07:53:31PM +0200, Sebastian Reichel wrote:
> Add both PCIe3 controllers together with the shared PHY.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588.dtsi | 128 +++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> index 4d66ca6c2e4c..af6f52afbaff 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> @@ -7,6 +7,11 @@
>  #include "rk3588-pinctrl.dtsi"
>  
>  / {
> +	pcie30_phy_grf: syscon@fd5b8000 {
> +		compatible = "rockchip,rk3588-pcie3-phy-grf", "syscon";
> +		reg = <0x0 0xfd5b8000 0x0 0x10000>;
> +	};
> +
>  	pipe_phy1_grf: syscon@fd5c0000 {
>  		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
>  		reg = <0x0 0xfd5c0000 0x0 0x100>;
> @@ -80,6 +85,116 @@ i2s10_8ch: i2s@fde00000 {
>  		status = "disabled";
>  	};
>  
> +	pcie3x4: pcie@fe150000 {
> +		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x00 0x0f>;
> +		clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
> +			 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
> +			 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>;
> +		clock-names = "aclk_mst", "aclk_slv",
> +			      "aclk_dbi", "pclk",
> +			      "aux", "pipe";
> +		device_type = "pci";
> +		interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie3x4_intc 0>,
> +				<0 0 0 2 &pcie3x4_intc 1>,
> +				<0 0 0 3 &pcie3x4_intc 2>,
> +				<0 0 0 4 &pcie3x4_intc 3>;
> +		linux,pci-domain = <0>;

> +		num-ib-windows = <16>;
> +		num-ob-windows = <16>;
> +		num-viewport = <8>;

These are marked as deprecated in the bindings and unused by the
driver anyway. The DW PCIe core driver auto-detects a number of
available iATU memory windows. So you can freely drop these
properties.

> +		max-link-speed = <3>;
> +		msi-map = <0x0000 &its1 0x0000 0x1000>;
> +		num-lanes = <4>;
> +		phys = <&pcie30phy>;
> +		phy-names = "pcie-phy";
> +		power-domains = <&power RK3588_PD_PCIE>;
> +		ranges = <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 0x00100000>,
> +			 <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 0x00e00000>,
> +			 <0x03000000 0x0 0x40000000 0x9 0x00000000 0x0 0x40000000>;
> +		reg = <0xa 0x40000000 0x0 0x00400000>,
> +		      <0x0 0xfe150000 0x0 0x00010000>,
> +		      <0x0 0xf0000000 0x0 0x00100000>;
> +		reg-names = "dbi", "apb", "config";
> +		resets = <&cru SRST_PCIE0_POWER_UP>, <&cru SRST_P_PCIE0>;
> +		reset-names = "pwr", "pipe";
> +		rockchip,pipe-grf = <&php_grf>;
> +		status = "disabled";
> +
> +		pcie3x4_intc: legacy-interrupt-controller {
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 260 IRQ_TYPE_EDGE_RISING 0>;
> +		};
> +	};
> +
> +	pcie3x2: pcie@fe160000 {
> +		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x10 0x1f>;
> +		clocks = <&cru ACLK_PCIE_2L_MSTR>, <&cru ACLK_PCIE_2L_SLV>,
> +			 <&cru ACLK_PCIE_2L_DBI>, <&cru PCLK_PCIE_2L>,
> +			 <&cru CLK_PCIE_AUX1>, <&cru CLK_PCIE2L_PIPE>;
> +		clock-names = "aclk_mst", "aclk_slv",
> +			      "aclk_dbi", "pclk",
> +			      "aux", "pipe";
> +		device_type = "pci";
> +		interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie3x2_intc 0>,
> +				<0 0 0 2 &pcie3x2_intc 1>,
> +				<0 0 0 3 &pcie3x2_intc 2>,
> +				<0 0 0 4 &pcie3x2_intc 3>;
> +		linux,pci-domain = <1>;

> +		num-ib-windows = <16>;
> +		num-ob-windows = <16>;
> +		num-viewport = <8>;

ditto

-Serge(y)

> +		max-link-speed = <3>;
> +		msi-map = <0x1000 &its1 0x1000 0x1000>;
> +		num-lanes = <2>;
> +		phys = <&pcie30phy>;
> +		phy-names = "pcie-phy";
> +		power-domains = <&power RK3588_PD_PCIE>;
> +		ranges = <0x01000000 0x0 0xf1100000 0x0 0xf1100000 0x0 0x00100000>,
> +			 <0x02000000 0x0 0xf1200000 0x0 0xf1200000 0x0 0x00e00000>,
> +			 <0x03000000 0x0 0x40000000 0x9 0x40000000 0x0 0x40000000>;
> +		reg = <0xa 0x40400000 0x0 0x00400000>,
> +		      <0x0 0xfe160000 0x0 0x00010000>,
> +		      <0x0 0xf1000000 0x0 0x00100000>;
> +		reg-names = "dbi", "apb", "config";
> +		resets = <&cru SRST_PCIE1_POWER_UP>, <&cru SRST_P_PCIE1>;
> +		reset-names = "pwr", "pipe";
> +		rockchip,pipe-grf = <&php_grf>;
> +		status = "disabled";
> +
> +		pcie3x2_intc: legacy-interrupt-controller {
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 255 IRQ_TYPE_EDGE_RISING 0>;
> +		};
> +	};
> +
>  	pcie2x1l0: pcie@fe170000 {
>  		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
>  		#address-cells = <3>;
> @@ -221,4 +336,17 @@ combphy1_ps: phy@fee10000 {
>  		rockchip,pipe-phy-grf = <&pipe_phy1_grf>;
>  		status = "disabled";
>  	};
> +
> +	pcie30phy: phy@fee80000 {
> +		compatible = "rockchip,rk3588-pcie3-phy";
> +		reg = <0x0 0xfee80000 0x0 0x20000>;
> +		#phy-cells = <0>;
> +		clocks = <&cru PCLK_PCIE_COMBO_PIPE_PHY>;
> +		clock-names = "pclk";
> +		resets = <&cru SRST_PCIE30_PHY>;
> +		reset-names = "phy";
> +		rockchip,pipe-grf = <&php_grf>;
> +		rockchip,phy-grf = <&pcie30_phy_grf>;
> +		status = "disabled";
> +	};
>  };
> -- 
> 2.40.1
> 
