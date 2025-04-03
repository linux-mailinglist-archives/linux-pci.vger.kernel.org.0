Return-Path: <linux-pci+bounces-25225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A562AA79FC9
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 11:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB940188DAB4
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C281F236B;
	Thu,  3 Apr 2025 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyOUKZ7l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE351A0739;
	Thu,  3 Apr 2025 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743671766; cv=none; b=EgZWHYFcJwpQr5P8LqwWtnKtxrfWBbKF9XX1fm9W9Ogl7v+G1ZM0+Ixf2ziwaY+ea3KKkxCVyt7dl+PiOBl1wBR8kTp/n4TBRD8o/+BNFBZZTYNrPfD8VvDoVsAPbScLcILQuvo5F7WFHimDEqVwjoAy0JkXoG/xoUE75xnXvJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743671766; c=relaxed/simple;
	bh=ECRvilHEObaf8aOmnKMnclANg6fwsfb/OgXk4Y9UmhE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gcHoiGpdSuYbXJpCTMAbREepvFjr3FkFn81CjL4tqKSG1dCkOk5XSqXCN22TLzANtjptrDvlBtC/wyGJomCaqLIfOWmnWKwO6lGArnolm8oxQxMLj6t6KXZYQZQxoaS6UW8dSCjKlGMdklhHXcbKSGBB5GTApZyV1u3TngGg7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyOUKZ7l; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743671765; x=1775207765;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ECRvilHEObaf8aOmnKMnclANg6fwsfb/OgXk4Y9UmhE=;
  b=ZyOUKZ7lonBLIAQKZTztMfaRjpwJVNriiR4mZDbplb6Wu1zz5QGKTbwq
   RHTjkT0UYVzL70scWMEn1wLsVL683+n7+6lf/PY0DADGOt4Z9wSRnaRQu
   b7YLRQkNPUWc0Dk7Jl4nUPrbHRuIrZ1+BXUd9dusChLOAtZn7Yv5QJyDQ
   TNejAILJ9YdGATDaBtVr0iK22LXjL+STRdKBCH+tK7sqDzwavkv0hvQ/7
   jx452Y7oADbYaglQbrG8cVVPU/xWVB3tZBkUxOzZq08jBGfKDfv8bV5XA
   TsldZg/vGSm437seqK2bU7YjX+uNz6/C9Aa+c8/QkXt1jODqKUW/HQTzU
   w==;
X-CSE-ConnectionGUID: hVr81agyR0i3biR2xJT+1w==
X-CSE-MsgGUID: DX1BrQkOT42B9ExlsVCvnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44961697"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="44961697"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 02:16:03 -0700
X-CSE-ConnectionGUID: aGCPg4cyR8Gfhr9hYZ2vuA==
X-CSE-MsgGUID: sKtAECH7Q5KML1zP2EPN5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="127448786"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.152])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 02:15:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 3 Apr 2025 12:15:45 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com, 
    manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com, 
    thomas.richard@bootlin.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v7 2/5] PCI: Refactor capability search functions to eliminate
 code duplication
