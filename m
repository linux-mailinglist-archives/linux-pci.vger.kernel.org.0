Return-Path: <linux-pci+bounces-24537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21761A6DD72
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 15:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0514D3B06DB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9234625E81A;
	Mon, 24 Mar 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhiBnJHV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263332E3366;
	Mon, 24 Mar 2025 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827942; cv=none; b=DPKZ+Z4us91+STDbGlY7KLR28KZ5/7Qggd7pIboUT+NGDF45n8eap5IAK0Ms9jn9tqCCTjWXkPCo8bDCQ58PgxKQHON3n+5hf+eTc7hzug4f6BGBF5i3sHt1vjJ2c+DWi+zj9i4ECqhpvKq3q597B1rQ0me3DuCtBxA2N500rBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827942; c=relaxed/simple;
	bh=QnTAv60/5/hw0d1Arp04mU2s9WavB8mo3z60p0fv7LY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sbmSBhAFr28odTQMo89hdKbgMgqccT1u/VMjALCL89PdSGuKP2wQiA8GmdIIaHoAYGqm+ACGmC5gBDJc3az3QteEWSS3ZqE+F0TmRw1N5mu0o45cx5hNyP0sh5Rl4ORlOjvMRzt6qiO1UgB04AKYonNLMOajdfAwwGO2bl2R/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhiBnJHV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742827941; x=1774363941;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=QnTAv60/5/hw0d1Arp04mU2s9WavB8mo3z60p0fv7LY=;
  b=bhiBnJHVrMON2O7TL9mmWzyf/f7J4pr+mwkXChFKGphXcr2jMJk1fpys
   TLPfljkmDwXZBj1xZYpfK014uy6Ca35AoFZt4SPjhc2cRYZDUdGChwKDv
   VwzBNqn5VFbmnmG+VYSuPI+3tYEO9+EPjqTyLKPGVrQWsOu8W1kufCD72
   rw4+IswI01tZBSezkWs0YDWUwoh/MYzMhphUB+4Hv7B3oUlr0lCcTizFT
   1yP57v+qiIVWtsKF+N2UEvSvZkvjIaehk15hRw+Kt4G8nDmnOCBy+MSel
   T1e3jYmMR0y8BQBds0/scPB+7/IQ+kajYezDe6CrmXq3eerESv6Mk0sxb
   w==;
X-CSE-ConnectionGUID: KW0IIdOzQPW3PnymBPuvVg==
X-CSE-MsgGUID: 6vJDBc60SuaIJg6vxh1vQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43192740"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="43192740"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 07:52:15 -0700
X-CSE-ConnectionGUID: R5K74Hi9R5SMKL98YhGPeA==
X-CSE-MsgGUID: JohHAexBT1+PvcGBTTWQZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124232088"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.251])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 07:52:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Mar 2025 16:52:00 +0200 (EET)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
    thomas.richard@bootlin.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v6 1/5] PCI: Introduce generic capability search functions
In-Reply-To: <b846123d-a161-4380-b7c7-24d7066f8d25@163.com>
Message-ID: <1846e0b6-e743-f743-b972-723ee81fd434@linux.intel.com>
References: <20250323164852.430546-1-18255117159@163.com> <20250323164852.430546-2-18255117159@163.com> <f89f3d00-4423-f65d-293e-8aec3be14418@linux.intel.com> <b846123d-a161-4380-b7c7-24d7066f8d25@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-734090953-1742827405=:1100"
Content-ID: <7331034a-f0f5-d770-0e1d-50c40594bb48@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-734090953-1742827405=:1100
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <4d2eba8b-16d9-5f4a-ced4-149830c157a3@linux.intel.com>

