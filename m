Return-Path: <linux-pci+bounces-17467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F239DEBDD
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 18:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0428B219CD
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 17:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE9C19CCEA;
	Fri, 29 Nov 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GT7W9T1u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D919E7F7
	for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732902631; cv=none; b=C4xBdbCCvnBY34gvDghC5tBCS+QMfG0fk4Jz5794ncWcWiQZdnfQ7i7km4lsfEW0WJqPqIHdh61u761oZxZ4OU+EqKXrmNhrcDjQht5f7AqR71MWwRTTQTiuqFhmiX2IJmHlgbj+Cmg8JkVM5bQwyV1vJacpRh5OvvNbJOQplc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732902631; c=relaxed/simple;
	bh=8ImrQXCJjXUd91H2/9i3Z8wuNRacPGJigWYHLmK2W1I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvp2BCOxWZp+YQ830xndGMUD9rUuxFsIYi16D3RK8hl77cDY4VQggN5NXixh9sf0BYHRyyzNcM0Fjm7FSscN5dlllucnMYFLDZ8MqOwT/oDjN2shIurZ2/+uR+xaHDxOn4sZ9g8Gym2b7bPJIafNnVTYEHzRPeEB8xzg67chfC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GT7W9T1u; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so109110666b.3
        for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2024 09:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732902628; x=1733507428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PqZrAfjye64ZhMw5Co4hhbixNEOQJOzDdw3eUKG3fbQ=;
        b=GT7W9T1ukkeXC48tyZU/KQTWNbKY9O39uvVW0jyGsneTTdwIWHe2s0CvdUB0yaNIw3
         Z9X1SYjXH9C8H7RI3dJdkTwYs4xQMQjdkj2LmZz7hYAgS6pH1tawBNpmWlRRw3F09TSL
         QH+e0alGomOwptCbrYWGTEqqlTgNgCIvF5IX1bwCeBvt7HmNs15UH0dh8ChYyv0hFrup
         luUmNlS41MKVZRs0H50dbLiA4F57degpX8ujNliwnC73Ip2deV5vxdHr0xNNd5EP459u
         SJYzjgxHw3OzPH/mYuGtnpH43NZcco9mAR+gD7gttSdmorJ+qx2/dfl/UnORJHRvJUei
         qMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732902628; x=1733507428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqZrAfjye64ZhMw5Co4hhbixNEOQJOzDdw3eUKG3fbQ=;
        b=JFkN+8uYr6ZFrXiPZX+3BjT9rczXoyoJfW/qm4ifR4ngN2YjfZCULRXnSoBJBPABwD
         4dvXYeRhqc8Gopve3efrKgWRQ9XpgkXK8K1Xaer4hFFNP/zZ0HcZrv5B5T1En0vewj2I
         o1Dl+04vv0//SetOvGBgfFKB1p+6zvyo5us5450EiEiT5EodBNcgKh41KOrGjaiN8Y6r
         6vbQEarKUHNvD7xFhaBfplJeZjHdutTqNnXcge9jdM4Yj0qA2pO613uygYTVwzplid0X
         B0Shebftq9vtC6BoeCrdsO2sO9BEJ4u5lrWsu/mFkym2f5Pj+azYRDCL8iUox88P+1Sq
         4J/A==
X-Forwarded-Encrypted: i=1; AJvYcCVABEEDRKLFXta+axw/QT4EA3dqgcXOeHr1rhf33cc6VasxHgC07PR5z1FvfPZGTvlElpljErt7ZMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5GcONukQ0eXKnLIDpGwCjaoaS1B2EX1Zf069v+8Zj04z5gUro
	KoopLETvtjH729tpYnoi8HVpU7KQneBBwMcquRnf8/hMr+FQa1yWjTb0Np1A9HI=
X-Gm-Gg: ASbGnctedFS/xcml1xyI7cotIxpmTselGLP3J55O8UYoQDLlKe+QzjwvlPEzmsPBBSQ
	Z66oX2zxFHqW8gSDTf+QUKDYfgeol32ZGoWnHmaFWcHdBzg7pCZ08xOJHzPe73FtV73tLcPfTmA
	TaDxsnVEC560LtHB6U+DxADGYp7gu3B3LGuCMQtRWvCnEjnMO40/mAdkstDP4nnusJcgqrUrape
	2fp7xzQn5oec+dNwM2AP8MmO6ep9tWJEiNMNe8Xn1O/JnVUvrkatSasfDel8L2QpMm2nwhTFp1l
	rp+0Z1PVZRMoQsy1U1Ee
