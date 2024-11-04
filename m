Return-Path: <linux-pci+bounces-15937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8127D9BB2FE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 12:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A601F20F5E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 11:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C827B1D3596;
	Mon,  4 Nov 2024 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VFK3C1wl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE81D31A5
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718684; cv=none; b=RWQtknM8wk4/LFjodOY+XydMdoVijJwIculhL8fzNJmHo/DPwngF62w9Zn8b+8GEj0+4Ih+t1krubdPDiinX1SYikFYJGHfZYAwdM0t+mU4+VuW1pzGlLe8JRd0lObINaaiOcLXCPnuqIa02b/+5nbATIoJW76DTUKuo6KQn4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718684; c=relaxed/simple;
	bh=VYra1vd3ZI3DNsV6QlM4eJ9XfY/djVw8e2jACzdfLOA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbCo8pZM4KtqUJakhaY5i/4+5D/EssQxFvyR+a4ApmJNg0WvCsHoG4WBtrsWlioWgOtsgw7uIKZBICTzauHNsAz22LOuta0t17c/n+gGBx0Vdf+2yT/RLQm7A9RPSGmZFS/fn3u/qljXDRLajvSxomJ7RNgN0MWAt/oUWxqgPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VFK3C1wl; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a998a5ca499so546948466b.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 03:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730718679; x=1731323479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iR/eLuJ7hqRBDR8qMgEyoLrx9OmW3jzB7EgHhAaqCPM=;
        b=VFK3C1wlQS9YEinmoSKLaIgWH8mnwCB1+9tp7wyC0kP0xMo1GJiJy++adFkf0XuBU6
         gRtNyhuzK+NDY1bpIoI0h5CqwyHEglxR+M/X69GFkxT6AB5SRxJniq3NKksC1PuP0oEE
         MDFEkCj9rlXjqsyxiDtWkU8a00Sehy/eY3X966U+YTNVQyQzwKWWqTjCViHhMeZSOJO+
         0z0B5Td6BaE17HX5HH1z/37/TpCRZwPaQc0jlfaPPS7tDHkgASciJ5kTpaLPHFOE5opU
         mBOVjT2PpWVJdvNsRujqFlrgTGKwJ/S6+4vvDqwOTVQfXo9Zva86D/T9/9x9lvRnbF3g
         flYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730718679; x=1731323479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR/eLuJ7hqRBDR8qMgEyoLrx9OmW3jzB7EgHhAaqCPM=;
        b=nGuHSGpAqRFiFp6359Xkzw58T0L7HULpzySHqvtOZqP+8EmWTVoMDf1lt0B8wBuUOH
         Mjgw264Gjso/S9QLJbC9TE7z50jQ8th0Ut+5+Gu+IFe4s/Ei66Ej5Y12T+o8qhKzJ5yN
         AunVjQwV+Y8NaIlI4BO0P94xnREqVyVm0vGTw4rS2V1Zr1aNBGhH0S+0dAkaMNEfTCpV
         8qpwBWRTufqmzeyPuZhOYC+1YUhxY6zOIl60+4ojn0JoX833icBWA5qtYDos4lJQJsTM
         452bqQqP+988ScWtc3+55D4xewI5RCB/e2pzwHHCgVe7qXcmnLwfdOscOTXiKLQOQD7Y
         oBwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkgaY/sF4XnO/4uRlp47ZvzmGC+9nBU5Pi1FZVK8j4RH5RClZ6BbQ8Ai9n/UTVxEEUmmC/d6HVOW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUZyvv3w6G7sftM+CTHSAR+5c1lafEB3d3aJ5za2gRNRfhnspw
	UgRoI/gOH8hl+PNN7gEDS8dFLozt/N/fkHbw9m6C0Jmnsb20qnJVJ75E/4YpTJU=
X-Google-Smtp-Source: AGHT+IG5tnzS154o2gsQZG2Mb2tToZi0pE7ZGdMnxoVRw4hvBg/+92C8iupvzX1HwjwL9uMQzQiObQ==
X-Received: by 2002:a17:907:9446:b0:a99:88ab:c7cb with SMTP id a640c23a62f3a-a9e654fd997mr1068397466b.33.1730718677440;
        Mon, 04 Nov 2024 03:11:17 -0800 (PST)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56645dcbsm549642066b.177.2024.11.04.03.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:11:16 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 4 Nov 2024 12:11:42 +0100
To: Krzysztof Kozlowski <krzk@kernel.org>
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
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 02/12] dt-bindings: pinctrl: Add RaspberryPi RP1
 gpio/pinctrl/pinmux bindings
Message-ID: <Zyir7pu8T-fjUIA4@apocalypse>
References: <cover.1730123575.git.andrea.porta@suse.com>
 <9a02498e0fbc135dcbe94adc7fc2d743cf190fac.1730123575.git.andrea.porta@suse.com>
 <mjhopgkrjahaxydn3ckianqnvjn55kxrldulvjkpqivlz72uyi@57l5vhydpzc2>
 <ZyOPHm7fl_vW7mAJ@apocalypse>
 <cc2e1a17-c5b1-4608-8e32-a6dea23a7efb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc2e1a17-c5b1-4608-8e32-a6dea23a7efb@kernel.org>

Hi Krzysztof,

