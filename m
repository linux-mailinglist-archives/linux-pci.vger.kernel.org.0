Return-Path: <linux-pci+bounces-25013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F377A76C21
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 18:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9267188E02F
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2D5214A92;
	Mon, 31 Mar 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beprDTwe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C42214A93;
	Mon, 31 Mar 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439197; cv=none; b=jR8BK3mS5eOazmj7u6DykeciLt4qChNoX5Czjon2OdkBD5lJk2jp/RuMfY1dLO4vNjFFS7nG0nQnPomMRvrQBBNY+7t+XK3d4RLlyiG/ddc6jx3mAbDvOCkPAvhn8TdQ/dKjNt7wMbkxHQntXJa1YBLxbHH4NKKcu9qvDKlRc+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439197; c=relaxed/simple;
	bh=qXG5PHT6tlVlTcFTiHxE04VnFfN/PkHPJd2NMFps+zA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zi7D5pnpWKvKIzCJC6qJDqaNHJki15bC+Y0gydjbLrNS1AH9tm6FTygdPsjdieYWxDLbCVFbM+Vl8clFxJ8KFmacvcYwTbSJQJcaKUh21ZEJCAagDosFjQkkejzdtKdsdLBHVxecCdIaozY5svIVGnE/iZJE0mVqsChdPFxkK4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beprDTwe; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743439195; x=1774975195;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qXG5PHT6tlVlTcFTiHxE04VnFfN/PkHPJd2NMFps+zA=;
  b=beprDTwedgImqqfIM9x13wYMLXL//j7XvC0G5Oda6lbW0W7oO5P4xKL3
   Mx19Aek5XE35Vhshlbb+YXHylEk7m8XZ7GtrUgt7LTXf08ZXtT2x/H3io
   o7EnKmXQ3YdeIWCTx8DXriLn0oyFJy34TRs7WEVYvj8X2Sm+RSmT5EVJ7
   5myaG+7b8KyXaehvqHiidTmhDo5VdtFjbH/WWgOhDzjrpha2/Ch5ASDoz
   wlr3DDeJOyG0Pt4RkUUkHtjqqAgUbrApYAp9Sr7a3uAGwuimnSEYhLsr3
   Una6bBDVI79S3R9BHfEkPpY2vBYNdpoOuHnEon9kuSxEnw7089v2vpoRm
   A==;
X-CSE-ConnectionGUID: LluK6bFxQcqm4eXq/Il0IA==
X-CSE-MsgGUID: Rsa7BCJhTpOWCh/I31bh8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44446392"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="44446392"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 09:39:54 -0700
X-CSE-ConnectionGUID: AZ+j1FU3SpuqZ+iFZixnyQ==
X-CSE-MsgGUID: 1NmxkuvIQDm7hZfYnIR8Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="126599097"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 09:39:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 31 Mar 2025 19:39:48 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, lpieralisi@kernel.org, kw@linux.com, 
    robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
In-Reply-To: <95d9f7d9-6569-4252-a54d-cbe38ade706b@163.com>
Message-ID: <fc6bec19-fb1e-bff0-8676-ba2c1ca860df@linux.intel.com>
References: <20250323164852.430546-1-18255117159@163.com> <20250323164852.430546-4-18255117159@163.com> <f467056d-8d4a-9dab-2f0a-ca589adfde53@linux.intel.com> <d370b69a-3b70-4e3b-94a3-43e0bc1305cd@163.com> <a3462c68-ec1b-0b1a-fee7-612bd1109819@linux.intel.com>
 <3d9b2fa9-98bf-4f47-aa76-640a4f82cb2f@163.com> <26dcba54-93c1-dda4-c5e2-e324e9d50b09@linux.intel.com> <f2725090-e199-493d-9ae3-e807d65f647b@163.com> <de6ce71c-ba82-496e-9c72-7c9c61b37906@163.com> <ddabf340-a00f-75b1-2b6b-d9ab550a984f@linux.intel.com>
 <9118fcc0-e5a5-40f2-be4b-7e06b4b20601@163.com> <b279863e-8d8c-4c14-98ad-c19d26c69146@163.com> <0e493832-6292-10d7-6f87-ed190059c999@linux.intel.com> <95d9f7d9-6569-4252-a54d-cbe38ade706b@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1694204000-1743439188=:929"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1694204000-1743439188=:929
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 30 Mar 2025, Hans Zhang wrote:
> On 2025/3/28 19:42, Ilpo J=C3=A4rvinen wrote:
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 47b31ad724fa..0d5dfd010a01 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -1198,6 +1198,64 @@ void pci_sort_breadthfirst(void);
> > >=20
> > >   /* Generic PCI functions exported to card drivers */
> > >=20
> > > +/* Extended capability finder */
> > > +#define PCI_FIND_NEXT_CAP_TTL(priv, devfn, read_cfg, start, cap)    =
 \
