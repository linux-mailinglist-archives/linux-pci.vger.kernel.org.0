Return-Path: <linux-pci+bounces-29251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2A2AD24B6
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 19:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736DC3A0F80
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 17:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9421F17E8;
	Mon,  9 Jun 2025 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KljyoXn+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20366217654;
	Mon,  9 Jun 2025 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488843; cv=none; b=nxx/g3X1Ytm8/6bopzA78hDPC/paGXlPh3t1YkRPIZEdqj1jm5L4nHZh8wDs+2wQI/kgNVGKlmWP9j1bJ/OWOhawx953OoOxm7erZSNxvyQ3qVn2chPL2YB6csgFHokUSLTTkaQL2+S26QYqLm7GoFf8yZH2Z9KHQWAEULu4p3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488843; c=relaxed/simple;
	bh=OYlhw1BjPK/7EbV6p8FJaWqGvxNhb0veN1hYTUnaj4Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ggdBWMYy6phxK6kI7dpnxqFRBNUuZMlI9IlI35iP1DbBGGga+Ymw+7L0yUWEvJBUVGQfDfgJr76mhFFZnFaeeobZS62tgwqXYVR1n07JCQhD+VvxZxP0wFyj7DfyOP6qRAQRYosuWPjgfrA/VgWHSFOgKEhPGgyfKyqPvZSHNn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KljyoXn+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749488842; x=1781024842;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OYlhw1BjPK/7EbV6p8FJaWqGvxNhb0veN1hYTUnaj4Y=;
  b=KljyoXn+lzFKlmt4ww3R4sT+o7RNcZTQTAarB1DJPdrWWnBlvqQzCeCl
   Lc7z4wnjztH4d0QINUdvOv8fqFGCL7hpZVq8S75PDlvFmTZMa037FwXYg
   qUWl6jwOTNrtSsvJg8YzMGPM/t+/XkkMyfSkWILu0uIMwPjtsjUGc3oAK
   95MwwyNloptDrkNDYuWAUS8uBtZpWmerm1H46QHaADpuRTHWR+2WUHate
   j3q2WajSnOlnCAuX8tjGDOwNYQy1PmeU/aXMLn5EysnfqH/bVoL3jhrqu
   kVFcWrExHqgHPftjc73KUzYoda3pmefp57Nlr59GctgqhBCpR3wcA4SqF
   w==;
X-CSE-ConnectionGUID: 6+SHvUyGSymlxJt729tYzw==
X-CSE-MsgGUID: RACGii1HS+6/YGS8c64fRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51667951"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="51667951"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 10:07:14 -0700
X-CSE-ConnectionGUID: OXgICkbPTXS3J8IOECVJMQ==
X-CSE-MsgGUID: dYCtnEJKRuW1WrA2HPYLIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="146924028"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 10:07:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Jun 2025 20:07:06 +0300 (EEST)
To: Rio Liu <rio@r26.me>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    "regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
    "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [REGRESSION] amdgpu fails to load external RX 580 since PCI:
 Allow relaxed bridge window tail sizing for optional resources
In-Reply-To: <w3gGcmhWNmeGetzLnhgkjfx0JTEyIOKN5sDu-uShZ_7JWthMgGP6plgDuhDbkYyaA7vtGbdl1WbMTZ5zM80OyJoqUa69krqDpuhqDangkLY=@r26.me>
Message-ID: <21d41e66-d019-31c7-1e73-fed80cf54965@linux.intel.com>
References: <o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NOzOW1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=@r26.me> <7a7a3619-902c-06ee-6171-6d8ec2107f97@linux.intel.com>
 <w3gGcmhWNmeGetzLnhgkjfx0JTEyIOKN5sDu-uShZ_7JWthMgGP6plgDuhDbkYyaA7vtGbdl1WbMTZ5zM80OyJoqUa69krqDpuhqDangkLY=@r26.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-169176343-1749488826=:948"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-169176343-1749488826=:948
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 9 Jun 2025, Rio Liu wrote:
> On Monday, June 9th, 2025 at AM 5:09, Ilpo J=C3=A4rvinen <ilpo.jarvinen@l=
inux.intel.com> wrote:
> > On Mon, 9 Jun 2025, rio@r26.me wrote:
> >=20
> > > I have an external Radeon RX580 on my machine connected via Thunderbo=
lt, and
> > > since upgrading from 6.14.1 the setup stopped working. Dmesg showed w=
arning from
> > > resource sanity check, followed by a stack trace https://pastebin.com=
/njR55rQW.
> > > Relevant snippet:
> > >=20
> > > [ 12.134907] amdgpu 0000:06:00.0: BAR 2 [mem 0x6000000000-0x60001ffff=
f 64bit pref]: releasing
> > > [ 12.134910] [drm:amdgpu_device_resize_fb_bar [amdgpu]] ERROR Problem=
 resizing BAR0 (-16).
