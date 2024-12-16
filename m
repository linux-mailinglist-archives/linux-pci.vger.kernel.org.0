Return-Path: <linux-pci+bounces-18491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8709F2C54
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 09:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C93164E00
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB669200109;
	Mon, 16 Dec 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b="PvlINJIN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400411FF7B0
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339286; cv=none; b=s3YIbzTI5cGywQURTB0n4mJoXD8MW3phfFnuRHiehotsQP/PPuzdJk2BEQ8kWCIPB2ge9O3X1LeV2Ejgjw9RLUwLbSQbvX58JpSZeGrD1tS/hrvXE3OSUK58sFzU8VgmoGgkTCaTzE8p2Y1QvgU/uy9fMzZ2BKk9GwDeDi4GqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339286; c=relaxed/simple;
	bh=5RY4lshhlze7QRp7NGCq58pFPobkxguy7/8IzrEV/BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KbRr6k8kzdE6fxhtTQeUoho/FIFZ+TBqeSzzGtuyicbtOjk+VzyPaYyGNYLhKelfGHIKxFdn28jD0NR9cyR7khjbkPC8vp9qm4N6kMOGhKsOF1STerLMvr4OKuY48kdbaeOYOMONVJXQWfwc+06Nkaw5+YuEgmpcM07SZY6Oels=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com; spf=pass smtp.mailfrom=8devices.com; dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b=PvlINJIN; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8devices.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3002c324e7eso44080581fa.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 00:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1734339282; x=1734944082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6HjFTfajugFjsfLZm3+u6D3uXDNooXNPgDhumvsfytQ=;
        b=PvlINJINj7usqDKjkhHwF044ny5/b6kU1S4S9YRBHeda+cIkoO+5nvENuFo9v9sdmN
         Xg83IHb2rnx2ySgHZLu+kc2euQHYip3UvpGRgFFkJw9FLqi6esJ5lrkmPx+YOT46YgTN
         XsRdqAyIvbG1DQBvzhw0zeTjiWlxNcDC5d6mLJ32HDdWuP+osTtn+AhXhRjLFUJLCs23
         c02Ih+1Xj4aF+9jGNY8NKMlYH9eejOp56R6g2BdlJA7Av2n9idkR+ypM2RXUuy9PaXNL
         12nuptKc9W5xDF0SsOv1WSkxzbCRkpZ9Yg7/S4HKxBJrDDCnI5ov9omS6gM3iuMl/DCP
         6J9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734339282; x=1734944082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HjFTfajugFjsfLZm3+u6D3uXDNooXNPgDhumvsfytQ=;
        b=FAP+ajwVfJn2Oh3pMitnqO4jgXHE6Uyg8S/BevaO3p/Sp1L4z7fd7aT+N3rU062Qd6
         d9GygTjxs4fbi9yuJye+0Gp+hW5Pn2K6QKPw+8qOyAMyEIiC8C8rAemH/3MEMFpmnEbr
         pwBhyUMTdjqzxVSZd4fhyOrVTQj3O41EEinyRh9xMKlAcIWRCkO0jUnOJXftZeMWNmfv
         VZIIs60MZtWup2dZIJoczQFvWDAlExVqxfZWyDmfFG/B4GBzj2YqEzlXIPqcopMRInu0
         fMPsnSCL0wxs8MlUyIdSOg6H2y/jCCC/rvhD8LrYNxxS7qfXxyzNn48DuqsGq7lMbG1g
         LOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1YHlDcYpuQ+pH+bmYUtFNasLP1sx4ya2zO/AM2C+x+O+rWJ1DobJ062ndsjhM2KYrb/ZyyRkXIak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhmrkGN4uer4t8ZTCCG1L5uYKX3o3LQ+S8hPO20Df8x8y+eHB3
	/g/foImpiWbb29ZckP9ykCDqh+yE69wEiggOU65OyaRQsbkOaw2xFq6ulodpahE=
X-Gm-Gg: ASbGncuj2lfDx7w1+1qOAT3D3yd9gOm6lNCZv+x6rL8RJ3iko47WZ2PQX3oKkX5hAOE
	YSpzSzTePlbJ0OEfTnbteTevZXVJ4UtWCHSRLGrUpzCk7ttPWWiy+WbzenENgyetMS3LKd85HKF
	4K5LLhCanBbhA/97pZwzS8dNS4o9MwGSK7QaF3EmgAake8yujsYjIlBsgVDKJKgwizBMiUo5ePK
	CXDzgDx7w80ywpxmWh70KxB1EyuhUJwAxKLp0VnDK9yLK0e46cwve8xrjXb2fITa4PXgqQ=
