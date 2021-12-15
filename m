Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432604765FE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 23:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhLOWfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 17:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhLOWfL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 17:35:11 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1128DC06173E
        for <linux-pci@vger.kernel.org>; Wed, 15 Dec 2021 14:35:11 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so26614643oto.13
        for <linux-pci@vger.kernel.org>; Wed, 15 Dec 2021 14:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DrRoCw7l3D7/9CGJqJ4R7z395m+W9pLZaas2T1HokPE=;
        b=NnwvJspKiha/Rl8EShdutwtVGV78a5SwE6iiRfdpg6nh16rmzSM5gJ+/nO6Tec754s
         Y+gJoXY+nfVXfAz/3jSJcy8Unl6Rw8RQz5Jdy9d8MJWogcfu6HTC6e7jn2GMnFzaytvS
         ANdWDvAcvCzezpQfZyjstxUGM2sGNaOM2c/GCjxckEGdPtyFhQ14LNcivyUglq/kiTqH
         dtEiNExkfzOR76VSEaKA6UjRyYsri8luOQqP/x+goQEfQaXyzSS63Oq83YDS99/u6hSA
         XlPXEZOCDQl+aRKFln1e7XIGHlp+7GMjaIcUDysbTURnRzbzsvr/BioiCpCQjUrU+7yI
         H+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DrRoCw7l3D7/9CGJqJ4R7z395m+W9pLZaas2T1HokPE=;
        b=EXKbxptIwX1Ir8Hq1EsKWBYwN6w2H1bA28VsIThEFzu8rbbteHLNWU3VLY3YObiXDm
         RnRKlY3ihdMyE3/tMw4i53HF2TRFBB17bhy8xmzQI6tR5GIkmVF7JTZeimcTEby4ab9H
         irs/E4izy+EZ45Bgw+6cpcFqYsdvkM+0TmXst10/wlpRI+r7DBycSMkUIgd2Ft8zW7e0
         p0HYtdeHe8ghdcQ6w+A5Y9JMIwJ9xXld0P9EV5fyW0RaF9dMJcfK2ENvMWzYkWDqcRpc
         y6KHLIlBAOFEy8BmShUzk3PIvh7pDc+/pP54Pg0tDv+Unliv+77DDvVDVp2gstDs5liJ
         ttyw==
X-Gm-Message-State: AOAM531QvBJ7LEjj5qu3uNidCQEAf1zfOUFAsKFd2vxZzhUXq25MCZ7M
        Wz+sOinW1/L31Y8B33CmWR4K0nH386/ncA==
X-Google-Smtp-Source: ABdhPJwOQVNpU4KGRwikBNvh7yK6qAC+L8kEQepBFOThQIcssf+d3eBXVXm/ezaqNUWvTeLv3TFMFQ==
X-Received: by 2002:a9d:6653:: with SMTP id q19mr10861621otm.116.1639607710366;
        Wed, 15 Dec 2021 14:35:10 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p23sm696362otf.37.2021.12.15.14.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:35:09 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:35:05 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 08/10] arm64: dts: qcom: sm8450: add PCIe0 RC device
Message-ID: <YbptmeteGVt75NuO@builder.lan>
References: <20211211021758.1712299-1-dmitry.baryshkov@linaro.org>
 <20211211021758.1712299-9-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211021758.1712299-9-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri 10 Dec 20:17 CST 2021, Dmitry Baryshkov wrote:

> Add device tree node for the first PCIe host found on the Qualcomm
> SM8450 platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

You need to pad these with a couple more zeros, see 0ac10b291bee
("arm64: dts: qcom: Fix 'interrupt-map' parent address cells")

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

Binding states that the node name needs to have the suffix "-state".

Regards,
Bjorn

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
