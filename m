Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D67897067
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 05:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfHUDb7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 23:31:59 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:43718 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfHUDb7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 23:31:59 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x7L3Vusd068100
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Aug 2019 23:31:57 -0400
Received: by mail-lf1-f42.google.com with SMTP id 62so650317lfa.8;
        Tue, 20 Aug 2019 20:31:57 -0700 (PDT)
X-Gm-Message-State: APjAAAURX9vk+ObwhABU89VU/fOEgkDJcYNO52tCywDjS7SF54Rhnr6k
        i57LECGG4Ig6WJJ2sfDd8siitaliYaiMeqaiKi4=
X-Google-Smtp-Source: APXvYqw2kV8aq5c/ZjYqNiCZFLfPbiTcII9+3u8CHm4ZyowA9u+Ct/Oug7TnOdSWBQnmZAMbfnRMzcq4ufIN3kx9kkI=
X-Received: by 2002:ac2:48b8:: with SMTP id u24mr16902642lfg.170.1566358316201;
 Tue, 20 Aug 2019 20:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <1565930002-5524-1-git-send-email-wenwen@cs.uga.edu> <20190819212317.GU253360@google.com>
In-Reply-To: <20190819212317.GU253360@google.com>
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Tue, 20 Aug 2019 23:31:20 -0400
X-Gmail-Original-Message-ID: <CAAa=b7dw3w9C5_A_kypw-g7+JBz8uHGQ7_=CVVq1LrhiFEBY7Q@mail.gmail.com>
Message-ID: <CAAa=b7dw3w9C5_A_kypw-g7+JBz8uHGQ7_=CVVq1LrhiFEBY7Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI / PCI: fix a memory leak bug
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wenwen@cs.uga.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 5:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> The subject line should give a clue about where the leak is, e.g.,
>
>   ACPI / PCI: fix acpi_pci_irq_enable() memory leak
>
> On Thu, Aug 15, 2019 at 11:33:22PM -0500, Wenwen Wang wrote:
> > In acpi_pci_irq_enable(), 'entry' is allocated by invoking
> > acpi_pci_irq_lookup(). However, it is not deallocated if
> > acpi_pci_irq_valid() returns false, leading to a memory leak. To fix this
> > issue, free 'entry' before returning 0.
>
> I think the corresponding kzalloc() is the one in
> acpi_pci_irq_check_entry().
>
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> > ---
> >  drivers/acpi/pci_irq.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> > index d2549ae..dea8a60 100644
> > --- a/drivers/acpi/pci_irq.c
> > +++ b/drivers/acpi/pci_irq.c
> > @@ -449,8 +449,10 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> >                * No IRQ known to the ACPI subsystem - maybe the BIOS /
> >                * driver reported one, then use it. Exit in any case.
> >                */
> > -             if (!acpi_pci_irq_valid(dev, pin))
> > +             if (!acpi_pci_irq_valid(dev, pin)) {
> > +                     kfree(entry);
> >                       return 0;
> > +             }
>
> Looks like we missed this when e237a5518425 ("x86/ACPI/PCI: Recognize
> that Interrupt Line 255 means "not connected"") was merged.
>
> You could add:
>
> Fixes: e237a5518425 ("x86/ACPI/PCI: Recognize that Interrupt Line 255 means "not connected"")
>
> >               if (acpi_isa_register_gsi(dev))
> >                       dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
> > --
> > 2.7.4
> >

Thanks for your comments and suggestions! I will rework the patch.

Wenwen
