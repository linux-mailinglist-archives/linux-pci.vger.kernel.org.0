Return-Path: <linux-pci+bounces-13987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D2993F52
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 09:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EEF0B20D51
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEAF1DFD82;
	Tue,  8 Oct 2024 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlO8WeqG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49813D52B;
	Tue,  8 Oct 2024 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368994; cv=none; b=YI5ooiijF5B3jLNarYwaewErkrusq090syWBJK98spiUSsV2JnVOFTROu/MJ1rDa93GEhOKY1Zbq4mKQLMwn5imfNedJiSYXYlrpjpRmVbTq3qr6149NBjfUCVz/sUqTjnvPYBFc6KA4aqoyNpKhwUiyxMnRhs+b3nk2FJB5vCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368994; c=relaxed/simple;
	bh=lLRq9apn5NED+qAIBew+fsy0dmv5IoCjdUu8Kffvc+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5LKXapLFV73aIHQXuL9LH3FDAy+kjQkLxnzYxOuhZWGVRRiW67faZmesCBb9VrbYRPx+biqt1a1fSNh0OAg9ybOSGZ7JlSSqnt8fdoXMqy4iSgjtJwrml2Tc7zLg4FF7hNANQ2mfcECk7awJzI3LVK552tz775IgSeWswv+gPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlO8WeqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D667C4CEC7;
	Tue,  8 Oct 2024 06:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728368994;
	bh=lLRq9apn5NED+qAIBew+fsy0dmv5IoCjdUu8Kffvc+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlO8WeqGY8C9lyhIjrN6exrYc8/oYCgmT2ul1B17ltTjI/nskT2PcRaZ7dG0cU9vc
	 4t9UqdUUov8PlWQWSQ6NvKVuOwFEHZsnGij8kdKLFwIDFb1hwUIUNDuYmZO4ChkQ3T
	 nPZnjUep9oT0odlqu7JCdW0soVUDJaxituNDYSIqtpAFAVFknur5o36oYFcExWuLkr
	 kbHR6dI1fBeKsrdAchAqbey1R+U9fanegMPKnlx6B6wpc7E7DY25Qtz0RRfXvP6ibb
	 WgOmMKHsXtMGna7H3NK9XHpR7N1AebLsC3CvH1lk+4N1eAE2EfujBfMPFMizHo5Xib
	 O9Aq2Mu+lt3mw==
Date: Tue, 8 Oct 2024 08:29:50 +0200
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
Subject: Re: [PATCH v2 02/14] dt-bindings: pinctrl: Add RaspberryPi RP1
 gpio/pinctrl/pinmux bindings
Message-ID: <csj452uzkug7nz6yygers6curpo2toj3pwmsa5ka2222hlfspf@jqumtwecvrdq>
References: <cover.1728300189.git.andrea.porta@suse.com>
 <0589448fa41bf7f3e951a75b70226a9873db554f.1728300189.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0589448fa41bf7f3e951a75b70226a9873db554f.1728300189.git.andrea.porta@suse.com>

On Mon, Oct 07, 2024 at 02:39:45PM +0200, Andrea della Porta wrote:
> Add device tree bindings for the gpio/pin/mux controller that is part of
> the RP1 multi function device, and relative entries in MAINTAINERS file.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../pinctrl/raspberrypi,rp1-gpio.yaml         | 169 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +
>  2 files changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> new file mode 100644
> index 000000000000..46e071ec6251
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> @@ -0,0 +1,169 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/raspberrypi,rp1-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RaspberryPi RP1 GPIO/Pinconf/Pinmux Controller submodule
> +
> +maintainers:
> +  - Andrea della Porta <andrea.porta@suse.com>
> +
> +description:
> +  The RP1 chipset is a Multi Function Device containing, among other sub-peripherals,
> +  a gpio/pinconf/mux controller whose 54 pins are grouped into 3 banks. It works also
> +  as an interrupt controller for those gpios.
> +
> +  Each pin configuration node lists the pin(s) to which it applies, and one or
> +  more of the mux function to select on those pin(s), and their configuration.
> +  The pin configuration and multiplexing supports the generic bindings.
> +  For details on each properties (including the meaning of "pin configuration node"),
> +  you can refer to ./pinctrl-bindings.txt.

Drop the sentence. pinctrl.yaml defines this already.

