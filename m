Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3514C473563
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 20:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbhLMT6c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 14:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbhLMT6a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 14:58:30 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0407CC06173F
        for <linux-pci@vger.kernel.org>; Mon, 13 Dec 2021 11:58:30 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 133so15475307pgc.12
        for <linux-pci@vger.kernel.org>; Mon, 13 Dec 2021 11:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmtlwaoKecb3OjlTS1+QUQgYom0U7BYI17ypi8x6kXI=;
        b=GnrjInCguT1hYvRxEFp2FFlcWJk+X6scQ0TguTZJYVs5btZvLe4+YCVtdB1wZBA4ql
         lPf7oCvJEdd0G+oUe5yfcRXur4cxWEXfxcjyEJoITH2W9As4AMyaF/6oqsEcsNBAgWD/
         UBIucA6BcyhNjSnCqT/ISHXWrlgFdN+ILDONTu1HlNwv1vdXyPxGBU9vO+59APihDv/L
         /nwhYbGPq5FxpkV4Q212xLuEDTP4CAF4U5LzT8KXzoBVVzuau0xfXfTisMvTpfIsPlgw
         +17xll8EDuD0UqXiCAsNXUxf++d7lYacez0U09SFm2L5hSCMz5JIZS3+Y+DKV/2HHGL6
         Pi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmtlwaoKecb3OjlTS1+QUQgYom0U7BYI17ypi8x6kXI=;
        b=GUHzQtPz59aVyNf0ab0zKzCKRUk7KKxaXE7QZqoAqy26cPCYf9z9+5X+Cd57P5T12a
         TLfoe7FY//PUtN9PJxkwa59zWF3TWrPOdinYRNRzeCSDW62XdQ5Ino7CHPLyfRp0ZnQa
         ErB4IeAfU/LwhuER9Ke/fRnlfD0qFiib3V8NW3eZK8RsB24a55zv9Gfuu7ogeHwc0mzs
         TKvdGJY8VJapRko3QpZ+tyX3D4iwa2ZinF9Gr7SSGxZjgdou9fB64H0LpQI5v0YXJSGJ
         tls/sRZYmwJsyQiMsxIdqvGgueyTDIRBioVtj3LaxkGSBNBc0cUR0aenPc1XU835cs6B
         /8KA==
X-Gm-Message-State: AOAM530A49YKbPfVsVYhaeqWC3ofe9qwGUWqukq3zLv1FWrXGQ2lDgzB
        d0ZKwgVAKSuCY7RzWL+6wtTrn8ONCPyJsWtDoRBDnA==
X-Google-Smtp-Source: ABdhPJyxdpF8yw1Mfppja7TttKdq2KytY/u0mapNh2UceVCKIokfMXDLBzkp5pk5YhzPAhPmfct2uhkiNfnabLvww9s=
X-Received: by 2002:a63:ef44:: with SMTP id c4mr564190pgk.146.1639425509218;
 Mon, 13 Dec 2021 11:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20211209094556.2085357-1-jiasheng@iscas.ac.cn> <20211211175450.GA398271@bhelgaas>
In-Reply-To: <20211211175450.GA398271@bhelgaas>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 13 Dec 2021 11:57:52 -0800
Message-ID: <CACK8Z6EntHP0TWfq=JdQ7QS8vCgXoRUJOWqbGYLvD6R2Mq0paw@mail.gmail.com>
Subject: Re: [PATCH] PCI/AER: potential dereference of null pointer
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, ruscur@russell.cc,
        oohall@gmail.com, bhelgaas@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello

On Sat, Dec 11, 2021 at 9:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rajat, author of aer_stats:
> db89ccbe52c7 ("PCI/AER: Define aer_stats structure for AER capable devices"
> 81aa5206f9a7 ("PCI/AER: Add sysfs attributes to provide AER stats and breakdown"]
>
> On Thu, Dec 09, 2021 at 05:45:56PM +0800, Jiasheng Jiang wrote:
> > he return value of kzalloc() needs to be checked.
> > To avoid use of null pointer in case of the failure of alloc.
> >
> > Fixes: db89ccbe52c7 ("PCI/AER: Define aer_stats structure for AER capable devices")
> > Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> > ---
> >  drivers/pci/pcie/aer.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index ec943cee5ecc..d04303edf468 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -376,6 +376,8 @@ void pci_aer_init(struct pci_dev *dev)
> >               return;
> >
> >       dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
> > +     if (!dev->aer_stats)
> > +             return;
>
> Did you actually trip over a null pointer dereference, and if so,
> where was it?
>
> I think the intent here was that aer_stats is a non-essential feature,
> and if we can't allocate space to keep the statistics, we can still
> use the device without the stats.

Ack. Yes, this was my intention.

Practically speaking though, if a system cannot allocate space for
aer_stats (608 bytes), I would think it is under an extreme memory
pressure so not really sure if will be able to really do anything with
the PCI device (probe the driver which may want to allocate more
memory etc). But that isn't anything that we can help with.

The current patch AFAICS looks like a no-op to me.

Thanks,

Rajat

>
> I *think* all the users of dev->aer_stats check for NULL before
> dereferencing it, but if you found a case that doesn't do that, we
> should definitely fix it.
>
> In a few cases (aer_stats_dev_attr, aer_stats_rootport_attr), the
> check isn't obvious -- it happens in aer_stats_attrs_are_visible().
> If aer_stats_attrs_are_visible() finds that aer_stats is NULL, those
> sysfs attributes should not be visible, and the corresponding *_show()
> functions should never be called.
>
> >       /*
> >        * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
> > --
> > 2.25.1
> >