> >=20
> > Please put it into drivers/pci/pci.h but other than that this is certai=
nly
> > to the direction I was suggesting.
>=20
> Hi Ilpo,
>=20
> I'm sorry for not replying to you in time. I tried to understand your
> suggestion, modify it, and then experiment on the actual SOC platform. Th=
ank
> you very much for your reply and patient advice.
>=20
> I'm going to put it in the drivers/pci/pci.h file.
>=20
> >=20
> > You don't need to have those priv and devfn there like that but you can
> > use the args... trick (see linux/iopoll.h) and put them as last paramet=
ers
> > to the macro so they can wary based on the caller needs, assuming args
> > will work like this, I've not tested:
> >=20
> > =09=09read_cfg(args, __pos, &val)
> >=20
>=20
> I have modified it in the following reply, but I only modify it like this=
 at
> present: read_cfg(args, __pos, size, &val)
>=20
> > The size parameter is the most annoying one as it's in between where an=
d
> > *val arguments so args... trick won't work for it. I suggest just
> > providing a function with the same signature as the related pci/access.=
c
> > function for now.
> >=20
>=20
> Currently DWC, CDNS, and pci.c seem to be unable to unify a common functi=
on to
> read config.
>=20
> I don't quite understand what you mean here. Is the current dw_pcie_read_=
cfg,
> cdns_pcie_read_cfg, __pci_bus_read_config correct? Please look at my late=
st
> modification. If it is not correct, please explain it again. Thank you ve=
ry
> much.

This was mostly me lamenting over the parameter order which makes the args=
=20
trick less efficient than it could be if the parameters would be in a=20
different order. The patch below looked okay to me.

> > A few nits related to the existing code quality of the cap parser funct=
ion
> > which should be addressed while we touch this function (probably in own
> > patches indepedent of this code move/rearrange patch itself).
> >=20
>=20
> I will revise it in my final submission. The following reply has been
> modified.


> > > +=09=09=09read_cfg((priv), (devfn), __pos, 2, (u32 *)&__ent); \
> > > +     \
> > > +=09=09=09__id =3D __ent & 0xff;                                \
> > > +=09=09=09if (__id =3D=3D 0xff)                                   \
> > > +=09=09=09=09break;                                      \
> > > +=09=09=09if (__id =3D=3D (cap)) {                                \
> > > +=09=09=09=09__found_pos =3D __pos;                        \
> > > +=09=09=09=09break;                                      \
> > > +=09=09=09}                                                   \
> > > +=09=09=09__pos =3D (__ent >> 8);                               \
> >=20
> > I'd add these into uapi/linux/pci_regs.h:
>=20
> This means that you will submit, and I will submit after you?
> Or should I submit this series of patches together?

I commented these cleanup opportunities so that you could add them to=20
your series. If I'd immediately start working on area/lines you're working=
=20
with, it would just trigger conflicts so it's better the original author=20
does the improvements within the series he/she is working with. It's a lot=
=20
less work for the maintainer that way :-).

