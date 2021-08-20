Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C383F2FEE
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241304AbhHTPq3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 11:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241204AbhHTPq2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Aug 2021 11:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629474350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHszTNWWcRskVDzdZXlLHDswkAE20E1/YSogilkamCc=;
        b=M0g6ZHqlh1/QtcxvBiaoSt5a8VXGT4P36KAB7Wvboo0T8XMtwSt0bD6kkVcFxFhCvHhnAt
        g+UmFdJw/QoIwV/D4Sobj07nFSGjI9dvdq2CswhQxC4GoCTIDTGfDf7t56uafRbqVMCNml
        xBIXo5IHvZK4wt6Nl5S+9GvTB9Ckv0I=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-UOH6f2mXPQO85xf6hcnqPQ-1; Fri, 20 Aug 2021 11:45:48 -0400
X-MC-Unique: UOH6f2mXPQO85xf6hcnqPQ-1
Received: by mail-il1-f200.google.com with SMTP id j6-20020a056e02014600b00224bde51e20so4232381ilr.5
        for <linux-pci@vger.kernel.org>; Fri, 20 Aug 2021 08:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=uHszTNWWcRskVDzdZXlLHDswkAE20E1/YSogilkamCc=;
        b=LvLUfrEC5tY1C7dUI3fdW1xBrK17KSaNZZ+uVi6HfamTYUEo0L41jEwyIaZ1eiDefP
         t8apIBK2cGHvSvJp/8MJ1KO5EH/0b6HN3fx7RuuHzE18b3hv9crLGI2GTRhJklrPHOkJ
         OiT75wgdNbonfeQH5NRPBSKX5zm33wshkAF48naeA1DWMqSSwIVCmFQmEDKlKwZYV6xI
         fwvUe5SUFZoEifdxol41/gcWpWeBEyDARg9gDxPe9NqND/kVSwE97dZq7f3ZgYIf9Inc
         IRYQx/UKXyq13EJHZ0Ptrkkm7OciARW3/h//wk36884QcTCCDG/NeiZAfX6uVlywD9tf
         8Ibw==
X-Gm-Message-State: AOAM532uLx9QzoX6NgNfLdoqVwp/7zm10UzpojDFrW8s4Jh25XGeRR/Q
        xL0knq+8bE0KEtTAyuGqJH4vqhClhrG+BAVBzKpxm/OISwGNpglwzKj4PEEa4A5qyzB7hsFUP5f
        cOhUr23q2nLW/aFvbFFr0
X-Received: by 2002:a92:730d:: with SMTP id o13mr14120052ilc.183.1629474348078;
        Fri, 20 Aug 2021 08:45:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg2sjYKFA9AAWfuBbHn5L0SErcEsE1gs6oiT41MLFTDJOtnKXglu2pDmfySls1D7mHv8Hm/A==
X-Received: by 2002:a92:730d:: with SMTP id o13mr14120023ilc.183.1629474347574;
        Fri, 20 Aug 2021 08:45:47 -0700 (PDT)
Received: from redhat.com (c-73-14-100-188.hsd1.co.comcast.net. [73.14.100.188])
        by smtp.gmail.com with ESMTPSA id j18sm3461883ioa.53.2021.08.20.08.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:45:47 -0700 (PDT)
Date:   Fri, 20 Aug 2021 09:45:45 -0600
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
Message-ID: <20210820094545.1f62dde1.alex.williamson@redhat.com>
In-Reply-To: <CAKXUXMxM6oUkwP-YGDY1WEA8T0mCrR-5c-HLAjW-UrNotfHiCQ@mail.gmail.com>
References: <20210819145114.21074-1-lukas.bulwahn@gmail.com>
        <20210819150703.GA3204796@bjorn-Precision-5520>
        <20210819141053.17a8a540.alex.williamson@redhat.com>
        <CAKXUXMxM6oUkwP-YGDY1WEA8T0mCrR-5c-HLAjW-UrNotfHiCQ@mail.gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 20 Aug 2021 10:28:21 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> On Thu, Aug 19, 2021 at 10:10 PM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Thu, 19 Aug 2021 10:07:03 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > =20
