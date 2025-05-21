Return-Path: <linux-pci+bounces-28199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302F4ABF0C1
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 12:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E538C7C7F
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541825A342;
	Wed, 21 May 2025 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgln4jpi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E528623BCF4;
	Wed, 21 May 2025 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821899; cv=none; b=ZKX7hd3D/IV3xt2V9HKSKCat/OLNWDRTA7mqsDtAQXz/nXomrm/Zon+cfg6ZNN9K+QVNCUcD/VdhtBbbquciEsIew2vofCBzVCcygz+WhLbbDStWci0ASwXYXGl21ZmgdkcCHHL2Hc9N6i/kW6uQuNymTFIydEdv3rSNVq/r8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821899; c=relaxed/simple;
	bh=V+k7h6+Q0/ddKSMSP5VzOiJCtuV4GZRXu/fTW8/R69M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X831k0S1LMzN/ROcc+LC6e21OsitOF1VFYjxgP9//HiVrH1YSdNVjHg1dRVhq0qz/aDogySaWVNf8bVu2QtVedql25bOvG6wCfPaFaQ85fUQHgPoUIfM8eO4us5W4UUhdd3g+McZokxx5Lwvix/YVgt94/5gvDySY3HLrcpFlEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgln4jpi; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747821898; x=1779357898;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=V+k7h6+Q0/ddKSMSP5VzOiJCtuV4GZRXu/fTW8/R69M=;
  b=bgln4jpi3ZWd2d2AIFuXOCVL2Gv1XOHyQZNosvt95ArqI+Hq8Qaqn5Xz
   LRO/Frow7LxdrBT3fWBeFrv+bv/6Ka+pZddP1uRUCxtHuOn7+aPIsP6tS
   hlmgJNfkzG6l7L+ZidVMD0cnD7t5TKygrpu+MH6EMQhxl4taSMrY/MZ1O
   N7UV4vI6Y1U8mt98oFqwksaar33bkO9IHHoWL5no+2kNz2yGL0CIyosss
   2MhHCQyrBzdE+hbAkQo/eJnapM3qSJmA3DHhYT00smSf5Dk/sMAtZs+nx
   TpJPg18DUQ2MaF2Tsg5nLwDJNO3BHTNSDbgl6Zia8wVf4G2uiAbvpfYez
   g==;
X-CSE-ConnectionGUID: SEaxTx6dRnGtJSaaM6Ye5Q==
X-CSE-MsgGUID: vPVeEeuWRLqm9sc+B6S4Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60835090"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="60835090"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 02:57:22 -0700
X-CSE-ConnectionGUID: mPSgTPnCRMymVa6225jeoQ==
X-CSE-MsgGUID: aZustmdkRT2F/53vhlKE7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="145242519"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 02:57:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 May 2025 12:57:12 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
    Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, 
    Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
    Dave Jiang <dave.jiang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 14/16] PCI/AER: Introduce ratelimit for error logs
In-Reply-To: <20250520193819.GA1318016@bhelgaas>
Message-ID: <741055cc-42bd-2e84-20eb-a4345753fcbc@linux.intel.com>
References: <20250520193819.GA1318016@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-714307709-1747821432=:946"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-714307709-1747821432=:946
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 20 May 2025, Bjorn Helgaas wrote:

> On Tue, May 20, 2025 at 02:55:32PM +0300, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 19 May 2025, Bjorn Helgaas wrote:
> >=20
> > > From: Jon Pan-Doh <pandoh@google.com>
> > >=20
> > > Spammy devices can flood kernel logs with AER errors and slow/stall
> > > execution. Add per-device ratelimits for AER correctable and uncorrec=
table
> > > errors that use the kernel defaults (10 per 5s).
> > >=20
> > > There are two AER logging entry points:
> > >=20
> > >   - aer_print_error() is used by DPC and native AER
> > >=20
> > >   - pci_print_aer() is used by GHES and CXL
> > >=20
> > > The native AER aer_print_error() case includes a loop that may log de=
tails
> > > from multiple devices.  This is ratelimited by the union of ratelimit=
s for
> > > these devices, set by add_error_device(), which collects the devices.=
  If
