Return-Path: <linux-pci+bounces-12654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69880969A3E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 12:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F90EB24C93
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44441A0BF6;
	Tue,  3 Sep 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Y7Q1nqmv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4EA1B9841
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359531; cv=none; b=nRl42UU8PoQ2+QYd50en1Vpef4T5vnJgs+Y2nxyIFxdnlDo/Z9zO5enR5pmR0cPZbzshvIS9UOzD/+mXQeQUjZNXh+RYZdH6rF0P8c+d5UYdPr56Yhqp++6/DGD6AaE8oq2oDWWVC1A3aMmX5OFdIBi3qHSatH1Rv3+N5/vInDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359531; c=relaxed/simple;
	bh=g+BQndnSQ/jZ8t98Qt3EL5uxMiVUeagDTEntJJ2poTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/20w2Wz9/aX5iGN699d33J2w7/hadIyOqiUGAjmp0dSFvctjmWH4Yi4Kyh4K0qEK04Zyf/LvhIZfU30aPDqctMJiauaUo8U6psVmBV5FHEldgmJk1p1seempFWlO449BXjAJQqqc8HpcJcyxfJ4xOONZEE+wFvlaAtQXRchzWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Y7Q1nqmv; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1a9dc3efc1so2820535276.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2024 03:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1725359528; x=1725964328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBhI+3qYA9cPBuR2PukJkDlon3K6gbOkQAbgvhgFwyU=;
        b=Y7Q1nqmvrjMQpJgi7Fii31LkzzcfssDupXC0V4LpCsecFTj8fajdbJhuxDZds8bXau
         OfuhOCezl9GaTz/FgpdbUfRCec+le16nW+mDTQYPL+jcKHX7kEn08u+/SvWWnnjbQ+aY
         hPCEAtvMDjgQrtxgVayGsyjm1samgBuU76ZWf/F+YWmxelbVrSds57UKPBOqleXDame1
         xI4a4PcRC2vITEVYAijjtHGjMHl3zGP6c2LdazitgsKUk7vMAWppiwsZv447TeZESfVz
         LO2OkJZYIwpyRJDuWiWeoZfk+5ti5UxV7YU2wRJJf2deiKn68ZB/EhHgnzre7elZm72e
         Zmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725359528; x=1725964328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBhI+3qYA9cPBuR2PukJkDlon3K6gbOkQAbgvhgFwyU=;
        b=jcVhYg/F346VDg6Dx0rrRdXka0/z9p5QFx0xRSo3//UBihCey+BBwpc+zbTSyHYsWs
         eoWO/vt0VprwD3QwclACjEBQ4VgJ1/aE9WIToXEViOYUYQ2cTKDIXVhiinx1Kz6L73y7
         DOpI8XHcVSzIbVbBs0iSMc2UgAKwWw0/7rFNlmH9/n8Mwz5xYpd8PTyZ4VmLnuVDrjeb
         DhFssce1KkCvs3XgSXkwvVF+Kg/AT9SQRL1GKrbMt1VTeFZ5BgKCAUEaYGSZa62yu/5a
         qk9Y1tngAfPR5TNNjhCD4m0/DJEOTH3swMM7uE9TZxtqjsxLra/UX+oyK0emhXgOjeTt
         e2Og==
X-Forwarded-Encrypted: i=1; AJvYcCXVJd+kpb6HkSJ/vl5oyobNGKuQOSsxRMdAHgzFwKQJ/mmsfBT30PEPXaAjIpzbXC9ymHe8Z4v7ilE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyawHC/wayHgj+v3V03fYq9cg6pWJIxb1fA8doQm002HW1B/GEm
	/z82Vdbi/a/WRzsZqZ1jK/q1PPU1yjeF6jp+M14iZpcEyXwB0A9XCOd0MXHYd9AXZHIZZJYuck0
	O988dIMOtc48dP63S67v1+yXeJSDFJSuujpUSkg==
