Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A4C47006E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 13:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbhLJMK3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 07:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbhLJMK2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 07:10:28 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC4FC0617A2
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 04:06:53 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id iq11so6703126pjb.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 04:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3A4XI+OFHkyTdDyIpE0tdpctLpghaRi+j3fzJm/k30s=;
        b=NxQO28OFAuO1x8qjWF6ClHK13UOKJcSviAZySdHLBXdSYHiauW02iC2EoRwL7haQlC
         ca+qRFCH80Ilal+g/OQz+DdOnDtPvdE8By0Gz6WT6mw+DbyoAJWYyVX35cr6NEmsx30r
         92ATxeNcv/eIBmrbrfF1JnKHvHKRYJ+TeUTl164OK1luGH2Yp4YETlFZxLXqxPT3okOK
         DQJv6d42Jb8Gf9GV2OhWk3/5aVMB06dJPSx8MR+BI1GFMMuba7mpOiDFc9F3utLyiZgE
         QJwG2Lat6CfcbvWCXyC54RwTQclJic4ufQJNOtTTGZy5/DZvtJjLgyWA1CHN4rG/HI69
         hw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3A4XI+OFHkyTdDyIpE0tdpctLpghaRi+j3fzJm/k30s=;
        b=xYoyV75fcJg/Wt6V7UGDmiNYB7M4DFpSAyRuqV3Q2qpgUCrAw0N6Sz70Jwhr0P34hx
         7GhGVLoCaaMqIieJSc3VTjdB8ZwT3EuslUyiF5HSLDYqxHt3QtDdCc2L8JF6KS2ME8wZ
         c1rFZjrL/krtTYUgT58ptb4fjfkz6Eci8EU1jeNggpIiufefgl0Aw6uT55sNIxpIjCI8
         mX6u0QlLPCmsTrmpuz9AXdvg9GQM5SImoJbDgoWv0CqH3KrHzdDUUZV40BRbc5PkQHt7
         5LkVstG0hLVXnPMxnMDAJNUpIdXyxWJfB7CT7G5Q3qEzqpJsVcBVXPiHWOHyl499jPuc
         HaZw==
X-Gm-Message-State: AOAM533I2TDovfFwEoHPCUOeNDsNbvtHqWy2/8vF4qEpGQzshMBKtqXT
        7+0fbDAkBiQ7KctgygQ4GOTO
X-Google-Smtp-Source: ABdhPJx7NRQ9KL4sHfSAmZceTnS+zlwI6FhjUAfWc3FXiSkZtyVwqnhSfrm25oAxMvD0xotqRn+QyQ==
X-Received: by 2002:a17:902:bcc4:b0:141:bfc4:ada with SMTP id o4-20020a170902bcc400b00141bfc40adamr74670339pls.20.1639138013322;
        Fri, 10 Dec 2021 04:06:53 -0800 (PST)
Received: from thinkpad ([202.21.42.75])
        by smtp.gmail.com with ESMTPSA id j20sm12273440pjl.3.2021.12.10.04.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:06:52 -0800 (PST)
Date:   Fri, 10 Dec 2021 17:36:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 08/10] arm64: dts: qcom: sm8450: add PCIe0 RC device
Message-ID: <20211210120644.GH1734@thinkpad>
References: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
 <20211208171442.1327689-9-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208171442.1327689-9-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 08, 2021 at 08:14:40PM +0300, Dmitry Baryshkov wrote:
> Add device tree node for the first PCIe host found on the Qualcomm
> SM8450 platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 101 +++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index a047d8a22897..09087a34a007 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -627,6 +627,84 @@ i2c14: i2c@a98000 {
>  				#size-cells = <0>;
>  				status = "disabled";
>  			};
> +		];
> +
> +		pcie0: pci@1c00000 {
> +			compatible = "qcom,pcie-sm8450";
> +			reg = <0 0x01c00000 0 0x3000>,
> +			      <0 0x60000000 0 0xf1d>,
> +			      <0 0x60000f20 0 0xa8>,
> +			      <0 0x60001000 0 0x1000>,
> +			      <0 0x60100000 0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
> +
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
> +				 <&pcie0_lane>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>;
> +			clock-names = "pipe",
> +				      "pipe_mux",
> +				      "phy_pipe",
> +				      "ref",
> +				      "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ddrss_sf_tbu",
> +				      "aggre0",
> +				      "aggre1";
> +
> +			iommus = <&apps_smmu 0x1c00 0x7f>;
> +			iommu-map = <0x0   &apps_smmu 0x1c00 0x1>,
> +				    <0x100 &apps_smmu 0x1c01 0x1>;
> +
> +			resets = <&gcc GCC_PCIE_0_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_0_GDSC>;
> +			power-domain-names = "gdsc";
> +
> +			phys = <&pcie0_lane>;
> +			phy-names = "pciephy";
> +
> +			perst-gpio = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +			enable-gpio = <&tlmm 96 GPIO_ACTIVE_HIGH>;

Wondering if this configuration varies between boards. If then, this should be
moved to board dts. Other than this,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pcie0_default_state>;
> +
> +			interconnects = <&pcie_noc MASTER_PCIE_0 &mc_virt SLAVE_EBI1>;
> +			interconnect-names = "pci";
> +
> +			status = "disabled";
>  		};
>  
>  		pcie0_phy: phy@1c06000 {
> @@ -763,6 +841,29 @@ tlmm: pinctrl@f100000 {
>  			gpio-ranges = <&tlmm 0 0 211>;
>  			wakeup-parent = <&pdc>;
>  
> +			pcie0_default_state: pcie0-default {
> +				perst {
> +					pins = "gpio94";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +
> +				clkreq {
> +					pins = "gpio95";
> +					function = "pcie0_clkreqn";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +
> +				wake {
> +					pins = "gpio96";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
>  			qup_i2c13_default_state: qup-i2c13-default-state {
>  				mux {
>  					pins = "gpio48", "gpio49";
> -- 
> 2.33.0
> 
