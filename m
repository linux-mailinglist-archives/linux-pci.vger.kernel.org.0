Return-Path: <linux-pci+bounces-24661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C6AA6F0CC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 12:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7F63B523E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0E5198A29;
	Tue, 25 Mar 2025 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qlun8Bqw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA062E337C;
	Tue, 25 Mar 2025 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901357; cv=none; b=NV+EIfQvQpe1mGoW1tGFslWzLZ9RHNHe/oQme1DPDK99OrOeWbJwVcv2Oau9AZxvwAEkCmFsdxH5KfGc7VoQJpjPzgZpLMEsNq8Ec1gIkBA5JV/Ly04jdXKXDafPr355SkDvmw+zlXltY3vffzG8lvMh6tfDKxFmclaBZTgd1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901357; c=relaxed/simple;
	bh=ejo2mJfaZPVCPpYuCkYgIZdpbhitxkRb24uvxJioFd0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FQyffSbCBZ9APqebvo6mMiXz3QNz/L70UJl20o+oa8dKyeOt8br1cGkT3jRgqQOAHV2DtkRns4zCkyVzduroX7Sk7d2KAmeewLTapdm0s5s0MRB0tixjisPcy/28gA9fwPqmZwwRkPrBmgY5cFj6qiWbICbpAjC2D6/SibyWkp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qlun8Bqw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742901356; x=1774437356;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ejo2mJfaZPVCPpYuCkYgIZdpbhitxkRb24uvxJioFd0=;
  b=Qlun8BqwW/Uv+e2Xtm89Rjr3UR/kXcG8rhwppZZb0pTmM2u+9dPcNb5L
   1EMcI65UWhq3x2oWp/iFSpDdKMP6wO+Bq53sx+Xa8Otr0OocGOcpUYWo/
   PEZyt49i6GzhdxufKVcRD9TbVbDPaNJwy/OCtQjSq0bw+ah4XmyqWE6o/
   vzzl72AKiZ3WRsE9d4I/yymkMEzXnxjkCwJphQhsO0XnRaaxpudd98zt/
   llr83f49SrqK4VR5gDGUwqZwftICavLduo3UgkP2K7Kd64scEROaXL9be
   NDF49u2qjKTnOvrHWXpYZXYSl8ZiXzCcOnPxh61cBESZuRy4FucpegtBb
   Q==;
X-CSE-ConnectionGUID: O0j/QV13SQaljd87p0Wg1w==
X-CSE-MsgGUID: UsM1+8oiReafEuLt36F5xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43299869"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="43299869"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 04:15:55 -0700
X-CSE-ConnectionGUID: pezZcfE1QgmaLFl2HoRdKg==
X-CSE-MsgGUID: Euqu4xK9QMqpCVBvr6tsdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="155253915"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.158])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 04:15:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 25 Mar 2025 13:15:49 +0200 (EET)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
    thomas.richard@bootlin.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
In-Reply-To: <3d9b2fa9-98bf-4f47-aa76-640a4f82cb2f@163.com>
Message-ID: <26dcba54-93c1-dda4-c5e2-e324e9d50b09@linux.intel.com>
References: <20250323164852.430546-1-18255117159@163.com> <20250323164852.430546-4-18255117159@163.com> <f467056d-8d4a-9dab-2f0a-ca589adfde53@linux.intel.com> <d370b69a-3b70-4e3b-94a3-43e0bc1305cd@163.com> <a3462c68-ec1b-0b1a-fee7-612bd1109819@linux.intel.com>
 <3d9b2fa9-98bf-4f47-aa76-640a4f82cb2f@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1369016099-1742899832=:930"
Content-ID: <dcc4341b-40b0-3a66-8cf5-ba1fb697c37b@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1369016099-1742899832=:930
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <79a7a062-7cab-6b21-e28f-218eedc1a9ca@linux.intel.com>