> > #define PCI_CAP_ID_MASK=09=090x00ff
> > #define PCI_CAP_LIST_NEXT_MASK=090xff00
> >=20
> > And then use FIELD_GET() to extract the fields.
>=20
> It has been modified.
>=20
> >=20
> > > +=09=09}                                                           \
> > > +=09=09__found_pos;                                                \
> > > +=09})
> > > +
> > > +/* Extended capability finder */
> > > +#define PCI_FIND_NEXT_EXT_CAPABILITY(priv, devfn, read_cfg, start, c=
ap)
> > > \
> > > +=09({                                                               =
  \
> > > +=09=09u16 __pos =3D (start) ?: PCI_CFG_SPACE_SIZE;                 \
> > > +=09=09u16 __found_pos =3D 0;                                       \
> > > +=09=09int __ttl, __ret;                                          \
> > > +=09=09u32 __header;                                              \
> > > +    \
> > > +=09=09__ttl =3D (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8; \
> > > +=09=09while (__ttl-- > 0 && __pos >=3D PCI_CFG_SPACE_SIZE) {       \
> > > +=09=09=09__ret =3D read_cfg((priv), (devfn), __pos, 4,        \
> > > +=09=09=09=09=09 &__header);                       \
> > > +=09=09=09if (__ret !=3D PCIBIOS_SUCCESSFUL)                   \
> > > +=09=09=09=09break;                                     \
> > > +    \
> > > +=09=09=09if (__header =3D=3D 0)                                 \
> > > +=09=09=09=09break;                                     \
> > > +    \
> > > +=09=09=09if (PCI_EXT_CAP_ID(__header) =3D=3D (cap) &&           \
> > > +=09=09=09    __pos !=3D start) {                              \
> > > +=09=09=09=09__found_pos =3D __pos;                       \
> > > +=09=09=09=09break;                                     \
> > > +=09=09=09}                                                  \
> > > +    \
> > > +=09=09=09__pos =3D PCI_EXT_CAP_NEXT(__header);                \
> > > +=09=09}                                                          \
> > > +=09=09__found_pos;                                               \
> > > +=09})
> > > +
> > >   u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn,=
 int
> > > cap);
> > >   u8 pci_find_capability(struct pci_dev *dev, int cap);
> > >   u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
> >=20
> >=20
> > I started to wonder though if the controller drivers could simply creat=
e
> > an "early" struct pci_dev & pci_bus just so they can use the normal
> > accessors while the real structs are not yet created. It looks not
> > much is needed from those structs to let the accessors to work.
> >=20
>=20
> Here are a few questions:
> 1. We need to initialize some variables for pci_dev. For example,
> dev->cfg_size needs to be initialized to 4K for PCIe.
>=20
> u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, int cap)
> {
> =09......
> =09if (dev->cfg_size <=3D PCI_CFG_SPACE_SIZE)
> =09=09return 0;
> =09......
>=20

Sure, it would require some initialization of the struct (but not=20
full init like the probe path does that does lots of setup too).

> 2. Create an "early" struct pci_dev & pci_bus for each SOC vendor (Qcom,
> Rockchip, etc). It leads to a lot of code that feels weird.

The early pci_dev+pci_bus would be created by a helper in PCI core that=20
initializes what is necessary for the supported set of early core=20
functionality to work. The controller drivers themselves would just call=20
that function.

> I still prefer the approach we are discussing now.

I'm not saying we should immediately head toward this new idea within this=
=20
series because it's going to be relatively big change. But it's certainly=
=20
something that looks worth exploring so that the current chicken-egg=20
problem with controller drivers could be solved.

> This is a modified patchs based on your suggestion:
>=20
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c
> b/drivers/pci/controller/cadence/pcie-cadence.c
> index 204e045aed8c..3991cc4c58d6 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -7,6 +7,32 @@
>  #include <linux/of.h>
>=20
>  #include "pcie-cadence.h"
> +#include "../../pci.h"
> +
> +static int cdns_pcie_read_cfg(void *priv, int where, int size, u32 *val)
> +{
> +=09struct cdns_pcie *pcie =3D priv;
> +
> +=09if (size =3D=3D 4)
> +=09=09*val =3D cdns_pcie_readl(pcie, where);
> +=09else if (size =3D=3D 2)
> +=09=09*val =3D cdns_pcie_readw(pcie, where);
> +=09else if (size =3D=3D 1)
> +=09=09*val =3D cdns_pcie_readb(pcie, where);
> +
> +=09return PCIBIOS_SUCCESSFUL;
> +}
> +
> +u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
> +{
> +=09return PCI_FIND_NEXT_CAP_TTL(cdns_pcie_read_cfg, PCI_CAPABILITY_LIST,
> +=09=09=09=09     cap, pcie);
> +}
> +
> +u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
> +{
> +=09return PCI_FIND_NEXT_EXT_CAPABILITY(cdns_pcie_read_cfg, 0, cap, pcie)=
;
> +}
>=20
>  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
>  {
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h
> b/drivers/pci/controller/cadence/pcie-cadence.h
> index f5eeff834ec1..dd7cb6b6b291 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -398,6 +398,16 @@ static inline u32 cdns_pcie_readl(struct cdns_pcie *=
pcie,
> u32 reg)
>  =09return readl(pcie->reg_base + reg);
>  }
>=20
> +static inline u32 cdns_pcie_readw(struct cdns_pcie *pcie, u32 reg)
> +{
> +=09return readw(pcie->reg_base + reg);
> +}
> +
> +static inline u32 cdns_pcie_readb(struct cdns_pcie *pcie, u32 reg)
> +{
> +=09return readb(pcie->reg_base + reg);
> +}
> +
>  static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
>  {
>  =09void __iomem *aligned_addr =3D PTR_ALIGN_DOWN(addr, 0x4);
> @@ -557,6 +567,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie=
_ep
> *ep)
>  }
>  #endif
>=20
> +u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
> +u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
> +
>  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
>=20
>  void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 =
fn,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> b/drivers/pci/controller/dwc/pcie-designware.c
> index 145e7f579072..e9a9a80b1085 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -203,83 +203,25 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
>  =09=09pci->type =3D ver;
>  }
>=20
> -/*
> - * These interfaces resemble the pci_find_*capability() interfaces, but =
these
> - * are for configuring host controllers, which are bridges *to* PCI devi=
ces
> but
> - * are not PCI devices themselves.
> - */
> -static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
> -=09=09=09=09  u8 cap)
> +static int dw_pcie_read_cfg(void *priv, int where, int size, u32 *val)
>  {
> -=09u8 cap_id, next_cap_ptr;
> -=09u16 reg;
> -
> -=09if (!cap_ptr)
> -=09=09return 0;
> -
> -=09reg =3D dw_pcie_readw_dbi(pci, cap_ptr);
> -=09cap_id =3D (reg & 0x00ff);
> -
> -=09if (cap_id > PCI_CAP_ID_MAX)
> -=09=09return 0;
> +=09struct dw_pcie *pcie =3D priv;
>=20
> -=09if (cap_id =3D=3D cap)
> -=09=09return cap_ptr;
> +=09*val =3D dw_pcie_read_dbi(pcie, where, size);
>=20
> -=09next_cap_ptr =3D (reg & 0xff00) >> 8;
> -=09return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
> +=09return PCIBIOS_SUCCESSFUL;
>  }
>=20
>  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>  {
> -=09u8 next_cap_ptr;
> -=09u16 reg;
> -
> -=09reg =3D dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
> -=09next_cap_ptr =3D (reg & 0x00ff);
> -
> -=09return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
> +=09return PCI_FIND_NEXT_CAP_TTL(dw_pcie_read_cfg, PCI_CAPABILITY_LIST,
> cap,
> +=09=09=09=09     pcie);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
>=20
> -static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 sta=
rt,
> -=09=09=09=09=09    u8 cap)
> -{
> -=09u32 header;
> -=09int ttl;
> -=09int pos =3D PCI_CFG_SPACE_SIZE;
> -
> -=09/* minimum 8 bytes per capability */
> -=09ttl =3D (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> -
> -=09if (start)
> -=09=09pos =3D start;
> -
> -=09header =3D dw_pcie_readl_dbi(pci, pos);
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
> -=09=09header =3D dw_pcie_readl_dbi(pci, pos);
> -=09}
> -
> -=09return 0;
> -}
> -
>  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
>  {
> -=09return dw_pcie_find_next_ext_capability(pci, 0, cap);
> +=09return PCI_FIND_NEXT_EXT_CAPABILITY(dw_pcie_read_cfg, 0, cap, pcie);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..778e366ea72e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -423,28 +423,28 @@ static int pci_dev_str_match(struct pci_dev *dev, c=
onst
> char *p,
>  =09return 1;
>  }
>=20
> -static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devf=
n,
> -=09=09=09=09  u8 pos, int cap, int *ttl)
> +static int __pci_bus_read_config(void *priv, unsigned int devfn, int whe=
re,
> +=09=09=09=09 u32 size, u32 *val)
>  {
> -=09u8 id;
> -=09u16 ent;
> +=09struct pci_bus *bus =3D priv;
> +=09int ret;
>=20
> -=09pci_bus_read_config_byte(bus, devfn, pos, &pos);
> +=09if (size =3D=3D 1)
> +=09=09ret =3D pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> +=09else if (size =3D=3D 2)
> +=09=09ret =3D pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
> +=09else
> +=09=09ret =3D pci_bus_read_config_dword(bus, devfn, where, val);
>=20
> -=09while ((*ttl)--) {
> -=09=09if (pos < 0x40)
> -=09=09=09break;
> -=09=09pos &=3D ~3;
> -=09=09pci_bus_read_config_word(bus, devfn, pos, &ent);
> +=09return ret;
> +}
>=20
> -=09=09id =3D ent & 0xff;
> -=09=09if (id =3D=3D 0xff)
> -=09=09=09break;
> -=09=09if (id =3D=3D cap)
> -=09=09=09return pos;
> -=09=09pos =3D (ent >> 8);
> -=09}
> -=09return 0;
> +static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devf=
n,
> +=09=09=09=09  u8 pos, int cap, int *ttl)
> +{
> +=09// If accepted, I will remove all use of "int *ttl" in a future patch=
=2E
> +=09return PCI_FIND_NEXT_CAP_TTL(__pci_bus_read_config, pos, cap, bus,
> +=09=09=09=09     devfn);
>  }
>=20
>  static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
> @@ -553,42 +553,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
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
> +=09return PCI_FIND_NEXT_EXT_CAPABILITY(__pci_bus_read_config, start, cap=
,
> +=09=09=09=09=09    dev->bus, dev->devfn);
>  }
>  EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e9cf26a9ee9..68c111be521d 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -4,6 +4,65 @@
>=20
>  #include <linux/pci.h>

