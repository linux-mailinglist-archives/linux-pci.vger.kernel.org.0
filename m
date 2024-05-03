Return-Path: <linux-pci+bounces-7039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624F68BAA22
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 11:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857451C215D4
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 09:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4177914F12D;
	Fri,  3 May 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="q07+nShz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA6814F13D
	for <linux-pci@vger.kernel.org>; Fri,  3 May 2024 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729588; cv=none; b=DU/fCJ6FDo0aocMd9S59Xn7MUEeMcu4I67AfxM43bVtjhZ84QK9/prul3CsAFF/JPNrU9LcBp1QZdeWsYfIhffBgKxvrwWWEWtYxdE0HhZX0goA2D+pWYtLnMs/+MAV9xyMvv3JFxdWFnTjqlG6PPL0qJR4USUx9LcJOnLi3XiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729588; c=relaxed/simple;
	bh=mMa55G8JHExAT8rwlOi7NwaLMkdhItOV46PcE5Z5BYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItUrwHCKQAFGnnhp4hM7CdrGYJG6I92vvh62l8ED+JONsROSHAKUK37vbS59fVkz7tZAHQ7faROzaEt1hHwANgpDKZz/TdrLG/aawoQp3e2ATDtWklYJFzclEF/BI7Si6pCwNxR4CXZg3aU5ITCx+ejI07tzIPyfZckHYXAAEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=q07+nShz; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de54b28c41eso9938975276.0
        for <linux-pci@vger.kernel.org>; Fri, 03 May 2024 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1714729585; x=1715334385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XPykcI0UfxbdDQHGE+xDIXBPrTmMpzWz1kaiWK2og0=;
        b=q07+nShz8ATmlIgYOZLRHzTjJh1FnkrmTvI7eZWG5VnhwLSQdrOKIh9jDwsFSWD/Lp
         QtYCq6lwsuOCShfDebCWJaIvYsEJpxqrIV+MR47i9gFCS7o1r6N60RO8SIeM0fy0gDum
         ODuQx5lrKQQ/kjC9inAPz67Ggj186utIeJkpegJq0SoWfA7HYf4383l35BSXJP9ku3Ho
         wC3fbeYHNPN89CM0yOxeZV0syeQrP9v/OKX98Ws8QZ11FeBoWx3lAhxOHqE7e1RnCMlx
         8th1Mn2xwDvoa5ZgqYKWGTRxmPdLAsYJ2VtQ9lqKZcZvyDkXkY8qTiXzK4GPcOLs2mKZ
         GlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714729585; x=1715334385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XPykcI0UfxbdDQHGE+xDIXBPrTmMpzWz1kaiWK2og0=;
        b=i2vWfwM/inHRGv9VuNLK6id/180EzPFhq8AFvbjnhtlFG3IXgzLeZzxlPahlepzjWe
         tW54M6fA7l1KWkOXUlVarPfzqIVoZQrWzmO5BZ2PxQZMZ7Ev+v4dY2/ezmdUgkFKPFqQ
         gWjHfXoveo+98zWJvZiT9IciCDFkyNhFQ+S/OVXt3AsLhwf189fUb0v9e6MKrEWh0mPz
         hnNc+hem+tJZ3LHdUsWXbSDJFp7leeX6AQvY+A3meCGhQRvSEbzsnsczAEO9KHULB/kO
         HO4syC5GNtczEP21Uhwb7+Wf0AopWmkRG6cU6apYmFLndwTcEsq11klk3dB85hdOLaDL
         J8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTDG7ejfi7NsN7FHx5IhH0Il5+r4fPXqM/EL3QrU+nsR5hph+kMsWWVGHyoSqN9uIxXJARKGiZxEdOu/ql2Y/3AUdfYt6l13h6
X-Gm-Message-State: AOJu0Yx8zat8zPAK3VXhprlT3LIhNb4F8T9S/xHYROwP6hH+QwZLEaYY
	wHnjYlnsN6+Db14MfRcnXhPy7FKlkkdIsFeB1Q1tYhm9ydykfh7oBgNal9t4+lAY0z0ILHVYDwr
	ygcyUMB8HdTOvcd0WhbPOiE8OAnPB59vM37wnf5VomJoJidWZ6Lo=
X-Google-Smtp-Source: AGHT+IHxMeWpfG77Zjt2ywfgRCZfRqj9TwqocACqKJsQiGyrtNgf+UfjGDogzVQc+MAQ/u6Eipn1I6bfy63n6kXjzDI=
X-Received: by 2002:a25:938b:0:b0:de5:a370:eb60 with SMTP id
 a11-20020a25938b000000b00de5a370eb60mr2509895ybm.46.1714729585059; Fri, 03
 May 2024 02:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424110223.21799-2-jhp@endlessos.org> <f111371300624b6f94f0746dbae66bd49f405eea.camel@linux.intel.com>
 <CAPpJ_ecOah=gYfYJVX-TypRiK8+oons3rKOVOATb4epm6sGZaw@mail.gmail.com> <af74b8d4f1f7072ffebc8a7f5cf392140da73dc7.camel@linux.intel.com>
