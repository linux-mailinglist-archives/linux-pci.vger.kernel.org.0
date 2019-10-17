Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12382DAEB4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 15:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436804AbfJQNsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 09:48:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40616 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394727AbfJQNsE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 09:48:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id m61so3629223qte.7;
        Thu, 17 Oct 2019 06:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9F1NynHBe9lfMAB/ZrN6cWXHTh5u4L4sRwtLfhngWc=;
        b=G+facC80VhcAvLi/e6A7TrduLWn0vD2qJhwCrXCQM3M5ILpu7FXJbXruo/38blvJR5
         Q9oLLeaCrnK44x/5Iju8xFk4HjeGNEu8EJAtJzKdeJlU40QpeDu7KikFtBXkeL0EpofJ
         Wehvt2p6B7cM8Ub1BPoCUh1tIiWug2UFg00NAXwu2T5EdY7duo662MRQQA7vMfPtBnhr
         mSqkgU+scwS6+zqRnMWS7LazQ3L7sA34yyI+rqDVn03k9VJD5ALQzh3dMciU948nlxoP
         Ajitc4MmV6M46JL/91n4aTOi2mOmgoZmFwpYshjmkKfcEHKHbS4m3FA4/c2VYhRbCjXb
         m+VQ==
X-Gm-Message-State: APjAAAXSOsXBzY9+d6+zJ5ejcNPbiEEoJ/ZVzs78OY1c9awftUPobS52
        m83lQK0zdCOJUPsfVDy9gK4P7r7Z5trw6EQGUrU=
X-Google-Smtp-Source: APXvYqxrCvbM940pdLdmtVqE4d93GXlx6MUaBU251o7f5GEXzpxhDY9oTpugTTbJy9ZdJgE4C/nnBZc9xI85Q3+56Lw=
X-Received: by 2002:a0c:c70a:: with SMTP id w10mr3972472qvi.222.1571320083293;
 Thu, 17 Oct 2019 06:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190930121520.1388317-1-arnd@arndb.de> <20190930121520.1388317-3-arnd@arndb.de>
 <MN2PR20MB2973D14C38B7BC7E081A73A9CA6D0@MN2PR20MB2973.namprd20.prod.outlook.com>
In-Reply-To: <MN2PR20MB2973D14C38B7BC7E081A73A9CA6D0@MN2PR20MB2973.namprd20.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Oct 2019 15:47:47 +0200
Message-ID: <CAK8P3a3+UrqS0nQxcG7UuMt4s5FDnowFq-C5-K5XU-CKpciM8g@mail.gmail.com>
Subject: Re: [PATCH 3/3] crypto: inside-secure - Remove #ifdef checks
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pascal van Leeuwen <pascalvanl@gmail.com>,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 17, 2019 at 3:26 PM Pascal Van Leeuwen
<pvanleeuwen@verimatrix.com> wrote:

> >       /* Register PCI driver */
> > -     pcireg_rc = pci_register_driver(&safexcel_pci_driver);
> > -#endif
> > +     ret = pci_register_driver(&safexcel_pci_driver);
> >
> > -#if IS_ENABLED(CONFIG_OF)
> >       /* Register platform driver */
> > -     ofreg_rc = platform_driver_register(&crypto_safexcel);
> > - #if IS_ENABLED(CONFIG_PCI)
> > -     /* Return success if either PCI or OF registered OK */
> > -     return pcireg_rc ? ofreg_rc : 0;
> > - #else
> > -     return ofreg_rc;
> > - #endif
> > -#else
> > - #if IS_ENABLED(CONFIG_PCI)
> > -     return pcireg_rc;
> > - #else
> > -     return -EINVAL;
> > - #endif
> > -#endif
> > +     if (IS_ENABLED(CONFIG_OF) && !ret) {
> >
> Hmm ... this would make it skip the OF registration if the PCIE
> registration failed. Note that the typical embedded  system will
> have a PCIE subsystem (e.g. Marvell A7K/A8K does) but will have
> the EIP embedded on the SoC as an OF device.
>
> So the question is: is it possible somehow that PCIE registration
> fails while OF registration does pass? Because in that case, this
> code would be wrong ...

I don't see how it would fail. When CONFIG_PCI is disabled,
pci_register_driver() does nothing, and the pci_driver as well
as everything referenced from it will be silently dropped from
the object file.
If CONFIG_PCI is enabled, then the driver will be registered
to the PCI subsystem, waiting for a device to show up, but
the driver registration does not care about whether there is
such a device.

> Other than that, I don't care much how this code is implemented
> as long as it works for both my use cases, being an OF embedded
> device (on a SoC _with_ or _without_ PCIE support) and a device
> on a PCIE board in a PCI (which has both PCIE and OF support).

Yes, that should be fine. There are a lot of drivers that support
multiple bus interfaces, and this is the normal way to handle them.

    Arnd
