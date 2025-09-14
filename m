Return-Path: <linux-pci+bounces-36097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A797B568A2
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 14:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149543B3F11
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DF02376F8;
	Sun, 14 Sep 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dO4mM1Z7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A2260580
	for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853300; cv=none; b=LYbUgWdOQZR/3Vhp7kFo0kfrD26tGEQO7KrL1jLDt2N5ho9R7G/qRcyRKBfqCw32zCsrxG49bRU0zKNJ6oufVwE0uStQ5Ica7Ayqd80eHgmga8o8rFKvDlON1E3tnRn/R1HM9oYKr2zOT/s42ZoEx9FUWK+LKmK62T/1jDYm9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853300; c=relaxed/simple;
	bh=fRxf354j9p5dLkCyRRpVnIzv7RmHa2wj/7G8YB2Kzos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIsk1juAsuqKBcmKKGClCKGOUQfQNzR105LxC6ivSYEfNcRm7EOFi91YP1kQQphh5PkW4DWknjZG5lfb/cHqrhQqFuukkvfeumMOZIs8VpZ8goDamfKZeElRrhQxaNZ1G1mhyDlP7AaUc1Ciiq+N0ObaVUHRZ2vf5Qn3WWA0muY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dO4mM1Z7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07c38680b3so339720666b.1
        for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 05:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757853297; x=1758458097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6My8g8ijlC6ggM3Nx6OmXgJVfqUSxwxL444mCRnJ11g=;
        b=dO4mM1Z7bieQEVV9pvJtiYB1n2s3M0sxuhEiKCi0QlhfFt6rOlNCbu1upgPSxukMyt
         00ZEN6lV6ryAfyb30zprRNm/OwvDldlBEcNfCtj4BWvoE0J3/xB+C9S+sp9i1dWYEgTx
         VdLgVaDbQYSuT/lQ//Hj15xByBHE/070bIskFk3z757O68AbtbmZuUbnui+VncOEm911
         7yeWSQzI7TdNEH5zKev5RS7RDQRzs/9A6Rvw0lo4m/8F++54wChp62Wa2AdTa6qjhdVE
         ZzahHFCd5IqzeSVACdZPSasIE609mg8wpHUIBhBiFYr+EKYNhmyu3FlLvyhNbJXyM8Cf
         EJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757853297; x=1758458097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6My8g8ijlC6ggM3Nx6OmXgJVfqUSxwxL444mCRnJ11g=;
        b=wQXTHQMPZjbJF1B/bHHUo24OwZjBKbEo6LJTfn5XHPAwkWg4PqH9V1X43Y8EYP4awP
         vKtdWb8iaAghHeuIUetsQ85WyPorCoIyumTwS75vH85P9lUdiaWEswH6v0qqdpIYB7C9
         yi7m/wNEiasGrsu/gcSLGO49Q847ASO6kSI+KxXIjr5dkQOeW2UMsIRC85cY23A3Knac
         v917nUVRBwhbdEPr2ehx9a8GcUNJUdxprfT4axrrPf02Ceyqu4WhhWBJ4iAnTnZaguYR
         7+nc8n92JaoP2Dnb8Df+Y3zA64QfeYzHy8sYEZzK4wzvAEKClGTMzqT9j3hUg1kLzg9E
         em0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWspHYmdcVR1/sKOl40/d1uT6cugtwZglspnkxz6zxbxlm2rsS8w1V2vYqhV2twi44yRhwetiqyTUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUBUss+Km4e3xGqkLk8W70YkmT/gZ1aFz2fuIHAQoHzx80duo6
	2HBntcAzHRJM1s+abHCOX/A63+EUtKKk9iYQXS6KydtYrAQdBWIJJnt52vzufn9lKXXCbCPAP7v
	sYHXQy0tu8m65tIzIeNXiZcQ2mkhfi0baTK6n72Z3YQ==
