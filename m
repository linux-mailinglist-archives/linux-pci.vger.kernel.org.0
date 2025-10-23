Return-Path: <linux-pci+bounces-39179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 833AAC02B79
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 19:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94A024E0679
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5180E29B793;
	Thu, 23 Oct 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjLXJx47"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9126F28F
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240253; cv=none; b=B4E5vBo4rwzWJpAlzd0c7xE4QBKlO8lTkm+w0qSgCU5BRwkaEAo5NTz4vbBvJ8Szoh1VTh4LTTAwlVEF7N//Y7F8NmVUiPtoAE7vGlmUdb5Fll3NlL99GB2x4fsB5hRwcqlRnRvmpdVIW4q4GIBJCY4Xtkd6ruEFTNGNE5k4x2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240253; c=relaxed/simple;
	bh=EONubYqN9mgVYQKzmqacdfnpXC1cir+Pfzg+6xUIhTg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KhKnOFXi3orYGf5C4M1Hl023St/gdsBdMWazItSp1OobUkUDuzEiC0fJqDFDI9DH3Iy/ooK+KGkPGq/tCA7m1Q/NzrnSJU/Vtbd0sKYDezVhNpDPhXnxB77fgBgmwr9yPMmdvEnB87s0eo4Aua1IBamEORn+jNHZ8ESc4I9Ce30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjLXJx47; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761240251; x=1792776251;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=EONubYqN9mgVYQKzmqacdfnpXC1cir+Pfzg+6xUIhTg=;
  b=QjLXJx47reIqxCPKhIxZpiC4nvL6rVwjOUsmn5cAgk6O4RXcynHTn3ty
   D5miH3D7bXyyA2mVHJpmjlKmAaNAI87YTlbrBJC6ptHQok6I4Fp736RBy
   RdqkPnZIeS8ekh2z7K5tQtkhEm0vIT+0waw/Lx45m+iTUYZN0kDTTeOZ7
   UZjnHWH9qpCQph5zv+ZQxbX9+sGs5YvIxQ2Msi0dTGtoSp5eydhSTcegF
   9YUQc7VKY9NT0YiFw2g5aIdGYTVquyq6+Ktm4RsFjLkMZD92T4uQozl5M
   OnkjeznywvOO/h/YTC1mHeJrgLyF0CpMIvBxKOJSc19xua6eaJebNVs7r
   A==;
X-CSE-ConnectionGUID: 6+3kh572T4yWdDpmzFgurQ==
X-CSE-MsgGUID: PWj9EleeR1aQX0ttBYtJsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81044848"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="81044848"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 10:24:10 -0700
X-CSE-ConnectionGUID: hlYtlqUZT3qdu7U/4VxPrw==
X-CSE-MsgGUID: XTKqdRjDQSCE6ukcL1N9Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="184285220"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 10:24:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 23 Oct 2025 20:24:02 +0300 (EEST)
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: linux-pci@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>, 
    Alex Deucher <alexander.deucher@amd.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>, 
    D Scott Phillips <scott@os.amperecomputing.com>
Subject: Re: 2499f53 (PCI: Rework optional resource handling) regression with
 AMDGPU on Arm AVA platform
In-Reply-To: <874irqop6b.fsf@draig.linaro.org>
Message-ID: <6a8559ea-1528-f09c-21c1-822e8d7569d2@linux.intel.com>
References: <874irqop6b.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-887458716-1761237511=:1016"
Content-ID: <37b6cf55-ac82-9b0a-ec20-63d7358bc7d1@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-887458716-1761237511=:1016
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <ac8953db-16c8-44e9-1cb8-85cac05d18f8@linux.intel.com>

On Wed, 22 Oct 2025, Alex Benn=E9e wrote:

> I've been tracking a regression on my Arm64 (Altra) AVA platform between
> 6.14 and 6.15. It looks like the rework commit broke the ability of the
> amdgpu driver to resize it's bar, resulting in an SError and failure to
> boot:
>=20
>   [   15.348097] amdgpu 000d:03:00.0: amdgpu: detected ip block number 8 =
<vcn_v4_0>
>   [   15.355901] amdgpu 000d:03:00.0: amdgpu: detected ip block number 9 =
<jpeg_v4_0>
>   [   15.363202] amdgpu 000d:03:00.0: amdgpu: detected ip block number 10=
 <mes_v11_0>
