Return-Path: <linux-pci+bounces-38650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83DBEDE90
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 07:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19ECC3A8880
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 05:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D2C22126C;
	Sun, 19 Oct 2025 05:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH1cnBZH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7A354ADF;
	Sun, 19 Oct 2025 05:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760852780; cv=none; b=kD+j76umSHSTqGaRhB3INhMlvYlcyEYFLNyYoEx3EP5hornQUKj4PyB0ov32r5Y7aMwp/Y8fqSmgLYxNTyzAQbk4R6AoCU3tBbFsvq8vx4xoY2/BDr6L73Cj18Y8hpfaQp9A3z6U2tgFFBab2iDbQYik65PSV76Ljd+l7QAK/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760852780; c=relaxed/simple;
	bh=k6dLJospkNnZM88ur31GaVa3vtvm36+YwoHgWyO9KWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDuZwZFVskIPtJpCpRw60MYRZ9k4qQHlLW+xjZg/sfUj34ZkcuGzKwioFNYvUGVvRPBwD+RCYA/vDuiFUggdIkQtPoxMYre5AEVU6Exlz0x0dFc3PMfgQx7IznxZhaQrHemR5GzbigaAZ1jZPAQzjXwH87wm2lJuMxz+jhbHIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH1cnBZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2CCC4CEE7;
	Sun, 19 Oct 2025 05:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760852779;
	bh=k6dLJospkNnZM88ur31GaVa3vtvm36+YwoHgWyO9KWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BH1cnBZHVvkXAIDXVa76qucH+MM6U4BI32MRjM3/OwIyrVezK8qBavKRymWlsrVH3
	 v5mU6zylvUJDFfGUaMPbfWpF36R/sj/23PSim4gZuda0JR+umCOo6ESx2mXBhxX4bd
	 J3R8XgTjwKbXpVWtUKhgFr/9ElAjLUc5efSGe+8Hs1CKL6rbnX5g/69stiEnf3+XOc
	 faAnizHGhLd8bKt5Ene03RVXHJJG4TV1h60zxRmwZTkKnK6MISB4WvRBf9Va7EpNZ/
	 dZm2r3WJPiXWARwneR9IDY+tXnWTD9lQke+GScWX+O4EfnIWNLMt2NPKQK5XuWjPnc
	 f/Fh2VIf5Gr3g==
Date: Sun, 19 Oct 2025 11:15:57 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	bhelgaas@google.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: Re: [PATCH v3 1/2] arm64: dts: toshiba: Update SoC and PCIe ranges
 to reflect hardware behavior
Message-ID: <qspujjam6am5wzdrb3ygbprdxf5u3aonn5m5qhywxvok5vapgy@idqfjpzs5hna>
References: <1757298848-15154-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1757298848-15154-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1757298848-15154-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>

On Mon, Sep 08, 2025 at 11:34:07AM +0900, Nobuhiro Iwamatsu wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> tmpv7708 trim address bit[31:30] in tmpv7708 before passing to the PCIe
> controller. Since only PCIe controller needs to convert the address range
> 0x40000000 - 0x80000000, add a bus definition, describe the ranges in it,
> and move the PCIe definition.
> 
> Prepare for the removal of the driver’s cpu_addr_fixup().
> 

This statement is the linux driver behavior which has nothing to do with
devicetree. Please drop it.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Suggested-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> 
> ---
> v3:
>  Move update in drivers/pci/controller/dwc/pcie-visconti.c to patch 2.
>  Update Signed-off-by address, because my company email address has changed.
> 
> v2:
>   Update commit message.
>   Fix range.
>   Set true to use_parent_dt_ranges.
>   move pcie under the dedicated sub-bus.
> ---
>  arch/arm64/boot/dts/toshiba/tmpv7708.dtsi | 75 ++++++++++++++---------
>  1 file changed, 45 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> index 39806f0ae5133..b754965a76ca6 100644
> --- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> +++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> @@ -478,37 +478,52 @@ pwm: pwm@241c0000 {
>  			status = "disabled";
>  		};
>  
> -		pcie: pcie@28400000 {
> -			compatible = "toshiba,visconti-pcie";
> -			reg = <0x0 0x28400000 0x0 0x00400000>,
> -			      <0x0 0x70000000 0x0 0x10000000>,
> -			      <0x0 0x28050000 0x0 0x00010000>,
> -			      <0x0 0x24200000 0x0 0x00002000>,
> -			      <0x0 0x24162000 0x0 0x00001000>;
> -			reg-names = "dbi", "config", "ulreg", "smu", "mpu";
> -			device_type = "pci";
> -			bus-range = <0x00 0xff>;
> -			num-lanes = <2>;
> -			num-viewport = <8>;
> -
> -			#address-cells = <3>;
> +		pcie_bus: bus@24000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
>  			#size-cells = <2>;
> -			#interrupt-cells = <1>;
> -			ranges = <0x81000000 0 0x40000000 0 0x40000000 0 0x00010000
> -				  0x82000000 0 0x50000000 0 0x50000000 0 0x20000000>;
> -			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi", "intr";
> -			interrupt-map-mask = <0 0 0 7>;
> -			interrupt-map =
> -				<0 0 0 1 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> -				 0 0 0 2 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> -				 0 0 0 3 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> -				 0 0 0 4 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> -			max-link-speed = <2>;
> -			clocks = <&extclk100mhz>, <&pismu TMPV770X_CLK_PCIE_MSTR>, <&pismu TMPV770X_CLK_PCIE_AUX>;
> -			clock-names = "ref", "core", "aux";
> -			status = "disabled";
> +			ranges = /* register 1:1 map */
> +				 <0x0 0x24000000 0x0 0x24000000 0x0 0x0C000000>,
> +				 /*
> +				  * bus fabric mask address bit 30 and 31 to 0
> +				  * before send to PCIe controller.
> +				  *
> +				  * PCIe map address 0 to cpu's 0x40000000
> +				  */
> +				 <0x0 0x00000000 0x0 0x40000000 0x0 0x40000000>;
> +
> +			pcie: pcie@28400000 {
> +				compatible = "toshiba,visconti-pcie";
> +				reg = <0x0 0x28400000 0x0 0x00400000>,
> +				      <0x0 0x30000000 0x0 0x10000000>,
> +				      <0x0 0x28050000 0x0 0x00010000>,
> +				      <0x0 0x24200000 0x0 0x00002000>,
> +				      <0x0 0x24162000 0x0 0x00001000>;
> +				reg-names = "dbi", "config", "ulreg", "smu", "mpu";
> +				device_type = "pci";
> +				bus-range = <0x00 0xff>;
> +				num-lanes = <2>;
> +				num-viewport = <8>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				#interrupt-cells = <1>;
> +				ranges = <0x81000000 0 0x00000000 0 0x00000000 0 0x00010000
> +					  0x82000000 0 0x10000000 0 0x10000000 0 0x20000000>;
> +				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "msi", "intr";
> +				interrupt-map-mask = <0 0 0 7>;
> +				interrupt-map =
> +					<0 0 0 1 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> +					 0 0 0 2 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> +					 0 0 0 3 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> +					 0 0 0 4 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> +				max-link-speed = <2>;
> +				clocks = <&extclk100mhz>, <&pismu TMPV770X_CLK_PCIE_MSTR>, <&pismu TMPV770X_CLK_PCIE_AUX>;
> +				clock-names = "ref", "core", "aux";
> +				status = "disabled";
> +			};
>  		};
>  	};
>  };
> -- 
> 2.51.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