> > > [ 12.135456] amdgpu 0000:06:00.0: BAR 2 [mem 0x6000000000-0x60001ffff=
f 64bit pref]: assigned
> > > [ 12.135524] amdgpu 0000:06:00.0: amdgpu: VRAM: 8192M 0x000000F400000=
000 - 0x000000F5FFFFFFFF (8192M used)
> > > [ 12.135527] amdgpu 0000:06:00.0: amdgpu: GART: 256M 0x000000FF000000=
00 - 0x000000FF0FFFFFFF
> > > [ 12.135536] resource: resource sanity check: requesting [mem 0x00000=
00000000000-0xffffffffffffffff], which spans more than PCI Bus 0000:00 [mem=
 0x000a0000-0x000bffff window]
> > > [ 12.135542] ------------[ cut here ]------------
> > > [ 12.135543] WARNING: CPU: 6 PID: 599 at arch/x86/mm/pat/memtype.c:72=
1 memtype_reserve_io+0xfc/0x110
> > > [ 12.135551] Modules linked in: ccm amdgpu(+) snd_hda_codec_realtek .=
=2E.
> > > [ 12.135652] CPU: 6 UID: 0 PID: 599 Comm: (udev-worker) Tainted: G S =
6.15.0-13743-g8630c59e9936 #16 PREEMPT(full) 3b462c924b3ffd8156fc3b77bcc8dd=
bf7257fa57
> > > [ 12.135654] Tainted: [S]=3DCPU_OUT_OF_SPEC
> > > [ 12.135655] Hardware name: COPELION INTERNATIONAL INC. ZX Series/ZX =
Series, BIOS 1.07.08TCOP3 03/27/2020
> > > [ 12.135656] RIP: 0010:memtype_reserve_io+0xfc/0x110
> > > [ 12.135659] Code: aa fb ff ff b8 f0 ff ff ff eb 88 8b 54 24 04 4c 89=
 ee 48 89 df e8 04 fe ff ff 85 c0 75 db 8b 54 24 04 41 89 16 e9 69 ff ff ff=
 <0f> 0b e9 4b ff ff ff e8 b8 5c fc 00 0f 1f 84 00 00 00 00 00 90 90
> > >=20
> > > Bisecting the stable branch pointed me to the following commit:
> > >=20
> > > commit 22df32c984be9e9145978acf011642da042a2af3 (HEAD)
> > > Author: Ilpo J=C3=A4rvinen ilpo.jarvinen@linux.intel.com
> > > Date: Mon Dec 16 19:56:11 2024 +0200
> > >=20
> > > PCI: Allow relaxed bridge window tail sizing for optional resources
> > >=20
> > > [ Upstream commit 67f9085596ee55dd27b540ca6088ba0717ee511c ]
> > >=20
> > > I've tested on stable (as of now 8630c59e99363c4b655788fd01134aef9bcd=
9264), and
> > > the issue persists. Reverting the offending commit via `git revert -n=
 22df32c984be9e9145978acf011642da042a2af3` allowed amdgpu to load again.
