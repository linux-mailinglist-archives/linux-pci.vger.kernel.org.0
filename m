Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A98CC2BB2
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 03:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfJABdN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 21:33:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46846 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfJABdN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 21:33:13 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so43436289ioo.13
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2019 18:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19/fqplMu5ncq+Zw3uRvu3m9c9STNF0irlcsoosW0Co=;
        b=al4gRHaeGg/cZqiZI795Rd78SRxqG84CjjJTGgVD1hrh/KEltmD3zrD7H7/JYMFpBj
         TWOtxGhfwU6fvTlF4F5oyov/65ob151+ZQd6YcgauSjW5ZulZxQpInvwLyCDUCl0UwFk
         s3t6vgSPNZ23BO6hvuEd/qDhD0lgGxHMrXoD2rZbjAkcd4G7CACCMeOtSQ+EW/rd0D1N
         ioClIyw4FzduHEDixVPXOzkX5qTCzOpv4ZS5g/OAacc8/JrLD2NVK8xYPsVOd5PLclIy
         XlxI8ZG1RPMy0TEc5EV+CpInsE6nRicSA+IIz1NipKdrArZxV72biLTev5UNbuDG8qcq
         i3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19/fqplMu5ncq+Zw3uRvu3m9c9STNF0irlcsoosW0Co=;
        b=nAPsBdvC4vzJeCy1F38BQDeYrMMMe2XpjHo4MnAoNjhnD5rp15ebMmz7CJCslQFqr7
         BWIeStuwMxHDRTQw2GlDgiYRIbS29e1GGtpwPJ1lzCXSMd4B3UBwKDXSYHIRs7cCtQp0
         FM4ZAIH5QB9HXfDLcxkPb7MzvaT3fOnqatVRfkrwwxHa/Ww+g6CUYcWvcln0kIATbYDN
         WJpyb2q0TPgLy8ZJD0JAAnWp+hcpM8ufuIlrb/HfUqeO3D8fW5Sxc3bROdW1CidcRlas
         CgP4bdSVj1PBJpTLnNxkSmtbe3UiB2x6Wc0aslORPvShk5xGJZQ1vVjNvDOx57RVVNHO
         A+Xw==
X-Gm-Message-State: APjAAAVDa2FdjtA9i7QcvxU3yYDzb0j1XeVA/xKjn0vO2SRLHItXlZbE
        dQAtwZqNyJ1xrbFGAOwVGbkoWK6S/2EQXfa3Ay8=
X-Google-Smtp-Source: APXvYqxoGSYSEq5KLwzbStd2aIGE9OIH0/k7KW8mb3xU3296xqnpTkwrsSzxIartHroxhzkiuVdW4vGI6APRF88Vwg0=
X-Received: by 2002:a92:cecc:: with SMTP id z12mr24175183ilq.293.1569893592169;
 Mon, 30 Sep 2019 18:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190930020848.25767-2-oohall@gmail.com> <20190930170948.GA154567@google.com>
In-Reply-To: <20190930170948.GA154567@google.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 1 Oct 2019 11:33:01 +1000
Message-ID: <CAOSf1CH0hmhrDNpi0TVeGD2uKfcEnv8+hd_z+KLuL-4=sOVeeA@mail.gmail.com>
Subject: Re: [PATCH 1/3] powernv/iov: Ensure the pdn for VFs always contains a
 valid PE number
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Shawn Anastasio <shawn@anastas.io>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 1, 2019 at 3:09 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Sep 30, 2019 at 12:08:46PM +1000, Oliver O'Halloran wrote:
>
> This is all powerpc, so I assume Michael will handle this.  Just
> random things I noticed; ignore if they don't make sense:
>
> > On PowerNV we use the pcibios_sriov_enable() hook to do two things:
> >
> > 1. Create a pci_dn structure for each of the VFs, and
> > 2. Configure the PHB's internal BARs that map MMIO ranges to PEs
> >    so that each VF has it's own PE. Note that the PE also determines
>
> s/it's/its/
>
> >    the IOMMU table the HW uses for the device.
> >
> > Currently we do not set the pe_number field of the pci_dn immediately after
> > assigning the PE number for the VF that it represents. Instead, we do that
> > in a fixup (see pnv_pci_dma_dev_setup) which is run inside the
> > pcibios_add_device() hook which is run prior to adding the device to the
> > bus.
> >
> > On PowerNV we add the device to it's IOMMU group using a bus notifier and
>
> s/it's/its/
>
> > in order for this to work the PE number needs to be known when the bus
> > notifier is run. This works today since the PE number is set in the fixup
> > which runs before adding the device to the bus. However, if we want to move
> > the fixup to a later stage this will break.
> >
> > We can fix this by setting the pdn->pe_number inside of
> > pcibios_sriov_enable(). There's no good to avoid this since we already have
>
> s/no good/no good reason/ ?
>
> Not quite sure what "this" refers to ... "no good reason to avoid
> setting pdn->pe_number in pcibios_sriov_enable()"?  The double
> negative makes it a little hard to parse.

