Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D89F4BC54D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 11:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395360AbfIXJ44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 05:56:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46849 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394079AbfIXJ44 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 05:56:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id f21so904938otl.13;
        Tue, 24 Sep 2019 02:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ml8qAvVeI/oVzxatM9ZW9urxDvsb84kxIZjzlp/0xdA=;
        b=U8/QWp3HBVXyPqjoIYGyi0SrZJeV/Ebh0fHA/0MsU0HZ6/FzClKwWEBTm4BGCdsqsO
         V5v216OlTJKVA9vMkvdcWabznigYRsL88GGXvS7IST8b0ytE2OpiEsIuVLKyhnjtZVAc
         QiB2nH22nuLM+sXhUJZ6du1kKEahL7YLEffW3w/duxxU3DKpjYDDQFn/IGeh3w2rs1hf
         p8NTEIuVIXfacQKnJT1l0N3cpM+9K9ZvmWjtpzCn6laK6bxkn3kdXvBFEd0XxF/6qHRS
         9c/Jlz1AqFuuI8W/TaIdYRANHGgQuMMcCctbug1SsMtf4DTwTlfhMIscWnR1guiKcTpE
         M8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ml8qAvVeI/oVzxatM9ZW9urxDvsb84kxIZjzlp/0xdA=;
        b=bdjl8ufSIJrxM238TAJSfAIARTdcS84iCV1k3V2S559P4FayNwyXf3alL2i4y66qfX
         049iI4T4yYzZ2stUt42cZAVx6bgtOEKjz5gf8h0ZyNhwah8PG9TxgYpcL6ugzlWxqXYM
         y9pWUueP1FpBQE5D8sPJfj0EDqiynKhnj50iIdO8Jo9cm+L0Ct+ckVYt+gzxWFaDZMoX
         9D5u5+xnTxsH1mzQy6iRwRI8CCVXZgRwNADyHD+g/hhVBXsdF6gIyW2Zi9E4sfH74UIc
         Gc6zPcO1RNy1nZ2AW0NP7oPRxRc/U094PZViMuOnP1oU3mfd9GQMfALeMddRiXfwvDrj
         G58A==
X-Gm-Message-State: APjAAAX10hcnubA4gnb01g/YSue0CPQs8OSoHquZv+OynbFKgIozTXyx
        xokxP9Y7KOh3UN8FAlzMwM1nsHD9qL7VnYgEseE=
X-Google-Smtp-Source: APXvYqwvP/KXTb/jVis3QJJ+pBqN6jRM2sjEwDeU1+H1qxRNVsh4di6xqzj7qPOO7gDwYS5Qz2y9cpc21FGzvLX0FL0=
X-Received: by 2002:a05:6830:15d7:: with SMTP id j23mr1032546otr.343.1569319016044;
 Tue, 24 Sep 2019 02:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <1567438203-8405-1-git-send-email-sundeep.lkml@gmail.com> <20190923123543.GL9720@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190923123543.GL9720@e119886-lin.cambridge.arm.com>
From:   sundeep subbaraya <sundeep.lkml@gmail.com>
Date:   Tue, 24 Sep 2019 15:26:44 +0530
Message-ID: <CALHRZuqycJ1bypE4iyHYEt7wiPpiG4wMpDt8Nbm2sjCZ29Pm7Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: Do not use bus number zero from EA capability
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Stalley, Sean" <sean.stalley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, sgoutham@marvell.com,
        Subbaraya Sundeep <sbhatta@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On Mon, Sep 23, 2019 at 6:05 PM Andrew Murray <andrew.murray@arm.com> wrote:
>
> On Mon, Sep 02, 2019 at 09:00:03PM +0530, sundeep.lkml@gmail.com wrote:
> > From: Subbaraya Sundeep <sbhatta@marvell.com>
> >
> > As per the spec, "Enhanced Allocation (EA) for Memory
> > and I/O Resources" ECN, approved 23 October 2014,
> > sec 6.9.1.2, fixed bus numbers of a bridge can be zero
>
> s/can/must/
>
> The spec uses the term *must*. "Can" implies that this is optional.
>
Yes will change to must.

