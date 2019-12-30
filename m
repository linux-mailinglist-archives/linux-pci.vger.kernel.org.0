Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB63412D517
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 00:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfL3XaC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Dec 2019 18:30:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfL3XaC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Dec 2019 18:30:02 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 145242071E;
        Mon, 30 Dec 2019 23:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577748601;
        bh=hkEGClyK44JrT1UNYO0jbZ0tX8GcixfZ5o/++Rt06dA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ycs0qW//qZzwO1So3mRQruBvcezHM66js6X/8OZd6SToAPYp9m01psXAmsP6hHrJ7
         EZTRcX1E33l/CHkNgCmtXrf5aCczPBaq0ipr5cdJkpTjegaevjTizea1HAV6pZ/B18
         l5ZsU0wXWXfmtsrkC8WOfzzS/iqXBwfzm8z/FGNI=
Received: by mail-qt1-f169.google.com with SMTP id d5so30664058qto.0;
        Mon, 30 Dec 2019 15:30:01 -0800 (PST)
X-Gm-Message-State: APjAAAUsKpXFIy/abzBCYHMB3pKOs646fmRUT/2KE0tor8BjT07qvVMP
        w77cy9+JX2uruDlHf7ah4JUwiezaKLNXe1KmKg==
X-Google-Smtp-Source: APXvYqzUYjO1rBL+O7ItgGLs1LEmveivzL2IGDBLwwnbea0alSFh/xQM2lhdiJtCRqsgvNgGZGkrlHwTkYsjRu3keSk=
X-Received: by 2002:ac8:5513:: with SMTP id j19mr50575941qtq.143.1577748600241;
 Mon, 30 Dec 2019 15:30:00 -0800 (PST)
MIME-Version: 1.0
References: <20191116005240.15722-1-robh@kernel.org> <20191116005240.15722-3-robh@kernel.org>
 <CAMuHMdX20LvK2o1cZJ8q83Q08JQzH6L07gmqBm0V0xSc5GHk4A@mail.gmail.com>
In-Reply-To: <CAMuHMdX20LvK2o1cZJ8q83Q08JQzH6L07gmqBm0V0xSc5GHk4A@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Dec 2019 16:29:48 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+24qYqN6u1o93gkGm13GZeSRQM4uor0170HeFbLdU-xQ@mail.gmail.com>
Message-ID: <CAL_Jsq+24qYqN6u1o93gkGm13GZeSRQM4uor0170HeFbLdU-xQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: PCI: Convert generic host binding to DT schema
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        David Daney <david.daney@cavium.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 12, 2019 at 7:41 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Sat, Nov 16, 2019 at 1:53 AM Rob Herring <robh@kernel.org> wrote:
> > Convert the generic PCI host binding to DT schema. The derivative Juno,
> > PLDA XpressRICH3-AXI, and Designware ECAM bindings all just vary in
> > their compatible strings. The simplest way to convert those to
> > schema is just add them into the common generic PCI host schema.
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Andrew Murray <andrew.murray@arm.com>
> > Cc: Zhou Wang <wangzhou1@hisilicon.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: David Daney <david.daney@cavium.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> > index 515b2f9542e5..000000000000
> > --- a/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
> > +++ /dev/null
>
> > -Example:
> > -
> > -    pcie1: pcie@7f000000 {
> > -        compatible = "socionext,synquacer-pcie-ecam", "snps,dw-pcie-ecam";
> > -        device_type = "pci";
> > -        reg = <0x0 0x7f000000 0x0 0xf00000>;
> > -        bus-range = <0x0 0xe>;
> > -        #address-cells = <3>;
> > -        #size-cells = <2>;
> > -        ranges = <0x1000000 0x00 0x00010000 0x00 0x7ff00000 0x0 0x00010000>,
> > -                 <0x2000000 0x00 0x70000000 0x00 0x70000000 0x0 0x0f000000>,
> > -                 <0x3000000 0x3f 0x00000000 0x3f 0x00000000 0x1 0x00000000>;
> > -
> > -        #interrupt-cells = <0x1>;
> > -        interrupt-map-mask = <0x0 0x0 0x0 0x0>;
>
> An all-zeroes interrupt-map-mask seems to be very common on embedded
> SoCs, where all devices are mapped to a single interrupt.

Indeed.

> However, schemas/pci/pci-bus.yaml says:
>
>   interrupt-map-mask:
>     items:
>       - description: PCI high address cell
>         minimum: 0
>         maximum: 0xf800
>       - description: PCI mid address cell
>         const: 0
>       - description: PCI low address cell
>         const: 0
>       - description: PCI IRQ cell
>         minimum: 1
>         maximum: 7
>
> and thus complains about an all-zeroes mask, e.g.
>
>     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml:
> pcie@fe000000: interrupt-map-mask:0:3: 0 is less than the minimum of 1

Now fixed.

Thanks,
Rob
