Return-Path: <linux-pci+bounces-13598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA7D9882B9
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 12:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CD2DB213BF
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E3A1898F8;
	Fri, 27 Sep 2024 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="jj9F7uWU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793E15FD16
	for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433786; cv=none; b=DdmNrRfHJcHaQ2lXEOofPmWOyzTBXB2aQfmbERLKiWO8LlB4MIZY6lQ/aBQkGAjivXToehw/hzxWTRnPcXoniMc8ELOkYW/ce6nVDGjKUlDZ9d5Gc23rF2gS7oOyPSyalo67jpaNJ77oAXymZ/jxme+wlKmWafgcXqidVLux28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433786; c=relaxed/simple;
	bh=1jj/KkVjsT17K/HIIfnoqj5ry23L+Gj3Qjal/RJszg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXyla9Xi19B6OmsKv4Tl+avfPrUm9UUXzacDuxHEofbr86pVbsgCQOguy7Oy+uxhHG1CsMNLRoItCe+fFdZ8jyqkf5CvpUDcvVL9GFjDlmi8BYQK7ab/l2UX9k5BXJdvHIHqut9oRUFs6U61GP4AYo5E8AK+cH/qt4uD6y3VGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=jj9F7uWU; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1d06c728b8so1794966276.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 03:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727433782; x=1728038582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAiyZWvtRN3hX0vlmCxNV/K5r2UEqD1zNefeXZouqxI=;
        b=jj9F7uWUijsH9xBV5yNRngBvTTvCtz+rb//l3ie9xOBZkiSuZ09AK2bmyHhw/PsQ5N
         Wi0/5K315DVV9bIH1eMc6VC6Jic+qhNWzQ6k8UnHghA2Gvhn/MsnOXR+xToDNHOFPcPS
         kat3RIBMqYVmdy3zr0gXcIE4YrtT9/C5XGrYOgKL2jiUzz49Z0/E9arYVuPqj+8rL4ag
         ZAMsFV1K2TRSHaZMS0+pwjcQjQE5DFsRqQJZPe586SpiuasseEbExQ3OPZ39rp/WT3is
         Ya+qmu6h32ThHJsVS0/bWzfsMGT2djn3hEtFruevT6qk7ZdntE3dU8kaxB9Z0lB4fpPG
         EW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727433782; x=1728038582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAiyZWvtRN3hX0vlmCxNV/K5r2UEqD1zNefeXZouqxI=;
        b=WVRtRpDEddsAugccuXF+feAgpjPHguEWWjJQowTbJEpbyVZ5ZmiDuHBaxWHdM5YqPa
         cbItOmqbQ+m4C5dB5UmOAx34hIIKUWgeg9whGycHCyLrBQ1eIWtyOvORF8QsKOrkofEs
         Fe/i8pV9KNyf6uVoVGwy7rtFgtL6t4GKDYNTZaN0SOcZF3y7MIXrg6uG1HpGRaFqTugQ
         QnnNyPn9xSeZM0DKcjAYYhKrPxR+j2Rbg86iEAb+Dq7yFMLqoE8zfxzbxU/iRo68w1m/
         nqNINj9XlFOgn2VaTIKYpo+q7idtCeeQoPUzFB79JNtUMYL3hy7KcsSElkryCH32TKl2
         XlAg==
X-Forwarded-Encrypted: i=1; AJvYcCW3wuB6xJdeJWRMwqackGPA6tOUBvV4X8OSLaPCa5R3Fcpw/T55bEL3copO8gpuhif8FvFnxOaCvfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDECCZ0zH8CrMNxv22xQ66uJs5i8ynGAi7Iq4/AGYOPTtNqGV1
	aeiydxJq4S9sdm1LQvAYMl5PilNmc/utErdUQIwee1IMeDAVaEfzxx0moO6Thme/qfr6At2puzf
	l2LBcdUGDoNC6ig+H3+cIwkb/Q5GGenS/YEkOIw==
