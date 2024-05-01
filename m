Return-Path: <linux-pci+bounces-6975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417CF8B90A2
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 22:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D161C217D5
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 20:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B366C147C74;
	Wed,  1 May 2024 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SypZ/tLc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C31527B2;
	Wed,  1 May 2024 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714595576; cv=none; b=kDhddhhsU5j4ZfspYTFYeh8FT9ZhrlBeSjvNNMRUYIvMoaxJHGClc1GaewcTnkrHsN8jTx3k9vrOGgQHX6CnXLlJvfB9ssJPmcLRtkA/2/bTGUWfGXqLun8FlNu/RQ20ez/ah0qPncBzlCiDzjHzvt2wqjy1ROYQbng2u4z0X6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714595576; c=relaxed/simple;
	bh=kHPex7wRsRdxgybsWrTwxdR3oVX9EtULevfdnKktyQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AU7q/ml7RPhiw92YCQPRyshKVJcvDpytPH4Icu5YBWL36RZTBNPoJ64UY0ivEZEL+uVNrqxKD/xOmlH8cG595QPVnONQ1ABmwZU5b9U+TqIvcgseGOFAV8lx49TbU/FN50lGmh4pZpDiZVobLrjXO/8B35LMov4iJworMerZ6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SypZ/tLc; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23d39e4c0d9so739124fac.0;
        Wed, 01 May 2024 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714595574; x=1715200374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PK6bUYnjKXA3139CuZnFqKdohXzB6bNghOA877px0F0=;
        b=SypZ/tLckei+0YnnXpuPrsPK31yfviKmoKPUfD8t0Ok/yW2Oryf1+YavXkYD/6LiCV
         hDXkXHAbyncZSLR6IUih1rowfi3/xtMfClpoVSnnx8bCeb/GEhk+hMweFRc19z4oOIaT
         Sif867X5o6aMxkI2Xo2y6L17RtpaJUKHTX0XCaNnmbmT6O2Nqmg4+zdq5Z+u+MXlCevE
         gjPkhNLRb8WKm1J3kezu8NarzHThsSlDMKJibxlGvuzh46zNEA0SWTJaYI/qgJlM0KR6
         BXhG5fNoHIw9OsBnGqFiEpPavvI6ToUBU9Af+cejUk5txMWvzxMVBiZP7Em+LX97L/3Z
         +aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714595574; x=1715200374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PK6bUYnjKXA3139CuZnFqKdohXzB6bNghOA877px0F0=;
        b=UFUkxFoSGSoI2pHQ1iToxTV7CqqERdEraojwMjBK8AgXDiJq4T7axSYcyJRCd65IOr
         Aj7AlKW4hkpotKyQsV7uSquSV+p1ApIm/yxUOi32vte4KcdKQfDQCdggTzwv7Gj6VmkT
         NkPhyU7yYzzbj4XFmhFWDA4yNfuoiFYPi+VeYsMVwbaDb3IvGjXL7hj5jxaHO54GVt/P
         82f7t7kjxDL/1gWEUnIB2l7x+jxi8mIFTueZHV4vejGr+vpgSnvV/4lJmw02Cczwzz4B
         ONecFu0DcitQ6VYjuLGeybInRwHisqCk16WWinnsprIvdyoLV9c0DrXF6fMGl2TfLzlQ
         U5ow==
X-Forwarded-Encrypted: i=1; AJvYcCWdKzNWpMvX0NvFJUu/SCt3mBxr9UnCEb2b33aB5ETn/b0prNJKhqnzLzHs81DaKWPwt1UDD4aSfNqhqnKGImALiCx2/3/amz7jM7EYYHlfWGyZPTOwLf6XITEhp+zsk1YU0c8RxJTqHLxdMGu1dA1QbiG2HGgZIZ0xXqq9QW8+h2kWiAN46m0qeiD3TLmD7m4grUTDzV+ZdsnR4eRKphFsWhT922PK/0e6q1qoUNHIx7iFB9r28QSKjpaBnSw=
X-Gm-Message-State: AOJu0YyXM1T/vNmdtL7XLcyJKBqlCWm1CDrC34t/GKqPXi4HmG3CWK/1
	Kf7nOkVI4HtChAs2o27znqHEZSfYFx4p7n2mNn94tbMOSqMZRw3/
