Return-Path: <linux-pci+bounces-17286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77819D8C0A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 19:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FFA168DB7
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49081B87D1;
	Mon, 25 Nov 2024 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Eh7sB2GV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BC238DE1;
	Mon, 25 Nov 2024 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558407; cv=none; b=lY3QCKTNXPDKQqg/GxXeuYeYUyZUdgR6tyPbr+VllzrlEVQ1kbTVndds1lAUsqchZtH/OCEAl/m74CRskf9is4Z8eA5yag4XgXgMBXmckfwl1jwrVlEbDOl2DwXw1ALifZDCerTgFftAJ/TJ34cykM9eGZ4m0YUtEpjOeuitA3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558407; c=relaxed/simple;
	bh=5J1cKvZbQzubIW7D0sc6crhyx9apabLKhR5beTtPYWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VrYbLhb0wfuPZ42BwPDHLZ8kgCGGCHZ6tlvVTCMWmSn5L+OCflzedCFKl44OS6obqQJapwxE/eXkittKTdKRHUZUFKnkkAwMM36q+hGaXjuY0uHL64wwjGUHQaEBm5DvjYuzRi2hc1XqQWWYGT1+VA2PAHykgNmDvcZS3j3wjls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Eh7sB2GV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1732558369; x=1733163169; i=wahrenst@gmx.net;
	bh=Jet1Wflq9Iv5ctweQk8pCStM7oRZw+jWxC+IFe3J/TI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Eh7sB2GVUzx+Fp/nuNzcETxLmaxftOVvTq3OD2M96EE/a5pYFk1m8Asx3mwmmjem
	 KWf0nwLwmUH6yVQ9lroJO7yoK/2twFwvWSYWSC15y9vwwHsJOdIjCxev0P7+IN2o/
	 oiY8CVaTahCG0mezp6sXz5sQYrOl1gE2MUAABcngYPAf8osXgXDkxg1Gmlgfc0DVp
	 rXuPxOpLrF1f2fq+fGhrWVXKw0GbML87+H7g/khoW+vHvI+5Hd+Uv/UT2znrjrsJ4
	 rPFRhvA+bKGhfO7XjK37ayn90CF5KccQIZAzwLZiuquptEA6G8abgexwx7GNSnwOM
	 nknQwZ7m8tXFF0A9Gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHnm-1tZuJv2YYM-0112NR; Mon, 25
 Nov 2024 19:12:49 +0100
Message-ID: <e0595933-d503-492d-ae29-aa3afe90b279@gmx.net>
Date: Mon, 25 Nov 2024 19:12:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] dt-bindings: pinctrl: Add RaspberryPi RP1
 gpio/pinctrl/pinmux bindings
To: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij
 <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <9b83c5ee8345e4fe26e942f343305fdddc01c59f.1732444746.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <9b83c5ee8345e4fe26e942f343305fdddc01c59f.1732444746.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SfcJ1U1ioolYlU08V0tDyUyw2lx+5XKM0Sq15uwms2N2TD3GDtv
 RVhf4eAAYXTT4NW/+ZEmAcWY7MGGonqdmQnhs4vMhmtMVQEie1Vqrh7Q9sOwzkNx/sAkUMJ
 E2r/k2YmV0vWRxLK+xRuvMxVtTdxi/Vkbah5D/uGjIn9tTZ2swWok2dWKRjRT4bnxlZoP6a
 gB///W+fSsqyeAFLDMlXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:15pj2DQDW1A=;lqF5/uK6uFKXoQv461NDp6cqEvf
 zxv1eeo0nBr8au2SHLc2y8hHaO3j6sGcJ+LeK20Hya+II31132SKpL45QEWO2E0POm0TdSfKQ
 TyDAfvmpHFWZYTWU6Mbniv9ue/KxCgWE5PyOo/QhBGTo/SSzQSKOidyxBb4/CmeI5Kq/XStDS
 w17giBiy9mph61kPzaNciZetzMZPjQZWucNB626gECxeVkwtqurYr086V/s4JA7ULEq7flupl
 y/zSV8beWOjHaH90GmNtL/iiERlsDWqY5+N6W7mmajxtSMnuEBc2wfh35vlqY0tmUA3r9G/ec
 2/LpJkimnjpFfUWa9l9N3keNoynAeL/Z4gRA8qnuloALrL0tHFeWOlrYqMLK6pwKZRmCtEyy1
 uoq1jbyqVTfHp5cbEJ1m5gj73s+aRbZGqsL1WejalBzti4Jw96DVIrB2YN4RBK26Wxezs3/ph
 XZvwOsIAQPBkweCgyC9aJ6Sm1RGe80Q1XKFHOAPhJZBZ+im++SKR37AXLPm6BvcrdwJYxqqG0
 fOTjOCGwJLyt5NwFbXsc5fGC5e/udV5EI672Caihpu3y5dubWK+5jYNzamcc7nwtMUvRCnmdK
 Bj3bGW9KsLSevZNGQiBExuY3nDfkhWo3NUx7xht5dnIjUX56X3/2sYxu7eJJLA2R3js6b8F0l
 AKV1Y3Db54hQ7/Zu7MfG80AUChkDJrKOm7Jf61dVxGVKWPvFvD/PvlacOmkfajCQzg0FWH2/O
 4aU4gZkUUslvgVwiZZir0dItd4KKJVB1O5tKX5FsaLIjYmGFQC1EKC2CzH/Y4y1St+JVzsElG
 krgyk1yQpauCZBklvupZeFxjYblsmzSJ36fiXpnd0jTxUHmD4OjmLVubPT/xdC7phg5vKpVbV
 RuiPiQON99AF5BsrjvWlarIGaMeweTv6v9Rxm/M92DeGsrwhVmdVRri8oqFzNFVSHkrlIZtB+
 AsVfA8lxEWPzdQeQTieHuFfNXgoXRNgM61fexT2IXwbITLaXj3Qij5OcPdY8z5EesssnS9JMp
 PBFRU7uYND8rcRYYLSmZj5NqLqCm7NyR//g1OosDoD8/XEy0HgigOfzdo7iQ89m4NfaemTsY+
 9mKzssjEw1lIgFWAbFjROw01asuei1

