Return-Path: <linux-pci+bounces-19538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C79A05CAD
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 14:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E4E1887CDB
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 13:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7556A1FBC94;
	Wed,  8 Jan 2025 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hI4ejmQU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F01FBC92
	for <linux-pci@vger.kernel.org>; Wed,  8 Jan 2025 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736342569; cv=none; b=LQoJ4PKruHsgc9Gq6LRmSFziILW4OjM0HMeg9xRfZBolE6ecl4n2r4Y6zKCkw37Skxu14TJHcASUh9nJYVuRivdpx/C5OXwTg+MVFenkyID9c74pNFsozipvl/u8J3jm7YfTRpfxEPMi7b0xqAIaz00bFBQj6piioRcc75ePNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736342569; c=relaxed/simple;
	bh=Dpg2Wb5I47smoJMY9zxlEd9D/QcsYMbGnyKqAhDGG88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJhbmA0rZGIM40sJ5H+5qmZe4rhvHhVWeQccq29eTXgEo1t+AV2xeSMJ4r6uzjaAvKZFy2cMPy3061ss7kt8D2WIVoY3k2P+c/tDP3q8t6oe6ehFA9ojdmlnN6p3cj1kOiIFgCeNFMVXREwQs56ek3r0kOSewAjHYdaF6F83BgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hI4ejmQU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163b0c09afso246605165ad.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Jan 2025 05:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736342566; x=1736947366; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uGQ6gTUaI3ZQFf1nCYXuOnJ+ZKOpQdsJP9iOpS9TOig=;
        b=hI4ejmQUnfASu1kUE7slRbne0vD0YZoF29Gwo0k/siTAMksZXChQETizCheoJWHgyd
         lGWTzC6gHEInqHuy7zK6gQB/r18MFozGjRgX0aq53yL5cqncZjsl3sEjlRN4/339kVjS
         2pnqJIO+r+hriKv2WKMrcZH/O/TSYdtpMKZ99chE+0AmOC76/THfOLfuUL3KmEX110XZ
         UvoxA6nYPGa4RgAXIP7xFr7zH2warQ6iecOnBkpVoPo2u/YnQeC1D9kUVceV/Rs0xdP+
         Y9xqAM7l/tyjTsKrgEVt3cQTx2iKz7hjVVaZDKCbz4H41OhBu9CjEAp2HIEozXIDMFJO
         TPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736342566; x=1736947366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGQ6gTUaI3ZQFf1nCYXuOnJ+ZKOpQdsJP9iOpS9TOig=;
        b=SFK+1PY9/64gORFPkpQZWBG/WVpfmkgopFPtPPMvVHrrrq9Z6hDVpU52NST0rZ3j/v
         CroBy4UiHKLvQ+idTJdU/l4TMaqRbjgmJZEcYHUMZBokPbqWRhVGAhyaYwz8T1ErSwkM
         7wrxEfTcwxmVD9Vunu5XMiA8RS81b7VSoAu0VXejtty2nDgpIcQmShi8UxmkuAansGA2
         bSCnOSjU8WRwXE5qzF/5Ad7KofrnjGDgI4ygZIp0jHweLbneYXNL9BJ9fnmy29yBeBNA
         34hhmNN5BrS1OmJ9YTXBOu1WsTl5ufqhVJHXy1l66+au/TjWB+NLl6HDEZvSc4oa/7+C
         tMig==
X-Forwarded-Encrypted: i=1; AJvYcCVFNHbT1q2kCzMf4h0rYD+dd5u0C/v5mjQdVawItTTreEgDyoKd7/JmZYXeonilG/hsPHC19ryo9Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBxgdkcS0Q/pMgVjUmqyLqYSupDBNrLyqa0UD9BYElW60EoTE/
	J9t12+BPfuqarJ2eepw+Y/WERYXWF2qh2U2bznncPJqjMaL6kv8WoQCyRiDOZA==