X-Google-Smtp-Source: AGHT+IEzSwcxMpfmsNAigtq6qZL4byOIUgTPPgr6w3Egy1Yuh0xxpseLaL7YmEO2D9SNew4xWf7X0w==
X-Received: by 2002:a2e:beac:0:b0:302:1d24:8db7 with SMTP id 38308e7fff4ca-302545504e8mr40968581fa.19.1734339282338;
        Mon, 16 Dec 2024 00:54:42 -0800 (PST)
Received: from [192.168.2.155] ([78.62.132.154])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3034401d405sm8561641fa.5.2024.12.16.00.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 00:54:41 -0800 (PST)
Message-ID: <cd55964f-423a-4fec-9c8c-7ee3602b8322@8devices.com>
Date: Mon, 16 Dec 2024 10:54:40 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/4] arm64: dts: qcom: ipq9574: Add PCIe PHYs and
 controller nodes
To: Sricharan R <quic_srichara@quicinc.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240801054803.3015572-1-quic_srichara@quicinc.com>
 <20240801054803.3015572-3-quic_srichara@quicinc.com>
Content-Language: en-US
From: Mantas Pucka <mantas@8devices.com>
In-Reply-To: <20240801054803.3015572-3-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-01 08:48, Sricharan R wrote:
> From: devi priya <quic_devipriy@quicinc.com>
>
> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
> found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
> [V7] Fixed review comments from Manivannan.
>
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 420 +++++++++++++++++++++++++-
>   1 file changed, 416 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 48dfafea46a7..078e2950acd2 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -226,6 +226,52 @@ rpm_msg_ram: sram@60000 {
>   			reg = <0x00060000 0x6000>;
>   		};
>   
> +		pcie0_phy: phy@84000 {
> +			compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> +			reg = <0x00084000 0x1000>;
> +
> +			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
> +				 <&gcc GCC_PCIE0_AHB_CLK>,
> +				 <&gcc GCC_PCIE0_PIPE_CLK>;
> +			clock-names = "aux", "cfg_ahb", "pipe";
> +
> +			assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
> +			assigned-clock-rates = <20000000>;
> +
> +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
> +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
> +			reset-names = "phy", "common";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "gcc_pcie0_pipe_clk_src";
> +
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		pcie2_phy: phy@8c000 {
> +			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
> +			reg = <0x0008c000 0x2000>;
> +
> +			clocks = <&gcc GCC_PCIE2_AUX_CLK>,
> +				 <&gcc GCC_PCIE2_AHB_CLK>,
> +				 <&gcc GCC_PCIE2_PIPE_CLK>;
> +			clock-names = "aux", "cfg_ahb", "pipe";
> +
> +			assigned-clocks = <&gcc GCC_PCIE2_AUX_CLK>;
> +			assigned-clock-rates = <20000000>;
> +
> +			resets = <&gcc GCC_PCIE2_PHY_BCR>,
> +				 <&gcc GCC_PCIE2PHY_PHY_BCR>;
> +			reset-names = "phy", "common";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "gcc_pcie2_pipe_clk_src";
> +
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
>   		rng: rng@e3000 {
>   			compatible = "qcom,prng-ee";
>   			reg = <0x000e3000 0x1000>;
> @@ -243,6 +289,52 @@ mdio: mdio@90000 {
>   			status = "disabled";
>   		};
>   
> +		pcie3_phy: phy@f4000 {
> +			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
> +			reg = <0x000f4000 0x2000>;
> +
> +			clocks = <&gcc GCC_PCIE3_AUX_CLK>,
> +				 <&gcc GCC_PCIE3_AHB_CLK>,
> +				 <&gcc GCC_PCIE3_PIPE_CLK>;
> +			clock-names = "aux", "cfg_ahb", "pipe";
> +
> +			assigned-clocks = <&gcc GCC_PCIE3_AUX_CLK>;
> +			assigned-clock-rates = <20000000>;
> +
> +			resets = <&gcc GCC_PCIE3_PHY_BCR>,
> +				 <&gcc GCC_PCIE3PHY_PHY_BCR>;
> +			reset-names = "phy", "common";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "gcc_pcie3_pipe_clk_src";
> +
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		pcie1_phy: phy@fc000 {
> +			compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> +			reg = <0x000fc000 0x1000>;
> +
> +			clocks = <&gcc GCC_PCIE1_AUX_CLK>,
> +				 <&gcc GCC_PCIE1_AHB_CLK>,
> +				 <&gcc GCC_PCIE1_PIPE_CLK>;
> +			clock-names = "aux", "cfg_ahb", "pipe";
> +
> +			assigned-clocks = <&gcc GCC_PCIE1_AUX_CLK>;
> +			assigned-clock-rates = <20000000>;
> +
> +			resets = <&gcc GCC_PCIE1_PHY_BCR>,
> +				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
> +			reset-names = "phy", "common";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "gcc_pcie1_pipe_clk_src";
> +
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
>   		qfprom: efuse@a4000 {
>   			compatible = "qcom,ipq9574-qfprom", "qcom,qfprom";
>   			reg = <0x000a4000 0x5a1>;
> @@ -309,10 +401,10 @@ gcc: clock-controller@1800000 {
>   			clocks = <&xo_board_clk>,
>   				 <&sleep_clk>,
>   				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> +				 <&pcie0_phy>,
> +				 <&pcie1_phy>,
> +				 <&pcie2_phy>,
> +				 <&pcie3_phy>,
>   				 <0>;
>   			#clock-cells = <1>;
>   			#reset-cells = <1>;
> @@ -756,6 +848,326 @@ frame@b128000 {
>   				status = "disabled";
>   			};
>   		};
> +
> +		pcie1: pcie@10000000 {
> +			compatible = "qcom,pcie-ipq9574";
> +			reg =  <0x10000000 0xf1d>,
> +			       <0x10000f20 0xa8>,
> +			       <0x10001000 0x1000>,
> +			       <0x000f8000 0x4000>,
> +			       <0x10100000 0x1000>;
> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <1>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x00000000 0x10200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x10300000 0x10300000 0x0 0x7d00000>;
> +
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 35 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 49 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 84 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 85 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE1_AXI_M_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_S_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>,
> +				 <&gcc GCC_PCIE1_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE1_AHB_CLK>,
> +				 <&gcc GCC_PCIE1_AUX_CLK>;
> +			clock-names = "axi_m",
> +				      "axi_s",
> +				      "axi_bridge",
> +				      "rchng",
> +				      "ahb",
> +				      "aux";
> +
> +			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
> +				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_S_STICKY_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_S_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_M_STICKY_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_M_ARES>,
> +				 <&gcc GCC_PCIE1_AUX_ARES>,
> +				 <&gcc GCC_PCIE1_AHB_ARES>;
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
> +			interconnects = <&gcc MASTER_ANOC_PCIE1 &gcc SLAVE_ANOC_PCIE1>,
> +					<&gcc MASTER_SNOC_PCIE1 &gcc SLAVE_SNOC_PCIE1>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +			status = "disabled";
> +		};
> +
> +		pcie3: pcie@18000000 {
> +			compatible = "qcom,pcie-ipq9574";
> +			reg =  <0x18000000 0xf1d>,
> +			       <0x18000f20 0xa8>,
> +			       <0x18001000 0x1000>,
> +			       <0x000f0000 0x4000>,
> +			       <0x18100000 0x1000>;
> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <3>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <2>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x00000000 0x18200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x18300000 0x18300000 0x0 0x7d00000>;
> +
> +			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,

Exact same SPI lines are listed for pcie@20000000 controller as well.

With this, MSI on pcie@18000000 don't seem to work.

> +				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 189 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 190 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 191 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 192 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE3_AXI_M_CLK>,
> +				 <&gcc GCC_PCIE3_AXI_S_CLK>,
> +				 <&gcc GCC_PCIE3_AXI_S_BRIDGE_CLK>,
> +				 <&gcc GCC_PCIE3_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE3_AHB_CLK>,
> +				 <&gcc GCC_PCIE3_AUX_CLK>;
> +			clock-names = "axi_m",
> +				      "axi_s",
> +				      "axi_bridge",
> +				      "rchng",
> +				      "ahb",
> +				      "aux";
> +
> +			resets = <&gcc GCC_PCIE3_PIPE_ARES>,
> +				 <&gcc GCC_PCIE3_CORE_STICKY_ARES>,
> +				 <&gcc GCC_PCIE3_AXI_S_STICKY_ARES>,
> +				 <&gcc GCC_PCIE3_AXI_S_ARES>,
> +				 <&gcc GCC_PCIE3_AXI_M_STICKY_ARES>,
> +				 <&gcc GCC_PCIE3_AXI_M_ARES>,
> +				 <&gcc GCC_PCIE3_AUX_ARES>,
> +				 <&gcc GCC_PCIE3_AHB_ARES>;
> +			reset-names = "pipe",
> +				      "sticky",
> +				      "axi_s_sticky",
> +				      "axi_s",
> +				      "axi_m_sticky",
> +				      "axi_m",
> +				      "aux",
> +				      "ahb";
> +
> +			phys = <&pcie3_phy>;
> +			phy-names = "pciephy";
> +			interconnects = <&gcc MASTER_ANOC_PCIE3 &gcc SLAVE_ANOC_PCIE3>,
> +					<&gcc MASTER_SNOC_PCIE3 &gcc SLAVE_SNOC_PCIE3>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +			status = "disabled";
> +		};
> +
> +		pcie2: pcie@20000000 {
> +			compatible = "qcom,pcie-ipq9574";
> +			reg =  <0x20000000 0xf1d>,
> +			       <0x20000f20 0xa8>,
> +			       <0x20001000 0x1000>,
> +			       <0x00088000 0x4000>,
> +			       <0x20100000 0x1000>;
> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <2>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <2>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x00000000 0x20200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x20300000 0x20300000 0x0 0x7d00000>;
> +
> +			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 164 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 165 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 186 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 187 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE2_AXI_M_CLK>,
> +				 <&gcc GCC_PCIE2_AXI_S_CLK>,
> +				 <&gcc GCC_PCIE2_AXI_S_BRIDGE_CLK>,
> +				 <&gcc GCC_PCIE2_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE2_AHB_CLK>,
> +				 <&gcc GCC_PCIE2_AUX_CLK>;
> +			clock-names = "axi_m",
> +				      "axi_s",
> +				      "axi_bridge",
> +				      "rchng",
> +				      "ahb",
> +				      "aux";
> +
> +			resets = <&gcc GCC_PCIE2_PIPE_ARES>,
> +				 <&gcc GCC_PCIE2_CORE_STICKY_ARES>,
> +				 <&gcc GCC_PCIE2_AXI_S_STICKY_ARES>,
> +				 <&gcc GCC_PCIE2_AXI_S_ARES>,
> +				 <&gcc GCC_PCIE2_AXI_M_STICKY_ARES>,
> +				 <&gcc GCC_PCIE2_AXI_M_ARES>,
> +				 <&gcc GCC_PCIE2_AUX_ARES>,
> +				 <&gcc GCC_PCIE2_AHB_ARES>;
> +			reset-names = "pipe",
> +				      "sticky",
> +				      "axi_s_sticky",
> +				      "axi_s",
> +				      "axi_m_sticky",
> +				      "axi_m",
> +				      "aux",
> +				      "ahb";
> +
> +			phys = <&pcie2_phy>;
> +			phy-names = "pciephy";
> +			interconnects = <&gcc MASTER_ANOC_PCIE2 &gcc SLAVE_ANOC_PCIE2>,
> +					<&gcc MASTER_SNOC_PCIE2 &gcc SLAVE_SNOC_PCIE2>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +			status = "disabled";
> +		};
> +
> +		pcie0: pci@28000000 {
pcie@28000000 to match other nodes
> +			compatible = "qcom,pcie-ipq9574";
> +			reg =  <0x28000000 0xf1d>,
> +			       <0x28000f20 0xa8>,
> +			       <0x28001000 0x1000>,
> +			       <0x00080000 0x4000>,
> +			       <0x28100000 0x1000>;
> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x00000000 0x28200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x28300000 0x28300000 0x0 0x7d00000>;
> +			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 75 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 78 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 79 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 83 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE0_AXI_M_CLK>,
> +				 <&gcc GCC_PCIE0_AXI_S_CLK>,
> +				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>,
> +				 <&gcc GCC_PCIE0_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE0_AHB_CLK>,
> +				 <&gcc GCC_PCIE0_AUX_CLK>;
> +			clock-names = "axi_m",
> +				      "axi_s",
> +				      "axi_bridge",
> +				      "rchng",
> +				      "ahb",
> +				      "aux";
> +
> +			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
> +				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
> +				 <&gcc GCC_PCIE0_AXI_S_STICKY_ARES>,
> +				 <&gcc GCC_PCIE0_AXI_S_ARES>,
> +				 <&gcc GCC_PCIE0_AXI_M_STICKY_ARES>,
> +				 <&gcc GCC_PCIE0_AXI_M_ARES>,
> +				 <&gcc GCC_PCIE0_AUX_ARES>,
> +				 <&gcc GCC_PCIE0_AHB_ARES>;
> +			reset-names = "pipe",
> +				      "sticky",
> +				      "axi_s_sticky",
> +				      "axi_s",
> +				      "axi_m_sticky",
> +				      "axi_m",
> +				      "aux",
> +				      "ahb";
> +
> +			phys = <&pcie0_phy>;
> +			phy-names = "pciephy";
> +			interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
> +					<&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +			status = "disabled";
> +		};
> +
>   	};
>   
>   	thermal-zones {

