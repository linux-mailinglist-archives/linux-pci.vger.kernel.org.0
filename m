Return-Path: <linux-pci+bounces-41259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E2CC5EA74
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 18:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C347B4E7677
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 17:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FFC341AB0;
	Fri, 14 Nov 2025 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXMS/qkO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18B833A021;
	Fri, 14 Nov 2025 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142039; cv=none; b=MP3T5AzHNTECllR5pK25pSWH/c2VkWLcWeeV3CwiNXiNC0Y7CU8sldcmaMnTJ/fFzXi3I5tVZB4r7elzLSpp6rS4k6/qavag8xt7Qz9FjdIaCj6+8Meo0GdiAaDMYzSz5xHky0iJPXdV9Ctcj44S6SKPvqtBbUaSBPY2Km8Lm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142039; c=relaxed/simple;
	bh=XyjjvLoi259QCLHfpkGfVoVKsKAuDtg/KBjkVulIV3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1K/Qe0SlfamK4PYQx3oNR8UwZdxsT0ISo6p13eBAzt2Vff1kLEdQvq+xIx+3SgO8gB6oUPOcgn1XMvhB3KvBnRtD6iW3NuElkGYHHvK2UlQqYHISgYX41fU/hXqQpspJH+Gn+2CSTuynPV9ADR7ZMUgSBo8sh73B5UsYwG9Y4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXMS/qkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A0DC4CEF5;
	Fri, 14 Nov 2025 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763142038;
	bh=XyjjvLoi259QCLHfpkGfVoVKsKAuDtg/KBjkVulIV3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXMS/qkO1FU4+yZsh79UN6ooCLpMlD0KkTuWbuNlIfHzPMCuZDFzz6Sq54z0cV4dc
	 RwUwJj84xYy7Ks9KRaMgTEEpxl85jWQe9Toii+SROmobR8h8GIHxOqIHJDB1jPwt/s
	 t+RhRj1y2v+Q7hc8Z8wW4KSgD0j6rpe5rVE2QqqLUDki4r/2aU4Nscpc5YULgimXlU
	 FY4NS4eL5aD05UtpxdQw4X33Y7hdSnWtKS0inoY3LO0LdiLQ8Ibt9SDVwJcKkEmYi+
	 NAwjO/zBaBJ+eiGgmCsS1/gEkCb8yHM6GD5lK1PWCHQmCLDgjiUvIyJ8DqEn2nH8xi
	 6hJJwlhPAO1oQ==
Date: Fri, 14 Nov 2025 23:10:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, helgaas@kernel.org, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com, 
	guoyin.chen@cixtech.com, peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 09/10] arm64: dts: cix: Add PCIe Root Complex on sky1
Message-ID: <bmzzuk4zvxyso5qyw7lsq3dxc7roiqhnip2mwsrlwkeenna7ic@n6cpil6nmahx>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
 <20251108140305.1120117-10-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251108140305.1120117-10-hans.zhang@cixtech.com>