X-Google-Smtp-Source: AGHT+IGYN2hClAynDOQSPkdh+tDja2D/Gm5+uHAP/0af6YinOuzCGD4fvpyEFhIKOmdk9my6ZhU65uXaK8bkO/bOJs8=
X-Received: by 2002:a05:6902:90d:b0:e0e:cef6:5265 with SMTP id
 3f1490d57ef6-e1a7a1a377amr13825850276.41.1725359527986; Tue, 03 Sep 2024
 03:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719075200.10717-2-jhp@endlessos.org> <20240719080255.10998-2-jhp@endlessos.org>
 <CAPpJ_edybLMtrN_gxP2h9Z-BuYH+RG-qRqMqgZM1oSVoW1sP5A@mail.gmail.com>
 <e37536a435630583398307682e1a9aadbabfb497.camel@linux.intel.com>
 <CAPpJ_eeATLdcnH9CWpvJM_9juV5ok+OEYysTit_HparqBpQ3CQ@mail.gmail.com>
 <eb900245-5e13-bc6c-994a-43f2db8322ea@linux.intel.com> <fc0e8066b06abed97d3857c5deefb03041a0fd2e.camel@linux.intel.com>
 <f9660f21-f2e8-c62c-5e86-ed4875f61701@linux.intel.com> <CAPpJ_eeO9j38VGaukrw79dqQAZ7Z8+QMOvTbymyV9=fbQBqFzw@mail.gmail.com>
 <4295d0e8-12c7-927c-2da5-682163ec3d9c@linux.intel.com>
In-Reply-To: <4295d0e8-12c7-927c-2da5-682163ec3d9c@linux.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Tue, 3 Sep 2024 18:31:31 +0800
Message-ID: <CAPpJ_ec0ADUmH8VsNh-aHA1zLnDSEhVXKprU1x1ELugwE1M_sQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] PCI/ASPM: Fix L1.2 parameters when enable link state
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "David E. Box" <david.e.box@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Johan Hovold <johan@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, 
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, linux-pci@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E6=96=BC 2024=E5=B9=B49=
=E6=9C=882=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:44=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On Mon, 12 Aug 2024, Jian-Hong Pan wrote:
>
> > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E6=96=BC 2024=E5=B9=
=B48=E6=9C=888=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:49=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > > On Wed, 7 Aug 2024, David E. Box wrote:
> > > > On Wed, 2024-08-07 at 14:18 +0300, Ilpo J=C3=A4rvinen wrote:
> > > > > On Wed, 7 Aug 2024, Jian-Hong Pan wrote:
> > > > >
> > > > > > David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=
=B48=E6=9C=886=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=884:26=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > Hi Jian-Hong,
> > > > > > >
> > > > > > > On Fri, 2024-08-02 at 16:24 +0800, Jian-Hong Pan wrote:
> > > > > > > > Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2024=E5=B9=B47=
=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > Currently, when enable link's L1.2 features with
> > > > > > > > > __pci_enable_link_state(),
> > > > > > > > > it configs the link directly without ensuring related L1.=
2 parameters,
> > > > > > > > > such
> > > > > > > > > as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THR=
ESHOLD have
> > > > > > > > > been
> > > > > > > > > programmed.
> > > > > > > > >
> > > > > > > > > This leads the link's L1.2 between PCIe Root Port and chi=
ld device
> > > > > > > > > gets
> > > > > > > > > wrong configs when a caller tries to enabled it.
> > > > > > > > >
> > > > > > > > > Here is a failed example on ASUS B1400CEAE with enabled V=
MD:
> > > > > > > > >
> > > > > > > > > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core=
 Processor
