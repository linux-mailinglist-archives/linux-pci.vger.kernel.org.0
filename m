Return-Path: <linux-pci+bounces-31061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CB6AED5BB
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 09:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67093B79F1
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 07:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6822185A8;
	Mon, 30 Jun 2025 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hx8ADqTK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0878190072;
	Mon, 30 Jun 2025 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268800; cv=none; b=kp9ezXpIZ8CWKA42EhMQlOe47dL20MKsW4JdpJLPUO75PUwvGn6j+lhX0GJq+mDaiAhnW++peunjl/1JbEWDn40HbEiduPvIbTSbxHh8Gxig+/cVErTtOxJauiPin+3bQJennLz9E5Ptgbm6Nu41ngNZzyk/B75aF4j4BHBiItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268800; c=relaxed/simple;
	bh=sGA8pj8z6/OPVGb0FWOogVxSnD1pMIT0m8Q8IQAiG/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmRCNRsfsMxQgiQlnzZ/tqXaaOtYChS5muCDPzKHTRipAvd2uW9FZK8uUYIUWs6HcQHLY5kTBQ9YUQcKGqtv6u3DqBaBnZ7/ScXDboCPdEJqKlaz/Ts0/NLI0jeu05BOeljkWWSP9AmSyzcVZY0dAZr8vEJVrY9AEwhT3dNNjo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx8ADqTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F06C4CEE3;
	Mon, 30 Jun 2025 07:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751268799;
	bh=sGA8pj8z6/OPVGb0FWOogVxSnD1pMIT0m8Q8IQAiG/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hx8ADqTKumOLneEmz4Q/GhcyoTL6n4dzKFJZxUUcLKyxsb4Lk32BOya9g30efS7XT
	 F2dxgILtZxke2gZtlPSdWeBGQ4TAuqKvS/Oa7LRPuZIlbP0VfpxU4nxX7OKPBenibj
	 Z3NVJg0Bft+JNDnTwLoGhSem9iCMlohbUH8e5sHQNP2i5LpzFRcLWicg3fPGFgcbRZ
	 lizZmhFQAwDA4kN1WZyvxsLHJiWmhpea0kbtmlNaLxkDbtbxwMwSiEMxTaGv7JTLY7
	 hanMqHOS722IOvcAfGwD9fp2fvAiLRf7ShkxXTml9cqsH5CXj/yos3YNiN6FyiYOhO
	 e1gR4nonOW/7w==
Date: Mon, 30 Jun 2025 09:33:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com, 
	guoyin.chen@cixtech.com, peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/14] arm64: dts: cix: Add PCIe Root Complex on sky1
Message-ID: <20250630-proficient-fearless-rottweiler-efde37@krzk-bin>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-14-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630041601.399921-14-hans.zhang@cixtech.com>

On Mon, Jun 30, 2025 at 12:16:00PM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add pcie_x*_rc node to support Sky1 PCIe driver based on the
> Cadence PCIe core.
> 
> Supports Gen1/Gen2/Gen3/Gen4, 1/2/4/8 lane, MSI/MSI-x interrupts
> using the ARM GICv3.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>

Where?

> ---
>  arch/arm64/boot/dts/cix/sky1.dtsi | 150 ++++++++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
> index 9c723917d8ca..1dac0e8d5fc1 100644
> --- a/arch/arm64/boot/dts/cix/sky1.dtsi
> +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
> @@ -289,6 +289,156 @@ mbox_ap2sfh: mailbox@80a0000 {
>  			cix,mbox-dir = "tx";
>  		};
>  
> +		pcie_x8_rc: pcie@a010000 { /* X8 */
> +			compatible = "cix,sky1-pcie-host";
> +			reg = <0x00 0x0a010000 0x00 0x10000>,
> +			      <0x00 0x0a000000 0x00 0x10000>,
> +			      <0x00 0x2c000000 0x00 0x4000000>,
> +			      <0x00 0x60000000 0x00 0x00100000>;
> +			reg-names = "reg", "rcsu", "cfg", "msg";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
> +			max-link-speed = <4>;
> +			num-lanes = <8>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			bus-range = <0xc0 0xff>;
> +			device_type = "pci";
> +			ranges = <0x01000000 0x0 0x60100000 0x0 0x60100000 0x0 0x00100000>,
> +				 <0x02000000 0x0 0x60200000 0x0 0x60200000 0x0 0x1fe00000>,
> +				 <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;

And none of the two reviewers asked you to follow DTS coding style? If
reviewer knows not much about DTS, don't review. Add an ack or
something, dunno, or actually perform proper review.

Best regards,
Krzysztof


