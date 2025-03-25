Return-Path: <linux-pci+bounces-24678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD4A704D9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 16:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163561683C2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD19C25BAA9;
	Tue, 25 Mar 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHwVaob/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706C31F4E4B;
	Tue, 25 Mar 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915919; cv=none; b=KChBIKPfefEYNLrIpEK0an/muQpkgEVWd8GQgLc0XaiANVt4LoJk9QRz9DdPdjmWgwUUnDGlky6fjzK1f4txChnIZgfXGtllEHQmn4v69JidRoCXTf06PYsSgimfy2gEWKlmu0VjUzFKyfGZNqPUAcdmdWP0Vx05JRId/+ol9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915919; c=relaxed/simple;
	bh=Xip6hkelY2h/lK6tFQymAS6rSo2DEWd0lKjvZ0e3Hcc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lAkIUHafPh30T7x9RVTxPWgm3OarhUmQbqFyLagdAyNNtTHCH/vfSzztSBQ7a/9S8b6+MNkFViHXSPKaz5BWUimUueNDN6nFHkqJFtjQWkbCz2ag0mp8Ste0Sy70k42I3vGzU0QiKAWZ9O4vSqVFiltvWcgqBe9amVxbG7TEqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHwVaob/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742915917; x=1774451917;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Xip6hkelY2h/lK6tFQymAS6rSo2DEWd0lKjvZ0e3Hcc=;
  b=jHwVaob/PLmlHfcbmN4RAiotEYGyh38e4s4tkNm+ldVRJtcvU14FME0J
   hMiTYUat5FbfWr29Rsp8Rtkn0cfpRy+KFP51mlRCr0X95yrRw/QzxJ4co
   JL1qBV17Q4K4tXs94OaaUiydclb5sTXKwNsft83a2Q33Oj3S5/Qd1IorP
   lhLSuhasHyxl5K7ierzFIUDuYonY6U7uTK7Zj4s94XdyvSN8UyenHLbE9
   u5QFIZWNlNzinkLWOjfcuYr+iMpZZoiC0uq+4z92OJ4/zlVzaCQ6SCrAc
   x41Gpclv+G4D4vj3gi6uSS/cZgH6h59W5JFMGPqTaymgl+JYYeqzU/TRx
   Q==;
X-CSE-ConnectionGUID: 3WPlB1y3Qn+aPIgDpcYnFQ==
X-CSE-MsgGUID: HYkUU9Q/RGqSpwkrziT/Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43403521"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="43403521"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:18:36 -0700
X-CSE-ConnectionGUID: P3o4QEYDTAyJosVhLmbXQQ==
X-CSE-MsgGUID: UYnuykAoQ6iH6quqPW0NuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124878045"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.158])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:18:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 25 Mar 2025 17:18:29 +0200 (EET)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
    thomas.richard@bootlin.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
In-Reply-To: <de6ce71c-ba82-496e-9c72-7c9c61b37906@163.com>
Message-ID: <ddabf340-a00f-75b1-2b6b-d9ab550a984f@linux.intel.com>
References: <20250323164852.430546-1-18255117159@163.com> <20250323164852.430546-4-18255117159@163.com> <f467056d-8d4a-9dab-2f0a-ca589adfde53@linux.intel.com> <d370b69a-3b70-4e3b-94a3-43e0bc1305cd@163.com> <a3462c68-ec1b-0b1a-fee7-612bd1109819@linux.intel.com>
 <3d9b2fa9-98bf-4f47-aa76-640a4f82cb2f@163.com> <26dcba54-93c1-dda4-c5e2-e324e9d50b09@linux.intel.com> <f2725090-e199-493d-9ae3-e807d65f647b@163.com> <de6ce71c-ba82-496e-9c72-7c9c61b37906@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-868479237-1742915909=:930"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-868479237-1742915909=:930
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 25 Mar 2025, Hans Zhang wrote:
> On 2025/3/25 20:16, Hans Zhang wrote:
> > > > > > > I'm really wondering why the read config function is provided
> > > > > > > directly
> > > > > > > as
> > > > > > > an argument. Shouldn't struct pci_host_bridge have some ops t=
hat
> > > > > > > can
> > > > > > > read
> > > > > > > config so wouldn't it make much more sense to pass it and use=
 the
