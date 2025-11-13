Return-Path: <linux-pci+bounces-41090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 165A1C57EB2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 15:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A47C4EAB76
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001FE283129;
	Thu, 13 Nov 2025 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKPoZDzj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55A926D4DD
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043561; cv=none; b=VMsCGd2lbyexsHaWhw0HBA8unk9bRS+LprOdsF4xie6lp8Wkv1OBvYKPd6f0RqOXTJCVAAr5dUQoAN3Ssi2duLItGWCkHP1Ox6+F1+VAZR4xlj+R3iReCDZ+UafS7mXwq+j1OgZFwNQFIKNegBl5XNGJgjmLLz8/UK9xrIfRuPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043561; c=relaxed/simple;
	bh=+60GxZqo7W68nBsBK+4RC1waiWGLnIxNTQPjNx2YCXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wdd0H2wcy3vmlb95v3BJPTK6Q4f6iEu1BEfqBtUe3evGMMdZELB2Pd1hxOJdGj+zUKNkazugi7eMnIaJsXvyHusML4lLcSu0hGVl1E8Dwfml3Mrnirf3jkLm4+5lilSRncBy5688O95+Vfaa7JQH982ogdgMgB33OEFfNl0FEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HKPoZDzj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so1445215a12.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 06:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763043558; x=1763648358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8gGk2esZ3TPP+U/Xv/QDaG4ohk1EPYMCao+ua5Ut7t0=;
        b=HKPoZDzjuucpsOnDVeeX5FEffNZmMkEhlZUPhNbufPgXC5bim6wpOygxs3qsKJOIHJ
         wAAMT8FZ2Zo/xn2Cp7pNHcDqfbtUq2T8+W81lsRmpBy6AAjYPHFHVfV+6y2wwYCxGoFU
         INo2jKqULR2PwHyeRV2G36PZnv1r2U17qcToy1s3gSRNsvSKBJL/VBMzpLyJCT9P8Hfm
         s/FnpM2JQu+lcRgugPqYBibi15c3j909O73bjmBPdR7ddIwrilS2d8KNJne3FYhvEgCO
         wdpZF4HYeas5hoFFpQbTcjLfNm+dKzg13JMYkzfvFG1Kb1gjo/bjYK5X/prLBvbIOQIt
         SVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763043558; x=1763648358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gGk2esZ3TPP+U/Xv/QDaG4ohk1EPYMCao+ua5Ut7t0=;
        b=IdxnGjcJHmyDAx/Mv7Jj/lEffUODXkoWkMKugIsGTYjVmocHyPYGCRiNkrGd3m2GjO
         vA07eKyy+SleQqG4QSjvFhwM6kZ0h1k8JpSS7lBg6KB8Zh4uobFfuZQzBrLIHRv8qJB1
         suTUgnlSnHNriDUZqF4FkD5C4uFhbiDkjrCYpxl5bzLJ3YNbKOFIIwTyNBQ8clxQRw3N
         4E2PgK5N0TXKSZ/eyV4lyK/kGXhswXXhh4mu6VEhh5rVQfTt423dmhDjAAjjzaxojKxk
         VGSOCG5kcU9X10cA6IJVYjXnjYrjlu2G/oTxYnu8Cd/gkc6mjoSEh283DWkPZkww+i9M
         XZIg==
X-Forwarded-Encrypted: i=1; AJvYcCWLr+GQJzHusZv8Dc7rvTq6dkluW2Pa3Hhq5EoOcEGR7zrHz8ESWWBm0gH08D72X2eXxQkLKu4unSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7PI8eKRZZj4YOumPgDwwcuFjqIwFLIGhXD1PL3qbFtrBeOM5p
	oRIy1Dxt0WOR9DDmvWYXuoO9jXPm8VAlaHxMWFtpqGkWSLqf8vQmuE2daPFtf5TGoaaCVxwAFVg
	YNijZBY3EFXhYc/Jddf+p4OUk4+2jxJC0gb6i2GNuzQ==
X-Gm-Gg: ASbGncvoay2UVz/FC58efgnO1bR9eoQly3MxAdsUXQH073L7Kg8+6vQq8YCw6he1nW7
	8kkSniVuORHQ2gAM32AFEvfhXwLXedpbkpTPCgSsZQkJPwMAXcgpzJpP3Umi+9wKm6PeIHLOlOv
	grn/fV7UuuBqRtvR4H/kuF/Px48WBAB8/j6LRU/bIwu7+luAERmZztUB37SzdVxqN+NP+dn8R0x
	7H5nfRAwOYbl2Ew5GjMXaUvg1vtmUKWq2KFfc+9YfuTJIEHJd0agSJLf/eWtJhRamggx91kLmIs
	xcqu7RYrA+hlFw==
X-Google-Smtp-Source: AGHT+IEk4ZuVDBz3u+9Uv4/zJfB1Emeu9cNMcz6aWafXiAHCM1K8SOZabMAhPk/X3XNWJIyPPXn256y5U9W+nbjKzzM=
X-Received: by 2002:a05:6402:27c6:b0:640:95e2:cd17 with SMTP id
 4fb4d7f45d1cf-6431a57e355mr5833525a12.36.1763043558031; Thu, 13 Nov 2025
 06:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110173334.234303-1-vincent.guittot@linaro.org>
 <20251110173334.234303-2-vincent.guittot@linaro.org> <aRIn1COnQG6Mz27j@lizhi-Precision-Tower-5810>
In-Reply-To: <aRIn1COnQG6Mz27j@lizhi-Precision-Tower-5810>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 13 Nov 2025 15:19:06 +0100
X-Gm-Features: AWmQ_bn4_FBV_0kJ1ugPYoCrbCQQh9T4qf5dxZ1Dk01YEW7NuCgTcJxJ5cXExLg
Message-ID: <CAKfTPtBT6qT2zC8toUOEFD_ZkJPBMJgZrZc2NCAFSUXANYJ==Q@mail.gmail.com>
Subject: Re: [PATCH 1/4 v4] dt-bindings: PCI: s32g: Add NXP PCIe controller
To: Frank Li <Frank.li@nxp.com>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Nov 2025 at 18:59, Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Nov 10, 2025 at 06:33:31PM +0100, Vincent Guittot wrote:
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
> >  .../bindings/pci/nxp,s32g-pcie.yaml           | 130 ++++++++++++++++++
> >  1 file changed, 130 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> > new file mode 100644
> > index 000000000000..6077c251c2cd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> > @@ -0,0 +1,130 @@
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
> > +  The S32G SoC family has two PCIe controllers, which can be configured as
> > +  either Root Complex or Endpoint.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
>
> Suggest move allOf after required, in case add if-else branch later.

okay
>
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
>
> Need match interrupt-names's restriction
>
>       minItems: 1
>       maxItems: 2

Yes

>
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: msi
> > +      - const: dma
> > +    minItems: 1
> > +
> ...
> > +
> > +        pcie@40400000 {
> > +            compatible = "nxp,s32g3-pcie",
> > +                         "nxp,s32g2-pcie";
>
> put to one line to save LOC.

Okay

>
> Frank
> > +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> > +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> > +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> > +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> > +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> > +                  <0x5f 0xffffe000 0x0 0x00002000>;   /* config space */
> ...
> > +            };
> > +        };
> > +    };
> > --
> > 2.43.0
> >