On Tue, 25 Mar 2025, Hans Zhang wrote:
> On 2025/3/24 23:02, Ilpo J=E4rvinen wrote:
> > > > >    +static u32 cdns_pcie_read_cfg(void *priv, int where, int size=
)
> > > > > +{
> > > > > +=09struct cdns_pcie *pcie =3D priv;
> > > > > +=09u32 val;
> > > > > +
> > > > > +=09if (size =3D=3D 4)
> > > > > +=09=09val =3D readl(pcie->reg_base + where);
> > > >=20
> > > > Should this use cdns_pcie_readl() ?
> > >=20
> > > pci_host_bridge_find_*capability required to read two or four bytes.
> > >=20
> > > reg =3D read_cfg(priv, cap_ptr, 2);
> > > or
> > > header =3D read_cfg(priv, pos, 4);
> > >=20
> > > Here I mainly want to write it the same way as size =3D=3D 2 and size=
 =3D=3D 1.
> > > Or size =3D=3D 4 should I write it as cdns_pcie_readl() ?
> >=20
> > As is, it seems two functions are added for the same thing for the case
> > with size =3D=3D 4 with different names which feels duplication. One co=
uld add
> > cdns_pcie_readw() and cdns_pcie_readb() too but perhaps cdns_pcie_readl=
()
> > should just call this new function instead?
>=20
> Hi Ilpo,
>=20
> Redefine a function with reference to DWC?

This patch was about cadence so my comment above what related to that.

> u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
>   dw_pcie_read(pci->dbi_base + reg, size, &val);
>     dw_pcie_read
>=20
> int dw_pcie_read(void __iomem *addr, int size, u32 *val)
> {
> =09if (!IS_ALIGNED((uintptr_t)addr, size)) {
> =09=09*val =3D 0;
> =09=09return PCIBIOS_BAD_REGISTER_NUMBER;
> =09}
>=20
> =09if (size =3D=3D 4) {
> =09=09*val =3D readl(addr);
> =09} else if (size =3D=3D 2) {
> =09=09*val =3D readw(addr);
> =09} else if (size =3D=3D 1) {
> =09=09*val =3D readb(addr);
> =09} else {
> =09=09*val =3D 0;
> =09=09return PCIBIOS_BAD_REGISTER_NUMBER;
> =09}
>=20
> =09return PCIBIOS_SUCCESSFUL;
> }
> EXPORT_SYMBOL_GPL(dw_pcie_read);
>=20
> >=20
> > > > > +=09else if (size =3D=3D 2)
> > > > > +=09=09val =3D readw(pcie->reg_base + where);
> > > > > +=09else if (size =3D=3D 1)
> > > > > +=09=09val =3D readb(pcie->reg_base + where);
> > > > > +
> > > > > +=09return val;
> > > > > +}
> > > > > +
> > > > > +u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
> > > > > +{
> > > > > +=09return pci_host_bridge_find_capability(pcie,
> > > > > cdns_pcie_read_cfg, cap);
> > > > > +}
> > > > > +
> > > > > +u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap=
)
> > > > > +{
> > > > > +=09return pci_host_bridge_find_ext_capability(pcie,
> > > > > cdns_pcie_read_cfg,
> > > > > cap);
> > > > > +}
> > > >=20
> > > > I'm really wondering why the read config function is provided direc=
tly
> > > > as
> > > > an argument. Shouldn't struct pci_host_bridge have some ops that ca=
n
> > > > read
> > > > config so wouldn't it make much more sense to pass it and use the f=
unc
> > > > from there? There seems to ops in pci_host_bridge that has read(), =
does
> > > > that work? If not, why?
> > > >=20
> > >=20
> > > No effect.
> >=20
> > I'm not sure what you meant?
> >=20
> > > Because we need to get the offset of the capability before PCIe
> > > enumerates the device.
> >=20
> > Is this to say it is needed before the struct pci_host_bridge is create=
d?
> >=20
> > > I originally added a separate find capability related
> > > function for CDNS in the following patch. It's also copied directly f=
rom
> > > DWC.
> > > Mani felt there was too much duplicate code and also suggested passin=
g a
> > > callback function that could manipulate the registers of the root por=
t of
> > > DWC
> > > or CDNS.
> >=20
> > I very much like the direction this patchset is moving (moving shared
> > part of controllers code to core), I just feel this doesn't go far enou=
gh
> > when it's passing function pointer to the read function.
> >=20
> > I admit I've never written a controller driver so perhaps there's
> > something detail I lack knowledge of but I'd want to understand why
> > struct pci_ops (which exists both in pci_host_bridge and pci_bus) canno=
t
> > be used?
> >=20
>=20
>=20
> I don't know if the following code can make it clear to you.
>=20
> static const struct dw_pcie_host_ops qcom_pcie_dw_ops =3D {
> =09.host_init=09=3D qcom_pcie_host_init,
>                   pcie->cfg->ops->post_init(pcie);
>                     qcom_pcie_post_init_2_3_3
>                       dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> };
>=20
> int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   bridge =3D devm_pci_alloc_host_bridge(dev, 0);

It does this almost immediately:

    bridge->ops =3D &dw_pcie_ops;

Can we like add some function into those ops such that the necessary read=
=20
can be performed? Like .early_root_config_read or something like that?

Then the host bridge capability finder can input struct pci_host_bridge=20
*host_bridge and can do host_bridge->ops->early_root_cfg_read(host_bridge,=
=20
=2E..). That would already be a big win over passing the read function=20
itself as a pointer.

Hopefully having such a function in the ops would allow moving other=20
common controller driver functionality into PCI core as well as it would=20
abstract the per controller read function (for the time before everything=
=20
is fully instanciated).

Is that a workable approach?

>   if (pp->ops->host_init)
>     pp->ops =3D &qcom_pcie_dw_ops;  // qcom here needs to find capability
>
>   pci_host_probe(bridge); // pcie enumerate flow
>     pci_scan_root_bus_bridge(bridge);
>       pci_register_host_bridge(bridge);
>         bus->ops =3D bridge->ops;   // Only pci bus ops can be used
>=20
>=20
> Best regards,
> Hans
>=20

--=20
 i.
--8323328-1369016099-1742899832=:930--

