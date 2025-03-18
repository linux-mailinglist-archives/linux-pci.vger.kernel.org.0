Return-Path: <linux-pci+bounces-24012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7880FA66B64
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 08:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5570B3BB4B6
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 07:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04011DE4D7;
	Tue, 18 Mar 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQ2Dj7Fu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391443151
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282297; cv=none; b=qiIp9xaBliUtCI+TbtVBCOJSu/wMi8VvSasBqrICBwDeP3ajyacT0sZZmVvRwQ6AX8qnEbIxtlVR3agNCvlHtApwWFJGBiR+Bqya0IyTnTX8jeTQ8iZW7eaKOk4m6qSRu9FitWWMSzMBOcNa8D1/S0HPehLo8H7gP5pEbb8fys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282297; c=relaxed/simple;
	bh=sHkWokmPrqXsdDV7+i8VB3rJOPWoE1XI438bG7S5Nlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxVEIBFS9u8U8gZxpCBLkT5m8k0/MxPGZ3U77T0VzhS1430gyo6DLcByQW3FRba50fDdFp7C/xEYEgejq1N631sOYnLh+MX/LQ3YfZ9WwEZa01mrqQCDs1P83i26VpeLiYMI0DYB/xNJwlIZxxnwepB0VTkUNkDKLEDOxYaQQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MQ2Dj7Fu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22349bb8605so112579825ad.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 00:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742282295; x=1742887095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uL3J0kJ07qCQwLi/H8v/Z+UezU+LpDO7hkpWTExk8ys=;
        b=MQ2Dj7FuHbOQVJ5YTk0xYiXvhy57ZnHOSkxAJ0yPyePEmJh9SaVwgup/Sc6Fq8A4v3
         7Mwe3Duhv/9grkY8khBxRl1JLymtWOG6oIBV+Z9acEtLjDNp6xvNAFeha/7Kp4xnZYsV
         qvpVlpGnAVZtKHmq1J7HqZigN8n5ETDmNxtiZGhP5ejtRlt92HBuUNU1n9R72ehYwIum
         BmQ3VTYZ+t7zsJuTozqLaK4193Xj9bTYZ7h4TOw0VOV2USV+Lw8SMZb7oCkT1qEBPTMU
         EokAipHKCrPZiY8Zkx/9csn8fQoUOmCvQoJ+epj8M4RTK7/QRPzJFj25ZC89Ab0KRD62
         FFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742282295; x=1742887095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uL3J0kJ07qCQwLi/H8v/Z+UezU+LpDO7hkpWTExk8ys=;
        b=Ac8mOMYNII1TTXPrRt4byEQq3BZJGrc8EmwnPld1PepkqRloL9FiTNv8MBoINPBJpy
         g7V5aE3Js7PKgFEf6heisMfyJhv1eVraxXNZSUac5QtdTQC+Oi57ndtqnCROStYoVjZM
         1ilWeukGWxv/5qwa44S7fkP1qNZ6qji4ltyUgE99GFJEf+b6kA/KPsP5C48db2zamoJA
         bwyQ7iu4oV393tKU+Uv1CgGqG8jSZJk7ubpiT+MozUlthWBlEURcC5bqVx8TtOUslfwc
         nTkt7Yo5avLpvKi6+QxJ1iokMVnZoECPJbhFGhXCBaWmnMwCS7v3tp/TS4rOYRdghhSc
         HxGw==
X-Forwarded-Encrypted: i=1; AJvYcCXKo6B7DNzb+JOadU9ZELJepecZBHQS1z2/thfJOaQmB1MrAkvAegTAmtbKO15Yigm+YG0hhLjJrXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQ4XOZ1o+paqd0XCHHuM7UfbRvdyLcDHUUsgvx5go50vD5hGB
	UZJ0rGsoaza06KO3mnYJJBWvvVsw1e9x97sXC1OJ5RIEqH3H1C5Ubv3tujcqPw==