> > > Dmesg: https://pastebin.com/xd76rDsW.
> > >=20
> > > Additional information
> > > - Distribution: Artix
> > > - Arch: x86_64
> > > - Kernel config: https://pastebin.com/DWSERJL5
> > > - eGPU adapter: https://www.adt.link/product/R43SG-TB3.html
> > > - Booting with pci=3Drealloc,hpbussize=3D0x33,hpmmiosize=3D256M,hpmmi=
oprefsize=3D1G
> > >=20
> > > I'm reporting here as these are the contacts from the commit message.
> > > Please let me know if there's a more appropriate place for this, as w=
ell
> > > as any more information I can provide.
> >=20
> >=20
> > Hi Rio,
> >=20
> > Thanks for the report and I'm sorry about causing this issue. Could you
> > please try if the patch below solves the issue.
> >=20
> > --
> > From b94823a193032b5f87114cff9e8edc5c67e4ef40 Mon Sep 17 00:00:00 2001
> > From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D ilpo.jarvinen@linux.in=
tel.com
> >=20
> > Date: Mon, 9 Jun 2025 12:05:20 +0300
> > Subject: [PATCH 1/1] PCI: Relaxed alignment should never increase min_a=
lign
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
> >=20
> > When using relaxed tail alignment for the bridge window,
> > pbus_size_mem() also tries to minimize min_align, which can under
> > certain scenarios end up increasing min_align from that found by
> > calculate_mem_align().
> >=20
> > Ensure min_align is not increased by the relaxed tail alignment.
> >=20
> > Eventually, it would be better to add calculate_relaxed_head_align()
> > similar to calculate_mem_align() which finds out what alignment can be
> > used for the head without introducing any gaps into the bridge window
> > to give flexibility on head address too. But that looks relatively
> > complex algorithm so it requires much more testing than fixing the
> > immediate problem causing a regression.
> >=20
> > Reported-by: Rio rio@r26.me
> >=20
> > Signed-off-by: Ilpo J=C3=A4rvinen ilpo.jarvinen@linux.intel.com
> >=20
> > ---
> > drivers/pci/setup-bus.c | 11 +++++++----
> > 1 file changed, 7 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 07c3d021a47e..f90d49cd07da 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1169,6 +1169,7 @@ static int pbus_size_mem(struct pci_bus *bus, uns=
igned long mask,
> > resource_size_t children_add_size =3D 0;
> > resource_size_t children_add_align =3D 0;
> > resource_size_t add_align =3D 0;
> > + resource_size_t relaxed_align;
> >=20
> > if (!b_res)
> > return -ENOSPC;
> > @@ -1246,8 +1247,9 @@ static int pbus_size_mem(struct pci_bus *bus, uns=
igned long mask,
> > if (bus->self && size0 &&
> >=20
> > !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
> > size0, min_align)) {
> > - min_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> > - min_align =3D max(min_align, win_align);
> > + relaxed_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> > + relaxed_align =3D max(relaxed_align, win_align);
> > + min_align =3D min(min_align, relaxed_align);
> > size0 =3D calculate_memsize(size, min_size, 0, 0, resource_size(b_res),=
 win_align);
> > pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignmen=
t rules\n",
> >=20
> > b_res, &bus->busn_res);
> >=20
> > @@ -1261,8 +1263,9 @@ static int pbus_size_mem(struct pci_bus *bus, uns=
igned long mask,
> > if (bus->self && size1 &&
> >=20
> > !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
> > size1, add_align)) {
> > - min_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> > - min_align =3D max(min_align, win_align);
> > + relaxed_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> > + relaxed_align =3D max(min_align, win_align);
> > + min_align =3D min(min_align, relaxed_align);
> > size1 =3D calculate_memsize(size, min_size, add_size, children_add_size=
,
> > resource_size(b_res), win_align);
> > pci_info(bus->self,
> >=20
> >=20
> > base-commit: 3719a04a80caf660f899a462cd8f3973bcfa676e
> > --
> > 2.39.5
>=20
> Hello Ilpo,
>=20
> I've tested the patch and it seems to fix the issue. Thank you!

Great, thanks for testing.

If you want, you can give your Tested-by tag so I can include it into the=
=20
official submission of the fix.

--=20
 i.

--8323328-169176343-1749488826=:948--

