Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BD02161EE
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 01:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGFXNL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 19:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGFXNK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 19:13:10 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEBEC08C5DF
        for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2020 16:13:10 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s9so47603795ljm.11
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2020 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SR19WDvOm+Jc/grBUK3DcAG61rsTa4WPLrkARxPZOAg=;
        b=l+Kck4QLh/GjDatFbN1XEqM3Tz6lakJhs3E9J1XdsBwYLSppoM1PHrBrrsnb5/v4tJ
         XrCDEAlLqxil2gTTmgd650zhncuLDENlO/0gQ/Y0lot0ofj1l6k0We1vcLPui5Eaq1nf
         iZF6FzBFsxbC5H78jo0pWHQ53RAsKmA0Ieq6QuSmcaxBJaXPxDUXAymnSm1l5bXyziUN
         E+k2/BSJGZ4dS3BsQdULyP/OQmSK4uXZTgrF/GtPuB6y8ObR8Hmqz1K86ft5+LQbtoy6
         szM/3+oamdz2utop5yBaSYUpEFUNKElOpbs79VyOw5ciwTV0x4aUw9N4u7XXeXRT0hYa
         w8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SR19WDvOm+Jc/grBUK3DcAG61rsTa4WPLrkARxPZOAg=;
        b=Z+dZ6ny+Ig6asUs7g+dhuQfkvY5CFGc1fiU+dX0rUN9Xiz9G2dwYzzvHeMXmfnuzmW
         pOpsJUAIjtjFm5dZrboRag9nQUwQCkVrAIz/ApcfGUqaI3treESE74wmErArqoD29lw2
         CnTP2BAjBK2TetNfX5dyc64lepgyRvDpyz2N5hYtOprEXbzmMKVU5Ely5oe4ToD/Ew7k
         KHnlC8PVz0cpnHCir7PKGNULgC1QPQi3clejPXv59oEd9pf8jIZy5P6IxC7DSaALxuKI
         ZLGkO1qD2Z69+qTvJJbYby1OSiyEkZoekL9NinVr+Py6MPDG0D5ex7m+fNDo01qHNSZa
         YfxQ==
X-Gm-Message-State: AOAM533458t53LokQCCHwK9cu65FTNLf2v5b4gW7sVOvHbSlyLO5/EeY
        hcp328uN0DF/9Na31ULLHkNhn2/mYU5w+4/040H77Q==
X-Google-Smtp-Source: ABdhPJxfpZUF/SiL6XakzrJYzR9zf4mbwwjNucTuoY4CEERAxdf2B8UbWftU6B65j4Lr/o8zaYhyCw9AyRNU1/YVzAk=
X-Received: by 2002:a05:651c:550:: with SMTP id q16mr28313693ljp.188.1594077188285;
 Mon, 06 Jul 2020 16:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-4-rajatja@google.com> <20200706164514.GA124720@bjorn-Precision-5520>
In-Reply-To: <20200706164514.GA124720@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 6 Jul 2020 16:12:31 -0700
Message-ID: <CACK8Z6EVgeTZLph4CWaztB1WavocMyN237FwDAZudtEa=_e3Cg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] PCI/ACS: Enable PCI_ACS_TB for untrusted/external-facing
 devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 6, 2020 at 9:45 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jun 29, 2020 at 09:49:39PM -0700, Rajat Jain wrote:
> > When enabling ACS, enable translation blocking for external facing ports
> > and untrusted devices.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v2: Commit log change
> >
> >  drivers/pci/pci.c    |  4 ++++
> >  drivers/pci/quirks.c | 11 +++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index d2ff987585855..79853b52658a2 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3330,6 +3330,10 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> >       /* Upstream Forwarding */
> >       ctrl |= (cap & PCI_ACS_UF);
> >
> > +     if (dev->external_facing || dev->untrusted)
> > +             /* Translation Blocking */
> > +             ctrl |= (cap & PCI_ACS_TB);
> > +
> >       pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> >  }
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index b341628e47527..6294adeac4049 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
> >       }
> >  }
> >
> > +/*
> > + * Currently this quirk does the equivalent of
> > + * PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV
> > + *
> > + * Currently missing, it also needs to do equivalent of PCI_ACS_TB,
> > + * if dev->external_facing || dev->untrusted
>
> I don't understand this comment.  Is this a "TODO"?  Is there
> something more that needs to be done here?

Yes. I'll mark it as a TODO to make it more clear.

>
> After a patch is applied, a comment should describe the code as it is.
>
> > + */
> >  static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
> >  {
> >       if (!pci_quirk_intel_pch_acs_match(dev))
> > @@ -4973,6 +4980,10 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
> >       ctrl |= (cap & PCI_ACS_CR);
> >       ctrl |= (cap & PCI_ACS_UF);
> >
> > +     if (dev->external_facing || dev->untrusted)
> > +             /* Translation Blocking */
> > +             ctrl |= (cap & PCI_ACS_TB);
> > +
> >       pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> >
> >       pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
