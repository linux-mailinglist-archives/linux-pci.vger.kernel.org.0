Return-Path: <linux-pci+bounces-29202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24434AD1A4B
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 11:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D9A7A430D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EAC24DD09;
	Mon,  9 Jun 2025 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZu+AhBf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C0B20B215;
	Mon,  9 Jun 2025 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749460174; cv=none; b=QUHteeC5k/noem88oorASg3TkFWdrdYyKdez7589vPVikEIZ8zV3hmYTSGNT/v4huxB4krmYTOx+0B+/h+aIQSUshKKnuunjfCOVhSkGZdVMFgAQla3soDN5ceutegG9aSqQG8K7LzShBRhGVUmr8XgqfIXhiPkdJa5SKRArjcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749460174; c=relaxed/simple;
	bh=Y1vVOWFo4+gJd6p52P8AjXxZ0rZeWzBwIFqlFI4KHJU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jsUdLA/dLY+C1MzM2Sp7B8U9cS7BhrgzYjWt+aStL2+IpdeZ3/amWNqbjI4ApHJYj0mf6EQkn1ijj3jXDF41isL8uvgqU2wqj1bseq2RpIsk1W3pdFmGMj4v6H4MdQd1mLsk7gjagRddBmuLSj2G0i0dLb1kcwy+BkzR9y1I6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZu+AhBf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749460172; x=1780996172;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Y1vVOWFo4+gJd6p52P8AjXxZ0rZeWzBwIFqlFI4KHJU=;
  b=FZu+AhBfoTyEu9DlJVjr+wpSWXugmBPWxwFuijLwHz8AdGKpfM7Y69ZR
   4hwgI9ZvTiOzVXkUjSkLMM4td89iZDL4cW1ip0i//geK4sWHhtGLo9u1T
   vnhStYM4NQBsvjhZcVWRRm95EnwlkY5h7EhM0hVO3h0hbqAf30A5q9WX1
   syb0lX4tB+PKa5e1+e/Uk/SQC3h2aws+puCrGcd7UFKckcajFHksEPCGn
   ofRyIO8rJNxefgeTHTygsWJXmzJutf245/Yx51erWXhd8Ki5RRHFrNwY6
   IJR90f+ktHAQFVX4Yj+sPdgjXmyHdh/On+7ZF+0E1prxy/sHf2tXd1ttJ
   w==;
X-CSE-ConnectionGUID: pLY4OCdPRhKAdMDUErVOUQ==
X-CSE-MsgGUID: 0aHxJxC7TnqvuFClsJt3rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="55320939"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="55320939"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 02:09:31 -0700
X-CSE-ConnectionGUID: /ONzoxthTrqs7xbHNMQu9A==
X-CSE-MsgGUID: yeDvTaq8TMa9aQRJqz0s8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="147387897"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 02:09:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Jun 2025 12:09:25 +0300 (EEST)
To: rio@r26.me
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    "regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
    "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [REGRESSION] amdgpu fails to load external RX 580 since PCI:
 Allow relaxed bridge window tail sizing for optional resources
In-Reply-To: <o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NOzOW1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=@r26.me>
Message-ID: <7a7a3619-902c-06ee-6171-6d8ec2107f97@linux.intel.com>
References: <o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NOzOW1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=@r26.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-653391715-1749460165=:948"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-653391715-1749460165=:948
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 9 Jun 2025, rio@r26.me wrote:

> Hello,
>=20
> I have an external Radeon RX580 on my machine connected via Thunderbolt, =
and
> since upgrading from 6.14.1 the setup stopped working. Dmesg showed warni=
ng from
> resource sanity check, followed by a stack trace https://pastebin.com/njR=
55rQW.
> Relevant snippet:
>=20
> [   12.134907] amdgpu 0000:06:00.0: BAR 2 [mem 0x6000000000-0x60001fffff =
64bit pref]: releasing
> [   12.134910] [drm:amdgpu_device_resize_fb_bar [amdgpu]] *ERROR* Problem=
 resizing BAR0 (-16).
> [   12.135456] amdgpu 0000:06:00.0: BAR 2 [mem 0x6000000000-0x60001fffff =
64bit pref]: assigned
> [   12.135524] amdgpu 0000:06:00.0: amdgpu: VRAM: 8192M 0x000000F40000000=
0 - 0x000000F5FFFFFFFF (8192M used)
> [   12.135527] amdgpu 0000:06:00.0: amdgpu: GART: 256M 0x000000FF00000000=
 - 0x000000FF0FFFFFFF
> [   12.135536] resource: resource sanity check: requesting [mem 0x0000000=
000000000-0xffffffffffffffff], which spans more than PCI Bus 0000:00 [mem 0=
x000a0000-0x000bffff window]
> [   12.135542] ------------[ cut here ]------------
> [   12.135543] WARNING: CPU: 6 PID: 599 at arch/x86/mm/pat/memtype.c:721 =
memtype_reserve_io+0xfc/0x110
> [   12.135551] Modules linked in: ccm amdgpu(+) snd_hda_codec_realtek ...
> [   12.135652] CPU: 6 UID: 0 PID: 599 Comm: (udev-worker) Tainted: G S   =
               6.15.0-13743-g8630c59e9936 #16 PREEMPT(full)  3b462c924b3ffd=
