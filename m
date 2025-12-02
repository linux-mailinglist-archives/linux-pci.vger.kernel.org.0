Return-Path: <linux-pci+bounces-42523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65DDC9CC69
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 20:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EED3A1C93
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 19:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34609204F93;
	Tue,  2 Dec 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcTL3Iyl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F5B2D3732;
	Tue,  2 Dec 2025 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704160; cv=none; b=djC9tHNQuCyzr+xzVxCmsPsOGSG5/VD+wDFkjQZwFAVIohZTW3xD5fCgQWrNKNrqltRUSyQd5/HTbSP8L4avjpgatd602clPM4lQp0ltnKavuQIwsYUTyxua22evhvP99ydYXCkDjObto9QbXND5CounbeMj83xswDEV1mDv7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704160; c=relaxed/simple;
	bh=lKrkdhRS1/1oVe9/u4QyZEf5UsdilYCI3qZ+43RZhas=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JmGHh3Ta1a04Eb88MVPHJR7h3hetzg4yYvccuPBFwLzNoeHI2OItUSBJRJtSUcMjh2FBMIFzfykCKFEhCwIh3zM/SFP9OPmX1Fil60EZidXACYeviXT0TdYO3xTO7ljyvk/fjiH9DUC6jmB+cH3/itPj0tEc7Xo5tutnSLR2Mpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcTL3Iyl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764704154; x=1796240154;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=lKrkdhRS1/1oVe9/u4QyZEf5UsdilYCI3qZ+43RZhas=;
  b=CcTL3Iyl9DASbT/nM/rReRgNPvPQvGC7qja93duvcpzPov2wsFIqarns
   /P6ROjxvsB9dvG2wrQqjnSMINxj9b5Wfw6DwB6LiI/v/iVtFp3OZ+rp7G
   jCgWi8ve2D1vomx2NcytGyCPJnHo3R3i53PA9aaGekpJOneZAVsHeZElM
   B1ZN3SYAC2Nrf/DtB+t83bdbl86uBgM21CrZq9wX0w2dANIN+wq1KcUst
   qtsxeABs3obAnv6oqxVY/0XLOpRcXEORcQ2tpHk+Q+yguSgv50TteIPzG
   9LHUpFZ7ip90UuwsNdmdc3H00Y6jnsPdCc+diXHAw4DqTiPuxEkwilnah
   g==;
X-CSE-ConnectionGUID: pFJV5/0HQpGuzHyTzFkSwg==
X-CSE-MsgGUID: mJWcBPHfSnCTFHqa/pNw/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66644589"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="66644589"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 11:35:54 -0800
X-CSE-ConnectionGUID: BFc/QYroSoiyUE/tInV0qA==
X-CSE-MsgGUID: S8FL7X2AR2WW/fSdHWMENA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="193757493"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 11:35:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Dec 2025 21:35:47 +0200 (EET)
To: =?ISO-8859-15?Q?Ren=E9_Rebe?= <rene@exactco.de>
cc: glaubitz@physik.fu-berlin.de, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, bhelgaas@google.com, 
    riccardo.mottola@libero.it
Subject: Re: PCI bridge window issue
In-Reply-To: <20251202.192907.1946164892504460809.rene@exactco.de>
Message-ID: <051199db-1c34-3e70-c028-73f850ff30f0@linux.intel.com>
References: <05c588754dcb83badaec6930499392fdd26be539.camel@physik.fu-berlin.de> <20251202.180451.409161725628042305.rene@exactco.de> <9c120cee-dadf-e5e4-3e27-f817499d27ec@linux.intel.com> <20251202.192907.1946164892504460809.rene@exactco.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1192105531-1764703933=:974"
Content-ID: <a23db443-0a42-040f-539d-ea70d229e092@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1192105531-1764703933=:974
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <51538aa1-52bb-91c0-b8cc-648f8233f624@linux.intel.com>

On Tue, 2 Dec 2025, Ren=E9 Rebe wrote:

> Hi Ilpo,
>=20
> On Tue, 2 Dec 2025 20:20:09 +0200 (EET), Ilpo J=E4rvinen <ilpo.jarvinen@l=
inux.intel.com> wrote:
>=20
> > On Tue, 2 Dec 2025, Ren=E9 Rebe wrote:
> >=20
> > > s390x. Maybe users of those want to allow list after testing? Now tha=
t
> > > I think about it I was wondering why ALSA RAD1 audio is not longer
> > > working in my Sgi Octane with the PCI window not being enabled. Would
> > > not suprise me it was some change like this, too. Should bisect next
> >=20
> > Hi Ren=E9,
> >=20
> > Could you please send me a dmesg and contents of the /proc/iomem (taken=
=20
> > with root right so it shows the real addresses) so I can look at this P=
CI=20
> > bridge window issue. If you know a working kernel, having logs from=20
> > working and broken case would be very helpful to easily locate the=20
> > differences.
>=20
> Thank you so much for offering help with that different
> issue. Sgi/Octane IP30 only went upstream some years ago. I only have
> the likewise not upstream snd-rad1 working with much older out of tree
> kernels. Thanks you for the hints, I'll try to find some time to to
> further debug this soon to bring the snd-rad1 ALSA driver upstream,
> too.

Okay, if it's an old issue, it's likely not because of the recent PCI core=
=20
changes.

If there are "can't assign" or "no compatible bridge window" lines for=20
PCI resources in the log, those happen before some endpoint driver even=20
comes into picture so it could be PCI core issue so in that sense it might=
=20
not matter if the endpoint driver is in-tree or out-of-tree as long as the=
=20
kernel you're testing with is otherwise "new enough" to contain the recent=
=20
changes and fixes to PCI subsystem.

--=20
 i.

> > At this point, no need to bisect as I might be able to figure it out ev=
en=20
> > without pinpointing the commit. To avoid spending on issues that are=20
> > already know and have a fix, please check you're not running somewhat o=
ld=20
> > kernel as I've already fixed a few things that have gotten broken due t=
o=20
> > recent made PCI bridge window fitting and assignment algorithm changes.
>=20
> I can not easily bisect mips64 sgi-ip30 anyway. As it was out of tree
> for 20y and the uptreamed code changed a lot during cleanup for
> merging.
>=20
> Good to have a contact to look into this next.
>=20
> Thanks!
> =09Ren=E9
>=20
>=20
--8323328-1192105531-1764703933=:974--