Hi Andrea,

Am 24.11.24 um 11:51 schrieb Andrea della Porta:
> Add device tree bindings for the gpio/pin/mux controller that is part of
> the RP1 multi function device, and relative entries in MAINTAINERS file.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   .../pinctrl/raspberrypi,rp1-gpio.yaml         | 193 ++++++++++++++++++
>   MAINTAINERS                                   |   2 +
>   2 files changed, 195 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberry=
pi,rp1-gpio.yaml
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-g=
pio.yaml b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.=
yaml
> new file mode 100644
> index 000000000000..21923d39c1bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yam=
l
> @@ -0,0 +1,193 @@
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
> +  The RP1 chipset is a Multi Function Device containing, among other
> +  sub-peripherals, a gpio/pinconf/mux controller whose 54 pins are grou=
ped
> +  into 3 banks.
> +  It works also as an interrupt controller for those gpios.
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
> +    description: The first cell is the pin number and the second cell i=
s used
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
> +    description: One interrupt specifier for each one of the 3 pin bank=
s.
> +
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
> +      Pin controller client devices use pin configuration subnodes (chi=
ldren
> +      and grandchildren) for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in thi=
s
> +          subnode.
> +        items:
> +          pattern: "^gpio([0-9]|[1-5][0-9])$"
> +
> +      function:
> +        enum: [ alt0, alt1, alt2, alt3, alt4, gpio, alt6, alt7, alt8, n=
one,
> +                aaud, dcd0, dpi, dsi0_te_ext, dsi1_te_ext, dsr0, dtr0, =
gpclk0,
> +                gpclk1, gpclk2, gpclk3, gpclk4, gpclk5, i2c0, i2c1, i2c=
2, i2c3,
> +                i2c4, i2c5, i2c6, i2s0, i2s1, i2s2, ir, mic, pcie_clkre=
q_n,
> +                pio, proc_rio, pwm0, pwm1, ri0, sd0, sd1, spi0, spi1, s=
pi2,
> +                spi3, spi4, spi5, spi6, spi7, spi8, uart0, uart1, uart2=
, uart3,
> +                uart4, uart5, vbus0, vbus1, vbus2, vbus3 ]
> +
> +        description:
> +          Specify the alternative function to be configured for the spe=
cified
> +          pins.
> +
> +      bias-disable: true
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      slew-rate:
> +        description: 0 is slow slew rate, 1 is fast slew rate
> +        enum: [ 0, 1 ]
> +      drive-strength:
> +        enum: [ 2, 4, 8, 12 ]
according to the driver in patch 4 the following should also be
supported by the hardware:

input-enable, input-schmitt-enable, output-enable, output-low, output-high
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +required:
> +  - reg
> +  - compatible
> +  - '#gpio-cells'
> +  - gpio-controller
> +  - interrupts
> +  - '#interrupt-cells'
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    rp1 {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        rp1_gpio: pinctrl@c0400d0000 {
> +            reg =3D <0xc0 0x400d0000  0x0 0xc000>,
> +                  <0xc0 0x400e0000  0x0 0xc000>,
> +                  <0xc0 0x400f0000  0x0 0xc000>;
> +            compatible =3D "raspberrypi,rp1-gpio";
> +            gpio-controller;
> +            #gpio-cells =3D <2>;
> +            interrupt-controller;
> +            #interrupt-cells =3D <2>;
> +            interrupts =3D <0 IRQ_TYPE_LEVEL_HIGH>,
> +                         <1 IRQ_TYPE_LEVEL_HIGH>,
> +                         <2 IRQ_TYPE_LEVEL_HIGH>;
> +            gpio-line-names =3D
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
> +            rp1-i2s0-default-state {
> +                function =3D "i2s0";
> +                pins =3D "gpio18", "gpio19", "gpio20", "gpio21";
> +                bias-disable;
> +            };
> +
> +            rp1-uart0-default-state {
> +                txd-pins {
> +                    function =3D "uart0";
> +                    pins =3D "gpio14";
> +                    bias-disable;
> +                };
> +
> +                rxd-pins {
> +                    function =3D "uart0";
> +                    pins =3D "gpio15";
> +                    bias-pull-up;
> +                };
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 75a66e3e34c9..c55d12550246 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19384,7 +19384,9 @@ RASPBERRY PI RP1 PCI DRIVER
>   M:	Andrea della Porta <andrea.porta@suse.com>
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> +F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
>   F:	include/dt-bindings/clock/rp1.h
> +F:	include/dt-bindings/misc/rp1.h
>
>   RC-CORE / LIRC FRAMEWORK
>   M:	Sean Young <sean@mess.org>


