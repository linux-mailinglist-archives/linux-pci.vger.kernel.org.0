Return-Path: <linux-pci+bounces-24934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFE2A7495D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 12:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4004172561
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 11:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FA121ABA6;
	Fri, 28 Mar 2025 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8UsbT5K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE55219A9B;
	Fri, 28 Mar 2025 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743162142; cv=none; b=V+F0zi6qZhh6zGnmt31FJgkXTPxq/szFkMFQpJqY9fjE9vX+jojaDBNwkpuyGuVGw7QaXL9Of/kW2rt8CYrX4ultsb6tqtb4ZkhquFktptXuRCauMn47hT4aJifgc15Qa3o3ckImBOkaqpZaIvmtFTMgpDoNda0n/wncy0p7H+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743162142; c=relaxed/simple;
	bh=f9DrOJIhJ9MbHkQN1Z7cmFcocyTKLaJ8Y+POEHgkC7E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B1V3sui3qG7bKmXjTDvX90P73ef6O5fyJHNc1dbXuC0nzoXYSjNAtb+cuVoxStPxCXSw6ybyn2AMa+hkxUf8B5pNXcy/PsIRlHYu0my8Qo79h1bS5LHVZJ/2QbvzSvAso/co8umXPPv6dqZEQEeYBCbICiZUfIBI5VL3MGHhmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8UsbT5K; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743162140; x=1774698140;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=f9DrOJIhJ9MbHkQN1Z7cmFcocyTKLaJ8Y+POEHgkC7E=;
  b=P8UsbT5KFSCsGMHEiJzmWX9KsammZvUo7zo5sLBY+vgwt5vSmQrOeKkw
   EKi3TwjtUQK/he4X7sVqLxI2gjtXdTr5mWSlB0fjzQF5vBr8bTPNzP4On
   27yaBxTe4S4z9FrO9V996BNjOs62GHvuy8kUrBzhyWQCgvB9qZ1kttUdy
   51zkRcgAMwwJVuIzNSQOyG6l7wvgxuPnYnHG+e7cp1QAaAeHPTBDikmTn
   71q9FblGCO5IKInp+PW4oD+7XIboN3wQMoutjbgCLUdIdq7/nOeD4g+wX
   15Vx9x/uS6vlUM/8asj2+rwxDH5QAnVW9mxEX9iMBqoubj70MHm2ouSIC
   w==;
X-CSE-ConnectionGUID: TxfS/ddCTLGy+veB2jt93g==
X-CSE-MsgGUID: +yc7wF+uRna7qClnDl0tfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44650161"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="44650161"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 04:42:19 -0700
X-CSE-ConnectionGUID: V76xbuNsSSSX5jdkO+FNnw==
X-CSE-MsgGUID: fOPyD39qQbuXW31s/zcfKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="130481496"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.43])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 04:42:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 28 Mar 2025 13:42:11 +0200 (EET)
To: Hans Zhang <18255117159@163.com>
cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, lpieralisi@kernel.org, kw@linux.com, 
    robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
In-Reply-To: <b279863e-8d8c-4c14-98ad-c19d26c69146@163.com>
Message-ID: <0e493832-6292-10d7-6f87-ed190059c999@linux.intel.com>
References: <20250323164852.430546-1-18255117159@163.com> <20250323164852.430546-4-18255117159@163.com> <f467056d-8d4a-9dab-2f0a-ca589adfde53@linux.intel.com> <d370b69a-3b70-4e3b-94a3-43e0bc1305cd@163.com> <a3462c68-ec1b-0b1a-fee7-612bd1109819@linux.intel.com>
 <3d9b2fa9-98bf-4f47-aa76-640a4f82cb2f@163.com> <26dcba54-93c1-dda4-c5e2-e324e9d50b09@linux.intel.com> <f2725090-e199-493d-9ae3-e807d65f647b@163.com> <de6ce71c-ba82-496e-9c72-7c9c61b37906@163.com> <ddabf340-a00f-75b1-2b6b-d9ab550a984f@linux.intel.com>
 <9118fcc0-e5a5-40f2-be4b-7e06b4b20601@163.com> <b279863e-8d8c-4c14-98ad-c19d26c69146@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-681295574-1743159337=:932"
Content-ID: <18406683-5fa9-f0b7-b739-efe99c82fa73@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-681295574-1743159337=:932
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <f181610a-81ba-d41a-58b6-f0f08022e899@linux.intel.com>

