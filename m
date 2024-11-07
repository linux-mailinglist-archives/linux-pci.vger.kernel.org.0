Return-Path: <linux-pci+bounces-16196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 485C59BFEF6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 08:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3A31C21406
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58FB194ACA;
	Thu,  7 Nov 2024 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OPoUaR2Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F1E1BDAA2
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963857; cv=none; b=RcLH5hezCvYMEVXqx/77A3EOcxi5GBhiyVcpxGV3N+0TcTzdxKAgAmeHi/oGAiJkQl8sYgHIXI5R2qSUKf9hyLqxX5u2IfDo89Gf3So0p+biHiN+Id1bo1MdyUpUcbP8Gu5q277GbfKn4xLqxKLuF8O0X1aBu1Ye1I45zhPCul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963857; c=relaxed/simple;
	bh=pMTFpGhlQtDtxK49IKvVF6FBBM3QiommfkMVhzAskMg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOjIu0Aj7Y9lsfVbRkCWhE2dTQ38NXD8k1JRHfrJ0qB/Deo4G6VTW8aJp2d9LOz50lBvQ+5Nz8WllHlBcDJXrvZaHUlvI2YJ6FJACOfRKuDq3TFJk9SSFIyUIEKeieENv30IISFp8+4ganLFifnBF+bJXCAR+L/4U7J0SDtyqe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OPoUaR2Q; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a9a850270e2so101456566b.0
        for <linux-pci@vger.kernel.org>; Wed, 06 Nov 2024 23:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730963852; x=1731568652; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nbOrRriYh6w4F8LVkNHZr22RHexrNFjFKA4icR8e7Vs=;
        b=OPoUaR2QjF/le64kDXff1pVReBcS1YW6YvjDmyunb1UOtQW+EN9WzLUBHANyjsgFom
         8NSGwY3gxsvP0ZsFeW8YSwxJrh3B/1aS3lSr8PsAhngMvO2Z6MWfj0vg/Pgn4ngm+M37
         /rs+lXIxfqAEJ9GWeR/RPzKJ9tFv++ow4cyFoIMBDTfqG/iAT4j9MOOCFugGzEcEV3sS
         CRrL+1MVrmyGw0fBrEf+DwDg+FkTIQvzqfXKR/sTxpVUpx+38p3jah3sMOX9V9SffHWc
         NVWH0S5H4qQ7yWgx/3LC3nzVzf13nCsvsu4do1TSZr5N9EuhZ2VfkfpZEdn/tS5c7IZs
         YIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730963852; x=1731568652;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbOrRriYh6w4F8LVkNHZr22RHexrNFjFKA4icR8e7Vs=;
        b=t9dXO8l49LDwnDeshrjRVJsAv1oZitJOwTVXGg4ppi4QW69z81a6dKzSKMdkDpsCHR
         VbSonnBMgmGPmxPfscIOkJoXT7foafx/oQQzKBX0K9LG287etiVO59BjlQhAlVHvE/Ft
         0BHFhXRxI2eMUlvlcXASPgJSsatmx1Eotdme7T3bMVLXD6IhNxm+WUtuTORXkumoVAHn
         wWrFQAWI3TyRGEDk8gauNi2eRDidlASqlZM/KImxwkDMwn7sOMc7X8S2mf09/HVbcHug
         lBwMP0j1AlL0+/W9QCqnOh91aWtvZ/rlXHIFrr0unSJ5yoFKaJerXm4kN+iomRPgkoq5
         aa+A==
X-Forwarded-Encrypted: i=1; AJvYcCXiF1zNHgenGsocGeXv9l739liPNMxM6Lhi/TkvjI49c1A3GrQstlo4kvXmPhr9EoTMk+MGiEEZkN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8dDewPB4alUyys+nNcIDm61qjmhd1AOU1dVbsvd88AxMksRD
	kWdbMRknmgvxOdnJyzhXja432xIPU1c8DVB/zEsfsznmDwNoRBKJI8lKN1tmL/w=
