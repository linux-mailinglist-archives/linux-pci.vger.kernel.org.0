Return-Path: <linux-pci+bounces-22110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F33CA40A57
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 17:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35226189E0FF
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE61F1F0E44;
	Sat, 22 Feb 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7agYjCX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42F3D984
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740243096; cv=none; b=Kar6NASEu6S7HzCpFoOMr8nHM2A75ixFbQyUCQU51StmOqE34SwWsAD7JIxENMSL1FO69kGfsWGYrphjK0eFDBJCuPog3iwX/4GSt+FuEAYbwrQ96QtJWVRW7AUqEwPJHht4rPRJt0O9m9nMtF9jZjgkW6AtGcAQRLYtwZWlYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740243096; c=relaxed/simple;
	bh=w0LmQz49aT/pe7eaUqi7mMgp1KIC2QgVZzGW5zZxAmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIHYFmCb/VTzsn0rUuIe3TtLi2lUFhr2MrIk5cLZFfJoDjYNwNRg7JdYy9GoP1D63o116h2yPIfPLWx0njoPprFgc57PcxESmQdOsks+hXWl8u+jpyw69h8cfgn+k8DW0hnUMJIPaBmzhevlTyZqft48VQ/BnRuRczKGaYLlufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h7agYjCX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so4965042a91.3
        for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740243095; x=1740847895; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sOUENYnzvt8ZQH4Hyb/QTR5W7roK5/nHLc7Zp4LFoQ0=;
        b=h7agYjCXoIz8r84QFAZ7cja5o9kqRXB9nEiVT7ToJrgO8AybkWuhKBU3kJniROwKfd
         b3h7XehRi/+IeU/BpBdb85YJwycA7qWUxeluZMIufofHkZbQPR6TViFO1J2WXNHp47M4
         rtDZ36ASNJ46Ytl/4vaYfz7S6IfB8tsLUihO36UakhHNNHE41kmxhYgRo5AAAmxcv0sC
         J5/hCv+73e5zoknCT6eOcBlDBhS5M15kKGAW9cnHwU+1DsGUrc6xquXqrNQoK3aGF6T5
         8b2WXnNkP9AerjzwpjXtXyOzhf4qtD7KmdJLJPSZbjnMXWqxtgdvCQUGfTn5Jwljujg/
         iYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740243095; x=1740847895;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOUENYnzvt8ZQH4Hyb/QTR5W7roK5/nHLc7Zp4LFoQ0=;
        b=q7XZh00NftfZpyYd58eJNJL1MsD6ZL1CTJDMYUjsz6tChfZ6aaGNIeEYj3d89esl6O
         UkS98iw8dNUVQnN4Jca+/txbG5QhHCtd3Uxx5X79yY6zIxP3hTo/lO+Rwb9cVpiSSYdl
         X3O6Tola+E7a8LPjLgGm6hdgvUquXW+hqIg3B2AuZXWC6EYqg5uZX8xzzUH2QbMGowgE
         MoTlK9mAR3PEq6fhDOk75YrFDD6Y78X5U0yJAhmVUbbxkB+W7H68l+DHN9T4T06+haap
         NVwH3XlcnBnn47KyB8p0ykAYZGNafsPTUoTdi4s2LNmBA4zCX1/N4bCTPtFhLtgAqZPv
         FIxA==
X-Forwarded-Encrypted: i=1; AJvYcCWbGZ2gNXeClI0MRfDEKF2kiOKKmtUDHJg5LP5At63qbCVE+nPbNFPdoNnz0wv9nRLtgyu4gFTWfa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHTL10aB71bLWmE35GbNjrrt38vRrl2eX8k1UBd7LzICuE1nJA
	ynxLKU/EZMiC9GnR6qWQq+X2KTDDxvi69tdALrHovfkEO0cFDHoceEpJOtJ8MA==
