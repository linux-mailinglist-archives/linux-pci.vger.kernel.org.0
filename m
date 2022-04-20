Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43B25090E2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 21:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381974AbiDTUAP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 16:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382005AbiDTUAH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 16:00:07 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117B648E5A;
        Wed, 20 Apr 2022 12:56:38 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id b188so3247533oia.13;
        Wed, 20 Apr 2022 12:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OyeWgb/U4rnVtnxBVHnhz7nKAu2v5/SnAMiyr6yT0DY=;
        b=lIBAUr6lUBTbGfhbxt/8RBCVnrfZL7OV6XAwZ6IffIpZ677jVTtE5lFs5RjxsZe1G3
         eHmzf22tfIQDaQoz34rhqWiphw5vl5tr+gtNqQjmJfaOfdOzZ91kOGk5Th/0UiesO2kZ
         uj4xp1/Gti0JgWIdX1gIUtsWo3LkrLsNX+aQWj9IHBDEKO2Zdn0VCoWZYXKMbCnlq3ab
         QWgNWghUYOPieusND/CmLYKJuzC0f0oFg+mq5WHzvUoNMAqitiGK9R5vGW3DJEUOdBM6
         cePt9o48dDfcfRsPg5eumtToTvLW+jKQh+K79kyHZdKzqQ8kUQEE7ZupEMDXAxIq5pTD
         9CYA==
X-Gm-Message-State: AOAM531Y6oIlXYmq+hWUsMZGOGaeEJRj29QLvcIwwFCdVcTcIFh0zpE5
        Eh3AnDF6hk2QwQJ6hV7f0w==
X-Google-Smtp-Source: ABdhPJyj+vjWS3Xi9zNx7tqjswIgQJkTRSUgANyjKvQv0BOw6vDI4yXWSqcqH1OdfMHyl2Mgrf0rbw==
X-Received: by 2002:aca:1811:0:b0:2ef:3c0f:f169 with SMTP id h17-20020aca1811000000b002ef3c0ff169mr2523761oih.61.1650484597182;
        Wed, 20 Apr 2022 12:56:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x2-20020a4a2a42000000b0033a3c4392c3sm4066899oox.26.2022.04.20.12.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 12:56:36 -0700 (PDT)
Received: (nullmailer pid 1749528 invoked by uid 1000);
        Wed, 20 Apr 2022 19:56:35 -0000
Date:   Wed, 20 Apr 2022 14:56:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 6/8] ARM: dts: r9a06g032: Add internal PCI bridge node
Message-ID: <YmBlc7e69INL4bfI@robh.at.kernel.org>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
 <20220414074011.500533-7-herve.codina@bootlin.com>
 <05c96b4d-313b-1aad-0ee5-61e54672765e@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c96b4d-313b-1aad-0ee5-61e54672765e@omp.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 18, 2022 at 12:02:52PM +0300, Sergey Shtylyov wrote:
> Hello!
> 
> On 4/14/22 10:40 AM, Herve Codina wrote:
> 
> > Add the device node for the r9a06g032 internal PCI bridge device.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  arch/arm/boot/dts/r9a06g032.dtsi | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
> > index 636a6ab31c58..848dc034bb8c 100644
> > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > @@ -211,6 +211,34 @@ gic: interrupt-controller@44101000 {
> >  			interrupts =
> >  				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> >  		};
> > +
> > +		pci_usb: pci@40030000 {
> > +			compatible = "renesas,pci-r9a06g032", "renesas,pci-rzn1";
> > +			device_type = "pci";
> > +			clocks = <&sysctrl R9A06G032_HCLK_USBH>,
> > +				 <&sysctrl R9A06G032_HCLK_USBPM>,
> > +				 <&sysctrl R9A06G032_CLK_PCI_USB>;
> > +			clock-names = "hclk_usbh", "hclk_usbpm", "clk_pci_usb";
> > +			reg = <0x40030000 0xc00>,
> > +			      <0x40020000 0x1100>;
> > +			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> > +			status = "disabled";
> > +
> > +			bus-range = <0 0>;
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +			#interrupt-cells = <1>;
> 
>    Really? I don't think this PCI bridge is also an interrupt controller...

'interrupt-map' depends on '#interrupt-cells'.

> 
> > +			ranges = <0x02000000 0 0x40020000 0x40020000 0 0x00010000>;
> > +			/* Should map all possible DDR as inbound ranges, but
> > +			 * the IP only supports a 256MB, 512MB, or 1GB window.
> > +			 * flags, PCI addr (64-bit), CPU addr, PCI size (64-bit)
> > +			 */
> > +			dma-ranges = <0x42000000 0 0x80000000 0x80000000 0 0x40000000>;
> > +			interrupt-map-mask = <0xf800 0 0 0x7>;
> > +			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
> > +					 0x0800 0 0 1 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
> > +					 0x1000 0 0 2 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> > +		};
> >  	};
> >  
> >  	timer {
> 
> MBR, Sergey
