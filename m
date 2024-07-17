Return-Path: <linux-pci+bounces-10454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E715293413B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21EB9B22009
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3621822C6;
	Wed, 17 Jul 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C+pVesPP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287A181B9A
	for <linux-pci@vger.kernel.org>; Wed, 17 Jul 2024 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236376; cv=none; b=HKeooYfkY98AwZNwA+s46O9YO3AhyB3EedqCYoKX9NNEkYC/6EyN4KVQayEide7CIjJ9uwg/m/SytqiGTJbJvybYcdMJH39841Sgc+IVDi/OUikLpdHl33aeclVS8Ukc2RSxLIVtcj8uz8r+ZZLLBZOR5W4bU/wsMg6NmPiEiA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236376; c=relaxed/simple;
	bh=08IsNE9OTrrak0Rh6mGhJs7i4Z8E5/HMFMFQD8ShHXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5lAjRxdjJmIFJSOJeSsZBzisILIKFlXwoZ+4S/DdepLTiNluMI1vy78kdhTsEeZgABaEYOELEjzGAw7B7cf6oQMaaeQSiY8fs+XCzbWJhjFkCmL0DEVHHjUmLLEv4m/XsfbWGojqKstcUjSKCunp+NhqnvFvsPJU5wsQjVFp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C+pVesPP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77e392f59fso810251666b.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Jul 2024 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721236373; x=1721841173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjjADzQfzKGGmui3quUsVPnA2QGdex7aGv6U5px6fj8=;
        b=C+pVesPPI2/BKC2/qOeVV6KFaBum/eCmDE00dWigG89lGf8rO9kszJZ/NHz2CozKb3
         yfrokExY1x1pQ6Dp2PHLnJm7ERbc353htHn//0ZwuGSmVBVcZahtAY6gRfaexmqhLRMV
         IwZN0IQs4Jim+BjMwB6smMkTRW6mE20rWWw0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721236373; x=1721841173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjjADzQfzKGGmui3quUsVPnA2QGdex7aGv6U5px6fj8=;
        b=JuUkkZ2f4ASEkNMtZ3yoB08cVq9tyPRE+7znHOV1r3SqVMH2VEkDneJV6xLg5bjt2h
         taPEJ9oIiUXD1KflChhCYu3GmJ+8lRQVdV9ZRp9ZK3ChpNUMF4GcgVl9dw3URyKMxMM/
         OKvebDKSUJxP4hIC5KyjpunnxvXJCPlFLOiy1WuZELJR7EzDSOhEU3rGCdlZK0HjbRVw
         zQiMgNAAl9qDZUXd5At70DtKaBUqvJrDrOPeE0IJmMxcMDdh0zalDW0ROhKVcv21+Avt
         IF+fvf3Wqx9P9YW9V+ve84vmdElIPo1/Qs8Y3lR6B2WDjDGY2u5ojoBhEJikLItdRSHO
         eOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbC69MO4heBEueJj52mRKsXvTzYnPb8TFm9Mk6v65PWCuP+LztZBPb921c6kNaKpfkn5F6Yb4b3AIGAZ68lPQPswomJPlJ8eHp
X-Gm-Message-State: AOJu0Yz6xgoZ1OW4orHT80TXLMohJvBONpycn+7gTQmGUTGkg/GDeMNj
	FwYROW94pzfBwuBuxq0c9lbKw6GHgbp1mL2fSVGHtQ6nUIGVpk2J7z9F9smVJVQf2hFzTxu3QEm
	mXHrR8Ps/eD0sbmNqGlFBF0Np97YeBYDedcn7
X-Google-Smtp-Source: AGHT+IFBxlQTTGYVoRJHLcq72dqotyMNCP7Z5MNNNWdLrjNcmzrUN5zFqA3dV9i3233qtp7yIKagUcpCNOM4xo1YEDE=
X-Received: by 2002:a17:906:a06:b0:a77:c080:11fc with SMTP id
 a640c23a62f3a-a7a011ae5f1mr149862866b.36.1721236372815; Wed, 17 Jul 2024
 10:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708172339.GA139099@bhelgaas> <e1ed82cb-6d20-4ca8-b047-4a02dde115a8@gmail.com>
 <CACfW=qpNmSeQVG_qSeYpEdk9pf_RTAEEKp+OiBYrRFd3d6HOXg@mail.gmail.com> <edf2a0aa-d027-489f-891f-254849a47c60@gmail.com>