X-Google-Smtp-Source: AGHT+IEEi213Oim+pFQt5WqNLTilQ8NosxMtUvlAkKIuNAoYd59Y3HupxqwZGjbBQ04m8SUtsX/Msw==
X-Received: by 2002:a05:6870:be97:b0:22f:bdb:633c with SMTP id nx23-20020a056870be9700b0022f0bdb633cmr125208oab.16.1714595574119;
        Wed, 01 May 2024 13:32:54 -0700 (PDT)
Received: from [192.168.7.110] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id rb11-20020a056871618b00b0023b5791f396sm2889919oab.15.2024.05.01.13.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 13:32:53 -0700 (PDT)
Message-ID: <7da9d481-1e44-4f0e-9210-fcbd95bd654f@gmail.com>
Date: Wed, 1 May 2024 15:32:52 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 8/8] arm64: dts: qcom: ipq9574: add PCIe2 and
 PCIe3 nodes
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
 <20240501042847.1545145-9-mr.nuke.me@gmail.com>
Content-Language: en-US
From: "Alex G." <mr.nuke.me@gmail.com>
In-Reply-To: <20240501042847.1545145-9-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/30/24 23:28, Alexandru Gagniuc wrote:
> On ipq9574, there are 4 PCIe controllers. Describe the pcie2 and pcie3
> nodes, and their PHYs in devicetree.
> 
> The pcie0 and pcie1 controllers use a gen3x1 PHY, which is not
> currently supported. Hence, only pcie2 and pcie3 are described. Only
> pcie2 was tested because my devboard only has conenctions to pcie2.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 178 +++++++++++++++++++++++++-
>   1 file changed, 176 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 7f2e5cbf3bbb..c391886cf9ab 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -300,8 +300,8 @@ gcc: clock-controller@1800000 {
>   				 <0>,
>   				 <0>,
>   				 <0>,
> -				 <0>,
> -				 <0>,
> +				 <&pcie2_phy>,
> +				 <&pcie3_phy>,
>   				 <0>;
>   			#clock-cells = <1>;
>   			#reset-cells = <1>;
> @@ -745,6 +745,180 @@ frame@b128000 {
>   				status = "disabled";
>   			};
>   		};
> +
> +		pcie2_phy: phy@8c000 {
> +			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
> +			reg = <0x0008c000 0x14f4>;
> +
> +			clocks = <&gcc GCC_PCIE2_AUX_CLK>,
> +				 <&gcc GCC_PCIE2_AHB_CLK>,
> +				 <&gcc GCC_PCIE2_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "pipe";
> +
> +			clock-output-names = "pcie_phy2_pipe_clk";
> +			#clock-cells = <0>;
> +			#phy-cells = <0>;
> +
> +			resets = <&gcc GCC_PCIE2_PHY_BCR>,
> +				 <&gcc GCC_PCIE2PHY_PHY_BCR>;
> +			reset-names = "phy",
> +				      "common";
> +			status = "disabled";
> +		};
> +
> +		pcie3_phy: phy@f4000 {
> +			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
> +			reg = <0x000f4000 0x14f4>;
> +
> +			clocks = <&gcc GCC_PCIE3_AUX_CLK>,
> +				 <&gcc GCC_PCIE3_AHB_CLK>,
> +				 <&gcc GCC_PCIE3_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "pipe";
> +
> +			clock-output-names = "pcie_phy3_pipe_clk";
> +			#clock-cells = <0>;
> +			#phy-cells = <0>;
> +
> +			resets = <&gcc GCC_PCIE3_PHY_BCR>,
> +				 <&gcc GCC_PCIE3PHY_PHY_BCR>;
> +			reset-names = "phy",
> +				      "common";
> +			status = "disabled";
> +		};
> +
> +		/* TODO: Populate pcie0/pcie1 when gen3x1 phy support is added. */
> +
> +		pcie2: pcie@20000000 {
> +			compatible = "qcom,pcie-ipq9574";
> +			reg = <0x20000000 0xf1d>,
> +			      <0x20000f20 0xa8>,
> +			      <0x20001000 0x1000>,
> +			      <0x00088000 0x4000>,
> +			      <0x20100000 0x1000>;
> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
> +
> +			ranges = <0x81000000 0x0 0x20200000 0x20200000 0x0 0x00100000>,
> +				 <0x82000000 0x0 0x20300000 0x20300000 0x0 0x07d00000>;
> +
> +			device_type = "pci";
> +			linux,pci-domain = <3>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <2>;
> +			max-link-speed = <3>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			phys = <&pcie2_phy>;
> +			phy-names = "pciephy";
> +
> +			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
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
> +				 <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
> +				 <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>,
> +				 <&gcc GCC_PCIE2_RCHNG_CLK>;
> +			clock-names = "axi_m",
> +				      "axi_s",
> +				      "axi_bridge",
> +				      "rchng";

There is a mistake here with the clock-names :( . Will fix it in v5.

> +
> +			resets = <&gcc GCC_PCIE2_PIPE_ARES>,
> +				 <&gcc GCC_PCIE2_AUX_ARES>,
> +				 <&gcc GCC_PCIE2_CORE_STICKY_ARES>,
> +				 <&gcc GCC_PCIE2_AXI_M_ARES>,
> +				 <&gcc GCC_PCIE2_AXI_S_ARES>,
> +				 <&gcc GCC_PCIE2_AXI_S_STICKY_ARES>,
> +				 <&gcc GCC_PCIE2_AXI_M_STICKY_ARES>,
> +				 <&gcc GCC_PCIE2_AHB_ARES>;
> +			reset-names = "pipe",
> +				      "aux",
> +				      "sticky",
> +				      "axi_m",
> +				      "axi_s",
> +				      "axi_s_sticky",
> +				      "axi_m_sticky",
> +				      "ahb";
> +			status = "disabled";
> +		};
> +
> +		pcie3: pcie@18000000 {
> +			compatible = "qcom,pcie-ipq9574";
> +			reg = <0x18000000 0xf1d>,
> +			      <0x18000f20 0xa8>,
> +			      <0x18001000 0x1000>,
> +			      <0x000f0000 0x4000>,
> +			      <0x18100000 0x1000>;
> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
> +
> +			ranges = <0x81000000 0x0 0x18200000 0x18200000 0x0 0x00100000>,
> +				 <0x82000000 0x0 0x18300000 0x18300000 0x0 0x07d00000>;
> +
> +			device_type = "pci";
> +			linux,pci-domain = <4>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <2>;
> +			max-link-speed = <3>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			phys = <&pcie3_phy>;
> +			phy-names = "pciephy";
> +
> +			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 189 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 190 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 192 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 192 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE3_AXI_M_CLK>,
> +				 <&gcc GCC_PCIE3_AXI_S_CLK>,
> +				 <&gcc GCC_PCIE3_AXI_S_BRIDGE_CLK>,
> +				 <&gcc GCC_ANOC_PCIE3_2LANE_M_CLK>,
> +				 <&gcc GCC_SNOC_PCIE3_2LANE_S_CLK>,
> +				 <&gcc GCC_PCIE3_RCHNG_CLK>;
> +			clock-names = "axi_m",
> +				      "axi_s",
> +				      "axi_bridge",
> +				      "anoc",
> +				      "snoc",
> +				      "rchng";
> +
> +			resets = <&gcc GCC_PCIE3_PIPE_ARES>,
> +				 <&gcc GCC_PCIE3_AUX_ARES>,
> +				 <&gcc GCC_PCIE3_CORE_STICKY_ARES>,
> +				 <&gcc GCC_PCIE3_AXI_M_ARES>,
> +				 <&gcc GCC_PCIE3_AXI_S_ARES>,
> +				 <&gcc GCC_PCIE3_AXI_S_STICKY_ARES>,
> +				 <&gcc GCC_PCIE3_AXI_M_STICKY_ARES>,
> +				 <&gcc GCC_PCIE3_AHB_ARES>;
> +			reset-names = "pipe",
> +				      "aux",
> +				      "sticky",
> +				      "axi_m",
> +				      "axi_s",
> +				      "axi_s_sticky",
> +				      "axi_m_sticky",
> +				      "ahb";
> +			status = "disabled";
> +		};
>   	};
>   
>   	thermal-zones {

