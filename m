Return-Path: <linux-pci+bounces-22762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3AAA4C346
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 15:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240201886432
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 14:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775D221171F;
	Mon,  3 Mar 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaMyLW42"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ECA12FF69;
	Mon,  3 Mar 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011728; cv=none; b=inyR7XDnr5VZYhQnQL0sObuFIq59lCB8x69JAioByaRMJURsN1DUgIDcCRCGQXBnXWQkF8nj3XI6wrTjQHdcbPKFcsoIgWi/wpzi3LXWnDnW2+MSQnsYrHUJoCf8ZSYfRE905fvcV1o+9J6BiNPfiVZgQjoN8+l6WTdz8VsS78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011728; c=relaxed/simple;
	bh=XB9K6qeId7bK+escV9osJW7r2f2TzOQgiSy/hD2k3Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XleN+ZiWeOiAhDmhCwdsnf9X8vPC2CC3faQF007bBFVrQvQmuTrcevcILg1RINxs3276E8GfrhRfY/vUUH/Tl3V2P2t9AL2sh82yHs2cs1XFt4wLoZ8OZFTfyT5ShmMhqR26zLUdFa00kmtcVVKHS+rCmNoORn3Mm586NEM/848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaMyLW42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFDDC4CED6;
	Mon,  3 Mar 2025 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741011727;
	bh=XB9K6qeId7bK+escV9osJW7r2f2TzOQgiSy/hD2k3Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PaMyLW42vY10uucrvQbMUMgTHjZ4C+KEy0vQnosVSEb3Cy/lAk7QJ+BDTT8v9MggD
	 2y89ZQSZ+Of+HHJs3SpwZT8y7o8+tEc1tgMxy3Nlc+p9gI4bXTXQMS/xK3J375a/hL
	 PiHYYPGUT/kHbY2H4kCTK83N/eKj76iE9qz/4EYesvPafDG3/rPKe7zXMilG4X1NBo
	 vr90aqDdO3KkJC+TKhpYjUM6O+rls5IAlnBuioDN8RmPjRoyRCN2+sJGQ46f2IliJs
	 Fl0OqqhFWNWOtsCVfSdrUAGuNmgvD7IT/rVJh6kDryr6nZuu7Vecawq7WZAjCAlT3v
	 oVE5468ECkXbw==
Date: Mon, 3 Mar 2025 08:22:06 -0600
From: Rob Herring <robh@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for
 PCIe RP PERST#
Message-ID: <20250303142206.GA1760319-robh@kernel.org>
References: <20250227042454.907182-1-sai.krishna.musham@amd.com>
 <20250227042454.907182-2-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227042454.907182-2-sai.krishna.musham@amd.com>

On Thu, Feb 27, 2025 at 09:54:53AM +0530, Sai Krishna Musham wrote:
> Introduce `reset-gpios` property to enable GPIO-based control of
> the PCIe RP PERST# signal, generating assert and deassert signals.
> 
> Traditionally, the reset was managed in hardware and enabled during
> initialization. With this patch set, the reset will be handled by the
> driver. Consequently, the `reset-gpios` property must be explicitly
> provided to ensure proper functionality.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> This patch depends on the following patch series.
> https://lore.kernel.org/all/20250217072713.635643-2-thippeswamy.havalige@amd.com/
> 
> Changes for v3:
> - None
> 
> Changes for v2:
> - Add define from include/dt-bindings/gpio/gpio.h for PERST# polarity
> - Update commit message
> ---
>  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index b63a759ec2d7..6aaeb76f498b 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -33,6 +33,9 @@ properties:
>        - const: cpm_csr
>      minItems: 2
>  
> +  reset-gpios:
> +    description: GPIO used as PERST# signal. Please refer to pci.txt.

Drop 'Please refer to pci.txt'. pci.txt or portions of it need to be 
removed as schemas have replaced them.

> +
>    interrupts:
>      maxItems: 1
>  
> @@ -63,6 +66,7 @@ properties:
>  required:
>    - reg
>    - reg-names
> +  - reset-gpios
>    - "#interrupt-cells"
>    - interrupts
>    - interrupt-map
> @@ -75,6 +79,7 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
>  
>      versal {
>                 #address-cells = <2>;
> @@ -99,6 +104,7 @@ examples:
>                         reg = <0x0 0xfca10000 0x0 0x1000>,
>                               <0x6 0x00000000 0x0 0x10000000>;
>                         reg-names = "cpm_slcr", "cfg";
> +                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
>                         pcie_intc_0: interrupt-controller {
>                                 #address-cells = <0>;
>                                 #interrupt-cells = <1>;
> @@ -127,6 +133,7 @@ examples:
>                               <0x06 0x00000000 0x00 0x1000000>,
>                               <0x00 0xfce20000 0x00 0x1000000>;
>                         reg-names = "cpm_slcr", "cfg", "cpm_csr";
> +                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
>  
>                         pcie_intc_1: interrupt-controller {
>                                 #address-cells = <0>;
> -- 
> 2.44.1
> 