On Sat, Nov 08, 2025 at 10:03:04PM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add pcie_x*_rc node to support Sky1 PCIe driver based on the
> Cadence PCIe core.
> 
> Supports Gen1/Gen2/Gen3/Gen4, 1/2/4/8 lane, MSI/MSI-x interrupts
> using the ARM GICv3.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  arch/arm64/boot/dts/cix/sky1.dtsi | 126 ++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
> index 2fb2c99c0796..1abafbfc3c9b 100644
> --- a/arch/arm64/boot/dts/cix/sky1.dtsi
> +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
> @@ -388,6 +388,132 @@ mbox_ap2sfh: mailbox@80a0000 {
>  			cix,mbox-dir = "tx";
>  		};
>  
> +		pcie_x8_rc: pcie@a010000 {
> +			compatible = "cix,sky1-pcie-host";
> +			reg = <0x00 0x0a010000 0x00 0x10000>,
> +			      <0x00 0x2c000000 0x00 0x4000000>,
> +			      <0x00 0x0a000300 0x00 0x100>,
> +			      <0x00 0x0a000400 0x00 0x100>,
> +			      <0x00 0x60000000 0x00 0x00100000>;
> +			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
> +			ranges = <0x01000000 0x0 0x60100000 0x0 0x60100000 0x0 0x00100000>,
> +				 <0x02000000 0x0 0x60200000 0x0 0x60200000 0x0 0x1fe00000>,
> +				 <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			bus-range = <0xc0 0xff>;
> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
> +			msi-map = <0xc000 &gic_its 0xc000 0x4000>;
> +			status = "disabled";
> +		};
> +
> +		pcie_x4_rc: pcie@a070000 {
> +			compatible = "cix,sky1-pcie-host";
> +			reg = <0x00 0x0a070000 0x00 0x10000>,
> +			      <0x00 0x29000000 0x00 0x3000000>,
> +			      <0x00 0x0a060300 0x00 0x40>,
> +			      <0x00 0x0a060400 0x00 0x40>,
> +			      <0x00 0x50000000 0x00 0x00100000>;
> +			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
> +			ranges = <0x01000000 0x00 0x50100000 0x00 0x50100000 0x00 0x00100000>,
> +				 <0x02000000 0x00 0x50200000 0x00 0x50200000 0x00 0x0fe00000>,
> +				 <0x43000000 0x14 0x00000000 0x14 0x00000000 0x04 0x00000000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			bus-range = <0x90 0xbf>;
> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH 0>;
> +			msi-map = <0x9000 &gic_its 0x9000 0x3000>;
> +			status = "disabled";
> +		};
> +
> +		pcie_x2_rc: pcie@a0c0000 {
> +			compatible = "cix,sky1-pcie-host";
> +			reg = <0x00 0x0a0c0000 0x00 0x10000>,
> +			      <0x00 0x26000000 0x00 0x3000000>,
> +			      <0x00 0x0a0600340 0x00 0x20>,
> +			      <0x00 0x0a0600440 0x00 0x20>,
> +			      <0x00 0x40000000 0x00 0x00100000>;
> +			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
> +			ranges = <0x01000000 0x0 0x40100000 0x0 0x40100000 0x0 0x00100000>,
> +				 <0x02000000 0x0 0x40200000 0x0 0x40200000 0x0 0x0fe00000>,
> +				 <0x43000000 0x10 0x00000000 0x10 0x00000000 0x04 0x00000000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			bus-range = <0x60 0x8f>;
> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH 0>;
> +			msi-map = <0x6000 &gic_its 0x6000 0x3000>;
> +			status = "disabled";
> +		};
> +
> +		pcie_x1_0_rc: pcie@a0d0000 {
> +			compatible = "cix,sky1-pcie-host";
> +			reg = <0x00 0x0a0d0000 0x00 0x10000>,
> +			      <0x00 0x20000000 0x00 0x3000000>,
> +			      <0x00 0x0a060360 0x00 0x20>,
> +			      <0x00 0x0a060460 0x00 0x20>,
> +			      <0x00 0x30000000 0x00 0x00100000>;
> +			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
> +			ranges = <0x01000000 0x0 0x30100000 0x0 0x30100000 0x0 0x00100000>,
> +				 <0x02000000 0x0 0x30200000 0x0 0x30200000 0x0 0x07e00000>,
> +				 <0x43000000 0x08 0x00000000 0x08 0x00000000 0x04 0x00000000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			bus-range = <0x00 0x2f>;
> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH 0>;
> +			msi-map = <0x0000 &gic_its 0x0000 0x3000>;
> +			status = "disabled";
> +		};
> +
> +		pcie_x1_1_rc: pcie@a0e0000 {
> +			compatible = "cix,sky1-pcie-host";
> +			reg = <0x00 0x0a0e0000 0x00 0x10000>,
> +			      <0x00 0x23000000 0x00 0x3000000>,
> +			      <0x00 0x0a060380 0x00 0x20>,
> +			      <0x00 0x0a060480 0x00 0x20>,
> +			      <0x00 0x38000000 0x00 0x00100000>;
> +			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
> +			ranges = <0x01000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000>,
> +				 <0x02000000 0x0 0x38200000 0x0 0x38200000 0x0 0x07e00000>,
> +				 <0x43000000 0x0C 0x00000000 0x0C 0x00000000 0x04 0x00000000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			bus-range = <0x30 0x5f>;
> +			device_type = "pci";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH 0>;
> +			msi-map = <0x3000 &gic_its 0x3000 0x3000>;
> +			status = "disabled";
> +		};
> +
>  		gic: interrupt-controller@e010000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x0 0x0e010000 0 0x10000>,	/* GICD */
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

