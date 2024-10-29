Return-Path: <linux-pci+bounces-15506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042B49B4305
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 08:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360B31C21B13
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 07:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B602022DE;
	Tue, 29 Oct 2024 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dsu5VFMw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68E1FF7A8;
	Tue, 29 Oct 2024 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730186590; cv=none; b=i6EMI7JkuodxGVFlSnhfZLVqQPA2xu5KBLOSWnnfzR10kq+pUGHgYnGnitV+EFpLNrec/bHz0xGcqgwTjB4qmAkfBD7VuW/gJetZ1BXCmpuj1nu1RDTlN+Z//sPNXgmqV+tGyvNMBGf3Al9UVdyvX0b29yxgqdetUQNBf74k5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730186590; c=relaxed/simple;
	bh=QAzVxk6lkr2Gefgn21V1NPzIlb3phHk+NiaSEFFYv6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKpFSo+XWXPNwl3uh/iW4W4YpjIhWZNPpGiOznpf7N/GleMz5VZMt2RWbj7i3ouDkohb42XmGXKmoXHym8g2rgIcWtmcfdtbSNWUs/Ti91ExclvufQglqL6gzDYkiyYZ/g4Z/bEw/w7wg3U1nI+Y1sRI1WZP+m5YOdemy53xm2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dsu5VFMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CB2C4CECD;
	Tue, 29 Oct 2024 07:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730186589;
	bh=QAzVxk6lkr2Gefgn21V1NPzIlb3phHk+NiaSEFFYv6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dsu5VFMw5/izIn95xYd0VwvPDr1GTjf2Jxb7smE2zw2vCRp5/UersnGNdbNWnA0Ai
	 3QSz4h0Hi0J/YvW7mygRXj9CBmbwKwbmGPa+Rp8aN3zmvR8qJTzhF4XplWvbP17nCX
	 F0qCYQoenQDUMfZUlPLBdTHlXsWSYUnqeYBvo02W2ZnhGYCyP/9eANC6B3wCYEtqE6
	 lSQapXgD6doDrdyIjuKB9rxSx6vvoa9LkPGSjuYEOcOnFIQNGHuB8naXkhZ4F1I1Pt
	 o6eYQdPZor2VmwM2wQhnL0ozS47jz0tB2WGMQrfQ2oidc8BmNChR3Hi9WXyOTQu6+H
	 t1Pz8xVUE6qZQ==
Date: Tue, 29 Oct 2024 08:23:06 +0100
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
Subject: Re: [PATCH v3 01/12] dt-bindings: clock: Add RaspberryPi RP1 clock
 bindings
Message-ID: <cxwzmlzafgdu2uarcx7mdv4p32zig7efatcg4dzmctho6mvykl@dgwvf3ltcjmo>
References: <cover.1730123575.git.andrea.porta@suse.com>
 <914978925d34cfb5bee10fe92603f98763af48b0.1730123575.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <914978925d34cfb5bee10fe92603f98763af48b0.1730123575.git.andrea.porta@suse.com>

On Mon, Oct 28, 2024 at 03:07:18PM +0100, Andrea della Porta wrote:
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
> index 000000000000..a123dd619f8e
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
> +      definitions in include/dt-bindings/clock/raspberrypi,rp1-clocks.h.

You still describe how current driver matches assigned-clocks to your
output clocks. That's not the property of clock-cells and that's not how
assigned-clocks work.

There are no assigned clocks in your DTS, so this is really irrelevant
(or not correct, choose).


> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: xosc

What is the purpose of clock-names if you do not use it? Drop.

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
> +        clocks@c040018000 {
> +            compatible = "raspberrypi,rp1-clocks";
> +            reg = <0xc0 0x40018000 0x0 0x10038>;
> +            #clock-cells = <1>;
> +            clocks = <&clk_rp1_xosc>;
> +            clock-names =  "xosc";

Only one space after '='.

Best regards,
Krzysztof