In-Reply-To: <af74b8d4f1f7072ffebc8a7f5cf392140da73dc7.camel@linux.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Fri, 3 May 2024 17:45:49 +0800
Message-ID: <CAPpJ_efYWWxGBopbSQHB=Y2+1RrXFR2XWeqEhGTgdiw3XX0Jmw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] PCI/ASPM: Fix L1.2 parameters when enable link state
To: david.e.box@linux.intel.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B45=E6=9C=
=881=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:26=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Tue, 2024-04-30 at 15:46 +0800, Jian-Hong Pan wrote:
> > David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B44=E6=
=9C=8827=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=888:03=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > Hi Jian-Hong,
> > >
> > > On Wed, 2024-04-24 at 19:02 +0800, Jian-Hong Pan wrote:
> > > > Currently, when enable link's L1.2 features with
> > > > __pci_enable_link_state(),
> > > > it configs the link directly without ensuring related L1.2 paramete=
rs,
> > > > such
> > > > as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD hav=
e been
> > > > programmed.
> > > >
> > > > This leads the link's L1.2 between PCIe Root Port and child device =
gets
> > > > wrong configs when a caller tries to enabled it.
> > > >
> > > > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> > > >
> > > > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor=
 PCIe
> > > > Controller (rev 01) (prog-if 00 [Normal decode])
> > > >     ...
> > > >     Capabilities: [200 v1] L1 PM Substates
> > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > > > L1_PM_Substates+
> > > >                   PortCommonModeRestoreTime=3D45us PortTPowerOnTime=
=3D50us
> > > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > >                    T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> > > >         L1SubCtl2: T_PwrOn=3D50us
> > > >
> > > > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue =
SN550
> > > > NVMe
> > > > SSD (rev 01) (prog-if 02 [NVM Express])
> > > >     ...
> > > >     Capabilities: [900 v1] L1 PM Substates
> > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > > L1_PM_Substates+
> > > >                   PortCommonModeRestoreTime=3D32us PortTPowerOnTime=
=3D10us
> > > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > >                    T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> > > >         L1SubCtl2: T_PwrOn=3D10us
> > > >
> > > > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on t=
he PCIe
> > > > Root Port and the child NVMe, they should be programmed with the sa=
me
> > > > LTR1.2_Threshold value. However, they have different values in this=
 case.
> > > >
> > > > Invoke aspm_calc_l12_info() to program the L1.2 parameters properly=
 before
> > > > enable L1.2 bits of L1 PM Substates Control Register in
> > > > __pci_enable_link_state().
> > > >
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > > ---
> > > > v2:
> > > > - Prepare the PCIe LTR parameters before enable L1 Substates
> > > >
> > > > v3:
> > > > - Only enable supported features for the L1 Substates part
> > > >
> > > > v4:
> > > > - Focus on fixing L1.2 parameters, instead of re-initializing whole=
 L1SS