X-Gm-Gg: ASbGnctWRBNemRK/r8yBxkl+zLHdkqciRXdYpGc9VpnD/8dLfnChSDqgFdT9tkW8QGk
	Rn7RDHerx5/1zUSwAT0XrDMa3i/jbYvK4aJVru8Kf7DeTWnBJJnIMHiU5RFURdVKKo2b9xNrhgr
	LhSFwUDvOf5F0quroGZ9zqrMI2fx+I27yC3v/Ot91CJ80lfKJw6DEbDCNRlE1tfndkz0Tx/BWr7
	ePzyvUKj/PJoXBtPLNkdp62vmzv0tPjvCVs0S1lcSXrwfT2dc3+dISf0izFdPimwX+X
X-Google-Smtp-Source: AGHT+IECtsM/gRYWLFY3hTWl1Cc6HjpXQcF89x7voGNTV2OpqZVBPzam7oV8L4vtfZfa5pZdqlOIuA==
X-Received: by 2002:a17:903:2b08:b0:216:70b6:8723 with SMTP id d9443c01a7336-21a83fb5af8mr47573525ad.44.1736342566329;
        Wed, 08 Jan 2025 05:22:46 -0800 (PST)
Received: from thinkpad ([117.213.97.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c8fsm327792835ad.60.2025.01.08.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 05:22:45 -0800 (PST)
Date: Wed, 8 Jan 2025 18:52:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, p.zabel@pengutronix.de,
	quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Praveenkumar I <quic_ipkumar@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: ipq5332: Add PCIe related nodes
Message-ID: <20250108132235.gh6p5d6t7wklzpm7@thinkpad>
References: <20250102113019.1347068-1-quic_varada@quicinc.com>
 <20250102113019.1347068-5-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250102113019.1347068-5-quic_varada@quicinc.com>

On Thu, Jan 02, 2025 at 05:00:18PM +0530, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Add phy and controller nodes for pcie0_x1 and pcie1_x2.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v5: Add 'num-lanes' to "pcie1_phy: phy@4b1000"
>     Make ipq5332 as main and ipq9574 as fallback compatible
>     Move controller nodes per address
>     Having Konrad's Reviewed-By
> 
> v4: Remove 'reset-names' as driver uses bulk APIs
>     Remove 'clock-output-names' as driver uses bulk APIs
>     Add missing reset for pcie1_phy
>     Convert 'reg-names' to a vertical list
>     Move 'msi-map' before interrupts
> 
> v3: Fix compatible string for phy nodes
>     Use ipq9574 as backup compatible instead of new compatible for ipq5332
>     Fix mixed case hex addresses
>     Add "mhi" space
>     Removed unnecessary comments and stray blank lines
> 
> v2: Fix nodes' location per address
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 221 +++++++++++++++++++++++++-
>  1 file changed, 219 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index d3c3e215a15c..89daf955e4bd 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -186,6 +186,43 @@ rng: rng@e3000 {
>  			clock-names = "core";
>  		};
>  
> +		pcie0_phy: phy@4b0000 {
> +			compatible = "qcom,ipq5332-uniphy-pcie-phy";
> +			reg = <0x004b0000 0x800>;
> +
> +			clocks = <&gcc GCC_PCIE3X1_0_PIPE_CLK>,
> +				 <&gcc GCC_PCIE3X1_PHY_AHB_CLK>;
> +
> +			resets = <&gcc GCC_PCIE3X1_0_PHY_BCR>,
> +				 <&gcc GCC_PCIE3X1_PHY_AHB_CLK_ARES>,
> +				 <&gcc GCC_PCIE3X1_0_PHY_PHY_BCR>;
> +
> +			#clock-cells = <0>;
> +
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		pcie1_phy: phy@4b1000 {
> +			compatible = "qcom,ipq5332-uniphy-pcie-phy";
> +			reg = <0x004b1000 0x1000>;
> +
> +			clocks = <&gcc GCC_PCIE3X2_PIPE_CLK>,
> +				 <&gcc GCC_PCIE3X2_PHY_AHB_CLK>;
> +
> +			resets = <&gcc GCC_PCIE3X2_PHY_BCR>,
> +				 <&gcc GCC_PCIE3X2_PHY_AHB_CLK_ARES>,
> +				 <&gcc GCC_PCIE3X2PHY_PHY_BCR>;
> +
> +			#clock-cells = <0>;
> +
> +			#phy-cells = <0>;
> +
> +			num-lanes = <2>;
> +
> +			status = "disabled";
> +		};
> +
>  		tlmm: pinctrl@1000000 {
>  			compatible = "qcom,ipq5332-tlmm";
>  			reg = <0x01000000 0x300000>;
> @@ -212,8 +249,8 @@ gcc: clock-controller@1800000 {
>  			#interconnect-cells = <1>;
>  			clocks = <&xo_board>,
>  				 <&sleep_clk>,
> -				 <0>,
> -				 <0>,
> +				 <&pcie1_phy>,
> +				 <&pcie0_phy>,
>  				 <0>;
>  		};
>  
> @@ -479,6 +516,186 @@ frame@b128000 {
>  				status = "disabled";
>  			};
>  		};
> +
> +		pcie1: pcie@18000000 {

pcie@

> +			compatible = "qcom,pcie-ipq5332", "qcom,pcie-ipq9574";
> +			reg = <0x00088000 0x3000>,
> +			      <0x18000000 0xf1d>,
> +			      <0x18000f20 0xa8>,
> +			      <0x18001000 0x1000>,
> +			      <0x18100000 0x1000>,
> +			      <0x0008b000 0x1000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config",
> +				    "mhi";
> +			device_type = "pci";
> +			linux,pci-domain = <1>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <2>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0 0x18200000 0x18200000 0 0x00100000>,

I/O address space should start from 0. Please refer other SoCs.

Also, use 0x0 for consistency.

> +				 <0x02000000 0 0x18300000 0x18300000 0 0x07d00000>;
> +
> +			msi-map = <0x0 &v2m0 0x0 0xffd>;
> +
> +			interrupts = <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7";

Is there a 'global' interrupt? If so, please add it.

> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 412 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 413 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 414 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 415 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE3X2_AXI_M_CLK>,
> +				 <&gcc GCC_PCIE3X2_AXI_S_CLK>,
> +				 <&gcc GCC_PCIE3X2_AXI_S_BRIDGE_CLK>,
> +				 <&gcc GCC_PCIE3X2_RCHG_CLK>,
> +				 <&gcc GCC_PCIE3X2_AHB_CLK>,
> +				 <&gcc GCC_PCIE3X2_AUX_CLK>;
> +			clock-names = "axi_m",
> +				      "axi_s",
> +				      "axi_bridge",
> +				      "rchng",
> +				      "ahb",
> +				      "aux";
> +
> +			resets = <&gcc GCC_PCIE3X2_PIPE_ARES>,
> +				 <&gcc GCC_PCIE3X2_CORE_STICKY_ARES>,
> +				 <&gcc GCC_PCIE3X2_AXI_S_STICKY_ARES>,
> +				 <&gcc GCC_PCIE3X2_AXI_S_CLK_ARES>,
> +				 <&gcc GCC_PCIE3X2_AXI_M_STICKY_ARES>,
> +				 <&gcc GCC_PCIE3X2_AXI_M_CLK_ARES>,
> +				 <&gcc GCC_PCIE3X2_AUX_CLK_ARES>,
> +				 <&gcc GCC_PCIE3X2_AHB_CLK_ARES>;
> +			reset-names = "pipe",
> +				      "sticky",
> +				      "axi_s_sticky",
> +				      "axi_s",
> +				      "axi_m_sticky",
> +				      "axi_m",
> +				      "aux",
> +				      "ahb";
> +
> +			phys = <&pcie1_phy>;
> +			phy-names = "pciephy";
> +
> +			interconnects = <&gcc MASTER_SNOC_PCIE3_2_M &gcc SLAVE_SNOC_PCIE3_2_M>,
> +					<&gcc MASTER_ANOC_PCIE3_2_S &gcc SLAVE_ANOC_PCIE3_2_S>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";

Can you check if the controller supports cache coherency? If so, you need to add
'dma-coherent'.

> +
> +			status = "disabled";

Please define the root port node as well.

All the above comments applies to 2nd controller node as well.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

