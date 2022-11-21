Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32036321A2
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 13:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiKUMLj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 07:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiKUMLi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 07:11:38 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7671971F21
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 04:11:37 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id c1so18521606lfi.7
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 04:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7qhOMct1HtHorGbIWxyZEdTxvsTx5R3VBHmP3l2woMg=;
        b=rOgOeCRWpjxZg5nXP82q7tc9S0QzvizVoefqoQzE2Q7H86DBuFTopuoD1mNZ5sPC4w
         92LR2HCe2f0niGUYjXVAgkj3CgjHkIIJP4c/FaNkPVIYy1kwyTkuXSkoLygGnmvi/jst
         imcQn5rkWlnFProwvMfFtxz5Hy9UDchjTMZGqJdQcNGdSkPZCzKKueQiMuiUhbuzPyKj
         DTJLiye9/PufyxJsnjqipi7wyoayFR5DAInUve/lu0v07p92+EvTAYJMpWwk/7ImGKK/
         MwIant5rN7BDSi0jJdmn094NsfnOvSb7KBWDqtHLQYrNl06EDQK81HZhMyEoOVgry0Xm
         A6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qhOMct1HtHorGbIWxyZEdTxvsTx5R3VBHmP3l2woMg=;
        b=NR4Qi8BnmWaqRReZNqqWA7rYmr62ZbiQsZPEuuVP4r++Idh8Fl07bjSjnYtpO+Ognt
         sTjZXrN5o7QigWSQRGfMTY2duugb5CyJQNWtJaDJDieBa7qr/5TYjo/ZWDpvNxXuSNe2
         Nd2fKWozaJfVAri5XBaqH14JQHB8mZUaHbAa+Edq63XXxh8AQVQmPcU/wZFkqUY4kdPH
         nhrv6svFmm/BkZbap5BIEDEwtuhbKkdirV5QrfCnGV6Yj6WeG7IS4iNdL+KjmKuIHviC
         Due38aL7EuRCqGvWL3psCPkUkBBLp+nHIj6YFrEepPAXdn/Rwwy6dpgnPabouQKgifYh
         6Vwg==
X-Gm-Message-State: ANoB5pkFQVbSKLg0swhvT9JOI39M6A1OnS+Ys42Qr6nwJG1niT3pddOc
        C/FPsA2uvquxKdQVTLIiTlN2UA==
X-Google-Smtp-Source: AA0mqf7xZ0mWUdJCN+6VFR2cUJVKZcxOD17BCaNQ2fbAP6LUKcuL2AlNDQkkD7XCO/YE1IbrdhUIRw==
X-Received: by 2002:ac2:58ca:0:b0:4b4:eed:ec3e with SMTP id u10-20020ac258ca000000b004b40eedec3emr5710487lfo.446.1669032695820;
        Mon, 21 Nov 2022 04:11:35 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w2-20020a19c502000000b004a05767bc07sm1996327lfe.28.2022.11.21.04.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:11:35 -0800 (PST)
Message-ID: <0149c0e5-f3d6-1e15-cadb-5b88ed4b3dbf@linaro.org>
Date:   Mon, 21 Nov 2022 13:11:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/6] arm64: dts: fsd: Add PCIe support for Tesla FSD SoC
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, mani@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, rcsekar@samsung.com,
        sriranjani.p@samsung.com, bharat.uppal@samsung.com,
        s.prashar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        niyas.ahmed@samsung.com, chanho61.park@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20221121105210.68596-1-shradha.t@samsung.com>
 <CGME20221121104741epcas5p31e1320bc4c0912485c1fabe52ea19988@epcas5p3.samsung.com>
 <20221121105210.68596-6-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121105210.68596-6-shradha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/11/2022 11:52, Shradha Todi wrote:
> Add the support for PCIe controller driver and phy driver
> for Tesla FSD. It includes support for both RC and EP.
> 
> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd-evb.dts      |  48 ++++++
>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi |  65 ++++++++
>  arch/arm64/boot/dts/tesla/fsd.dtsi         | 171 +++++++++++++++++++++
>  3 files changed, 284 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> index 1db6ddf03f01..cda72b0f76f8 100644
> --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> @@ -41,3 +41,51 @@
>  &ufs {
>  	status = "okay";
>  };
> +
> +&pcie_phy0 {
> +	status = "disabled";

It's a double disable, isn't it?

> +};
> +
> +&pcie_phy1 {
> +	status = "disabled";
> +};
> +
> +&pcie4_rc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_clkreq>, <&pcie1_wake>, <&pcie1_preset>,
> +			<&pcie0_slot1>;
> +	status = "disabled";

