Return-Path: <linux-pci+bounces-29656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966FAD876A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 11:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3FE3AEDF9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7DA280CC8;
	Fri, 13 Jun 2025 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctnowZ7+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719B2727EC;
	Fri, 13 Jun 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806029; cv=none; b=FqqREwZCEqX6y1DrEly6wR3l/lk21Jsnl7DULTekb/7s5KwBhPjnTJcAgYuGa/hChvG6mNdGPuW0B4+CWpLqfHhdH/BgxLz/1Vbhf3C4mJpSpd3u1s9v5kHd01IA9j4DpZT5/Fr2Y1+RvhA01ezTHlOad0/2hK/kCicbF0vQYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806029; c=relaxed/simple;
	bh=A4rei9vr0g663YBmbvMyS3DhGYGv66yWEgowRVk+S8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7MIic14rFVDaK8u+CHCymh/DXBYq8fY4hq42j9kd89ZKOx/fpvWdYOeI+vxSzvl0F+0bCmOoBdzGrX2HDBQy9a00AHkiPAzMp99PT3bc1W/bSweh6rJD2fsW+Tmon8ADxm2ecsKw67ahOe7VkCG2caJ/kA41ZGYmtpNzNM7Yp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctnowZ7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E6DC4CEEB;
	Fri, 13 Jun 2025 09:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749806028;
	bh=A4rei9vr0g663YBmbvMyS3DhGYGv66yWEgowRVk+S8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctnowZ7+xat8+n++ruzyMKi4rSUPpy7C6PxmsBAeCvG5vn8DIQTiIKSgyC6HWQgfs
	 wSi/QTkKH5EnMf+yNB8TIgyR6zN+8nYqDBW7yKv8iifN4UgitR+XFZOm4A/MilI277
	 k5Srscym/w0I5LVd1MRyg8/ol4HinEhXjtJS8N6d0A0k0M7Nra8igd9Q5vFXjl47Ph
	 4fHaaRnPlhyREBzFc4VsYYGor4i7co+akWQ/0BTIxZqJ+PGVbs1p8u5BfVpmYdnk4u
	 5eU4+8HHXaQbkrkZGucVDkYVjVUD72mGqKlzYxFZdzt/0sc/kW5WOLz5aEejBQsqEP
	 jLadRYSNVZRZQ==
Date: Fri, 13 Jun 2025 14:43:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>, 
	krishna.chundru@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Qiang Yu <quic_qianyu@quicinc.com>, 
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/4] dt-bindings: PCI: qcom,pcie-sc8180x: Drop unrelated
 clocks from PCIe hosts
Message-ID: <qri7dxwqoltam2yanxicgejjq3xprd6cunvpgukasmtt7c5lmh@ikdl24royen6>
References: <20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com>
 <20250521-topic-8150_pcie_drop_clocks-v1-1-3d42e84f6453@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521-topic-8150_pcie_drop_clocks-v1-1-3d42e84f6453@oss.qualcomm.com>

+ Krishna

On Wed, May 21, 2025 at 03:38:10PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The TBU clock belongs to the Translation Buffer Unit, part of the SMMU.
> The ref clock is already being driven upstream through some of the
> branches.
> 

Can you please cross check with the hardware programming guide (I don't have
access to atm) that the 'ref' clock is no longer voted by the driver?

- Mani

> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml         | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
> index 331fc25d7a17d657d4db3863f0c538d0e44dc840..34a4d7b2c8459aeb615736f54c1971014adb205f 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
> @@ -33,8 +33,8 @@ properties:
>        - const: mhi # MHI registers
>  
>    clocks:
> -    minItems: 8
> -    maxItems: 8
> +    minItems: 6
> +    maxItems: 6
>  
>    clock-names:
>      items:
> @@ -44,8 +44,6 @@ properties:
>        - const: bus_master # Master AXI clock
>        - const: bus_slave # Slave AXI clock
>        - const: slave_q2a # Slave Q2A clock
> -      - const: ref # REFERENCE clock
> -      - const: tbu # PCIe TBU clock
>  
>    interrupts:
>      minItems: 8
> @@ -117,17 +115,13 @@ examples:
>                       <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>                       <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
>                       <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> -                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> -                     <&gcc GCC_PCIE_0_CLKREF_CLK>,
> -                     <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
> +                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
>              clock-names = "pipe",
>                            "aux",
>                            "cfg",
>                            "bus_master",
>                            "bus_slave",
> -                          "slave_q2a",
> -                          "ref",
> -                          "tbu";
> +                          "slave_q2a";
>  
>              dma-coherent;
>  
> 
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