> > > [+cc Alex]
> > >
> > > On Thu, Aug 19, 2021 at 04:51:14PM +0200, Lukas Bulwahn wrote: =20
> > > > The Intel Denverton chip provides HSM & IFSI. In order to access
> > > > HSM & IFSI at the same time, provide two HECI hardware IDs for acce=
ssing.
> > > >
> > > > Suggested-by: Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.=
com>
> > > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > > ---
> > > > Tomas, please pick this quick helpful extension for the hardware.
> > > >
> > > >  drivers/misc/mei/hw-me-regs.h | 3 ++-
> > > >  drivers/misc/mei/pci-me.c     | 1 +
> > > >  drivers/pci/quirks.c          | 3 +++
> > > >  3 files changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me=
-regs.h
> > > > index cb34925e10f1..c1c41912bb72 100644
> > > > --- a/drivers/misc/mei/hw-me-regs.h
> > > > +++ b/drivers/misc/mei/hw-me-regs.h
> > > > @@ -68,7 +68,8 @@
> > > >  #define MEI_DEV_ID_BXT_M      0x1A9A  /* Broxton M */
> > > >  #define MEI_DEV_ID_APL_I      0x5A9A  /* Apollo Lake I */
> > > >
> > > > -#define MEI_DEV_ID_DNV_IE     0x19E5  /* Denverton IE */
> > > > +#define MEI_DEV_ID_DNV_IE  0x19E5  /* Denverton for HECI1 - IFSI */
> > > > +#define MEI_DEV_ID_DNV_IE_2        0x19E6  /* Denverton 2 for HECI=
2 - HSM */
> > > >
> > > >  #define MEI_DEV_ID_GLK        0x319A  /* Gemini Lake */
> > > >
> > > > diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
> > > > index c3393b383e59..30827cd2a1c2 100644
> > > > --- a/drivers/misc/mei/pci-me.c
> > > > +++ b/drivers/misc/mei/pci-me.c
> > > > @@ -77,6 +77,7 @@ static const struct pci_device_id mei_me_pci_tbl[=
] =3D {
> > > >     {MEI_PCI_DEVICE(MEI_DEV_ID_APL_I, MEI_ME_PCH8_CFG)},
> > > >
> > > >     {MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE, MEI_ME_PCH8_CFG)},
> > > > +   {MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE_2, MEI_ME_PCH8_SPS_CFG)},
> > > >
> > > >     {MEI_PCI_DEVICE(MEI_DEV_ID_GLK, MEI_ME_PCH8_CFG)},
> > > >
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index 6899d6b198af..2ab767ef8469 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -4842,6 +4842,9 @@ static const struct pci_dev_acs_enabled {
> > > >     { PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
> > > >     { PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
> > > >     { PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_rciep_acs },
> > > > +   /* Denverton */
> > > > +   { PCI_VENDOR_ID_INTEL, 0x19e5, pci_quirk_mf_endpoint_acs },
> > > > +   { PCI_VENDOR_ID_INTEL, 0x19e6, pci_quirk_mf_endpoint_acs }, =20
> > >
> > > This looks like it should be a separate patch with a commit log that
> > > explains it.  For example, see these:
> > >
> > >   db2f77e2bd99 ("PCI: Add ACS quirk for Broadcom BCM57414 NIC")
> > >   3247bd10a450 ("PCI: Add ACS quirk for Intel Root Complex Integrated=
 Endpoints")
> > >   299bd044a6f3 ("PCI: Add ACS quirk for Zhaoxin Root/Downstream Ports=
")
> > >   0325837c51cb ("PCI: Add ACS quirk for Zhaoxin multi-function device=
s")
> > >   76e67e9e0f0f ("PCI: Add ACS quirk for Amazon Annapurna Labs root po=
rts")
> > >   46b2c32df7a4 ("PCI: Add ACS quirk for iProc PAXB")
> > >   01926f6b321b ("PCI: Add ACS quirk for HXT SD4800")
> > >
> > > It should be acked by somebody at Intel since this quirk relies on
> > > behavior of the device for VM security. =20
> >
> > +1 Thanks Bjorn.  I got curious and AFAICT these functions are the
> > interface for the host system to communicate with "Innovation Engine"
> > processors within the SoC, which seem to be available for system
> > builders to innovate and differentiate system firmware features.  I'm
> > not sure then how we can assume a specific interface ("HSM" or "IFSI",
> > whatever those are) for each function, nor of course how we can assume
> > isolation between them.  Thanks, =20
>=20
> Alex, I got a Denverton hardware with Innovation Engine and the
> specific system firmware (basically delivered from Intel). To make use
> of that hardware, someone at Intel suggested adding these PCI ACS
> quirks. It is unclear to me if there are various different Denverton
> systems out there (I only got one!) with many different system
> firmware variants for the Innovation Engine or if there is just one
> Denverton with IE support and with one firmware from Intel, i.e., the
> one I got.
>=20
> If there is only one or two variants of the Denverton with Innovation
> Engine firmware out there, then we could add this ACS quirk here
> unconditionally (basically assuming that if the other firmware is
> there, the IE would just do the right thing, e.g., deny any operation
> for a non-existing firmware function), right? Just adding a commit
> similar to the commits Bjorn pointed out above. Otherwise, we would
> need to make that conditional for possible different variants, but I
> would need a bit more guidance from you on which other variants exist
> and how one can differentiate between them.

Hi Lukas,

I'm looking at the C3000 datasheet, Intel document #337018-002, where I
see:

1.2.7 Innovation Engine (IE)
	...
	For the IE, the system builder can install an embedded
	operating system, drivers and application they develop on their
	own, or purchase them from a third-party vendor. Intel does not
	provide operating systems, drivers or applications for the IE.

15.2.3.1 Interrupt Timer Sub System (ITSS)
	...
	The Innovation Engine (IE) has a sideband connection to the
	ITSS components.

16 Power Management Controller (PMC)
	...
	16.2 Feature List
		...
		=E2=80=A2 Interacts with the SoC Innovation Engine (IE)

Table 16-4. Causes of SMI and SCI=20
	...
	[IE can cause SMI or SCI]

16.10.1 Initiating State Changes when in the G0 (S0) Working State
	...
	The Intel=C2=AE Management Engine and Innovation Engine firmware
	each has a mechanism to turn off a hung system similar to the
	Power-Button Override by writing bits in their power-management
	control registers.

And the apparent coup de gr=C3=A2ce:

37 Innovation Engine
	The Innovation Engine (IE) is an optional, complete, embedded
	engine intended to enable SoC customers to provide their own
	custom system management. This chapter provides a brief
	overview of the IE. It is reserved for system-builder code, not
	for Intel firmware since Intel supplies IE hardware only. IE
	activation is not required for normal system operation.
	...
	IE is a completely optional feature, and is disabled by default
	in the silicon. It can be enabled by system builders and OEMs
	to run signed firmware created by the system builder or a third
	party software vendor. IE is not like the Intel=C2=AE Management
	Engine (Intel=C2=AE ME) where Intel provides the HW plus a complete
	FW solution. Intel only provides IE hardware (along with
	collateral and tools enabling).

For the HECI, I see:

37.3 Architectural Overview
	...
	The devices exposed by the IE subsystem to the Host Root Space
	are:
		=E2=80=A2 HECI (1, 2 and 3) =E2=80=93 These functions define the
		  mechanism for host software and IE firmware to
		  communicate. This device exposes three PCI functions
		  to the host during PCI bus enumeration. The message
		  format is OEM dependent and communication between
		  host and IE subsystem takes place via circular
		  buffers and control/status registers. This function
		  supports host MSI, SMI and SCI# interrupt generation
		  mechanisms.


So I don't see how the datasheet supports that there's either any
specific API defined per HECI interface or that these functions would
ever be intended in a generic way for independent use of by a userspace
driver or VM.  Perhaps with DMI or ACPI info an HECI could be
associated to a specific vendor API, by why we'd describe them as using
isolated IOMMU grouping is a complete mystery to me.  Thanks,

Alex

