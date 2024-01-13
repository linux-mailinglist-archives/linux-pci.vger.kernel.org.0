Return-Path: <linux-pci+bounces-2132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF6182C86B
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jan 2024 01:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E32E1F24092
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jan 2024 00:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AA9A28;
	Sat, 13 Jan 2024 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZzU/LwH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84BE7F6
	for <linux-pci@vger.kernel.org>; Sat, 13 Jan 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705106183; x=1736642183;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Tg+AtEuWrqkJvBaYLIQm8tE54KL+guhe4xC+A34g+5A=;
  b=WZzU/LwHKYC2Xdo6SQlETWhh2h25I74FT7KhjIX35ylCWZPxcyWC8+uy
   vDaR+LU2wbCq1GOOPGrlI/cGfUpFt7waXVd1oTLMhaewhUq+l5cKI11X6
   RdO2QrVq3re15vJ7xTPwxWEHHI8/1TLCk/gei9pzayQBiub1/8luxg1IH
   LGuLF2buQpanBNAsP+Vxd+JqPkLVv3mAc1G3URjiDh+X83SFqyHWyO2C7
   29J3n9k5EjipnoJFAQNpT9dRvIzZUlV/2i8ULhhggCiIuWIMjVvmivVc0
   S4p/ybg0yvYFoG71hWmSXGtvVlJ3Mv3n6Z7sVxT8SwM9uFmG78/OpmAHE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="17928199"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="17928199"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 16:36:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="906465908"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="906465908"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 16:36:21 -0800
Received: from jkhodgso-mobl.amr.corp.intel.com (unknown [10.209.94.137])
	by linux.intel.com (Postfix) with ESMTP id 26300580CD9;
	Fri, 12 Jan 2024 16:36:21 -0800 (PST)
Message-ID: <839ac3bf6ad4d6154532f615687132414c1fc1db.camel@linux.intel.com>
Subject: Re: [PATCH v5] PCI/ASPM: Add back L1 PM Substate save and restore
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com, 
	rafael.j.wysocki@intel.com, kai.heng.feng@canonical.com, 
	tasev.stefanoska@skynet.be, enriquezmark36@gmail.com, kernel@witt.link, 
	koba.ko@canonical.com, wse@tuxedocomputers.com, ricky_wu@realtek.com, 
	linux-pci@vger.kernel.org, Michael Schaller <michael@5challer.de>
Date: Fri, 12 Jan 2024 16:36:20 -0800
In-Reply-To: <6e258022-229f-88bc-037f-18b0a1568bbf@linux.intel.com>
References: <20240110184659.GA2113074@bhelgaas>
	 <6e258022-229f-88bc-037f-18b0a1568bbf@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-11 at 14:28 +0200, Ilpo J=C3=A4rvinen wrote:
> On Wed, 10 Jan 2024, Bjorn Helgaas wrote:
>=20
> > On Wed, Jan 10, 2024 at 07:24:31AM -0800, David E. Box wrote:
> > > On Thu, 2023-12-28 at 18:30 -0600, Bjorn Helgaas wrote:
> > > > On Thu, Dec 28, 2023 at 04:31:12PM -0600, Bjorn Helgaas wrote:
> > > > > On Wed, Dec 20, 2023 at 05:12:50PM -0800, David E. Box wrote:
> >=20
> > > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > > index 55bc3576a985..3c4b2647b4ca 100644
> > > > > > --- a/drivers/pci/pci.c
> > > > > > +++ b/drivers/pci/pci.c
> > > >=20
> > > > > > @@ -1579,7 +1579,7 @@ static void pci_restore_pcie_state(struct
> > > > > > pci_dev
> > > > > > *dev)
> > > > > > =C2=A0{
> > > > > > ...
> > > >=20
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 So we restore here =
only the
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * LNKCTL register w=
ith the ASPM control field clear. ASPM
> > > > > > will
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * be restored in pc=
i_restore_aspm_state().
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val =3D cap[i++] & ~=
PCI_EXP_LNKCTL_ASPMC;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcie_capability_writ=
e_word(dev, PCI_EXP_LNKCTL, val);
> > > > >=20
> > > > > When CONFIG_PCIEASPM is not set, we will clear ASPMC here and nev=
er
> > > > > restore it.=C2=A0 I don't know if this ever happens.=C2=A0 Do we =
need to worry
> > > > > about this?=C2=A0 Might firmware restore ASPMC itself before we g=
et here?
> > > > > What do we want to happen in this case?
> > >=20
> > > I just checked this. L1 does get disabled which we don't want. We
> > > need to save and restore the BIOS ASPM configuration even when
> > > CONFIG_PCIEASPM is not set.
> >=20
> > There's some other ASPM stuff that we want even when CONFIG_PCIEASPM
> > is not set.=C2=A0 I think some of that code is currently in probe.c and
> > pci.c.
> >=20
> > I can't find it right now, but we had some discussion about moving
> > that code into aspm.c, compiling aspm.c unconditionally, and adding
> > CONFIG_PCIEASPM ifdefs inside it for these cases.=C2=A0 Maybe this is t=
he
> > time do to that?=C2=A0 If so, probably a preliminary patch or two to do
> > the code movement without any functional changes, followed by the
> > actual fixes.
>=20
> Hi,
>=20
> It's here:
>=20
> https://lore.kernel.org/linux-pci/20231011200442.GA1040348@bhelgaas/
>=20
> I'm still not even half way done with the update for that patch series=
=20
> because I got stuck while attempting to do the rtsx driver changes the=
=20
> new way and moved to work on other stuff for a while.
>=20
> So far I've only tentatively placed some #ifdef into aspm.c but it wasn't=
=20
> all thought nor well arranged yet to limit the number of needed #ifdefs s=
o
> nothing ready to be posted yet. And therefore not much effort is lost if=
=20
> David wants to take a look at it instead in the meantime.

I'll take a stab at it.

David