Make sure to add the necessary headers for the function/macros you're=20
using so that things won't depend on the #include order in the .c file.

>=20
> +/* Ilpo: I'd add these into uapi/linux/pci_regs.h: */
> +#define PCI_CAP_ID_MASK=09=090x00ff
> +#define PCI_CAP_LIST_NEXT_MASK=090xff00
> +
> +/* Standard capability finder */

Capability

Always use the same capitalization as the specs do.

You should probably write a kernel doc for this macro too.

I'd put these macro around where pcie_cap_has_*() forward declarations=20
are so that the initial define block is not split.

> +#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)=09=09\
> +({=09=09=09=09=09=09=09=09=09\
> +=09u8 __pos =3D (start);=09=09=09=09=09=09\
> +=09int __ttl =3D PCI_FIND_CAP_TTL;=09=09=09=09=09\
> +=09u16 __ent;=09=09=09=09=09=09=09\
> +=09u8 __found_pos =3D 0;=09=09=09=09=09=09\
> +=09u8 __id;=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09read_cfg(args, __pos, 1, (u32 *)&__pos);=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09while (__ttl--) {=09=09=09=09=09=09\
> +=09=09if (__pos < PCI_STD_HEADER_SIZEOF)=09=09=09\
> +=09=09=09break;=09=09=09=09=09=09\
> +=09=09__pos =3D ALIGN_DOWN(__pos, 4);=09=09=09=09\
> +=09=09read_cfg(args, __pos, 2, (u32 *)&__ent);=09=09\
> +=09=09__id =3D FIELD_GET(PCI_CAP_ID_MASK, __ent);=09=09\
> +=09=09if (__id =3D=3D 0xff)=09=09=09=09=09\
> +=09=09=09break;=09=09=09=09=09=09\
> +=09=09if (__id =3D=3D (cap)) {=09=09=09=09=09\
> +=09=09=09__found_pos =3D __pos;=09=09=09=09\
> +=09=09=09break;=09=09=09=09=09=09\
> +=09=09}=09=09=09=09=09=09=09\
> +=09=09__pos =3D FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);=09\
> +=09}=09=09=09=09=09=09=09=09\
> +=09__found_pos;=09=09=09=09=09=09=09\
> +})
> +
> +/* Extended capability finder */
> +#define PCI_FIND_NEXT_EXT_CAPABILITY(read_cfg, start, cap, args...)=09\
> +({=09=09=09=09=09=09=09=09=09\
> +=09u16 __pos =3D (start) ?: PCI_CFG_SPACE_SIZE;=09=09=09\
> +=09u16 __found_pos =3D 0;=09=09=09=09=09=09\
> +=09int __ttl, __ret;=09=09=09=09=09=09\
> +=09u32 __header;=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09__ttl =3D (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;=09\
> +=09while (__ttl-- > 0 && __pos >=3D PCI_CFG_SPACE_SIZE) {=09=09\
> +=09=09__ret =3D read_cfg(args, __pos, 4, &__header);=09=09\
> +=09=09if (__ret !=3D PCIBIOS_SUCCESSFUL)=09=09=09\
> +=09=09=09break;=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09=09if (__header =3D=3D 0)=09=09=09=09=09\
> +=09=09=09break;=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09=09if (PCI_EXT_CAP_ID(__header) =3D=3D (cap) && __pos !=3D start) {\
> +=09=09=09__found_pos =3D __pos;=09=09=09=09\
> +=09=09=09break;=09=09=09=09=09=09\
> +=09=09}=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09=09__pos =3D PCI_EXT_CAP_NEXT(__header);=09=09=09\
> +=09}=09=09=09=09=09=09=09=09\
> +=09__found_pos;=09=09=09=09=09=09=09\
> +})
> +
>  struct pcie_tlp_log;
>=20
>  /* Number of possible devfns: 0.0 to 1f.7 inclusive */
>=20
>=20
> Looking forward to your latest suggestions.

This generally looked good, I didn't read with a very fine comb but just=20
focused on the important bits. I'll take a more detailed look once you=20
make the official submission.

--=20
 i.

--8323328-1694204000-1743439188=:929--

