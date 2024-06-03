Return-Path: <linux-pci+bounces-8179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CB28D7C76
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 09:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4BB283268
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 07:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860083FB1C;
	Mon,  3 Jun 2024 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="VQG/WwcL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8054CB5B
	for <linux-pci@vger.kernel.org>; Mon,  3 Jun 2024 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399789; cv=none; b=PC8wcORwvgM9vclpE1XtgFt4opDyr7I0fQatCCBP3oI0AQNB6GWNxVIHsyQVcItEaotzdlCdXPLqAwUmptDkIVjO1L2ys8onF1d3iZ34/BOBzosoNhx7KLcMzI9gSYA+K41p9AXj1wFW2jazKJVQ/fbTSeaHEQV+Ot9n+8g4OCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399789; c=relaxed/simple;
	bh=FQcaGvqxHgAWtH/m1ETOvuY4XHfiqtWUGWeGThQtu6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMF9pRQJCjCXJhp/lJgMNHsENYZJlnEA9dRoFwyyiKG5VMljjSbllYLjwTBm86dztSM8QO9ZNnzPcFcE+J7jAIwIbI1wSuoJx1z6c3iWTrxo9eqtAkhrbpuclE4AT9VjLhMJqKHdaTMDKG7NYAK6NlWRXiPFIyATeLEqFhqR/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=VQG/WwcL; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-627efad69b4so27738437b3.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Jun 2024 00:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1717399786; x=1718004586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvOcvTxOe86cH/fhIth8mSwHCM4OmKwF1BNDBKgFY24=;
        b=VQG/WwcL/ssf+9doCUgLph5DmuGUzf6WOY8pG+fegWr6fcXmeK0vpGU3T8Q2e2WG0E
         A7tcP58ooKvHlIVwgkZqYTE/jhlCtcrmt+Bh06kPUYTZwg6qNpfi9QFe3G7Km4YqSsUQ
         gjtgZLVczLcoTpOWMvQHscSAqQaiUhPeer9ir7Dp2fnjtOPAR32yXMQ1er6l0rV59LEe
         q6V/QN084Nclozhgmto4wjpFCOu9DiCCOKORPaxVgfpW/v8kBJVceeh14rfhbyXZkeJJ
         DTovQmo4i5RlLgbngBuLuOwViFQtODSMby0uCZw+cC8XZxzS6K/eTyV1C1SDknC354kX
         OJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717399786; x=1718004586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvOcvTxOe86cH/fhIth8mSwHCM4OmKwF1BNDBKgFY24=;
        b=fAMFb2SP2VQhgU7HB62Tb3VrfhRbN+wO3I4yd/aH7Cdxir9DuAAJ9YwwaWFSO969G2
         KgRoQ9JxR9KGKjlo7Vk+nbcAXLs2lPWk8e7c4E4DERPuu2gwGMyQVgo5l93Ndhr549vZ
         +srrX0y098cYIOWr7EU+UgodiFzabAxLfsg3NpTK33phVXydwtKOTM9dBftKEWWySpAi
         IP8siAX149/jdjBsI27aZjUGW9RpP7xyl/YDPRGSVn8VGLkNVeRGRvsg+3QsMbP7AWcD
         TYMNhWwkHPGPbNDrP4Chfipo07lTzN5fBOKmPxn49+qYw7FXzn7kvUpoZRO1vl29JlAi
         JD+A==
X-Forwarded-Encrypted: i=1; AJvYcCXV5KJnTtKBBmMcUNDRCL/Mw6VyvatBNdoGN8nOOthe7vd1eEyjXhhHV4/JLLHhG4/YHiN6SzyODVUDB7EcpcJXUWadjajRdXg3
X-Gm-Message-State: AOJu0YwGQKNMcoE+VDKZkey6sGmUX5SPQolDHZvBg88GZ7XZ9UGPyGJZ
	HfJdG+dCnTiZYuMl45n5/RZyQw0B1WJoQvzGjeiBtxPEQqYKJfeSD79sbcEJWlgj7gcCqCR6Cmi
	r/chYB6TSM6f2s0rr54w2K9h1hTtEtM7evj2SSB/UJLP4n0IT/mw=
