Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E3738159E
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 05:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhEOD5y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 23:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEOD5x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 23:57:53 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F6C06174A
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 20:56:40 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id o9so1481126ilh.6
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 20:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YqCHjI5DLPc7hpafqWtiME2iwfumNyvs/GPlMFwGAxA=;
        b=Y2+asGc5vGG00M8XtynmVZRpQ2XM3cNop4rjHPPPRSztbXQ7L7flj8VLszKNGlyQJC
         +6NfXnNUhs1yYkI4Ztm6RoJkbziduvE2LrQZo66tWfi2IlopVJ3QfXtvDkZXCIFJl1Jg
         gK7qj3S/W58//WBTdI0eFEviMOVyvJGkmXLbLdkPCQ8RaFg4x+lvvo2s6YjF7xkLDdFP
         s6VKmvo55UzYNBh9y319aizB5HeDHX42SA8q86o47CT98ODmEBhE4LMTlEemws8jDRLP
         iG7CR71OPFlSihQFnRtfmv1quOU64DeTabfg5+bVw/oGb6782bao/IEbl7nzgE7ijj2Z
         Pcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YqCHjI5DLPc7hpafqWtiME2iwfumNyvs/GPlMFwGAxA=;
        b=jK0CQK79Cium4dWdiq6brz7igZVdc23VVno+Y1wOF9gFm9CB8F6PCPdy79wT2HHSnM
         jI6bWKjanHl7elj0uNMzs5MgGhWoI40h0O7oFr6dsz2/bs8rwN9I0498Bo+q3T6XIO7v
         S/A8cd407m3pjhyohDQMBmN45kqs5dasRSrQ3kvC9La0vK5SE9xxwIJPssPdp9MV1NIc
         h4gjHTXkBizc4OE4/as4HfHRpX30DSmYKm7YbR8XWZM9CKTm1JLJ5KzPf4B1cNr2rub/
         zS0k1wO5EU2FxnDQAjIrY1n5ZxdBd7Ak4W+01yoA5V1MTpPzxqEsYIVpCkX796qP0sWc
         EmoQ==
X-Gm-Message-State: AOAM530LDwM2RjDjV/+8o7TR9291doT6AU4c922LbOQKARYwshTPsjvn
        Pc6e5um7zXHedMWFS+hS5nSbCdf/uphF9Nd8BsTYrWKta5g=
X-Google-Smtp-Source: ABdhPJxFqiY5KqKgu+B1cLG2b3+EkNX2dbgW7+c6NthSjUavveDnI9vjOUXPM0m+xUIhW7K0sG1Zu7PyQY2NDj8fj2w=
X-Received: by 2002:a05:6e02:d51:: with SMTP id h17mr43092394ilj.134.1621050999976;
 Fri, 14 May 2021 20:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210514080025.1828197-5-chenhuacai@loongson.cn> <20210514155110.GA2764013@bjorn-Precision-5520>
In-Reply-To: <20210514155110.GA2764013@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 15 May 2021 11:56:28 +0800
Message-ID: <CAAhV-H4ubahHxOvTyTng9bUhrVNXmC0K+cvG1Saco=xaQMs=hA@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: Add quirk for multifunction devices of LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Krzysztof and Bjorn

I will improve my spelling, others see below please.

On Fri, May 14, 2021 at 11:51 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, May 14, 2021 at 04:00:24PM +0800, Huacai Chen wrote:
> > From: Jianmin Lv <lvjianmin@loongson.cn>
> >
> > In LS7A, multifunction device use same pci PIN and different
> > irq for different function, so fix it for standard pci PIN
> > usage.
>
> Apparently the defect here is that the Interrupt Pin register reports
> the wrong INTx values?
In LS7A, the Pin register is hardcoded to the same value for all
functions in multi-function devices, so we need this.
>
> Will this be fixed in future hardware so we don't have to add more
> devices to the quirk?
This will be fixed in future hardware.

Huacai
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
> > @@ -242,6 +242,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >                       DEV_LS7A_LPC, loongson_system_bus_quirk);
> >
> > +static void loongson_pci_pin_quirk(struct pci_dev *dev)
> > +{
> > +     static const struct pci_device_id devids[] = {
> > +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> > +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> > +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> > +             { 0, },
> > +     };
> > +
> > +     if (pci_match_id(devids, dev)) {
> > +             u8 fun = dev->devfn & 7;
>
> Use PCI_FUNC().
>
> > +             dev->pin = 1 + (fun & 3);
> > +     }
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_ANY_ID, loongson_pci_pin_quirk);
>
> The usual pattern is to list each device here instead of using
> pci_match_id() in the quirk, e.g.,
>
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, 0x7a09, loongson_pci_pin_quirk);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, 0x7a19, loongson_pci_pin_quirk);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, 0x7a29, loongson_pci_pin_quirk);
>
> >  static void loongson_mrrs_quirk(struct pci_dev *dev)
> >  {
> >       struct pci_bus *bus = dev->bus;
> > --
> > 2.27.0
> >
