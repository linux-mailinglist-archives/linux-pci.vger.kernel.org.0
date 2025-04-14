Return-Path: <linux-pci+bounces-25794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9535A87850
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 09:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC681892343
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 07:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306491A0711;
	Mon, 14 Apr 2025 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZRTDiRD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0470829D05;
	Mon, 14 Apr 2025 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744614134; cv=none; b=d5IxT0R94KRdAWxWe4OfckkrLpg3n/VYMVXQbPaFAQ9joA/dEfhs+4c8d18KqcPZBwJ+XzS1o9P4fWRG6FtNAgJ7EnEsXY8xqRHrqPo7modZGWvJeAfnP9mS7UEdkRir5skgjxXxNT+pcVw1UHw4laBAG9VbcMeiFiJyZzJtIBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744614134; c=relaxed/simple;
	bh=Y+PzRa5KHzS3rRu7HfCG+Yc3+iPhWFVgRe6fdYaJvW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmd9xuxYh5E21aDIWjQUTm4RcFofDH3XJdA+cLEGk+p2+T3WgtVLk5wub1lWRba6G6gjrPZtGu8GT7y8onds0YYXzQfzbuK4rPMlUFzyyh5aUrZe0u5GntRRGjVbUAj4T2DOAFN6FUV7Lbgb33V6lKUKwONawAL4HYyDbXQj9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZRTDiRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CBCC4CEE2;
	Mon, 14 Apr 2025 07:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744614133;
	bh=Y+PzRa5KHzS3rRu7HfCG+Yc3+iPhWFVgRe6fdYaJvW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZRTDiRDjhtRQIF5HRwOfptBoU1y+N8XY3hnlYCziTttxb4MMPTeEb89lyTvYUPCf
	 THqpn3XG5Q7FTGm5sC99GYH/l3QBEYx3N/X7nDFXBRZSOq+9/hCrHP2bM4naaP8yXx
	 lduBwjj9k/AWIkOQL3AmIKLC+myqfGCzQIv4ZYlwRbGYcJ3mDx6nvbqN1uQbEUOkaA
	 qbd2mm+ElcpVXgXKT2mp84FkxjoF2DOZ44aNu2S2/M4ELraT1jhGb03n7AcsYWtnO4
	 q2ogvg8o8JBeSZi04Bz7x400SabDmmdgiKcAQNDejww9mCIoWMX12EBrZ04epg/mBa
	 4+jHblJNk0aHw==
Date: Mon, 14 Apr 2025 09:02:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	cassel@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michal.simek@amd.com, bharat.kumar.gogada@amd.com, 
	thippeswamy.havalige@amd.com
Subject: Re: [RESEND PATCH v7 1/2] dt-bindings: PCI: xilinx-cpm: Add
 `cpm_crx` and `cpm5nc_fw_attr` properties
Message-ID: <20250414-naughty-simple-rattlesnake-bb75bb@shite>
References: <20250414032304.862779-1-sai.krishna.musham@amd.com>
 <20250414032304.862779-2-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414032304.862779-2-sai.krishna.musham@amd.com>

On Mon, Apr 14, 2025 at 08:53:03AM GMT, Sai Krishna Musham wrote:
> Add the `cpm_crx` property to manage the PCIe IP reset, and
> `cpm5nc_fw_attr` property to clear firewall after link reset, while
> maintaining backward compatibility with existing device trees.
> 
> Also, incorporate `reset-gpios` in example for GPIO-based handling of
> the PCIe Root Port (RP) PERST# signal for enabling assert and deassert
> control.
> 
> The `reset-gpios` and `cpm_crx` properties must be provided for CPM,
> CPM5 and CPM5_HOST1. For CPM5NC, all three properties - `reset-gpios`,
> `cpm_crx` and `cpm5nc_fw_attr` must be explicitly defined to ensure

This we see from the diff, but why they must be defined?

> proper functionality.

What functionality?

> 
> Include an example DTS node and complete the binding documentation for
> CPM5NC. Also, fix the bridge register address size in the example for
> CPM5.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes for v7:
> - Update CPM5NC device tree binding.
> - Add CPM5NC device tree example node.
> - Update commit message.
> 
> Changes for v6:
> - Resolve ABI break.
> - Update commit message.
> 

...

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - xlnx,versal-cpm5nc-host
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: CPM system level control and status registers.
> +            - description: Configuration space region and bridge registers.
> +            - description: CPM clock and reset control registers.
> +            - description: CPM5NC Firewall attribute register.
> +          minItems: 2
> +        reg-names:
> +          items:
> +            - const: cpm_slcr
> +            - const: cfg
> +            - const: cpm_crx
> +            - const: cpm5nc_fw_attr
> +          minItems: 2

Why interrupts are not required for this variant? Why isn't this an
interrupt controller?

>  
>  unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
>  
>      versal {
>                 #address-cells = <2>;
> @@ -98,8 +165,10 @@ examples:
>                                  <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
>                         msi-map = <0x0 &its_gic 0x0 0x10000>;
>                         reg = <0x0 0xfca10000 0x0 0x1000>,
> -                             <0x6 0x00000000 0x0 0x10000000>;
> -                       reg-names = "cpm_slcr", "cfg";
> +                             <0x6 0x00000000 0x0 0x10000000>,
> +                             <0x0 0xfca00000 0x0 10000>;
> +                       reg-names = "cpm_slcr", "cfg", "cpm_crx";
> +                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
>                         pcie_intc_0: interrupt-controller {
>                                 #address-cells = <0>;
>                                 #interrupt-cells = <1>;
> @@ -126,8 +195,10 @@ examples:
>                         msi-map = <0x0 &its_gic 0x0 0x10000>;
>                         reg = <0x00 0xfcdd0000 0x00 0x1000>,
>                               <0x06 0x00000000 0x00 0x1000000>,
> -                             <0x00 0xfce20000 0x00 0x1000000>;
> -                       reg-names = "cpm_slcr", "cfg", "cpm_csr";
> +                             <0x00 0xfce20000 0x00 0x10000>,
> +                             <0x00 0xfcdc0000 0x00 0x10000>;
> +                       reg-names = "cpm_slcr", "cfg", "cpm_csr", "cpm_crx";
> +                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
>  
>                         pcie_intc_1: interrupt-controller {
>                                 #address-cells = <0>;
> @@ -136,4 +207,22 @@ examples:
>                         };
>                 };
>  
> +               cpm5nc_pcie: pcie@e4a10000 {
> +                       compatible = "xlnx,versal-cpm5nc-host";
> +                       device_type = "pci";
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       interrupt-parent = <&gic>;
> +                       bus-range = <0x00 0xff>;
> +                       ranges = <0x2000000 0x00 0xa8000000 0x00 0xa8000000 0x00 0x8000000>,
> +                                <0x43000000 0x1010 0x00 0x1010 0x00 0x08 0x00>;
> +                       msi-map = <0x0 &its_gic 0x40000 0x10000>;
> +                       reg = <0x00 0xe4a10000 0x00 0x10000>,
> +                             <0x00 0xa0000000 0x00 0x8000000>,
> +                             <0x00 0xe4a00000 0x00 0x10000>,
> +                             <0x00 0xe4301000 0x00 0x10000>;

Follow DTS coding style. Or just drop this example... it also has
incorrect indentation. :/

> +                       reg-names = "cpm_slcr", "cfg", "cpm_crx", "cpm5nc_fw_attr";
> +                       reset-gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
> +               };
> +
>      };
> -- 
> 2.44.1
> 

