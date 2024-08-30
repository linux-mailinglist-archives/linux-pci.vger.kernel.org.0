Return-Path: <linux-pci+bounces-12504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2D2965C35
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 10:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F9F286186
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 08:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3851B16DED8;
	Fri, 30 Aug 2024 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZRkFZrj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C616DEB5
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008353; cv=none; b=e8asjKnCNsCDAWdMGNROVijEsKZ8JV1rrdWTWsyEZ7Ga/KTLGjZsiIxEZVL/cVHBDFYuOq8etfciULA/9FOs94VhWG3ykvBOtDJDCtT5K8zkZBc/7s3PPORoUzlpmtJJ8UlfP9KfVwFz+uVCF2LkHa2gSnfxeiUMp1cW/VwyVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008353; c=relaxed/simple;
	bh=onA0Rhh+UzLqUP5jEJTgKgOSRj6UGJ9Pt5npI0Xahjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GurdfreeRVkkd7ANIWp2J7kG6DWL3gezJES5G755tn9pJJTgj6V2o1as7O4XYpzLodmFolBOfuqDBoqLi6Mj28ZHuY763svkn5dDKXzTsyat7/Ho27jh7QZU9IJGhBHMKfwbNATywiZZZxf3VacJBbZv40cjyzE904ukPE7Y/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eZRkFZrj; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3df0d9c0fbfso706933b6e.2
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 01:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725008350; x=1725613150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=71qAjwrIo/FbmBz5Myk4n9y6EiwPiLE9Dng5NwJZ7Bo=;
        b=eZRkFZrjc0iKE9K16Fib4cMqp7Z/uq7YEjfEO5nRqCMWTWbMQw5ylQFSHNQrGklfWM
         B2kKewDJhItywraG/5kjtqYyllONRyMGtBX0i0XGTrT3MqMz+NfPVkJF0UCdjXNLbvLT
         9uCs6sR+t7NKZzcsUAitcgKMkpybg6il9tEvOHFd0Kw/PMEjEL4cOr3ZzIL6QDaDxVC0
         tHer7UjbzbuNQ4QXz7rQ2q7JD2ZqXdoHOTsBTrxDKZE+1AlLmJphFXXqQ5sn+FR82fqS
         I67RdvfsfnZVTRxKDle9yOIlW750vJHz7zhraKTAl+s6eJ7FNsL1FT8bGd2PYCRn+iK6
         BEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725008350; x=1725613150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71qAjwrIo/FbmBz5Myk4n9y6EiwPiLE9Dng5NwJZ7Bo=;
        b=JZBQqFHsMqiczw2unnlhMvGfFJtOw92eI3IKQTvzi4JJmPzCHz5TuQBOcV29aYFfTW
         BWd2J7kAkY/M7b2uURzEHnmZKV77r45T0t4kUIRk54pParFe6OH7icjOjaIh8cqM1jHd
         VwLla8i/hlef/sV9ttvz6cG7rugSXHkDmIBG/FWcWDgBejrevluQhRhz/Ado4QjiVOiK
         ZDEqSyuaSFD6ULqVYA2tv4XrCZQVaEBc+Oqqg5LPYj9PImlciBmFKY55W9hK9IuARjQ/
         3rHAMt2CO6FEP+LELPQk9smYe+ZSJLlYe3+92mwIBwwVc/Xj40i8u8gqHisu0R1csyYQ
         n2nA==
X-Forwarded-Encrypted: i=1; AJvYcCXXuap8C0MGKUX2C/AavDseqsBIF8O5b40iUYOqRgv9WmdUnwRsFH1ouOzNzpIR4mUrtHG3E3Q04zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQWoym8gi74W4eQj5VyG9f4dpBtT96xw4GyV9nnFCRWeoUVgys
	7tL0qSWmwGGIJuGhNEL6bPKQm2XBHYetvbyF6saaUjzHiOOMB6HM5PSIXrJFaw==
X-Google-Smtp-Source: AGHT+IGJE/0+ObI0CkZ+IOdkM1nwpEnemU7pt2j1Bs59c55j95S6Wc2rMVcunwSLXz0CAPYJaOw1vg==
X-Received: by 2002:a05:6808:1242:b0:3d9:384a:7e1a with SMTP id 5614622812f47-3df05c4e59amr5026350b6e.1.1725008350377;
        Fri, 30 Aug 2024 01:59:10 -0700 (PDT)