X-Gm-Gg: ASbGncvNMWELeDKmKIxcvtI60WU7BSbk/fajiceTZQPGpY/Ks5slxpRyznUol+zbciW
	Joxs7UUuL3A0KhzmUlce5FnbDMfTarQgbsf/lXWKUnrkDoxDcVAUwr/S4jGMNVQjXdLa2QCD/aK
	zJ6HeK8wehfQf9Yja593ucsTFXHgg2MhGAbAPuUKs6Bb8T3AOKaRWHTSExP+Q5eKqDFkJjLbTsY
	iqCSHIHZkyIOcj3vxY8sP3OUu8p5c1QvVM1zXEHMsIxhtw=
X-Google-Smtp-Source: AGHT+IE9iMZLipi8SbmYOlVHFkjWHvFeGW1GqsUB94IHXcDFtD/+YhZqBpHxrpl4wzzT0r2J3Pq8q72gpM+PxQoXhrE=
X-Received: by 2002:a17:907:7f87:b0:b0e:d477:4961 with SMTP id
 a640c23a62f3a-b0ed477740fmr113747966b.23.1757853296988; Sun, 14 Sep 2025
 05:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912141436.2347852-1-vincent.guittot@linaro.org>
 <20250912141436.2347852-2-vincent.guittot@linaro.org> <aMSHsoLHGUBoWX8e@lizhi-Precision-Tower-5810>
In-Reply-To: <aMSHsoLHGUBoWX8e@lizhi-Precision-Tower-5810>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 14 Sep 2025 14:34:44 +0200
X-Gm-Features: Ac12FXyj3Q4Ir_GGRHAULDx1O8xgannDkGizhiAuLvket8uRGtmjSHnXquF9Gho
Message-ID: <CAKfTPtBh3jvEQF09sL8g7Zeru+WvtQO31UFZEZDx1DYJ8RCK3w@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
To: Frank Li <Frank.li@nxp.com>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 22:51, Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> > Describe the PCIe controller available on the S32G platforms.
>
> can you cc imx@lists.linux.dev next time? suppose most part is similar with
> imx and layerscape chips.

Ok will do

>
> >
> > Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> > Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> > Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  .../devicetree/bindings/pci/nxp,s32-pcie.yaml | 169 ++++++++++++++++++
> >  1 file changed, 169 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> > new file mode 100644
> > index 000000000000..287596d7162d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> > @@ -0,0 +1,169 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/nxp,s32-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP S32G2xx/S32G3xx PCIe controller
> > +
> > +maintainers:
> > +  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > +  - Ionut Vicovan <ionut.vicovan@nxp.com>
> > +
> > +description:
> > +  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
> > +  The S32G SoC family has two PCIe controllers, which can be configured as
> > +  either Root Complex or End Point.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - nxp,s32g2-pcie     # S32G2 SoCs RC mode
> > +      - items:
> > +          - const: nxp,s32g3-pcie
> > +          - const: nxp,s32g2-pcie
> > +
> > +  reg:
> > +    minItems: 7
>
> If minItems is the same maxItems, needn't minItems.

Ok, I didn't know that

>
> > +    maxItems: 7
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: dbi2
> > +      - const: atu
> > +      - const: dma
> > +      - const: ctrl
> > +      - const: config
> > +      - const: addr_space
> > +
> > +  interrupts:
> > +    minItems: 8
> > +    maxItems: 8
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: link_req_stat
> > +      - const: dma
> > +      - const: msi
> > +      - const: phy_link_down
> > +      - const: phy_link_up
> > +      - const: misc
> > +      - const: pcs
> > +      - const: tlp_req_no_comp
>
> use - for names

Yes, I forgot to change this