In-Reply-To: <c6706073-86b0-445a-b39f-993ac9b054fa@163.com>
Message-ID: <bf6f0acb-9c48-05de-6d6d-efb0236e2d30@linux.intel.com>
References: <20250402042020.48681-1-18255117159@163.com> <20250402042020.48681-3-18255117159@163.com> <8b693bfc-73e0-2956-2ba3-1bfd639660b6@linux.intel.com> <c6706073-86b0-445a-b39f-993ac9b054fa@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1454255942-1743671745=:1302"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1454255942-1743671745=:1302
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 2 Apr 2025, Hans Zhang wrote:
> On 2025/4/2 20:38, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 2 Apr 2025, Hans Zhang wrote:
> >=20
> > > Refactor the PCI capability and extended capability search functions
> > > by consolidating common code patterns into reusable macros
> > > (PCI_FIND_NEXT_CAP_TTL and PCI_FIND_NEXT_EXT_CAPABILITY). The main
> > > changes include:
> > >=20
> > > 1. Introducing a unified config space read helper (__pci_bus_read_con=
fig).
> > > 2. Removing duplicate search logic from __pci_find_next_cap_ttl and
> > >     pci_find_next_ext_capability.
> > > 3. Implementing consistent capability discovery using the new macros.
> > > 4. Simplifying HyperTransport capability lookup by leveraging the
> > >     refactored code.
> > >=20
> > > The refactoring maintains existing functionality while reducing code
> > > duplication and improving maintainability. By centralizing the search
> > > logic, we achieve better code consistency and make future updates eas=
ier.
> > >=20
> > > This change has been verified to maintain backward compatibility with
> > > existing capability discovery patterns through thorough testing of PC=
I
> > > device enumeration and capability probing.
> > >=20
> > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > ---
> > >   drivers/pci/pci.c | 79 +++++++++++++-------------------------------=
---
> > >   1 file changed, 22 insertions(+), 57 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 869d204a70a3..521096c73686 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -423,36 +423,33 @@ static int pci_dev_str_match(struct pci_dev *de=
v,
> > > const char *p,
> > >   =09return 1;
> > >   }
> > >   -static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned in=
t
> > > devfn,
> > > -=09=09=09=09  u8 pos, int cap, int *ttl)
> > > +static int __pci_bus_read_config(void *priv, unsigned int devfn, int
> > > where,
> > > +=09=09=09=09 u32 size, u32 *val)
> >=20
> > This probably should be where the other accessors are so in access.c. I=
'd
> > put its prototype into drivers/pci/pci.h only for now.
> >=20
>=20
> Hi Ilpo,
>=20
> Thank you very much for your guidance. Will change.
>=20
>=20
> > >   {
> > > -=09u8 id;
> > > -=09u16 ent;
> > > +=09struct pci_bus *bus =3D priv;
> > > +=09int ret;
> > >   -=09pci_bus_read_config_byte(bus, devfn, pos, &pos);
> > > +=09if (size =3D=3D 1)
> > > +=09=09ret =3D pci_bus_read_config_byte(bus, devfn, where, (u8 *)val)=
;
> > > +=09else if (size =3D=3D 2)
> > > +=09=09ret =3D pci_bus_read_config_word(bus, devfn, where, (u16 *)val=
);
> > > +=09else
> > > +=09=09ret =3D pci_bus_read_config_dword(bus, devfn, where, val);
> > >   -=09while ((*ttl)--) {
> > > -=09=09if (pos < 0x40)
> > > -=09=09=09break;
> > > -=09=09pos &=3D ~3;
> > > -=09=09pci_bus_read_config_word(bus, devfn, pos, &ent);
> > > +=09return ret;
> > > +}
> > >   -=09=09id =3D ent & 0xff;
> > > -=09=09if (id =3D=3D 0xff)
> > > -=09=09=09break;
> > > -=09=09if (id =3D=3D cap)
> > > -=09=09=09return pos;
> > > -=09=09pos =3D (ent >> 8);
> > > -=09}
> > > -=09return 0;
> > > +static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int
> > > devfn,
> > > +=09=09=09=09  u8 pos, int cap)
> > > +{
> > > +=09return PCI_FIND_NEXT_CAP_TTL(__pci_bus_read_config, pos, cap, bus=
,
> > > +=09=09=09=09     devfn);
> > >   }
> > >     static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int d=
evfn,
> > >   =09=09=09      u8 pos, int cap)
> > >   {
> > > -=09int ttl =3D PCI_FIND_CAP_TTL;
> > > -
> > > -=09return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
> > > +=09return __pci_find_next_cap_ttl(bus, devfn, pos, cap);
> > >   }
> > >     u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
> > > @@ -553,42 +550,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
> > >    */
> > >   u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, in=
t
> > > cap)
> > >   {
> > > -=09u32 header;
> > > -=09int ttl;
> > > -=09u16 pos =3D PCI_CFG_SPACE_SIZE;
> > > -
> > > -=09/* minimum 8 bytes per capability */
> > > -=09ttl =3D (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> > > -
> > >   =09if (dev->cfg_size <=3D PCI_CFG_SPACE_SIZE)
> > >   =09=09return 0;
> > >   -=09if (start)
> > > -=09=09pos =3D start;
> > > -
> > > -=09if (pci_read_config_dword(dev, pos, &header) !=3D PCIBIOS_SUCCESS=
FUL)
> > > -=09=09return 0;
> > > -
> > > -=09/*
> > > -=09 * If we have no capabilities, this is indicated by cap ID,
> > > -=09 * cap version and next pointer all being 0.
> > > -=09 */
> > > -=09if (header =3D=3D 0)
> > > -=09=09return 0;
> > > -
> > > -=09while (ttl-- > 0) {
> > > -=09=09if (PCI_EXT_CAP_ID(header) =3D=3D cap && pos !=3D start)
> > > -=09=09=09return pos;
> > > -
> > > -=09=09pos =3D PCI_EXT_CAP_NEXT(header);
> > > -=09=09if (pos < PCI_CFG_SPACE_SIZE)
> > > -=09=09=09break;
> > > -
> > > -=09=09if (pci_read_config_dword(dev, pos, &header) !=3D
> > > PCIBIOS_SUCCESSFUL)
> > > -=09=09=09break;
> > > -=09}
> > > -
> > > -=09return 0;
> > > +=09return PCI_FIND_NEXT_EXT_CAPABILITY(__pci_bus_read_config, start,=
 cap,
> > > +=09=09=09=09=09    dev->bus, dev->devfn);
> >=20
> > I don't like how 1 & 2 patches are split into two. IMO, they mostly bel=
ong
> > together. However, (IMO) you can introduce the new all-size config spac=
e
> > accessor in a separate patch before the combined patch.
> >=20
>=20
> Ok. I'll change it to the following. The rest I'll combine into a patch.
>=20
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index b123da16b63b..bb2e26c2eb81 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -85,6 +85,23 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
>  EXPORT_SYMBOL(pci_bus_write_config_word);
>  EXPORT_SYMBOL(pci_bus_write_config_dword);
>=20
> +

Extra newline

> +int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 s=
ize,
> +=09=09=09u32 *val)
> +{
> +=09struct pci_bus *bus =3D priv;
> +=09int ret;
> +
> +=09if (size =3D=3D 1)
> +=09=09ret =3D pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> +=09else if (size =3D=3D 2)
> +=09=09ret =3D pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
> +=09else
> +=09=09ret =3D pci_bus_read_config_dword(bus, devfn, where, val);
> +
> +=09return ret;
> +}
> +
>  int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
>  =09=09=09    int where, int size, u32 *val)
>  {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e9cf26a9ee9..6a7c88b9cd35 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -88,6 +88,8 @@ extern bool pci_early_dump;
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>  bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
>  bool pcie_cap_has_rtctl(const struct pci_dev *dev);
> +int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 s=
ize,
> +=09=09=09u32 *val);
>=20
>  /* Functions internal to the PCI core code */
>=20
>=20
> > >   }
> > >   EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
> > >   @@ -648,7 +614,6 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
> > >     static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int
> > > ht_cap)
> > >   {
> > > -=09int rc, ttl =3D PCI_FIND_CAP_TTL;
> > >   =09u8 cap, mask;
> > >     =09if (ht_cap =3D=3D HT_CAPTYPE_SLAVE || ht_cap =3D=3D HT_CAPTYPE=
_HOST)
> > > @@ -657,7 +622,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *=
dev,
> > > u8 pos, int ht_cap)
> > >   =09=09mask =3D HT_5BIT_CAP_MASK;
> > >     =09pos =3D __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
> > > -=09=09=09=09      PCI_CAP_ID_HT, &ttl);
> > > +=09=09=09=09      PCI_CAP_ID_HT);
> > >   =09while (pos) {
> > >   =09=09rc =3D pci_read_config_byte(dev, pos + 3, &cap);
> > >   =09=09if (rc !=3D PCIBIOS_SUCCESSFUL)
> > > @@ -668,7 +633,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *=
dev,
> > > u8 pos, int ht_cap)
> > >     =09=09pos =3D __pci_find_next_cap_ttl(dev->bus, dev->devfn,
> > >   =09=09=09=09=09      pos + PCI_CAP_LIST_NEXT,
> > > -=09=09=09=09=09      PCI_CAP_ID_HT, &ttl);
> > > +=09=09=09=09=09      PCI_CAP_ID_HT);
> >=20
> > This function kind of had the idea to share the ttl but I suppose that =
was
> > just a final safeguard to make sure the loop will always terminate in c=
ase
> > the config space is corrupted so the unsharing is not a big issue.
> >=20
>=20
> __pci_find_next_cap_ttl
>   // This macro definition already has ttl loop restrictions inside it.
>   PCI_FIND_NEXT_CAP_TTL
>=20
> Do I understand that you agree to remove ttl initialization and parameter
> passing?

Yes, I agree with it but doing anything like this (although I'd mention=20
the reasoning in the changelog myself).

--=20
 i.
--8323328-1454255942-1743671745=:1302--