X-Google-Smtp-Source: AGHT+IEX2Evxyflw/CMHyoRJQLoVCR2jENihjiIc1hKIoKNsqbbPOIWHyMXEQKyDnuNQA4sZF5AXtFcqOGTkk0FvuqE=
X-Received: by 2002:a25:af4a:0:b0:dfa:72d1:e296 with SMTP id
 3f1490d57ef6-dfa73c3dfb3mr7814417276.35.1717399786078; Mon, 03 Jun 2024
 00:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <876d19b7702dc16010b56bce049e2ab60bf68e3b.camel@linux.intel.com> <20240503222803.GA1608065@bhelgaas>
In-Reply-To: <20240503222803.GA1608065@bhelgaas>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Mon, 3 Jun 2024 15:29:10 +0800
Message-ID: <CAPpJ_ecZKXL1w8CvNf-48sPuH4XXCE5afB3fJG2c+g2JNX0FEQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] PCI/ASPM: Fix L1.2 parameters when enable link state
To: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "David E. Box" <david.e.box@linux.intel.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, Johan Hovold <johan@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bjorn Helgaas <helgaas@kernel.org> =E6=96=BC 2024=E5=B9=B45=E6=9C=884=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=886:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> [+cc Francisco]
>
> On Fri, May 03, 2024 at 12:15:49PM -0700, David E. Box wrote:
> > On Fri, 2024-05-03 at 17:45 +0800, Jian-Hong Pan wrote:
> > > David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B45=
=E6=9C=881=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:26=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > On Tue, 2024-04-30 at 15:46 +0800, Jian-Hong Pan wrote:
> > > > > David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=
=B44=E6=9C=8827=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=888:03=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > > > > > On Wed, 2024-04-24 at 19:02 +0800, Jian-Hong Pan wrote:
> > > > > > > Currently, when enable link's L1.2 features with
> > > > > > > __pci_enable_link_state(),
> > > > > > > it configs the link directly without ensuring related L1.2 pa=
rameters,
> > > > > > > such
> > > > > > > as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHO=
LD have
> > > > > > > been
> > > > > > > programmed.
> > > > > > >
> > > > > > > This leads the link's L1.2 between PCIe Root Port and child d=
evice
> > > > > > > gets
> > > > > > > wrong configs when a caller tries to enabled it.
> > > > > > >
> > > > > > > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> > > > > > >
> > > > > > > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Pro=
cessor
> > > > > > > PCIe
> > > > > > > Controller (rev 01) (prog-if 00 [Normal decode])
> > > > > > >     ...
> > > > > > >     Capabilities: [200 v1] L1 PM Substates
> > > > > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L=
1.1+
> > > > > > > L1_PM_Substates+
> > > > > > >                   PortCommonModeRestoreTime=3D45us PortTPower=
OnTime=3D50us
> > > > > > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_=
L1.1-
> > > > > > >                    T_CommonMode=3D45us LTR1.2_Threshold=3D101=
376ns
> > > > > > >         L1SubCtl2: T_PwrOn=3D50us
> > > > > > >
> > > > > > > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD=
 Blue
> > > > > > > SN550
> > > > > > > NVMe
> > > > > > > SSD (rev 01) (prog-if 02 [NVM Express])
> > > > > > >     ...
> > > > > > >     Capabilities: [900 v1] L1 PM Substates
> > > > > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L=
1.1-
> > > > > > > L1_PM_Substates+
> > > > > > >                   PortCommonModeRestoreTime=3D32us PortTPower=
OnTime=3D10us
> > > > > > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_=
L1.1-
> > > > > > >                    T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> > > > > > >         L1SubCtl2: T_PwrOn=3D10us
> > > > > > >
> > > > > > > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.=
2 on the
> > > > > > > PCIe
> > > > > > > Root Port and the child NVMe, they should be programmed with =
the same
> > > > > > > LTR1.2_Threshold value. However, they have different values i=
n this
> > > > > > > case.
> > > > > > >
> > > > > > > Invoke aspm_calc_l12_info() to program the L1.2 parameters pr=
operly
> > > > > > > before
> > > > > > > enable L1.2 bits of L1 PM Substates Control Register in
> > > > > > > __pci_enable_link_state().
> > > > > > >
> > > > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > > > > > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > > > > > ---
> > > > > > > v2:
> > > > > > > - Prepare the PCIe LTR parameters before enable L1 Substates
> > > > > > >
> > > > > > > v3:
> > > > > > > - Only enable supported features for the L1 Substates part
> > > > > > >
> > > > > > > v4:
> > > > > > > - Focus on fixing L1.2 parameters, instead of re-initializing=
 whole
