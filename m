Return-Path: <linux-pci+bounces-25421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 222E4A7E7D8
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 19:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272E53A3E72
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADE82144DE;
	Mon,  7 Apr 2025 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddvQe6jX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30852147E4;
	Mon,  7 Apr 2025 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045425; cv=none; b=ffj8VQobFSQMvPgCP10Xj78mdiW74lqwukL6fDL7GWp/r/Ux4/BSuTLSaRkvPzRbpBTsJhN20gQEvkvzakVS24qtPezk+FTiAJHUvOy5ix7myvb5CXAaaetb7VhMyrdF0ziFJZtnco/Re0lFoohdexsg4d5OSNXbyKqjb5WVbFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045425; c=relaxed/simple;
	bh=uGH8Y5dUpYWEFGIoyf0TOOSBgAkFdU1fp1yGsMKllZg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=khGoW18ske2HNQpElknqZ8IJePn26/X+1NnR+xUYZ2S9ClgrMeKRUOTzdMSyMA4tFVigPVqK/wazOxldXnmA0STekTmJ7DihlAgEdkw4mB5lMWuHD5M1ac+RDlt7Mhef3cN4/canjEnBnq+tb34H4I7m9gUqDCsnaNEb53pwQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddvQe6jX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744045423; x=1775581423;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uGH8Y5dUpYWEFGIoyf0TOOSBgAkFdU1fp1yGsMKllZg=;
  b=ddvQe6jXO1Ak9MA5e/DRC+DdcCPgzFxyGGOz2xTy+537BcsyY1o5Yioj
   O0ceLMoti93XDOYu71Cia1EbXD+Jm8rmQ/0LRcCahTdts7J1vp31jrRuz
   23Y0PvZNGHju22EgZnMHYgBsTwp4/W3AFR4y7vIoLU9clG5HCuWJs72lO
   4ISTJ/o+cz/+I7R41AkYH2DYawuRFpkyVd6q/6LNjBu9SccQfFZCEqzsc
   E2H5+Gw4+ZQp5RjK3eEn850tLrJDN4t/gvsUKRlPqv4F/TcZTQGSwk+Dh
   FVlG9PwJ3+t9R6Cl0vUGBuEmi3Dbb8OiEVRp/vcXn0tajg1CKn/nB7/90
   w==;
X-CSE-ConnectionGUID: TeevXfkLRmSrqEqJGekjTA==
X-CSE-MsgGUID: xdA9xqMCSyW4+Bniqbz6cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70820182"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="70820182"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 10:03:42 -0700
X-CSE-ConnectionGUID: GSmzYfrSQ/Sid9fJjdqG5A==
X-CSE-MsgGUID: 9GyG4JovR8y60vJRfgGMqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="133167967"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 10:03:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 7 Apr 2025 20:03:35 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com, 
    manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com, 
    thomas.richard@bootlin.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v7 2/5] PCI: Refactor capability search functions to eliminate
 code duplication
In-Reply-To: <ef0237d9-f5da-44d7-ab45-2be037cf0f25@163.com>
Message-ID: <3689b121-1ff2-f0f6-59f4-293cda8ea6a8@linux.intel.com>
References: <20250402042020.48681-1-18255117159@163.com> <20250402042020.48681-3-18255117159@163.com> <8b693bfc-73e0-2956-2ba3-1bfd639660b6@linux.intel.com> <c6706073-86b0-445a-b39f-993ac9b054fa@163.com> <bf6f0acb-9c48-05de-6d6d-efb0236e2d30@linux.intel.com>
 <f77f60a0-72d2-4a9c-864e-bd8c4ea8a514@163.com> <ef0237d9-f5da-44d7-ab45-2be037cf0f25@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-830954236-1744045415=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-830954236-1744045415=:936
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 4 Apr 2025, Hans Zhang wrote:

>=20
>=20
> On 2025/4/3 20:24, Hans Zhang wrote:
> > > > > > =C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0 EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
> > > > > > =C2=A0=C2=A0 @@ -648,7 +614,6 @@ EXPORT_SYMBOL_GPL(pci_get_dsn)=
;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 static u8 __pci_find_next_ht_cap(struc=
t pci_dev *dev, u8 pos,
> > > > > > int
> > > > > > ht_cap)
> > > > > > =C2=A0=C2=A0 {
> > > > > > -=C2=A0=C2=A0=C2=A0 int rc, ttl =3D PCI_FIND_CAP_TTL;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 cap, mask;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ht_cap =3D=
=3D HT_CAPTYPE_SLAVE || ht_cap =3D=3D
> > > > > > HT_CAPTYPE_HOST)
> > > > > > @@ -657,7 +622,7 @@ static u8 __pci_find_next_ht_cap(struct pci=
_dev
> > > > > > *dev,
> > > > > > u8 pos, int ht_cap)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk =3D HT_5BIT_CAP_MASK;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pos =3D __pci_=
find_next_cap_ttl(dev->bus, dev->devfn, pos,
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI_CAP_=
ID_HT, &ttl);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI_CAP_=
ID_HT);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (pos) {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=
 =3D pci_read_config_byte(dev, pos + 3, &cap);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (rc !=3D PCIBIOS_SUCCESSFUL)
> > > > > > @@ -668,7 +633,7 @@ static u8 __pci_find_next_ht_cap(struct pci=
_dev
> > > > > > *dev,
> > > > > > u8 pos, int ht_cap)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 pos =3D __pci_find_next_cap_ttl(dev->bus, dev->devfn,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pos + PCI_CAP_LIST_NEXT,
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 PCI_CAP_ID_HT, &ttl);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 PCI_CAP_ID_HT);
> > > > >=20
> > > > > This function kind of had the idea to share the ttl but I suppose=
 that
> > > > > was
> > > > > just a final safeguard to make sure the loop will always terminat=
e in
> > > > > case
> > > > > the config space is corrupted so the unsharing is not a big issue=
=2E
> > > > >=20
> > > >=20
> > > > __pci_find_next_cap_ttl
> > > > =C2=A0=C2=A0 // This macro definition already has ttl loop restrict=
ions inside it.
> > > > =C2=A0=C2=A0 PCI_FIND_NEXT_CAP_TTL
> > > >=20
> > > > Do I understand that you agree to remove ttl initialization and
> > > > parameter
> > > > passing?
> > >=20
> > > Yes, I agree with it but doing anything like this (although I'd menti=
on
> > > the reasoning in the changelog myself).
> > >=20
> >=20
> > Ok, I see. I will give the reasons.
>=20
> Hi Ilpo,
>=20
> The [v9 3/6]patch I plan to submit is as follows, please review it.
>=20
> From 6da415d130e76b57ecf401f14bf0b66f20407839 Mon Sep 17 00:00:00 2001
> From: Hans Zhang <18255117159@163.com>
> Date: Fri, 4 Apr 2025 00:20:29 +0800
> Subject: [v9 3/6] PCI: Refactor capability search into common macros
>=20
> - Capability search is done both in PCI core and some controller drivers.
> - PCI core's cap search func requires PCI device and bus structs exist.
> - Controller drivers cannot use PCI core's cap search func as they
>   need to find capabilities before they instantiated the PCI device & bus
>   structs.
>=20
> - Move capability search into a macro so it can be reused where normal
>   PCI config space accessors cannot yet be used due to lack of the
>   instantiated PCI dev.
> - Instead, give the config space reading function as an argument to the
>   new macro.
> - Convert PCI core to use the new macro.

None of these bullets are true lists so please write them as normal=20
English paragraphs. Also please extend some of shortened words lke "cap"=20
--> "Capability", "PCI dev" -> PCI Device (for terms, the capitalization=20
of the first letter, you should follow what the PCI specs use).

--=20
 i.

