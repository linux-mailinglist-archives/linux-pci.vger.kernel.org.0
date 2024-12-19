Return-Path: <linux-pci+bounces-18784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7A69F7FB2
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5585D164C1D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDFA226553;
	Thu, 19 Dec 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXOqh4pk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE95E2AE96;
	Thu, 19 Dec 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625574; cv=none; b=Da3SVdm7FqEbF4bPK0BBKOOLRa5LLMsArh1zuY2WzGVSxI2uKhznVZ4fINeNHcnANxXtwqMUb0N0PoSUy9csi8+klKIjzIg/5arcThTrfTwo8QEtmp8nWbeepk6gw4E2nCTLGkWJNm4y0T8BtWg6dGfE0uFwj4cQvh/sCtWoLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625574; c=relaxed/simple;
	bh=ajUO4Nbvo0w+CfkvoUUqjwLuwX5rSRElzu9b+3jnoNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GbmBvIzvZNoa7U2a644RTl4zL4AktnlLFtl6i0/72hGzX06beg18A9U8wa9kFjmztswENL5ivmwcLAiqRgcA3aof82CcLeUzb0Unx5SYy6uPSu925QzYww/2zJXINhc+rv4maoyuABhGbj+EuPVixz0yHsUxF0e4HKrJ+AnAuwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXOqh4pk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734625573; x=1766161573;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ajUO4Nbvo0w+CfkvoUUqjwLuwX5rSRElzu9b+3jnoNY=;
  b=JXOqh4pkwEtTeND7QDTh3L9UQ0HrDnMlQlY/6+YDIwPbmcbSZaBssElW
   H7DYnfD+N/8tmqtaznCm9qG64XfVlKgDbzX1jlzVyb0O1f0MclQ/9CTZa
   pxdQKyQjtoZZKyP2lDD0Q42tlrq1k8jId2Gt8EdqhXCG4QszrMQALboOk
   AX4qEfoADt82SIQ/Lg8sNwXJjG3O5PYOfit1dPM8RDOKKKCsQKhTYWBmo
   Xzu0DWwPSjhIG0RUpANky2hRZBKyGhG804H5maFewcxEnFq6bMIMy+Ip3
   DxL0y62CWXLzy0lCGqSShqxcnyOKzMs8Nm2cykVMC1peh1YN49bVgOx+e
   w==;
X-CSE-ConnectionGUID: yWGgGZckSpi5mXA2GZgp+w==
X-CSE-MsgGUID: rIMoZ2EdTqu/sslMGwomUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="34468947"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="34468947"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 08:25:14 -0800
X-CSE-ConnectionGUID: vqFk6jgwS1CU33hP8R1Y6Q==
X-CSE-MsgGUID: bmwjhI3BSRSjNCfqsDN1OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="103228104"
Received: from dwoodwor-mobl2.amr.corp.intel.com ([10.125.108.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 08:25:14 -0800
Message-ID: <ffeae6a38215df37d8c109c16fd8b6713687ba77.camel@linux.intel.com>
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Bjorn Helgaas <helgaas@kernel.org>, Kenneth Crudup <kenny@panix.com>, 
 Nirmal Patel <nirmal.patel@linux.ntel.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, Vidya Sagar
 <vidyas@nvidia.com>,  Bjorn Helgaas <bhelgaas@google.com>, Andrea Righi
 <andrea.righi@canonical.com>, You-Sheng Yang <vicamo.yang@canonical.com>,
 linux-pm@vger.kernel.org,  linux-pci@vger.kernel.org
Date: Thu, 19 Dec 2024 08:25:12 -0800
In-Reply-To: <20241213230214.GA3434438@bhelgaas>
References: <20241213230214.GA3434438@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kenneth,

On Fri, 2024-12-13 at 17:02 -0600, Bjorn Helgaas wrote:
> [cc->to: David, Nirmal]
>=20
> On Fri, Dec 13, 2024 at 02:26:37PM -0800, Kenneth Crudup wrote:
> > OK, it looks like the effective change (that's not already contained in=
 the
> > LTR SNOOP patches already in Linus' master (et al.)) comes from this li=
ne
> > from the Ubuntu commit 1a0102a0 ("UBUNTU: SAUCE: PCI/ASPM: Enable ASPM =
for
> > links under VMD domain"):
> >=20
> > ----
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 00143f5fb83a..d2ff44e7fbb1 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -688,7 +688,8 @@ static void pcie_aspm_cap_init(struct pcie_link_sta=
te
> > *link, int blacklist)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspm_l1ss_init(link);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Save default state */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->aspm_default =3D link->aspm=
_enabled;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->aspm_default =3D parent->de=
v_flags & PCI_DEV_FLAGS_ENABLE_ASPM ?
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ASPM_STATE_ALL : link->aspm_enabled;
>=20
> So I thought the "pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL)" in
> f492edb40b54 would effectively do the same thing:
>=20
> > > > > > https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+=
git/
> > > > > > lunar/commit/?id=3D1a0102a08f206149d9abd56c2b28877c878b5526
> > > > >=20
> > > > > This is "UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD
> > > > > domain", which adds "link->aspm_default =3D ASPM_STATE_ALL" for d=
evice
> > > > > IDs 0x9a09 and 0xa0b0.
> > > > >=20
> > > > > This looks like it should also be handled by upstream f492edb40b5=
4
> > > > > ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR") [1], which=
 adds
> > > > > "pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL)".
>=20
> But I guess it doesn't actually work.=C2=A0 I'm hoping David or Nirmal ca=
n
> figure out why it doesn't because it seems obvious that it's the
> intent.

Is PCIe ASPM disabled? In the kernel log do you see:

    "can't override BIOS ASPM; OS doesn't have ASPM control"

David