On Fri, 28 Mar 2025, Hans Zhang wrote:
> On 2025/3/25 23:37, Hans Zhang wrote:
> > On 2025/3/25 23:18, Ilpo J=E4rvinen wrote:>>
> > > > Hi Ilpo,
> > > >=20
> > > > Another question comes to mind:
> > > > If working in EP mode, devm_pci_alloc_host_bridge will not be execu=
ted
> > > > and
> > > > there will be no struct pci_host_bridge.
> > > >=20
> > > > Don't know if you have anything to add?
> > >=20
> > > Hi Hans,
> > >=20
> > > No, I don't have further ideas at this point, sorry. It seems it isn'=
t
> > > realistic without something more substantial that currently isn't the=
re.
> > >=20
> > > This lack of way to have a generic way to read the config before the =
main
> > > struct are instanciated by the PCI core seems to be the limitation th=
at
> > > hinders sharing code between controller drivers and it would have bee=
n
> > > nice to address it.
> > >=20
> > > But please still make the capability list parsing code common, it sho=
uld
> > > be relatively straightforward using a macro which can take different =
read
> > > functions similar to read_poll_timeout. That will avoid at least some
> > > amount of code duplication.
> > >=20
> > > Thanks for trying to come up with a solution (or thinking enough to s=
ay
> > > it doesn't work)!
> > >=20
> >=20
> > Hi Ilpo,
> >=20
> > It's okay. It's what I'm supposed to do. Thank you very much for your
> > discussion with me. I'll try a macro definition like read_poll_timeout.=
 Will
> > share the revised patches soon for your feedback.
> >=20
> > Best regards,
> > Hans
> >=20
> >=20
>=20
> Dear Ilpo, Mani and Bjorn,
>=20
>=20
> The following is my new idea, and the following is patch. Please help to =
check
> whether it is reasonable.
>=20
> I successfully tested the CDNS and DWC drivers locally. If there are othe=
r
> risks, please point them out, and we'll discuss them. Please give your
> opinion. Thank you very much.
>=20
> Or is the submitted patch reasonable? I'd like to ask for your advice.
>=20
> Patchs:
>=20
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c
> b/drivers/pci/controller/cadence/pcie-cadence.c
> index 204e045aed8c..92aea42a18d0 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -5,9 +5,37 @@
>=20
>  #include <linux/kernel.h>
>  #include <linux/of.h>
> +#include <linux/pci.h>
>=20
>  #include "pcie-cadence.h"
>=20
> +static int cdns_pcie_read_cfg(void *priv, unsigned int devfn, int where,
> +=09=09=09      int size, u32 *val)
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
> +=09return PCI_FIND_NEXT_CAP_TTL(pcie, 0, cdns_pcie_read_cfg,
> +=09=09=09=09     PCI_CAPABILITY_LIST, cap);
> +}
> +
> +u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
> +{
> +=09return PCI_FIND_NEXT_EXT_CAPABILITY(pcie, 0, cdns_pcie_read_cfg, 0,
> +=09=09=09=09=09    cap);
> +}
> +
>  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
>  {
>  =09u32 delay =3D 0x3;
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
> index 145e7f579072..1b579dbc5cb1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -203,83 +203,26 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
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
> +static int dw_pcie_read_cfg(void *priv, unsigned int devfn, int where, i=
nt
> size,
> +=09=09=09    u32 *val)
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
> +=09*val =3D dw_pcie_read_dbi(pcie, where, size);
>=20
> -=09if (cap_id =3D=3D cap)
> -=09=09return cap_ptr;
> -
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
> +=09return PCI_FIND_NEXT_CAP_TTL(pcie, 0, dw_pcie_read_cfg,
> +=09=09=09=09     PCI_CAPABILITY_LIST, cap);
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
> +=09return PCI_FIND_NEXT_EXT_CAPABILITY(pcie, 0, dw_pcie_read_cfg, 0,
> +=09=09=09=09=09    cap);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..af7467c3143d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -423,28 +423,27 @@ static int pci_dev_str_match(struct pci_dev *dev, c=
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
> +=09return PCI_FIND_NEXT_CAP_TTL(bus, devfn, __pci_bus_read_config, pos,
> +=09=09=09=09     cap);
>  }
>=20
>  static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
> @@ -553,42 +552,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
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
> +=09return PCI_FIND_NEXT_EXT_CAPABILITY(dev->bus, dev->devfn,
> +=09=09=09=09=09    __pci_bus_read_config, start,
> cap);
>  }
>  EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
>=20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 47b31ad724fa..0d5dfd010a01 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1198,6 +1198,64 @@ void pci_sort_breadthfirst(void);
>=20
>  /* Generic PCI functions exported to card drivers */
>=20
> +/* Extended capability finder */
> +#define PCI_FIND_NEXT_CAP_TTL(priv, devfn, read_cfg, start, cap)     \

