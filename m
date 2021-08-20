Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065333F31F3
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 19:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhHTRF3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 13:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231512AbhHTRF2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Aug 2021 13:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629479089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMZf1Dr+VIH/M+CopQ+a4FGjGR8VCJ2zmAp1aqpZ8T8=;
        b=TMFOUfBXoVasZu6hS7pLaL7iMUacI4d6OwdUwCQkifkIfC7hDwEiGQ6iN3V6VraB3vKuiK
        01Jo2ZT/iuMUPGr+nBvYG5qunLOgM/fqtcuxQv9YRUPe6erBbAWGPCs0RfAtg6VnS9v/dE
        LkLj6esyW0gDcVk2nrf3qSogVPF0Udc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-VbCde7iyORaggaP3SNQ1_w-1; Fri, 20 Aug 2021 13:04:46 -0400
X-MC-Unique: VbCde7iyORaggaP3SNQ1_w-1
Received: by mail-io1-f71.google.com with SMTP id h3-20020a056602008300b005b7c0e23e11so5809168iob.4
        for <linux-pci@vger.kernel.org>; Fri, 20 Aug 2021 10:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NMZf1Dr+VIH/M+CopQ+a4FGjGR8VCJ2zmAp1aqpZ8T8=;
        b=iUGbzz88Onp3A7SHRJHHjxU/iTLhe9KUi1m6VfjfRGLW7VWn84kOr0zG8zhm6S1dKZ
         JDijWT5q/QgpWuZOlVdpVK0w6dCxdRa+ZO+konVv1gXx+rs7kf+BsoYvcK3zKQ2WAePs
         X2ZpgkB1w39268cEsg7EXVzJZ/QdLueOQ0aGxE7VwkHPGOs5LsBP0caIJY09dwVqj2jH
         /MhpOaGvdjigyzxmJYoWwXRwc0PQEDm8G4eN3r4ulBhDfG3T7RSUfJ2n0QIggRHQOo8y
         yVkQ8IwJ9XupKsT3qAjs/Ej5L/SVWbb/Tr0JP5TTpiwWHHom4+WT2HdLPx1Wtn0nVsBq
         jZsw==
X-Gm-Message-State: AOAM532V1SNVGKn/MZ31c1lKGAc9/XFoNZBxgBI5H0TpV4KFKIJW9A2x
        y69RR33Cp6tVy3cekF0LUma56LHTs5yGiLymKlDYEkose+am1N0Sz9Tn3KCYEfgtm5nkRknIgS9
        dtBkl/fVJWOivanh5TmNr
X-Received: by 2002:a02:cb05:: with SMTP id j5mr18833724jap.94.1629479085983;
        Fri, 20 Aug 2021 10:04:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUidvCH829mnTDoRa2liI8eh7VaTEQCmURVOjPMzikEG8F69QSPdnsLsPsmqRLXPDVS4fVaw==
X-Received: by 2002:a02:cb05:: with SMTP id j5mr18833705jap.94.1629479085756;
        Fri, 20 Aug 2021 10:04:45 -0700 (PDT)
Received: from redhat.com (c-73-14-100-188.hsd1.co.comcast.net. [73.14.100.188])
        by smtp.gmail.com with ESMTPSA id i18sm3643445ilk.84.2021.08.20.10.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:04:45 -0700 (PDT)
Date:   Fri, 20 Aug 2021 11:04:43 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mei: improve Denverton HSM & IFSI support
Message-ID: <20210820110443.0c86c1ce.alex.williamson@redhat.com>
In-Reply-To: <CAKXUXMzr50u_YVZ51Hb3_hXQ-w1N4orogJR5VO1-QgQf_+3imw@mail.gmail.com>
References: <20210819145114.21074-1-lukas.bulwahn@gmail.com>
        <20210819150703.GA3204796@bjorn-Precision-5520>
        <20210819141053.17a8a540.alex.williamson@redhat.com>
        <CAKXUXMxM6oUkwP-YGDY1WEA8T0mCrR-5c-HLAjW-UrNotfHiCQ@mail.gmail.com>
        <20210820094545.1f62dde1.alex.williamson@redhat.com>
        <CAKXUXMzr50u_YVZ51Hb3_hXQ-w1N4orogJR5VO1-QgQf_+3imw@mail.gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 20 Aug 2021 18:25:04 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> On Fri, Aug 20, 2021 at 5:45 PM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Fri, 20 Aug 2021 10:28:21 +0200
> > Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > =20
> > > On Thu, Aug 19, 2021 at 10:10 PM Alex Williamson
> > > <alex.williamson@redhat.com> wrote: =20
> > > >
> > > > On Thu, 19 Aug 2021 10:07:03 -0500
> > > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > =20
> > > > > [+cc Alex]
> > > > >
> > > > > On Thu, Aug 19, 2021 at 04:51:14PM +0200, Lukas Bulwahn wrote: =20
> > > > > > The Intel Denverton chip provides HSM & IFSI. In order to access
> > > > > > HSM & IFSI at the same time, provide two HECI hardware IDs for =
accessing.
> > > > > >
> > > > > > Suggested-by: Ionel-Catalin Mititelu <ionel-catalin.mititelu@in=
tel.com>
> > > > > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > > > > ---
> > > > > > Tomas, please pick this quick helpful extension for the hardwar=
e.
> > > > > >
> > > > > >  drivers/misc/mei/hw-me-regs.h | 3 ++-
> > > > > >  drivers/misc/mei/pci-me.c     | 1 +
> > > > > >  drivers/pci/quirks.c          | 3 +++
> > > > > >  3 files changed, 6 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/h=
w-me-regs.h
> > > > > > index cb34925e10f1..c1c41912bb72 100644
> > > > > > --- a/drivers/misc/mei/hw-me-regs.h
> > > > > > +++ b/drivers/misc/mei/hw-me-regs.h
> > > > > > @@ -68,7 +68,8 @@
> > > > > >  #define MEI_DEV_ID_BXT_M      0x1A9A  /* Broxton M */
> > > > > >  #define MEI_DEV_ID_APL_I      0x5A9A  /* Apollo Lake I */
> > > > > >
> > > > > > -#define MEI_DEV_ID_DNV_IE     0x19E5  /* Denverton IE */
> > > > > > +#define MEI_DEV_ID_DNV_IE  0x19E5  /* Denverton for HECI1 - IF=
SI */
> > > > > > +#define MEI_DEV_ID_DNV_IE_2        0x19E6  /* Denverton 2 for =
HECI2 - HSM */
> > > > > >
> > > > > >  #define MEI_DEV_ID_GLK        0x319A  /* Gemini Lake */
> > > > > >
> > > > > > diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-m=
e.c
> > > > > > index c3393b383e59..30827cd2a1c2 100644
> > > > > > --- a/drivers/misc/mei/pci-me.c
> > > > > > +++ b/drivers/misc/mei/pci-me.c
> > > > > > @@ -77,6 +77,7 @@ static const struct pci_device_id mei_me_pci_=
tbl[] =3D {
> > > > > >     {MEI_PCI_DEVICE(MEI_DEV_ID_APL_I, MEI_ME_PCH8_CFG)},
> > > > > >
> > > > > >     {MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE, MEI_ME_PCH8_CFG)},
> > > > > > +   {MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE_2, MEI_ME_PCH8_SPS_CFG)},
> > > > > >
> > > > > >     {MEI_PCI_DEVICE(MEI_DEV_ID_GLK, MEI_ME_PCH8_CFG)},
> > > > > >
> > > > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > > > index 6899d6b198af..2ab767ef8469 100644
> > > > > > --- a/drivers/pci/quirks.c
> > > > > > +++ b/drivers/pci/quirks.c
> > > > > > @@ -4842,6 +4842,9 @@ static const struct pci_dev_acs_enabled {
> > > > > >     { PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
> > > > > >     { PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
> > > > > >     { PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_rciep_acs },
> > > > > > +   /* Denverton */
> > > > > > +   { PCI_VENDOR_ID_INTEL, 0x19e5, pci_quirk_mf_endpoint_acs },
> > > > > > +   { PCI_VENDOR_ID_INTEL, 0x19e6, pci_quirk_mf_endpoint_acs },=
 =20
> > > > >
> > > > > This looks like it should be a separate patch with a commit log t=
hat
> > > > > explains it.  For example, see these:
> > > > >
> > > > >   db2f77e2bd99 ("PCI: Add ACS quirk for Broadcom BCM57414 NIC")
> > > > >   3247bd10a450 ("PCI: Add ACS quirk for Intel Root Complex Integr=
ated Endpoints")
> > > > >   299bd044a6f3 ("PCI: Add ACS quirk for Zhaoxin Root/Downstream P=
orts")
> > > > >   0325837c51cb ("PCI: Add ACS quirk for Zhaoxin multi-function de=
vices")
> > > > >   76e67e9e0f0f ("PCI: Add ACS quirk for Amazon Annapurna Labs roo=
t ports")
> > > > >   46b2c32df7a4 ("PCI: Add ACS quirk for iProc PAXB")
> > > > >   01926f6b321b ("PCI: Add ACS quirk for HXT SD4800")
> > > > >
> > > > > It should be acked by somebody at Intel since this quirk relies on
> > > > > behavior of the device for VM security. =20
> > > >
> > > > +1 Thanks Bjorn.  I got curious and AFAICT these functions are the
> > > > interface for the host system to communicate with "Innovation Engin=
e"
> > > > processors within the SoC, which seem to be available for system
> > > > builders to innovate and differentiate system firmware features.  I=
'm
> > > > not sure then how we can assume a specific interface ("HSM" or "IFS=
I",
> > > > whatever those are) for each function, nor of course how we can ass=
ume
> > > > isolation between them.  Thanks, =20
> > >
> > > Alex, I got a Denverton hardware with Innovation Engine and the
> > > specific system firmware (basically delivered from Intel). To make use
> > > of that hardware, someone at Intel suggested adding these PCI ACS
> > > quirks. It is unclear to me if there are various different Denverton
> > > systems out there (I only got one!) with many different system
> > > firmware variants for the Innovation Engine or if there is just one
> > > Denverton with IE support and with one firmware from Intel, i.e., the
> > > one I got.
> > >
> > > If there is only one or two variants of the Denverton with Innovation
> > > Engine firmware out there, then we could add this ACS quirk here
> > > unconditionally (basically assuming that if the other firmware is
> > > there, the IE would just do the right thing, e.g., deny any operation
> > > for a non-existing firmware function), right? Just adding a commit
> > > similar to the commits Bjorn pointed out above. Otherwise, we would
> > > need to make that conditional for possible different variants, but I
> > > would need a bit more guidance from you on which other variants exist
> > > and how one can differentiate between them. =20
> >
> > Hi Lukas,
> >
> > I'm looking at the C3000 datasheet, Intel document #337018-002, where I
> > see:
> >
> > 1.2.7 Innovation Engine (IE)
> >         ...
> >         For the IE, the system builder can install an embedded
> >         operating system, drivers and application they develop on their
> >         own, or purchase them from a third-party vendor. Intel does not
> >         provide operating systems, drivers or applications for the IE.
> > =20
>=20
> Well, IMHO, my observation of what Intel provided to me clearly
> contradicts that statement. It seems that Intel did provide an
> operating system, driver and applications for the IE, and suggested
> modifying/extending the kernel sources for that purpose beyond what
> was already existing in the kernel tree, which already suggests by
> itself that Intel has a specific driver and application for the IE in
> mind.

But in your case is Intel both the SoC vendor and system builder?  It's
specifically noted below that Intel does not provide a complete IE FW
solution to 3rd parties, regardless of any standardization that might
(or might not) exist among Intel developed solutions based on this SoC.
This doesn't contradict the datasheet.
=20
> > 15.2.3.1 Interrupt Timer Sub System (ITSS)
> >         ...
> >         The Innovation Engine (IE) has a sideband connection to the
> >         ITSS components.
> >
> > 16 Power Management Controller (PMC)
> >         ...
> >         16.2 Feature List
> >                 ...
> >                 =E2=80=A2 Interacts with the SoC Innovation Engine (IE)
> >
> > Table 16-4. Causes of SMI and SCI
> >         ...
> >         [IE can cause SMI or SCI]
> >
> > 16.10.1 Initiating State Changes when in the G0 (S0) Working State
> >         ...
> >         The Intel=C2=AE Management Engine and Innovation Engine firmware
> >         each has a mechanism to turn off a hung system similar to
> > the Power-Button Override by writing bits in their power-management
> >         control registers.
> >
> > And the apparent coup de gr=C3=A2ce:
> >
> > 37 Innovation Engine
> >         The Innovation Engine (IE) is an optional, complete,
> > embedded engine intended to enable SoC customers to provide their
> > own custom system management. This chapter provides a brief
> >         overview of the IE. It is reserved for system-builder code,
> > not for Intel firmware since Intel supplies IE hardware only. IE
> >         activation is not required for normal system operation.
> >         ...
> >         IE is a completely optional feature, and is disabled by
> > default in the silicon. It can be enabled by system builders and
> > OEMs to run signed firmware created by the system builder or a third
> >         party software vendor. IE is not like the Intel=C2=AE Management
> >         Engine (Intel=C2=AE ME) where Intel provides the HW plus a
> > complete FW solution. Intel only provides IE hardware (along with
> >         collateral and tools enabling).
> >
> > For the HECI, I see:
> >
> > 37.3 Architectural Overview
> >         ...
> >         The devices exposed by the IE subsystem to the Host Root
> > Space are:
> >                 =E2=80=A2 HECI (1, 2 and 3) =E2=80=93 These functions d=
efine the
> >                   mechanism for host software and IE firmware to
> >                   communicate. This device exposes three PCI
> > functions to the host during PCI bus enumeration. The message
> >                   format is OEM dependent and communication between
> >                   host and IE subsystem takes place via circular
> >                   buffers and control/status registers. This
> > function supports host MSI, SMI and SCI# interrupt generation
> >                   mechanisms.
> >
> >
> > So I don't see how the datasheet supports that there's either any
> > specific API defined per HECI interface or that these functions
> > would ever be intended in a generic way for independent use of by a
> > userspace driver or VM.  Perhaps with DMI or ACPI info an HECI
> > could be associated to a specific vendor API, by why we'd describe
> > them as using isolated IOMMU grouping is a complete mystery to me.
> > Thanks,=20
>=20
> I agree with that mystery, but I do not know if I should rather trust
> the Intel documentation you cite or simply the bits and pieces that
> already landed in the kernel tree here for the Denverton IE.
>=20
> Am I right that we are basically stuck here without any further
> explanation by somebody from Intel?
>=20
> Do I also get it right that:
>=20
> If we would trust the Intel documentation, we would not really see the
> purpose of the existing line
> MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE, MEI_ME_PCH8_CFG) in
> drivers/misc/mei/pci-me.c, added with commit f7ee8ead151f ("mei: me:
> add denverton innovation engine device IDs"), because that also
> depends on the existence of a specific system-builder code?

The existing entry was added by Tomas in commit f7ee8ead151f ("mei: me:
add denverton innovation engine device IDs") which claims IE is an
ME-like device which provides HW security offload.  I expect there is
the ability to provide such an offload, but I'm afraid this was added
relative to a specific implementation of IE that we really can't
determine by the device ID alone according to the datasheet.

I don't know the MEI code, does it further probe for a compatible
software interface on these device IDs or are we likely to run into the
weeds?

I think we're stuck without some public comment from Intel.  I don't
necessarily have high confidence in the existing entry.  Thanks,

Alex

