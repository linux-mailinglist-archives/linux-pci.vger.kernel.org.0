Return-Path: <linux-pci+bounces-11329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A07B948188
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 20:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B30E1C21DF5
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 18:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC782149DFC;
	Mon,  5 Aug 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YG8HAlZg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B1620;
	Mon,  5 Aug 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882302; cv=none; b=nRher+V7dcUwqg86JW6WeUFrlrLNGYLLdsQtsKz3N8Fyx4bM9nW1cHarONAcgxIUM2Yy1pc2TsENOE+oaAJy8lbbc3t24Gsjy1F91NqX2D+9hVJ/1aSGBtOWDNhcfTJ5n9XqOoO0zwgAkBvDSbZcfqLbrGvvk79JztVdrBJCwO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882302; c=relaxed/simple;
	bh=FXzVqenhzpdtHOcXatACMscpU64GG8a2FW3cWjhPU4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tecnlUwcsrcGjsjaE4QOMJWGqzPU88+U+w6TAHMHK61/9bwhAfhPYCW8HPHBAGlAfrkXk8/1JA+3P2l3392ygXvszpBL8gN+DBAxOFUw1DhxKalq57ymkWYI7yc5DMquAwyqNrUj95/61Uag3WBfFJtrJH3NPFQfpbzER4akb5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YG8HAlZg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722882301; x=1754418301;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FXzVqenhzpdtHOcXatACMscpU64GG8a2FW3cWjhPU4c=;
  b=YG8HAlZgxD/JjywpnJ7escHKts16euzYha0KbxseRvMQO7/6TZsp3Lmx
   jIrOs6wNX4vjtGav+hD1Qg/5wr5Ihf0ndPhd1EnuvHezwMIrevkeBgulk
   gnXUdbYYZ6n57p8aWmDcKPzWI34LllisMGAwL/nJP/s2YZ9iGCZvnAkiG
   4I80dUf6rxbhiArUiQAOYEk1n26VRNRUcfr7viNa8DNH5eYCO0hiopj3X
   KYa1uA8xBHsCMYB9D2+GERI16QOPhdBYViR2MP5nkheYn1ciXHI8CynjC
   q8NLWJeNo8Ye+VTJEfpHD9o3VBzxM01LMS6+x0eNShgPGwYvcaHv03JlP
   Q==;
X-CSE-ConnectionGUID: Ds9TdhGpRVSc3IgUhVMDyw==
X-CSE-MsgGUID: jtsJU53QT8iSvfzo0+SUnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="38319719"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="38319719"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 11:25:00 -0700
X-CSE-ConnectionGUID: FsfLEgeoSMuZCBEOpjAveA==
X-CSE-MsgGUID: 3n4634pQTdWQm1wruZFtJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="60394620"
Received: from unknown (HELO localhost) ([10.2.132.131])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 11:24:57 -0700
Date: Mon, 5 Aug 2024 11:24:56 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>,
 David Box <david.e.box@linux.intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>,
 Jonathan Derrick <jonathan.derrick@linux.dev>, Paul M Stillwell Jr
 <paul.m.stillwell.jr@intel.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@endlessos.org
Subject: Re: [PATCH v8 4/4] PCI/ASPM: Fix L1.2 parameters when enable link
 state
Message-ID: <20240805112456.00007cad@linux.intel.com>
In-Reply-To: <CAPpJ_edybLMtrN_gxP2h9Z-BuYH+RG-qRqMqgZM1oSVoW1sP5A@mail.gmail.com>
References: <20240719075200.10717-2-jhp@endlessos.org>
	<20240719080255.10998-2-jhp@endlessos.org>
	<CAPpJ_edybLMtrN_gxP2h9Z-BuYH+RG-qRqMqgZM1oSVoW1sP5A@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Aug 2024 16:24:18 +0800
Jian-Hong Pan <jhp@endlessos.org> wrote:

> Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2024=E5=B9=B47=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Currently, when enable link's L1.2 features with
> > __pci_enable_link_state(), it configs the link directly without
> > ensuring related L1.2 parameters, such as T_POWER_ON,
> > Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD have been
> > programmed.
> >
> > This leads the link's L1.2 between PCIe Root Port and child device
> > gets wrong configs when a caller tries to enabled it.
> >
> > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> >
> > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor
> > PCIe Controller (rev 01) (prog-if 00 [Normal decode]) ...
> >     Capabilities: [200 v1] L1 PM Substates
> >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > L1_PM_Substates+ PortCommonModeRestoreTime=3D45us
> > PortTPowerOnTime=3D50us L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1-
> > ASPM_L1.2+ ASPM_L1.1- T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> >         L1SubCtl2: T_PwrOn=3D50us
> >
> > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue
> > SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express]) ...
> >     Capabilities: [900 v1] L1 PM Substates
> >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > L1_PM_Substates+ PortCommonModeRestoreTime=3D32us
> > PortTPowerOnTime=3D10us L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1-
> > ASPM_L1.2+ ASPM_L1.1- T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >         L1SubCtl2: T_PwrOn=3D10us
> >
> > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on
> > the PCIe Root Port and the child NVMe, they should be programmed
> > with the same LTR1.2_Threshold value. However, they have different
> > values in this case.
> >
> > Invoke aspm_calc_l12_info() to program the L1.2 parameters properly
> > before enable L1.2 bits of L1 PM Substates Control Register in
> > __pci_enable_link_state().
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> > v2:
> > - Prepare the PCIe LTR parameters before enable L1 Substates
> >
> > v3:
> > - Only enable supported features for the L1 Substates part
> >
> > v4:
> > - Focus on fixing L1.2 parameters, instead of re-initializing whole
> > L1SS
> >
> > v5:
> > - Fix typo and commit message
> > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
> >   aspm_get_l1ss_cap()"
> >
> > v6:
> > - Skipped
> >
> > v7:
> > - Pick back and rebase on the new version kernel
> > - Drop the link state flag check. And, always config link state's
> > timing parameters
> >
> > v8:
> > - Because pcie_aspm_get_link() might return the link as NULL, move
> >   getting the link's parent and child devices after check the link
> > is not NULL. This avoids NULL memory access.
> >
> >  drivers/pci/pcie/aspm.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 5db1044c9895..55ff1d26fcea 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1411,9 +1411,15 @@ EXPORT_SYMBOL(pci_disable_link_state);
> >  static int __pci_enable_link_state(struct pci_dev *pdev, int
> > state, bool locked) {
> >         struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> > +       u32 parent_l1ss_cap, child_l1ss_cap;
> > +       struct pci_dev *parent, *child;
> >
> >         if (!link)
> >                 return -EINVAL;
> > +
> > +       parent =3D link->pdev;
> > +       child =3D link->downstream;
> > +
> >         /*
> >          * A driver requested that ASPM be enabled on this device,
> > but
> >          * if we don't have permission to manage ASPM (e.g., on ACPI
> > @@ -1428,6 +1434,15 @@ static int __pci_enable_link_state(struct
> > pci_dev *pdev, int state, bool locked) if (!locked)
> >                 down_read(&pci_bus_sem);
> >         mutex_lock(&aspm_lock);
> > +       /*
> > +        * Ensure L1.2 parameters: Common_Mode_Restore_Times,
> > T_POWER_ON and
> > +        * LTR_L1.2_THRESHOLD are programmed properly before enable
> > bits for
> > +        * L1.2, per PCIe r6.0, sec 5.5.4.
> > +        */
> > +       parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> > +       child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> > +       aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
> > +
> >         link->aspm_default =3D pci_calc_aspm_enable_mask(state);
> >         pcie_config_aspm_link(link, policy_to_aspm_state(link));
> >
> > --
> > 2.45.2
> > =20
>=20
> Hi Nirmal and Paul,
>=20
> It will be great to have your review here.
>=20
> I had tried to "set the threshold value in vmd_pm_enable_quirk()"
> directly as Paul said [1].  However, it still needs to get the PCIe
> link from the PCIe device to set the threshold value.
> And, pci_enable_link_state_locked() gets the link. Then, it will be
> great to calculate and programm L1 sub-states' parameters properly
> before configuring the link's ASPM there.
>=20
> [1]:
> https://lore.kernel.org/linux-kernel/20240624081108.10143-2-jhp@endlessos=
.org/T/#mc467498213fe1a6116985c04d714dae378976124
>=20
> Jian-Hong Pan

Hi Jian-Hong Pan,

I am not an LTR, ASPM expert, but this part looks good to me.

Can you explain why you decided to move pci_enable_link_state_locked()
call down to out_state_change in vmd.c? Will it cause any issue if=20
pci_find_ext_capability returns 0?

Thanks
-nirmal

