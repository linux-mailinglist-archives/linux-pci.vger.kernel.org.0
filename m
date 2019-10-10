Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB393D3282
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 22:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfJJUhk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 16:37:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36002 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfJJUhk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2019 16:37:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id 67so6089199oto.3;
        Thu, 10 Oct 2019 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d92cz9+ek3jXcWrW3Uf8eUh6Gt1ObIFPj64rzYVpR8k=;
        b=g50Sz/pHnHWExn1i1sgk7vVB9BcieHWp6Sk5NUgysb1A3vs/bYYW9MFMq17sbay5d8
         vIGA9a0EOOGRvo0a9iINfHslrC6B/a9/kjk9fddflW8/7EMdT1l6VZyDv555UAuHCgM5
         bRCuicOkEkNpJq3V+lBWaFC+mJ4AJhHZxiGvEZnsBIyqpHCsvc99VPrnXpDJkuJFCqlh
         5IeqwjW7XtHH3V8VbvDk/hRoyzG0GrJDf4m57OHSJf8LHzq2MLRsHMezN3hc+dycxLo3
         IQm18YIyVqPTz92ggQU+wUYODJzmjZrHvvYzefkCQYamEaYVw1qKQ/PrjC+2LviZ0pIh
         K9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d92cz9+ek3jXcWrW3Uf8eUh6Gt1ObIFPj64rzYVpR8k=;
        b=PROYDeJ2jxFc9IbPzMDjV/ETjZQ+cVQ35/kFEp/tKY3MktVOWfgzg3JHF4Yr+bWS6z
         MLZFgayEyUZrsKw+tGuzjNgdRgafbnBfkKPe3DYiRmnEDn985cDViHSPoJBrKrWRCdtM
         Evd356CB2d2NLSTVRUHG0n+X6ftyGep/VomReCT0b8P+MVtd2LdcI0xc1Ha4DHpZQ+fL
         HF+Vjk9OA2MUktDxeSkYpc6uG2apxGSJmaEPwIfIUnwSFpkNxPPj1VHHxipzyH+oTK77
         nimSQPRQkSgZs/2XhZ5ujRGXfJSq/DFUzJ3AawGqy4wsTGayC3pPHbeYmtUMvLimfdOo
         NhFQ==
X-Gm-Message-State: APjAAAVbOvIdXzAq29gDev/rVclO9/Olrj3dDSzi+J2ikZ/aRiVaWODU
        DIeqDxWVvA00I/2TVD6AfZ5LWaxhUEQA9hFox18=
X-Google-Smtp-Source: APXvYqxpzB8h705YHdZ4X2xWMlt6+O4+yxqxb1NZRABO9Jutpieby+Bzd4GgM8hRpmlaWMNIxLUxB7WuWvjRnkZ0qzM=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr9238640otb.193.1570739859383;
 Thu, 10 Oct 2019 13:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191009200523.8436-1-stuart.w.hayes@gmail.com>
 <20191009200523.8436-3-stuart.w.hayes@gmail.com> <CAHp75Vc1mZ7qxKPGaqDVAQ9d_UjNq9LJDEPWHQHaYCfw7vGrmA@mail.gmail.com>
 <CAHp75VfNjnAxua6ESx1Vp=57O=pVM10P1UK8bGNQUk7FeY=Dmw@mail.gmail.com>
In-Reply-To: <CAHp75VfNjnAxua6ESx1Vp=57O=pVM10P1UK8bGNQUk7FeY=Dmw@mail.gmail.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Date:   Thu, 10 Oct 2019 15:37:28 -0500
Message-ID: <CAL5oW02uRk-ZLMaE6Skt7rX6xy=sQNttfSZ2N1JRBXPfjJpZNg@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: pciehp: Wait for PDS if in-band presence is disabled
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 10, 2019 at 12:40 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Oct 10, 2019 at 8:37 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Oct 9, 2019 at 11:05 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>
> > > +static void pcie_wait_for_presence(struct pci_dev *pdev)
> > > +{
> > > +       int timeout = 1250;
>
> > > +       bool pds;
>
> Also this is redundant. Just use the following outside the loop
>
>  if (!retries)
>    pc_info(...);
>
> .
>
> > > +       u16 slot_status;
> > > +
> > > +       while (true) {
> > > +               pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> > > +               pds = !!(slot_status & PCI_EXP_SLTSTA_PDS);
> > > +               if (pds || timeout <= 0)
> > > +                       break;
> > > +               msleep(10);
> > > +               timeout -= 10;
> > > +       }
> >
> > Can we avoid infinite loops? They are hard to parse (in most cases,
> > and especially when it's a timeout loop)
> >
> > unsigned int retries = 125; // 1250 ms
> >
> > do {
> >  ...
> > } while (--retries);
> >
> > > +
> > > +       if (!pds)
> > > +               pci_info(pdev, "Presence Detect state not set in 1250 msec\n");
> > > +}
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
>
>
>
> --
> With Best Regards,
> Andy Shevchenko

Thank you for the feedback!  An infinite loop is used several other places in
this driver--this keeps the style similar.  I can change it as you suggest,
though, if that would be preferable to consistency.