>   [   15.384163] amdgpu 000d:03:00.0: amdgpu: Fetched VBIOS from ROM BAR
>   [   15.390434] amdgpu: ATOM BIOS: 113-4481LHS-UC1
>   [   15.400079] amdgpu 000d:03:00.0: amdgpu: CP RS64 enable
>   [   15.411830] amdgpu 000d:03:00.0: amdgpu: Trusted Memory Zone (TMZ) f=
eature not supported
>   [   15.419932] amdgpu 000d:03:00.0: amdgpu: PCIE atomic ops is not supp=
orted
>   [   15.426719] [drm] GPU posting now...
>   [   15.430329] [drm] vm size is 262144 GB, 4 levels, block size is 9-bi=
t, fragment size is 9-bit
>   [   15.438871] amdgpu 000d:03:00.0: BAR 2 [mem 0x340010000000-0x3400101=
fffff 64bit pref]: releasing
>   [   15.447648] amdgpu 000d:03:00.0: BAR 0 [mem 0x340000000000-0x34000ff=
fffff 64bit pref]: releasing
>   [   15.456452] pcieport 000d:02:00.0: bridge window [mem 0x340000000000=
-0x340017ffffff 64bit pref]: releasing
>   [   15.466095] pcieport 000d:01:00.0: bridge window [mem 0x340000000000=
-0x340017ffffff 64bit pref]: releasing
>   [   15.475738] pcieport 000d:00:01.0: bridge window [mem 0x340000000000=
-0x340017ffffff 64bit pref]: releasing
>   [   15.485386] pcieport 000d:00:01.0: bridge window [io  0x1000-0x0fff]=
 to [bus 01-03] add_size 1000
>   [   15.494252] pcieport 000d:00:01.0: bridge window [mem 0x340000000000=
-0x3402ffffffff 64bit pref]: assigned
>   [   15.503809] pcieport 000d:00:01.0: bridge window [io  size 0x1000]: =
can't assign; no space
>   [   15.512063] pcieport 000d:00:01.0: bridge window [io  size 0x1000]: =
failed to assign
>   [   15.519796] pcieport 000d:00:01.0: bridge window [io  size 0x1000]: =
can't assign; no space
>   [   15.528049] pcieport 000d:00:01.0: bridge window [io  size 0x1000]: =
failed to assign
>   [   15.535787] pcieport 000d:01:00.0: bridge window [mem 0x340000000000=
-0x3402ffffffff 64bit pref]: assigned
>   [   15.545349] pcieport 000d:02:00.0: bridge window [mem 0x340000000000=
-0x3402ffffffff 64bit pref]: assigned
>   [   15.554911] amdgpu 000d:03:00.0: BAR 0 [mem 0x340000000000-0x3401fff=
fffff 64bit pref]: assigned
>   [   15.563612] amdgpu 000d:03:00.0: BAR 2 [mem 0x340200000000-0x3402001=
fffff 64bit pref]: assigned
>   [   15.572313] pcieport 000d:00:01.0: PCI bridge to [bus 01-03]
>   [   15.577962] pcieport 000d:00:01.0:   bridge window [mem 0x50000000-0=
x502fffff]
>   [   15.585175] pcieport 000d:00:01.0:   bridge window [mem 0x3400000000=
00-0x3402ffffffff 64bit pref]
>   [   15.594038] pcieport 000d:00:01.0: bridge window [mem 0x340000000000=
-0x340017ffffff 64bit pref]: can't claim; address conflict with PCI Bus 000=
d:01 [mem 0x340000000000-0x340017ffffff 64bit pref]
>=20
> Failure to claim space for the bridge window...

Thanks for the report.

I was just looking at a similar oddity from another reporter and thanks=20
this getting second case with an "impossible" claim conflict, I was=20
finally able to zero in on a bug in the resize code which has been there=20
since the introduction of the BAR resizing.

It will take a few days for me to come up fixes that do address also the
problems you'd likely hit next after this claim conflict bug is fixed.

> >From discussions with Ard it seems if the firmware had resized the BAR f=
irst,
> and then assigned the resources, there would be no issue. However there
> is no latter firmware for the platform.

We want to make kernel capable of considering BARs with their maximum=20
sizes eventually so it wouldn't matter what FW does. I've been working=20
towards that direction for a while now but I keep getting distracted by=20
fixing all these other bugs in the existing code. :-)

> While the PCI change has provoked this regression I suspect the amdgpu co=
de
> could handle the failure to resize the BAR better and if it can't get
> what it wants just not initialise the driver. I did hit some cases while
> bisecting where the GPU just wasn't visible.

Indeed, things could be better on multiple levels.

Also the entire pci_resize_resource() API is flawed in that it isn't=20
currently able to restore all device's resources as they were in case of a=
=20
failure. It seems I might have to fix it now as there seem no other way to=
=20
fix this claim conflict problem.

=2E..And fix will be a bit invasive as I need to merge=20
pbus_reassign_bridge_resources() and pci_resize_resource() into a new
pci_release_and_resize_resource() API that handles rollback properly
in case of an error.

> I'm available to test patches and generate additional debug info so do
> let me know if there is anything I can do to help.

Thanks, I'll send the fix series for testing once it is ready.

--
 i.
--8323328-887458716-1761237511=:1016--

