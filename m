Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C0928CF1D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 15:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgJMN1Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Oct 2020 09:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbgJMN1Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2020 09:27:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA79C0613D6
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2020 06:27:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x16so7083981ljh.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2020 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NIDO88L/SfLo7a2I6RUC0k7nZAbu1A3o1CF53Wby8o=;
        b=MwfmDJKmJ81pU5hFl/rnyB8ayCOt5/lEUwSU27O6JDx9gQHn3DTxf+20E2rDsHteN3
         9JTXgdXXsFRCbcDH9mN59YWJeO5adNlI1tyTLFP3T75BWSlWOBZlXUIezLx4IvooOzhl
         iGMrxOm/GgqysYdhsEknsvhLgGgOndvkipKdbiQSRDirQWRFH7UT0/jHGov7IYyeLf9J
         L5CvqhwM4drP3u2Hx5OyA2YyEVgNmqYg3Rmh4z4C97GCr5h0HIZPZWmqSlg4fwlsX8jR
         QsCFkAfIZTTPlYPiMnrleySRmUurBcPFBXPWPMEkZ88jIn7qIWgNQRBHz0cZXIkUQY3H
         7cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NIDO88L/SfLo7a2I6RUC0k7nZAbu1A3o1CF53Wby8o=;
        b=dCPzondAa1THjhmDVpJe+i3o+B0O96gnRpUxDTV6MKpJiROJz3b94sIxBZ3O6maIUB
         /CjFN8ebusNcBBH1GTbjLtDzhLalpuH5/ibqQTsfGHaDUeCgxtcrWRAEi8WCU3V/cElY
         OtqVTAWsQ1Z4dUANvBmV/Wb7TQJe+JXC/unDWUC1SnUiNPtwDx//facNc49jIFZyuYbp
         p8m17NMn+HMq7V0CHR9d4sXuR/XY2OhLA2/ifBWtBJRPkfPLIwgdoWXG7ibHPQOTNbr8
         v9fBeCFOE2zxrAlEfDXPqP+o0eHLbu/Qfxk+z6PtucX1/GmbpM1+DfKHmCfxtW+TxPfY
         jhMQ==
X-Gm-Message-State: AOAM531zH08L03g2kZ3nM7+Wdt5aIJy7MBMWU/TPlbkvC0XFrHCk9Pgo
        4SeOdEMIk9Jci3RADIpWu9p8Jhkt58bZYdIeggNVTw==
X-Google-Smtp-Source: ABdhPJyUtzNpor9sibSYIY37lGowERAa80Msa/zFAJYgm+rvw5o4xkcDDfln7nDCdfKgqesfqrths5OjzjeufIK57F0=
X-Received: by 2002:a2e:b893:: with SMTP id r19mr2025007ljp.104.1602595641517;
 Tue, 13 Oct 2020 06:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
 <20201004162908.3216898-3-martin.blumenstingl@googlemail.com>
 <CACRpkdbTw4UBw02RXX2prju45AsDZqPchhz=gdzsuT-QjhYHVw@mail.gmail.com> <CAFBinCAFDhWp6mgUqyOjdMVBR5oZQVpmVPjhnZs1Xg16tFa0PQ@mail.gmail.com>
In-Reply-To: <CAFBinCAFDhWp6mgUqyOjdMVBR5oZQVpmVPjhnZs1Xg16tFa0PQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Oct 2020 15:27:10 +0200
Message-ID: <CACRpkdZdwoQCxxqosn2jQPMXLDnTEjuxSWOxG-L1YGE33wbFrg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] dt-bindings: gpio: Add binding documentation for
 Etron EJ168/EJ188/EJ198
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 7, 2020 at 9:58 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> On Wed, Oct 7, 2020 at 11:19 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Sun, Oct 4, 2020 at 8:00 PM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> >
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - pci1b6f,7023
> > > +      - pci1b6f,7052
> >
> > I think it is better to let the PCI driver for the whole hardware in
> > drivers/usb/host/xhci-pci.c probe from the PCI configuration space
> > numbers, and then add a gpio_chip to xhci-pci.c.
>
> to have everything consistent I will move the binding to
> Documentation/devicetree/bindings/usb

I do not understand why a PCI device would need a DT binding
at all. They just probe from the magic number in the PCI
config space, they spawn struct pci_dev PCI devices, not the
type of platform devices coming out of the DT parser code.
No DT compatible needed.

What am I not understanding about this?

Yours,
Linus Walleij
