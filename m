Return-Path: <linux-pci+bounces-15307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C59B044E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 15:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1A61C21AC3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775781632E2;
	Fri, 25 Oct 2024 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzUt3tKJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4C1F7566;
	Fri, 25 Oct 2024 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863573; cv=none; b=OIj3Y4GPZWvdjEJO1HMmv5F4rUa/bW8fROhlJ/tl5gvX2VDShThgX8huBbnBZe6GmiMwEI1Rk3AFmtoWkHbZVwT0hgLN9ea2pWeIAGAJu92BWzvXBU/Sxb3OduD9whWGaBrj5lIBKNF4BCLtbkkmWxC5ekKdAawIq/HgLPw/QKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863573; c=relaxed/simple;
	bh=/HnzH8LIxgCAWX0/LLh1puQjwqcQ1NSbusIo7Y2Mm3Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gu2G+DRsc/IDw/hI/yWgdzXNE6/dQ7fZkL9yPY3JaeUb0WyF/L1EJe8pDJ3o31w2qMRWD4he0UO9BTSGQftLYoOkWd3hOA9C+mG4R8q0xVRlWAJweAxGPS/MxXwVf7vpF65TVf0jrGQtbgVY3xyL0NqL9Vqva0EeNgQmMrQpPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzUt3tKJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729863571; x=1761399571;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/HnzH8LIxgCAWX0/LLh1puQjwqcQ1NSbusIo7Y2Mm3Q=;
  b=TzUt3tKJKFyWLwOZpsSNOr/CnNVKenZRKHG7W7CnzmIvtePLpj65CEuU
   i4u/9oKhYKSrhXR/JTgJHIcyNSgqvDtCrYYWdGpQTkJPZxZITte1aymn8
   STXIxnuchSQd/hrem4IxS7CRquATMxqGrmJIvg2frEEIFa4qI7O+0VKrd
   UUkPIbkGLiB9X9jAg6EeXYkzSpxAQl3fcDpOU6hFU505upV33xK7C+Cc9
   /7YDBgL5qNQSRaWNZ+O50IhUirpZXMsEqTajvWj8Bx/7y5ZDs/ChO9aMc
   4YFLLhUE9E23MS5lPKBSydenv0cT8kXujCpplEglmYBWV1Ide7PwAZkwi
   Q==;
X-CSE-ConnectionGUID: uVvo5VE1Q9egw6uoeGAbIA==
X-CSE-MsgGUID: 8uQtQPinRPihbf92JuzMWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33229180"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33229180"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:39:30 -0700
X-CSE-ConnectionGUID: 2L9XHif8SVm9IHuMKA3KaQ==
X-CSE-MsgGUID: m60xT2EDQUCcPtzhB4axHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="111752941"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:39:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Oct 2024 16:39:21 +0300 (EEST)
To: Yazen Ghannam <yazen.ghannam@amd.com>
cc: linux-edac@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com, 
    john.allen@amd.com, mario.limonciello@amd.com, bhelgaas@google.com, 
    Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com, 
    linux@roeck-us.net, clemens@ladisch.de, 
    Hans de Goede <hdegoede@redhat.com>, linux-pci@vger.kernel.org, 
    linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 14/16] x86/amd_smn, platform/x86/amd/hsmp: Have HSMP use
 SMN
In-Reply-To: <20241024160625.GC965@yaz-khff2.amd.com>
Message-ID: <d44f45c1-a550-de07-d1fa-91dfe0adb47f@linux.intel.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com> <20241023172150.659002-15-yazen.ghannam@amd.com> <2797ecc5-935d-21a2-bb43-273a7eae3a12@linux.intel.com> <20241024160625.GC965@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-983401245-1729863561=:946"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-983401245-1729863561=:946
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Oct 2024, Yazen Ghannam wrote:

