Return-Path: <linux-pci+bounces-12715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7F496AF96
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 05:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E306280EF0
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 03:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62C757CA7;
	Wed,  4 Sep 2024 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="TqwXXuKt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5194C33D5
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 03:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725422223; cv=none; b=GhMcitvUZXsq9vPdgCmDpY+pGi0Pyy4UI7j4btyHoCXv/LJlXeWWSQ6WDFTdGgSUx0C6CMZZT4F07drfg/u+qYWLMf559oqVXyBmNfkwYqCmTHTDm9gwhnN6wziadgmUNK6kw677Lh2PPjzkFvAYm5l9dP0XwvvXD1fjojPVO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725422223; c=relaxed/simple;
	bh=GQrGpaQ0uhcwRbQ9gF/glyqASk9gXyZ51QYYNiCm+bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFbhnws+/WKjEu5ZurmuFVvwb0u8pEOSZg1bM/eeIltYdPfoBRjttWRhBdnowj1MZm3sPBtVEIqt5ei3DMNYT1Ws4+n3A+DOCWHH1ITeoglcx47YXu8WwzIB2hxAxfcVZ6T6uXwDRqhXimRcxHEwo5r60TP/Ob/rtGDXtQ7opvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=TqwXXuKt; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e1ce8a675f7so2477553276.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2024 20:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1725422220; x=1726027020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVv3Wj3ZGR6bYClXy+Z0RIGbotqk+lCcqfyX+Qn2Woo=;
        b=TqwXXuKt3N7e169UO9iwun3vVw4UOuIABVdaYVi7drrXr862xQdp3LosWcXxaCx/s5
         9Tt8owTm9JCnI15wiBmx9GLYNC+rw3+RMB0/2OeRlcXlyf0K5XucfYB2tjzrXs8RCJoy
         4y2n0EpbkVejsQnQLI10zfZihUMbqqd3pSHE9yRgLVJH1KwU/m6MeAJjI5gxsngjPTCB
         e8chjqrFRkZARo0SXGdi65pvrOf0wC7v6VKFkQmQ0kyNXgcn0NIqQpRKV+ZURjuA0iD/
         f6GIqD3OJ8VG5FDIGGxP8ap+vpr+d/WAmm5WMYisIL7+sBvflAF8AyoipyZ2YrKYN89H
         WEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725422220; x=1726027020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVv3Wj3ZGR6bYClXy+Z0RIGbotqk+lCcqfyX+Qn2Woo=;
        b=dP+EDjmkEmLZSUl4hxoc6v95HLkcH4nDn3vDwYwggQtEy++4pIzZ2ZDRMgGneilddn
         LdVeKtiwNr5E0y0KO2lGj3CnJF+H0fJYtVXXO6dZnDQsJCbL5PTVoTjYPwtc74KHckRY
         6pKAmVewH0b4HtUVsc76PG9SuevJdcUYxjrQRmBdjramq01MnrwyWQsg1E7sopfXdC2x
         vO1R/ZfE+YFufkO2MJaHvVQZLRiPU2YZ8+eOf3ynzniHe/yfqmMUc7tCE8qGUGcCAQci
         ILCkSxaxnLJn5YWBV88WU7mmgxovjAjG5CkJNQMIxtt+7M3F3T0BTyaVIpFgInI0yetv
         Rtvg==
X-Forwarded-Encrypted: i=1; AJvYcCWP7dxCETgF5YsyLkmZVaR0utzBLtXXBkaoFRMbZcZwf1Tzxw98jGFXMLgsiXO/syX5XK7g6VWYVm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxscylIF3TFs4Ff04pTnCa5YMoDLixmsFKwmCHCIzVO6UuQjzCP
	lMkN75NT8HFAIHNFONN72Whhu/62c/WyovEFckpU0eGyCqaUQUhi6K2VKPX1yRn1AzNmfEUr4Qa
	Pib+rfJi0Wec69YSAIecHr8MDDpF/r1tb94Tx2B+Ln25VmlSfC5M=
