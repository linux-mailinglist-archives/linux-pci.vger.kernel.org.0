Return-Path: <linux-pci+bounces-13986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5464E993F26
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 09:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B821C22263
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 07:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8B51DE4F5;
	Tue,  8 Oct 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqpvB27S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C911DE4D9;
	Tue,  8 Oct 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368789; cv=none; b=XzlEBC9XbmFSWf9d7Bhr8p77Vsx2dGocFFlB01gm6rM0XErBqWGY1F32ZJVtRKnQA09Dzgi08XT0NGo6DY2h8h76jZSPA7CxFc3rBoWyLgKO0gBscbHXEyOBv8F06Yb4ERio6XoS+jJuasv+dixJev2cqeKC95gnx6m0coLuxRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368789; c=relaxed/simple;
	bh=T45AqMpwASiBl0/I50N2dY606S5QKSd7yQWdyfR9JdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpM/pnJfyP/L0y/IS2rcIqhJJh1TIIxbPaB5T2of59AZL1gIS/lBYfl8lK3wlndg4friLvtvYKJvolRHQxqW/7udgfSx9yTaKyvxIrcxJMO1G0S+UacdoZTcXlypMchw6IWYCQ3InGHRFL/CQVpiOZmp46FdKQEpzFWsLYy6qPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqpvB27S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2527DC4CECC;
	Tue,  8 Oct 2024 06:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728368788;
	bh=T45AqMpwASiBl0/I50N2dY606S5QKSd7yQWdyfR9JdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqpvB27S6vyJAseVV7a2ekE1MW8fK51W7M2o5OXx9n0djgMeF1DhKsAxpMVtcNqWH
	 D3f2AUxaMr9vNiyhZqZF4PSoXJTlFpEZXZS3sS8Z+8/+y9j8gz4E+9J9wwiiplZrrA
	 FxMAvuyThwsIkCfuG7hctoTgaFG95309AoBvQ0IU92ObWRf7SfuB+Z3eJD1TDlLPJA
	 SpUS0ugQPwjSEIj81uKzhXJj2k17WCSGacw62j9KGwcQiDny0djKWIfj8PxttApF0h
	 VHDsCEZzW/z/nd1YRVsWRoiLhllvp/xdDxSGhB0NcgdKavv7LC5i8RYvc7Wklw8JtZ
	 cfPjwDO1ZGgig==
Date: Tue, 8 Oct 2024 08:26:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
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
Subject: Re: [PATCH v2 04/14] dt-bindings: misc: Add device specific bindings
 for RaspberryPi RP1
Message-ID: <zequ4ps7h6ynr2y5yrcqm3tpvvmmrgc6auupfy435rpysiyypf@7cd2zbwhk3ya>
References: <cover.1728300189.git.andrea.porta@suse.com>
 <3141e3e7898c1538ea658487923d3446b3d7fd0c.1728300189.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3141e3e7898c1538ea658487923d3446b3d7fd0c.1728300189.git.andrea.porta@suse.com>

On Mon, Oct 07, 2024 at 02:39:47PM +0200, Andrea della Porta wrote:
> The RP1 is a MFD that exposes its peripherals through PCI BARs. This
> schema is intended as minimal support for the clock generator and
> gpio controller peripherals which are accessible through BAR1.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../devicetree/bindings/misc/pci1de4,1.yaml   | 110 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/pci1de4,1.yaml b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> new file mode 100644
> index 000000000000..3f099b16e672
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/pci1de4,1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RaspberryPi RP1 MFD PCI device
> +
> +maintainers:
> +  - Andrea della Porta <andrea.porta@suse.com>
> +
> +description:
> +  The RaspberryPi RP1 is a PCI multi function device containing
> +  peripherals ranging from Ethernet to USB controller, I2C, SPI
> +  and others.
> +  The peripherals are accessed by addressing the PCI BAR1 region.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-ep-bus.yaml
> +
> +properties:
> +  compatible:
> +    additionalItems: true

Why is this true? This is final schema, not a "common" part.

> +    maxItems: 3
> +    items:
> +      - const: pci1de4,1
> +
> +patternProperties:
> +  "^pci-ep-bus@[0-2]$":
> +    $ref: '#/$defs/bar-bus'
> +    description:
> +      The bus on which the peripherals are attached, which is addressable
> +      through the BAR.
> +
> +unevaluatedProperties: false
> +
> +$defs:
> +  bar-bus:
> +    $ref: /schemas/pci/pci-ep-bus.yaml#/$defs/pci-ep-bus
> +    unevaluatedProperties: false
> +
> +    properties:
> +      "#interrupt-cells":
> +        const: 2
> +        description:
> +          Specifies respectively the interrupt number and flags as defined
> +          in include/dt-bindings/interrupt-controller/irq.h.
> +
> +      interrupt-controller: true
> +
> +      interrupt-parent:
> +        description:
> +          Must be the phandle of this 'pci-ep-bus' node. It will trigger
> +          PCI interrupts on behalf of peripheral generated interrupts.
> +
> +    patternProperties:
> +      "^clocks(@[0-9a-f]+)?$":

Why @ is optional? Your device is fixed, not flexible.

Best regards,
Krzysztof


