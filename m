Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CF41FDB0
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 04:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEPCNF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 May 2019 22:13:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41011 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfEPCNF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 May 2019 22:13:05 -0400
Received: by mail-io1-f67.google.com with SMTP id a17so1280692iot.8;
        Wed, 15 May 2019 19:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0BxXB4zPDiOOfyC+NP7YQ7W9WygH1f8j4Ibdj5jSx8=;
        b=S76E8BnFTqJFfu4hITlNf4d9W8fnZzuEvA185DDima+mNpq308pzJ3COKZlx0J5AOA
         Os2N/tdsun3xbqzO0VtqpNYCR71Q8NKBWpZdSWN9qZ/K5OhWVjP2Vr+m2bJ5qZaC1jsa
         XI+CbBrdGuEi6jUEipw8Ihhc/ctiy8WSB9nX/TM6OclzQPdQkMFTYQ20mj1P7b3SuFtx
         io16V5Zj2rPbRknnTwjvyg5tvPwve/eFqoLN/fL0hwZ57z5h4l6SJ5latqEABdoGuaCx
         1uOHk8RWuFqI8fwHiygyyUuhcID24gsu8mY46dvZLEN++WMjEGRvldJjLb5cgOEbl15j
         tZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0BxXB4zPDiOOfyC+NP7YQ7W9WygH1f8j4Ibdj5jSx8=;
        b=hX9g+MlcHdEY3A44njUHALkH7sJg6+a8DItF9Iq5kRHx15nPLbfiWoYn+irjBgYAK5
         Q7X0b74m0GBJ+Fm1JEUFWmbY0R0J6y4cWKrWbla4+bOYXO8b7jfw8kjQlW3l8MZyAVgu
         g8QCE+ZCBNdL71Z6BP8BIvzbW1OzyN63Zxn87Tyna8Kw3+AFIzob49KPcsPuTpume5/M
         Yi7aBMZEQuqiDdzQyy8K7nc6zIYaFzzaQnCthJeYAcG8q8DjdzZvLGzuIovYsWgyKf9r
         ZQ2h62+pkBsLNw08UGKTvnuZDAvZRCqJE6WHgfwqcIyARDy7+p6YMQVimCsD9+w1imW/
         rTfg==
X-Gm-Message-State: APjAAAVdvGnOQlvnhBPao13I7FfsEfqOnE+G9gwQeOdOXAtO3Q2dGoTN
        LOuLUkbZ2wWWq3bTmeTOk6/IO0PXuP51I9jqsRw=
X-Google-Smtp-Source: APXvYqyGzb4bjvcMT/XOKjMi0fgaWNblLuDguikeY9TTnJZwbOxuhHcZ1BRdqU1QMJBVWgJnwJJtH3xGoTQZxCc45tg=
X-Received: by 2002:a5e:a51a:: with SMTP id 26mr19026953iog.171.1557972783813;
 Wed, 15 May 2019 19:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <1556081835-12921-1-git-send-email-ley.foon.tan@intel.com>
 <1556081835-12921-2-git-send-email-ley.foon.tan@intel.com>
 <CAFiDJ59Pi6fxyE=0ifNJRoGc4QBX3XKJ=L7FXjJ_a6Vyh8otMg@mail.gmail.com> <20190515135933.GB30985@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190515135933.GB30985@e121166-lin.cambridge.arm.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Thu, 16 May 2019 10:12:52 +0800
Message-ID: <CAFiDJ5-1YncDFFES+vj2bnaRwq74RT=s0KB9FBpYFt-r9T+a2g@mail.gmail.com>
Subject: Re: [PATCH] PCI: altera-msi: Allow building as module
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 15, 2019 at 9:59 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, May 14, 2019 at 01:35:20PM +0800, Ley Foon Tan wrote:
> > On Wed, Apr 24, 2019 at 12:57 PM Ley Foon Tan <ley.foon.tan@intel.com> wrote:
> > >
> > > Altera MSI IP is a soft IP and is only available after
> > > FPGA image is programmed.
> > >
> > > Make driver modulable to support use case FPGA image is programmed
> > > after kernel is booted. User proram FPGA image in kernel then only load
> > > MSI driver module.
> > >
> > > Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> > > ---
> > >  drivers/pci/controller/Kconfig           |  2 +-
> > >  drivers/pci/controller/pcie-altera-msi.c | 10 ++++++++++
> > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > > index 4b550f9cdd56..920546cb84e2 100644
> > > --- a/drivers/pci/controller/Kconfig
> > > +++ b/drivers/pci/controller/Kconfig
> > > @@ -181,7 +181,7 @@ config PCIE_ALTERA
> > >           FPGA.
> > >
> > >  config PCIE_ALTERA_MSI
> > > -       bool "Altera PCIe MSI feature"
> > > +       tristate "Altera PCIe MSI feature"
> > >         depends on PCIE_ALTERA
> > >         depends on PCI_MSI_IRQ_DOMAIN
> > >         help
> > > diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
> > > index 025ef7d9a046..16d938920ca5 100644
> > > --- a/drivers/pci/controller/pcie-altera-msi.c
> > > +++ b/drivers/pci/controller/pcie-altera-msi.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/interrupt.h>
> > >  #include <linux/irqchip/chained_irq.h>
> > >  #include <linux/init.h>
> > > +#include <linux/module.h>
> > >  #include <linux/msi.h>
> > >  #include <linux/of_address.h>
> > >  #include <linux/of_irq.h>
> > > @@ -288,4 +289,13 @@ static int __init altera_msi_init(void)
> > >  {
> > >         return platform_driver_register(&altera_msi_driver);
> > >  }
> > > +
> > > +static void __exit altera_msi_exit(void)
> > > +{
> > > +       platform_driver_unregister(&altera_msi_driver);
> > > +}
> > > +
> > >  subsys_initcall(altera_msi_init);
> > > +MODULE_DEVICE_TABLE(of, altera_msi_of_match);
> > > +module_exit(altera_msi_exit);
> > > +MODULE_LICENSE("GPL v2");
> > > --
> > > 2.19.0
> > >
> > Hi
> >
> > Any comment for this patch?
>
> I will get to these patches for the next merge window, thanks.

Thanks.

Regards
Ley Foon