X-Google-Smtp-Source: AGHT+IF7i5rs2I/Z8Do8qBVzOITzII4lxVZ5lVsk4D6hBN3DGyS3RbzWkQK53YgfV1EgQ7zK28Pzig==
X-Received: by 2002:a05:6402:13d3:b0:5d0:224b:d4c1 with SMTP id 4fb4d7f45d1cf-5d080c53c5dmr12990539a12.25.1732902627665;
        Fri, 29 Nov 2024 09:50:27 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0b264f0d2sm996856a12.72.2024.11.29.09.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 09:50:27 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 29 Nov 2024 18:51:00 +0100
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 02/10] dt-bindings: pinctrl: Add RaspberryPi RP1
 gpio/pinctrl/pinmux bindings
Message-ID: <Z0n_BA8ZRU3ghE7Z@apocalypse>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <9b83c5ee8345e4fe26e942f343305fdddc01c59f.1732444746.git.andrea.porta@suse.com>
 <e0595933-d503-492d-ae29-aa3afe90b279@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0595933-d503-492d-ae29-aa3afe90b279@gmx.net>

Hi Stephan,

On 19:12 Mon 25 Nov     , Stefan Wahren wrote:
> Hi Andrea,
> 
> Am 24.11.24 um 11:51 schrieb Andrea della Porta:
> > Add device tree bindings for the gpio/pin/mux controller that is part of
> > the RP1 multi function device, and relative entries in MAINTAINERS file.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >   .../pinctrl/raspberrypi,rp1-gpio.yaml         | 193 ++++++++++++++++++
> >   MAINTAINERS                                   |   2 +
> >   2 files changed, 195 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> > new file mode 100644
> > index 000000000000..21923d39c1bc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> > @@ -0,0 +1,193 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/raspberrypi,rp1-gpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RaspberryPi RP1 GPIO/Pinconf/Pinmux Controller submodule
> > +
> > +maintainers:
> > +  - Andrea della Porta <andrea.porta@suse.com>
> > +
> > +description:
> > +  The RP1 chipset is a Multi Function Device containing, among other
> > +  sub-peripherals, a gpio/pinconf/mux controller whose 54 pins are grouped
> > +  into 3 banks.
> > +  It works also as an interrupt controller for those gpios.
> > +
> > +properties:
> > +  compatible:
> > +    const: raspberrypi,rp1-gpio
> > +
> > +  reg:
> > +    maxItems: 3
> > +    description: One reg specifier for each one of the 3 pin banks.
> > +
> > +  '#gpio-cells':
> > +    description: The first cell is the pin number and the second cell is used
> > +      to specify the flags (see include/dt-bindings/gpio/gpio.h).
> > +    const: 2
> > +
> > +  gpio-controller: true
> > +
> > +  gpio-ranges:
> > +    maxItems: 1
> > +
> > +  gpio-line-names:
> > +    maxItems: 54
> > +
> > +  interrupts:
> > +    maxItems: 3
> > +    description: One interrupt specifier for each one of the 3 pin banks.
> > +
> > +  '#interrupt-cells':
> > +    description:
> > +      Specifies the Bank number [0, 1, 2] and Flags as defined in
> > +      include/dt-bindings/interrupt-controller/irq.h.
> > +    const: 2
> > +
> > +  interrupt-controller: true
> > +
> > +patternProperties:
> > +  "-state$":
> > +    oneOf:
> > +      - $ref: "#/$defs/raspberrypi-rp1-state"
> > +      - patternProperties:
> > +          "-pins$":
> > +            $ref: "#/$defs/raspberrypi-rp1-state"
> > +        additionalProperties: false
> > +
> > +$defs:
> > +  raspberrypi-rp1-state:
> > +    allOf:
> > +      - $ref: pincfg-node.yaml#
> > +      - $ref: pinmux-node.yaml#
> > +
> > +    description:
> > +      Pin controller client devices use pin configuration subnodes (children
> > +      and grandchildren) for desired pin configuration.
> > +      Client device subnodes use below standard properties.
> > +
> > +    properties:
> > +      pins:
> > +        description:
> > +          List of gpio pins affected by the properties specified in this
> > +          subnode.
> > +        items:
> > +          pattern: "^gpio([0-9]|[1-5][0-9])$"
> > +
> > +      function:
> > +        enum: [ alt0, alt1, alt2, alt3, alt4, gpio, alt6, alt7, alt8, none,
> > +                aaud, dcd0, dpi, dsi0_te_ext, dsi1_te_ext, dsr0, dtr0, gpclk0,
> > +                gpclk1, gpclk2, gpclk3, gpclk4, gpclk5, i2c0, i2c1, i2c2, i2c3,
> > +                i2c4, i2c5, i2c6, i2s0, i2s1, i2s2, ir, mic, pcie_clkreq_n,
> > +                pio, proc_rio, pwm0, pwm1, ri0, sd0, sd1, spi0, spi1, spi2,
> > +                spi3, spi4, spi5, spi6, spi7, spi8, uart0, uart1, uart2, uart3,
> > +                uart4, uart5, vbus0, vbus1, vbus2, vbus3 ]
> > +
> > +        description:
> > +          Specify the alternative function to be configured for the specified
> > +          pins.
> > +
> > +      bias-disable: true
> > +      bias-pull-down: true
> > +      bias-pull-up: true
> > +      slew-rate:
> > +        description: 0 is slow slew rate, 1 is fast slew rate
> > +        enum: [ 0, 1 ]
> > +      drive-strength:
> > +        enum: [ 2, 4, 8, 12 ]
> according to the driver in patch 4 the following should also be
> supported by the hardware:
> 
> input-enable, input-schmitt-enable, output-enable, output-low, output-high

