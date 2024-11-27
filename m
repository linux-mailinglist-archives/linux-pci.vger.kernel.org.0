Return-Path: <linux-pci+bounces-17397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4649DA35F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 08:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADC8FB219E0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 07:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC151547FB;
	Wed, 27 Nov 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bucSP35A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC7018E0E;
	Wed, 27 Nov 2024 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694113; cv=none; b=tnmK7FOdzZ7OTxb3LY2s2xDD8AfyHcjuHn66wRT9wtdoOHjzVAKo510e5/0xLUlfO/rlRPunU566b/FbB5cTPyX85FZmwULWMfHCFH68Ie8IRskjCDR2ZfIQrC6ZydbGcZ+UiG9Bzxvqa7LLCT820YGKu3Uesb+r7HopvUipHec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694113; c=relaxed/simple;
	bh=x0xX5vYSBWllewRjPzdfK0c874WVsNj5qAoWrojVTGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYuDsypKvwkjC7mUNPQMAl1mJG2hhAyzJwFSLWUWxeMe5ApCS8R5LdFSarJrBm/xbouz2kzYHIDlq4Eh3G9LER5/kXGHI/ZKtJIeoQDSX4X99vj5/aEOnNeDRMTN5ruREwA9IpsCjguDZhVDzAnUfZR7tNyaOFrVCO5H2USWzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bucSP35A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6B3C4CECC;
	Wed, 27 Nov 2024 07:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732694112;
	bh=x0xX5vYSBWllewRjPzdfK0c874WVsNj5qAoWrojVTGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bucSP35AKAy65nI+BITULDx0+C9mvIKCfCDFgHIyv84XK+74qXxwFqUbTN41rkK+C
	 Ra6tp1daRWkSizWrHnXH10FW7w58tZ2kX8hBinj8iFiX1chlQzHLXzCN+l4ncSQR03
	 OnPHmh97RjPzSeDuH/4EE01NtM3RfoJgytMQdFBrt2uZX5X3MUhBxpKV/tKlolYwP2
	 AAPuj17Gfvw2HqlZy5FOkO4Dv2lqO62E3NZ22t36PrOPbxmBz/MoM46QZS/72X63i3
	 4rCESMHIqtId3GjebgFlSCLkaOZ8aJEJHy9tLVB3HTM8J+Qb7joF3gswz/if9EU4DG
	 43V0+UResU/dA==
Date: Wed, 27 Nov 2024 08:55:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof Wilczynski <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 02/10] dt-bindings: pinctrl: Add RaspberryPi RP1
 gpio/pinctrl/pinmux bindings
Message-ID: <4ufubysv62v7aq53qfzxmup5agmqypdvemd24vm6eentph46qq@3kveluud3zd3>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <9b83c5ee8345e4fe26e942f343305fdddc01c59f.1732444746.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b83c5ee8345e4fe26e942f343305fdddc01c59f.1732444746.git.andrea.porta@suse.com>

On Sun, Nov 24, 2024 at 11:51:39AM +0100, Andrea della Porta wrote:
> +  '#interrupt-cells':
> +    description:
> +      Specifies the Bank number [0, 1, 2] and Flags as defined in
> +      include/dt-bindings/interrupt-controller/irq.h.
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +patternProperties:
> +  "-state$":
> +    oneOf:
> +      - $ref: "#/$defs/raspberrypi-rp1-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/raspberrypi-rp1-state"
> +        additionalProperties: false
> +
> +$defs:
> +  raspberrypi-rp1-state:
> +    allOf:
> +      - $ref: pincfg-node.yaml#
> +      - $ref: pinmux-node.yaml#
> +
> +    description:
> +      Pin controller client devices use pin configuration subnodes (children
> +      and grandchildren) for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          pattern: "^gpio([0-9]|[1-5][0-9])$"

You have 54 GPIOs, so up to 53.

Use also consistent quotes, either ' or ".

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


