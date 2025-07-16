Return-Path: <linux-pci+bounces-32248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4635EB07079
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 10:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C3D1889530
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 08:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759BB2EAD07;
	Wed, 16 Jul 2025 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be89xxRr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440182EACE9;
	Wed, 16 Jul 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654439; cv=none; b=CNhXlgErlM4YsP9/4PmkELu1Lv6SFL7laOdt2L9/vtCpwLx+YkEnGm9iA42DhCKWosDpDtTDaMpHybPqDW8Pfu4LR/um84UN4KM+MhYKGoSXGwgDN0mK5tJ+rQfZqeEAcOASMRf+8D/FbWM/cmfel88+CZ5nX4WNIHDCsdwowdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654439; c=relaxed/simple;
	bh=jA5FOSjFCNJGkBGVQ3T0NygKzKDwksb4u4k+DuY6Ba4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxbMhNK6THbjHz+2JJTztjNFyZd1loQVIGWKoWc2YfxnoRqDQcV1mn4RvchTp7R5FsXsBDz5FDaE6DZK99NOG+OC/0ZB0LW2oltN73PO7GpsZgnMoQhzc3olRwQyYjB1tZZkI1HuCoEWdeV2HL5qyWt/NR8KGzo9c6THWaUTlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be89xxRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F140C4CEF0;
	Wed, 16 Jul 2025 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752654438;
	bh=jA5FOSjFCNJGkBGVQ3T0NygKzKDwksb4u4k+DuY6Ba4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=be89xxRrv9xuxcIrfDxAYLIU64qDm+AhV8+M6ZIRIHCV6NppRf5AJ8o0NCluJ2xnX
	 hSiKyhZD+ICPEpqMknx+RBzxKFD5dm6ESQ2smgvsBvzpQDiBzd+uOsuEKINp2NBc+4
	 Ow9bH4ecBU8nxkuGEmi5Vm76U/1jskLNLgCK+j8iE9IcqlssP94zZCzNxubpn1bglP
	 8QBH0Vaaf13M+t1q580dgn/uJViuDVecG6wZ2QfQpJP4eRa95IUBj1iMy0rXCPp1+u
	 x/q8hOrqYIxVowZRisT94c+q6Wr+Jlzz9bc39vjnwJ2fUOJL4NLrvO8Vty7rZ0Kjdd
	 gEwd8c0O2CWpw==
Date: Wed, 16 Jul 2025 10:27:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 03/10] dt-bindings: PCI: Add ASPEED PCIe RC support
Message-ID: <20250716-watchful-enigmatic-condor-0fc6b3@krzk-bin>
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
 <20250715034320.2553837-4-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715034320.2553837-4-jacky_chou@aspeedtech.com>

On Tue, Jul 15, 2025 at 11:43:13AM +0800, Jacky Chou wrote:
> This binding describes the required and optional properties for

No, describe the hardware, not "this binding".

> configuring the PCIe RC node, including support for syscon phandles,
> MSI, clocks, resets, and interrupt mapping. The schema enforces strict
> property validation and provides a comprehensive example for reference.

Don't say what schema does or does not. It's completely redundant.
Describe the hardware.

Your entire commit is redundantn and not helpful at all.

> 

...

> +
> +  aspeed,ahbc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the ASPEED AHB Controller (AHBC) syscon node.
> +      This reference is used by the PCIe controller to access
> +      system-level configuration registers related to the AHB bus.
> +      To enable AHB access for the PCIe controller.
> +
> +  aspeed,pciecfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the ASPEED PCIe configuration syscon node.
> +      This reference allows the PCIe controller to access
> +      SoC-specific PCIe configuration registers. There are the others
> +      functions such PCIe RC and PCIe EP will use this common register
> +      to configure the SoC interfaces.
> +
> +  aspeed,pciephy:

No, phys are not syscons. I already told you that in v1.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the ASPEED PCIe PHY syscon node.
> +      This property provides access to the PCIe PHY control
> +      registers required for link initialization and management.
> +      The other functions such PCIe RC and PCIe EP will use this
> +      common register to configure the PHY interfaces and get some
> +      information from the PHY.
> +
> +  interrupt-controller:
> +    description: Interrupt controller node for handling legacy PCI interrupts.
> +    type: object
> +    properties:
> +      '#address-cells':
> +        const: 0
> +      '#interrupt-cells':
> +        const: 1
> +      interrupt-controller: true
> +
> +    required:
> +      - '#address-cells'
> +      - '#interrupt-cells'
> +      - interrupt-controller
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus-common.yaml#

No other binding references this. Don't write completely different code
than all other SoCs. This entire binding is written such way.

> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-pcie
> +    then:
> +      required:
> +        - aspeed,ahbc
> +    else:
> +      properties:
> +        aspeed,ahbc: false
> +
> +required:
> +  - reg
> +  - interrupts
> +  - bus-range
> +  - ranges
> +  - resets
> +  - reset-names
> +  - msi-parent
> +  - msi-controller
> +  - aspeed,pciecfg
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +patternProperties:
> +  "^pcie@[0-9a-f,]+$":

Why do you need it? Also, order things according to example schema.

Best regards,
Krzysztof