> > > > > > > L1SS
> > > > > > >
> > > > > > > v5:
> > > > > > > - Fix typo and commit message
> > > > > > > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introdu=
ce
> > > > > > >   aspm_get_l1ss_cap()"
> > > > > > >
> > > > > > >  drivers/pci/pcie/aspm.c | 12 ++++++++++++
> > > > > > >  1 file changed, 12 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.=
c
> > > > > > > index c55ac11faa73..553327dee991 100644
> > > > > > > --- a/drivers/pci/pcie/aspm.c
> > > > > > > +++ b/drivers/pci/pcie/aspm.c
> > > > > > > @@ -1402,6 +1402,8 @@ EXPORT_SYMBOL(pci_disable_link_state);
> > > > > > >  static int __pci_enable_link_state(struct pci_dev *pdev, int=
 state,
> > > > > > > bool
> > > > > > > locked)
> > > > > > >  {
> > > > > > >         struct pcie_link_state *link =3D pcie_aspm_get_link(p=
dev);
> > > > > > > +       struct pci_dev *child =3D link->downstream, *parent =
=3D link-
> > > > > > > >pdev;
> > > > > > > +       u32 parent_l1ss_cap, child_l1ss_cap;
> > > > > > >
> > > > > > >         if (!link)
> > > > > > >                 return -EINVAL;
> > > > > > > @@ -1433,6 +1435,16 @@ static int __pci_enable_link_state(str=
uct
> > > > > > > pci_dev
> > > > > > > *pdev, int state, bool locked)
> > > > > > >                 link->aspm_default |=3D ASPM_STATE_L1_1_PCIPM=
 |
> > > > > > > ASPM_STATE_L1;
> > > > > > >         if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> > > > > > >                 link->aspm_default |=3D ASPM_STATE_L1_2_PCIPM=
 |
> > > > > > > ASPM_STATE_L1;
> > > > > > > +       /*
> > > > > > > +        * Ensure L1.2 parameters: Common_Mode_Restore_Times,
> > > > > > > T_POWER_ON
> > > > > > > and
> > > > > > > +        * LTR_L1.2_THRESHOLD are programmed properly before =
enable
> > > > > > > bits
> > > > > > > for
> > > > > > > +        * L1.2, per PCIe r6.0, sec 5.5.4.
> > > > > > > +        */
> > > > > > > +       if (state & link->aspm_capable & ASPM_STATE_L1_2_MASK=
) {
> > > > > >
> > > > > > This is still mixing PCIE_LINK_STATE flags with ASPM_STATE flag=
s.
>
> FWIW, Ilpo has removed the ASPM_STATE flags, so eventually this would
> have to be updated to apply on the current pci/aspm branch.  We're at
> rc6 already, so likely this will end up being v6.11 material so you'll
> be able to rebase on v6.10-rc1 when it comes out.
>
> > > > > Thanks for your review, but I notice some description in PCIe spe=
c,
> > > > > 5.5.4 L1 PM Substates Configuration:
> > > > > "Prior to setting either or both of the enable bits for L1.2, the
> > > > > values for TPOWER_ON, Common_Mode_Restore_Time, and, if the ASPM =
L1.2
> > > > > Enable bit is to be Set, the LTR_L1.2_THRESHOLD (both Value and S=
cale
> > > > > fields) must be programmed." =3D> I think this includes both "ASP=
M L1.2
> > > > > Enable" and "PCI-PM L1.2 Enable" bits.
> > > >
> > > > That's fine. While the spec clearly calls out the ASPM L1.2 Enable =
bit here,
> > > > I
> > > > see no harm in including PCI-PM L1.2 in that check. This is what th=
e code
> > > > already does in aspm_l1ss_init().
> > > >
> > > > The issue is the mixed used of two different types of flags that do=
n't have
> > > > the
> > > > same meaning. 'state' contains PCIE_LINK_STATE flags which are part=
 of the
> > > > caller API to the pci_<enabled/disable>_link_state() functions. The
> > > > ASPM_STATE
> > > > flags are used internally to aspm.c to track all states and their m=
eaningful
> > > > combinations such as ASPM_STATE_L1_2_MASK which includes ASPM L1.2 =
and PCI-
> > > > PM
> > > > L1.2. You should not do bit operations between them.
> > > >
> > > > Also, you should not require that the timings be calculated only if=
 L1_2 is
> > > > enabled. You should calculate the timings as long as it's capable. =
This is
> > > > also
> > > > what aspm_l1ss_init() does.
> > > >
> > > > The confusion might be over the fact that you are having
> > > > __pci_enable_link_state() call aspm_calc_l12_info(). This should ha=
ve been
> > > > handled during initialization of the link in aspm_l1ss_init() and I=
'm not
> > > > sure
> > > > why it didn't. Maybe it's because, for VMD, ASPM default state woul=
d have
> > > > started out all disabled and this somehow led to aspm_l1ss_init() n=
ot
> > > > getting
> > > > called. But looking through the code I don't see it. It would be gr=
eat if
> > > > you
> > > > can confirm why they weren't calculated before.
> > >
> > > I debug it again.  If I delete the pci_reset_bus() in vmd controller =
like:
> > >
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vm=
d.c
> > > index 87b7856f375a..39bfda4350bf 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -930,25 +930,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd=
,
> > > unsigned long features)
> > >         pci_scan_child_bus(vmd->bus);
> > >         vmd_domain_reset(vmd);
> > >
> > > -       /* When Intel VMD is enabled, the OS does not discover the Ro=
ot Ports
> > > -        * owned by Intel VMD within the MMCFG space. pci_reset_bus()=
 applies
> > > -        * a reset to the parent of the PCI device supplied as argume=
nt. This
> > > -        * is why we pass a child device, so the reset can be trigger=
ed at
> > > -        * the Intel bridge level and propagated to all the children =
in the
> > > -        * hierarchy.
> > > -        */
> > > -       list_for_each_entry(child, &vmd->bus->children, node) {
> > > -               if (!list_empty(&child->devices)) {
> > > -                       dev =3D list_first_entry(&child->devices,
> > > -                                              struct pci_dev, bus_li=
st);
> > > -                       ret =3D pci_reset_bus(dev);
> >
> > Hi Nirmal. It's not clear to me from the comment why there's a need to =
do a bus
> > reset. It looks like it is causing misconfiguration of the ASPM L1.2 ti=
mings
> > which would have been done above in pci_scan_child_bus(). Jian-Hong dis=
covered
> > that without the above reset code, the timings are correct.
>
> I don't understand that comment either.  If we don't enumerate the
> Root Ports below VMD, it sounds like something is wrong, and reset
> doesn't seem like the right fix.
>
> The reset was added by 0a584655ef89 ("PCI: vmd: Fix secondary bus
> reset for Intel bridges") for guest reboots.  Maybe Francisco can shed
> more light on it.

Hi Francisco,

We found: the VMD remapped PCI devices' (PCIe bridge and NVMe SSD)
PCIe LTR1.2_Threshold is correct originally, but becomes misconfigured
after "pci_reset_bus()" in "vmd_enable_domain()".

Here is an example that the PCI bridge and its child NVMe SSD have
different LTR1.2_Threshold:

10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor
PCIe Controller (rev 01) (prog-if 00 [Normal decode])
    ...
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
                  PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
        L1SubCtl2: T_PwrOn=3D50us

10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue
SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express])
    ...
    Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
L1_PM_Substates+
                  PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
        L1SubCtl2: T_PwrOn=3D10us

It will be great to have your knowledge: Is resetting a PCI device at
bridge level still needed here?

Thanks,
Jian-Hong Pan

> > This patch recalculates the timings during the call to pci_enable_link_=
state()
> > which is called during pci_bus_walk() below. Originally I thought the
> > recalculation might have been needed by all callers to pci_enabled_link=
_state()
> > since it changes the default BIOS configuration. But it looks like the =
reset is
> > the cause and only the VMD driver would need the recalculation as a res=
ult. I
> > don't see qcom doing a reset.
> >
> > Jian-Hong, given this (and assuming the reset is needed) I would not ca=
ll
> > aspm_calc_l12_info() from pci_enable_link_state() but instead try redoi=
ng the
> > whole ASPM initialization right after the resets are done, maybe by cal=
ling
> > pci_scan_child_bus() again. What do you think Bjorn?
>
> I would expect pci_reset_bus() to save and restore config space, but
> if we don't enumerate all the devices correctly, I suppose we wouldn't
> do that for devices we don't know about.
>
> > > -                       if (ret)
> > > -                               pci_warn(dev, "can't reset device: %d=
\n",
> > > ret);
> > > -
> > > -                       break;
> > > -               }
> > > -       }
> > > -
> > >         pci_assign_unassigned_bus_resources(vmd->bus);
> > >
> > >         pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
> > >
> > > Although PCI-PM_L1.2 is disabled, both PCI bridge and the NVMe's
> > > LTR1.2_Threshold are configured as 101376ns:
> > >
> > > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core
> > > Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal
> > > decode])
> > > ...
> > >   Capabilities: [200 v1] L1 PM Substates
> > >   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Sub=
states+
> > >     PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
> > >   L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > >      T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> > >   L1SubCtl2: T_PwrOn=3D50us
> > >
> > > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD
> > > Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> > > ...
> > >   Capabilities: [900 v1] L1 PM Substates
> > >   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Sub=
states+
> > >     PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
> > >   L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > >      T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> > >   L1SubCtl2: T_PwrOn=3D50us
> > >
> > > Then, I apply the patch "PCI: vmd: Set PCI devices to D0 before enabl=
e
> > > PCI PM's L1 substates".  Both PCI bridge and the NVMe's PCI-PM_L1.2 i=
s
> > > enabled and LTR1.2_Threshold is configured as 101376ns.
> > >
> > > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core
> > > Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal
> > > decode])
> > > ...
> > >   Capabilities: [200 v1] L1 PM Substates
> > >   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Sub=
states+
> > >     PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
> > >   L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > >      T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> > >   L1SubCtl2: T_PwrOn=3D50us
> > >
> > > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD
> > > Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> > > ...
> > >   Capabilities: [900 v1] L1 PM Substates
> > >   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Sub=
states+
> > >     PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
> > >   L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > >      T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> > >   L1SubCtl2: T_PwrOn=3D50us
> > >
> > > I do not know VMD very much.  However, from the test result, it looks
> > > like LTR1.2_Threshold has been configured properly originally.  But,
> > > LTR1.2_Threshold is misconfigured by 'pci_reset_bus()'.
> > > ...
> > > > > > 'state' should not even matter.
> > > > > > The timings should always be calculated and programmed as long
> > > > > > as L1_2 is capable. That way the timings are ready even if L1_2=
 isn't
> > > > > > being
> > > > > > enabled now (in case the user enables it later).
> > > > > >
> > > > > > > +               parent_l1ss_cap =3D aspm_get_l1ss_cap(parent)=
;
> > > > > > > +               child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> > > > > > > +               aspm_calc_l12_info(link, parent_l1ss_cap,
> > > > > > > child_l1ss_cap);
> > > > > > > +       }
> > > > > > >         pcie_config_aspm_link(link, policy_to_aspm_state(link=
));
> > > > > > >
> > > > > > >         link->clkpm_default =3D (state & PCIE_LINK_STATE_CLKP=
M) ? 1 : 0;
> > > > > >
> > > >
> >

