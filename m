Return-Path: <linux-pci+bounces-2053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FBD82AEB3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 13:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B841F2309C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E26115AC3;
	Thu, 11 Jan 2024 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzzFuKry"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F1C15AC0
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704976097; x=1736512097;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=aQBGgJjZ/ElzSVg54nomsvM5m3C31TLHD1iz9cQLJGU=;
  b=hzzFuKry+9tsPL0nJG+3+bm8H8VaA0wG5dEVJ1ETHqWxgjtqZoFPncaC
   929QTnUIHAqe4mb+TCW8/6wa5f3rLaWn9R4IvSjGVn7SXOOThVrtqUATD
   dX91T+a37xhbognIHS8LMJOziu9A8jpQw28Rx36n40+PCkKSeRjD5ybq2
   HEMFUKvnRg7fmOcpsnnNQ2Y/Mfpl4zKu/gvFO6Oy+GaO//+xJQ9LaVUGV
   kzkgLmCroYHW0qiG4iki6MlASVH+3kpxO4Y5oaXSDupcRMya7dI0n5iRT
   5TCVLjOPZwPkwRR9JiXljo4nMsvqdW/qk5E6m3anZymeY3HFei5Gdld5x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="402603821"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="402603821"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 04:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113819642"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1113819642"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.201])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 04:28:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jan 2024 14:28:06 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: "David E. Box" <david.e.box@linux.intel.com>, bhelgaas@google.com, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com, 
    rafael.j.wysocki@intel.com, kai.heng.feng@canonical.com, 
    tasev.stefanoska@skynet.be, enriquezmark36@gmail.com, kernel@witt.link, 
    koba.ko@canonical.com, wse@tuxedocomputers.com, ricky_wu@realtek.com, 
    linux-pci@vger.kernel.org, Michael Schaller <michael@5challer.de>
Subject: Re: [PATCH v5] PCI/ASPM: Add back L1 PM Substate save and restore
In-Reply-To: <20240110184659.GA2113074@bhelgaas>
Message-ID: <6e258022-229f-88bc-037f-18b0a1568bbf@linux.intel.com>
References: <20240110184659.GA2113074@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1082851991-1704973470=:1278"
Content-ID: <ad9babed-f384-5062-a9d0-84cc6f0c8872@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1082851991-1704973470=:1278
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <8ca0222d-f6ad-ed4b-e684-7cdb3e16cbeb@linux.intel.com>

On Wed, 10 Jan 2024, Bjorn Helgaas wrote:

> On Wed, Jan 10, 2024 at 07:24:31AM -0800, David E. Box wrote:
> > On Thu, 2023-12-28 at 18:30 -0600, Bjorn Helgaas wrote:
> > > On Thu, Dec 28, 2023 at 04:31:12PM -0600, Bjorn Helgaas wrote:
> > > > On Wed, Dec 20, 2023 at 05:12:50PM -0800, David E. Box wrote:
>=20
> > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > index 55bc3576a985..3c4b2647b4ca 100644
> > > > > --- a/drivers/pci/pci.c
> > > > > +++ b/drivers/pci/pci.c
> > >=20
> > > > > @@ -1579,7 +1579,7 @@ static void pci_restore_pcie_state(struct p=
ci_dev
> > > > > *dev)
> > > > > =A0{
> > > > > ...
> > >=20
> > > > > +=A0=A0=A0=A0=A0=A0=A0 So we restore here only the
> > > > > +=09 * LNKCTL register with the ASPM control field clear. ASPM wi=
ll
> > > > > +=09 * be restored in pci_restore_aspm_state().
> > > > > +=09 */
> > > > > +=09val =3D cap[i++] & ~PCI_EXP_LNKCTL_ASPMC;
> > > > > +=09pcie_capability_write_word(dev, PCI_EXP_LNKCTL, val);
> > > >=20
> > > > When CONFIG_PCIEASPM is not set, we will clear ASPMC here and never
> > > > restore it.=A0 I don't know if this ever happens.=A0 Do we need to =
worry
> > > > about this?=A0 Might firmware restore ASPMC itself before we get he=
re?
> > > > What do we want to happen in this case?
> >=20
> > I just checked this. L1 does get disabled which we don't want. We
> > need to save and restore the BIOS ASPM configuration even when
> > CONFIG_PCIEASPM is not set.
>=20
> There's some other ASPM stuff that we want even when CONFIG_PCIEASPM
> is not set.  I think some of that code is currently in probe.c and
> pci.c.
>=20
> I can't find it right now, but we had some discussion about moving
> that code into aspm.c, compiling aspm.c unconditionally, and adding
> CONFIG_PCIEASPM ifdefs inside it for these cases.  Maybe this is the
> time do to that?  If so, probably a preliminary patch or two to do
> the code movement without any functional changes, followed by the
> actual fixes.

Hi,

It's here:

https://lore.kernel.org/linux-pci/20231011200442.GA1040348@bhelgaas/

I'm still not even half way done with the update for that patch series=20
because I got stuck while attempting to do the rtsx driver changes the=20
new way and moved to work on other stuff for a while.

So far I've only tentatively placed some #ifdef into aspm.c but it wasn't=
=20
all thought nor well arranged yet to limit the number of needed #ifdefs so
nothing ready to be posted yet. And therefore not much effort is lost if=20
David wants to take a look at it instead in the meantime.

--=20
 i.
--8323328-1082851991-1704973470=:1278--

