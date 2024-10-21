Return-Path: <linux-pci+bounces-14948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479579A713C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 19:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54FF2B2126A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0BF1EF93F;
	Mon, 21 Oct 2024 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NAwCfqhH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564661EF0AA
	for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2024 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532488; cv=none; b=Q9uPn//ZnAhbn3nX0qBz/lZ0Mb5LaaDV+gHa6NTZ2V1qpidNhtK+A6Q1jOESOwWI7smkLdZpH09GoJA8RY3vMQ08Sd0VUt/fnBvQVa3Ab8kX1LvC1iPlNDVryku7MNXxy+1qwGtihjgrJ/cSledlE29j033gOoNWDDOdL9l3iKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532488; c=relaxed/simple;
	bh=TuvrQ85T3vVtYJA6Cx1RVkvTS+wxjyvClzrMpwlzDho=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx1XCsv3/qVPifzkCHDAdvkEiYkIH64E//vpjU5jh8Euz4qqrvStgYFk0W882CW3Rmbl//1Kl8cmqwv2iHdKb7P0KwDDZDCa8yTZoo8ScxWqgRZ6iTMLxe6hfIs5QRxG2pJ/JgaSP6I6b5JAhkxKUYWm8cwawaZp8e/8cDU3OIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NAwCfqhH; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a9a628b68a7so610362366b.2
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2024 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729532482; x=1730137282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=63cpWyi1JIA2H2wekOls4P53PLW9lkUzTohEq41jf5s=;
        b=NAwCfqhHElFT4FbQCyfqrD2O0Wpb+RQAGKirWpRkBALABHxzfUDmk+hdOjOEqdjBhQ
         HOzBWa5cWqj5chxMRnAI24RbYZX9wl6i35DwpAGTb/7mUup46wXtUcx/sbk8uhZkA4pV
         FxW8m150mrF7XrxhTCJUNFWZv3uik9hZ8MpbIvOE/aKM0CTQZnWTi7jOw+wciNgM8TUd
         4NTi7EZdWKP/blLObrIwnipk4sJhPCSrtDR3md9kSsY6gdbPStMoFphNC480fE9aKDKU
         S4y224ohW8d+7HirIkIVuI82K7Weo/cbrs0uKM4vNmFLqO7bUNkZXj2wOt5KSfYAxupZ
         i29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729532482; x=1730137282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63cpWyi1JIA2H2wekOls4P53PLW9lkUzTohEq41jf5s=;
        b=hsGhxR4C34ib6dBejnHreIFlFzZFtZkNqx6EZBUEZH0/YmVYqSkPzScgTbRjj/kJMK
         UvXLvuePACtpNH+OzKZYpoNM5m6nyZVuNSmLZJNcpGkGpIDHBNaH3j7iJ/b/68KquJ7z
         F5QO60Y4IRouPyB74TzzFB+ph2FBdWhMKY7+YJfvyComCV20fNmegapsptiYkbIWVCmV
         fbqERuKS1HR03ZjEHg06wRnYEuc/Yv2Am43Kju2nLUejHBSBos7Rqmg0Y+MT/y4WEvgV
         6AUAidIrOnXnkQ9zCYccURd2DcZLDgQJ/ygfVyHHAPrKfEsD9wBt5Yd5Q0ZhI9fgFJ1v
         VsFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/xZZbKPg1DxVvCQkSvdhs3myRko0qjm5ch0foB4yy6EklKYBCPiwTQOnx8ROy8WmGCtw/+TSStMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw17pTUiYWsIf2lSRI7pGM0qxqQCtZWH7SvTILGn2P5t+SXhtH/
	bhP41x5CFJQcnQ0zBrPF1zLfIT3QURLrRke1n8w+GHKRnHCgGfKWeqtl79/6KYA=
X-Google-Smtp-Source: AGHT+IFwv4AD5sxlbdXAZB4TXDNLjUkfEFeFMzWPzU0NZL2Sw8oAxvsJavg9+Gy7Z9Bftm2TVA1zKw==
X-Received: by 2002:a17:907:7d8f:b0:a99:35eb:1301 with SMTP id a640c23a62f3a-a9a69a66fb0mr1297305266b.18.1729532482486;
        Mon, 21 Oct 2024 10:41:22 -0700 (PDT)