> > > no such device is found, the Error Source message is ratelimited by t=
he
> > > Root Port or RCEC that received the ERR_* message.
> > >=20
> > > The DPC aer_print_error() case is currently not ratelimited.
> > >=20
> > > The GHES and CXL pci_print_aer() cases are ratelimited by the Error S=
ource
> > > device.
>=20
> > >  static int add_error_device(struct aer_err_info *e_info, struct pci_=
dev *dev)
> > >  {
> > > +=09/*
> > > +=09 * Ratelimit AER log messages.  Generally we add the Error Source
> > > +=09 * device, but there are is_error_source() cases that can result =
in
> > > +=09 * multiple devices being added here, so we OR them all together.
> >=20
> > I can see the code uses OR ;-) but I wasn't helpful because this commen=
t=20
> > didn't explain why at all. As this ratelimit thing is using reverse log=
ic=20
> > to begin with, this is a very tricky bit.
> >=20
> > Perhaps something less vague like:
> >=20
> > ... we ratelimit if all devices have reached their ratelimit.
> >=20
> > Assuming that was the intention here? (I'm not sure.)
>=20
> My intention was that if there's any downstream device that has an
> unmasked error logged and it has not reached its ratelimit, we should
> log messages for all devices with errors logged.  Does something like
> this help?
>=20
>   /*
>    * Ratelimit AER log messages.  "dev" is either the source
>    * identified by the root's Error Source ID or it has an unmasked
>    * error logged in its own AER Capability.  If any of these devices
>    * has not reached its ratelimit, log messages for all of them.
>    * Messages are emitted when e_info->ratelimit is non-zero.
>    *
>    * Note that e_info->ratelimit was already initialized to 1 for the
>    * ERR_FATAL case.
>    */

Yes, this is much clearer of intent, thanks.

> The ERR_FATAL case is from this post-v6 change that I haven't posted
> yet:
>=20
>   aer_isr_one_error(...)
>   {
>     ...
>     if (status & PCI_ERR_ROOT_UNCOR_RCV) {
>       int fatal =3D status & PCI_ERR_ROOT_FATAL_RCV;
>       struct aer_err_info e_info =3D {
>         ...
>  +      .ratelimit =3D fatal ? 1 : 0;
>=20
>=20
> > > +=09 */
> > >  =09if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
> > >  =09=09e_info->dev[e_info->error_dev_num] =3D pci_dev_get(dev);
> > > +=09=09e_info->ratelimit |=3D aer_ratelimit(dev, e_info->severity);
> > >  =09=09e_info->error_dev_num++;
> > >  =09=09return 0;
> > >  =09}
>=20
> > > @@ -1147,9 +1183,10 @@ static void aer_recover_work_func(struct work_=
struct *work)
> > >  =09=09pdev =3D pci_get_domain_bus_and_slot(entry.domain, entry.bus,
> > >  =09=09=09=09=09=09   entry.devfn);
> > >  =09=09if (!pdev) {
> > > -=09=09=09pr_err("no pci_dev for %04x:%02x:%02x.%x\n",
> > > -=09=09=09       entry.domain, entry.bus,
> > > -=09=09=09       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
> > > +=09=09=09pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
> >=20
> > This case was not mentioned in the changelog.
>=20
> Sharp eyes!  What do you think of this commit log text?
>=20
>   The CXL pci_print_aer() case is ratelimited by the Error Source device.
>=20
>   The GHES pci_print_aer() case is via aer_recover_work_func(), which
>   searches for the Error Source device.  If the device is not found, ther=
e's
>   no per-device ratelimit, so we use a system-wide ratelimit that covers =
all
>   error types (correctable, non-fatal, and fatal).

Works for me as long as it is mentioned.

> This isn't really ideal because in pci_print_aer(), the struct
> aer_capability_regs has already been filled by firmware and the
> logging doesn't read any registers from the device at all.
>=20
> However, pci_print_aer() *does* want the pci_dev for statistics and
> tracing (pci_dev_aer_stats_incr()) and, of course, for the aer_printks
> themselves.

While not a perfect solution, this looks yet another case where it would=20
help to create a dummy pci_dev struct with minimal setup which allows=20
calling functions that input a pci_dev.

That solution is not perfect because it arms a trap. Downstream=20
functions could get changed and if the developer assumes they have a full=
=20
pci_dev at hand, it could cause issues with the dummy pci_dev. How likely
it happens is debatable but for many cases where the call-chain isn't=20
overly complex such as here, dummy pci_dev seems helpful.

> We could leave this pr_err() completely alone; hopefully it's a rare
> case.  I think the CXL path just silently skips pci_print_aer() if
> this happens.
>=20
> Eventually I would really like the native AER path to start by doing
> whatever firmware is doing, e.g., fill in struct aer_capability_regs,
> so the core of the AER handling could be identical between native AER
> and GHES/CXL.  If we could do that, maybe we could figure out a
> cleaner way to handle this corner case.


--=20
 i.

--8323328-714307709-1747821432=:946--