> > when no function that uses EA is located behind it.
> > Hence assign bus numbers sequentially when fixed bus
> > numbers are zero.
>
> Perhaps s/sequentially/as per normal/ or similar. As we're not doing
> anything different here.
>
Ok will change

> >
> > Fixes: 2dbce590117981196fe355efc0569bc6f949ae9b
>
> Is it worth describing what actually goes wrong without this patch - and
> when this occurs? I guess it's possible for a bridge to have an EA
> capability, but no devices using EA behind it - and thus in this suitation
> the downstream devices have unnecessary bus number constraints?
>
EA is for functions which are permanently connected to host bridge.
In our case all the on chip devices use EA and bridges which are there for
connecting off chip devices use EA with fixed bus numbers as zero.
Bus numbers for those bridges need to be configured as per
normal enumeration, failing to do so makes those bridges not functional
because secondary and subordinate bus numbers are 0.

> >
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
>
> Does this need to be CC'd to stable?
>
Ok will CC stable from v2

> > ---
> >  drivers/pci/probe.c | 25 +++++++++++++------------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index a3c7338..c06ca4c 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1095,27 +1095,28 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
> >   * @sub: updated with subordinate bus number from EA
> >   *
> >   * If @dev is a bridge with EA capability, update @sec and @sub with
> > - * fixed bus numbers from the capability and return true.  Otherwise,
> > - * return false.
> > + * fixed bus numbers from the capability. Otherwise @sec and @sub
> > + * will be zeroed.
> >   */
> > -static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
> > +static void pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
> >  {
> >       int ea, offset;
> >       u32 dw;
> >
> > +     *sec = *sub = 0;
> > +
> >       if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> > -             return false;
> > +             return;
> >
> >       /* find PCI EA capability in list */
> >       ea = pci_find_capability(dev, PCI_CAP_ID_EA);
> >       if (!ea)
> > -             return false;
> > +             return;
> >
> >       offset = ea + PCI_EA_FIRST_ENT;
> >       pci_read_config_dword(dev, offset, &dw);
> >       *sec =  dw & PCI_EA_SEC_BUS_MASK;
> >       *sub = (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHIFT;
>
> Is there any value in doing any sanity checking here? E.g. sub !=0, sub > sec?
>

I don't think it is needed since we read hardwired values from HW.

> > -     return true;
> >  }
> >
> >  /*
> > @@ -1151,7 +1152,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >       u16 bctl;
> >       u8 primary, secondary, subordinate;
> >       int broken = 0;
> > -     bool fixed_buses;
> >       u8 fixed_sec, fixed_sub;
> >       int next_busnr;
> >
> > @@ -1254,11 +1254,12 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >               pci_write_config_word(dev, PCI_STATUS, 0xffff);
> >
> >               /* Read bus numbers from EA Capability (if present) */
> > -             fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> > -             if (fixed_buses)
> > +             pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> > +
> > +             next_busnr = max + 1;
> > +             /* Use secondary bus number in EA */
> > +             if (fixed_sec)
> >                       next_busnr = fixed_sec;
> > -             else
> > -                     next_busnr = max + 1;
>
> There is a subtle style change here (assigning and then potentially reassigning
> with a new value vs assigning once using both if/else). No idea if this matters
> but I thought I'd point it out in case it wasn't intentional.
>
This is intentional just to avoid else case.

Thanks for review. I will send v2.
Sundeep

> Thanks,
>
> Andrew Murray
>
> >
> >               /*
> >                * Prevent assigning a bus number that already exists.
> > @@ -1336,7 +1337,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >                * If fixed subordinate bus number exists from EA
> >                * capability then use it.
> >                */
> > -             if (fixed_buses)
> > +             if (fixed_sub)
> >                       max = fixed_sub;
> >               pci_bus_update_busn_res_end(child, max);
> >               pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
> > --
> > 2.7.4
> >