X-Google-Smtp-Source: AGHT+IFy1wVMweI7DvFqLPraYIfxrsjYLDZW2hbcC/QC0D+FUokojneDiptGHjleNk99Qg17IiWWyKSXj7PiLFDNPZI=
X-Received: by 2002:a05:6902:1613:b0:e20:140b:152d with SMTP id
 3f1490d57ef6-e2604b45164mr1949966276.15.1727433782405; Fri, 27 Sep 2024
 03:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924070551.14976-2-jhp@endlessos.org> <20240924072858.15929-3-jhp@endlessos.org>
 <8050f9d4cb851fc301cc35b4fb5a839ff71fdcae.camel@linux.intel.com>
 <CAPpJ_ed09KJY9Gw2qGwOHdKFw4-BAMyG6jOyWHnV7brJutwfVw@mail.gmail.com>
 <44275137-97fc-3da9-c01a-6e747c236c8e@linux.intel.com> <7ddc91f4-a68e-7186-0a02-ba0fdf1a718c@linux.intel.com>
In-Reply-To: <7ddc91f4-a68e-7186-0a02-ba0fdf1a718c@linux.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Fri, 27 Sep 2024 18:42:26 +0800
Message-ID: <CAPpJ_efeeEa78WcAzFnfeLdygFfnNqkS9_tMVf74Ut6JH-SK-w@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] PCI: vmd: Save/restore PCIe bridge states
 before/after pci_reset_bus()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: david.e.box@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>, 
	Johan Hovold <johan@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E6=96=BC 2024=E5=B9=B49=
=E6=9C=8826=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:22=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On Thu, 26 Sep 2024, Ilpo J=C3=A4rvinen wrote:
>
> > On Thu, 26 Sep 2024, Jian-Hong Pan wrote:
> >
> > > David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B49=
=E6=9C=8826=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:51=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > >
> > > > Hi Jian-Hong,
> > > >
> > > > On Tue, 2024-09-24 at 15:29 +0800, Jian-Hong Pan wrote:
> > > > > PCI devices' parameters on the VMD bus have been programmed prope=
rly
> > > > > originally. But, cleared after pci_reset_bus() and have not been =
restored
> > > > > correctly. This leads the link's L1.2 between PCIe Root Port and =
child
> > > > > device gets wrong configs.
> > > > >
> > > > > Here is a failed example on ASUS B1400CEAE with enabled VMD. Both=
 PCIe
> > > > > bridge and NVMe device should have the same LTR1.2_Threshold valu=
e.
> > > > > However, they are configured as different values in this case:
> > > > >
> > > > > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core =
Processor
> > > > > PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
> > > > >   ...
> > > > >   Capabilities: [200 v1] L1 PM Substates
> > > > >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_=
PM_Substates+
> > > > >       PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
> > > > >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > > >       T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> > > > >     L1SubCtl2: T_PwrOn=3D0us
> > > > >
> > > > > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp=
 WD Blue
> > > > > SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> > > > >   ...
> > > > >   Capabilities: [900 v1] L1 PM Substates
> > > > >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_=
PM_Substates+
> > > > >       PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
> > > > >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > > >       T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> > > > >     L1SubCtl2: T_PwrOn=3D50us
> > > > >
> > > > > Here is VMD mapped PCI device tree:
> > > > >
> > > > > -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
> > > > >  | ...
> > > > >  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVM=
e SSD
> > > > >               \-17.0  Intel Corporation Tiger Lake-LP SATA Contro=
ller
> > > > >
> > > > > When pci_reset_bus() resets the bus [e1] of the NVMe, it only sav=
es and
> > > > > restores NVMe's state before and after reset. Because bus [e1] ha=
s only one
> > > > > device: 10000:e1:00.0 NVMe. The PCIe bridge is missed. However, w=
hen it
> > > > > restores the NVMe's state, it also restores the ASPM L1SS between=
 the PCIe