X-Gm-Gg: ASbGncslAJvJ7hOZDe4GjEIeZhiQD0Ig+XfBzqZ0mb7vWivIfsIr/9D24fhw4CIszaQ
	qWzKqkQoLZ9+K7usvuIQlrTXTjMGDVRKqBoX0Oq+QlPhAKz9mksZBeI8HAKjdjyJJuyTAoEHdUB
	JGKFFG6EXzWbFiAmQk7iiLyMEkx1jcsM+3oRIDzlKoUZlXOP5t/xKbs6zbeNyw1repdz6wvXkl1
	SL7Jq5BGaD1bec/tfvYwjUAuMaSLmKue/PSLZaxwD7dmZ1UtG7IImETMXqiAFpRjvD2p7xCWNk6
	2E9j17vqWRKaIQcjwApHKQ2tUApqCBKeDZb0HCz+DEappCI8t/OuDPbYTjMBwe6h/C0=
X-Google-Smtp-Source: AGHT+IEzVk5IzlQIC5VwuXRJuSpzspEea6bADLr7EeZbZUTj69tT3vTxsaaX4dqVtRwwYUxDGF902w==
X-Received: by 2002:a17:903:3bad:b0:223:2cae:4a96 with SMTP id d9443c01a7336-225e0b0fa67mr181209535ad.42.1742282295391;
        Tue, 18 Mar 2025 00:18:15 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba7275sm87355885ad.115.2025.03.18.00.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:18:15 -0700 (PDT)
Date: Tue, 18 Mar 2025 12:47:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
	kishon@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	kw@linux.com, lpieralisi@kernel.org, p.zabel@pengutronix.de,
	quic_nsekar@quicinc.com, robh@kernel.org, robimarko@gmail.com,
	vkoul@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
Message-ID: <20250318071756.uilfhwfzgr5gds3o@thinkpad>
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883E4A90C8AFF66BCAE14F49DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS7PR19MB8883E4A90C8AFF66BCAE14F49DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>

On Wed, Mar 05, 2025 at 05:41:30PM +0400, George Moussalem wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add phy and controller nodes for a 2-lane Gen2 and
> a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
> one global interrupt.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 232 +++++++++++++++++++++++++-
>  1 file changed, 230 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 8914f2ef0bc4..301a044bdf6d 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -147,6 +147,234 @@ usbphy0: phy@5b000 {
>  			status = "disabled";
>  		};
>  
> +		pcie1: pcie@78000 {
> +			compatible = "qcom,pcie-ipq5018";
> +			reg = <0x00078000 0x3000>,
> +			      <0x80000000 0xf1d>,
> +			      <0x80000f20 0xa8>,
> +			      <0x80001000 0x1000>,
> +			      <0x80100000 0x1000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +			max-link-speed = <2>;

Why do you want to limit link speed?

> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			phys = <&pcie1_phy>;
> +			phy-names ="pciephy";
> +
> +			ranges = <0x81000000 0 0x80200000 0x80200000 0 0x00100000>,	/* I/O */
> +				 <0x82000000 0 0x80300000 0x80300000 0 0x10000000>;	/* MEM */

These ranges are wrong. Please check with other DT files.

Same comments to other instance as well.

> +
> +			msi-map = <0x0 &v2m0 0x0 0xff8>;
> +
> +			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7",
> +					  "global";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_M_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_S_CLK>,
> +				 <&gcc GCC_PCIE1_AHB_CLK>,
> +				 <&gcc GCC_PCIE1_AUX_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>;
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
> +			reset-names = "pipe",
> +				      "sleep",
> +				      "sticky",
> +				      "axi_m",
> +				      "axi_s",
> +				      "ahb",
> +				      "axi_m_sticky",
> +				      "axi_s_sticky";
> +
> +			status = "disabled";
> +
> +			pcie@0 {
> +				device_type = "pci";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +			};
> +		};
> +
> +		pcie1_phy: phy@7e000{
> +			compatible = "qcom,ipq5018-uniphy-pcie-phy";
> +			reg = <0x0007e000 0x800>;
> +
> +			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
> +
> +			resets = <&gcc GCC_PCIE1_PHY_BCR>,
> +				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
> +
> +			#clock-cells = <0>;
> +

Please get rid of these newlines between -cells properties.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