X-Google-Smtp-Source: AGHT+IHlh83siOzs9LzVlou7Mi5KLH2GTaon3Y0hMjy1XLQnRCZr46FtBA9rzwxvTB8un9xUcbePsRSkuigPSy82y5U=
X-Received: by 2002:a05:6902:2b06:b0:e1a:70d1:18a4 with SMTP id
 3f1490d57ef6-e1a79fb593bmr16675383276.3.1725422219763; Tue, 03 Sep 2024
 20:56:59 -0700 (PDT)
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
 <20240903081705.00001334@linux.intel.com>
In-Reply-To: <20240903081705.00001334@linux.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 4 Sep 2024 11:56:23 +0800
Message-ID: <CAPpJ_edZmmoWHFrT8XMLmtTPuFEgNXkEQ1OJdLOVnf38uGfO=A@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] PCI/ASPM: Fix L1.2 parameters when enable link state
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Johan Hovold <johan@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, 
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, linux-pci@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nirmal Patel <nirmal.patel@linux.intel.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=
=883=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:17=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Mon, 12 Aug 2024 16:18:22 +0800
> Jian-Hong Pan <jhp@endlessos.org> wrote:
>
> > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E6=96=BC 2024=E5=B9=
=B48=E6=9C=888=E6=97=A5 =E9=80=B1=E5=9B=9B
> > =E4=B8=8B=E5=8D=885:49=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Wed, 7 Aug 2024, David E. Box wrote:
> > >
> > > > On Wed, 2024-08-07 at 14:18 +0300, Ilpo J=C3=A4rvinen wrote:
> > > > > On Wed, 7 Aug 2024, Jian-Hong Pan wrote:
> > > > >
> > > > > > David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=
=B48=E6=9C=886=E6=97=A5
> > > > > > =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=884:26=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > > > >
> > > > > > > Hi Jian-Hong,
> > > > > > >
> > > > > > > On Fri, 2024-08-02 at 16:24 +0800, Jian-Hong Pan wrote:
> > > > > > > > Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2024=E5=B9=B47=
=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=94
> > > > > > > > =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > Currently, when enable link's L1.2 features with
> > > > > > > > > __pci_enable_link_state(),
> > > > > > > > > it configs the link directly without ensuring related
> > > > > > > > > L1.2 parameters, such
> > > > > > > > > as T_POWER_ON, Common_Mode_Restore_Time, and
> > > > > > > > > LTR_L1.2_THRESHOLD have been
> > > > > > > > > programmed.
> > > > > > > > >
> > > > > > > > > This leads the link's L1.2 between PCIe Root Port and
> > > > > > > > > child device gets
> > > > > > > > > wrong configs when a caller tries to enabled it.
> > > > > > > > >
> > > > > > > > > Here is a failed example on ASUS B1400CEAE with enabled
> > > > > > > > > VMD:
> > > > > > > > >
> > > > > > > > > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen
> > > > > > > > > Core Processor PCIe
> > > > > > > > > Controller (rev 01) (prog-if 00 [Normal decode])
> > > > > > > > >     ...
> > > > > > > > >     Capabilities: [200 v1] L1 PM Substates
> > > > > > > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> > > > > > > > > ASPM_L1.1+ L1_PM_Substates+
> > > > > > > > >                   PortCommonModeRestoreTime=3D45us
> > > > > > > > > PortTPowerOnTime=3D50us L1SubCtl1: PCI-PM_L1.2-
> > > > > > > > > PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- T_CommonMode=3D45us
> > > > > > > > > LTR1.2_Threshold=3D101376ns L1SubCtl2: T_PwrOn=3D50us
> > > > > > > > >
> > > > > > > > > 10000:e1:00.0 Non-Volatile memory controller: Sandisk
> > > > > > > > > Corp WD Blue SN550
> > > > > > > > > NVMe SSD (rev 01) (prog-if 02 [NVM Express])
> > > > > > > > >     ...
> > > > > > > > >     Capabilities: [900 v1] L1 PM Substates
> > > > > > > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+
> > > > > > > > > ASPM_L1.1- L1_PM_Substates+
> > > > > > > > >                   PortCommonModeRestoreTime=3D32us
> > > > > > > > > PortTPowerOnTime=3D10us L1SubCtl1: PCI-PM_L1.2-
> > > > > > > > > PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- T_CommonMode=3D0us
> > > > > > > > > LTR1.2_Threshold=3D0ns L1SubCtl2: T_PwrOn=3D10us
> > > > > > > > >
> > > > > > > > > According to "PCIe r6.0, sec 5.5.4", before enabling
> > > > > > > > > ASPM L1.2 on the PCIe
> > > > > > > > > Root Port and the child NVMe, they should be programmed
> > > > > > > > > with the same LTR1.2_Threshold value. However, they
> > > > > > > > > have different values in this case.
> > > > > > > > >
> > > > > > > > > Invoke aspm_calc_l12_info() to program the L1.2
> > > > > > > > > parameters properly before
> > > > > > > > > enable L1.2 bits of L1 PM Substates Control Register in
> > > > > > > > > __pci_enable_link_state().
> > > > > > > > >
> > > > > > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D21839=
4
> > > > > > > > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > > > > > > > ---
> > > > > > > > > v2:
> > > > > > > > > - Prepare the PCIe LTR parameters before enable L1
> > > > > > > > > Substates
> > > > > > > > >
> > > > > > > > > v3:
> > > > > > > > > - Only enable supported features for the L1 Substates
> > > > > > > > > part
> > > > > > > > >
> > > > > > > > > v4:
> > > > > > > > > - Focus on fixing L1.2 parameters, instead of
> > > > > > > > > re-initializing whole L1SS
> > > > > > > > >
> > > > > > > > > v5:
> > > > > > > > > - Fix typo and commit message
> > > > > > > > > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM:
> > > > > > > > > Introduce aspm_get_l1ss_cap()"
> > > > > > > > >
> > > > > > > > > v6:
> > > > > > > > > - Skipped
> > > > > > > > >
> > > > > > > > > v7:
> > > > > > > > > - Pick back and rebase on the new version kernel
> > > > > > > > > - Drop the link state flag check. And, always config
> > > > > > > > > link state's timing
> > > > > > > > >   parameters
> > > > > > > > >
> > > > > > > > > v8:
> > > > > > > > > - Because pcie_aspm_get_link() might return the link as
> > > > > > > > > NULL, move getting the link's parent and child devices
> > > > > > > > > after check the link is not NULL. This avoids NULL
> > > > > > > > > memory access.
> > > > > > > > >
> > > > > > > > >  drivers/pci/pcie/aspm.c | 15 +++++++++++++++
> > > > > > > > >  1 file changed, 15 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/pci/pcie/aspm.c
> > > > > > > > > b/drivers/pci/pcie/aspm.c index
> > > > > > > > > 5db1044c9895..55ff1d26fcea 100644 ---
> > > > > > > > > a/drivers/pci/pcie/aspm.c +++ b/drivers/pci/pcie/aspm.c
> > > > > > > > > @@ -1411,9 +1411,15 @@
> > > > > > > > > EXPORT_SYMBOL(pci_disable_link_state); static int
> > > > > > > > > __pci_enable_link_state(struct pci_dev *pdev, int
> > > > > > > > > state, bool locked)
> > > > > > > > >  {
> > > > > > > > >         struct pcie_link_state *link =3D
> > > > > > > > > pcie_aspm_get_link(pdev);
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
> > > > > > > > >          * A driver requested that ASPM be enabled on
> > > > > > > > > this device, but
> > > > > > > > >          * if we don't have permission to manage ASPM
> > > > > > > > > (e.g., on ACPI @@ -1428,6 +1434,15 @@ static int
> > > > > > > > > __pci_enable_link_state(struct pci_dev
> > > > > > > > > *pdev, int state, bool locked)
> > > > > > > > >         if (!locked)
> > > > > > > > >                 down_read(&pci_bus_sem);
> > > > > > > > >         mutex_lock(&aspm_lock);
> > > > > > > > > +       /*
> > > > > > > > > +        * Ensure L1.2 parameters:
> > > > > > > > > Common_Mode_Restore_Times, T_POWER_ON and
> > > > > > > > > +        * LTR_L1.2_THRESHOLD are programmed properly
> > > > > > > > > before enable bits for
> > > > > > > > > +        * L1.2, per PCIe r6.0, sec 5.5.4.
> > > > > > > > > +        */
> > > > > > > > > +       parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> > > > > > > > > +       child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> > > > > > > > > +       aspm_calc_l12_info(link, parent_l1ss_cap,
> > > > > > > > > child_l1ss_cap);
> > > > > > >
> > > > > > > I still don't think this is the place to recalculate the
> > > > > > > L1.2 parameters especially when know the calculation was
> > > > > > > done but was cleared by pci_bus_reset(). Can't we just do a
> > > > > > > pci_save/restore_state() before/after pci_bus_reset() in
> > > > > > > vmd.c?
> > > > > >
> > > > > > I have not thought pci_save/restore_state() around
> > > > > > pci_bus_reset() before.  It is an interesting direction.
> > > > > >
> > > > > > So, I prepare modification below for test.  Include "[PATCH
> > > > > > v8 1/4] PCI: vmd: Set PCI devices to D0 before enable PCI
> > > > > > PM's L1 substates", too.  Then, both the PCIe bridge and the
> > > > > > PCIe device have the same LTR_L1.2_THRESHOLD 101376ns as
> > > > > > expected.
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/vmd.c
> > > > > > b/drivers/pci/controller/vmd.c index
> > > > > > bbf4a47e7b31..6b8dd4f30127 100644 ---
> > > > > > a/drivers/pci/controller/vmd.c +++
> > > > > > b/drivers/pci/controller/vmd.c @@ -727,6 +727,18 @@ static
> > > > > > void vmd_copy_host_bridge_flags(struct pci_host_bridge
> > > > > > *root_bridge, vmd_bridge->native_dpc =3D
> > > > > > root_bridge->native_dpc; }
> > > > > >
> > > > > > +static int vmd_pci_save_state(struct pci_dev *pdev, void
> > > > > > *userdata) +{
> > > > > > +       pci_save_state(pdev);
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int vmd_pci_restore_state(struct pci_dev *pdev, void
> > > > > > *userdata) +{
> > > > > > +       pci_restore_state(pdev);
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > >  /*
> > > > > >   * Enable ASPM and LTR settings on devices that aren't
> > > > > > configured by BIOS. */
> > > > > > @@ -927,6 +939,7 @@ static int vmd_enable_domain(struct
> > > > > > vmd_dev *vmd, unsigned long features)
> > > > > >         pci_scan_child_bus(vmd->bus);
> > > > > >         vmd_domain_reset(vmd);
> > > > > >
> > > > > > +       pci_walk_bus(vmd->bus, vmd_pci_save_state, NULL);
> > > > > >         /* When Intel VMD is enabled, the OS does not
> > > > > > discover the Root Ports
> > > > > >          * owned by Intel VMD within the MMCFG space.
> > > > > > pci_reset_bus() applies
> > > > > >          * a reset to the parent of the PCI device supplied
> > > > > > as argument. This
> > > > > > @@ -945,6 +958,7 @@ static int vmd_enable_domain(struct
> > > > > > vmd_dev *vmd, unsigned long features)
> > > > > >                         break;
> > > > > >                 }
> > > > > >         }
> > > > > > +       pci_walk_bus(vmd->bus, vmd_pci_restore_state, NULL);
> > > > >
> > > > > Why not call pci_reset_bus() (or __pci_reset_bus()) then in
> > > > > vmd_enable_domain() which preserves state unlike
> > > > > pci_reset_bus()?
> > > > >
> > > > > (Don't tell me naming of these functions is a horrible mess.
> > > > > :-/)
> > > >
> > > > Hmm. So this *is* calling pci_reset_bus().
> > >
> > > Yeah, I managed to get confused by the names myself, I somehow
> > > ended up thinking it calls pci_bus_reset() which is not correct...
> > >
> > > > L1.2 configuration has specific
> > > > ordering requirements for changes to parent & child devices.
> > > > Could be why it's not getting restored properly.
> > >
> > > Indeed, it has to be something else since the patch above doesn't
> > > even restore anything because dev->state_saved should get set to
> > > false by the first pci_restore_state() called from
> > > __pci_reset_bus() -> pci_bus_restore_locked() -> pci_dev_restore(),
> > > I think!?
> >
> > Inspired by Ilpo's comment.  I add some debug messages based on
> > linux-next's tag 'next-20240809' to understand the code path of
> > pci_reset_bus():
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index ffaaca0978cb..3ee71374f1de 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5133,8 +5133,10 @@ static void pci_dev_save_and_disable(struct
> > pci_dev *dev)
> >          * races with ->remove() by the device lock, which must be
> > held by
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
> >          * Wake-up device prior to save.  PM registers default to D0
> > after @@ -5144,6 +5146,7 @@ static void
> > pci_dev_save_and_disable(struct pci_dev *dev)
> > pci_set_power_state(dev, PCI_D0);
> >
> >         pci_save_state(dev);
> > +       pci_info(dev, "%s: PCI state_saved is %s\n", __func__,
> > dev->state_saved ? "true" : "false");
> >         /*
> >          * Disable the device by clearing the Command register,
> > except for
> >          * INTx-disable which is set.  This not only disables MMIO
> > and I/O port @@ -5655,6 +5658,10 @@ static void
> > pci_bus_save_and_disable_locked(struct pci_bus *bus)
> >         struct pci_dev *dev;
> >
> >         list_for_each_entry(dev, &bus->devices, bus_list) {
> > +               pci_info(dev, "%s: PCI state_saved is %s, and %s
> > subordinate\n",
> > +                        __func__,
> > +                        dev->state_saved ? "true" : "false",
> > +                        dev->subordinate ? "has" : "does not have");
> >                 pci_dev_save_and_disable(dev);
> >                 if (dev->subordinate)
> >                         pci_bus_save_and_disable_locked(dev->subordinat=
e);
> > @@ -5671,6 +5678,10 @@ static void pci_bus_restore_locked(struct
> > pci_bus *bus) struct pci_dev *dev;
> >
> >         list_for_each_entry(dev, &bus->devices, bus_list) {
> > +               pci_info(dev, "%s: PCI state_saved is %s, and %s
> > subordinate\n",
> > +                        __func__,
> > +                        dev->state_saved ? "true" : "false",
> > +                        dev->subordinate ? "has" : "does not have");
> >                 pci_dev_restore(dev);
> >                 if (dev->subordinate)
> >                         pci_bus_restore_locked(dev->subordinate);
> > @@ -5786,8 +5797,10 @@ static int pci_bus_reset(struct pci_bus *bus,
> > bool probe) if (!bus->self || !pci_bus_resettable(bus))
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
> > @@ -5858,10 +5871,12 @@ static int __pci_reset_bus(struct pci_bus
> > *bus) int rc;
> >
> >         rc =3D pci_bus_reset(bus, PCI_RESET_PROBE);
> > +       pci_info(bus->self, "%s: pci_bus_reset() returns %d\n",
> > __func__, rc); if (rc)
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
> >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > L1_PM_Substates+ PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50=
us
> >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >       T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >     L1SubCtl2: T_PwrOn=3D0us
> >
> > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD
> > Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> >   ...
> >   Capabilities: [900 v1] L1 PM Substates
> >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > L1_PM_Substates+ PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10=
us
> >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >       T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> >     L1SubCtl2: T_PwrOn=3D50us
> >
> > We can see the NVMe has expected LTR1.2_Threshold=3D101376ns, but the
> > PCIe bridge has LTR1.2_Threshold=3D0ns.
> >
> > Then, check the dmesg.  I notice the debug messages:
> >
> > pci 10000:e0:06.0: PCI bridge to [bus e1]
> > pci 10000:e0:06.0: Primary bus is hard wired to 0
> > pci 10000:e1:00.0: pci_reset_bus: false
> > pci 10000:e0:06.0: pci_bus_reset: probe is true.  So return 0 directly
> > pci 10000:e0:06.0: __pci_reset_bus: pci_bus_reset() returns 0
> > pci 10000:e0:06.0: __pci_reset_bus: pci_bus_trylock() returns true
> > pci 10000:e1:00.0: pci_bus_save_and_disable_locked: PCI state_saved is
> > false, and does not have subordinate
> > pci 10000:e1:00.0: pci_dev_save_and_disable: PCI state_saved is true
> > Freeing initrd memory: 75236K
> > pci 10000:e1:00.0: pci_bus_restore_locked: PCI state_saved is true,
> > and does not have subordinate
> >
> > So, the code path is:
> >
> > vmd_enable_domain()
> >   pci_reset_bus()
> >     __pci_reset_bus()
> >       pci_bus_reset()
> >         pci_bus_save_and_disable_locked()
> >           pci_dev_save_and_disable()
> >         pci_bus_restore_locked()
> >           pci_dev_restore()
> >
> > And, from the debug messages, I learned only NVMe 10000:e1:00.0 does
> > pci_save/restore_state.  But, the PCIe bridge 10000:e0:06.0 does not.
> > So, PCIe bridge 10000:e0:06.0 does not restore state correctly.
> >
> > Besides, it is NVMe 10000:e1:00.0's bus [e1] been reset, not the VMD's
> > bus in vmd_enable_domain().
> > * Bus "e1" has only NVMe 10000:e1:00.0
> > * VMD's bus in vmd_enable_domain() has PCIe bridge 10000:e0:06.0, NVMe
> > 10000:e1:00.0 and SATA Controller 10000:e0:17.0.
> >
> > Here is the PCI tree:
> >
> > -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
> >  |           +-02.0  Intel Corporation Tiger Lake-LP GT2 [UHD
> > Graphics G4] |           +-04.0  Intel Corporation TigerLake-LP
> > Dynamic Tuning Processor Participant
> >  |           +-06.0  Intel Corporation RST VMD Managed Controller
> >  |           +-07.0-[01-2b]--
> >  |           +-08.0  Intel Corporation GNA Scoring Accelerator module
> >  |           +-0a.0  Intel Corporation Tigerlake Telemetry Aggregator
> > Driver |           +-0d.0  Intel Corporation Tiger Lake-LP
> > Thunderbolt 4 USB Controller
> >  |           +-0d.2  Intel Corporation Tiger Lake-LP Thunderbolt 4
> > NHI #0 |           +-0e.0  Intel Corporation Volume Management Device
> > NVMe RAID Controller
> >  |           +-14.0  Intel Corporation Tiger Lake-LP USB 3.2 Gen 2x1
> > xHCI Host Controller
> >  |           +-14.2  Intel Corporation Tiger Lake-LP Shared SRAM
> >  |           +-14.3  Intel Corporation Wi-Fi 6 AX201
> >  |           +-15.0  Intel Corporation Tiger Lake-LP Serial IO I2C
> > Controller #0 |           +-15.1  Intel Corporation Tiger Lake-LP
> > Serial IO I2C Controller #1 |           +-16.0  Intel Corporation
> > Tiger Lake-LP Management Engine Interface |           +-17.0  Intel
> > Corporation RST VMD Managed Controller |           +-1f.0  Intel
> > Corporation Tiger Lake-LP LPC Controller |           +-1f.3  Intel
> > Corporation Tiger Lake-LP Smart Sound Technology Audio Controller
> >  |           +-1f.4  Intel Corporation Tiger Lake-LP SMBus Controller
> >  |           +-1f.5  Intel Corporation Tiger Lake-LP SPI Controller
> >  |           \-1f.6  Intel Corporation Ethernet Connection (13) I219-V
> >  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
> >               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
> >
> > According the findings above, to ensure the devices on the VMD bus
> > have correctly states, seems pci_save_state() all the devices before
> > pci_reset_bus(), and pci_restore_state() all the devices after
> > pci_reset_bus() is the correct answer.
> What happens if you call pci_reset_bus with PCIe bridge 10000:e0:06.0
> instead of NVMe 10000:e1:00.0? I believe the current implementation in
> vmd_enable_domain finds first child device on each rootport and calls
> pci_reset_bus with NVMe.

If call pci_reset_bus with PCIe bridge 10000:e0:06.0 instead of NVMe
10000:e1:00.0, it will show warning message "pci 10000:e0:06.0 can't
reset device: -25".

Jian-Hong Pan