> +
> +properties:
> +  compatible:
> +    const: raspberrypi,rp1-gpio
> +
> +  reg:
> +    maxItems: 3
> +    description: One reg specifier for each one of the 3 pin banks.
> +
> +  '#gpio-cells':
> +    description: The first cell is the pin number and the second cell is used
> +      to specify the flags (see include/dt-bindings/gpio/gpio.h).
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  gpio-ranges:
> +    maxItems: 1
> +
> +  gpio-line-names:
> +    maxItems: 54
> +
> +  interrupts:
> +    maxItems: 3
> +    description: One interrupt specifier for each one of the 3 pin banks.
> +
> +  '#interrupt-cells':
> +    description:
> +      Specifies the Bank number [0, 1, 2] and Flags as defined in
> +      include/dt-bindings/interrupt-controller/irq.h.
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +additionalProperties:
> +  anyOf:

Uh, no, I think you got comments on this. You should be specific which
nodes you expect, e.g. pins or groups. See other recent bindings for
example.

> +    - type: object
> +      additionalProperties: false
> +      allOf:
> +        - $ref: pincfg-node.yaml#
> +        - $ref: pinmux-node.yaml#
> +
> +      description:
> +        Pin controller client devices use pin configuration subnodes (children
> +        and grandchildren) for desired pin configuration.
> +        Client device subnodes use below standard properties.
> +
> +      properties:
> +        pins:
> +          description:
> +            A string (or list of strings) adhering to the pattern "gpio[0-5][0-9]"
> +        function: true
> +        bias-disable: true
> +        bias-pull-down: true
> +        bias-pull-up: true
> +        slew-rate:
> +          description: 0 is slow slew rate, 1 is fast slew rate
> +          enum: [ 0, 1 ]
> +        drive-strength:
> +          enum: [ 2, 4, 8, 12 ]
> +
> +    - type: object
> +      additionalProperties:
> +        $ref: "#/additionalProperties/anyOf/0"

I don't quite get what you wanted to achieve here.

> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +required:
> +  - reg
> +  - compatible
> +  - "#gpio-cells"
> +  - gpio-controller
> +  - interrupts
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    rp1 {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        rp1_gpio: pinctrl@c0400d0000 {
> +            reg = <0xc0 0x400d0000  0x0 0xc000>,
> +                  <0xc0 0x400e0000  0x0 0xc000>,
> +                  <0xc0 0x400f0000  0x0 0xc000>;
> +            compatible = "raspberrypi,rp1-gpio";
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
> +                         <1 IRQ_TYPE_LEVEL_HIGH>,
> +                         <2 IRQ_TYPE_LEVEL_HIGH>;
> +            gpio-line-names =
> +                   "ID_SDA", // GPIO0
> +                   "ID_SCL", // GPIO1
> +                   "GPIO2", "GPIO3", "GPIO4", "GPIO5", "GPIO6",
> +                   "GPIO7", "GPIO8", "GPIO9", "GPIO10", "GPIO11",
> +                   "GPIO12", "GPIO13", "GPIO14", "GPIO15", "GPIO16",
> +                   "GPIO17", "GPIO18", "GPIO19", "GPIO20", "GPIO21",
> +                   "GPIO22", "GPIO23", "GPIO24", "GPIO25", "GPIO26",
> +                   "GPIO27",
> +                   "PCIE_RP1_WAKE", // GPIO28
> +                   "FAN_TACH", // GPIO29
> +                   "HOST_SDA", // GPIO30
> +                   "HOST_SCL", // GPIO31
> +                   "ETH_RST_N", // GPIO32
> +                   "", // GPIO33
> +                   "CD0_IO0_MICCLK", // GPIO34
> +                   "CD0_IO0_MICDAT0", // GPIO35
> +                   "RP1_PCIE_CLKREQ_N", // GPIO36
> +                   "", // GPIO37
> +                   "CD0_SDA", // GPIO38
> +                   "CD0_SCL", // GPIO39
> +                   "CD1_SDA", // GPIO40
> +                   "CD1_SCL", // GPIO41
> +                   "USB_VBUS_EN", // GPIO42
> +                   "USB_OC_N", // GPIO43
> +                   "RP1_STAT_LED", // GPIO44
> +                   "FAN_PWM", // GPIO45
> +                   "CD1_IO0_MICCLK", // GPIO46
> +                   "2712_WAKE", // GPIO47
> +                   "CD1_IO1_MICDAT1", // GPIO48
> +                   "EN_MAX_USB_CUR", // GPIO49
> +                   "", // GPIO50
> +                   "", // GPIO51
> +                   "", // GPIO52
> +                   ""; // GPIO53
> +
> +            rp1_uart0_14_15: rp1_uart0_14_15 {

Underscores are not allowed in node names. Please read DTS coding style.

Drop unused labels.

> +                pin_txd {
> +                    function = "uart0";
> +                    pins = "gpio14";
> +                    bias-disable;
> +                };

Best regards,
Krzysztof


