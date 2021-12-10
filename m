Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1319D47002C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 12:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbhLJLlD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 06:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbhLJLlD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 06:41:03 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDEAC0617A2
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 03:37:28 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id p13so8249119pfw.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 03:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qi2ii7axpVPM6M5j9yKMozSkF/k3GbmTDPLNt+E5MLk=;
        b=acwYIZDGWQoJ31rdBIRmigTvMAK5hGgUACwg6gzz1XMlcC9WQ8kOCqLsqu8YRJMOa5
         vrOQL9I+1esExYHfkA0CK1Qy5Mr7ckRp/7xgLfEvhia4KNQBgRP2yhHnAD+36zUSmKei
         xVbkcpaE4FvukexOVlXNRY4NSx2BnFPjIwOAPqbU14ON2flSKlOfUYL5yxT1j5wLSQrq
         mdoOIYNV0uY0aDoFDE2p7Q0CFWl7RcDiz2r+u9sl7I+ulHus7icfWSLBkqtkVSnVCKMF
         uiASmCzf0QK1EF7/KPUQuTmBDxJobM6ofAZ505tFZF4q3NBX3z5a2/hO21VgfFgzMwzh
         c5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qi2ii7axpVPM6M5j9yKMozSkF/k3GbmTDPLNt+E5MLk=;
        b=tKwfbYUIZVgb6QoScPh+fjeYM5dGzIq/Kp+LimGYo2Yy+bNVvXVPXEa6ekVPj3CWNt
         h3brT6/r4y3fxSVpwXgfvp9vKjdxePSgZLFHmYtr9/4WpA2zerMjPmesQh3TmkwXcCY3
         VMyMrA0yTItR18WbY+tW3b7rzFbM+omsKv2c7AFgcut0s+vduTJ8bay6lfCWW9/vW2OD
         qvjmxOdBm2iQa70cp9ilT7+ZqQ8fOCjAYpkWmgB6F03NUuoRHlUFRKOVXcbHrXjLypYt
         +IHirkbmTVaK7NjQ2OUWTCdbr2KHrc5j6EN23UUOOfasPQlnauX6Cbr1btnVtg6n7CQk
         fudQ==
X-Gm-Message-State: AOAM532TxXk/mo+8hFj7xItto5SpzhFnKd11ZVi1Ie5wBTFYZ8Omkk0v
        H8xY4OJlVWNZHuGN5VSoazIV
X-Google-Smtp-Source: ABdhPJwZJzp1BvF7xLuULGMdYqjjGXpKYnPljTi18kLCPgfMUUNFpVqPsqgVa6itGcnUd1l3myVGpg==
X-Received: by 2002:a62:1a03:0:b0:494:64b5:3e01 with SMTP id a3-20020a621a03000000b0049464b53e01mr17584648pfa.35.1639136247602;
        Fri, 10 Dec 2021 03:37:27 -0800 (PST)
Received: from thinkpad ([202.21.42.75])
        by smtp.gmail.com with ESMTPSA id kk7sm14517702pjb.19.2021.12.10.03.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 03:37:27 -0800 (PST)
Date:   Fri, 10 Dec 2021 17:07:20 +0530
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
Subject: Re: [PATCH v2 07/10] arm64: dts: qcom: sm8450: add PCIe0 PHY node
Message-ID: <20211210113720.GG1734@thinkpad>
References: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
 <20211208171442.1327689-8-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208171442.1327689-8-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 08, 2021 at 08:14:39PM +0300, Dmitry Baryshkov wrote:
> Add device tree node for the first PCIe PHY device found on the Qualcomm
> SM8450 platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 42 ++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 16a789cacb65..a047d8a22897 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -558,8 +558,12 @@ gcc: clock-controller@100000 {
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
> -			clock-names = "bi_tcxo", "sleep_clk";
> -			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&pcie0_lane>,
> +				 <&sleep_clk>;
> +			clock-names = "bi_tcxo",
> +				      "pcie_0_pipe_clk",
> +				      "sleep_clk";
>  		};
>  
>  		qupv3_id_0: geniqup@9c0000 {
> @@ -625,6 +629,40 @@ i2c14: i2c@a98000 {
>  			};
>  		};
>  
> +		pcie0_phy: phy@1c06000 {
> +			compatible = "qcom,sm8450-qmp-gen3x1-pcie-phy";
> +			reg = <0 0x01c06000 0 0x200>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "refgen";
> +
> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			status = "disabled";
> +
> +			pcie0_lane: lanes@1c06200 {
> +				reg = <0 0x1c06e00 0 0x200>, /* tx */
> +				      <0 0x1c07000 0 0x200>, /* rx */
> +				      <0 0x1c06200 0 0x200>, /* pcs */

Oh, so this platform has "PCS" at the starting offset? This is different
compared to other platforms as "TX" always comes first.

And the size is "0x200" for all?

Thanks,
Mani

> +				      <0 0x1c06600 0 0x200>; /* pcs_pcie */
> +				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
> +				clock-names = "pipe0";
> +
> +				#clock-cells = <0>;
> +				#phy-cells = <0>;
> +				clock-output-names = "pcie_0_pipe_clk";
> +			};
> +		};
> +
>  		config_noc: interconnect@1500000 {
>  			compatible = "qcom,sm8450-config-noc";
>  			reg = <0 0x01500000 0 0x1c000>;
> -- 
> 2.33.0
> 
