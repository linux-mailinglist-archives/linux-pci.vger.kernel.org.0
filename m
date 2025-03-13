Return-Path: <linux-pci+bounces-23590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA75EA5EFEE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 10:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0D917CB4A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9602641D4;
	Thu, 13 Mar 2025 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUEiE9cd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980751FBCAE;
	Thu, 13 Mar 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859448; cv=none; b=ebE95CtvNr1p7ttnq68mvmr/oOg8qmVoPKBxGL1X6tFEZFXLcHQHsQf9DMHgwoOMO3ty8jApmaItELMHoGmKeSRZYUhJmcKst4bhE9a7JRDnfkpu/jA1IUuZIAanNHAdDFP9pOER7Gfz8AMkDcXTrOx/hk+P/qHPV4qKXY/ku7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859448; c=relaxed/simple;
	bh=kQra7Uax2xjWGj1Bg2SDrSkgORCccpcYXbO386VNAo0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MEPWtoq0fNP974oIMROmktB8YLU2ePDYJ8G0u2pWPXADCKM/L5+I4JxLuLEBtypo7hk6iVSnQDlxgcZb4SdwRBjE8LtxWn5lVhbZRpgqNMv5V2xgBjUooCGbSkWGgusmB87IdSYEsuw1IjFJ5N4AEo+Q9ytlbHrLkQ2zkQIk1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUEiE9cd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741859447; x=1773395447;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kQra7Uax2xjWGj1Bg2SDrSkgORCccpcYXbO386VNAo0=;
  b=cUEiE9cdXDy9WFli5Hqejedb27tKGjliyF/oCVPb5bR62/QSlz+HFtrc
   4eGqm8ikp/0blpHfw46kZOq9O4l+M+8pSDjLPgthtoM2tC5o8oDkqQNZB
   1dcMybxrr0MrCyIcHQtQLQFLLDBaDhQtrbmZgJgyOwjxBVw4s9RwtYPE8
   DuLwzXVCB6KaO2sfkahkyqg1GF4w6udgohPI9THH//4YHVUoZuGVhZgdV
   9Ly6s5fNrKOllUSuEJux6M/KjRQ3ofx8ZpJqm4fnJCobAC22fhGRwRrpP
   EAaTU6jxfw84o1xaOFst355WDlEhETTKbQXfwBVjaXL3zkzQqgZ+uGD9f
   Q==;
X-CSE-ConnectionGUID: 72gRccuqTD+Eajwciae+vg==
X-CSE-MsgGUID: jv3OWKjDSvOF6kei3ex+tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="54348230"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="54348230"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:50:46 -0700
X-CSE-ConnectionGUID: csq7WghwQo6RD1sHs7pLvw==
X-CSE-MsgGUID: xjhmYOwJRd67+TeGwsLPVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120894564"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:50:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Mar 2025 11:50:37 +0200 (EET)
To: =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>
cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org, 
    dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rodrigo Vivi <rodrigo.vivi@intel.com>, 
    Michal Wajdeczko <michal.wajdeczko@intel.com>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
    Maxime Ripard <mripard@kernel.org>, 
    Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
    Simona Vetter <simona@ffwll.ch>, Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v5 1/6] PCI/IOV: Restore VF resizable BAR state after
 reset
In-Reply-To: <d6e026ad-4dd4-2e03-6f8b-a10980fa0ce7@linux.intel.com>
Message-ID: <f99f1533-2dd7-7ba8-3a5c-f68e45b1e8b6@linux.intel.com>
References: <20250312225949.969716-1-michal.winiarski@intel.com> <20250312225949.969716-2-michal.winiarski@intel.com> <d6e026ad-4dd4-2e03-6f8b-a10980fa0ce7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-873385725-1741859437=:1742"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-873385725-1741859437=:1742
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 13 Mar 2025, Ilpo J=C3=A4rvinen wrote:

> On Wed, 12 Mar 2025, Micha=C5=82 Winiarski wrote:
>=20
> > Similar to regular resizable BAR, VF BAR can also be resized, e.g. by
> > the system firmware or the PCI subsystem itself.
> >=20
> > Add the capability ID and restore it as a part of IOV state.
> >=20
> > See PCIe r4.0, sec 9.3.7.4.
> >=20
> > Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> >  drivers/pci/iov.c             | 29 ++++++++++++++++++++++++++++-
> >  include/uapi/linux/pci_regs.h |  1 +
> >  2 files changed, 29 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index 121540f57d4bf..eb4d33eacacb8 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -7,6 +7,7 @@
> >   * Copyright (C) 2009 Intel Corporation, Yu Zhao <yu.zhao@intel.com>
> >   */
> > =20
> > +#include <linux/bitfield.h>
> >  #include <linux/pci.h>
> >  #include <linux/slab.h>
> >  #include <linux/export.h>
> > @@ -868,6 +869,30 @@ static void sriov_release(struct pci_dev *dev)
> >  =09dev->sriov =3D NULL;
> >  }
> > =20
> > +static void sriov_restore_vf_rebar_state(struct pci_dev *dev)
> > +{
> > +=09unsigned int pos, nbars, i;
> > +=09u32 ctrl;
> > +
> > +=09pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VF_REBAR);
> > +=09if (!pos)
> > +=09=09return;
>=20
> FYI, the commit f7c9bb759161 ("PCI: Cache offset of Resizable BAR=20
> capability") which is currently in pci/enumeration makes this simpler.

I'm sorry, I realized it's not the same capability but you should do=20
similar thing for VF rebar capability as caching the value of=20
pci_find_ext_capability() avoids some slowness during save/restore.

--=20
 i.

> > +=09pci_read_config_dword(dev, pos + PCI_REBAR_CTRL, &ctrl);
> > +=09nbars =3D FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
> > +
> > +=09for (i =3D 0; i < nbars; i++, pos +=3D 8) {
> > +=09=09int bar_idx, size;
> > +
> > +=09=09pci_read_config_dword(dev, pos + PCI_REBAR_CTRL, &ctrl);
> > +=09=09bar_idx =3D FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, ctrl);
> > +=09=09size =3D pci_rebar_bytes_to_size(dev->sriov->barsz[bar_idx]);
> > +=09=09ctrl &=3D ~PCI_REBAR_CTRL_BAR_SIZE;
> > +=09=09ctrl |=3D FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
> > +=09=09pci_write_config_dword(dev, pos + PCI_REBAR_CTRL, ctrl);
> > +=09}
> > +}
> > +
> >  static void sriov_restore_state(struct pci_dev *dev)
> >  {
> >  =09int i;
> > @@ -1027,8 +1052,10 @@ resource_size_t pci_sriov_resource_alignment(str=
uct pci_dev *dev, int resno)
> >   */
> >  void pci_restore_iov_state(struct pci_dev *dev)
> >  {
> > -=09if (dev->is_physfn)
> > +=09if (dev->is_physfn) {
> > +=09=09sriov_restore_vf_rebar_state(dev);
> >  =09=09sriov_restore_state(dev);
> > +=09}
> >  }
> > =20
> >  /**
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_reg=
s.h
> > index 3c2558b98d225..aadd483c47d6f 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -744,6 +744,7 @@
> >  #define PCI_EXT_CAP_ID_L1SS=090x1E=09/* L1 PM Substates */
> >  #define PCI_EXT_CAP_ID_PTM=090x1F=09/* Precision Time Measurement */
> >  #define PCI_EXT_CAP_ID_DVSEC=090x23=09/* Designated Vendor-Specific */
> > +#define PCI_EXT_CAP_ID_VF_REBAR 0x24=09/* VF Resizable BAR */
> >  #define PCI_EXT_CAP_ID_DLF=090x25=09/* Data Link Feature */
> >  #define PCI_EXT_CAP_ID_PL_16GT=090x26=09/* Physical Layer 16.0 GT/s */
> >  #define PCI_EXT_CAP_ID_NPEM=090x29=09/* Native PCIe Enclosure Manageme=
nt */
> >=20
>=20
>=20
--8323328-873385725-1741859437=:1742--