You are right, added.

Many thanks,
Andrea

> > +
> > +    additionalProperties: false
> > +
> > +allOf:
> > +  - $ref: pinctrl.yaml#
> > +
> > +required:
> > +  - reg
> > +  - compatible
> > +  - '#gpio-cells'
> > +  - gpio-controller
> > +  - interrupts
> > +  - '#interrupt-cells'
> > +  - interrupt-controller
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    rp1 {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        rp1_gpio: pinctrl@c0400d0000 {
> > +            reg = <0xc0 0x400d0000  0x0 0xc000>,
> > +                  <0xc0 0x400e0000  0x0 0xc000>,
> > +                  <0xc0 0x400f0000  0x0 0xc000>;
> > +            compatible = "raspberrypi,rp1-gpio";
> > +            gpio-controller;
> > +            #gpio-cells = <2>;
> > +            interrupt-controller;
> > +            #interrupt-cells = <2>;
> > +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <1 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <2 IRQ_TYPE_LEVEL_HIGH>;
> > +            gpio-line-names =
> > +                   "ID_SDA", // GPIO0
> > +                   "ID_SCL", // GPIO1
> > +                   "GPIO2", "GPIO3", "GPIO4", "GPIO5", "GPIO6",
> > +                   "GPIO7", "GPIO8", "GPIO9", "GPIO10", "GPIO11",
> > +                   "GPIO12", "GPIO13", "GPIO14", "GPIO15", "GPIO16",
> > +                   "GPIO17", "GPIO18", "GPIO19", "GPIO20", "GPIO21",
> > +                   "GPIO22", "GPIO23", "GPIO24", "GPIO25", "GPIO26",
> > +                   "GPIO27",
> > +                   "PCIE_RP1_WAKE", // GPIO28
> > +                   "FAN_TACH", // GPIO29
> > +                   "HOST_SDA", // GPIO30
> > +                   "HOST_SCL", // GPIO31
> > +                   "ETH_RST_N", // GPIO32
> > +                   "", // GPIO33
> > +                   "CD0_IO0_MICCLK", // GPIO34
> > +                   "CD0_IO0_MICDAT0", // GPIO35
> > +                   "RP1_PCIE_CLKREQ_N", // GPIO36
> > +                   "", // GPIO37
> > +                   "CD0_SDA", // GPIO38
> > +                   "CD0_SCL", // GPIO39
> > +                   "CD1_SDA", // GPIO40
> > +                   "CD1_SCL", // GPIO41
> > +                   "USB_VBUS_EN", // GPIO42
> > +                   "USB_OC_N", // GPIO43
> > +                   "RP1_STAT_LED", // GPIO44
> > +                   "FAN_PWM", // GPIO45
> > +                   "CD1_IO0_MICCLK", // GPIO46
> > +                   "2712_WAKE", // GPIO47
> > +                   "CD1_IO1_MICDAT1", // GPIO48
> > +                   "EN_MAX_USB_CUR", // GPIO49
> > +                   "", // GPIO50
> > +                   "", // GPIO51
> > +                   "", // GPIO52
> > +                   ""; // GPIO53
> > +
> > +            rp1-i2s0-default-state {
> > +                function = "i2s0";
> > +                pins = "gpio18", "gpio19", "gpio20", "gpio21";
> > +                bias-disable;
> > +            };
> > +
> > +            rp1-uart0-default-state {
> > +                txd-pins {
> > +                    function = "uart0";
> > +                    pins = "gpio14";
> > +                    bias-disable;
> > +                };
> > +
> > +                rxd-pins {
> > +                    function = "uart0";
> > +                    pins = "gpio15";
> > +                    bias-pull-up;
> > +                };
> > +            };
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 75a66e3e34c9..c55d12550246 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19384,7 +19384,9 @@ RASPBERRY PI RP1 PCI DRIVER
> >   M:	Andrea della Porta <andrea.porta@suse.com>
> >   S:	Maintained
> >   F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > +F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >   F:	include/dt-bindings/clock/rp1.h
> > +F:	include/dt-bindings/misc/rp1.h
> > 
> >   RC-CORE / LIRC FRAMEWORK
> >   M:	Sean Young <sean@mess.org>
> 