I agree it's a bit vague, I'll re-word it.

> > all the required information at that point, so... do that. Moving this
> > earlier does cause two problems:
> >
> > 1. We trip the WARN_ON() in the fixup code, and
> > 2. The EEH core will clear pdn->pe_number while recovering VFs.
> >
> > The only justification for either of these is a comment in eeh_rmv_device()
> > suggesting that pdn->pe_number *must* be set to IODA_INVALID_PE in order
> > for the VF to be scanned. However, this comment appears to have no basis in
> > reality so just delete it.
> >
> > Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> > ---
> > Can't get rid of the fixup entirely since we need it to set the
> > ioda_pe->pdev back-pointer. I'll look at killing that another time.
> > ---
> >  arch/powerpc/kernel/eeh_driver.c          |  6 ------
> >  arch/powerpc/platforms/powernv/pci-ioda.c | 19 +++++++++++++++----
> >  arch/powerpc/platforms/powernv/pci.c      |  4 ----
> >  3 files changed, 15 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> > index d9279d0..7955fba 100644
> > --- a/arch/powerpc/kernel/eeh_driver.c
> > +++ b/arch/powerpc/kernel/eeh_driver.c
> > @@ -541,12 +541,6 @@ static void eeh_rmv_device(struct eeh_dev *edev, void *userdata)
> >
> >               pci_iov_remove_virtfn(edev->physfn, pdn->vf_index);
> >               edev->pdev = NULL;
> > -
> > -             /*
> > -              * We have to set the VF PE number to invalid one, which is
> > -              * required to plug the VF successfully.
> > -              */
> > -             pdn->pe_number = IODA_INVALID_PE;
> >  #endif
> >               if (rmv_data)
> >                       list_add(&edev->rmv_entry, &rmv_data->removed_vf_list);
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index 5e3172d..70508b3 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -1558,6 +1558,10 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
> >
> >       /* Reserve PE for each VF */
> >       for (vf_index = 0; vf_index < num_vfs; vf_index++) {
> > +             int vf_devfn = pci_iov_virtfn_devfn(pdev, vf_index);
> > +             int vf_bus = pci_iov_virtfn_bus(pdev, vf_index);
> > +             struct pci_dn *vf_pdn;
> > +
> >               if (pdn->m64_single_mode)
> >                       pe_num = pdn->pe_num_map[vf_index];
> >               else
> > @@ -1570,13 +1574,11 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
> >               pe->pbus = NULL;
> >               pe->parent_dev = pdev;
> >               pe->mve_number = -1;
> > -             pe->rid = (pci_iov_virtfn_bus(pdev, vf_index) << 8) |
> > -                        pci_iov_virtfn_devfn(pdev, vf_index);
> > +             pe->rid = (vf_bus << 8) | vf_devfn;
> >
> >               pe_info(pe, "VF %04d:%02d:%02d.%d associated with PE#%x\n",
>
> Not related to *this* patch, but this looks like maybe it's supposed
> to match the pci_name(), e.g., "%04x:%02x:%02x.%d" from
> pci_setup_device()?  If so, the "%04d:%02d:%02d" here will be
> confusing since the decimal & hex won't always match.

That looks plain wrong. I'll send a separate patch to fix it.

> >                       hose->global_number, pdev->bus->number,
>
> Consider pci_domain_nr(bus) instead of hose->global_number?  It would
> be nice if you had the pci_dev * for each VF so you could just use
> pci_name(vf) instead of all this domain/bus/PCI_SLOT/FUNC.

Unfortunately, we don't have pci_devs for the VFs when
pcibios_sriov_enable() is called. On powernv (and pseries) we only
permit config accesses to a BDF when a pci_dn exists for that BDF
because the platform code assumes that one will exist. As a result we
can't scan the VFs until after pcibios_sriov_enable() is called since
that's where pci_dn's are created for the VFs. I'm working on removing
the use of pci_dn from powernv entirely though. Once that's done we
should revisit whether any of this infrastructure is necessary...

Oliver