???

> +};
> +
> +&pcie4_ep {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_clkreq>, <&pcie1_wake>, <&pcie1_preset>,
> +			<&pcie0_slot1>;
> +	status = "disabled";
> +};
> +
> +&pcie0_rc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake0>, <&pcie0_preset0>,
> +			 <&pcie0_slot0>;
> +	status = "disabled";
> +};
> +
> +&pcie0_ep {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake0>, <&pcie0_preset0>,
> +			 <&pcie0_slot0>;
> +	status = "disabled";
> +};
> +
> +&pcie1_rc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake1>, <&pcie0_preset0>;
> +	status = "disabled";
> +};
> +
> +&pcie1_ep {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake1>, <&pcie0_preset0>;
> +	status = "disabled";

Ordering is broken. All overrides/extends are ordered by label name.

> +};
> diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> index d0abb9aa0e9e..edae62dfa987 100644
> --- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> @@ -64,6 +64,27 @@
>  		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
>  		samsung,pin-drv = <FSD_PIN_DRV_LV2>;
>  	};
> +
> +	pcie1_clkreq: pcie1-clkreq {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

(...)

>  
>  &pinctrl_pmu {
> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
> index f35bc5a288c2..2177f6964553 100644
> --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> @@ -32,6 +32,14 @@
>  		spi0 = &spi_0;
>  		spi1 = &spi_1;
>  		spi2 = &spi_2;
> +		pciephy0 = &pcie_phy0;
> +		pciephy1 = &pcie_phy1;
> +		pcierc0 = &pcie0_rc;
> +		pcieep0 = &pcie0_ep;
> +		pcierc1 = &pcie1_rc;
> +		pcieep1 = &pcie1_ep;
> +		pcierc2 = &pcie4_rc;
> +		pcieep2 = &pcie4_ep;

Since these are disabled, aliases do not belong to DTSI, but to board.

Also, explain why do you need them.

>  	};
>  
>  	cpus {
> @@ -860,6 +868,169 @@
>  			clocks = <&clock_fsys0 UFS0_MPHY_REFCLK_IXTAL26>;
>  			clock-names = "ref_clk";
>  		};
> +
> +		pcie_phy0: pcie-phy@15080000 {
> +			compatible = "tesla,fsd-pcie-phy";
> +			#phy-cells = <0>;
> +			reg = <0x0 0x15080000 0x0 0x2000>,
> +			      <0x0 0x150A0000 0x0 0x1000>;
> +			reg-names = "phy", "pcs";
> +			samsung,pmureg-phandle = <&pmu_system_controller>;
> +			tesla,pcie-sysreg = <&sysreg_fsys0>;
> +			phy-mode = <0>;
> +			status = "disabled";
> +		};
> +
> +		pcie_phy1: pcie-phy@16880000 {
> +			compatible = "tesla,fsd-pcie-phy";
> +			#phy-cells = <0>;
> +			reg = <0x0 0x16880000 0x0 0x2000>,
> +			      <0x0 0x16860000 0x0 0x1000>;
> +			reg-names = "phy", "pcs";
> +			samsung,pmureg-phandle = <&pmu_system_controller>;
> +			tesla,pcie-sysreg = <&sysreg_fsys1>;
> +			phy-mode = <0>;
> +			status = "disabled";
> +		};
> +
> +		pcie4_rc: pcie@15400000 {

Not ordered. Keep nodes sorted by unit address, at least within the
group of devices you add.

> +			compatible = "tesla,fsd-pcie";

reg is second property. reg-names and ranges follow.

> +			clocks = <&clock_fsys0 PCIE_SUBCTRL_INST0_AUX_CLK_SOC>,
> +				 <&clock_fsys0 PCIE_SUBCTRL_INST0_DBI_ACLK_SOC>,
> +				 <&clock_fsys0 PCIE_SUBCTRL_INST0_MSTR_ACLK_SOC>,
> +				 <&clock_fsys0 PCIE_SUBCTRL_INST0_SLV_ACLK_SOC>;
> +			clock-names = "aux_clk", "dbi_clk", "mstr_clk", "slv_clk";
> +			#address-cells = <3>;
> +			#size-cells = <2>;

Best regards,
Krzysztof