On Mon, 24 Mar 2025, Hans Zhang wrote:
> On 2025/3/24 21:28, Ilpo J=E4rvinen wrote:
> > On Mon, 24 Mar 2025, Hans Zhang wrote:
> >=20
> > > Existing controller drivers (e.g., DWC, custom out-of-tree drivers)
> > > duplicate logic for scanning PCI capability lists. This creates
> > > maintenance burdens and risks inconsistencies.
> > >=20
> > > To resolve this:
> > >=20
> > > Add pci_host_bridge_find_*capability() in pci-host-helpers.c, accepti=
ng
> > > controller-specific read functions and device data as parameters.
> > >=20
> > > This approach:
> > > - Centralizes critical PCI capability scanning logic
> > > - Allows flexible adaptation to varied hardware access methods
> > > - Reduces future maintenance overhead
> > > - Aligns with kernel code reuse best practices
> > >=20
> > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > ---
> > > Changes since v5:
> > > https://lore.kernel.org/linux-pci/20250321163803.391056-2-18255117159=
@163.com
> > >=20
> > > - If you put the helpers in drivers/pci/pci.c, they unnecessarily enl=
arge
> > >    the kernel's .text section even if it's known already at compile t=
ime
> > >    that they're never going to be used (e.g. on x86).
> > >=20
> > > - Move the API for find capabilitys to a new file called
> > >    pci-host-helpers.c.
> > >=20
> > > Changes since v4:
> > > https://lore.kernel.org/linux-pci/20250321101710.371480-2-18255117159=
@163.com
> > >=20
> > > - Resolved [v4 1/4] compilation warning.
> > > - The patch commit message were modified.
> > > ---
> > >   drivers/pci/controller/Kconfig            | 17 ++++
> > >   drivers/pci/controller/Makefile           |  1 +
> > >   drivers/pci/controller/pci-host-helpers.c | 98 ++++++++++++++++++++=
+++
> > >   drivers/pci/pci.h                         |  7 ++
> > >   4 files changed, 123 insertions(+)
> > >   create mode 100644 drivers/pci/controller/pci-host-helpers.c
> > >=20
> > > diff --git a/drivers/pci/controller/Kconfig
> > > b/drivers/pci/controller/Kconfig
> > > index 9800b7681054..0020a892a55b 100644
> > > --- a/drivers/pci/controller/Kconfig
> > > +++ b/drivers/pci/controller/Kconfig
> > > @@ -132,6 +132,23 @@ config PCI_HOST_GENERIC
> > >   =09  Say Y here if you want to support a simple generic PCI host
> > >   =09  controller, such as the one emulated by kvmtool.
> > >   +config PCI_HOST_HELPERS
> > > +=09bool
> > > +=09prompt "PCI Host Controller Helper Functions" if EXPERT
> > > + =09help
> > > +=09  This provides common infrastructure for PCI host controller dri=
vers
> > > to
> > > +=09  handle PCI capability scanning and other shared operations. The
> > > helper
> > > +=09  functions eliminate code duplication across controller drivers.
> > > +
> > > +=09  These functions are used by PCI controller drivers that need to=
 scan
> > > +=09  PCI capabilities using controller-specific access methods (e.g.=
 when
> > > +=09  the controller is behind a non-standard configuration space).
> > > +
> > > +=09  If you are using any PCI host controller drivers that require t=
hese
> > > +=09  helpers (such as DesignWare, Cadence, etc), this will be
> > > +=09  automatically selected. Say N unless you are developing a custo=
m PCI
> > > +=09  host controller driver.
> >=20
> > Hi,
> >=20
> > Does this need to be user selectable at all? What's the benefit? If
> > somebody is developing a driver, they can just as well add the select
> > clause in that driver to get it built.
> >=20
>=20
> Dear Ilpo,
>=20
> Thanks your for reply. Only DWC and CDNS drivers are used here, what do y=
ou
> suggest should be done?

Just make it only Kconfig select'able and not user selectable at all.

