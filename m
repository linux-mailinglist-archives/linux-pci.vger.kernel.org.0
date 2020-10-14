Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23B28E0AE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgJNMn4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 08:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbgJNMnz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Oct 2020 08:43:55 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9C58208B3;
        Wed, 14 Oct 2020 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602679435;
        bh=VSSG6hE1gZVIO+oAQetzoy/KZoYOIOgG7GLGn23AjHw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gmwaZOXNGa7xlauuNbm35LLRVxbMYdQMzQ0fMEa+GFvzSKPiL4vNcKYvaRv/F+ldF
         u8q1DHVD3Oz5MNjdPlacGcNifOuWZaLgGCIhai/DIWUEMswBjMKhy5VvzkHJn7OhBT
         OvAiH+nir4Czuo42hp6RoSyTLln1/pWOTq0JB8f0=
Received: by mail-oi1-f179.google.com with SMTP id l85so3040047oih.10;
        Wed, 14 Oct 2020 05:43:54 -0700 (PDT)
X-Gm-Message-State: AOAM533maxKKS203fG25oXVUx9WotTmnylyj8CTKhURx3pZ5Q5lbDbN9
        eGQaY4h7iw9VQsTXP9mGtCFpVrK3xI9WEPcoWg==
X-Google-Smtp-Source: ABdhPJzfXfTAUHLSNmyidra28l2x73efWCi8eYxJ+PR4UmijFgQXtyvfPxbegY4CmNzQH5ljoNIZ1Crl1wjVuzUrhQA=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr2136679oie.152.1602679434031;
 Wed, 14 Oct 2020 05:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
 <20201004162908.3216898-3-martin.blumenstingl@googlemail.com>
 <CACRpkdbTw4UBw02RXX2prju45AsDZqPchhz=gdzsuT-QjhYHVw@mail.gmail.com>
 <CAFBinCAFDhWp6mgUqyOjdMVBR5oZQVpmVPjhnZs1Xg16tFa0PQ@mail.gmail.com> <CACRpkdZdwoQCxxqosn2jQPMXLDnTEjuxSWOxG-L1YGE33wbFrg@mail.gmail.com>
In-Reply-To: <CACRpkdZdwoQCxxqosn2jQPMXLDnTEjuxSWOxG-L1YGE33wbFrg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 14 Oct 2020 07:43:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLF8KHG6qZUJzdMyN5cX-ZvPDbuGSGZLOw=CkY90SUGLw@mail.gmail.com>
Message-ID: <CAL_JsqLF8KHG6qZUJzdMyN5cX-ZvPDbuGSGZLOw=CkY90SUGLw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] dt-bindings: gpio: Add binding documentation for
 Etron EJ168/EJ188/EJ198
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 13, 2020 at 8:27 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Oct 7, 2020 at 9:58 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> > On Wed, Oct 7, 2020 at 11:19 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Sun, Oct 4, 2020 at 8:00 PM Martin Blumenstingl
> > > <martin.blumenstingl@googlemail.com> wrote:
> > >
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - pci1b6f,7023
> > > > +      - pci1b6f,7052
> > >
> > > I think it is better to let the PCI driver for the whole hardware in
> > > drivers/usb/host/xhci-pci.c probe from the PCI configuration space
> > > numbers, and then add a gpio_chip to xhci-pci.c.
> >
> > to have everything consistent I will move the binding to
> > Documentation/devicetree/bindings/usb
>
> I do not understand why a PCI device would need a DT binding
> at all. They just probe from the magic number in the PCI
> config space, they spawn struct pci_dev PCI devices, not the
> type of platform devices coming out of the DT parser code.
> No DT compatible needed.

Same reason for all the discoverable buses need bindings. There can be
parts that are not discoverable or connections with non-discoverable
nodes. There's also cases where the discoverable device has to be
powered, reset deasserted, clocks enabled, etc. first to be
discovered.

If the GPIOs here had connections elsewhere in the DT, then we have to
describe the provider in DT.

Rob
