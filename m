Return-Path: <linux-pci+bounces-23116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF8A56872
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 14:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2943B1306
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 13:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F5420F068;
	Fri,  7 Mar 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEuYQ/jR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09512940B;
	Fri,  7 Mar 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352800; cv=none; b=HRbTjdiYEGe30i/iY6HJZESEv1bf0ki53np9ueE5hPuaYG2lJ31oN7Q2yFHF9zl+44cd+yV1P3Lsiy4ylA9bneAMjJHjKJ7DVOcw7UY1j+26dIYkvCWUvptKwx/UaDSGtN1CDguJNCz61Fun9w3etZFuVd18KMZREkHNZ1c5Skw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352800; c=relaxed/simple;
	bh=pyHubA2Y8El2Dxo9cYYe+J579rPOig3OH2qxyp1/PRI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a4Zczyns2EXw2iLplFCwBv7dhfjoMKjbrByO2pIuYhFDEe/OIscTnU8lGfxcYRNSg2KXHYRxI6UkZLn3s2asFCqVSY0N2xVRrwsijV+O2xYvXnXwe+HdN6qJVy+ZhAyBH7k82JXqMCg5hH6i+BWKARMXrigBHi52ajkqkNUdDxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEuYQ/jR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741352799; x=1772888799;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pyHubA2Y8El2Dxo9cYYe+J579rPOig3OH2qxyp1/PRI=;
  b=DEuYQ/jRG9mtclPA0IATUGLr4pX+iKGnlrDBia9YCz+kmFbdMZxQnLGL
   JhIUC5C3psJSoEAUGXTW6jO/Yp9k7bzY42ODPOyfdgEEQpQVR6y2/2sDH
   VOGRxc9gf/EGIxJRAFXp4HTBfsaGAL5xLKrP6GNlDKIwZw7RUx8e8UXwe
   2Y9PalP03VARs2KHsXKeHnDM3FcQ7FGS7JWl7bQ15GDfhyHJC5gtE2PbP
   Bfj5HzDo9fHtS+84U9+HQv+COIFDrBa1wemucCCRx2/iaYZUpWxbpS/Ru
   livylHbKn4RwjIJYSR1s9ldEkjQdDMRJ9fwmsWDi+SAL775dF6OUjha/R
   w==;
X-CSE-ConnectionGUID: beueioGtTge6zZmwJARSdA==
X-CSE-MsgGUID: 5UBe7GtaTp2oWnq2EwZ+kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42597806"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42597806"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 05:06:38 -0800
X-CSE-ConnectionGUID: Vcy1/GqCRXy6USNwKX5XPw==
X-CSE-MsgGUID: 2vsEvP1QS+yo9LF9DAAYeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150271266"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.120])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 05:06:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 7 Mar 2025 15:06:31 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
In-Reply-To: <20250304211428.GA258044@bhelgaas>
Message-ID: <ef29ceb3-9aa6-f4ca-014e-3f005a9b4beb@linux.intel.com>
References: <20250304211428.GA258044@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-967870661-1741352791=:984"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-967870661-1741352791=:984
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 4 Mar 2025, Bjorn Helgaas wrote:

> On Tue, Mar 04, 2025 at 03:51:08PM +0200, Ilpo J=C3=A4rvinen wrote:
> > Disallow Extended Tags and Max Read Request Size (MRRS) larger than
> > 128B for devices under Xeon 6 Root Ports if the Root Port is bifurcated
> > to x2. Also, 10-Bit Tag Requester should be disallowed for device
> > underneath these Root Ports but there is currently no 10-Bit Tag
> > support in the kernel.
> >=20
> > The normal path that writes MRRS is through
> > pcie_bus_configure_settings() -> pcie_bus_configure_set() ->
> > pcie_write_mrrs() and contains a few early returns that are based on
> > the value of pcie_bus_config. Overriding such checks with the host
> > bridge flag check on each level seems messy. Thus, simply ensure MRRS
> > is always written in pci_configure_device() if a device requiring the
> > quirk is detected.
>=20
> This is kind of weird.  It's apparently not an erratum in the sense
> that something doesn't *work*, just something for "optimized PCIe
> performance"?
>=20
> What are we supposed to do with this?  Add similar quirks for every
> random PCI controller?  Scratching my head about what this means for
> the future.
>=20
> What bad things happen if we *don't* do this?  Is this something we
> could/should rely on BIOS to configure for us?