X-Gm-Gg: ASbGncs2rIWqg6iYqsWnamjMUC2nzjvNC/kRhWna8f2lzsOJFWcFfGyNmX2INn/tT9T
	7k20sKluMvphvxOvdhwArKOZWFEzDlzGvCPDPz5aDE2xgTYlrAJd4NZ8pHuODO9Ns3QbvsLqjte
	rtWqCr5CfwEPoMbi6bT9brMCsdl2FaQDQEZz+TFXHmgwny3mDh3Z06nhEWBAZ6gc2yAE+4IQiAK
	c4/KGzvgPH1Vbs5wtdoucv8FYLANIib9XhulDsTPxHIoy4LkDi+RJf+R6iD9KXHUfgKXSq1PFK3
	EyJR+dXapc9DFwRlu794TMvT1kKKMDplVXWi5w==
X-Google-Smtp-Source: AGHT+IHJoDxHiXuse7PDv45xfuzLtsqgGLpJ0OEKAFEDkIQnRP5KJLDYqtkpTUaVZ1UEGlR/auVcng==
X-Received: by 2002:a17:90b:1dcb:b0:2f8:4a3f:dd2d with SMTP id 98e67ed59e1d1-2fce78d1b51mr13034417a91.15.1740243094733;
        Sat, 22 Feb 2025 08:51:34 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb04c697sm3437710a91.19.2025.02.22.08.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:51:34 -0800 (PST)
Date: Sat, 22 Feb 2025 22:21:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: sar2130p: add PCIe EP device
 nodes
Message-ID: <20250222165128.55ly42qw2id4pucv@thinkpad>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250221-sar2130p-pci-v3-7-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221-sar2130p-pci-v3-7-61a0fdfb75b4@linaro.org>

On Fri, Feb 21, 2025 at 05:52:05PM +0200, Dmitry Baryshkov wrote:
> On the Qualcomm AR2 Gen1 platform the second PCIe host can be used
> either as an RC or as an EP device. Add device node for the PCIe EP.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sar2130p.dtsi | 61 ++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sar2130p.dtsi b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
> index dd832e6816be85817fd1ecc853f8d4c800826bc4..b45e9e2ae0357bd0c7d719eaf4fc1faa1cf913f2 100644
> --- a/arch/arm64/boot/dts/qcom/sar2130p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
> @@ -1474,6 +1474,67 @@ pcie@0 {
>  			};
>  		};
>  
> +		pcie1_ep: pcie-ep@1c08000 {
> +			compatible = "qcom,sar2130p-pcie-ep";
> +			reg = <0x0 0x01c08000 0x0 0x3000>,
> +			      <0x0 0x40000000 0x0 0xf1d>,
> +			      <0x0 0x40000f20 0x0 0xa8>,
> +			      <0x0 0x40001000 0x0 0x1000>,
> +			      <0x0 0x40200000 0x0 0x1000000>,
> +			      <0x0 0x01c0b000 0x0 0x1000>,
> +			      <0x0 0x40002000 0x0 0x2000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "addr_space",
> +				    "mmio",
> +				    "dma";
> +
> +			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
> +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
> +				 <&gcc GCC_CFG_NOC_PCIE_ANOC_AHB_CLK>,
> +				 <&gcc GCC_QMIP_PCIE_AHB_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ddrss_sf_tbu",
> +				      "aggre_noc_axi",
> +				      "cnoc_sf_axi",
> +				      "qmip_pcie_ahb";
> +
> +			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "global",
> +					  "doorbell",
> +					  "dma";
> +
> +			interconnects = <&pcie_noc MASTER_PCIE_1 QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &config_noc SLAVE_PCIE_1 QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "pcie-mem",
> +					     "cpu-pcie";
> +			iommus = <&apps_smmu 0x1e00 0x1>;
> +			resets = <&gcc GCC_PCIE_1_BCR>;
> +			reset-names = "core";
> +			power-domains = <&gcc PCIE_1_GDSC>;
> +			phys = <&pcie1_phy>;
> +			phy-names = "pciephy";
> +
> +			num-lanes = <2>;
> +
> +			status = "disabled";
> +		};
> +
>  		pcie1_phy: phy@1c0e000 {
>  			compatible = "qcom,sar2130p-qmp-gen3x2-pcie-phy";
>  			reg = <0x0 0x01c0e000 0x0 0x2000>;
> 
> -- 
> 2.39.5
> 

-- 
மணிவண்ணன் சதாசிவம்