>
> > +
> > +  msi-parent:
> > +    description:
> > +      Use this option to reference the GIC controller node which will
> > +      handle the MSIs. This property can be used only in Root Complex mode.
> > +      The msi-parent node must be declared as "msi-controller" and the list of
> > +      available SPIs that can be used must be declared using "mbi-ranges".
> > +      If "msi-parent" is not present in the PCIe node, MSIs will be handled
> > +      by iMSI-RX -Integrated MSI Receiver [AXI Bridge]-, an integrated
> > +      MSI reception module in the PCIe controller's AXI Bridge which
> > +      detects and terminates inbound MSI requests (received on the RX wire).
> > +      These MSIs no longer appear on the AXI bus, instead a hard-wired
> > +      interrupt is raised, documented as "DSP AXI MSI Interrupt" in the SoC
> > +      Reference Manual.
>
> Don't need description for this common property.
>
> msi-parent for pcie devices is most likely wrong. It should use msi-map.

Ok, I'm going to have a look.

>
> > +
> > +  nxp,phy-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: Select PHY mode for PCIe controller
> > +    enum:
> > +      - crns  # Common Reference Clock, No Spread Spectrum
> > +      - crss  # Common Reference Clock, Spread Spectrum
> > +      - srns  # Separate reference Clock, No Spread Spectrum
> > +      - sris  # Separate Reference Clock, Independent Spread Spectrum
> > +
> > +  max-link-speed:
> > +    description:
> > +      The max link speed is normaly Gen3, but can be enforced to a lower value
> > +      in case of special limitations.
>
> needn't description here.

ok

>
> > +    maximum: 3
> > +
> > +  num-lanes:
> > +    description:
> > +      Max bus width (1 or 2); it is the number of physical lanes
>
> needn't description here.

ok

>
> > +    minimum: 1
> > +    maximum: 2
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - ranges
> > +  - nxp,phy-mode
> > +  - num-lanes
> > +  - phys
> > +
> > +additionalProperties: true
>
> unevaluatedProperties: false
>
> because you refs to /schemas/pci/snps,dw-pcie-common.yaml
>
> You can send to me do internal review before you post to upstream.

ok, thanks

>
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/phy/phy.h>
> > +
> > +    bus {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        pcie0: pcie@40400000 {
>
> Needn't label "pcie0"

ok

>
> > +            compatible = "nxp,s32g3-pcie",
> > +                         "nxp,s32g2-pcie";
> > +            dma-coherent;
> > +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> > +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> > +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> > +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> > +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> > +                  /* RC configuration space, 4KB each for cfg0 and cfg1
> > +                   * at the end of the outbound memory map
> > +                   */
> > +                  <0x5f 0xffffe000 0x0 0x00002000>,
> > +                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
> > +                  reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
> > +                              "config", "addr_space";
> > +                  #address-cells = <3>;
> > +                  #size-cells = <2>;
> > +                  device_type = "pci";
> > +                  ranges =
> > +                  /* downstream I/O, 64KB and aligned naturally just
> > +                   * before the config space to minimize fragmentation
> > +                   */
> > +                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> > +                  /* non-prefetchable memory, with best case size and
> > +                  * alignment
> > +                   */
> > +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> > +
> > +                  nxp,phy-mode = "crns";
> > +                  bus-range = <0x0 0xff>;
> > +                  interrupts =  <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> > +                  interrupt-names = "link_req_stat", "dma", "msi",
> > +                                    "phy_link_down", "phy_link_up", "misc",
> > +                                    "pcs", "tlp_req_no_comp";
> > +                  #interrupt-cells = <1>;
> > +                  interrupt-map-mask = <0 0 0 0x7>;
> > +                  interrupt-map = <0 0 0 1 &gic 0 0 0 128 4>,
> > +                                  <0 0 0 2 &gic 0 0 0 129 4>,
> > +                                  <0 0 0 3 &gic 0 0 0 130 4>,
> > +                                  <0 0 0 4 &gic 0 0 0 131 4>;
>
> use pre define macro
>
> <0 0 0 1 &gic GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,

yes

>
> > +                  msi-parent = <&gic>;
>
> Suppose it is wrong for pcie



>
> you should use msi-map
>
> Frank
> > +
> > +                  num-lanes = <2>;
> > +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > +        };
> > +    };
> > --
> > 2.43.0
> >