>=20
> The macros now implement, parameterized by the config access method. The
> PCI core functions are converted to utilize these macros with the standar=
d
> pci_bus_read_config accessors. Controller drivers can later use the same
> macros with their early access mechanisms while maintaining the existing
> protection against infinite loops through preserved TTL checks.
>=20
> The ttl parameter was originally an additional safeguard to prevent
> infinite loops in corrupted config space.  However, the
> PCI_FIND_NEXT_CAP_TTL macro already enforces a TTL limit internally.
> Removing redundant ttl handling simplifies the interface while maintainin=
g
> the safety guarantee. This aligns with the macro's design intent of
> encapsulating TTL management.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/pci.c | 70 +++++---------------------------------
>  drivers/pci/pci.h | 86 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+), 61 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e4d3719b653d..bef242d84ab4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -9,7 +9,6 @@
>   */
>=20
>  #include <linux/acpi.h>
> -#include <linux/align.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
> @@ -31,7 +30,6 @@
>  #include <asm/dma.h>
>  #include <linux/aer.h>
>  #include <linux/bitfield.h>
> -#include <uapi/linux/pci_regs.h>
>  #include "pci.h"
>=20
>  DEFINE_MUTEX(pci_slot_mutex);
> @@ -426,35 +424,16 @@ static int pci_dev_str_match(struct pci_dev *dev, c=
onst
> char *p,
>  }
>=20
>  static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devf=
n,
> -=09=09=09=09  u8 pos, int cap, int *ttl)
> +=09=09=09=09  u8 pos, int cap)
>  {
> -=09u8 id;
> -=09u16 ent;
> -
> -=09pci_bus_read_config_byte(bus, devfn, pos, &pos);
> -
> -=09while ((*ttl)--) {
> -=09=09if (pos < PCI_STD_HEADER_SIZEOF)
> -=09=09=09break;
> -=09=09pos =3D ALIGN_DOWN(pos, 4);
> -=09=09pci_bus_read_config_word(bus, devfn, pos, &ent);
> -
> -=09=09id =3D FIELD_GET(PCI_CAP_ID_MASK, ent);
> -=09=09if (id =3D=3D 0xff)
> -=09=09=09break;
> -=09=09if (id =3D=3D cap)
> -=09=09=09return pos;
> -=09=09pos =3D FIELD_GET(PCI_CAP_LIST_NEXT_MASK, ent);
> -=09}
> -=09return 0;
> +=09return PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config, pos, cap, bus,
> +=09=09=09=09     devfn);
>  }
>=20
>  static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
>  =09=09=09      u8 pos, int cap)
>  {
> -=09int ttl =3D PCI_FIND_CAP_TTL;
> -
> -=09return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
> +=09return __pci_find_next_cap_ttl(bus, devfn, pos, cap);
>  }
>=20
>  u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
> @@ -555,42 +534,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
>   */
>  u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, int cap=
)
>  {
> -=09u32 header;
> -=09int ttl;
> -=09u16 pos =3D PCI_CFG_SPACE_SIZE;
> -
> -=09/* minimum 8 bytes per capability */
> -=09ttl =3D (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> -
>  =09if (dev->cfg_size <=3D PCI_CFG_SPACE_SIZE)
>  =09=09return 0;
>=20
> -=09if (start)
> -=09=09pos =3D start;
> -
> -=09if (pci_read_config_dword(dev, pos, &header) !=3D PCIBIOS_SUCCESSFUL)
> -=09=09return 0;
> -
> -=09/*
> -=09 * If we have no capabilities, this is indicated by cap ID,
> -=09 * cap version and next pointer all being 0.
> -=09 */
> -=09if (header =3D=3D 0)
> -=09=09return 0;
> -
> -=09while (ttl-- > 0) {
> -=09=09if (PCI_EXT_CAP_ID(header) =3D=3D cap && pos !=3D start)
> -=09=09=09return pos;
> -
> -=09=09pos =3D PCI_EXT_CAP_NEXT(header);
> -=09=09if (pos < PCI_CFG_SPACE_SIZE)
> -=09=09=09break;
> -
> -=09=09if (pci_read_config_dword(dev, pos, &header) !=3D
> PCIBIOS_SUCCESSFUL)
> -=09=09=09break;
> -=09}
> -
> -=09return 0;
> +=09return PCI_FIND_NEXT_EXT_CAPABILITY(pci_bus_read_config, start, cap,
> +=09=09=09=09=09    dev->bus, dev->devfn);
>  }
>  EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
>=20
> @@ -650,7 +598,7 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
>=20
>  static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap=
)
>  {
> -=09int rc, ttl =3D PCI_FIND_CAP_TTL;
> +=09int rc;
>  =09u8 cap, mask;
>=20
>  =09if (ht_cap =3D=3D HT_CAPTYPE_SLAVE || ht_cap =3D=3D HT_CAPTYPE_HOST)
> @@ -659,7 +607,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev,=
 u8
> pos, int ht_cap)
>  =09=09mask =3D HT_5BIT_CAP_MASK;
>=20
>  =09pos =3D __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
> -=09=09=09=09      PCI_CAP_ID_HT, &ttl);
> +=09=09=09=09      PCI_CAP_ID_HT);
>  =09while (pos) {
>  =09=09rc =3D pci_read_config_byte(dev, pos + 3, &cap);
>  =09=09if (rc !=3D PCIBIOS_SUCCESSFUL)
> @@ -670,7 +618,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev,=
 u8
> pos, int ht_cap)
>=20
>  =09=09pos =3D __pci_find_next_cap_ttl(dev->bus, dev->devfn,
>  =09=09=09=09=09      pos + PCI_CAP_LIST_NEXT,
> -=09=09=09=09=09      PCI_CAP_ID_HT, &ttl);
> +=09=09=09=09=09      PCI_CAP_ID_HT);
>  =09}
>=20
>  =09return 0;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6a7c88b9cd35..b204ebeeb1cf 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -2,7 +2,9 @@
>  #ifndef DRIVERS_PCI_H
>  #define DRIVERS_PCI_H
>=20
> +#include <linux/align.h>
>  #include <linux/pci.h>
> +#include <uapi/linux/pci_regs.h>
>=20
>  struct pcie_tlp_log;
>=20
> @@ -91,6 +93,90 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
>  int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 s=
ize,
>  =09=09=09u32 *val);
>=20
> +/* Standard Capability finder */
> +/**
> + * PCI_FIND_NEXT_CAP_TTL - Find a PCI standard capability
> + * @read_cfg: Function pointer for reading PCI config space
> + * @start: Starting position to begin search
> + * @cap: Capability ID to find
> + * @args: Arguments to pass to read_cfg function
> + *
> + * Iterates through the capability list in PCI config space to find
> + * the specified capability. Implements TTL (time-to-live) protection
> + * against infinite loops.
> + *
> + * Returns: Position of the capability if found, 0 otherwise.
> + */
> +#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)=09=09\
> +({=09=09=09=09=09=09=09=09=09\
> +=09int __ttl =3D PCI_FIND_CAP_TTL;=09=09=09=09=09\
> +=09u8 __id, __found_pos =3D 0;=09=09=09=09=09\
> +=09u8 __pos =3D (start);=09=09=09=09=09=09\
> +=09u16 __ent;=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09read_cfg(args, __pos, 1, (u32 *)&__pos);=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09while (__ttl--) {=09=09=09=09=09=09\
> +=09=09if (__pos < PCI_STD_HEADER_SIZEOF)=09=09=09\
> +=09=09=09break;=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09=09__pos =3D ALIGN_DOWN(__pos, 4);=09=09=09=09\
> +=09=09read_cfg(args, __pos, 2, (u32 *)&__ent);=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09=09__id =3D FIELD_GET(PCI_CAP_ID_MASK, __ent);=09=09\
> +=09=09if (__id =3D=3D 0xff)=09=09=09=09=09\
> +=09=09=09break;=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09=09if (__id =3D=3D (cap)) {=09=09=09=09=09\
> +=09=09=09__found_pos =3D __pos;=09=09=09=09\
> +=09=09=09break;=09=09=09=09=09=09\
> +=09=09}=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09=09__pos =3D FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);=09\
> +=09}=09=09=09=09=09=09=09=09\
> +=09__found_pos;=09=09=09=09=09=09=09\
> +})
> +
> +/* Extended Capability finder */
> +/**
> + * PCI_FIND_NEXT_EXT_CAPABILITY - Find a PCI extended capability
> + * @read_cfg: Function pointer for reading PCI config space
> + * @start: Starting position to begin search (0 for initial search)
> + * @cap: Extended capability ID to find
> + * @args: Arguments to pass to read_cfg function
> + *
> + * Searches the extended capability space in PCI config registers
> + * for the specified capability. Implements TTL protection against
> + * infinite loops using a calculated maximum search count.
> + *
> + * Returns: Position of the capability if found, 0 otherwise.
> + */
> +#define PCI_FIND_NEXT_EXT_CAPABILITY(read_cfg, start, cap, args...)
> \
> +({
> \
> +=09u16 __pos =3D (start) ?: PCI_CFG_SPACE_SIZE;
> \
> +=09u16 __found_pos =3D 0;
> \
> +=09int __ttl, __ret;
> \
> +=09u32 __header;
> \
> +
> \
> +=09__ttl =3D (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> \
> +=09while (__ttl-- > 0 && __pos >=3D PCI_CFG_SPACE_SIZE) {
> \
> +=09=09__ret =3D read_cfg(args, __pos, 4, &__header);
> \
> +=09=09if (__ret !=3D PCIBIOS_SUCCESSFUL)
> \
> +=09=09=09break;
> \
> +
> \
> +=09=09if (__header =3D=3D 0)
> \
> +=09=09=09break;
> \
> +
> \
> +=09=09if (PCI_EXT_CAP_ID(__header) =3D=3D (cap) && __pos !=3D start) {
> \
> +=09=09=09__found_pos =3D __pos;
> \
> +=09=09=09break;
> \
> +=09=09}
> \
> +
> \
> +=09=09__pos =3D PCI_EXT_CAP_NEXT(__header);
> \
> +=09}
> \
> +=09__found_pos;
> \
> +})
> +
>  /* Functions internal to the PCI core code */
>=20
>  #ifdef CONFIG_DMI
>=20
>=20
>=20
> Best regards,
> Hans
>=20
--8323328-830954236-1744045415=:936--