> > > >
> > > > v5:
> > > > - Fix typo and commit message
> > > > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
> > > >   aspm_get_l1ss_cap()"
> > > >
> > > >  drivers/pci/pcie/aspm.c | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > index c55ac11faa73..553327dee991 100644
> > > > --- a/drivers/pci/pcie/aspm.c
> > > > +++ b/drivers/pci/pcie/aspm.c
> > > > @@ -1402,6 +1402,8 @@ EXPORT_SYMBOL(pci_disable_link_state);
> > > >  static int __pci_enable_link_state(struct pci_dev *pdev, int state=
, bool
> > > > locked)
> > > >  {
> > > >         struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> > > > +       struct pci_dev *child =3D link->downstream, *parent =3D lin=
k->pdev;
> > > > +       u32 parent_l1ss_cap, child_l1ss_cap;
> > > >
> > > >         if (!link)
> > > >                 return -EINVAL;
> > > > @@ -1433,6 +1435,16 @@ static int __pci_enable_link_state(struct pc=
i_dev
> > > > *pdev, int state, bool locked)
> > > >                 link->aspm_default |=3D ASPM_STATE_L1_1_PCIPM |
> > > > ASPM_STATE_L1;
> > > >         if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> > > >                 link->aspm_default |=3D ASPM_STATE_L1_2_PCIPM |
> > > > ASPM_STATE_L1;
> > > > +       /*
> > > > +        * Ensure L1.2 parameters: Common_Mode_Restore_Times, T_POW=
ER_ON
> > > > and
> > > > +        * LTR_L1.2_THRESHOLD are programmed properly before enable=
 bits
> > > > for
> > > > +        * L1.2, per PCIe r6.0, sec 5.5.4.
> > > > +        */
> > > > +       if (state & link->aspm_capable & ASPM_STATE_L1_2_MASK) {
> > >
> > > This is still mixing PCIE_LINK_STATE flags with ASPM_STATE flags.
> >
> > Thanks for your review, but I notice some description in PCIe spec,
> > 5.5.4 L1 PM Substates Configuration:
> > "Prior to setting either or both of the enable bits for L1.2, the
> > values for TPOWER_ON, Common_Mode_Restore_Time, and, if the ASPM L1.2
> > Enable bit is to be Set, the LTR_L1.2_THRESHOLD (both Value and Scale
> > fields) must be programmed." =3D> I think this includes both "ASPM L1.2
> > Enable" and "PCI-PM L1.2 Enable" bits.
>
> That's fine. While the spec clearly calls out the ASPM L1.2 Enable bit he=
re, I
> see no harm in including PCI-PM L1.2 in that check. This is what the code
> already does in aspm_l1ss_init().
>
> The issue is the mixed used of two different types of flags that don't ha=
ve the
> same meaning. 'state' contains PCIE_LINK_STATE flags which are part of th=
e
> caller API to the pci_<enabled/disable>_link_state() functions. The ASPM_=
STATE
> flags are used internally to aspm.c to track all states and their meaning=
ful
> combinations such as ASPM_STATE_L1_2_MASK which includes ASPM L1.2 and PC=
I-PM
> L1.2. You should not do bit operations between them.
>
> Also, you should not require that the timings be calculated only if L1_2 =
is
> enabled. You should calculate the timings as long as it's capable. This i=
s also
> what aspm_l1ss_init() does.
>
> The confusion might be over the fact that you are having
> __pci_enable_link_state() call aspm_calc_l12_info(). This should have bee=
n
> handled during initialization of the link in aspm_l1ss_init() and I'm not=
 sure
> why it didn't. Maybe it's because, for VMD, ASPM default state would have
> started out all disabled and this somehow led to aspm_l1ss_init() not get=
ting
> called. But looking through the code I don't see it. It would be great if=
 you
> can confirm why they weren't calculated before.

I debug it again.  If I delete the pci_reset_bus() in vmd controller like:

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..39bfda4350bf 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -930,25 +930,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
unsigned long features)
        pci_scan_child_bus(vmd->bus);
        vmd_domain_reset(vmd);

-       /* When Intel VMD is enabled, the OS does not discover the Root Por=
ts
-        * owned by Intel VMD within the MMCFG space. pci_reset_bus() appli=
es
-        * a reset to the parent of the PCI device supplied as argument. Th=
is
-        * is why we pass a child device, so the reset can be triggered at
-        * the Intel bridge level and propagated to all the children in the
-        * hierarchy.
-        */
-       list_for_each_entry(child, &vmd->bus->children, node) {
-               if (!list_empty(&child->devices)) {
-                       dev =3D list_first_entry(&child->devices,
-                                              struct pci_dev, bus_list);
-                       ret =3D pci_reset_bus(dev);
-                       if (ret)
-                               pci_warn(dev, "can't reset device: %d\n", r=
et);
-
-                       break;
-               }
-       }
-
        pci_assign_unassigned_bus_resources(vmd->bus);

        pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);

Although PCI-PM_L1.2 is disabled, both PCI bridge and the NVMe's
LTR1.2_Threshold are configured as 101376ns:

10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core
Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal
decode])
...
  Capabilities: [200 v1] L1 PM Substates
  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates=
+
    PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
  L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
     T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
  L1SubCtl2: T_PwrOn=3D50us

10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD
Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
...
  Capabilities: [900 v1] L1 PM Substates
  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates=
+
    PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
  L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
     T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
  L1SubCtl2: T_PwrOn=3D50us

Then, I apply the patch "PCI: vmd: Set PCI devices to D0 before enable
PCI PM's L1 substates".  Both PCI bridge and the NVMe's PCI-PM_L1.2 is
enabled and LTR1.2_Threshold is configured as 101376ns.

10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core
Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal
decode])
...
  Capabilities: [200 v1] L1 PM Substates
  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates=
+
    PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
  L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
     T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
  L1SubCtl2: T_PwrOn=3D50us

10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD
Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
...
  Capabilities: [900 v1] L1 PM Substates
  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates=
+
    PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
  L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
     T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
  L1SubCtl2: T_PwrOn=3D50us

I do not know VMD very much.  However, from the test result, it looks
like LTR1.2_Threshold has been configured properly originally.  But,
LTR1.2_Threshold is misconfigured by 'pci_reset_bus()'.

Jian-Hong Pan



> >
> > Jain-Hong Pan
> >
> > > 'state' should not even matter.
> > > The timings should always be calculated and programmed as long
> > > as L1_2 is capable. That way the timings are ready even if L1_2 isn't=
 being
> > > enabled now (in case the user enables it later).
> > >
> > > David
> > >
> > > > +               parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> > > > +               child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> > > > +               aspm_calc_l12_info(link, parent_l1ss_cap, child_l1s=
s_cap);
> > > > +       }
> > > >         pcie_config_aspm_link(link, policy_to_aspm_state(link));
> > > >
> > > >         link->clkpm_default =3D (state & PCIE_LINK_STATE_CLKPM) ? 1=
 : 0;
> > >
>