8156fc3b77bcc8ddbf7257fa57
> [   12.135654] Tainted: [S]=3DCPU_OUT_OF_SPEC
> [   12.135655] Hardware name: COPELION INTERNATIONAL INC. ZX Series/ZX Se=
ries, BIOS 1.07.08TCOP3 03/27/2020
> [   12.135656] RIP: 0010:memtype_reserve_io+0xfc/0x110
> [   12.135659] Code: aa fb ff ff b8 f0 ff ff ff eb 88 8b 54 24 04 4c 89 e=
e 48 89 df e8 04 fe ff ff 85 c0 75 db 8b 54 24 04 41 89 16 e9 69 ff ff ff <=
0f> 0b e9 4b ff ff ff e8 b8 5c fc 00 0f 1f 84 00 00 00 00 00 90 90
>=20
> Bisecting the stable branch pointed me to the following commit:
>=20
> commit 22df32c984be9e9145978acf011642da042a2af3 (HEAD)
> Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Date:   Mon Dec 16 19:56:11 2024 +0200
>=20
>     PCI: Allow relaxed bridge window tail sizing for optional resources
>    =20
>     [ Upstream commit 67f9085596ee55dd27b540ca6088ba0717ee511c ]
>=20
> I've tested on stable (as of now 8630c59e99363c4b655788fd01134aef9bcd9264=
), and
> the issue persists. Reverting the offending commit via `git revert -n
> 22df32c984be9e9145978acf011642da042a2af3` allowed amdgpu to load again.
> Dmesg: https://pastebin.com/xd76rDsW.
>=20
> Additional information
>    - Distribution: Artix
>    - Arch: x86_64
>    - Kernel config: https://pastebin.com/DWSERJL5
>    - eGPU adapter: https://www.adt.link/product/R43SG-TB3.html
>    - Booting with pci=3Drealloc,hpbussize=3D0x33,hpmmiosize=3D256M,hpmmio=
prefsize=3D1G
>=20
> I'm reporting here as these are the contacts from the commit message.=20
> Please let me know if there's a more appropriate place for this, as well=
=20
> as any more information I can provide.=20

Hi Rio,

Thanks for the report and I'm sorry about causing this issue. Could you=20
please try if the patch below solves the issue.

--
From=20b94823a193032b5f87114cff9e8edc5c67e4ef40 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.intel=
=2Ecom>
Date: Mon, 9 Jun 2025 12:05:20 +0300
Subject: [PATCH 1/1] PCI: Relaxed alignment should never increase min_align
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

When using relaxed tail alignment for the bridge window,
pbus_size_mem() also tries to minimize min_align, which can under
certain scenarios end up increasing min_align from that found by
calculate_mem_align().

Ensure min_align is not increased by the relaxed tail alignment.

Eventually, it would be better to add calculate_relaxed_head_align()
similar to calculate_mem_align() which finds out what alignment can be
used for the head without introducing any gaps into the bridge window
to give flexibility on head address too. But that looks relatively
complex algorithm so it requires much more testing than fixing the
immediate problem causing a regression.

Reported-by: Rio <rio@r26.me>
Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 07c3d021a47e..f90d49cd07da 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1169,6 +1169,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigne=
d long mask,
 =09resource_size_t children_add_size =3D 0;
 =09resource_size_t children_add_align =3D 0;
 =09resource_size_t add_align =3D 0;
+=09resource_size_t relaxed_align;
=20
 =09if (!b_res)
 =09=09return -ENOSPC;
@@ -1246,8 +1247,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigne=
d long mask,
 =09if (bus->self && size0 &&
 =09    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, typ=
e,
 =09=09=09=09=09   size0, min_align)) {
-=09=09min_align =3D 1ULL << (max_order + __ffs(SZ_1M));
-=09=09min_align =3D max(min_align, win_align);
+=09=09relaxed_align =3D 1ULL << (max_order + __ffs(SZ_1M));
+=09=09relaxed_align =3D max(relaxed_align, win_align);
+=09=09min_align =3D min(min_align, relaxed_align);
 =09=09size0 =3D calculate_memsize(size, min_size, 0, 0, resource_size(b_re=
s), win_align);
 =09=09pci_info(bus->self, "bridge window %pR to %pR requires relaxed align=
ment rules\n",
 =09=09=09 b_res, &bus->busn_res);
@@ -1261,8 +1263,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigne=
d long mask,
 =09=09if (bus->self && size1 &&
 =09=09    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, =
type,
 =09=09=09=09=09=09   size1, add_align)) {
-=09=09=09min_align =3D 1ULL << (max_order + __ffs(SZ_1M));
-=09=09=09min_align =3D max(min_align, win_align);
+=09=09=09relaxed_align =3D 1ULL << (max_order + __ffs(SZ_1M));
+=09=09=09relaxed_align =3D max(min_align, win_align);
+=09=09=09min_align =3D min(min_align, relaxed_align);
 =09=09=09size1 =3D calculate_memsize(size, min_size, add_size, children_ad=
d_size,
 =09=09=09=09=09=09  resource_size(b_res), win_align);
 =09=09=09pci_info(bus->self,

base-commit: 3719a04a80caf660f899a462cd8f3973bcfa676e
--=20
2.39.5

--8323328-653391715-1749460165=:948--