X-Google-Smtp-Source: AGHT+IFPT6mzuetQvJyLFc7e08zxC/5UPQxA/Xio6fkK4wjMcfEmL06ep3a65TdFRwza/k5rV5x/ew==
X-Received: by 2002:a17:907:70d4:b0:a9e:b5d0:de6 with SMTP id a640c23a62f3a-a9eb5d00edemr628074966b.50.1730963852370;
        Wed, 06 Nov 2024 23:17:32 -0800 (PST)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defaefsm49539066b.164.2024.11.06.23.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 23:17:32 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 7 Nov 2024 08:17:58 +0100
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
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
Subject: Re: [PATCH v3 04/12] dt-bindings: misc: Add device specific bindings
 for RaspberryPi RP1
Message-ID: <ZyxppoSeZhOQ8h2L@apocalypse>
References: <cover.1730123575.git.andrea.porta@suse.com>
 <768d2307342e1054c58324a9d51957456dc82cbf.1730123575.git.andrea.porta@suse.com>
 <20241106145022.t7w2762t7zxpefc3@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106145022.t7w2762t7zxpefc3@thinkpad>

Hi Manivannan,

On 14:50 Wed 06 Nov     , Manivannan Sadhasivam wrote:
> On Mon, Oct 28, 2024 at 03:07:21PM +0100, Andrea della Porta wrote:
> > The RP1 is a MFD that exposes its peripherals through PCI BARs. This
> > schema is intended as minimal support for the clock generator and
> > gpio controller peripherals which are accessible through BAR1.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  .../devicetree/bindings/misc/pci1de4,1.yaml   | 80 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/misc/pci1de4,1.yaml b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> > new file mode 100644
> > index 000000000000..d66b2fc130d1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/misc/pci1de4,1.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RaspberryPi RP1 MFD PCI device
> > +
> > +maintainers:
> > +  - Andrea della Porta <andrea.porta@suse.com>
> > +
> > +description:
> > +  The RaspberryPi RP1 is a PCI multi function device containing
> > +  peripherals ranging from Ethernet to USB controller, I2C, SPI
> > +  and others.
> > +  The peripherals are accessed by addressing the PCI BAR1 region.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-ep-bus.yaml
> > +
> > +properties:
> > +  compatible:
> > +    additionalItems: true
> > +    maxItems: 3
> > +    items:
> > +      - const: pci1de4,1
> > +
> > +  '#interrupt-cells':
> > +    const: 2
> > +    description:
> > +      Specifies respectively the interrupt number and flags as defined
> > +      in include/dt-bindings/interrupt-controller/irq.h.
> > +
> > +  interrupt-controller: true
> > +
> > +unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - '#interrupt-cells'
> > +  - interrupt-controller
> > +  - pci-ep-bus@1
> > +
> > +examples:
> > +  - |
> > +    pci {
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +
> > +        rp1@0,0 {
> > +            compatible = "pci1de4,1";
> > +            ranges = <0x01 0x00 0x00000000
> > +                      0x82010000 0x00 0x00
> > +                      0x00 0x400000>;
> 
> Could you please have the 'ranges' in a single line as used everywhere?
> 
> - Mani

Sure.

Many thanks,
Andrea

> 
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +            interrupt-controller;
> > +            #interrupt-cells = <2>;
> > +
> > +            pci_ep_bus: pci-ep-bus@1 {
> > +                compatible = "simple-bus";
> > +                ranges = <0xc0 0x40000000
> > +                          0x01 0x00 0x00000000
> > +                          0x00 0x00400000>;
> > +                dma-ranges = <0x10 0x00000000
> > +                              0x43000000 0x10 0x00000000
> > +                              0x10 0x00000000>;
> > +                #address-cells = <2>;
> > +                #size-cells = <2>;
> > +
> > +                rp1_clocks: clocks@c040018000 {
> > +                    compatible = "raspberrypi,rp1-clocks";
> > +                    reg = <0xc0 0x40018000 0x0 0x10038>;
> > +                    #clock-cells = <1>;
> > +                    clocks = <&clk_rp1_xosc>;
> > +                    clock-names =  "xosc";
> > +                };
> > +            };
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ccf123b805c8..2aea5a6166bd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19384,6 +19384,7 @@ RASPBERRY PI RP1 PCI DRIVER
> >  M:	Andrea della Porta <andrea.porta@suse.com>
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > +F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> >  F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> >  F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >  F:	include/dt-bindings/clock/rp1.h
> > -- 
> > 2.35.3
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

