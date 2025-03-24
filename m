Return-Path: <linux-pci+bounces-24538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B96CA6DDC0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 16:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC7C3AAD5C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD4925E45A;
	Mon, 24 Mar 2025 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UtkbcPW7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BCB667;
	Mon, 24 Mar 2025 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828558; cv=none; b=eljGKpKeQIL0ubPcNwaGaHgnsvit5rHKkT+cKd32q4r+5q+05oBARrLnR/sH3eIIujNjSewy8TLIFccdbN0tTjhwDda4nPUtPSYhCEMqE1QQ5cIcMZDctPhM9AWI0pykr6NwycjU+EbhCXYzfhSUKDKJYFHnGgvCh+JrrCzIJuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828558; c=relaxed/simple;
	bh=8cXfyPbWxAr/jWnMcJDQrocLjVs+q5zx4VVdCdCy9kM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fRZMphNCwBCJl6LaAG2jBGe310npGWzpSht8Fi25XydrCVZftKq2x1f5Uf0XcjI+v88bCGGpBK8fzMo9enriHlFEQwBQFOhkKsWgxYY3fAxs7p77jrhLSWJQNLyJRpJ5QOycXyTjimrFQnz3IKkZCPSHragpNiWdaWVCeYYlXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UtkbcPW7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742828556; x=1774364556;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=8cXfyPbWxAr/jWnMcJDQrocLjVs+q5zx4VVdCdCy9kM=;
  b=UtkbcPW7LGJCR3/yOiAnfvOL8yXhQTBPAKiTgfokKONxMolw1mtfPlNo
   boiC+TZDiQ1RjE/DqEWoGlJ5/5bWL/3Tv4PWYuHTiv5LP0bFCT6C4sBSU
   3wryJcT2IfySFtXXZZE3QqEpMTt1r1JK4BGIeMlHQU/cIODHECh6GrgOs
   3A2TQ++/uaVR8eiuoFgIHDk0bTOPRZTn8hv77U1n4Y7HdnwMkd6hljSEJ
   vIMPhfdBezSCRgheO44QFQd+fm804msCY53rVqk/nUs3yGrgPJdb8DKiZ
   GIQi+71tPu7vhC/9vq4jHJQZ3PZsOBnc3GTOI3H1fl+1HqLpZWY4GZAu2
   A==;
X-CSE-ConnectionGUID: i702SIYEQACFVJJn+sjX/g==
X-CSE-MsgGUID: cXFIolXSRdGx8O7+bWm/+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="55409908"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="55409908"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 08:02:35 -0700
X-CSE-ConnectionGUID: gMnauPJeRRK4fryKzAjBIw==
X-CSE-MsgGUID: RgZUcThoSyyQCA7D+PG4Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="129183127"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.251])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 08:02:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Mar 2025 17:02:28 +0200 (EET)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
    thomas.richard@bootlin.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
In-Reply-To: <d370b69a-3b70-4e3b-94a3-43e0bc1305cd@163.com>
Message-ID: <a3462c68-ec1b-0b1a-fee7-612bd1109819@linux.intel.com>
References: <20250323164852.430546-1-18255117159@163.com> <20250323164852.430546-4-18255117159@163.com> <f467056d-8d4a-9dab-2f0a-ca589adfde53@linux.intel.com> <d370b69a-3b70-4e3b-94a3-43e0bc1305cd@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-920175786-1742826920=:1100"
Content-ID: <318e995d-f786-7902-a077-e902a2ba123b@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-920175786-1742826920=:1100
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <d310fa7e-10d5-290b-4aff-454e1f31a150@linux.intel.com>