> > > +
> > >   config PCIE_HISI_ERR
> > >   =09depends on ACPI_APEI_GHES && (ARM64 || COMPILE_TEST)
> > >   =09bool "HiSilicon HIP PCIe controller error handling driver"
> > > diff --git a/drivers/pci/controller/Makefile
> > > b/drivers/pci/controller/Makefile
> > > index 038ccbd9e3ba..e80091eb7597 100644
> > > --- a/drivers/pci/controller/Makefile
> > > +++ b/drivers/pci/controller/Makefile
> > > @@ -12,6 +12,7 @@ obj-$(CONFIG_PCIE_RCAR_HOST) +=3D pcie-rcar.o
> > > pcie-rcar-host.o
> > >   obj-$(CONFIG_PCIE_RCAR_EP) +=3D pcie-rcar.o pcie-rcar-ep.o
> > >   obj-$(CONFIG_PCI_HOST_COMMON) +=3D pci-host-common.o
> > >   obj-$(CONFIG_PCI_HOST_GENERIC) +=3D pci-host-generic.o
> > > +obj-$(CONFIG_PCI_HOST_HELPERS) +=3D pci-host-helpers.o
> > >   obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) +=3D pci-thunder-ecam.o
> > >   obj-$(CONFIG_PCI_HOST_THUNDER_PEM) +=3D pci-thunder-pem.o
> > >   obj-$(CONFIG_PCIE_XILINX) +=3D pcie-xilinx.o
> > > diff --git a/drivers/pci/controller/pci-host-helpers.c
> > > b/drivers/pci/controller/pci-host-helpers.c
> > > new file mode 100644
> > > index 000000000000..cd261a281c60
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/pci-host-helpers.c
> > > @@ -0,0 +1,98 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * PCI Host Controller Helper Functions
> > > + *
> > > + * Copyright (C) 2025 Hans Zhang
> > > + *
> > > + * Author: Hans Zhang <18255117159@163.com>
> > > + */
> > > +
> > > +#include <linux/pci.h>
> > > +
> > > +#include "../pci.h"
> > > +
> > > +/*
> > > + * These interfaces resemble the pci_find_*capability() interfaces, =
but
> > > these
> > > + * are for configuring host controllers, which are bridges *to* PCI
> > > devices but
> > > + * are not PCI devices themselves.
> > > + */
> > > +static u8 __pci_host_bridge_find_next_cap(void *priv,
> > > +=09=09=09=09=09  pci_host_bridge_read_cfg read_cfg,
> > > +=09=09=09=09=09  u8 cap_ptr, u8 cap)
> > > +{
> > > +=09u8 cap_id, next_cap_ptr;
> > > +=09u16 reg;
> > > +
> > > +=09if (!cap_ptr)
> > > +=09=09return 0;
> > > +
> > > +=09reg =3D read_cfg(priv, cap_ptr, 2);
> > > +=09cap_id =3D (reg & 0x00ff);
> > > +
> > > +=09if (cap_id > PCI_CAP_ID_MAX)
> > > +=09=09return 0;
> > > +
> > > +=09if (cap_id =3D=3D cap)
> > > +=09=09return cap_ptr;
> > > +
> > > +=09next_cap_ptr =3D (reg & 0xff00) >> 8;
> > > +=09return __pci_host_bridge_find_next_cap(priv, read_cfg, next_cap_p=
tr,
> > > +=09=09=09=09=09       cap);
> >=20
> > This is doing (tail) recursion?? Why??
> >=20
> > What should be done, IMO, is that code in __pci_find_next_cap_ttl()
> > refactored such that it can be reused instead of duplicating it in a
> > slightly different form here and the functions below.
> >=20
> > The capability list parser should be the same?
> >=20
>=20
> The original function is in the following file:
> drivers/pci/controller/dwc/pcie-designware.c
> u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
> u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
>=20
> CDNS has the same need to find the offset of the capability.
>=20
> We don't have pci_dev before calling pci_host_probe, but we want to get t=
he
> offset of the capability and configure some registers to initialize the r=
oot
> port. Therefore, the __pci_find_next_cap_ttl function cannot be used. Thi=
s is
> also the purpose of dw_pcie_find_*capability.

__pci_find_next_cap_ttl() does not take pci_dev so I'm unsure if the=20
problem is real or not?!?

> The CDNS driver does not have a cdns_pcie_find_*capability function.
> Therefore, separate the find capability, and then DWC and CDNS can be use=
d at
> the same time to reduce duplicate code.
>=20
>=20
> Communication history:
>=20
> Bjorn HelgaasMarch 14, 2025, 8:31 p.m. UTC | #8
> On Fri, Mar 14, 2025 at 06:35:11PM +0530, Manivannan Sadhasivam wrote:
> > ...
>=20
> > Even though this patch is mostly for an out of tree controller
> > driver which is not going to be upstreamed, the patch itself is
> > serving some purpose. I really like to avoid the hardcoded offsets
> > wherever possible. So I'm in favor of this patch.
> >
> > However, these newly introduced functions are a duplicated version
> > of DWC functions. So we will end up with duplicated functions in
> > multiple places. I'd like them to be moved (both this and DWC) to
> > drivers/pci/pci.c if possible. The generic function
> > *_find_capability() can accept the controller specific readl/ readw
> > APIs and the controller specific private data.
>=20
> I agree, it would be really nice to share this code.
>=20
> It looks a little messy to deal with passing around pointers to
> controller read ops, and we'll still end up with a lot of duplicated
> code between __pci_find_next_cap() and __cdns_pcie_find_next_cap(),
> etc.
>=20
> Maybe someday we'll make a generic way to access non-PCI "config"
> space like this host controller space and PCIe RCRBs.
>=20
> Or if you add interfaces that accept read/write ops, maybe the
> existing pci_find_capability() etc could be refactored on top of them
> by passing in pci_bus_read_config_word() as the accessor.

At minimum, the loop in __pci_find_next_cap_ttl() could be turned into a=20
macro similar to eg. read_poll_timeout() that takes the read function as=20
an argument (read_poll_timeout() looks messy because it doesn't align=20
backslashed to far right). That would avoid duplicating the parsing logic
on C code level.

> > > +}
> > > +
> > > +u8 pci_host_bridge_find_capability(void *priv,
> > > +=09=09=09=09   pci_host_bridge_read_cfg read_cfg, u8 cap)
> > > +{
> > > +=09u8 next_cap_ptr;
> > > +=09u16 reg;
> > > +
> > > +=09reg =3D read_cfg(priv, PCI_CAPABILITY_LIST, 2);
> > > +=09next_cap_ptr =3D (reg & 0x00ff);
> > > +
> > > +=09return __pci_host_bridge_find_next_cap(priv, read_cfg, next_cap_p=
tr,
> > > +=09=09=09=09=09       cap);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_host_bridge_find_capability);
>=20
>=20
> Best regards,
> Hans
>=20

--=20
 i.
--8323328-734090953-1742827405=:1100--

