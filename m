Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EE9290CEC
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 22:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409073AbgJPUw5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 16:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393599AbgJPUw5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2020 16:52:57 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1461EC061755;
        Fri, 16 Oct 2020 13:52:57 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p13so3859078edi.7;
        Fri, 16 Oct 2020 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LugPJbth2L+5NzHqEmJU9Ma7NXcScsFxdJ4jE8WC+U4=;
        b=Tu7vXfika4qfrXsXOIcn75dbSNc5REGqutvQkX6182ssmjsn2jxIUZ+kP8c4FqidD1
         iMzZVkOEOhMbhuvETrQ/wljPan2CMq5kBxv+mBrz11X8ejGecJ8bWRBk8n5i1el2g865
         DcJ19IfZWCT5lfDCWFPx7PDVa7mCH/RVW3L8uosA+GHrAE6AlJIKvI9YTPbecLzi8Zl4
         jzEq+1N1XhG3Y53aL+JM7tkGhzIN5n4Di8Q1Ya0zBcGQFV/82K9vHhZHztRJVXCX8jxA
         1TLFIqkAgvFYCRXj7lryJz8v9DXrS+Q/x9nl9BFk4o7ukXPoUCi3AXy1fiWoVQkhtyRR
         Lo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LugPJbth2L+5NzHqEmJU9Ma7NXcScsFxdJ4jE8WC+U4=;
        b=M1sS6jgMdJVphvKsg93hRVoBd3QUrMRpMpEj6lliVh6CddE5rvlcaYFkiBYlnrxmsn
         kkzXq5jOLTqjjHd9ZqE5cvU0c4Jt3DoSjbbtzlq7G7LVY+s+YTDWMjl5y/tQHIk1zJ56
         mvptrkOWytmUqAWhQbbJNuIvMUl5CJ6gqDrmJG82aFkJNbYsBWbBXeC6pkdcrADzRvNr
         dryKiUPK89bnY+8GA/XxD0tT2HrF+UhWQGLWVkCGByfHnKt9WN5KnHcN1PmSMYe2tuRl
         /IVTJwI9jnpAyvfGmIHr+haex5Vcoxf2NvQLkO8himq1nIYjtiRxVKsQgYUBhBaOkvlA
         fFow==
X-Gm-Message-State: AOAM5336d8FlJU4OA5cnSyeXtFyPU5bLG+Qu7kk2T3vbxaxqUjUNVuBh
        Ez8klFJtDCQ3T8Fv+u4bto18rLIvnmzx26MKMLI=
X-Google-Smtp-Source: ABdhPJxZ42lByUDO+OTDvcJk4T2dgzm029Jq7A4vWTsHVjzFmUepjiwamlx320/sHJIq5iNEVzj9fJQxeoJTImluMKI=
X-Received: by 2002:a50:d517:: with SMTP id u23mr6148394edi.338.1602881575797;
 Fri, 16 Oct 2020 13:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
 <20201004162908.3216898-3-martin.blumenstingl@googlemail.com>
 <CACRpkdbTw4UBw02RXX2prju45AsDZqPchhz=gdzsuT-QjhYHVw@mail.gmail.com>
 <CAFBinCAFDhWp6mgUqyOjdMVBR5oZQVpmVPjhnZs1Xg16tFa0PQ@mail.gmail.com>
 <CACRpkdZdwoQCxxqosn2jQPMXLDnTEjuxSWOxG-L1YGE33wbFrg@mail.gmail.com> <CAL_JsqLF8KHG6qZUJzdMyN5cX-ZvPDbuGSGZLOw=CkY90SUGLw@mail.gmail.com>
In-Reply-To: <CAL_JsqLF8KHG6qZUJzdMyN5cX-ZvPDbuGSGZLOw=CkY90SUGLw@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 16 Oct 2020 22:52:44 +0200
Message-ID: <CAFBinCBpDn1Vx1ZQdk-Gf-muuAyxjXb+zCkvW6jsH8jP6mDuTw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] dt-bindings: gpio: Add binding documentation for
 Etron EJ168/EJ188/EJ198
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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

Hi Linus,

On Wed, Oct 14, 2020 at 2:43 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Oct 13, 2020 at 8:27 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Wed, Oct 7, 2020 at 9:58 PM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > > On Wed, Oct 7, 2020 at 11:19 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > > On Sun, Oct 4, 2020 at 8:00 PM Martin Blumenstingl
> > > > <martin.blumenstingl@googlemail.com> wrote:
> > > >
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - pci1b6f,7023
> > > > > +      - pci1b6f,7052
> > > >
> > > > I think it is better to let the PCI driver for the whole hardware in
> > > > drivers/usb/host/xhci-pci.c probe from the PCI configuration space
> > > > numbers, and then add a gpio_chip to xhci-pci.c.
> > >
> > > to have everything consistent I will move the binding to
> > > Documentation/devicetree/bindings/usb
> >
> > I do not understand why a PCI device would need a DT binding
> > at all. They just probe from the magic number in the PCI
> > config space, they spawn struct pci_dev PCI devices, not the
> > type of platform devices coming out of the DT parser code.
> > No DT compatible needed.
>
> Same reason for all the discoverable buses need bindings. There can be
> parts that are not discoverable or connections with non-discoverable
> nodes. There's also cases where the discoverable device has to be
> powered, reset deasserted, clocks enabled, etc. first to be
> discovered.
>
> If the GPIOs here had connections elsewhere in the DT, then we have to
> describe the provider in DT.
this is exactly what I need it for: that platform has hand-written
.dts files and I need to wire up a GPIO LED


Best regards,
Martin
