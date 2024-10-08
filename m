Return-Path: <linux-pci+bounces-13988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9F1993F57
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 09:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997D61F2261A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF04155747;
	Tue,  8 Oct 2024 06:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdd3u/Q4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA18674059;
	Tue,  8 Oct 2024 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728369124; cv=none; b=NGG61BqqHKum9J5L9ns7oMXLTa+6FRufQ6By6hyFUF0hQIu5952S70PAdFgkVtkM53z7nljI3nVFLUJ1E5YcONRtQHmlmg7Ey6BNxpO4ltEqHkPuWA9rCvUFOug1ILJ6iZvmYdVHZpG9eSz9UwEYtiCQEsK4YJ2tolbeYSlKDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728369124; c=relaxed/simple;
	bh=wXuEkZB63dwO8XNaP5BUpmaijSR4KYy0bM4/gDsyrzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyXSzPUMpk62jlRZe0lJpt3Zy9Yr9sdMYkhiGauP6ljXuNPZ3r2+x4Nyd5FrS3kldrq9p1FPEPf57G8CuAbCkL+pxS/952qE8wOYUIxhVN6Jgy7OlfG0ubFqRYl+xQ3TRc+m/jsqn8eB0/kISbOz+ZTb2k5DH6pk8qNE+cw1ZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdd3u/Q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BC8C4CEC7;
	Tue,  8 Oct 2024 06:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728369123;
	bh=wXuEkZB63dwO8XNaP5BUpmaijSR4KYy0bM4/gDsyrzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdd3u/Q4Uvnnn4TaK+k8assSxt04sfUYRwaswAwbeGZttzvCF6Qk7dhPiv+zAt79A
	 ig0hmBPtGEwsavdxl48Pw5vChJWcCMymoN0VC3ANpq8w9BOg3fdc76h12ifkEEbK8N
	 LRb8cr33FASXt9z28rVgZsjkvsT7EemkfzI6FezEuzuvroVF6BNNYZ5X1ESV8TqdKZ
	 2mIX2Y+0hXtetEFipbCPHT/17vojO0KV3OJnNldq20jxhtK2nTvnrCX4quxYfH+99S
	 GYuCtDJaXY42T2RbWi3HZCx049aDtTjpJuI8mhwdbmrYq8PV1oJEoAWJnAfNNn7gvE
	 4/3hFrmQNkewA==
Date: Tue, 8 Oct 2024 08:31:59 +0200
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
Subject: Re: [PATCH v2 01/14] dt-bindings: clock: Add RaspberryPi RP1 clock
 bindings
Message-ID: <bznpgisxve5y34lu6hj6mlahd7r5fq2wz565nieiwvihwqbnzx@v6uk4mifhkhp>
References: <cover.1728300189.git.andrea.porta@suse.com>
 <74199551e7a9e43a9aa2e1ed1a678493e7a8fb2c.1728300189.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74199551e7a9e43a9aa2e1ed1a678493e7a8fb2c.1728300189.git.andrea.porta@suse.com>

On Mon, Oct 07, 2024 at 02:39:44PM +0200, Andrea della Porta wrote:
> Add device tree bindings for the clock generator found in RP1 multi
> function device, and relative entries in MAINTAINERS file.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../clock/raspberrypi,rp1-clocks.yaml         | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  .../clock/raspberrypi,rp1-clocks.h            | 61 ++++++++++++++++++
>  3 files changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
>  create mode 100644 include/dt-bindings/clock/raspberrypi,rp1-clocks.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> new file mode 100644
> index 000000000000..5e2e98051bf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/raspberrypi,rp1-clocks.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RaspberryPi RP1 clock generator
> +
> +maintainers:
> +  - Andrea della Porta <andrea.porta@suse.com>
> +
> +description: |
> +  The RP1 contains a clock generator designed as three PLLs (CORE, AUDIO,
> +  VIDEO), and each PLL output can be programmed though dividers to generate
> +  the clocks to drive the sub-peripherals embedded inside the chipset.
> +
> +  Link to datasheet:
> +  https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> +
> +properties:
> +  compatible:
> +    const: raspberrypi,rp1-clocks
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    description:
> +      The index in the assigned-clocks is mapped to the output clock as per

How assigned-clocks is related to this? Drop.

> +      definitions in dt-bindings/clock/raspberrypi,rp1-clocks.h.

Use full paths, so they can be validated. This applies to all your
patches.

> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: rp1-xosc

Drop clock-names, redundant. Or just "xosc". Hyphens are not recommended
character and rp1 is redundant.

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/raspberrypi,rp1-clocks.h>
> +
> +    rp1 {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        rp1_clocks: clocks@c040018000 {

Drop unused label.

> +            compatible = "raspberrypi,rp1-clocks";
> +            reg = <0xc0 0x40018000 0x0 0x10038>;
> +            #clock-cells = <1>;
> +            clocks = <&clk_rp1_xosc>;
> +            clock-names =  "rp1-xosc";
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c27f3190737f..75a66e3e34c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19380,6 +19380,12 @@ F:	Documentation/devicetree/bindings/media/raspberrypi,pispbe.yaml
>  F:	drivers/media/platform/raspberrypi/pisp_be/
>  F:	include/uapi/linux/media/raspberrypi/
>  
> +RASPBERRY PI RP1 PCI DRIVER
> +M:	Andrea della Porta <andrea.porta@suse.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> +F:	include/dt-bindings/clock/rp1.h
> +
>  RC-CORE / LIRC FRAMEWORK
>  M:	Sean Young <sean@mess.org>
>  L:	linux-media@vger.kernel.org
> diff --git a/include/dt-bindings/clock/raspberrypi,rp1-clocks.h b/include/dt-bindings/clock/raspberrypi,rp1-clocks.h
> new file mode 100644
> index 000000000000..b7c1eaa74eae
> --- /dev/null
> +++ b/include/dt-bindings/clock/raspberrypi,rp1-clocks.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */

Any reason for different license?

> +/*
> + * Copyright (C) 2021 Raspberry Pi Ltd.
> + */

Best regards,
Krzysztof


