Return-Path: <linux-pci+bounces-13172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56D9781F9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 16:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0D31F21240
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D421DC045;
	Fri, 13 Sep 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxCR1lZn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D99B1DC758
	for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235841; cv=none; b=nvg6+O7AEil6fq1lh0DEvzuSv5+En65oT8MlrJZL4IRHFqeXEq/y+Vpt96gr4PoC3Nl/qPFXQYtPSQCEKaCu0vaI+o0eSsjfdfhOi7cyM4ZpjAzhuKpSMkFqI717CYqp+2t9IJgoPva+H+WhOdweSuKQlK1zaEbZAly483YlKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235841; c=relaxed/simple;
	bh=nygQcvBgkEXlQczrMZaRkwU7DMO4Sgzp88nUG5kKe5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSqSa+kUwg7M0MGEp/qaE38jHbbK634ZGAa6fNeVpPiFc8UKBAGJy3YdfY9iPzby4x4AdCaLMYd4F+kCetNU1529p5FVX6hJsQKnT0qelcjtQ9yoW38NB/vu3tACCrjl/3aPnFGtfbkt2OZ/xZkzH6wZNr7RXE28Od3Q6weAikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mxCR1lZn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2053616fa36so25368375ad.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726235839; x=1726840639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j4zVOa+rsJLoaZtlg7qNm3b8vXOuxAqtzpJMF/Jo70g=;
        b=mxCR1lZnLia7tXuzndmEmU9G/PqZ3bWM7olWjHgy68VKbkcAa7fFyPgiXkmK3EyeN1
         I0O6lqAiVB0zxCBLs/U1Yf+0aQ/cRjO+qwDx6rsL6SkJe2QFVETz9C/bd1a3lgkX+8bi
         tAzvU/Gzv5xXBDYC/V0Vpp6f8SR5L6e+MKOQm/vjKi4olziVi+iXMsbaRu556EAH+6rq
         9q5YPGCdyYxbZOxMci57owTtPivKZTEOUZp0dVTPWbtXZXd4WhGQpP8o8Dgkzrjj05Pd
         Z5CwhDH2/+S6mDMlyiDOVojhLse+vhGlMxKWnVsxc+QF16rZTx4sSoyDkLQ/nXQMrKRf
         RpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726235839; x=1726840639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4zVOa+rsJLoaZtlg7qNm3b8vXOuxAqtzpJMF/Jo70g=;
        b=kF+UvNsddkWIAgT6ZtJUzZdHbIH+poYKa7oCMUGUKNgVhNhX9PZZ4N2awg/qiykwou
         /sMww/afvNKBMFOV5esj7uMBie61A6iy/5m0KFyo6vlX5bWv8OTpKZm7cp+9dv/ipQR2
         HT616ifxRb0EU4aNTM+oPINA0WTMvWfLCD+wZf9GqduEuPo6Wl+8+L5ZaOAkcb3KyBtf
         a4NbZFQRtjpX5Dat4sKuqONZslL2AF0zBCjOSUiwN0ZAmr3sTYR9yON+WZix1B/sgXTx
         6p3fQg3oVYLvuC7n2CbuusWVEDWYm+7mRrqBv6dVyh4PmBv2INRreyDUEJPFPEzNXM7c
         F0OA==
X-Forwarded-Encrypted: i=1; AJvYcCWq3I4UHJB9ygENPuBRYeI/opgbHl7DTwTt6SugTGtv5gO5/taKYE4a623+1z7SLIoeY53EhLGKjGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy23FmM3IqCNvRPpJVM9MK1888N+J930kNi3b5Wokhnu/6Z6R09
	wI5POkICUxVgt+ejWz8s+rbPwwP2V51QfzKYDSwKiG5jzA5eCw1HY4TLj/yO8w==
X-Google-Smtp-Source: AGHT+IF/dhpwnwCRU/9Bk+v+2G3zbmxcvhusIOoU80hBY2klO7C51mKtJhG7H4NPXx22niLc5+SxxA==
X-Received: by 2002:a17:902:f785:b0:205:7863:2dec with SMTP id d9443c01a7336-2076e3698edmr95862965ad.27.1726235838719;
        Fri, 13 Sep 2024 06:57:18 -0700 (PDT)