On Mon, 24 Mar 2025, Hans Zhang wrote:
> On 2025/3/24 21:44, Ilpo J=E4rvinen wrote:
> > On Mon, 24 Mar 2025, Hans Zhang wrote:
> >=20
> > > Since the PCI core is now exposing generic APIs for the host bridges =
to
> >=20
> > No need to say "since ... is now exposing". Just say "Use ..." as if th=
e
> > API has always existed even if you just added it.
> >=20
>=20
> Hi Ilpo,
>=20
> Thanks your for reply. Will change.
>=20
>=20
> > > search for the PCIe capabilities, make use of them in the CDNS driver=
=2E
> > >=20
> > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > ---
> > > Changes since v5:
> > > https://lore.kernel.org/linux-pci/20250321163803.391056-4-18255117159=
@163.com
> > >=20
> > > - Kconfig add "select PCI_HOST_HELPERS"
> > > ---
> > >   drivers/pci/controller/cadence/Kconfig        |  1 +
> > >   drivers/pci/controller/cadence/pcie-cadence.c | 25 ++++++++++++++++=
+++
> > >   drivers/pci/controller/cadence/pcie-cadence.h |  3 +++
> > >   3 files changed, 29 insertions(+)
> > >=20
> > > diff --git a/drivers/pci/controller/cadence/Kconfig
> > > b/drivers/pci/controller/cadence/Kconfig
> > > index 8a0044bb3989..0a4f245bbeb0 100644
> > > --- a/drivers/pci/controller/cadence/Kconfig
> > > +++ b/drivers/pci/controller/cadence/Kconfig
> > > @@ -5,6 +5,7 @@ menu "Cadence-based PCIe controllers"
> > >     config PCIE_CADENCE
> > >   =09bool
> > > +=09select PCI_HOST_HELPERS
> > >     config PCIE_CADENCE_HOST
> > >   =09bool
> > > diff --git a/drivers/pci/controller/cadence/pcie-cadence.c
> > > b/drivers/pci/controller/cadence/pcie-cadence.c
> > > index 204e045aed8c..329dab4ff813 100644
> > > --- a/drivers/pci/controller/cadence/pcie-cadence.c
> > > +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> > > @@ -8,6 +8,31 @@
> > >     #include "pcie-cadence.h"
> > >   +static u32 cdns_pcie_read_cfg(void *priv, int where, int size)
> > > +{
> > > +=09struct cdns_pcie *pcie =3D priv;
> > > +=09u32 val;
> > > +
> > > +=09if (size =3D=3D 4)
> > > +=09=09val =3D readl(pcie->reg_base + where);
> >=20
> > Should this use cdns_pcie_readl() ?
>=20
> pci_host_bridge_find_*capability required to read two or four bytes.
>=20
> reg =3D read_cfg(priv, cap_ptr, 2);
> or
> header =3D read_cfg(priv, pos, 4);
>=20
> Here I mainly want to write it the same way as size =3D=3D 2 and size =3D=
=3D 1.
> Or size =3D=3D 4 should I write it as cdns_pcie_readl() ?

As is, it seems two functions are added for the same thing for the case=20
with size =3D=3D 4 with different names which feels duplication. One could =
add=20
cdns_pcie_readw() and cdns_pcie_readb() too but perhaps cdns_pcie_readl()=
=20
should just call this new function instead?

> > > +=09else if (size =3D=3D 2)
> > > +=09=09val =3D readw(pcie->reg_base + where);
> > > +=09else if (size =3D=3D 1)
> > > +=09=09val =3D readb(pcie->reg_base + where);
> > > +
> > > +=09return val;
> > > +}
> > > +
> > > +u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
> > > +{
> > > +=09return pci_host_bridge_find_capability(pcie, cdns_pcie_read_cfg, =
cap);
> > > +}
> > > +
> > > +u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
> > > +{
> > > +=09return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_c=
fg,
> > > cap);
> > > +}
> >=20
> > I'm really wondering why the read config function is provided directly =
as
> > an argument. Shouldn't struct pci_host_bridge have some ops that can re=
ad
> > config so wouldn't it make much more sense to pass it and use the func
> > from there? There seems to ops in pci_host_bridge that has read(), does
> > that work? If not, why?
> >=20
>=20
> No effect.=20

I'm not sure what you meant?

> Because we need to get the offset of the capability before PCIe
> enumerates the device.=20

Is this to say it is needed before the struct pci_host_bridge is created?

> I originally added a separate find capability related
> function for CDNS in the following patch. It's also copied directly from =
DWC.
> Mani felt there was too much duplicate code and also suggested passing a
> callback function that could manipulate the registers of the root port of=
 DWC
> or CDNS.

I very much like the direction this patchset is moving (moving shared=20
part of controllers code to core), I just feel this doesn't go far enough=
=20
when it's passing function pointer to the read function.

I admit I've never written a controller driver so perhaps there's=20
something detail I lack knowledge of but I'd want to understand why
struct pci_ops (which exists both in pci_host_bridge and pci_bus) cannot=20
be used?

> https://patchwork.kernel.org/project/linux-pci/patch/20250308133903.32221=
6-1-18255117159@163.com/
>=20
> The original function is in the following file:
> drivers/pci/controller/dwc/pcie-designware.c
> u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
> u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
>=20
> CDNS has the same need to find the offset of the capability.
>=20
> > > +
> > >   void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
> > >   {
> > >   =09u32 delay =3D 0x3;
> > > diff --git a/drivers/pci/controller/cadence/pcie-cadence.h
> > > b/drivers/pci/controller/cadence/pcie-cadence.h
> > > index f5eeff834ec1..6f4981fccb94 100644
> > > --- a/drivers/pci/controller/cadence/pcie-cadence.h
> > > +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> > > @@ -557,6 +557,9 @@ static inline int cdns_pcie_ep_setup(struct
> > > cdns_pcie_ep *ep)
> > >   }
> > >   #endif
> > >   +u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
> > > +u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
> > > +
> > >   void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
> > >     void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 bus=
nr,
> > > u8 fn,
> > >=20
> >=20
>=20
> Best regards,
> Hans
>=20

--=20
 i.
--8323328-920175786-1742826920=:1100--

