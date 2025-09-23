Return-Path: <linux-pci+bounces-36793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C4EB970F3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D253BA44C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35638280025;
	Tue, 23 Sep 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDm0ReiT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD927FD62
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649256; cv=none; b=uCmA73gycB7MLpdGXfE4DTFaC6Im2pN6waMBcTOogSlpudy0VBQ7LIISfyaWONyL2VNVSICkukUU6A4MOiYuGL2ZvyrWq5BBTfG/pDA1bpKtY9+aW4wT1EAGBmPb77iSXZgT51L/l7tu519jIA8Zp5099/a6oyOpXKhJ3K0egmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649256; c=relaxed/simple;
	bh=gnYeGB2B1v903Xtz4VVWD8MoJQwc4kIonn9k6NGquuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVFMCFYCPqQvTWO6ArwvQNJUwO9+j+4o+23BY7uk96+1ENoJgNDc7kuc/GbnPJzKdzPO7GMjyj/J6kOKjviE4CaZ72lEUsbk6FHz4KexUjpByij7dYLCenFm7C7gxbLmDqwM2JmpyVilKAbZyFw1T3J97aSgeMJWz062vO3AyT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wDm0ReiT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so8208335a12.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 10:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758649252; x=1759254052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKpIP4JHqz6cG4UOF6o0Lt4gug+UcA+CBt0Oa3txFso=;
        b=wDm0ReiT0JO33GRnQsUmiItMDDpOTtlKqwY9GjFzmuoUNUWXlbGD2CboD23oAm5VTD
         geImEzahHyJH0HF9h/74NVN2TAJkWHBK64r1P5Z0mv/HHSyMQu0ZJKpVy13NKwGH+z3Z
         5URL+Xdex3XiH+cO9VxhNfafppqkVmIvaYAUBXUUrTDpyRNPM1HxMjLbm8GpDMnzf0mA
         6jM1475eDg24yW1NWFRXizXCKqScxB5AKA0x0VQH/oH3YEldsdkR7CI5GCyeLulThbEF
         F5Qu5qUwLg5uW15wI6bG+gny1kioeFU6GvK4sUksb9p1V36V2EPucHaw25HSw26AP+6l
         ytlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649252; x=1759254052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKpIP4JHqz6cG4UOF6o0Lt4gug+UcA+CBt0Oa3txFso=;
        b=UI4gz4smkbwVLCs3SrlCFZem/36sn62hAIu9BryD3SSbZwRiOPuwrwEn0cTq8l+5w4
         1wI8lBulzlGOYE5TJTH9nI+qeCrabcrOlZE9Ogxa0R2R9aW+WHcpeFVlGwh/dpbXNGiX
         IKP+9P8Gg82stIOBQ7XSUIK4lgh3u4IIhgNaPe34ix28PBI2ClenYG4KcWpLQ+scp/1+
         o7282YFqR4Ngc1aoyBUy9Uunj2za5lMqUG/wpPg81Ehu6JcXKmTMQpBLKfObkNn8zl/P
         b0weogdossN3BA4nCnV7mZJWz9YgFUbQZWM8Tq1xDCuiLrSAPnA73PfMyhgE7F8trDPn
         2+cQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1LhtqPAjGRel+2Gj1oqAkz91BJySswsIj5rHBeIdKNKKMOn2+VKaclwhqtEshqxeR4qPNzbdZ6CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGOVEjGy0oRugR2S75K9ksQjvoIBnbr1kF/oU9BLX2Bn8g9Gxs
	tC7LighCO/WkLpfFhy9iUlC5/71CtYmMi3FDa67QqiF7ElpcIruyYDa4dM6wUjnUtl4xm7ddBk/
	NPktS9y5o4dL61sbXkqicuIZ5T/ZfXrgkMc0s1rK7hA==