Please put it into drivers/pci/pci.h but other than that this is certainly=
=20
to the direction I was suggesting.

You don't need to have those priv and devfn there like that but you can=20
use the args... trick (see linux/iopoll.h) and put them as last parameters=
=20
to the macro so they can wary based on the caller needs, assuming args=20
will work like this, I've not tested:

=09=09read_cfg(args, __pos, &val)

The size parameter is the most annoying one as it's in between where and=20
*val arguments so args... trick won't work for it. I suggest just=20
providing a function with the same signature as the related pci/access.c=20
function for now.

A few nits related to the existing code quality of the cap parser function=
=20
which should be addressed while we touch this function (probably in own=20
patches indepedent of this code move/rearrange patch itself).

> +=09({                                                                  \
> +=09=09typeof(start) __pos =3D (start);                              \
> +=09=09int __ttl =3D PCI_FIND_CAP_TTL;                               \
> +=09=09u16 __ent =3D 0;                                              \
> +=09=09u8 __found_pos =3D 0;                                         \
> +=09=09u8 __id;                                                    \
> +     \
> +=09=09read_cfg((priv), (devfn), __pos, 1, (u32 *)&__pos);         \
> +     \
> +=09=09while (__ttl--) {                                           \
> +=09=09=09if (__pos < 0x40)                                   \

I started to wonder if there's something for this and it turn out we've=20
PCI_STD_HEADER_SIZEOF.

> +=09=09=09=09break;                                      \
> +=09=09=09__pos &=3D ~3;                                        \

This could use some align helper.

> +=09=09=09read_cfg((priv), (devfn), __pos, 2, (u32 *)&__ent); \
> +     \
> +=09=09=09__id =3D __ent & 0xff;                                \
> +=09=09=09if (__id =3D=3D 0xff)                                   \
> +=09=09=09=09break;                                      \
> +=09=09=09if (__id =3D=3D (cap)) {                                \
> +=09=09=09=09__found_pos =3D __pos;                        \
> +=09=09=09=09break;                                      \
> +=09=09=09}                                                   \
> +=09=09=09__pos =3D (__ent >> 8);                               \

I'd add these into uapi/linux/pci_regs.h:

#define PCI_CAP_ID_MASK=09=090x00ff
#define PCI_CAP_LIST_NEXT_MASK=090xff00

And then use FIELD_GET() to extract the fields.

> +=09=09}                                                           \
> +=09=09__found_pos;                                                \
> +=09})
> +
> +/* Extended capability finder */
> +#define PCI_FIND_NEXT_EXT_CAPABILITY(priv, devfn, read_cfg, start, cap) =
   \
> +=09({                                                                 \
> +=09=09u16 __pos =3D (start) ?: PCI_CFG_SPACE_SIZE;                 \
> +=09=09u16 __found_pos =3D 0;                                       \
> +=09=09int __ttl, __ret;                                          \
> +=09=09u32 __header;                                              \
> +    \
> +=09=09__ttl =3D (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8; \
> +=09=09while (__ttl-- > 0 && __pos >=3D PCI_CFG_SPACE_SIZE) {       \
> +=09=09=09__ret =3D read_cfg((priv), (devfn), __pos, 4,        \
> +=09=09=09=09=09 &__header);                       \
> +=09=09=09if (__ret !=3D PCIBIOS_SUCCESSFUL)                   \
> +=09=09=09=09break;                                     \
> +    \
> +=09=09=09if (__header =3D=3D 0)                                 \
> +=09=09=09=09break;                                     \
> +    \
> +=09=09=09if (PCI_EXT_CAP_ID(__header) =3D=3D (cap) &&           \
> +=09=09=09    __pos !=3D start) {                              \
> +=09=09=09=09__found_pos =3D __pos;                       \
> +=09=09=09=09break;                                     \
> +=09=09=09}                                                  \
> +    \
> +=09=09=09__pos =3D PCI_EXT_CAP_NEXT(__header);                \
> +=09=09}                                                          \
> +=09=09__found_pos;                                               \
> +=09})
> +
>  u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int =
cap);
>  u8 pci_find_capability(struct pci_dev *dev, int cap);
>  u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);


I started to wonder though if the controller drivers could simply create=20
an "early" struct pci_dev & pci_bus just so they can use the normal=20
accessors while the real structs are not yet created. It looks not=20
much is needed from those structs to let the accessors to work.

--=20
 i.
--8323328-681295574-1743159337=:932--