On 19:10 Thu 31 Oct     , Krzysztof Kozlowski wrote:
> On 31/10/2024 15:07, Andrea della Porta wrote:
> > Hi Krzysztof,
> > 
> > On 08:26 Tue 29 Oct     , Krzysztof Kozlowski wrote:
> >> On Mon, Oct 28, 2024 at 03:07:19PM +0100, Andrea della Porta wrote:
> >>> Add device tree bindings for the gpio/pin/mux controller that is part of
> >>> the RP1 multi function device, and relative entries in MAINTAINERS file.
> >>>
> >>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> >>> ---
> >>>  .../pinctrl/raspberrypi,rp1-gpio.yaml         | 163 ++++++++++++++++++
> >>>  MAINTAINERS                                   |   2 +
> >>>  2 files changed, 165 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >>> new file mode 100644
> >>> index 000000000000..465a53a6d84f
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >>> @@ -0,0 +1,163 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/pinctrl/raspberrypi,rp1-gpio.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: RaspberryPi RP1 GPIO/Pinconf/Pinmux Controller submodule
> >>> +
> >>> +maintainers:
> >>> +  - Andrea della Porta <andrea.porta@suse.com>
> >>> +
> >>> +description:
> >>> +  The RP1 chipset is a Multi Function Device containing, among other sub-peripherals,
> >>> +  a gpio/pinconf/mux controller whose 54 pins are grouped into 3 banks. It works also
> >>
> >> Please wrap code according to coding style (checkpatch is not a coding
> >> style description but only a tool).
> > 
> > Ack.
> > 
> >>
> >>> +  as an interrupt controller for those gpios.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: raspberrypi,rp1-gpio
> >>> +
> >>> +  reg:
> >>> +    maxItems: 3
> >>> +    description: One reg specifier for each one of the 3 pin banks.
> >>> +
> >>> +  '#gpio-cells':
> >>> +    description: The first cell is the pin number and the second cell is used
> >>> +      to specify the flags (see include/dt-bindings/gpio/gpio.h).
> >>> +    const: 2
> >>> +
> >>> +  gpio-controller: true
> >>> +
> >>> +  gpio-ranges:
> >>> +    maxItems: 1
> >>> +
> >>> +  gpio-line-names:
> >>> +    maxItems: 54
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 3
> >>> +    description: One interrupt specifier for each one of the 3 pin banks.
> >>> +
> >>> +  '#interrupt-cells':
> >>> +    description:
> >>> +      Specifies the Bank number [0, 1, 2] and Flags as defined in
> >>> +      include/dt-bindings/interrupt-controller/irq.h.
> >>> +    const: 2
> >>> +
> >>> +  interrupt-controller: true
> >>> +
> >>> +additionalProperties:
> >>
> >> Not much improved. You are supposed to have here pattern, just like
> >> other bindings. I asked for this last time.
> >>
> >> And there are examples using it - almost all or most of pinctrl
> >> bindings, including bindings having subnodes (but you do not use such
> >> case here).
> > 
> > This is the same approach used in [1], which seems quite recent. I did't
> 
> 2021, so not that recent, but you are right that it's not the example I
> would recommend. See rather:
> git grep pins -- Documentation/devicetree/bindings/pinctrl/ | grep '\$'
> 
> 
> pins, groups, states, etc.

Perfect. Thanks for the example suggestion.

> 
> > use pattern because I wouldn't really want to enforce a particular naming
> > scheme. Subnodes are used, please see below. Since pinctrl.yaml explicitly
> 
> But we want to enforce, because it brings uniformity and matches
> partially generic naming patterns.

Ack.

> 
> > says that there is no common binding but each device has its own, I
> > thought that was reasonable choice. Should I enforce some common pattern,
> > then?
> 
> Yes, you should. Again, look at other bindings, e.g. qcom tlmm or lpass lpi.

Ok.

> 
> > 
> >>
> >>> +  anyOf:
> >>> +    - type: object
> >>> +      additionalProperties: false
> >>> +      allOf:
> >>> +        - $ref: pincfg-node.yaml#
> >>> +        - $ref: pinmux-node.yaml#
> >>> +
> >>> +      description:
> >>> +        Pin controller client devices use pin configuration subnodes (children
> >>> +        and grandchildren) for desired pin configuration.
> >>> +        Client device subnodes use below standard properties.
> >>> +
> >>> +      properties:
> >>> +        pins:
> >>> +          description:
> >>> +            A string (or list of strings) adhering to the pattern 'gpio[0-5][0-9]'
> >>> +        function: true
> >>> +        bias-disable: true
> >>> +        bias-pull-down: true
> >>> +        bias-pull-up: true
> >>> +        slew-rate:
> >>> +          description: 0 is slow slew rate, 1 is fast slew rate
> >>> +          enum: [ 0, 1 ]
> >>> +        drive-strength:
> >>> +          enum: [ 2, 4, 8, 12 ]
> >>> +
> >>> +    - type: object
> >>> +      additionalProperties:
> >>> +        $ref: "#/additionalProperties/anyOf/0"
> >>
> >> Your example does not use any subnodes, so this looks not needed.
> > 
> > The example has subnodes, as in the following excerpt from the example:
> 
> I meant, you do not need properties in subnodes (1st level). You only
> want properties in subnodes of subnodes, so 2nd level. What is the point
> of allowing them in 1st level?

I will add those two sub-nodes to the example:

            rp1-i2s0-default-state {
                function = "i2s0";
                pins = "gpio18", "gpio19", "gpio20", "gpio21";
                bias-disable;
            };

            rp1-uart0-default-state {
                txd-pins {
                    function = "uart0";
                    pins = "gpio14";
                    bias-disable;
                };

                rxd-pins {
                    function = "uart0";
                    pins = "gpio15";
                    bias-pull-up;
                };
            };

The first is just a group of pins with the same settings, the second is 
a pin group with different settings per pin. This is basically the same
usage as in qcom,sm4250-lpass-lpi-pinctrl.yaml.

Many thanks,
Andrea

 
> 
> 
> 
> Best regards,
> Krzysztof
> 

