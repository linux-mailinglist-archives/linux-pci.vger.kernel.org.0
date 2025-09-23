Return-Path: <linux-pci+bounces-36779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E51B96668
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 16:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A787A3828
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E152561A2;
	Tue, 23 Sep 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPEC+jtD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9EF1F1534
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638968; cv=none; b=OQtr5oPSDSfBKhCw1+B0Nl8HdtTIcG8S1iq5FDLpr0m/SoYz+SPhuAspTKF+xDEdViyR+YV5d96z28G8RHE3rnXvKVYbHFui7kZz8f1Dc8waYib+Mv0pNKs5uz0hOCTLzjFJGPggCXRPN8dwbU8uGTMuWN24h0dwoL6p/LEzRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638968; c=relaxed/simple;
	bh=ic044369QqtidAh8yfSu/u+g2qCbcTn5nkvJ11LGmK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9Fy4UiB2133x50SlBteugRrZwYF6P/MWymvWDTogKSRhKqD0puj9mu6X/atukQKgje8tOu9muDPt2gW0VsAw06t3cu0dmoOfd9DbMlaJhP7IbB/mmgnFowBiH/LLzM7njJFsbBWtCTXro10n1Q65hUM9XoOx4tIU0T/1mF8ycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TPEC+jtD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b2e66a300cbso350523466b.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758638965; x=1759243765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y52Xkcdn7xk0ZUxLnhD94pTmXLnFSczNPfuhX4p80MM=;
        b=TPEC+jtDInGq1C+bY8wOuS4f4GXhBr/bb/fxzoiOzx/9zFfNIhZUPPeJMdDJvRZh57
         wRZYGqL8Dte/0r/US7ULXs95k7lKwA4W1sY7SSxni7Cz9bYkNO7Q2uGhuySael2pL5sF
         VCQPjQ9PyYcypiqbgEzgVpcQD+XzI/lasBAZ82bvhvL0ABDMcS99gZefPyZGE27VvFRe
         xa5CSuzp0xToPzzOMUYjLt/O9GNZ4Xv1Jh4bdYdUexI4ALoith6Hxp9UNIxf6EY/KGv/
         PNaQmAXMR+vkh7jchkbZPGjXdKunqt4WZYgN4zexr5PlugNdJAGWD2sLC82lYenqGGa4
         PfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638965; x=1759243765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y52Xkcdn7xk0ZUxLnhD94pTmXLnFSczNPfuhX4p80MM=;
        b=kfXYaW8mYGKOGBV3POpGy9iFj4qGSt3vpjg5pIrPGxtR/6/VyTF0pTW9lKbFksRRWl
         3vhcLOXnyUxdcjhpnb0q15fVg1w9yBXVW9XG6QGtjgdMowlrsRfAAwa/vZzH6/2rWZj/
         gBoezUfKFca/4OLu6hvAtHEmzJoBKfMS7wvSOSYOK1vUmvqvfNHvX796HhC+IXdVcB59
         5m5el3vE5bTEBU7hazYmbwtWVUaCH6zUrVGUPBCeD1KO+Ps5wNOx11lJGTsL4RvhVr5r
         yfM4NYniCN3Ugt2gFwmrEdlHrV7Imte7f40TnEjho0jff1bRWJWKgoPocmUhahh5mCMT
         DAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu3XlTJOnOU81chYjkVftJFKM1tuhXuDpQYrxRFkT8FFzMUVQkQB/SPW9RaUyAZvz9t5lS2DfG6Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAJ77jTIw0BzuR9aSVMKvkmir036DwMkMHkgfMLrMGTggQa+pO
	Givc4dO/1dnoRbQHX0S6Zejg79yPjlGJRYttt01r0Vjpa50dXBM2T1k1dnTrjKkLbiNdStzZOD8
	VFoqxIqJAZsWrPtXXcEGsrR0rxFNqreboOWfTxsAjCQ==
X-Gm-Gg: ASbGncvBd/6czD96Lg1ZEFCJTSOWgZQS6u+4hDQqsbYb5PTaqhd5nvvI3xxVpphnvm9
	MJjz+nkRJsU+gxbz6ogQQmJwUbOoPCiQ15Ym0CZiOhUMk6plgvgHhRk2NEqBW1OE9jZaWUD3PMN
	34E7dIwSmvc4333eFQWjDxtYH5i8pR0UkWLW8cp+9VWL4D8vSgnALNNVRh5JhG0OejdCDJtulsu
	nIu2aZawhvs9YDW9VwD88hMVVK2yCGZJjpw
X-Google-Smtp-Source: AGHT+IECKT9YZPD+FAdye+FerjTbLGMGSvvRtZ+Pjo4XFET+bb/b/phi396gjsk4a+Gepk9kfKc2SZh1oT+jOw9HvrM=
X-Received: by 2002:a17:907:6d03:b0:b04:2533:e8dd with SMTP id
 a640c23a62f3a-b302d29ad94mr253112266b.60.1758638964984; Tue, 23 Sep 2025
 07:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org> <aM2HMOvksD0kSd1u@lizhi-Precision-Tower-5810>
In-Reply-To: <aM2HMOvksD0kSd1u@lizhi-Precision-Tower-5810>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 23 Sep 2025 16:49:13 +0200
X-Gm-Features: AS18NWBnvH3cHGC78xNej_-VaL44m5KxupJlVq-5uA_Jq-oxSoNspDlHAQbMDqk
Message-ID: <CAKfTPtDadioUFDn2F5gJ59tYJD2owVZMZs9TNUBHk-2uuz0GmQ@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
To: Frank Li <Frank.li@nxp.com>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Sept 2025 at 18:39, Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Sep 19, 2025 at 05:58:19PM +0200, Vincent Guittot wrote:
> > Describe the PCIe controller available on the S32G platforms.
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
> ...
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
>
> why not snps,dw-pcie.yaml?

dt binding check reports a number errors and warnings with snps,dw-pcie.yaml.
In addition to the reg and irq names which I can't all map on the
snps,dw-pcie.yaml, it reports unevaluated properties which I don't
have with schemas/pci/pci-bus.yaml



>
> Frank
> > +
> > +unevaluatedProperties: false
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
> > +        pcie@40400000 {
> > +            compatible = "nxp,s32g3-pcie",
> > +                         "nxp,s32g2-pcie";
> > +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> > +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> > +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> > +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> > +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> > +                  /*
> > +                   * RC configuration space, 4KB each for cfg0 and cfg1
> > +                   * at the end of the outbound memory map
> > +                   */
> > +                  <0x5f 0xffffe000 0x0 0x00002000>,
> > +                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
> > +            reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
> > +                        "config", "addr_space";
> > +            dma-coherent;
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +            device_type = "pci";
> > +            ranges =
> > +                  /*
> > +                   * downstream I/O, 64KB and aligned naturally just
> > +                   * before the config space to minimize fragmentation
> > +                   */
> > +                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> > +                  /*
> > +                   * non-prefetchable memory, with best case size and
> > +                   * alignment
> > +                   */
> > +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> > +
> > +            bus-range = <0x0 0xff>;
> > +            interrupts =  <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names = "link-req-stat", "dma", "msi",
> > +                              "phy-link-down", "phy-link-up", "misc",
> > +                              "pcs", "tlp-req-no-comp";
> > +            #interrupt-cells = <1>;
> > +            interrupt-map-mask = <0 0 0 0x7>;
> > +            interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <0 0 0 2 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <0 0 0 3 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <0 0 0 4 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +            phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > +        };
> > +    };
> > --
> > 2.43.0
> >

