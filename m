Return-Path: <linux-pci+bounces-9251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E63917134
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 21:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F341C225E7
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 19:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4825517C7CD;
	Tue, 25 Jun 2024 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdyRNAse"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DDD143882;
	Tue, 25 Jun 2024 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719344572; cv=none; b=PB8kvyy2Wae9Bn3Wk8HezoMyjHYjbuElL3HGoFPrErhbKWVYYl5LJjlpDG+UJEm+a47wZBoljbQ6iozxio4OfihWHGhNiW/yWPWVfm2JY/GV34rrdhxD6aqEUZHtU7pJgbuZ9zafXt3TWIAwppfbbHR4cQd3kXnkOxSSSd5V/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719344572; c=relaxed/simple;
	bh=DveFdF9nepyczNRTYDxbBM/91PZjFxumtLrhvZS3Rb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6tBuWiv3NkMWPyGgtr8xmqzMQij+yOASv8Effs3HD7GrMazQ/mP6r4egdQVxHwGvTLvyLdMCcUOqtFHXazcxEdoyr/kR0HK7R5dtncNPzr6paXb4qlG12er6u/sRsKnJmbtZVsIKedJXC074jjX+iQ/HLvlg2Qh7wpu2i37PMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdyRNAse; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719344570; x=1750880570;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DveFdF9nepyczNRTYDxbBM/91PZjFxumtLrhvZS3Rb8=;
  b=CdyRNAseX3LZ0/2l17tAseVDFXH3EdX0lDhKe7VmMRNA1CmOG4cYtTsd
   NgjeGVp+iBwDdqFhcx6EayHVdt6Q3bZuD03zu/0o3hklxn+ay2inv973m
   m/4/8mYsD3ky5XNGm1wAGRrkVmxB6ueSQ15VaNwZl0EYZlewEXPSma5UM
   2vio3H8jt709OSJ51+r26r4oreCPO/Hr9+KkKbbaAbyOxtNnBEMIs8kcg
   J0ynxtPw55zlhRIDQSWXEC/8WlJnLa3pMawlBnD0S4+5mNgm8bYD1OsXH
   yVduUKjpN+kMu+sDLJL5xQcw4806jy5kTSPViOpBnqbeKwrlomJyISrnC
   A==;
X-CSE-ConnectionGUID: TsGecSbMRNm+ZxTbQnSsnw==
X-CSE-MsgGUID: gyzhE1H+RCKDCia9NqL6Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16530882"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16530882"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 12:42:49 -0700
X-CSE-ConnectionGUID: SmrJ7SUURpmPgnPi2JhHiw==
X-CSE-MsgGUID: VhUpg8VnQSKZHobbHXpbzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43569031"
Received: from patelni-mobl1.amr.corp.intel.com (HELO localhost) ([10.124.97.190])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 12:42:48 -0700
Date: Tue, 25 Jun 2024 12:42:47 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Francisco Munoz
 <francisco.munoz.ruiz@linux.intel.com>, Johan Hovold <johan@kernel.org>,
 David Box <david.e.box@linux.intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>,
 Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@endlessos.org, Paul M Stillwell Jr
 <paul.m.stillwell.jr@intel.com>
Subject: Re: [PATCH v6 3/3] PCI: vmd: Drop resetting PCI bus action after
 scan mapped PCI child bus
Message-ID: <20240625124247.00001768@linux.intel.com>
In-Reply-To: <CAPpJ_ee5e-wwOGJ9z+AaXbpDUkN_zZt3Q_BLcZTztW8aHcPSfg@mail.gmail.com>
References: <20240624081108.10143-2-jhp@endlessos.org>
	<20240624082144.10265-2-jhp@endlessos.org>
	<20240624082458.00006da1@linux.intel.com>
	<CAPpJ_ee5e-wwOGJ9z+AaXbpDUkN_zZt3Q_BLcZTztW8aHcPSfg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jun 2024 17:52:55 +0800
Jian-Hong Pan <jhp@endlessos.org> wrote:

> Nirmal Patel <nirmal.patel@linux.intel.com> =E6=96=BC 2024=E5=B9=B46=E6=
=9C=8824=E6=97=A5 =E9=80=B1=E4=B8=80
> =E4=B8=8B=E5=8D=8811:25=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Mon, 24 Jun 2024 16:21:45 +0800
> > Jian-Hong Pan <jhp@endlessos.org> wrote:
> > =20
> > > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on
> > > the PCIe Root Port and the child device, they should be
> > > programmed with the same LTR1.2_Threshold value. However, they
> > > have different values on VMD mapped PCI child bus. For example,
> > > Asus B1400CEAE's VMD mapped PCI bridge and NVMe SSD controller
> > > have different LTR1.2_Threshold values:
> > >
> > > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core
> > > Processor PCIe Controller (rev 01) (prog-if 00 [Normal decode])
> > > ... Capabilities: [200 v1] L1 PM Substates
> > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > > L1_PM_Substates+ PortCommonModeRestoreTime=3D45us
> > > PortTPowerOnTime=3D50us L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1-
> > > ASPM_L1.2+ ASPM_L1.1- T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> > >         L1SubCtl2: T_PwrOn=3D50us
> > >
> > > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue
> > > SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express]) ...
> > >     Capabilities: [900 v1] L1 PM Substates
> > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > L1_PM_Substates+ PortCommonModeRestoreTime=3D32us
> > > PortTPowerOnTime=3D10us L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1-
> > > ASPM_L1.2+ ASPM_L1.1- T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> > >         L1SubCtl2: T_PwrOn=3D10us
> > >
> > > After debug in detail, both of the VMD mapped PCI bridge and the
> > > NVMe SSD controller have been configured properly with the same
> > > LTR1.2_Threshold value. But, become misconfigured after reset the
> > > VMD mapped PCI bus which is introduced from commit 0a584655ef89
> > > ("PCI: vmd: Fix secondary bus reset for Intel bridges") and commit
> > > 6aab5622296b ("PCI: vmd: Clean up domain before enumeration"). So,
> > > drop the resetting PCI bus action after scan VMD mapped PCI child
> > > bus.
> > >
> > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > ---
> > > v6:
> > > - Introduced based on the discussion
> > > https://lore.kernel.org/linux-pci/CAPpJ_efYWWxGBopbSQHB=3DY2+1RrXFR2X=
WeqEhGTgdiw3XX0Jmw@mail.gmail.com/
> > >
> > >  drivers/pci/controller/vmd.c | 20 --------------------
> > >  1 file changed, 20 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/vmd.c
> > > b/drivers/pci/controller/vmd.c index 5309afbe31f9..af413cdb4f4e
> > > 100644 --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -793,7 +793,6 @@ static int vmd_enable_domain(struct vmd_dev
> > > *vmd, unsigned long features) resource_size_t offset[2] =3D {0};
> > >       resource_size_t membar2_offset =3D 0x2000;
> > >       struct pci_bus *child;
> > > -     struct pci_dev *dev;
> > >       int ret;
> > >
> > >       /*
> > > @@ -935,25 +934,6 @@ static int vmd_enable_domain(struct vmd_dev
> > > *vmd, unsigned long features) pci_scan_child_bus(vmd->bus);
> > >       vmd_domain_reset(vmd);
> > >
> > > -     /* When Intel VMD is enabled, the OS does not discover the
> > > Root Ports
> > > -      * owned by Intel VMD within the MMCFG space.
> > > pci_reset_bus() applies
> > > -      * a reset to the parent of the PCI device supplied as
> > > argument. This
> > > -      * is why we pass a child device, so the reset can be
> > > triggered at
> > > -      * the Intel bridge level and propagated to all the children
> > > in the
> > > -      * hierarchy.
> > > -      */
> > > -     list_for_each_entry(child, &vmd->bus->children, node) {
> > > -             if (!list_empty(&child->devices)) {
> > > -                     dev =3D list_first_entry(&child->devices,
> > > -                                            struct pci_dev,
> > > bus_list);
> > > -                     ret =3D pci_reset_bus(dev);
> > > -                     if (ret)
> > > -                             pci_warn(dev, "can't reset device:
> > > %d\n", ret); -
> > > -                     break;
> > > -             }
> > > -     }
> > > -
> > >       pci_assign_unassigned_bus_resources(vmd->bus);
> > >
> > >       pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features); =20
> >
> > Thanks for the patch.
> >
> > pci_reset_bus is required to avoid failure in vmd domain creation
> > during multiple soft reboots test. So I believe we can't just remove
> > it without proper testing. vmd_pm_enable_quirk happens after
> > pci_reset_bus, then how is it resetting LTR1.2_Threshold value? =20
>=20
> uh!  I mean that drop pci_reset_bus(dev) after
> pci_scan_child_bus(vmd->bus) Not pci_walk_bus() with
> vmd_pm_enable_quirk.

That is what I am saying; we cannot remove/drop pci_reset_bus it is
very useful for the case I mentioned in my previous comment and in case
of direct assign or Guest OS PCIe device enumeration.

-nirmal
>=20
> Jian-Hong Pan
>=20
>=20
> Jian-Hong Pan


