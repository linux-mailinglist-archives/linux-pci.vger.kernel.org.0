Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E6C3F2868
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 10:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhHTI3F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 04:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhHTI3D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Aug 2021 04:29:03 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC416C061575;
        Fri, 20 Aug 2021 01:28:25 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id z18so17408985ybg.8;
        Fri, 20 Aug 2021 01:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdq+Asx3o4yD/FR2CqSULa1+X944ILDoCu3HB23Mx3g=;
        b=IQY8gJ3jyuJ3XjjqiV9rSLsGOks9PtZ9qfZ+DFER9/NaUyiXkwo7JPkDV24/24kZSC
         0l8MjP2TWSvUnBYQD5ZEMTs564KjkJdpeAQfjhULoDTV1RFrwtl832ynm5e5tlWDWatB
         Vgz3EjBH0DWTr9Ha4oqxnKpQD9013TBMhkNXda8V0yoUVYmEstZn+tAdCi3iDKGGcfB3
         eDMnAejQkQ1MKJwSBPisfDBxYKlsTiC1iZJy/J/lJwFOZoVemVjrdL93Hr2aMOS2EBCJ
         TpTg8tR+awoDKsFzANZQduO2YB9OON13QYlBb8kT+XF/JTgHeXkhPJEebDXaBJuQvDBm
         Xt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdq+Asx3o4yD/FR2CqSULa1+X944ILDoCu3HB23Mx3g=;
        b=Vgq7Bt9DS6tfbLFjcuBCCMy4TxwnIr6D5znDnkpICU2e9q1zovWQhqwaL+O5BhOxaa
         ZYfeoUWPkoax6fuxFWbmhFJ0ef9U4lpazjzgwxAjJ4wOfjzmPPmL6c3k5LkdX+duH+qh
         i3j5eM8Xm+Ot/TbPJ3MYYnW2e9s4UQNAWtA1nvSsW8B0H4CRGYfbPqVi0QIXJ5av2kk2
         pluul0AllJts6okEFb/u+WNVN/VbJvy+ToTZy7EIviS05PDanad0SWgRb49AgpwVF0wi
         EP8zKYU5oG2scD/T6qXS4sJzvXMqqKwKk9lYCei/FyUBr0PdurOR+BfdNWKgWRLkIBsZ
         VKdA==
X-Gm-Message-State: AOAM5339Oe/9lCjrPB4Cs0ez8v6veFeaap7n4vqyMrxr+ltUHG02kko+
        mb44788B/FsKC6UrefLd1vfSy+BqL7QK6pC5FJ4=
X-Google-Smtp-Source: ABdhPJwOpjlOtYBbtglbGMf8WzHdOM7BhLlE+/8zkazTjw2cP4dcMowFABjZJBRD/o6Tzf5o7yn1a9pqm35FFBwBZiw=
X-Received: by 2002:a25:b08d:: with SMTP id f13mr24381577ybj.518.1629448104971;
 Fri, 20 Aug 2021 01:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210819145114.21074-1-lukas.bulwahn@gmail.com>
 <20210819150703.GA3204796@bjorn-Precision-5520> <20210819141053.17a8a540.alex.williamson@redhat.com>