Received: from thinkpad ([120.60.66.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af4739asm28455325ad.66.2024.09.13.06.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:57:18 -0700 (PDT)
Date: Fri, 13 Sep 2024 19:27:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
Message-ID: <20240913135710.6ionsmzo45orin6n@thinkpad>
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
 <20240913083724.1217691-6-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913083724.1217691-6-quic_qianyu@quicinc.com>

On Fri, Sep 13, 2024 at 01:37:24AM -0700, Qiang Yu wrote:
> Describe PCIe3 controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe3.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 202 ++++++++++++++++++++++++-
>  1 file changed, 201 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index a36076e3c56b..a7703e4974a6 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -744,7 +744,7 @@ gcc: clock-controller@100000 {
>  
>  			clocks = <&bi_tcxo_div2>,
>  				 <&sleep_clk>,
> -				 <0>,
> +				 <&pcie3_phy>,
>  				 <&pcie4_phy>,
>  				 <&pcie5_phy>,
>  				 <&pcie6a_phy>,
> @@ -2907,6 +2907,206 @@ mmss_noc: interconnect@1780000 {
>  			#interconnect-cells = <2>;
>  		};
>  
> +		pcie3: pci@1bd0000 {

pcie@

> +			device_type = "pci";
> +			compatible = "qcom,pcie-x1e80100";
> +			reg = <0 0x01bd0000 0 0x3000>,
> +			      <0 0x78000000 0 0xf1d>,

0x0 here and below.

> +			      <0 0x78000f40 0 0xa8>,
> +			      <0 0x78001000 0 0x1000>,
> +			      <0 0x78100000 0 0x100000>,
> +			      <0 0x01bd3000 0 0x1000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config",
> +				    "mhi";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x78200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x78300000 0x0 0x78300000 0x0 0x3d00000>,
> +				 <0x03000000 0x7 0x40000000 0x7 0x40000000 0x0 0x40000000>;
> +			bus-range = <0x00 0xff>;
> +
> +			dma-coherent;
> +
> +			linux,pci-domain = <3>;
> +			num-lanes = <8>;
> +
> +			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 671 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7";

Can you add 'global' interrupt as well? While doing so, please make sure the
global_irq related patches are applied and Link up works fine. Those patches are
already in linux-next.

> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 0 220 IRQ_TYPE_LEVEL_HIGH>,

Use GIC_SPI for the parent interrupt specifier.

- Mani

> +					<0 0 0 2 &intc 0 0 0 221 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 0 237 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 0 238 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE_3_AUX_CLK>,
> +				 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_3_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_3_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_3_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK>,
> +				 <&gcc GCC_CNOC_PCIE_NORTH_SF_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "noc_aggr",
> +				      "cnoc_sf_axi";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_3_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			interconnects = <&pcie_south_anoc MASTER_PCIE_3 QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> +					 &cnoc_main SLAVE_PCIE_3 QCOM_ICC_TAG_ALWAYS>;
> +			interconnect-names = "pcie-mem",
> +					     "cpu-pcie";
> +
> +			resets = <&gcc GCC_PCIE_3_BCR>,
> +				 <&gcc GCC_PCIE_3_LINK_DOWN_BCR>;
> +			reset-names = "pci",
> +				      "link_down";
> +
> +			power-domains = <&gcc GCC_PCIE_3_GDSC>;
> +
> +			phys = <&pcie3_phy>;
> +			phy-names = "pciephy";
> +
> +			operating-points-v2 = <&pcie3_opp_table>;
> +
> +			status = "disabled";
> +
> +			pcie3_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				/* GEN 1 x1 */
> +				opp-2500000 {
> +					opp-hz = /bits/ 64 <2500000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <250000 1>;
> +				};
> +
> +				/* GEN 1 x2 and GEN 2 x1 */
> +				opp-5000000 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +				};
> +
> +				/* GEN 1 x4 and GEN 2 x2 */
> +				opp-10000000 {
> +					opp-hz = /bits/ 64 <10000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <1000000 1>;
> +				};
> +
> +				/* GEN 1 x8 and GEN 2 x4 */
> +				opp-20000000 {
> +					opp-hz = /bits/ 64 <20000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <2000000 1>;
> +				};
> +
> +				/* GEN 2 x8 */
> +				opp-40000000 {
> +					opp-hz = /bits/ 64 <40000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <4000000 1>;
> +				};
> +
> +				/* GEN 3 x1 */
> +				opp-8000000 {
> +					opp-hz = /bits/ 64 <8000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +					opp-peak-kBps = <984500 1>;
> +				};
> +
> +				/* GEN 3 x2 and GEN 4 x1 */
> +				opp-16000000 {
> +					opp-hz = /bits/ 64 <16000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +					opp-peak-kBps = <1969000 1>;
> +				};
> +
> +				/* GEN 3 x4 and GEN 4 x2 */
> +				opp-32000000 {
> +					opp-hz = /bits/ 64 <32000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +					opp-peak-kBps = <3938000 1>;
> +				};
> +
> +				/* GEN 3 x8 and GEN 4 x4 */
> +				opp-64000000 {
> +					opp-hz = /bits/ 64 <64000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +					opp-peak-kBps = <7876000 1>;
> +				};
> +
> +				/* GEN 4 x8 */
> +				opp-128000000 {
> +					opp-hz = /bits/ 64 <128000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +					opp-peak-kBps = <15753000 1>;
> +				};
> +			};
> +		};
> +
> +		pcie3_phy: phy@1be0000 {
> +			compatible = "qcom,x1e80100-qmp-gen4x8-pcie-phy";
> +			reg = <0 0x01be0000 0 0x10000>;
> +
> +			clocks = <&gcc GCC_PCIE_3_PHY_AUX_CLK>,
> +				 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
> +				 <&tcsr TCSR_PCIE_8L_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE_3_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_3_PIPEDIV2_CLK>;
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "ref",
> +				      "rchng",
> +				      "pipe",
> +				      "pipediv2";
> +
> +			resets = <&gcc GCC_PCIE_3_PHY_BCR>,
> +				 <&gcc GCC_PCIE_3_NOCSR_COM_PHY_BCR>;
> +			reset-names = "phy",
> +				      "phy_nocsr";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc GCC_PCIE_3_PHY_GDSC>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie3_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		pcie6a: pci@1bf8000 {
>  			device_type = "pci";
>  			compatible = "qcom,pcie-x1e80100";
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

