Return-Path: <linux-pci+bounces-10370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DC5932652
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 14:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B293B20D5F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 12:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6567417623C;
	Tue, 16 Jul 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NsLtOH34"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E419A2A5
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721132010; cv=none; b=TUDQnbgwKx6OGPXGNPuZe73ZOQPlqUBEuvt1NCg5dkQ0MO2SSBoSTklch/bfZR+91jkJG8aPajFDIcLsuAF9Pms/ekFAwRUMXjN9kJgpg2ek9FJuas+O/Ba0OX+uk7kI0qGQqX0mFq2+uWFthoeW1eShhn0MnkPd7TO90DEGSw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721132010; c=relaxed/simple;
	bh=7nzL0hsEVLYqclx2vdoyRQ+fyOj0zU7J8Tz2f3Sn41w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0TMP7Gbxe6GyYK8o0Tt5N3Gvd5hCrj+02tmkO+KaKnUrKHQFzG5SnTtaH8sIQjV16Q9FCTaD63ZeagIR8PnET3JBXvpgCWwU4ChzM0Rx0EkFWolOyzWW89eqV23yqKqEIJVlWYAQJy7XM+0mr/LAnT/Rc37l5nAfPoP8Fvtd/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NsLtOH34; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea929ea56so10213303e87.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721132006; x=1721736806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PVFHYdHZi+efErbVwSvkwoy+x9lyeTaxOb532+jDh0=;
        b=NsLtOH34+gWW09PMFFqPtEksdZpK9ukRl64Q5jjWbqBE50t4r6/gFleOBJrfyw1o1q
         TYqbPeNHa3bRWGbnboNIl07gKUV3K6kwNtxRRR/96q7rswOp3UxR6wTfX+eO5ttUumrr
         67dQ0lKh7KyVbkGwsHXREYLqiqvs17dtye5F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721132006; x=1721736806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PVFHYdHZi+efErbVwSvkwoy+x9lyeTaxOb532+jDh0=;
        b=RexrV8zmn53Et47qb9FLkeuxglAkPmnR4Z41wHGSRZDxboRyYDPoxDOdgupPKlF6B2
         89I+6rfJQCaMeP1qPWlgKgmFYW5F1W493RyBxMooCXmrXGrO1wbigD25EDqG/ZsxTSn7
         GBY4BX0iAKMYq8cBf7iEWnJIqbrXI04pjWU22KktyXeVoZBa684dWCrlVU8ezy8CdUj6
         ycLKYH2jGT4ltYzsaP7lMh+j3q3631kmcdwrvMmrM+tFA3ugYvDxGkiAmQaZ8qL/52BA
         qAxm3dJCeOkHDzsz5vzeQvlQaE5QmfzKy+vs+rpAHKYQqJkQO20S+Uhvk1diSIMPaPn5
         aNTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUQyiNI9fo5vfORWdqHMBzmDEC4Fky2E2KO7i1xZiSg/PiOq0+5LIz9XgQJDmJ7ZTCDcLFxKKaPSEwMIGtEDEs3cJ463enCnVq
X-Gm-Message-State: AOJu0Yzf/pKr9jBzVpFfHIi+PSh+AyK2dvNXf9i9zRuVEtfwOnbRp9uT
	f8y2oS3MTsMfvOoBpkwtUbqHqIxldCIdZxrfdy5Jzx4cyLmwkWU0uGNAsHIZcy/oulBNtiVHnJ9
	JrgJLYwFdQdFjNHPBqr4/nXrM2PMmWotPCifw
X-Google-Smtp-Source: AGHT+IENriO2isT0xngPPe/l4TaABGM29ZIf6rpmv5eCzBqKta0WEazSUwmCKZ10rKVmknYD9VV+OdD4is54ZWtBWzU=
X-Received: by 2002:a05:6512:3089:b0:52e:9921:6dff with SMTP id
 2adb3069b0e04-52edef1ee8fmr1871326e87.26.1721132005279; Tue, 16 Jul 2024
 05:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708172339.GA139099@bhelgaas> <e1ed82cb-6d20-4ca8-b047-4a02dde115a8@gmail.com>
 <CACfW=qpNmSeQVG_qSeYpEdk9pf_RTAEEKp+OiBYrRFd3d6HOXg@mail.gmail.com> <ad0d1201-1fe1-4170-8cfa-d23e74ef8bfd@gmail.com>
In-Reply-To: <ad0d1201-1fe1-4170-8cfa-d23e74ef8bfd@gmail.com>
From: George-Daniel Matei <danielgeorgem@chromium.org>
Date: Tue, 16 Jul 2024 14:13:14 +0200
Message-ID: <CACfW=qrCrXM6Et=Yafug00pbYZzifhVGLhdLMsdYiYXSh=tGFA@mail.gmail.com>
Subject: Re: [PATCH] PCI: r8169: add suspend/resume aspm quirk
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, nic_swsd@realtek.com, netdev@vger.kernel.org, 
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 7:45=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
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
> >>         rc =3D pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);1
>
> With this (older) 6.1 version everything is ok?
> Would mean that L1.1 is active and the system suspends (STR?) properly
> also with L1.1 being active.
>
Yes, with 6.1 everything was ok. L1 was active and just the L1.1 substate
was enabled, L1.2 was disabled.

> Under 6.6 per default L1 (incl. sub-states) is disabled.
> Then you manually enable L1 (incl. L1.1, but not L1.2?) via sysfs,
> and now the system hangs on suspend?
>
Yes, in 6.6 L1 (+substates) is disabled. Like Bjorn mentioned, I
think that is because of 90ca51e8c654 ("r8169:
fix ASPM-related issues on a number of systems with NIC version from
RTL8168h". With L1 disabled the system would not suspend so I enabled
back L1 along with just L1.1 substate through sysfs, just to test, and
saw that the system could
suspend again.  L1 is disabled by default for a reason, that's because
it could cause tx timeouts. So to try to work around the possible timeouts
I thought  of changing the ASPM states before suspending and then
restoring on resume.

> Is this what you're saying? Would be strange because in both cases
> L1.1 is active when suspending.
>
>
> > For the listed devices, ASPM L1 is disabled entirely in 6.6. As for
> > the reason, L1 was observed to cause some problems
> > (https://bugzilla.kernel.org/show_bug.cgi?id=3D217814). We use a Raptor
> > Lake soc and it won't change residency if the NIC doesn't have L1
> > enabled. I saw in 6.1 the following comment:
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

