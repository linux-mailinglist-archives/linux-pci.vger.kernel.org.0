Return-Path: <linux-pci+bounces-7418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E897E8C3F41
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 12:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8CF28B6C5
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 10:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99CF14B075;
	Mon, 13 May 2024 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="QwbVZhVx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE6914A4CA
	for <linux-pci@vger.kernel.org>; Mon, 13 May 2024 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596865; cv=none; b=FCCE/TVDi0ohGVk53s+z2km0b13WUDv2aZwa/vbYX+w6vcIFigShXirNPBDVrYeBbav2UpSqb/hnRG22HtcNoDaVc2g51puXznW3hbZe6OVQwUSF6Tja8OAWJYT6B1f6BObEIq/bzJLcm+nNuWKo6Q2Oo31gU6i6cL49gA3TmU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596865; c=relaxed/simple;
	bh=jcWHkZ+4h0/UemeChWj8Javj6dw64yaQ09G20AXq5LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpcirui64wTGeIslz6HbgYVf8oRDGpRN4Pgk1afV+zus4v3bD/ISttGEOaF+FgKB35dLsaAA9vHIvZt1IQc+adOXDNpTE2Homd6bVygGgotoE3p5GLEQLF3C9uJSd3NL8K0j7QXsD/sjniafPckrcTTwoob26bUMarNfA8VU1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=QwbVZhVx; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61e01d5ea74so43006497b3.2
        for <linux-pci@vger.kernel.org>; Mon, 13 May 2024 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1715596862; x=1716201662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpn5OEPW7Xw/aeDTszRYfR0y7RQ53gJ6+nm+7uYU0a0=;
        b=QwbVZhVxt/jP4bDQfD1vSYRPaua7qFulOfiGrJ/S76hhM66yzEQUVQ8YZuMFGqWIBc
         OELFuluhbyz9WermoJNhgmC0zO2WATAVXdcb+yubM367LhGlsoprJWIpV2wBOrSzZ1/i
         Oagz796Ih8/6DmwudRA8X9ia9G9003qVpAXET/xQ1VDSI20sU0A1M1lYMFU7AeDXtIMe
         slhcZ3o37RaRJMZmOSphRw1VUFSOLmHRpTczvuDws3hV+wak9XuRTAxsfNOk/FeyYJzN
         r2xOwJPSdlUYmLo0g3Ge3uAPrgydmG3RfMjQ9SFpnb7e4HnNp9Y3XhGnR4LxfxNbvb1U
         ENQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715596862; x=1716201662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpn5OEPW7Xw/aeDTszRYfR0y7RQ53gJ6+nm+7uYU0a0=;
        b=u5n31HeyvKmvrD5GMOQ/8HYfQKZZYZ1bJf+/UzAneHvcAUG6z0zktjIHq7RfL28ydV
         N23lP6+Ebwz0p269MN9QcBiH0neFbZE4FpCRSODiIQvLpGMT4wKULvwnR/2BpfNS/skF
         Xfevg8cbuXZVCpKb6taVZMktPUSatG0SQXsuKPry8VWP/OV2bcGvJx7WSTg2eIuounS3
         BZ4Y6nG56Nn5RKZcMFMlrHXsUY2SpTm2qsJSYy1jsgdW3pJmTa9hfuMpip3IvM9ybtoh
         LU3zBpiDFe/kLWQLWbz0zV5MGm1i7IO+lfR2kSZQ4psHE0uxZ/exCv/vDBxazjlj48v1
         0ylg==
X-Forwarded-Encrypted: i=1; AJvYcCUABof+oQRq348qYO8DMHSU9J6Sn9eTrm0UtQ69GWMDaVOvVX/kNkWwf2MVHoX7T/zzcvHU98RijuoegaGcMKRiZWkNY84emLCa
X-Gm-Message-State: AOJu0YyRljpjClgKuLMKBN4hpYcWuQhBXqd/jE7u7ptBlao4FGdOF+FR
	iqR+Dz3SxokpTY+dTVWFbfY0itt/DE9ReVSaxzjFn1U+P/XPmxu+pEj9lnusKLx4uJGZChpguYZ
	2oBz5fZUiJJVPNcWSisYyl2qSsvAnIaBOAAvYblwNU8Yh4BTYxhI=
X-Google-Smtp-Source: AGHT+IHQGxRzolOCahReQ7cGRUPf0/JeOtm5YvnQn9yRp4CWZUs2MFL/+7owYaL7Q+mk9jm6en4s4LkPmZHSRwWX/rI=
X-Received: by 2002:a25:bc49:0:b0:deb:d672:db6a with SMTP id
 3f1490d57ef6-dee4f1ce8damr9431930276.5.1715596862191; Mon, 13 May 2024
 03:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <876d19b7702dc16010b56bce049e2ab60bf68e3b.camel@linux.intel.com> <20240503222803.GA1608065@bhelgaas>
In-Reply-To: <20240503222803.GA1608065@bhelgaas>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Mon, 13 May 2024 18:40:26 +0800
Message-ID: <CAPpJ_ef0SQiPN1U30HgHPvNLFrDHXQfinE6t+5EwHOhmf2v_Gw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] PCI/ASPM: Fix L1.2 parameters when enable link state
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "David E. Box" <david.e.box@linux.intel.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, Johan Hovold <johan@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
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
>
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

According to the discussion above, the misconfiguration of ASPM L1.2
timings comes from pci_reset_bus() which is added by another issue
related to VT-d pass-through:
* 6aab5622296b ("PCI: vmd: Clean up domain before enumeration")
* 0a584655ef89 ("PCI: vmd: Fix secondary bus reset for Intel bridges")
However, I do not quite understand the scenario.

Should I drop patches "PCI/ASPM: Introduce aspm_get_l1ss_cap()" and
"PCI/ASPM: Fix L1.2 parameters when enable link state", then only send
"PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates"
and "PCI/ASPM: Add notes about enabling PCI-PM L1SS to
pci_enable_link_state(_locked)" first?

Jian-Hong Pan

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

