Return-Path: <linux-pci+bounces-34527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872E6B310B0
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 09:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB03604760
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 07:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223A92E8E1E;
	Fri, 22 Aug 2025 07:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxiAkC/U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133F2E762C;
	Fri, 22 Aug 2025 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848633; cv=none; b=QviTQSiseoCFhCqcIzEDzNJFncw39S3oZS4EM4+jrQj90Hn3/XomeHRJNoScrjvwLFzJo/0x6j+6sSTxQhwIHXptlIN9Mt45wZfGZTEp1cl+6FoR/YOqFsJaSjRWbijcg4dXWmf9KdZMdOCndLcDjNPUVvOSv1pkCoGipDeRGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848633; c=relaxed/simple;
	bh=Vo6lGk3lJxWzkqjBHldERuXljqaYSDMJvGkWXAsvEMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTV6bbfHDOnpy/kL3Z7lZWx/psRHztB3awbvbdFrYYfygEHXhllkbkD5Nbs9qX5VSuomiQUIsr2PVU8Qr7jRwa3GOgd0u3wXXY7JjZJ+iPMmmHZIA+YJM8Ecl/7qFoBFWenSYDfAX00a7ohxGqpNSfg6v9qodnU/YCLbCRQj9UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxiAkC/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DE9C4CEF1;
	Fri, 22 Aug 2025 07:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755848632;
	bh=Vo6lGk3lJxWzkqjBHldERuXljqaYSDMJvGkWXAsvEMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxiAkC/Uq6DTFLdpAeDazGexMQGwo5OAzT25VbIPq9h6cbk0g0Pm7aCBXH6ge/K5C
	 Eysk+65rDgz5DuULeiQrGXivwHmnMScNXYLo4t0JddFrhKJu+qBi4fgQf/tVFiEC/Y
	 rLQPLfHYHHMVNInaLRPmXOw3ptp0oIjfpZFHFvL7kis+M+kblYA+h8SKZ84ZOOi4Ps
	 sxyPYn3S0UVY7XkexvvOtghovEAhd0nIP4e2NjMa0SqUJo4ovTO5WSEfL6mkH1r3P2
	 pBK8ElcKSfqeNpjB8PbtH9btw1TsE59bJA7PGnvhcZtnPkkAIk504Ngbk9BZ7f00gO
	 8pqIqcIqWfA0A==
Date: Fri, 22 Aug 2025 13:13:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v10 3/5] arm64: dts: qcom: qcs8300-ride: enable pcie0
 interface
Message-ID: <wwpdqg3tqq252emsbhu3lvpq5eefgbzk7bpgr2gu3hekokoqob@76fcww4fm3yg>
References: <20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com>
 <20250811071131.982983-4-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811071131.982983-4-ziyue.zhang@oss.qualcomm.com>

On Mon, Aug 11, 2025 at 03:11:29PM GMT, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe0, board related gpios,
> PMIC regulators, etc for qcs8300-ride board.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 40 +++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> index 8c166ead912c..e8e382db2b99 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> @@ -308,6 +308,23 @@ &iris {
>  	status = "okay";
>  };
>  
> +&pcie0 {
> +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;

Since we have deprecated these properties in host bridge node recently, please
move these properties to PCI bridge node.

- Mani

> +
> +	pinctrl-0 = <&pcie0_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	vdda-phy-supply = <&vreg_l6a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +
> +	status = "okay";
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> @@ -348,6 +365,29 @@ ethernet0_mdio: ethernet0-mdio-pins {
>  			bias-pull-up;
>  		};
>  	};
> +
> +	pcie0_default_state: pcie0-default-state {
> +		wake-pins {
> +			pins = "gpio0";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		clkreq-pins {
> +			pins = "gpio1";
> +			function = "pcie0_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-pins {
> +			pins = "gpio2";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +	};
>  };
>  
>  &uart7 {
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