> > > > > > > > > PCIe
> > > > > > > > > Controller (rev 01) (prog-if 00 [Normal decode])
> > > > > > > > >     ...
> > > > > > > > >     Capabilities: [200 v1] L1 PM Substates
> > > > > > > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ AS=
PM_L1.1+
> > > > > > > > > L1_PM_Substates+
> > > > > > > > >                   PortCommonModeRestoreTime=3D45us PortTP=
owerOnTime=3D50us
> > > > > > > > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ A=
SPM_L1.1-
> > > > > > > > >                    T_CommonMode=3D45us LTR1.2_Threshold=
=3D101376ns
> > > > > > > > >         L1SubCtl2: T_PwrOn=3D50us
> > > > > > > > >
> > > > > > > > > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Cor=
p WD Blue
> > > > > > > > > SN550
> > > > > > > > > NVMe SSD (rev 01) (prog-if 02 [NVM Express])
> > > > > > > > >     ...
> > > > > > > > >     Capabilities: [900 v1] L1 PM Substates
> > > > > > > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ AS=
PM_L1.1-
> > > > > > > > > L1_PM_Substates+
> > > > > > > > >                   PortCommonModeRestoreTime=3D32us PortTP=
owerOnTime=3D10us
> > > > > > > > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ A=
SPM_L1.1-
> > > > > > > > >                    T_CommonMode=3D0us LTR1.2_Threshold=3D=
0ns
> > > > > > > > >         L1SubCtl2: T_PwrOn=3D10us
> > > > > > > > >
> > > > > > > > > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM=
 L1.2 on the
> > > > > > > > > PCIe
> > > > > > > > > Root Port and the child NVMe, they should be programmed w=
ith the same
> > > > > > > > > LTR1.2_Threshold value. However, they have different valu=
es in this
> > > > > > > > > case.
> > > > > > > > >
> > > > > > > > > Invoke aspm_calc_l12_info() to program the L1.2 parameter=
s properly
> > > > > > > > > before
> > > > > > > > > enable L1.2 bits of L1 PM Substates Control Register in
> > > > > > > > > __pci_enable_link_state().
> > > > > > > > >
> > > > > > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D21839=
4
> > > > > > > > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > > > > > > > ---
> > > > > > > > > v2:
> > > > > > > > > - Prepare the PCIe LTR parameters before enable L1 Substa=
tes
> > > > > > > > >
> > > > > > > > > v3:
> > > > > > > > > - Only enable supported features for the L1 Substates par=
t
> > > > > > > > >
> > > > > > > > > v4:
> > > > > > > > > - Focus on fixing L1.2 parameters, instead of re-initiali=
zing whole
> > > > > > > > > L1SS
> > > > > > > > >
> > > > > > > > > v5:
> > > > > > > > > - Fix typo and commit message
> > > > > > > > > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Int=
roduce
> > > > > > > > >   aspm_get_l1ss_cap()"
> > > > > > > > >
> > > > > > > > > v6:
> > > > > > > > > - Skipped
> > > > > > > > >
> > > > > > > > > v7:
> > > > > > > > > - Pick back and rebase on the new version kernel
> > > > > > > > > - Drop the link state flag check. And, always config link=
 state's
> > > > > > > > > timing
> > > > > > > > >   parameters
> > > > > > > > >
> > > > > > > > > v8:
> > > > > > > > > - Because pcie_aspm_get_link() might return the link as N=
ULL, move
> > > > > > > > >   getting the link's parent and child devices after check=
 the link is