Received: from localhost (host-95-239-0-46.retail.telecomitalia.it. [95.239.0.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a913707edsm232308566b.127.2024.10.21.10.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 10:41:22 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 21 Oct 2024 19:41:43 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 02/14] dt-bindings: pinctrl: Add RaspberryPi RP1
 gpio/pinctrl/pinmux bindings
Message-ID: <ZxaSV2sj9-EpaSsh@apocalypse>
References: <cover.1728300189.git.andrea.porta@suse.com>
 <0589448fa41bf7f3e951a75b70226a9873db554f.1728300189.git.andrea.porta@suse.com>
 <csj452uzkug7nz6yygers6curpo2toj3pwmsa5ka2222hlfspf@jqumtwecvrdq>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <csj452uzkug7nz6yygers6curpo2toj3pwmsa5ka2222hlfspf@jqumtwecvrdq>

Hi Krzysztof,

On 08:29 Tue 08 Oct     , Krzysztof Kozlowski wrote:
> On Mon, Oct 07, 2024 at 02:39:45PM +0200, Andrea della Porta wrote:
> > Add device tree bindings for the gpio/pin/mux controller that is part of
> > the RP1 multi function device, and relative entries in MAINTAINERS file.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  .../pinctrl/raspberrypi,rp1-gpio.yaml         | 169 ++++++++++++++++++
> >  MAINTAINERS                                   |   2 +
> >  2 files changed, 171 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> > new file mode 100644
> > index 000000000000..46e071ec6251
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> > @@ -0,0 +1,169 @@
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
> > +  The RP1 chipset is a Multi Function Device containing, among other sub-peripherals,
> > +  a gpio/pinconf/mux controller whose 54 pins are grouped into 3 banks. It works also
> > +  as an interrupt controller for those gpios.
> > +
> > +  Each pin configuration node lists the pin(s) to which it applies, and one or
> > +  more of the mux function to select on those pin(s), and their configuration.
> > +  The pin configuration and multiplexing supports the generic bindings.
> > +  For details on each properties (including the meaning of "pin configuration node"),
> > +  you can refer to ./pinctrl-bindings.txt.
> 
> Drop the sentence. pinctrl.yaml defines this already.

Just to be sure, by 'sentence' I assume you mean the entire paragraph from
"Each pin configuration..." to "...refer to ./pinctrl-bindings.txt.", right?
 
> 
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
> > +additionalProperties:
> > +  anyOf:
> 
> Uh, no, I think you got comments on this. You should be specific which
> nodes you expect, e.g. pins or groups. See other recent bindings for
> example.

Please see below.

> 
> > +    - type: object
> > +      additionalProperties: false
> > +      allOf:
> > +        - $ref: pincfg-node.yaml#
> > +        - $ref: pinmux-node.yaml#
> > +
> > +      description:
> > +        Pin controller client devices use pin configuration subnodes (children
> > +        and grandchildren) for desired pin configuration.
> > +        Client device subnodes use below standard properties.
> > +
> > +      properties:
> > +        pins:
> > +          description:
> > +            A string (or list of strings) adhering to the pattern "gpio[0-5][0-9]"
> > +        function: true
> > +        bias-disable: true
> > +        bias-pull-down: true
> > +        bias-pull-up: true
> > +        slew-rate:
> > +          description: 0 is slow slew rate, 1 is fast slew rate
> > +          enum: [ 0, 1 ]
> > +        drive-strength:
> > +          enum: [ 2, 4, 8, 12 ]
> > +
> > +    - type: object
> > +      additionalProperties:
> > +        $ref: "#/additionalProperties/anyOf/0"
> 
> I don't quite get what you wanted to achieve here.

This should be a compact way to describe a schema that allows declarations like
the following:

rp1_gpio {
  ...

  /* grouped gpios */
  rp1_uart0_14_15: rp1_uart0_14_15 {
    pin_txd {
      function = "uart0";
      pins = "gpio14";
      bias-disable;
    };

    pin_rxd {
      function = "uart0";
      pins = "gpio15";
      bias-pull-up;
    };
  };

  /* standalone pins */
  rp1_i2s0_18_21: rp1_i2s0_18_21 {
      function = "i2s0";
      pins = "gpio18", "gpio19", "gpio20", "gpio21";
      bias-disable;
  };

  ...
};

that is, both standalone and group pinctrl/pinmux node.

> 
> > +
> > +allOf:
> > +  - $ref: pinctrl.yaml#
> > +
> > +required:
> > +  - reg
> > +  - compatible
> > +  - "#gpio-cells"
> > +  - gpio-controller
> > +  - interrupts
> > +  - "#interrupt-cells"
> > +  - interrupt-controller
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
> > +            rp1_uart0_14_15: rp1_uart0_14_15 {
> 
> Underscores are not allowed in node names. Please read DTS coding style.
> 
> Drop unused labels.

Ack.

Many thanks,
Andrea

> 
> > +                pin_txd {
> > +                    function = "uart0";
> > +                    pins = "gpio14";
> > +                    bias-disable;
> > +                };
> 
> Best regards,
> Krzysztof
> 