X-Gm-Gg: ASbGncvjSyNTqxle6Xm+8ZnOnLECJYz2+Ln4tkxWyDb8wABMBKRoN53K+hiXexEGgXD
	YJ42Q9gaSxgvEBUb1of8Pp6+lb7gPT5yBYhNxB7nDfOXrUoFvpVGviElbqd6t4QfLmy6boqcZxz
	fjHD8m+IhHXA8GDAb4ZnUdlwM089d/glVVpyC9sfndTmDSitTgszmy9kDis2m7fA6wN0QWS6/BG
	UDcVbKX9jR7stwoH+8t4IoEDUMwsYT9HI7Q
X-Google-Smtp-Source: AGHT+IGKj6Y7Rbxbcuv/p78PYY4VhOn0VuHWkuzF4bBzMgRnn4BUqA5lXuES789K8QEVi7gDnX95FchYWyP/N+Yb7J4=
X-Received: by 2002:a05:6402:42d4:b0:634:66c8:9e6d with SMTP id
 4fb4d7f45d1cf-63467a196c6mr3151558a12.35.1758649252279; Tue, 23 Sep 2025
 10:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org> <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>
In-Reply-To: <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 23 Sep 2025 19:40:40 +0200
X-Gm-Features: AS18NWBNIKbQJlsVTlHAuM-w_iiTyLoHRH4gz5lC-pFfTqvjXuoI-RD55es6jyQ
Message-ID: <CAKfTPtD2MH9_xT+Fq4vvpGNMJPSkwh3CMaVCLRcNxrn_Ab7eLQ@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
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

On Mon, 22 Sept 2025 at 08:21, Manivannan Sadhasivam <mani@kernel.org> wrot=
e:
>
> On Fri, Sep 19, 2025 at 05:58:19PM +0200, Vincent Guittot wrote:
> > Describe the PCIe controller available on the S32G platforms.
> >
>
> You should mention that this binding is for the controller operating in '=
Root
> Complex' mode.
>
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
> >  .../devicetree/bindings/pci/nxp,s32-pcie.yaml | 131 ++++++++++++++++++
> >  1 file changed, 131 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32-pcie.=
yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml b/=
Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> > new file mode 100644
> > index 000000000000..cabb8b86c042
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> > @@ -0,0 +1,131 @@
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
> > +  The S32G SoC family has two PCIe controllers, which can be configure=
d as
> > +  either Root Complex or Endpoint.
> > +
>
> But this binding is going to cover only the 'Root Complex' mode, isn't it=
?

I was planning to add the endpoint in the same file as the hardware
description remains the same between RC and EP but only the use of the
HW is different. But it looks like I have to separate binding for RC
and endpoint

>
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
> > +    maxItems: 8
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: link-req-stat
> > +      - const: dma
> > +      - const: msi
> > +      - const: phy-link-down
> > +      - const: phy-link-up
> > +      - const: misc
> > +      - const: pcs
> > +      - const: tlp-req-no-comp
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
> > +allOf:
> > +  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
> > +  - $ref: /schemas/pci/pci-bus.yaml#
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
> > +                  /*
> > +                   * RC configuration space, 4KB each for cfg0 and cfg=
1
> > +                   * at the end of the outbound memory map
> > +                   */
> > +                  <0x5f 0xffffe000 0x0 0x00002000>,
> > +                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr spa=
ce */
> > +            reg-names =3D "dbi", "dbi2", "atu", "dma", "ctrl",
> > +                        "config", "addr_space";
> > +            dma-coherent;
> > +            #address-cells =3D <3>;
> > +            #size-cells =3D <2>;
> > +            device_type =3D "pci";
> > +            ranges =3D
> > +                  /*
> > +                   * downstream I/O, 64KB and aligned naturally just
> > +                   * before the config space to minimize fragmentation
> > +                   */
> > +                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x000=
10000>,
>
> s/0x81000000/0x01000000
>
> since the 'relocatable' is irrelevant.
>
> > +                  /*
> > +                   * non-prefetchable memory, with best case size and
> > +                   * alignment
> > +                   */
> > +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfff=
e0000>;
>
> s/0x82000000/0x02000000
>
> And the PCI address really starts from 0x00000000? I don't think so.

I'm going to check why they set this value



>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