> > > > > > > > >   not NULL. This avoids NULL memory access.
> > > > > > > > >
> > > > > > > > >  drivers/pci/pcie/aspm.c | 15 +++++++++++++++
> > > > > > > > >  1 file changed, 15 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/a=
spm.c
> > > > > > > > > index 5db1044c9895..55ff1d26fcea 100644
> > > > > > > > > --- a/drivers/pci/pcie/aspm.c
> > > > > > > > > +++ b/drivers/pci/pcie/aspm.c
> > > > > > > > > @@ -1411,9 +1411,15 @@ EXPORT_SYMBOL(pci_disable_link_sta=
te);
> > > > > > > > >  static int __pci_enable_link_state(struct pci_dev *pdev,=
 int state,
> > > > > > > > > bool
> > > > > > > > > locked)
> > > > > > > > >  {
> > > > > > > > >         struct pcie_link_state *link =3D pcie_aspm_get_li=
nk(pdev);
> > > > > > > > > +       u32 parent_l1ss_cap, child_l1ss_cap;
> > > > > > > > > +       struct pci_dev *parent, *child;
> > > > > > > > >
> > > > > > > > >         if (!link)
> > > > > > > > >                 return -EINVAL;
> > > > > > > > > +
> > > > > > > > > +       parent =3D link->pdev;
> > > > > > > > > +       child =3D link->downstream;
> > > > > > > > > +
> > > > > > > > >         /*
> > > > > > > > >          * A driver requested that ASPM be enabled on thi=
s device, but
> > > > > > > > >          * if we don't have permission to manage ASPM (e.=
g., on ACPI
> > > > > > > > > @@ -1428,6 +1434,15 @@ static int __pci_enable_link_state=
(struct
> > > > > > > > > pci_dev
> > > > > > > > > *pdev, int state, bool locked)
> > > > > > > > >         if (!locked)
> > > > > > > > >                 down_read(&pci_bus_sem);
> > > > > > > > >         mutex_lock(&aspm_lock);
> > > > > > > > > +       /*
> > > > > > > > > +        * Ensure L1.2 parameters: Common_Mode_Restore_Ti=
mes,
> > > > > > > > > T_POWER_ON and
> > > > > > > > > +        * LTR_L1.2_THRESHOLD are programmed properly bef=
ore enable
> > > > > > > > > bits for
> > > > > > > > > +        * L1.2, per PCIe r6.0, sec 5.5.4.
> > > > > > > > > +        */
> > > > > > > > > +       parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> > > > > > > > > +       child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> > > > > > > > > +       aspm_calc_l12_info(link, parent_l1ss_cap, child_l=
1ss_cap);
> > > > > > >
> > > > > > > I still don't think this is the place to recalculate the L1.2=
 parameters
> > > > > > > especially when know the calculation was done but was cleared=
 by
> > > > > > > pci_bus_reset(). Can't we just do a pci_save/restore_state() =
before/after
> > > > > > > pci_bus_reset() in vmd.c?
> > > > > >
> > > > > > I have not thought pci_save/restore_state() around pci_bus_rese=
t()
> > > > > > before.  It is an interesting direction.
> > > > > >
> > > > > > So, I prepare modification below for test.  Include "[PATCH v8 =
1/4]
> > > > > > PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 subst=
ates",
> > > > > > too.  Then, both the PCIe bridge and the PCIe device have the s=
ame
> > > > > > LTR_L1.2_THRESHOLD 101376ns as expected.
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/control=
ler/vmd.c
> > > > > > index bbf4a47e7b31..6b8dd4f30127 100644
> > > > > > --- a/drivers/pci/controller/vmd.c
> > > > > > +++ b/drivers/pci/controller/vmd.c
> > > > > > @@ -727,6 +727,18 @@ static void vmd_copy_host_bridge_flags(str=
uct
> > > > > > pci_host_bridge *root_bridge,
> > > > > >         vmd_bridge->native_dpc =3D root_bridge->native_dpc;
> > > > > >  }
> > > > > >
> > > > > > +static int vmd_pci_save_state(struct pci_dev *pdev, void *user=
data)
> > > > > > +{
> > > > > > +       pci_save_state(pdev);
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int vmd_pci_restore_state(struct pci_dev *pdev, void *u=
serdata)
> > > > > > +{
> > > > > > +       pci_restore_state(pdev);
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > >  /*
> > > > > >   * Enable ASPM and LTR settings on devices that aren't configu=
red by BIOS.
> > > > > >   */
> > > > > > @@ -927,6 +939,7 @@ static int vmd_enable_domain(struct vmd_dev=
 *vmd,
> > > > > > unsigned long features)
> > > > > >         pci_scan_child_bus(vmd->bus);
> > > > > >         vmd_domain_reset(vmd);
> > > > > >
> > > > > > +       pci_walk_bus(vmd->bus, vmd_pci_save_state, NULL);
> > > > > >         /* When Intel VMD is enabled, the OS does not discover =
the Root
> > > > > > Ports
> > > > > >          * owned by Intel VMD within the MMCFG space. pci_reset=
_bus()
> > > > > > applies
> > > > > >          * a reset to the parent of the PCI device supplied as =
argument.
> > > > > > This
> > > > > > @@ -945,6 +958,7 @@ static int vmd_enable_domain(struct vmd_dev=
 *vmd,
> > > > > > unsigned long features)
> > > > > >                         break;
> > > > > >                 }
> > > > > >         }
> > > > > > +       pci_walk_bus(vmd->bus, vmd_pci_restore_state, NULL);
> > > > >
> > > > > Why not call pci_reset_bus() (or __pci_reset_bus()) then in
> > > > > vmd_enable_domain() which preserves state unlike pci_reset_bus()?
> > > > >
> > > > > (Don't tell me naming of these functions is a horrible mess. :-/)
> > > >
> > > > Hmm. So this *is* calling pci_reset_bus().
> > >
> > > Yeah, I managed to get confused by the names myself, I somehow
> > > ended up thinking it calls pci_bus_reset() which is not correct...
> > >
> > > > L1.2 configuration has specific
> > > > ordering requirements for changes to parent & child devices. Could =
be why it's
> > > > not getting restored properly.
> > >
> > > Indeed, it has to be something else since the patch above doesn't eve=
n
> > > restore anything because dev->state_saved should get set to false by =
the
> > > first pci_restore_state() called from
> > > __pci_reset_bus() -> pci_bus_restore_locked() -> pci_dev_restore(), I
> > > think!?
> >
> > Inspired by Ilpo's comment.  I add some debug messages based on
> > linux-next's tag 'next-20240809' to understand the code path of
> > pci_reset_bus():
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index ffaaca0978cb..3ee71374f1de 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5133,8 +5133,10 @@ static void pci_dev_save_and_disable(struct pci_=
dev *dev)
> >          * races with ->remove() by the device lock, which must be held=
 by
> >          * the caller.
> >          */
> > -       if (err_handler && err_handler->reset_prepare)
> > +       if (err_handler && err_handler->reset_prepare) {
> > +               pci_info(dev, "%s: %pF\n", __func__,
> > err_handler->reset_prepare);
> >                 err_handler->reset_prepare(dev);
> > +       }
> >
> >         /*
> >          * Wake-up device prior to save.  PM registers default to D0 af=
ter
> > @@ -5144,6 +5146,7 @@ static void pci_dev_save_and_disable(struct pci_d=
ev *dev)
> >         pci_set_power_state(dev, PCI_D0);
> >
> >         pci_save_state(dev);
> > +       pci_info(dev, "%s: PCI state_saved is %s\n", __func__,
> > dev->state_saved ? "true" : "false");
> >         /*
> >          * Disable the device by clearing the Command register, except =
for
> >          * INTx-disable which is set.  This not only disables MMIO and =
I/O port
> > @@ -5655,6 +5658,10 @@ static void
> > pci_bus_save_and_disable_locked(struct pci_bus *bus)
> >         struct pci_dev *dev;
> >
> >         list_for_each_entry(dev, &bus->devices, bus_list) {
> > +               pci_info(dev, "%s: PCI state_saved is %s, and %s subord=
inate\n",
> > +                        __func__,
> > +                        dev->state_saved ? "true" : "false",
> > +                        dev->subordinate ? "has" : "does not have");
> >                 pci_dev_save_and_disable(dev);
> >                 if (dev->subordinate)
> >                         pci_bus_save_and_disable_locked(dev->subordinat=
e);
> > @@ -5671,6 +5678,10 @@ static void pci_bus_restore_locked(struct pci_bu=
s *bus)
> >         struct pci_dev *dev;
> >
> >         list_for_each_entry(dev, &bus->devices, bus_list) {
> > +               pci_info(dev, "%s: PCI state_saved is %s, and %s subord=
inate\n",
> > +                        __func__,
> > +                        dev->state_saved ? "true" : "false",
> > +                        dev->subordinate ? "has" : "does not have");
> >                 pci_dev_restore(dev);
> >                 if (dev->subordinate)
> >                         pci_bus_restore_locked(dev->subordinate);
> > @@ -5786,8 +5797,10 @@ static int pci_bus_reset(struct pci_bus *bus, bo=
ol probe)
> >         if (!bus->self || !pci_bus_resettable(bus))
> >                 return -ENOTTY;
> >
> > -       if (probe)
> > +       if (probe) {
> > +               pci_info(bus->self, "%s: probe is true.  So return 0
> > directly", __func__);
> >                 return 0;
> > +       }
> >
> >         pci_bus_lock(bus);
> >
> > @@ -5858,10 +5871,12 @@ static int __pci_reset_bus(struct pci_bus *bus)
> >         int rc;
> >
> >         rc =3D pci_bus_reset(bus, PCI_RESET_PROBE);
> > +       pci_info(bus->self, "%s: pci_bus_reset() returns %d\n", __func_=
_, rc);
> >         if (rc)
> >                 return rc;
> >
> >         if (pci_bus_trylock(bus)) {
> > +               pci_info(bus->self, "%s: pci_bus_trylock() returns
> > true\n", __func__);
> >                 pci_bus_save_and_disable_locked(bus);
> >                 might_sleep();
> >                 rc =3D pci_bridge_secondary_bus_reset(bus->self);
> > @@ -5881,6 +5896,7 @@ static int __pci_reset_bus(struct pci_bus *bus)
> >   */
> >  int pci_reset_bus(struct pci_dev *pdev)
> >  {
> > +       pci_info(pdev, "%s: %s", __func__,
> > !pci_probe_reset_slot(pdev->slot) ? "true" : "false");
> >         return (!pci_probe_reset_slot(pdev->slot)) ?
> >             __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
> >  }
> >
> > And, have the information of VMD PCIe devices with the built kernel:
> >
> > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core
> > Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal
> > decode])
> >   ...
> >   Capabilities: [200 v1] L1 PM Substates
> >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Sub=
states+
> >       PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
> >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >       T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >     L1SubCtl2: T_PwrOn=3D0us
> >
> > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD
> > Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> >   ...
> >   Capabilities: [900 v1] L1 PM Substates
> >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Sub=
states+
> >       PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
> >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >       T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> >     L1SubCtl2: T_PwrOn=3D50us
> >
> > We can see the NVMe has expected LTR1.2_Threshold=3D101376ns, but the
> > PCIe bridge has LTR1.2_Threshold=3D0ns.
>
> This is now the other way around as in the original posting that had
> 0ns for 10000:e1:00.0 ??
>
> Is this behavior even consistent or did you e.g. mess up some copy
> pasting somewhere?

The original posting came with older kernel 6.5. It shows:

10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core
Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal
decode])
...
  Capabilities: [200 v1] L1 PM Substates
    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substat=
es+
      PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
    L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
      T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
    L1SubCtl2: T_PwrOn=3D50us
...

10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD
Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
...
  Capabilities: [900 v1] L1 PM Substates
    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substat=
es+
      PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
    L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
      T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
    L1SubCtl2: T_PwrOn=3D10us
...

Full information:
https://gist.github.com/starnight/e19487a44efefff477f9ac9ed641c183

But, newer kernel, for example linux-next next-20240809 and
next-20240820 which I have tried shows:

10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core
Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal
decode])
...
  Capabilities: [200 v1] L1 PM Substates
    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substat=
es+
      PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
    L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
      T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
    L1SubCtl2: T_PwrOn=3D0us
...

10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD
Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
...
  Capabilities: [900 v1] L1 PM Substates
    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substat=
es+
      PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
    L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
      T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
    L1SubCtl2: T_PwrOn=3D50us
...

Full information:
https://gist.github.com/starnight/081ea4adbce40a27faf234e5e135b49a

So, according to the information above, different kernel versions show
different L1 sub-states.

Jian-Hong Pan