> > > > > > > func
> > > > > > > from there? There seems to ops in pci_host_bridge that has re=
ad(),
> > > > > > > does
> > > > > > > that work? If not, why?
> > > > > > >=20
> > > > > >=20
> > > > > > No effect.
> > > > >=20
> > > > > I'm not sure what you meant?
> > > > >=20
> > > > > > Because we need to get the offset of the capability before PCIe
> > > > > > enumerates the device.
> > > > >=20
> > > > > Is this to say it is needed before the struct pci_host_bridge is
> > > > > created?
> > > > >=20
> > > > > > I originally added a separate find capability related
> > > > > > function for CDNS in the following patch. It's also copied dire=
ctly
> > > > > > from
> > > > > > DWC.
> > > > > > Mani felt there was too much duplicate code and also suggested
> > > > > > passing a
> > > > > > callback function that could manipulate the registers of the ro=
ot
> > > > > > port of
> > > > > > DWC
> > > > > > or CDNS.
> > > > >=20
> > > > > I very much like the direction this patchset is moving (moving sh=
ared
> > > > > part of controllers code to core), I just feel this doesn't go fa=
r
> > > > > enough
> > > > > when it's passing function pointer to the read function.
> > > > >=20
> > > > > I admit I've never written a controller driver so perhaps there's
> > > > > something detail I lack knowledge of but I'd want to understand w=
hy
> > > > > struct pci_ops (which exists both in pci_host_bridge and pci_bus)
> > > > > cannot
> > > > > be used?
> > > > >=20
> > > >=20
> > > >=20
> > > > I don't know if the following code can make it clear to you.
> > > >=20
> > > > static const struct dw_pcie_host_ops qcom_pcie_dw_ops =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0.host_init=C2=A0=C2=A0=C2=A0 =3D qcom_pcie_=
host_init,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie->cfg->ops->post_init(pcie);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qcom_pcie_post_init_=
2_3_3
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_=
find_capability(pci, PCI_CAP_ID_EXP);
> > > > };
> > > >=20
> > > > int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > > =C2=A0=C2=A0 bridge =3D devm_pci_alloc_host_bridge(dev, 0);
> > >=20
> > > It does this almost immediately:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 bridge->ops =3D &dw_pcie_ops;
> > >=20
> > > Can we like add some function into those ops such that the necessary =
read
> > > can be performed? Like .early_root_config_read or something like that=
?
> > >=20
> > > Then the host bridge capability finder can input struct pci_host_brid=
ge
> > > *host_bridge and can do host_bridge->ops->early_root_cfg_read(host_br=
idge,
> > > ...). That would already be a big win over passing the read function
> > > itself as a pointer.
> > >=20
> > > Hopefully having such a function in the ops would allow moving other
> > > common controller driver functionality into PCI core as well as it wo=
uld
> > > abstract the per controller read function (for the time before everyt=
hing
> > > is fully instanciated).
> > >=20
> > > Is that a workable approach?
> > >=20
> >=20
> > I'll try to add and test it in your way first.
> >=20
> > Another problem here is that I've seen some drivers invoke
> > dw_pcie_find_*capability before if (pp->ops->init) {. When I confirm it=
, or
> > I'll see if I can cover all the issues.
> >=20
> > If I pass the test, I will provide the temporary patch here, please che=
ck
> > whether it is OK, and then submit the next version. If not, we'll discu=
ss
> > it.
> >=20
>=20
> Hi Ilpo,
>=20
> Another question comes to mind:
> If working in EP mode, devm_pci_alloc_host_bridge will not be executed an=
d
> there will be no struct pci_host_bridge.
>=20
> Don't know if you have anything to add?

Hi Hans,

No, I don't have further ideas at this point, sorry. It seems it isn't=20
realistic without something more substantial that currently isn't there.

This lack of way to have a generic way to read the config before the main=
=20
struct are instanciated by the PCI core seems to be the limitation that=20
hinders sharing code between controller drivers and it would have been=20
nice to address it.

But please still make the capability list parsing code common, it should=20
be relatively straightforward using a macro which can take different read=
=20
functions similar to read_poll_timeout. That will avoid at least some=20
amount of code duplication.

Thanks for trying to come up with a solution (or thinking enough to say=20
it doesn't work)!

> > Thank you very much for your advice.
> >=20
> > > > =C2=A0=C2=A0 if (pp->ops->host_init)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 pp->ops =3D &qcom_pcie_dw_ops;=C2=A0 // qc=
om here needs to find capability
> > > >=20
> > > > =C2=A0=C2=A0 pci_host_probe(bridge); // pcie enumerate flow
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 pci_scan_root_bus_bridge(bridge);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_register_host_bridge(bridg=
e);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->ops =3D bridg=
e->ops;=C2=A0=C2=A0 // Only pci bus ops can be used
> > > >=20
> > > >=20
>=20
> Best regards,
> Hans
>=20

--=20
 i.

--8323328-868479237-1742915909=:930--

