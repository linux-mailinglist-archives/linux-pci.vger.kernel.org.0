Return-Path: <linux-pci+bounces-40468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1711DC3988B
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 09:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 553584FA8F2
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AE63002B7;
	Thu,  6 Nov 2025 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvYySyMu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5412B3002D1
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416556; cv=none; b=FeRN6FM1KhTdGbxPAAZ46Rbx7uLcrrrCGJGV+oGa9GDGynDo4LwNvNhl04ym/I00bixEFbkhVYex7hMhVDa0bogXeOoOkMnwB8pBhKNt7upcFN3bAQcKtZWVXB6X7cVW3p+GRyRbyphVwD8/gdAl+b21KXw672nBf+hE+q0FdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416556; c=relaxed/simple;
	bh=lRfiaPilGCbrJdjqrBIGDPtcN225cI7Hh21G5/DO+Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taSxH+8YF1114Y/QXGDoPz6kgLM6ZoFKxpSRswO1vrFqbgE7fW1b78Eun0u+xGsakqZlE9fhzah5o1kxT9/fIrnuv2+BrZ++2lmgxZc7LaUsnXmOC0xe9gNXO6l6IudoiBex2KkoK8D/RyeyNWIpoBHG4sDEwkXWFZYlNtR1wFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NvYySyMu; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640741cdda7so895662a12.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 00:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762416553; x=1763021353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqG4Vhl3gJVR6ZhqmKUIStjnvxpVzC8nlU32UMscO8w=;
        b=NvYySyMuRQQ2XjjjuqY+FhQl1fDeGxv2W9ykGPjf49sMdooflSZhikY/BsSyjgRyY2
         B41A092sTC5rqpSzbbymPoEL9zfSMHZlun719XL8pjn6CEyb5m0r5FOgeg8gpy+0eb++
         s79zrf0X59MWpaFxMNn2HD+xE6V0KA4K/gc2X/R7LwIJbnjZodvcs/MSQNATmrV1BOAL
         FjcdDkmMSN52Ywfzsy5AWdl2jEAsaWkCTLAwT9rxtKR3/boQHlUtC/cEKF12DwQdtF7K
         jveM3IVh8x3kfkknev0xxeGotnlrT9MAZDkgLdUmNgHTjLhLaAdUw1CXfhe1RaszMRmO
         +I6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416553; x=1763021353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqG4Vhl3gJVR6ZhqmKUIStjnvxpVzC8nlU32UMscO8w=;
        b=BFMzWqXDc7kKcoKq+Fuqq5bvJ88mtGcejdSru03Pmbe9QAJ0P3RVEFl66yyD0ezr1j
         GGPeKCaanYEJRsXMtOQBL3Ooui7j/gcalqbjWt+I6qGZZHMaDe7qaRrDpTIv/fxh+I4p
         2LV1568q01RR+7lZnaXI9wSeqKC1e4IF5YB2OL7NXWoHD4mSLAqpK3+iiOemq68+GZOV
         USS19NYDRVUO0ouQYzD5TldDesQ95t6xzkq7O9DeLN+OJxItWsgEIsYRIbS+c2DfzyU7
         UfuBmrSUvZQ6MgiovPTf+VbZ8a4jMtl2It3D+GBak0DSHOi/Pz7g6jrAazIe7dSDHfXZ
         6XBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6Nx6FjKMdN7G+RsEc5cGd54jMIJkE+jO7ZMZyb1l39p8PgccigTJ5JvRHFck6yUEB591S+lkZqaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7O6O5ev5JvYAYjg/WD+kx2L5JQ75mmGgK9jhr+z5Sj9ddh1wQ
	vjKLZu7plDAg8qvQTkbQMfQ/LcawekprKCUH9BINtAWaE16uqHvtox2vREp81YE/Lo2rj/OYZw7
	mxrexYHrS+0zuJFG5QgsPXAPq+KseI9fp6fG8AeLj/Q==
X-Gm-Gg: ASbGncuyhFHWyHhwdpBTXqj5x3kOrXvvkweYm61Ljn9r0gHTxXMcH89SV5odmlFy99R
	RKQf1gqSK1CG7yFMsrMOpuQp2FsdSHfJdSnhGyghEFQ4hlxcR7A34xEuqH3G2fYyLwwqyiOyy8d
	4agGgpCoydIEIcNYJxzBBqthWBVYWyco+Gz4IZ0bgDP+RehZyuLVkxeTzFvrlyMgTtJ8fFnzNcd
	oO95yF9MxBF4Th2my5hgrNhHB/yPG5YdliXt1Zd2SBLVXYRn4LPOpt1mrdsBD2wrajTCjQz
