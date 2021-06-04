Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB03C39B658
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 12:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFDKCf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 06:02:35 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:37603 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFDKCe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 06:02:34 -0400
Received: by mail-ed1-f45.google.com with SMTP id b11so10466924edy.4
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 03:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBQD7Un56lN0z2oeN/M8hCljHk3EqA4dP7dm5bjbnEA=;
        b=Gm4Qo8Dxss2EFKU/uY2o2VlqoGUmp+BC1WRP+YdnUnMl8x7TVjBPTb0k2jPjagtXIp
         yme5LoGdEhCLezLpp0Ur/tg0uW+tCGqRqQzGPMkGXkKZoex5VV4ajbWeQZ/z/JxRzcrt
         799ZsuBIlL8OKkhZaDr90MqXpMJI/dWwiW1TR5IO0lQYAa9xJaSHaRR1dOOQH7CQDfaD
         CfkGj54ymFoQ4eowdymSklmQcfDtENUSjW3+vfNWx2Ai5QKUsWOsyhBU6oMaaED0wVhO
         1jGMhk+JexIepdscE1eg73szCUEwCCv+S2VZatKUjk8ql83edbZQvfe9Wcaw2MVNLenA
         ualA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBQD7Un56lN0z2oeN/M8hCljHk3EqA4dP7dm5bjbnEA=;
        b=YMEi7Qu8ppO5XFkd49oyqCx1UdncTAUl0G4hQGkLFcBZ+L8kyIgkKS5EYhZ1ERb3uZ
         DvZo0c7y/n74aCayfzMv/lUh14qUw/cvGdEA2vuj6J39LB0QFhM7tfT8ddRVi8QAurMD
         uLEJtbe9RtiSYCu/FsdPFBSxxfr/ZB0w07/6fDOOXNiMqCNxmQgcioj4HEeSaZVzzlK0
         f+ObirBwnQaCtEaPbmgGzlQe5mYou8ODWJOPoqOxskJ93YzNE5vd/qRRkqnX9LtiwaEZ
         G5kpnkBXo6XZ3U0BcVDQFOtPbPPQ+6SRG/3CZdPRMD3e0uZqk2ypfVHqVuMSCLANTZoA
         Bqcg==
X-Gm-Message-State: AOAM5329EWo7fF+u64D+x5hwnR2k7UrSAilWJj0wg0A8OM8GP9xs90/X
        Mwf5aQwlvBuyx+Y62kULLkjQ0PspP/zhWm9A8Ac=
X-Google-Smtp-Source: ABdhPJwsOj4HY6c2kPiiTxubjpk0HusZB40NhGfuYkvUWdOhOT13dg7A++neJ2wCyWKWh1tO+XaJtRMlz4sspXbrwRA=
X-Received: by 2002:aa7:d755:: with SMTP id a21mr3911857eds.146.1622800787647;
 Fri, 04 Jun 2021 02:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210528071503.1444680-5-chenhuacai@loongson.cn> <20210528205129.GA1519561@bjorn-Precision-5520>
In-Reply-To: <20210528205129.GA1519561@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 4 Jun 2021 17:59:35 +0800
Message-ID: <CAAhV-H6t_UpcW3iCYw9iG3NXhZin4Sk-zsORNcrcg8Q=8jiJcw@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] PCI: Add quirk for multifunction devices of LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Sat, May 29, 2021 at 4:51 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rob, previous discussion at
> https://lore.kernel.org/r/20210514080025.1828197-5-chenhuacai@loongson.cn]
>
> On Fri, May 28, 2021 at 03:15:03PM +0800, Huacai Chen wrote:
> > From: Jianmin Lv <lvjianmin@loongson.cn>
> >
> > In LS7A, multifunction device use same PCI PIN (because the PIN register
> > report the same INTx value to each function) but we need different IRQ
> > for different functions, so add a quirk to fix it for standard PCI PIN
> > usage.
>
> This seems to say that PCI_INTERRUPT_PIN reports the same value for
> all functions, but the functions actually use *different* IRQs.
>
> That would be a hardware defect, and of course, we can work around
> such things.  It's always better if you can assure us that the defect
> will be fixed in future designs so we don't have to update the
> workaround with more device IDs.
Yes, you are right, and new hardware will not need this workaround.

>
> But Jiaxun suggests [1] that the FDT says all the interrupts go to the
> same IRQ.
>
> So I don't know what's going on here.  We can certainly work around a
> problem, but of course, this quirk would apply for both FDT and
> ACPI-based systems, and the FDT systems seem to work without it.
Emmm, I have discussed with Jiaxun, and maybe you missed something. He
means that ACPI systems need this workaround, and FDT systems don't
need this. But this workaround doesn't break FDT systems, because FDT
systems simply ignore the workaround (interrupts are specified in .dts
file).

Huacai
>
> [1] https://lore.kernel.org/r/933330cb-9d86-2b22-9bed-64becefbe2d1@flygoat.com
>
> > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/quirks.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 10b3b2057940..6ab4b3bba36b 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -242,6 +242,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >                       DEV_LS7A_LPC, loongson_system_bus_quirk);
> >
> > +static void loongson_pci_pin_quirk(struct pci_dev *dev)
> > +{
> > +     dev->pin = 1 + (PCI_FUNC(dev->devfn) & 3);
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_0, loongson_pci_pin_quirk);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_1, loongson_pci_pin_quirk);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_2, loongson_pci_pin_quirk);
> > +
> >  static void loongson_mrrs_quirk(struct pci_dev *dev)
> >  {
> >       struct pci_bus *bus = dev->bus;
> > --
> > 2.27.0
> >
