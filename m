Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09D6CA1C4
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 12:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjC0KyX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 06:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjC0KyW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 06:54:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A28EFE;
        Mon, 27 Mar 2023 03:54:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13DA7B80DA9;
        Mon, 27 Mar 2023 10:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD1AC433EF;
        Mon, 27 Mar 2023 10:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679914458;
        bh=3m5S2P0Y01xv0mVXDkCZEoWn9ZtG8G6QGBhdIL/kX/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0qAhMBt7IVpjUMYgi2bPELCKNFe6lTVo6Tu0djOmqrs5Gb8lc9d45RdcQPrW+d3I
         mcOwVZBm0DqeQ9BzA08EsW0WqX8+rL4keYE02uS1CxbI+tSexLy/x8RGEG3Y/dAUfV
         PLv4XFvBywCazj2bDR3Qthy25CsZ3RTE0yTFZpUs80dh1mzNnK54vEhMByGsGxEUDX
         kgOctzXvb5bEs6yOk7geAJY3qbYBoXaIKIw3PpxWjaUwSk9iQV2z4qI+VlW40lw019
         8d0+Iri1oImxcx2rLfBOSiZj7nFHCoy4TgZQ6v86kr6h2gRrZV2qCAXg3tc8vVWKNT
         rM3Cx+sXisqvw==
Date:   Mon, 27 Mar 2023 16:24:03 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/5] ARM: dts: qcom: sdx65: Add support for PCIe EP
Message-ID: <20230327105403.GF16424@thinkpad>
References: <1679036039-27157-1-git-send-email-quic_rohiagar@quicinc.com>
 <1679036039-27157-4-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1679036039-27157-4-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 17, 2023 at 12:23:57PM +0530, Rohit Agarwal wrote:
> Add support for PCIe Endpoint controller on the
> Qualcomm SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 56 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 084daf8..a7d8ad9 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	#address-cells = <1>;
> @@ -293,6 +294,56 @@
>  			status = "disabled";
>  		};
>  
> +		pcie_ep: pcie-ep@1c00000 {
> +			compatible = "qcom,sdx65-pcie-ep", "qcom,sdx55-pcie-ep";
> +			reg = <0x01c00000 0x3000>,
> +			      <0x40000000 0xf1d>,
> +			      <0x40000f20 0xa8>,
> +			      <0x40001000 0x1000>,
> +			      <0x40200000 0x100000>,
> +			      <0x01c03000 0x3000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "addr_space",
> +				    "mmio";
> +
> +			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
> +
> +			clocks = <&gcc GCC_PCIE_AUX_CLK>,
> +				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLEEP_CLK>,
> +				 <&gcc GCC_PCIE_0_CLKREF_EN>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "sleep",
> +				      "ref";
> +
> +			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "global", "doorbell";
> +
> +			resets = <&gcc GCC_PCIE_BCR>;
> +			reset-names = "core";
> +
> +			power-domains = <&gcc PCIE_GDSC>;
> +
> +			phys = <&pcie_phy>;
> +			phy-names = "pcie-phy";
> +
> +			max-link-speed = <3>;
> +			num-lanes = <2>;
> +
> +			status = "disabled";
> +		};
> +
>  		pcie_phy: phy@1c06000 {
>  			compatible = "qcom,sdx65-qmp-gen4x2-pcie-phy";
>  			reg = <0x01c06000 0x2000>;
> @@ -330,6 +381,11 @@
>  			#hwlock-cells = <1>;
>  		};
>  
> +		tcsr: syscon@1fcb000 {
> +			compatible = "qcom,sdx65-tcsr", "syscon";
> +			reg = <0x01fc0000 0x1000>;
> +		};
> +
>  		remoteproc_mpss: remoteproc@4080000 {
>  			compatible = "qcom,sdx55-mpss-pas";
>  			reg = <0x04080000 0x4040>;
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
