Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906EA43B295
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 14:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhJZMpQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 08:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbhJZMpQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 08:45:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6506FC061220
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 05:42:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so16806586lfu.5
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HuPXxQ3Dx5OU5hbFOWVQiDy9S2Ab/pqOebTTCbBX458=;
        b=yp/FjIP2ZykqVytABuEpEZO1uJnOPB/r5RSZXjwbbGVBknnnCJfGJQWPwFNhzbdWPx
         5b0kfYV+PNchKANblo/AR1ip8GVyob81fsovi0Seo2WABuCQICdFeaudXFmfExFdFG+V
         vObP8NA2YVpVe/PTSjnGvAnp5xI0ba/iq0RzglKYLQwkak+gTB+X/V98elp1ND8v/hmj
         X0p+SnQmWdwr0VDaP1vCO6RbHkUkp2EC7S2H4hUoeLdabKo9lVnUhC3mSHjiYBx9j8DS
         GqaG7gfuZpk7F5dsJE0ISRS6s48eNw/ffU02WhE6I6mUPjU0OcLCph0+shE4xvcCFSSA
         eUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HuPXxQ3Dx5OU5hbFOWVQiDy9S2Ab/pqOebTTCbBX458=;
        b=8EZlyTW2x/IJ1HJVH5gpX2UBTaAE+7BI93AjoDj9H6nllQRukYu7teVWma0JleW9sU
         ucCF27vsS6x1pZiQPa9zfju+8s9h2XOFcjD1WIkI/DVvRGdlNxPhyWnMDaZoL+6zkYdA
         QRWsnkkSdtKzHuOztN+WWDR0/WFskYCG0r8MqUzicpK3CwlnYDYKi6MoxqGocibwGJP7
         kjOQgYpGiTS4SAYEGwzqOiJ8DHOvsLQ+vQD/AiTbYKszTbTWh6G0E0ILyNoZMvgCn9IW
         jw34c1g+xJE8yROc7B53OPhr003YDDAZ0kFUF/kR4a5nh0NyVYOOCc+//ZMmghk5Ub5P
         Ra7Q==
X-Gm-Message-State: AOAM531tDd9ODEkYCpzw7ZxUrUYgr0XbqQhBnqT9aZIR6EI2YLx4WoM/
        BPy098Fmqf8sjzau/0q0IbvDErfCjpvfvA==
X-Google-Smtp-Source: ABdhPJwtr6cFDc91FwGgkx11o3XI6XVYbNqXOl252C5qhPNnoAkCmQISNhEGbYqHen0kRK1NV8MKuw==
X-Received: by 2002:a05:6512:108e:: with SMTP id j14mr23034146lfg.274.1635252170309;
        Tue, 26 Oct 2021 05:42:50 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o26sm2017103ljg.92.2021.10.26.05.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 05:42:49 -0700 (PDT)
Subject: Re: [PATCH v12 2/5] arm64: dts: qcom: sc7280: Add PCIe and PHY
 related nodes
To:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, swboyd@chromium.org, lorenzo.pieralisi@arm.com,
        svarbanov@mm-sol.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org,
        linux-pci@vger.kernel.org
References: <1633628923-25047-1-git-send-email-pmaliset@codeaurora.org>
 <1633628923-25047-3-git-send-email-pmaliset@codeaurora.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <70502702-3f55-46f2-46e4-d3dda4f0294d@linaro.org>
Date:   Tue, 26 Oct 2021 15:42:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1633628923-25047-3-git-send-email-pmaliset@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/10/2021 20:48, Prasad Malisetty wrote:
> Add PCIe controller and PHY nodes for sc7280 SOC.
> 
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 118 +++++++++++++++++++++++++++++++++++
>   1 file changed, 118 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 39635da..cde814f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1563,6 +1563,117 @@
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
>   
> +		pcie1: pci@1c08000 {
> +			compatible = "qcom,pcie-sc7280";
> +			reg = <0 0x01c08000 0 0x3000>,
> +			      <0 0x40000000 0 0xf1d>,
> +			      <0 0x40000f20 0 0xa8>,
> +			      <0 0x40001000 0 0x1000>,
> +			      <0 0x40100000 0 0x100000>;
> +
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <1>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <2>;
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
> +
> +			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 435 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 438 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 439 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
> +				 <&pcie1_lane 0>,

This should be just <&pcie1_lane>, as the phy doesn't have clock cells.

> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_PCIE_1_AUX_CLK>,
> +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_CLK>;
> +
> +			clock-names = "pipe",
> +				      "pipe_mux",
> +				      "phy_pipe",
> +				      "ref",
> +				      "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "tbu",
> +				      "ddrss_sf_tbu";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			resets = <&gcc GCC_PCIE_1_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc GCC_PCIE_1_GDSC>;
> +
> +			phys = <&pcie1_lane>;
> +			phy-names = "pciephy";
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pcie1_clkreq_n>;
> +
> +			iommus = <&apps_smmu 0x1c80 0x1>;
> +
> +			iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
> +				    <0x100 &apps_smmu 0x1c81 0x1>;
> +
> +			status = "disabled";
> +		};
> +
> +		pcie1_phy: phy@1c0e000 {
> +			compatible = "qcom,sm8250-qmp-gen3x2-pcie-phy";
> +			reg = <0 0x01c0e000 0 0x1c0>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
> +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_CLKREF_EN>,
> +				 <&gcc GCC_PCIE1_PHY_RCHNG_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "refgen";
> +
> +			resets = <&gcc GCC_PCIE_1_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			assigned-clocks = <&gcc GCC_PCIE1_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			status = "disabled";
> +
> +			pcie1_lane: lanes@1c0e200 {
> +				reg = <0 0x01c0e200 0 0x170>,
> +				      <0 0x01c0e400 0 0x200>,
> +				      <0 0x01c0ea00 0 0x1f0>,
> +				      <0 0x01c0e600 0 0x170>,
> +				      <0 0x01c0e800 0 0x200>,
> +				      <0 0x01c0ee00 0 0xf4>;
> +				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
> +				clock-names = "pipe0";
> +
> +				#phy-cells = <0>;
> +				#clock-cells = <1>;
> +				clock-output-names = "pcie_1_pipe_clk";
> +			};
> +		};
> +
>   		ipa: ipa@1e40000 {
>   			compatible = "qcom,sc7280-ipa";
>   
> @@ -2676,6 +2787,13 @@
>   			gpio-ranges = <&tlmm 0 0 175>;
>   			wakeup-parent = <&pdc>;
>   
> +			pcie1_clkreq_n: pcie1-clkreq-n {
> +				pins = "gpio79";
> +				function = "pcie1_clkreqn";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
>   			qspi_clk: qspi-clk {
>   				pins = "gpio14";
>   				function = "qspi_clk";
> 


-- 
With best wishes
Dmitry