X-Google-Smtp-Source: AGHT+IFpGXTLSElm/iJX28AkNKWJysbi+VSdMAhhXx+DpEVvXomYFy1/eZ4xIzIhBa3g0OBlHb0wiAGdwqeYIeUCjdY=
X-Received: by 2002:a05:6402:3508:b0:640:c779:909 with SMTP id
 4fb4d7f45d1cf-64105a5c833mr5111127a12.27.1762416552602; Thu, 06 Nov 2025
 00:09:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022174309.1180931-1-vincent.guittot@linaro.org>
 <20251022174309.1180931-2-vincent.guittot@linaro.org> <6k5zdhbhtqg2dghdm2bkbymr5rwzcowziaahfdvgw4dk22y43y@npsrperinzue>
In-Reply-To: <6k5zdhbhtqg2dghdm2bkbymr5rwzcowziaahfdvgw4dk22y43y@npsrperinzue>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 6 Nov 2025 09:09:01 +0100
X-Gm-Features: AWmQ_blssT-7N0Jk7hsjbSupnpo_HEbqq26DIoOJgn8hufRZY427ml3fisK5oFk
Message-ID: <CAKfTPtC87w7RVSDAXWXRX1sjgo4s=_Z_k62+mfTXrMZwmkEpFg@mail.gmail.com>
Subject: Re: [PATCH 1/4 v3] dt-bindings: PCI: s32g: Add NXP PCIe controller
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Nov 2025 at 08:12, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> On Wed, Oct 22, 2025 at 07:43:06PM +0200, Vincent Guittot wrote:
> > Describe the PCIe host controller available on the S32G platforms.
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
> >  .../bindings/pci/nxp,s32g-pcie.yaml           | 102 ++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie=
.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b=
/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> > new file mode 100644
> > index 000000000000..2d8f7ad67651
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> > @@ -0,0 +1,102 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/nxp,s32g-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP S32G2xxx/S32G3xxx PCIe Root Complex controller
> > +
> > +maintainers:
> > +  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > +  - Ionut Vicovan <ionut.vicovan@nxp.com>
> > +
> > +description:
> > +  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
> > +  The S32G SoC family has two PCIe controllers, which can be configure=
d as
> > +  either Root Complex or Endpoint.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - nxp,s32g2-pcie
> > +      - items:
> > +          - const: nxp,s32g3-pcie
> > +          - const: nxp,s32g2-pcie
> > +
> > +  reg:
> > +    maxItems: 6
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: dbi2
> > +      - const: atu
> > +      - const: dma
> > +      - const: ctrl
> > +      - const: config
> > +
> > +  interrupts:
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: dma
> > +      - const: msi
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - ranges
> > +  - phys
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/phy/phy.h>
> > +
> > +    bus {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        pcie@40400000 {
> > +            compatible =3D "nxp,s32g3-pcie",
> > +                         "nxp,s32g2-pcie";
> > +            reg =3D <0x00 0x40400000 0x0 0x00001000>,   /* dbi registe=
rs */
> > +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 register=
s */
> > +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers=
 */
> > +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers=
 */
> > +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl register=
s */
> > +                  <0x5f 0xffffe000 0x0 0x00002000>;  /* config space *=
/
> > +            reg-names =3D "dbi", "dbi2", "atu", "dma", "ctrl", "config=
";
> > +            dma-coherent;
> > +            #address-cells =3D <3>;
> > +            #size-cells =3D <2>;
> > +            device_type =3D "pci";
> > +            ranges =3D
> > +                     <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x=
00010000>,
> > +                     <0x82000000 0x0 0x00000000 0x58 0x00000000 0x0 0x=
80000000>,
> > +                     <0x82000000 0x1 0x00000000 0x59 0x00000000 0x6 0x=
fffe0000>;
> > +
> > +            bus-range =3D <0x0 0xff>;
> > +            interrupts =3D <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names =3D "dma", "msi";
> > +            #interrupt-cells =3D <1>;
> > +            interrupt-map-mask =3D <0 0 0 0x7>;
> > +            interrupt-map =3D <0 0 0 1 &gic 0 0 GIC_SPI 128 IRQ_TYPE_L=
EVEL_HIGH>,
> > +                            <0 0 0 2 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEV=
EL_HIGH>,
> > +                            <0 0 0 3 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEV=
EL_HIGH>,
> > +                            <0 0 0 4 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEV=
EL_HIGH>;
> > +
> > +            phys =3D <&serdes0 PHY_TYPE_PCIE 0 0>;
>
> PHY is a Root Port specific resource, not Root Complex. So it should be m=
oved to
> the Root Port node and the controller driver should parse the Root Port n=
ode and
> control PHY. Most of the existing platforms still specify PHY and other R=
oot
> Port properties in controller node, but they are wrong.

Yeah, we had similar discussion on v1 and as designware core code
doesn't support it, the goal was to follow other implementations until
designware core is able to parse root port nodes.
I can add a root port node for the phy and parse it in s32 probe
function but then If I need to restrict the number of lane to 1
instead of the default 2 with num-lanes then I have to put it the
controller node otherwise designware core node will not get it.



>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