> > > > > bridge and the NVMe by pci_restore_aspm_l1ss_state(). The NVMe's =
L1SS is
> > > > > restored correctly. But, the PCIe bridge's L1SS is restored with =
the wrong
> > > > > value 0x0. Becuase, the PCIe bridge's state is not saved before r=
eset.
> > > > > That is why pci_restore_aspm_l1ss_state() gets the parent device =
(PCIe
> > > > > bridge)'s saved state capability data and restores L1SS with valu=
e 0.
> > > > >
> > > > > So, save the PCIe bridge's state before pci_reset_bus(). Then, re=
store the
> > > > > state after pci_reset_bus(). The restoring state also consumes th=
e saving
> > > > > state.
> > > > >
> > > > > Link: https://www.spinics.net/lists/linux-pci/msg159267.html
> > > > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > > > ---
> > > > > v9:
> > > > > - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD =
instead.
> > > > >
> > > > >  drivers/pci/controller/vmd.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controlle=
r/vmd.c
> > > > > index 11870d1fc818..2820005165b4 100644
> > > > > --- a/drivers/pci/controller/vmd.c
> > > > > +++ b/drivers/pci/controller/vmd.c
> > > > > @@ -938,9 +938,16 @@ static int vmd_enable_domain(struct vmd_dev =
*vmd,
> > > > > unsigned long features)
> > > > >               if (!list_empty(&child->devices)) {
> > > > >                       dev =3D list_first_entry(&child->devices,
> > > > >                                              struct pci_dev, bus_=
list);
> > > >
> > > > Newline here
> > > > > +                     /* To avoid pci_reset_bus restore wrong ASP=
M L1SS
> > > > > +                      * configuration due to missed saving paren=
t device's
> > > > > +                      * states, save & restore the parent device=
's states
> > > > > +                      * as well.
> > > > > +                      */
> > > >
> > > > No text on first line of comment.
> > >
> > > Oops!  Thanks
> > >
> > > >     /*
> > > >      * To avoid pci_reset_bus restore wrong ASPM L1SS
> > > >      * ...
> > > >      */
> > > >
> > > > > +                     pci_save_state(dev->bus->self);
> > > > >                       ret =3D pci_reset_bus(dev);
> > > > >                       if (ret)
> > > > >                               pci_warn(dev, "can't reset device: =
%d\n",
> > > > > ret);
> > > > > +                     pci_restore_state(dev->bus->self);
> > > >
> > > > I think Ilpo's point was that pci_save_aspm_l1ss_state() and
> > > > pci_restore_aspm_l1ss_state() should be more symmetric. If
> > > > pci_save_aspm_l1ss_state() is changed to also handle the state for =
the device
> > > > and its parent in the same call, then no change is needed here. But=
 that would
> > > > only handle L1SS settings and not anything else that might need to =
be restored
> > > > after the bus reset. So I'm okay with it either way.
> >
> > Why would something else need to be restored? The spec explicitly says =
the
> > bus reset should not cause config changes on the parent other than
> > to status bits.
> >
> > Based on what is seen so far, the problem here is not the reset itself
> > breaking parent's config but ASPM code restoring values from state beyo=
nd
> > what it had saved and thus it programs pseudogarbage into the L1SS
> > settings.
> >
> > > Yes, that made me think the whole day before I sent out this patch. I
> > > do not know what is the best reset bus procedure, especially how othe=
r
> > > drivers reset the bus.
> > >
> > > If trace the code path:
> > > pci_reset_bus()
> > >   __pci_reset_bus()
> > >     pci_bus_reset()
> > >       pci_bus_save_and_disable_locked()
> > >
> > > pci_bus_save_and_disable_locked()'s comment shows "Save and disable
> > > devices from the top of the tree down while holding the @dev mutex
> > > lock for the entire tree". I think that means the PCI(e) bridge shoul=
d
> > > save state first, then the following bus' devices. However, VMD reset=
s
> > > the child device (10000:e1:00.0 NVMe)'s bus first and only saves the
> > > child device (10000:e1:00.0 NVMe)'s state. It does not visit the tree
> > > from the top to down. So, it misses the PCIe bridge.  Therefore, I
> > > make it save & restore its parent (10000:e0:06.0 PCIe bridge)'s state
> > > as compensation.
> >
> > The problem with your fix is it only takes care of part of the cases (i=
.e.
> > VMD). But there are other callers of pci_reset_bus() which would also
> > restore incorrect L1SS settings, no?
> >
> > I'd suggest making the L1SS code symmetric on this, even if it means
> > saving the register value twice when walking the tree downwards (it see=
ms
> > harmless to write the same value twice).
>
> Perhaps parent->state_saved =3D=3D true could even be used to avoid doing=
 it
> twice/unnecessarily if the parent is already saved.

Saving twice is the concern. Using parent->state_saved =3D=3D true as
guard seems nice.
v10 patch has been sent out for review.

Jian-Hong Pan

