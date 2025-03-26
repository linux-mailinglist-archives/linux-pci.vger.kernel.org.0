Return-Path: <linux-pci+bounces-24731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19BFA7119C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC46E174EF6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 07:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C8D199E8D;
	Wed, 26 Mar 2025 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+pTzN5B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABDC823DE;
	Wed, 26 Mar 2025 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975152; cv=none; b=XJFI+EMud274Jzp75PzgHN6zutFnRttCfP+Z/B0qLfsmVR+VOAGm9eh16/sks7dfCFfHG8NCMqYiMcj+wYcaWf+TD7OUVnKsy0Omt+R/ylt/X4diqiN9CwqPJ8DrCDxojjbbkDmBJtYbZvbi38JpuXPd/VO8kepUY4TAx/SiAFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975152; c=relaxed/simple;
	bh=360J2yfqQ597HNTiFqR6IcA+Tuon4KwsfEhtV6HVjhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5H5FktJEM1jTXM63oo+0AeSuHMZOgy/1mjzhlKn3RsmbeLipqOb5N4wW8HtMQeZNzc/1o9y4gwgjrEY4Lm5o+RoPv3QrqrYpBd7uzQnf3P5Lb1GjCQIeG2vM+zbD3mx57g1utuNDtJlucbgCE18NcdIfWDFC+/qMCe3YDRyYvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+pTzN5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5312C4CEE2;
	Wed, 26 Mar 2025 07:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742975152;
	bh=360J2yfqQ597HNTiFqR6IcA+Tuon4KwsfEhtV6HVjhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+pTzN5Brqudst3q9PS/Q55Ngb/P9g/qYew+wxAjpstieNfnpGNXSOGvUcdtzjhGh
	 G76yfOy738qtt4ikqXZBVTA1t2lZAxSN754x2Qx+5J+zmTWjX+8M2IpPZKqnRexmB9
	 G0bx3dmmjfFofY6V+Xp0OZOi35Riwwn4OsEcoBVkGZgN9o0tJp3lNwnzl5jMj/DxCb
	 v4Tb3swOWG+gXGZHDVV5tV6nI289uCnLbb+mYTTQ4c1Pb3mYI8fwcmOKKlKdiBbxR4
	 GAvbDJ69TjE0/ZrmY9c7DxDS4ZmgIWd6xrgMY1/7w/dUuhCTMUtbLcfrR2wkfbnlY7
	 kGb8+awWcGslQ==
Date: Wed, 26 Mar 2025 08:45:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	cassel@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michal.simek@amd.com, bharat.kumar.gogada@amd.com, 
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH v6 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for
 PCIe RP PERST#
Message-ID: <20250326-stereotyped-agama-of-reward-e6baf1@krzk-bin>
References: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
 <20250326022811.3090688-2-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326022811.3090688-2-sai.krishna.musham@amd.com>

On Wed, Mar 26, 2025 at 07:58:10AM +0530, Sai Krishna Musham wrote:
> Introduce `reset-gpios` property to enable GPIO-based control of
> the PCIe RP PERST# signal, generating assert and deassert signals.

I think it was removed, so this is not necessary. The property was there
all the time.

> 
> Traditionally, the reset was managed in hardware and enabled during
> initialization. With this patch set, the reset will be handled by the
> driver. Consequently, the `reset-gpios` property must be explicitly
> provided to ensure proper functionality.
> 
> Add CPM clock and reset control registers base (`cpm_crx`) to handle
> PCIe IP reset along with PCIe RP PERST# to avoid Link Training errors.

So does it mean it was not working before at all?

> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes for v6:
> - Resolve ABI break.
> - Update commit message.
> 
> Changes for v5:
> - Remove `reset-gpios` property from required as it is already present
>   in pci-bus-common.yaml
> - Update commit message
> 
> Changes for v4:
> - Add CPM clock and reset control registers base to handle PCIe IP
>   reset.
> - Update commit message.
> 
> Changes for v3:
> - None
> 
> Changes for v2:
> - Add define from include/dt-bindings/gpio/gpio.h for PERST# polarity
> - Update commit message
> ---
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 72 ++++++++++++++-----
>  1 file changed, 55 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index d674a24c8ccc..26e9cea41889 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -9,9 +9,6 @@ title: CPM Host Controller device tree for Xilinx Versal SoCs
>  maintainers:
>    - Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
>  
> -allOf:
> -  - $ref: /schemas/pci/pci-host-bridge.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -21,18 +18,12 @@ properties:
>        - xlnx,versal-cpm5nc-host
>  
>    reg:
> -    items:
> -      - description: CPM system level control and status registers.
> -      - description: Configuration space region and bridge registers.
> -      - description: CPM5 control and status registers.
> -    minItems: 2
> +    minItems: 3

That's an ABI break.

> +    maxItems: 4
>  
>    reg-names:
> -    items:
> -      - const: cpm_slcr
> -      - const: cfg
> -      - const: cpm_csr
> -    minItems: 2
> +    minItems: 3
> +    maxItems: 4
>  
>    interrupts:
>      maxItems: 1
> @@ -72,10 +63,53 @@ required:
>    - msi-map
>    - interrupt-controller
>  
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - xlnx,versal-cpm-host-1.00
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: CPM system level control and status registers.
> +            - description: Configuration space region and bridge registers.
> +            - description: CPM clock and reset control registers.

Before two items, now min 3, so another ABI break. Missing minItems.

> +        reg-names:
> +          items:
> +            - const: cpm_slcr
> +            - const: cfg
> +            - const: cpm_crx

Same

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - xlnx,versal-cpm5-host
> +              - xlnx,versal-cpm5-host1
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: CPM system level control and status registers.
> +            - description: Configuration space region and bridge registers.
> +            - description: CPM5 control and status registers.
> +            - description: CPM clock and reset control registers.

This makes no sense, you still add the entry in the middle. This patch
fixed nothing from issues previously pointed out.

It's the third or fourth try and you keep repeating the same mistake,
which means you do not understand the problem. The problem is: you
cannot change the order. If you change it, it's an ABI break and nothing
in commit msg explained that.

Best regards,
Krzysztof


