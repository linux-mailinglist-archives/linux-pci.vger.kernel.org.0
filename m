Return-Path: <linux-pci+bounces-37925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB1EBD4C00
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B123E74F3
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF95831063B;
	Mon, 13 Oct 2025 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzkzm7ev"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B329C31B807
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369784; cv=none; b=J8m0JGBTYWtN4WgkAVTMks2LVP/PktclTTKgWKLIxB/695t++/h366qoyx8JAm0IWpy3o3+755gkp9iFIVuuLCQTG3fkkzBiQDpxb3dHhxMWxUAgIJBpK08Bu7lZfy6W/BgyGhszlbbTfbH4bY63UC+0BBBppE5Y8v1myXE0eLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369784; c=relaxed/simple;
	bh=EcAScP8kWJYcjBhUA++ZM+u5kxXirSV8VoqH6FPC2o4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mZSdDBO8M7Kr5E86wY1XUK3lssp+mqhze3PWwqBxa5hCDhxoAAk8k/3c1b4aTxBO3DB7cvK+YmFrVEX/7LXmOkOHpvNTSe77r1b4ZPyxvPC7/KtWIoElfrtbD527XvQffx1fnRaDPA0fh0pUjr9ckDI8/6y+MZVQcwCamnMJAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzkzm7ev; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760369783; x=1791905783;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EcAScP8kWJYcjBhUA++ZM+u5kxXirSV8VoqH6FPC2o4=;
  b=fzkzm7evallCOZHSqFBXs2YImswuBJCKn08Eq7dhVCZInoQBqCuojiA9
   pN1Z18WkSvYDvX+jHHixhUlB/JqPTp4cbBSAbhran/D9DbhOv/1xZdmiS
   niIxlGlzO5E3A6WHdHqhBBgFixgTSWoNUdRdTXoC/pinwxBfoz6etnxIs
   56BCxKjR9aHHwgp/p8PybE51L4bTZWc68MvhhhnSzlAc50yTr9kxBsHhA
   BYcwQW1tmNlLLw9p5gDmwmluT9hkXw1ViBfjeteAbLbAR3EQJQL2sU4jE
   SMzC/xZcANRoiAD81ZwjV/dwW1jGFm9GinO/ZHdckMB5m81jSCEwqCZef
   w==;
X-CSE-ConnectionGUID: rxJeq5SeQX+YIP8e5k5iig==
X-CSE-MsgGUID: eQ51SULUSc2BhbpdwG/4sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66335796"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66335796"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 08:36:22 -0700
X-CSE-ConnectionGUID: bb315DzDS56JlaeOxpuVYQ==
X-CSE-MsgGUID: YCj5rocPRl+nK1ONFB7Rgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="205320380"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.77])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 08:36:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Oct 2025 18:36:16 +0300 (EEST)
To: Thomas Zimmermann <tzimmermann@suse.de>
cc: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com, 
    bhelgaas@google.com, Eric Biggers <ebiggers@kernel.org>, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/VGA: Select SCREEN_INFO
In-Reply-To: <a7870faa-9c31-435b-b043-9f3ba1cbdcee@suse.de>
Message-ID: <f4df0e28-5d45-44aa-e7b9-2d5d075ea649@linux.intel.com>
References: <20251013135929.913441-1-superm1@kernel.org> <f36a943e-73bb-97ce-83bc-56aa0e1b5267@linux.intel.com> <6dd53ff9-2398-4756-9c13-c082f1c01d4b@kernel.org> <56b866bd-d1ad-3be3-a6a6-ed726aa1f9ef@linux.intel.com>
 <a7870faa-9c31-435b-b043-9f3ba1cbdcee@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2021188991-1760369776=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2021188991-1760369776=:933
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 13 Oct 2025, Thomas Zimmermann wrote:
> Am 13.10.25 um 16:35 schrieb Ilpo J=C3=A4rvinen:
> > On Mon, 13 Oct 2025, Mario Limonciello wrote:
> >=20
> > > On 10/13/25 9:16 AM, Ilpo J=C3=A4rvinen wrote:
> > > > On Mon, 13 Oct 2025, Mario Limonciello (AMD) wrote:
> > > >=20
> > > > > commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default()=
 with
> > > > > a screen info check") introduced an implicit dependency upon
> > > > > SCREEN_INFO
> > > > > by removing the open coded implementation.
> > > > >=20
> > > > > If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_defa=
ult()
> > > > > would now return false.  Add a select for SCREEN_INFO to ensure t=
hat
> > > > > the
> > > > > VGA arbiter works as intended.
> > > > >=20
> > > > > Reported-by: Eric Biggers <ebiggers@kernel.org>
> > > > > Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@s=
ol/
> > > > > Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > > > Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default()=
 with
> > > > > a
> > > > > screen info check")
> > > > > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > > > > ---
> > > > >    drivers/pci/Kconfig | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > >=20
> > > > > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > > > > index 7065a8e5f9b14..c35fed47addd5 100644
> > > > > --- a/drivers/pci/Kconfig
> > > > > +++ b/drivers/pci/Kconfig
> > > > > @@ -306,6 +306,7 @@ config VGA_ARB
> > > > >    =09bool "VGA Arbitration" if EXPERT
> > > > >    =09default y
> > > > >    =09depends on (PCI && !S390)
> > > > > +=09select SCREEN_INFO
> > > > >    =09help
> > > > >    =09  Some "legacy" VGA devices implemented on PCI typically ha=
ve
> > > > > the same
> > > > >    =09  hard-decoded addresses as they did on ISA. When multiple =
PCI
> > > > > devices
> > > > The commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default=
()
> > > > with
> > > > a screen info check") also changed to #ifdef CONFIG_SCREEN_INFO aro=
und
> > > > the
> > > > call, but that now becomes superfluous with this select, no?
> > > Thanks! Will adjust.
>=20
> Yes, thanks. You can no longer run into this #else.
>=20
> > >=20
> > > > Looking into the history of the ifdefs here is quite odd pattern (o=
nly
> > > > the last one comes with some explanation but even that is on the va=
gue
> > > > side and fails to remove the actual now unnecessary ifdef :-/):
> > > >=20
> > > > #if defined(CONFIG_X86) -> #if defined(CONFIG_X86) -> select SCREEN=
_INFO
> > > >=20
> > > > Was it intentional to allow building without CONFIG_SCREEN_INFO?
> > > >=20
> > > You mean in the VGA arbiter code?  Or just in general?
> > Here in the VGA arbiter. I'm just trying to understand why the #else pa=
rt
> > was here post-337bf13aa9dda.
>=20
> The #else branch used to return false (i.e., the device is not the defaul=
t).=C2=A0
> But this was only used internally by fbcon for minor features. So it real=
ly
> didn't matter that much.
>=20
> Now we need the default for userspace, hence we likely should have an #el=
se
> branch at all.

Thanks for the explanation.

--=20
 i.

--8323328-2021188991-1760369776=:933--