Received: from thinkpad ([117.193.213.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d721dsm2512363a12.87.2024.08.30.01.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:59:10 -0700 (PDT)
Date: Fri, 30 Aug 2024 14:29:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, p.zabel@pengutronix.de,
	dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, robimarko@gmail.com
Subject: Re: [PATCH V2 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
Message-ID: <20240830085901.oeiuuijlvq2ydho2@thinkpad>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
 <20240827045757.1101194-6-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827045757.1101194-6-quic_srichara@quicinc.com>

On Tue, Aug 27, 2024 at 10:27:56AM +0530, Sricharan R wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add phy and controller nodes for a 2-lane Gen2 and
> 1-lane Gen2 PCIe buses.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> ---
>  [v2] Removed relocatable flags,  removed assigned-clock-rates,
>       fixed rest of the cosmetic comments.
> 
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 168 +++++++++++++++++++++++++-
>  1 file changed, 166 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 7e6e2c121979..dd5d6b7ff094 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>  #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -143,7 +144,33 @@ usbphy0: phy@5b000 {
>  			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
>  
>  			#phy-cells = <0>;
> +		};
> +
> +		pcie_x1phy: phy@7e000{
> +			compatible = "qcom,ipq5018-uniphy-pcie-gen2x1";
> +			reg = <0x0007e000 0x800>;
> +			#phy-cells = <0>;
> +			#clock-cells = <0>;
> +			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
> +			clock-names = "pipe";
> +			assigned-clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
> +			resets = <&gcc GCC_PCIE1_PHY_BCR>,
> +				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
> +			reset-names = "phy", "common";
> +			status = "disabled";
> +		};
>  
> +		pcie_x2phy: phy@86000{
> +			compatible = "qcom,ipq5018-uniphy-pcie-gen2x2";
> +			reg = <0x00086000 0x1000>;
> +			#phy-cells = <0>;
> +			#clock-cells = <0>;
> +			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
> +			clock-names = "pipe";
> +			assigned-clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
> +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
> +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
> +			reset-names = "phy", "common";
>  			status = "disabled";
>  		};
>  
> @@ -170,8 +197,8 @@ gcc: clock-controller@1800000 {
>  			reg = <0x01800000 0x80000>;
>  			clocks = <&xo_board_clk>,
>  				 <&sleep_clk>,
> -				 <0>,
> -				 <0>,
> +				 <&pcie_x2phy>,
> +				 <&pcie_x1phy>,
>  				 <0>,
>  				 <0>,
>  				 <0>,
> @@ -387,6 +414,143 @@ frame@b128000 {
>  				status = "disabled";
>  			};
>  		};
> +
> +		pcie0: pci@80000000 {

pcie@

> +			compatible = "qcom,pcie-ipq5018";
> +			reg =  <0x80000000 0xf1d>,
> +			       <0x80000f20 0xa8>,
> +			       <0x80001000 0x1000>,
> +			       <0x00078000 0x3000>,
> +			       <0x80100000 0x1000>;

Are you sure that the config space is only 4K?

> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +			max-link-speed = <2>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			phys = <&pcie_x1phy>;
> +			phy-names ="pciephy";
> +
> +			ranges = <0x01000000 0 0x80200000 0x80200000 0 0x00100000

Please check the value of this field in other SoCs.

> +				  0x02000000 0 0x80300000 0x80300000 0 0x10000000>;
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 142 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 143 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 144 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 145 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "global_irq";

I'm pretty sure that this SoC has SPI based MSI interrupts. So they should be
described even though ITS is supported.

> +
> +			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_M_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_S_CLK>,
> +				 <&gcc GCC_PCIE1_AHB_CLK>,
> +				 <&gcc GCC_PCIE1_AUX_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>;
> +
> +			clock-names = "iface",
> +				      "axi_m",
> +				      "axi_s",
> +				      "ahb",
> +				      "aux",
> +				      "axi_bridge";
> +
> +			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
> +				 <&gcc GCC_PCIE1_SLEEP_ARES>,
> +				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_MASTER_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_SLAVE_ARES>,
> +				 <&gcc GCC_PCIE1_AHB_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_MASTER_STICKY_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_SLAVE_STICKY_ARES>;
> +
> +			reset-names = "pipe",
> +				      "sleep",
> +				      "sticky",
> +				      "axi_m",
> +				      "axi_s",
> +				      "ahb",
> +				      "axi_m_sticky",
> +				      "axi_s_sticky";
> +
> +			msi-map = <0x0 &v2m0 0x0 0xff8>;
> +			status = "disabled";

Please add the rootport node also as like other SoCs.

Above comments applies to below PCIe node.

- Mani

> +		};
> +
> +		pcie1: pci@a0000000 {
> +			compatible = "qcom,pcie-ipq5018";
> +			reg =  <0xa0000000 0xf1d>,
> +			       <0xa0000f20 0xa8>,
> +			       <0xa0001000 0x1000>,
> +			       <0x00080000 0x3000>,
> +			       <0xa0100000 0x1000>;
> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <1>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <2>;
> +			max-link-speed = <2>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			phys = <&pcie_x2phy>;
> +			phy-names ="pciephy";
> +
> +			ranges = <0x01000000 0 0xa0200000 0xa0200000 0 0x00100000
> +				  0x02000000 0 0xa0300000 0xa0300000 0 0x10000000>;
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 75 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 78 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 79 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 83 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "global_irq";
> +
> +			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
> +				 <&gcc GCC_PCIE0_AXI_M_CLK>,
> +				 <&gcc GCC_PCIE0_AXI_S_CLK>,
> +				 <&gcc GCC_PCIE0_AHB_CLK>,
> +				 <&gcc GCC_PCIE0_AUX_CLK>,
> +				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>;
> +
> +			clock-names = "iface",
> +				      "axi_m",
> +				      "axi_s",
> +				      "ahb",
> +				      "aux",
> +				      "axi_bridge";
> +
> +			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
> +				 <&gcc GCC_PCIE0_SLEEP_ARES>,
> +				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
> +				 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
> +				 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
> +				 <&gcc GCC_PCIE0_AHB_ARES>,
> +				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>,
> +				 <&gcc GCC_PCIE0_AXI_SLAVE_STICKY_ARES>;
> +
> +			reset-names = "pipe",
> +				      "sleep",
> +				      "sticky",
> +				      "axi_m",
> +				      "axi_s",
> +				      "ahb",
> +				      "axi_m_sticky",
> +				      "axi_s_sticky";
> +
> +			msi-map = <0x0 &v2m0 0x0 0xff8>;
> +			status = "disabled";
> +		};
> +
>  	};
>  
>  	timer {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