Even if BIOS configures this (I'm under impression they already do, I=20
had problem in finding a configuration in our lab on which this patch
had some effect). But my kernel was built with CONFIG_PCIE_BUS_DEFAULT, if=
=20
I set that to CONFIG_PCIE_BUS_PERFORMANCE, what BIOS did will be=20
overwritten.

One option would be to drop the changes to drivers/pci/probe.c which is=20
there to force MRRS is always written (in this v1). That case should be=20
coverable with BIOS configuration but changes into pcie_set_readrq() seems=
=20
necessary to prevent Linux overwriting the configuration made by the BIOS.=
=20
Unless there's going to some other mechanism to tell kernel it should keep=
=20
hands from from these values as suggested by Dan.

--=20
 i.

> > Link: https://cdrdv2.intel.com/v1/dl/getContent/837176
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >=20
> > The normal path that writes MRRS is somewhat convoluted so I ensure MRR=
S
> > gets written in a more direct way, I'm not sure if that's the best
> > approach. Thus sending this as RFC.
> >=20
> >  drivers/pci/pci.c    | 15 ++++++++-------
> >  drivers/pci/probe.c  |  8 +++++++-
> >  drivers/pci/quirks.c | 27 +++++++++++++++++++++++++++
> >  include/linux/pci.h  |  1 +
> >  4 files changed, 43 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 869d204a70a3..81ddad81ccb8 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5913,7 +5913,7 @@ EXPORT_SYMBOL(pcie_get_readrq);
> >  int pcie_set_readrq(struct pci_dev *dev, int rq)
> >  {
> >  =09u16 v;
> > -=09int ret;
> > +=09int ret, max_mrrs =3D 4096;
> >  =09struct pci_host_bridge *bridge =3D pci_find_host_bridge(dev->bus);
> > =20
> >  =09if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
> > @@ -5933,13 +5933,14 @@ int pcie_set_readrq(struct pci_dev *dev, int rq=
)
> > =20
> >  =09v =3D FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> > =20
> > -=09if (bridge->no_inc_mrrs) {
> > -=09=09int max_mrrs =3D pcie_get_readrq(dev);
> > +=09if (bridge->no_inc_mrrs)
> > +=09=09max_mrrs =3D pcie_get_readrq(dev);
> > +=09if (bridge->only_128b_mrrs)
> > +=09=09max_mrrs =3D 128;
> > =20
> > -=09=09if (rq > max_mrrs) {
> > -=09=09=09pci_info(dev, "can't set Max_Read_Request_Size to %d; max is =
%d\n", rq, max_mrrs);
> > -=09=09=09return -EINVAL;
> > -=09=09}
> > +=09if (rq > max_mrrs) {
> > +=09=09pci_info(dev, "can't set Max_Read_Request_Size to %d; max is %d\=
n", rq, max_mrrs);
> > +=09=09return -EINVAL;
> >  =09}
> > =20
> >  =09ret =3D pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index b6536ed599c3..ceaa34b0525b 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2342,7 +2342,11 @@ static void pci_configure_serr(struct pci_dev *d=
ev)
> > =20
> >  static void pci_configure_device(struct pci_dev *dev)
> >  {
> > +=09struct pci_host_bridge *host_bridge =3D pci_find_host_bridge(dev->b=
us);
> > +
> >  =09pci_configure_mps(dev);
> > +=09if (host_bridge && host_bridge->only_128b_mrrs)
> > +=09=09pcie_set_readrq(dev, 128);
> >  =09pci_configure_extended_tags(dev, NULL);
> >  =09pci_configure_relaxed_ordering(dev);
> >  =09pci_configure_ltr(dev);
> > @@ -2851,13 +2855,15 @@ static void pcie_write_mps(struct pci_dev *dev,=
 int mps)
> > =20
> >  static void pcie_write_mrrs(struct pci_dev *dev)
> >  {
> > +=09struct pci_host_bridge *host_bridge =3D pci_find_host_bridge(dev->b=
us);
> >  =09int rc, mrrs;
> > =20
> >  =09/*
> >  =09 * In the "safe" case, do not configure the MRRS.  There appear to =
be
> >  =09 * issues with setting MRRS to 0 on a number of devices.
> >  =09 */
> > -=09if (pcie_bus_config !=3D PCIE_BUS_PERFORMANCE)
> > +=09if (pcie_bus_config !=3D PCIE_BUS_PERFORMANCE &&
> > +=09    (!host_bridge || !host_bridge->only_128b_mrrs))
> >  =09=09return;
> > =20
> >  =09/*
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index b84ff7bade82..987cd94028e1 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5564,6 +5564,33 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORK=
S, 0x0144, quirk_no_ext_tags);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ex=
t_tags);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ex=
t_tags);
> > =20
> > +static void quirk_pcie2x_no_tags_no_mrrs(struct pci_dev *pdev)
> > +{
> > +=09struct pci_host_bridge *bridge =3D pci_find_host_bridge(pdev->bus);
> > +=09u32 linkcap;
> > +
> > +=09if (!bridge)
> > +=09=09return;
> > +
> > +=09pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &linkcap);
> > +=09if (FIELD_GET(PCI_EXP_LNKCAP_MLW, linkcap) !=3D 0x2)
> > +=09=09return;
> > +
> > +=09bridge->no_ext_tags =3D 1;
> > +=09bridge->only_128b_mrrs =3D 1;
> > +=09pci_info(pdev, "Disabling Extended Tags and forcing MRRS to 128B (p=
erformance reasons due to 2x PCIe link)\n");
> > +}
> > +
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db0, quirk_pcie2x_no_t=
ags_no_mrrs);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db1, quirk_pcie2x_no_t=
ags_no_mrrs);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db2, quirk_pcie2x_no_t=
ags_no_mrrs);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db3, quirk_pcie2x_no_t=
ags_no_mrrs);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db6, quirk_pcie2x_no_t=
ags_no_mrrs);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db7, quirk_pcie2x_no_t=
ags_no_mrrs);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db8, quirk_pcie2x_no_t=
ags_no_mrrs);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db9, quirk_pcie2x_no_t=
ags_no_mrrs);
> > +
> > +
> >  #ifdef CONFIG_PCI_ATS
> >  static void quirk_no_ats(struct pci_dev *pdev)
> >  {
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 47b31ad724fa..def29c8c0f84 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -601,6 +601,7 @@ struct pci_host_bridge {
> >  =09unsigned int=09ignore_reset_delay:1;=09/* For entire hierarchy */
> >  =09unsigned int=09no_ext_tags:1;=09=09/* No Extended Tags */
> >  =09unsigned int=09no_inc_mrrs:1;=09=09/* No Increase MRRS */
> > +=09unsigned int=09only_128b_mrrs:1;=09/* Only 128B MRRS */
> >  =09unsigned int=09native_aer:1;=09=09/* OS may use PCIe AER */
> >  =09unsigned int=09native_pcie_hotplug:1;=09/* OS may use PCIe hotplug =
*/
> >  =09unsigned int=09native_shpc_hotplug:1;=09/* OS may use SHPC hotplug =
*/
> >=20
> > base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> > --=20
> > 2.39.5
> >=20
>=20
--8323328-967870661-1741352791=:984--