In-Reply-To: <20210819141053.17a8a540.alex.williamson@redhat.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 20 Aug 2021 10:28:21 +0200
Message-ID: <CAKXUXMxM6oUkwP-YGDY1WEA8T0mCrR-5c-HLAjW-UrNotfHiCQ@mail.gmail.com>
Subject: Re: [PATCH] mei: improve Denverton HSM & IFSI support
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 19, 2021 at 10:10 PM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Thu, 19 Aug 2021 10:07:03 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > [+cc Alex]
> >
> > On Thu, Aug 19, 2021 at 04:51:14PM +0200, Lukas Bulwahn wrote:
> > > The Intel Denverton chip provides HSM & IFSI. In order to access
> > > HSM & IFSI at the same time, provide two HECI hardware IDs for accessing.
> > >
> > > Suggested-by: Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > ---
> > > Tomas, please pick this quick helpful extension for the hardware.
> > >
> > >  drivers/misc/mei/hw-me-regs.h | 3 ++-
> > >  drivers/misc/mei/pci-me.c     | 1 +
> > >  drivers/pci/quirks.c          | 3 +++
> > >  3 files changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
> > > index cb34925e10f1..c1c41912bb72 100644
> > > --- a/drivers/misc/mei/hw-me-regs.h
> > > +++ b/drivers/misc/mei/hw-me-regs.h
> > > @@ -68,7 +68,8 @@
> > >  #define MEI_DEV_ID_BXT_M      0x1A9A  /* Broxton M */
> > >  #define MEI_DEV_ID_APL_I      0x5A9A  /* Apollo Lake I */
> > >
> > > -#define MEI_DEV_ID_DNV_IE     0x19E5  /* Denverton IE */
> > > +#define MEI_DEV_ID_DNV_IE  0x19E5  /* Denverton for HECI1 - IFSI */
> > > +#define MEI_DEV_ID_DNV_IE_2        0x19E6  /* Denverton 2 for HECI2 - HSM */
> > >
> > >  #define MEI_DEV_ID_GLK        0x319A  /* Gemini Lake */
> > >
> > > diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
> > > index c3393b383e59..30827cd2a1c2 100644
> > > --- a/drivers/misc/mei/pci-me.c
> > > +++ b/drivers/misc/mei/pci-me.c
> > > @@ -77,6 +77,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
> > >     {MEI_PCI_DEVICE(MEI_DEV_ID_APL_I, MEI_ME_PCH8_CFG)},
> > >
> > >     {MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE, MEI_ME_PCH8_CFG)},
> > > +   {MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE_2, MEI_ME_PCH8_SPS_CFG)},
> > >
> > >     {MEI_PCI_DEVICE(MEI_DEV_ID_GLK, MEI_ME_PCH8_CFG)},
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 6899d6b198af..2ab767ef8469 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -4842,6 +4842,9 @@ static const struct pci_dev_acs_enabled {
> > >     { PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
> > >     { PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
> > >     { PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_rciep_acs },
> > > +   /* Denverton */
> > > +   { PCI_VENDOR_ID_INTEL, 0x19e5, pci_quirk_mf_endpoint_acs },
> > > +   { PCI_VENDOR_ID_INTEL, 0x19e6, pci_quirk_mf_endpoint_acs },
> >
> > This looks like it should be a separate patch with a commit log that
> > explains it.  For example, see these:
> >
> >   db2f77e2bd99 ("PCI: Add ACS quirk for Broadcom BCM57414 NIC")
> >   3247bd10a450 ("PCI: Add ACS quirk for Intel Root Complex Integrated Endpoints")
> >   299bd044a6f3 ("PCI: Add ACS quirk for Zhaoxin Root/Downstream Ports")
> >   0325837c51cb ("PCI: Add ACS quirk for Zhaoxin multi-function devices")
> >   76e67e9e0f0f ("PCI: Add ACS quirk for Amazon Annapurna Labs root ports")
> >   46b2c32df7a4 ("PCI: Add ACS quirk for iProc PAXB")
> >   01926f6b321b ("PCI: Add ACS quirk for HXT SD4800")
> >
> > It should be acked by somebody at Intel since this quirk relies on
> > behavior of the device for VM security.
>
> +1 Thanks Bjorn.  I got curious and AFAICT these functions are the
> interface for the host system to communicate with "Innovation Engine"
> processors within the SoC, which seem to be available for system
> builders to innovate and differentiate system firmware features.  I'm
> not sure then how we can assume a specific interface ("HSM" or "IFSI",
> whatever those are) for each function, nor of course how we can assume
> isolation between them.  Thanks,

Alex, I got a Denverton hardware with Innovation Engine and the
specific system firmware (basically delivered from Intel). To make use
of that hardware, someone at Intel suggested adding these PCI ACS
quirks. It is unclear to me if there are various different Denverton
systems out there (I only got one!) with many different system
firmware variants for the Innovation Engine or if there is just one
Denverton with IE support and with one firmware from Intel, i.e., the
one I got.

If there is only one or two variants of the Denverton with Innovation
Engine firmware out there, then we could add this ACS quirk here
unconditionally (basically assuming that if the other firmware is
there, the IE would just do the right thing, e.g., deny any operation
for a non-existing firmware function), right? Just adding a commit
similar to the commits Bjorn pointed out above. Otherwise, we would
need to make that conditional for possible different variants, but I
would need a bit more guidance from you on which other variants exist
and how one can differentiate between them.

Lukas