> On Thu, Oct 24, 2024 at 04:23:55PM +0300, Ilpo J=E4rvinen wrote:
> > On Wed, 23 Oct 2024, Yazen Ghannam wrote:
> >=20
> > > The HSMP interface is just an SMN interface with different offsets.
> > >=20
> > > Define an HSMP wrapper in the SMN code and have the HSMP platform dri=
ver
> > > use that rather than a local solution.
> > >=20
> > > Also, remove the "root" member from AMD_NB, since there are no more
> > > users of it.
> > >=20
> > > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > > ---
> > >  arch/x86/include/asm/amd_nb.h    |  1 -
> > >  arch/x86/include/asm/amd_smn.h   |  3 +++
> > >  arch/x86/kernel/amd_nb.c         |  1 -
> > >  arch/x86/kernel/amd_smn.c        |  9 +++++++++
> > >  drivers/platform/x86/amd/Kconfig |  2 +-
> > >  drivers/platform/x86/amd/hsmp.c  | 32 +++++-------------------------=
--
> > >  6 files changed, 18 insertions(+), 30 deletions(-)
> > >=20
> > > diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd=
_nb.h
> > > index 55c03d3495bc..cbe31e316e39 100644
> > > --- a/arch/x86/include/asm/amd_nb.h
> > > +++ b/arch/x86/include/asm/amd_nb.h
> > > @@ -27,7 +27,6 @@ struct amd_l3_cache {
> > >  };
> > > =20
> > >  struct amd_northbridge {
> > > -=09struct pci_dev *root;
> > >  =09struct pci_dev *misc;
> > >  =09struct pci_dev *link;
> > >  =09struct amd_l3_cache l3_cache;
> > > diff --git a/arch/x86/include/asm/amd_smn.h b/arch/x86/include/asm/am=
d_smn.h
> > > index 6850de69f863..f0eb12859c42 100644
> > > --- a/arch/x86/include/asm/amd_smn.h
> > > +++ b/arch/x86/include/asm/amd_smn.h
> > > @@ -8,4 +8,7 @@
> > >  int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
> > >  int __must_check amd_smn_write(u16 node, u32 address, u32 value);
> > > =20
> > > +/* Should only be used by the HSMP driver. */
> > > +int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value=
, bool write);
> > > +
> > >  #endif /* _ASM_X86_AMD_SMN_H */
> > > diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> > > index 10cdeddeda02..4c22317a6dfe 100644
> > > --- a/arch/x86/kernel/amd_nb.c
> > > +++ b/arch/x86/kernel/amd_nb.c
> > > @@ -73,7 +73,6 @@ static int amd_cache_northbridges(void)
> > >  =09amd_northbridges.nb =3D nb;
> > > =20
> > >  =09for (i =3D 0; i < amd_northbridges.num; i++) {
> > > -=09=09node_to_amd_nb(i)->root =3D amd_node_get_root(i);
> > >  =09=09node_to_amd_nb(i)->misc =3D amd_node_get_func(i, 3);
> > >  =09=09node_to_amd_nb(i)->link =3D amd_node_get_func(i, 4);
> > >  =09}
> > > diff --git a/arch/x86/kernel/amd_smn.c b/arch/x86/kernel/amd_smn.c
> > > index 997fd3edd9c0..527dda8e3a2b 100644
> > > --- a/arch/x86/kernel/amd_smn.c
> > > +++ b/arch/x86/kernel/amd_smn.c
> > > @@ -18,6 +18,9 @@ static DEFINE_MUTEX(smn_mutex);
> > >  #define SMN_INDEX_OFFSET=090x60
> > >  #define SMN_DATA_OFFSET=09=090x64
> > > =20
> > > +#define HSMP_INDEX_OFFSET=090xc4
> > > +#define HSMP_DATA_OFFSET=090xc8
> > > +
> > >  /*
> > >   * SMN accesses may fail in ways that are difficult to detect here i=
n the called
> > >   * functions amd_smn_read() and amd_smn_write(). Therefore, callers =
must do
> > > @@ -100,6 +103,12 @@ int __must_check amd_smn_write(u16 node, u32 add=
ress, u32 value)
> > >  }
> > >  EXPORT_SYMBOL_GPL(amd_smn_write);
> > > =20
> > > +int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value=
, bool write)
> > > +{
> > > +=09return __amd_smn_rw(HSMP_INDEX_OFFSET, HSMP_DATA_OFFSET, node, ad=
dress, value, write);
> > > +}
> > > +EXPORT_SYMBOL_GPL(amd_smn_hsmp_rdwr);
> > > +
> > >  static int amd_cache_roots(void)
> > >  {
> > >  =09u16 node, num_nodes =3D amd_num_nodes();
> > > diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/=
amd/Kconfig
> > > index f88682d36447..e100b315c62b 100644
> > > --- a/drivers/platform/x86/amd/Kconfig
> > > +++ b/drivers/platform/x86/amd/Kconfig
> > > @@ -8,7 +8,7 @@ source "drivers/platform/x86/amd/pmc/Kconfig"
> > > =20
> > >  config AMD_HSMP
> > >  =09tristate "AMD HSMP Driver"
> > > -=09depends on AMD_NB && X86_64 && ACPI
> > > +=09depends on AMD_SMN && X86_64 && ACPI
> > >  =09help
> > >  =09  The driver provides a way for user space tools to monitor and m=
anage
> > >  =09  system management functionality on EPYC server CPUs from AMD.
> > > diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/a=
md/hsmp.c
> > > index 8fcf38eed7f0..544efb0255c0 100644
> > > --- a/drivers/platform/x86/amd/hsmp.c
> > > +++ b/drivers/platform/x86/amd/hsmp.c
> >=20
> > FYI, there has been major restructuring done for this driver in=20
> > pdx86/for-next.
> >
>=20
> Yep, no problem. I can rebase these changes on top of those.
>=20
> Any comments on the general approach?

I deemed looking deeper into the patch waste of my time due to the=20
expected changes, so no comments at this time.

--=20
 i.

--8323328-983401245-1729863561=:946--