In-Reply-To: <edf2a0aa-d027-489f-891f-254849a47c60@gmail.com>
From: George-Daniel Matei <danielgeorgem@chromium.org>
Date: Wed, 17 Jul 2024 19:12:41 +0200
Message-ID: <CACfW=qqJ4ubkr036n=VU8GM=OVru-q76O8DG4GV-8hMyK5ZGKA@mail.gmail.com>
Subject: Re: [PATCH] PCI: r8169: add suspend/resume aspm quirk
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, nic_swsd@realtek.com, netdev@vger.kernel.org, 
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 9:59=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 10.07.2024 17:09, George-Daniel Matei wrote:
> > Hi,
> >
> >>> Added aspm suspend/resume hooks that run
> >>> before and after suspend and resume to change
> >>> the ASPM states of the PCI bus in order to allow
> >>> the system suspend while trying to prevent card hangs
> >>
> >> Why is this needed?  Is there a r8169 defect we're working around?
> >> A BIOS defect?  Is there a problem report you can reference here?
> >>
> >
> > We encountered this issue while upgrading from kernel v6.1 to v6.6.
> > The system would not suspend with 6.6. We tracked down the problem to
> > the NIC of the device, mainly that the following code was removed in
> > 6.6:
> >> else if (tp->mac_version >=3D RTL_GIGA_MAC_VER_46)
> >>         rc =3D pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
> > For the listed devices, ASPM L1 is disabled entirely in 6.6. As for
> > the reason, L1 was observed to cause some problems
> > (https://bugzilla.kernel.org/show_bug.cgi?id=3D217814). We use a Raptor
> > Lake soc and it won't change residency if the NIC doesn't have L1
> > enabled. I saw in 6.1 the following comment:
>
> With residency you refer to the package power saving state?
>
Yes, by residency I'm referring to the package power saving state.

> >> Chips from RTL8168h partially have issues with L1.2, but seem
> >> to work fine with L1 and L1.1.
> > I was thinking that disabling/enabling L1.1 on the fly before/after
> > suspend could help mitigate the risk associated with L1/L1.1 . I know
> > that ASPM settings are exposed in sysfs and that this could be done
> > from outside the kernel, that was my first approach, but it was
> > suggested to me that this kind of workaround would be better suited
> > for quirks. I did around 1000 suspend/resume cycles of 16-30 seconds
> > each (correcting the resume dev->bus->self being configured twice
> > mistake) and did not notice any problems. What do you think, is this a
> > good approach ... ?
> >
> If the root cause really should be in the SoC's ASPM implementation, then=
:
> - Other systems with the same SoC may suffer from the same problem,
>   but are not covered by the quirk.
> - The issue may occur also with other devices than a RTL8168 NIC.
>   How about e.g. RTL8125? Or completely different PCI devices?
>
> What I understand so far from your description:
>
> W/o ASPM L1 the SoC doesn't change "residency". See comment above,
> please elaborate on this.
> And w/ ASPM L1 the NIC hangs on suspend?
> What's the dmesg entries related to this hang? Tx timeout?
> Or card not accessible at all?
>
W/o ASPM L1 the SoC doesn't change power states, yes.
With ASPM L1 the SoC changes power states. But for the L1
substates, L1.1 could cause tx timeouts as per 90ca51e8c654 ("r8169:
fix ASPM-related issues on a number of systems with NIC version from
RTL8168h". So L1 (and L1.1) couldn't be simply turned back on without the
possibility of running into these tx timeouts. I never observed them while
I experimented and tested with L1 and L1.1.

> My perspective so far:
> It's a relatively complex quirk that covers only a part of the potentiall=
y
> affected systems, and the issue isn't well understood.
>
> And most likely there are lots of systems out there with a Raptor Lake CP=
U
> and a RTL8168 on board. Therefore it's surprising that there hasn't been
> a similar report before.
>
>
> >>> +             //configure device
> >>> +             pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> >>> +                                                PCI_EXP_LNKCTL_ASPMC=
, 0);
> >>> +
> >>> +             pci_read_config_word(dev->bus->self,
> >>> +                                  dev->bus->self->l1ss + PCI_L1SS_CT=
L1,
> >>> +                                  &val);
> >>> +             val =3D val & ~PCI_L1SS_CTL1_L1SS_MASK;
> >>> +             pci_write_config_word(dev->bus->self,
> >>> +                                   dev->bus->self->l1ss + PCI_L1SS_C=
TL1,
> >>> +                                   val);
> >> Updates the parent (dev->bus->self) twice; was the first one supposed
> >> to update the device (dev)?
> > Yes, it was supposed to update the device (dev). It's my first time
> > sending a patch and I messed something up while doing some style
> > changes, I will correct it. I'm sorry for that.
> >
> >> This doesn't restore the state as it existed before suspend.  Does
> >> this rely on other parts of restore to do that?
> > It operates on the assumption that after driver initialization
> > PCI_EXP_LNKCTL_ASPMC is 0 and that there are no states enabled in
> > CTL1. I did a lspci -vvv dump on the affected devices before and after
> > the quirks ran and saw no difference. This could be improved.
> >
> >> What is the RTL8168 chip version used on these systems?
> > It should be RTL8111H.
> >
> >> What's the root cause of the issue?
> >> A silicon bug on the host side?
> > I think it's the ASPM implementation of the soc.
> >
> >> ASPM L1 is disabled per default in r8169. So why is the patch needed
> >> at all?
> > Leaving it disabled all the time prevents the system from suspending.
> >
> This is not clear to me. You refer to STR?
> Why should a system not suspend just because one PCI device doesn't
> have ASPM L1 enabled?
I think some of my previous comments have been misleading.
The actual problem is that the SoC doesn't change power states.

intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!!

In the case of the system I observed the problem, there is an
EC, separate from the SoC, which will trigger the system to resume
if following a suspend there is no power state transition
detected after a period of time. That's why I was mentioning
"can't suspend" but actually is a "can't achieve s0ix" problem.

I searched for s0ix problems, I found:
https://bugzilla.kernel.org/show_bug.cgi?id=3D207893
and it looks similar. What do you think ?

Somehow not having L1 enabled makes it that the PCI controller
have a state that doesn't meet the criteria to transition to s0ix.




>
> > Thank you,
> > George-Daniel Matei
> >
> >
> >
> >
> >
> > On Tue, Jul 9, 2024 at 12:15=E2=80=AFAM Heiner Kallweit <hkallweit1@gma=
il.com> wrote:
> >>
> >> On 08.07.2024 19:23, Bjorn Helgaas wrote:
> >>> [+cc r8169 folks]
> >>>
> >>> On Mon, Jul 08, 2024 at 03:38:15PM +0000, George-Daniel Matei wrote:
> >>>> Added aspm suspend/resume hooks that run
> >>>> before and after suspend and resume to change
> >>>> the ASPM states of the PCI bus in order to allow
> >>>> the system suspend while trying to prevent card hangs
> >>>
> >>> Why is this needed?  Is there a r8169 defect we're working around?
> >>> A BIOS defect?  Is there a problem report you can reference here?
> >>>
> >>
> >> Basically the same question from my side. Apparently such a workaround
> >> isn't needed on any other system. And Realtek NICs can be found on mor=
e
> >> or less every consumer system. What's the root cause of the issue?
> >> A silicon bug on the host side?
> >>
> >> What is the RTL8168 chip version used on these systems?
> >>
> >> ASPM L1 is disabled per default in r8169. So why is the patch needed
> >> at all?
> >>
> >>> s/Added/Add/
> >>>
> >>> s/aspm/ASPM/ above
> >>>
> >>> s/PCI bus/device and parent/
> >>>
> >>> Add period at end of sentence.
> >>>
> >>> Rewrap to fill 75 columns.
> >>>
> >>>> Signed-off-by: George-Daniel Matei <danielgeorgem@chromium.org>
> >>>> ---
> >>>>  drivers/pci/quirks.c | 142 ++++++++++++++++++++++++++++++++++++++++=
+++
> >>>>  1 file changed, 142 insertions(+)
> >>>>
> >>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >>>> index dc12d4a06e21..aa3dba2211d3 100644
> >>>> --- a/drivers/pci/quirks.c
> >>>> +++ b/drivers/pci/quirks.c
> >>>> @@ -6189,6 +6189,148 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL=
, 0x56b0, aspm_l1_acceptable_latency
> >>>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_accep=
table_latency);
> >>>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_accep=
table_latency);
> >>>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_accep=
table_latency);
> >>>> +
> >>>> +static const struct dmi_system_id chromebox_match_table[] =3D {
> >>>> +    {
> >>>> +            .matches =3D {
> >>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Brask"),
> >>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >>>> +            }
> >>>> +    },
> >>>> +    {
> >>>> +            .matches =3D {
> >>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Aurash"),
> >>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >>>> +            }
> >>>> +    },
> >>>> +            {
> >>>> +            .matches =3D {
> >>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Bujia"),
> >>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >>>> +            }
> >>>> +    },
> >>>> +    {
> >>>> +            .matches =3D {
> >>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Gaelin"),
> >>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >>>> +            }
> >>>> +    },
> >>>> +    {
> >>>> +            .matches =3D {
> >>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Gladios"),
> >>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >>>> +            }
> >>>> +    },
> >>>> +    {
> >>>> +            .matches =3D {
> >>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Hahn"),
> >>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >>>> +            }
> >>>> +    },
> >>>> +    {
> >>>> +            .matches =3D {
> >>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Jeev"),
> >>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >>>> +            }
> >>>> +    },
> >>>> +    {
> >>>> +            .matches =3D {
> >>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Kinox"),
> >>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >>>> +            }
> >>>> +    },
> >>>> +    {
> >>>> +            .matches =3D {
> >>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Kuldax"),
> >>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >>>> +            }
> >>>> +    },
> >>>> +    {
> >>>> +            .matches =3D {
> >>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Lisbon"),
> >>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >>>> +            }
> >>>> +    },
> >>>> +    {
> >>>> +                    .matches =3D {
> >>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Moli"),
> >>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >>>> +            }
> >>>> +    },
> >>>> +    { }
> >>>> +};
> >>>> +
> >>>> +static void rtl8169_suspend_aspm_settings(struct pci_dev *dev)
> >>>> +{
> >>>> +    u16 val =3D 0;
> >>>> +
> >>>> +    if (dmi_check_system(chromebox_match_table)) {
> >>>> +            //configure parent
> >>>> +            pcie_capability_clear_and_set_word(dev->bus->self,
> >>>> +                                               PCI_EXP_LNKCTL,
> >>>> +                                               PCI_EXP_LNKCTL_ASPMC=
,
> >>>> +                                               PCI_EXP_LNKCTL_ASPM_=
L1);
> >>>> +
> >>>> +            pci_read_config_word(dev->bus->self,
> >>>> +                                 dev->bus->self->l1ss + PCI_L1SS_CT=
L1,
> >>>> +                                 &val);
> >>>> +            val =3D (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
> >>>> +                  PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1=
_2 |
> >>>> +                  PCI_L1SS_CTL1_ASPM_L1_1;
> >>>> +            pci_write_config_word(dev->bus->self,
> >>>> +                                  dev->bus->self->l1ss + PCI_L1SS_C=
TL1,
> >>>> +                                  val);
> >>>> +
> >>>> +            //configure device
> >>>> +            pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> >>>> +                                               PCI_EXP_LNKCTL_ASPMC=
,
> >>>> +                                               PCI_EXP_LNKCTL_ASPM_=
L1);
> >>>> +
> >>>> +            pci_read_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, &v=
al);
> >>>> +            val =3D (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
> >>>> +                  PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1=
_2 |
> >>>> +                  PCI_L1SS_CTL1_ASPM_L1_1;
> >>>> +            pci_write_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, v=
al);
> >>>> +    }
> >>>> +}
> >>>> +
> >>>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_REALTEK, 0x8168,
> >>>> +                      rtl8169_suspend_aspm_settings);
> >>>> +
> >>>> +static void rtl8169_resume_aspm_settings(struct pci_dev *dev)
> >>>> +{
> >>>> +    u16 val =3D 0;
> >>>> +
> >>>> +    if (dmi_check_system(chromebox_match_table)) {
> >>>> +            //configure device
> >>>> +            pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> >>>> +                                               PCI_EXP_LNKCTL_ASPMC=
, 0);
> >>>> +
> >>>> +            pci_read_config_word(dev->bus->self,
> >>>> +                                 dev->bus->self->l1ss + PCI_L1SS_CT=
L1,
> >>>> +                                 &val);
> >>>> +            val =3D val & ~PCI_L1SS_CTL1_L1SS_MASK;
> >>>> +            pci_write_config_word(dev->bus->self,
> >>>> +                                  dev->bus->self->l1ss + PCI_L1SS_C=
TL1,
> >>>> +                                  val);
> >>>> +
> >>>> +            //configure parent
> >>>> +            pcie_capability_clear_and_set_word(dev->bus->self,
> >>>> +                                               PCI_EXP_LNKCTL,
> >>>> +                                               PCI_EXP_LNKCTL_ASPMC=
, 0);
> >>>> +
> >>>> +            pci_read_config_word(dev->bus->self,
> >>>> +                                 dev->bus->self->l1ss + PCI_L1SS_CT=
L1,
> >>>> +                                 &val);
> >>>> +            val =3D val & ~PCI_L1SS_CTL1_L1SS_MASK;
> >>>> +            pci_write_config_word(dev->bus->self,
> >>>> +                                  dev->bus->self->l1ss + PCI_L1SS_C=
TL1,
> >>>> +                                  val);
> >>>
> >>> Updates the parent (dev->bus->self) twice; was the first one supposed
> >>> to update the device (dev)?
> >>>
> >>> This doesn't restore the state as it existed before suspend.  Does
> >>> this rely on other parts of restore to do that?
> >>>
> >>>> +    }
> >>>> +}
> >>>> +
> >>>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_REALTEK, 0x8168,
> >>>> +                     rtl8169_resume_aspm_settings);
> >>>>  #endif
> >>>>
> >>>>  #ifdef CONFIG_PCIE_DPC
> >>>> --
> >>>> 2.45.2.803.g4e1b14247a-goog
> >>>>
> >>
>

