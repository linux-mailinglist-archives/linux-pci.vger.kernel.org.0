Return-Path: <linux-pci+bounces-20522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C4A21A48
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 10:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3401888976
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 09:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487161AB52F;
	Wed, 29 Jan 2025 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K99pt4KH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC15194C78;
	Wed, 29 Jan 2025 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738144076; cv=none; b=uTEokbIZ4st4Ku87EDVpG9f3FZc7Ys46Xmhq14zOYhSTxHlvosaPSRvaQOYxo1mAL37ohM4HUO6Yntz50ghHSD515i/tn/nVT+zrEOvzwzoDkKwduI6EJrPqTYN0NwD/b2aTklNCsL3d52AyzNPP1YhX5dkja903o2Cdm2zZRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738144076; c=relaxed/simple;
	bh=gtZgByV3yfC1Ara8kuE21FImn1XoVMsWDvQ8Ijdajk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cq1pqOq2B7im1MHxfZv/o9WlMg6kegmBK+OYtTmWWrcpqhQbj5CSxSz9C8DEJVbpNMZUUhimMnMEGy7V+9dQiAN1nncWPqG0rmsIu2V5I1+BmlUNzsix7XKBe4MbsSKDqb5XHixzqy6dWfVYbIw39PgyWuKC7RbY0T2J/CRPI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K99pt4KH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DFFC4CED3;
	Wed, 29 Jan 2025 09:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738144075;
	bh=gtZgByV3yfC1Ara8kuE21FImn1XoVMsWDvQ8Ijdajk8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K99pt4KHCUegmavMIy4OQXMqzj53B8KSW6lMyB8e0A7r3TtyaDJFoU+Dc8DvS3HRq
	 yexoKG7aiBILOIfT/MqVnnhZnYTdQqxRn90mP/RKFZTig/dPCd/cEua4BYOFmCE274
	 tt/iFP/6I9BDJ5tw+W1HWOp5f/2BMVqREEHwX8KB4AkvIkrWlj8fya0Wh73ZjRyirp
	 mlhEvlqTe+9lRfKRoQFn/cMkd8VT4PC6q9ilslY5rOWaaBKX+qCuZ+/LwIXVLe/IOA
	 WbwU0W+INPNMeclp7pxCDNYBQdrGe96nN/nZYwC/t6JlSMHmS7W7WZ3DpsfvHhDkb8
	 jTe6YhVQNlZsA==
Message-ID: <ea614dc5-ad24-4795-b9ba-fa682eda428f@kernel.org>
Date: Wed, 29 Jan 2025 10:47:49 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>, lpieralisi@kernel.org,
 kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 dinguyen@kernel.org, joyce.ooi@intel.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: matthew.gerlach@altera.com, peter.colberg@altera.com
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com>
 <20250127173550.1222427-4-matthew.gerlach@linux.intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250127173550.1222427-4-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/01/2025 18:35, Matthew Gerlach wrote:
> Add the base device tree for support of the PCIe Root Port
> for the Agilex family of chips.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v3:
>  - Remove accepted patches from patch set.
> 
> v2:
>  - Rename node to fix schema check error.
> ---
>  .../intel/socfpga_agilex_pcie_root_port.dtsi  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> new file mode 100644
> index 000000000000..50f131f5791b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier:     GPL-2.0

Odd spaces in SPDX tag.

> +/*
> + * Copyright (C) 2024, Intel Corporation
> + */
> +&soc0 {
> +	aglx_hps_bridges: fpga-bus@80000000 {
> +		compatible = "simple-bus";
> +		reg = <0x80000000 0x20200000>,
> +		      <0xf9000000 0x00100000>;
> +		reg-names = "axi_h2f", "axi_h2f_lw";

Where is this binding defined?

> +		#address-cells = <0x2>;
> +		#size-cells = <0x1>;

These two are not hex.

> +		ranges = <0x00000000 0x00000000 0x80000000 0x00040000>,
> +			 <0x00000000 0x10000000 0x90100000 0x0ff00000>,
> +			 <0x00000000 0x20000000 0xa0000000 0x00200000>,
> +			 <0x00000001 0x00010000 0xf9010000 0x00008000>,
> +			 <0x00000001 0x00018000 0xf9018000 0x00000080>,
> +			 <0x00000001 0x00018080 0xf9018080 0x00000010>;
> +
> +		pcie_0_pcie_aglx: pcie@200000000 {
> +			reg = <0x00000000 0x10000000 0x10000000>,
> +			      <0x00000001 0x00010000 0x00008000>,
> +			      <0x00000000 0x20000000 0x00200000>;
> +			reg-names = "Txs", "Cra", "Hip";

Where is this binding defined?


> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_SPI 0x14 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <0x1>;
> +			device_type = "pci";
> +			bus-range = <0x0000000 0x000000ff>;
> +			ranges = <0x82000000 0x00000000 0x00100000 0x00000000 0x10000000 0x00000000 0x0ff00000>;
> +			msi-parent = <&pcie_0_msi_irq>;
> +			#address-cells = <0x3>;
> +			#size-cells = <0x2>;

Same problem for all cells.

> +			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_0_pcie_aglx 0 0 0 0x1>,
> +					<0x0 0x0 0x0 0x2 &pcie_0_pcie_aglx 0 0 0 0x2>,
> +					<0x0 0x0 0x0 0x3 &pcie_0_pcie_aglx 0 0 0 0x3>,
> +					<0x0 0x0 0x0 0x4 &pcie_0_pcie_aglx 0 0 0 0x4>;
> +			status = "disabled";
> +		};
> +
> +		pcie_0_msi_irq: msi@10008080 {
> +			compatible = "altr,msi-1.0";
> +			reg = <0x00000001 0x00018080 0x00000010>,
> +			      <0x00000001 0x00018000 0x00000080>;
> +			reg-names = "csr", "vector_slave";
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_SPI 0x13 IRQ_TYPE_LEVEL_HIGH>;
> +			msi-controller;
> +			num-vectors = <0x20>;

That's decimal. Value is for humans and we count numbers in decimal.



Best regards,
Krzysztof

