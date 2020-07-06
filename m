Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B09215977
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 16:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgGFObk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 10:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbgGFObk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 10:31:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C9EC061794
        for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2020 07:31:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z2so18935607wrp.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2020 07:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhw/BUTROVOYN40TpUh0RgTpP5MGKfF0bQwNQn8IkII=;
        b=G6sMfBcyiYZnXJjewARbxvkBt3nPIhVdokEGhTOdGLVzWM49cWwLxahf6Rk2CZ1TFB
         s/0S87lpRaLeyIqVJQEXwzGp3bW5n5qiDoJasdHuh95CUnRkVR+HzZeQgjKbYbhlqt3b
         WD9MqtcyVkJe4aVoz5MvW6z5eWkzVtxC+SoaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhw/BUTROVOYN40TpUh0RgTpP5MGKfF0bQwNQn8IkII=;
        b=VLZAW9oBxFEzmIUPm0gTpsU+ujAx7Ud3w2iL/0vZNoSqtWf7qa/EEvrE8OIH0tWr/D
         Jl26+Y8ezv5zj4Jx8wW87/dmUlavxF3+tR+21tSFpGLqIGzUUR0tFD6C2mUbG/QSjVeu
         K46QXFJOqkOZ347enH1tLF+e1AgfvJWI8RL4BwyFUqc4Dbhu9lB3slJ/ScAtweVCt2Da
         hoCxh2vVFrlK0QEvGprfcuDHxTJtf9DUhUiCcUVTLJsE4jtncTH+qfkLpZDrEbAfaysB
         EeWupYLjJRmuOVUqC5J7yhuzIJzxSL1MWpT/H750qNTqNrD5F2d8TCuwqbUKP20iEpMm
         2mow==
X-Gm-Message-State: AOAM5330KVApjRS0fzJAXtTSylWwCDwDwGOOfxKM3NnDkVDLzBgSMdre
        kh9DLCwE5hCS9w9+fdqVE9AsJuIWQzwZGEd9/S2PJWQfg1o=
X-Google-Smtp-Source: ABdhPJyHqRH6FGwmZgD3+KEklIah/GrAEhS53xleM7Xl7Ibxb6V9FYXfGur/MTogqCYMmnM+3ePQijdxNsAEQ6ymJm4=
X-Received: by 2002:adf:edc6:: with SMTP id v6mr49556859wro.413.1594045898580;
 Mon, 06 Jul 2020 07:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200701212155.37830-1-james.quinlan@broadcom.com>
 <20200701212155.37830-3-james.quinlan@broadcom.com> <968d6802-b30e-b618-1dd5-1b1a5ba6548a@cogentembedded.com>
In-Reply-To: <968d6802-b30e-b618-1dd5-1b1a5ba6548a@cogentembedded.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 6 Jul 2020 10:31:27 -0400
Message-ID: <CA+-6iNyoMiy6gybczF6_fqazHAjps-gbJt9pyJ65wTxSp1Lmpw@mail.gmail.com>
Subject: Re: [PATCH v6 02/12] ata: ahci_brcm: Fix use of BCM7216 reset controller
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 2, 2020 at 5:32 AM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>
> Hello!
>
> On 02.07.2020 0:21, Jim Quinlan wrote:
>
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > A reset controller "rescal" is shared between the AHCI driver and the PCIe
> > driver for the BrcmSTB 7216 chip.  Use
> > devm_reset_control_get_optional_shared control() to handle this sharing.
>
>     Not "devm_reset_control_get_optional_shared() control"?


Hi Sergei, sorry for the delay in my response.  I will fix the above.

Thanks again,
Jim

>
>
> >
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> >
> > Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
> > Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
> > ---
> >   drivers/ata/ahci_brcm.c | 11 +++--------
> >   1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> > index 6853dbb4131d..d6115bc04b09 100644
> > --- a/drivers/ata/ahci_brcm.c
> > +++ b/drivers/ata/ahci_brcm.c
> [...]
> > @@ -452,11 +451,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
> >
> >       /* Reset is optional depending on platform and named differently */
> >       if (priv->version == BRCM_SATA_BCM7216)
> > -             reset_name = "rescal";
> > +             priv->rcdev = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
> >       else
> > -             reset_name = "ahci";
> > +             priv->rcdev = devm_reset_control_get_optional(&pdev->dev, "ahci");
> >
> > -     priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
> >       if (IS_ERR(priv->rcdev))
> >               return PTR_ERR(priv->rcdev);
> >
> [...]
>
> MBR, Sergei
