Return-Path: <linux-pci+bounces-41982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE3BC824A2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 20:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAFC34E8981
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 19:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544472DEA68;
	Mon, 24 Nov 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuEHxk+I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5522D63F6;
	Mon, 24 Nov 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011945; cv=none; b=VYTEF/DBAnhPBULoKH5IT+cnQUt9tFM56C8cz75MzxZr3hzbKL2vstPTMBqp4WuURRVeSGDAcIg0WhC30Cx5mvMWGkrD6i3Tayo2W/s9K6tAP3j3UlXaeAVU6r8lznKCht2fqBtVMwtaP23fYRlnTutqb0xhbLBs8cID2pZT9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011945; c=relaxed/simple;
	bh=B2rGpi+k3MfKXiHktufnR/jxW2hc9aZh2nEhtPZLmUw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ba5dZdm8xZfYJimjiEWcMU5qt70x/rTw7VZNaCGdy9qWBjBvY0I46ooYAlCBykG14WfIHnmnzq1pMw2gwLvW2llPs8JwUapF2KmmdeA0PNcsmD5tXDQYiROUze/WcR9ngMhtdwm8VDMPBwKxezrYm+vmARv75AAFaUSzaq8AZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuEHxk+I; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764011943; x=1795547943;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=B2rGpi+k3MfKXiHktufnR/jxW2hc9aZh2nEhtPZLmUw=;
  b=IuEHxk+ItqOINqFiIXl4dN+7Q9RzxfaopXL4fIci7FXEcEn4LIB/3WSB
   PSKi8GTHalGUDQ0yT0Bjod0d6/7pXuyDX72ziYDZWv0LeQ/x1kOCBOixP
   FRDcBJixen827EyT3JMiRCY7d/iYcNKJeyKtjlKgHmfW/ae0EYGYWMJKa
   0DGXrAJ4i2HAByIpNa7qZjQxmOt2BcgGcpJ+jeDNjTlGcEsargkAPj2pS
   cRHmUbKylrt+gRFUW2PdiDj5F6ZpO+WiP1tkGuNf1vd4ujBgajajZY08R
   6/3q1F8w1jTXLEU2Xej1/j7Qb2MjcY321frMf6nuI4MI1S7J9+W+U0W6p
   A==;
X-CSE-ConnectionGUID: 1Qf7LgsZSU+t4V3+08frLA==
X-CSE-MsgGUID: I7Mmzvo4Sl28p0R5tM2xHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65964624"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="65964624"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 11:19:02 -0800
X-CSE-ConnectionGUID: 81cjfa7ASRelEumc1EDznQ==
X-CSE-MsgGUID: x98jZPD2SQ+Bsjp6YWd6WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="215759802"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.97])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 11:19:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Nov 2025 21:18:57 +0200 (EET)
To: Hinko Kocevar <Hinko.Kocevar@ess.eu>
cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    "bhelgaas@google.com" <bhelgaas@google.com>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] PCIe hotplug behind PEX8748: bridge window allocation
 failures when moving AMC between adjacent downstream ports
In-Reply-To: <GV2PR10MB6672E198F632F5903E27AEF283D0A@GV2PR10MB6672.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <7468e936-1a16-3971-283a-9d4d77fe3b35@linux.intel.com>
References: <GV2PR10MB6672E198F632F5903E27AEF283D0A@GV2PR10MB6672.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1614741206-1763998322=:1076"
Content-ID: <0f38d5b7-8468-b31f-f2e9-32e6165129ed@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1614741206-1763998322=:1076
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <1bbfb757-da95-c26b-3b55-ae50ff57c20f@linux.intel.com>

On Mon, 24 Nov 2025, Hinko Kocevar wrote:

> Hello,
>=20
> I am observing reproducible PCIe hotplug resource allocation failures on=
=20
> Linux 6.18.0-rc7 in a MicroTCA system with an Intel Q170-based CPU board=
=20
> and a PLX PEX8725 / PEX8748 PCIe switch hierarchy. Earlier stock=20
> versions of the kernel (6.11, 6.8) fail with similar symptoms.=20
>=20
> An AMC card with a small 256 KiB BAR works correctly at boot, and also=20
> works when hot-removed and reinserted into the *same* slot. However,=20
> when reinserted into an adjacent slot, the kernel fails to assign even a=
=20
> 256 KiB BAR, with repeated messages of:
>=20
> bridge window [mem size X]: can't assign; no space
> pci <endpoint>: BAR 0 [...] failed to assign
>=20
>=20
> This occurs with vanilla Linux built from git, with no pci=3D cmdline=20
> options, and with Above-4G decoding enabled in CPU BIOS.
>=20
> I have (see attached file for details on PCI resources):
>=20
> * CPU board: Intel Q170 chipset
> * Root port =E2=86=92 PEX8725 (01:00.0) =E2=86=92 PEX8748 (03:00.0) =E2=
=86=92 downstream ports 04:00.0 .. 04:12.0
> * AMC card under test:
>   * 10ee:7011, Xilinx 7-Series PCIe endpoint
>   * Single BAR0 of 0x40000 bytes
>=20
> This AMC works normally at boot and functions under the `mrf-pci` driver.
>=20
> Reproduce error sequence:
>=20
> 1. Remove AMC
>=20
> [  840.371432] pcieport 0000:04:0b.0: pciehp: Slot(12): Button press: wil=
l power off in 5 sec
> [  845.448242] mrf-pci 0000:0c:00.0: MRF Cleaned up
>=20
> 2. Reinsert into SAME slot (Slot 12) =E2=86=92 SUCCESS
>=20
> The kernel cannot allocate IO windows, but *BAR 0 is successfully assigne=
d*:
>=20
> [  865.689276] pcieport 0000:04:0b.0: pciehp: Slot(12): Link Up
> [  866.687797] pci 0000:0c:00.0: [10ee:7011]
> [  866.687952] pci 0000:0c:00.0: BAR 0 [mem 0x00000000-0x0003ffff]
>=20
> [  866.688528] pci 0000:0c:00.0: BAR 0 [mem 0xdf000000-0xdf03ffff]: assig=
ned
>=20
> [  866.689539] mrf-pci 0000:0c:00.0: MRF Setup complete
>=20
> The device is operational.
>=20
> 3. Remove AMC and insert into ADJACENT slot (Slot 11) =E2=86=92 FAILURE
>=20
> When moved to a neighboring downstream PEX8748 port, BAR assignment fails=
 repeatedly:
>=20
> [  952.268260] pcieport 0000:04:09.0: pciehp: Slot(11): Card present
> [  953.367876] pci 0000:0a:00.0: [10ee:7011]
> [  953.368008] pci 0000:0a:00.0: BAR 0 [mem 0x00000000-0x0003ffff]
>=20
> [  953.368506] pcieport 0000:04:09.0: bridge window [mem size 0x00200000]=
: can't assign; no space
> [  953.368515] pcieport 0000:04:09.0: bridge window [mem size 0x00200000 =
64bit pref]: can't assign; no space
> [  953.368544] pci 0000:0a:00.0: BAR 0 [mem size 0x00040000]: can't assig=
n; no space
> [  953.368553] pci 0000:0a:00.0: BAR 0 [mem size 0x00040000]: failed to a=
ssign
>=20
> [  953.369048] mrf-pci 0000:0a:00.0: can't ioremap BAR 0: [??? 0x00000000=
 flags 0x0]
> [  953.369054] mrf-pci 0000:0a:00.0: Failed to map BARS!
>=20
>=20
> The kernel repeatedly tries to reserve 2 MiB bridge windows for this=20
> port (size 0x00200000), even though the only required resource is a 256=
=20
> KiB EP BAR.
>=20
> Why this appears to be a kernel bug?
>=20
> * The endpoint BAR is small (256 KiB).
> * Hotplug into the same slot succeeds.
> * Hotplug into an adjacent slot fails, with oversized bridge windows requ=
ested.
> * Cold boot always succeeds.
> * The hotplug sizing logic seems to request windows much larger than nece=
ssary.

Hi,

There are two things which can make kernel to request more memory than=20
needed:

- window reserved for hotplug that can be controlled with pci=3Dhpmmiosize=
=3D=20
on the kernel's command line (defaults to DEFAULT_HOTPLUG_MMIO_SIZE which i=
s 2M)

- old_size in calculate_memsize().

I did a patch to remove old_size, it is here (not sure yet if it will go=20
mainline in this form as there's some regression potential):

https://lore.kernel.org/linux-pci/922b1f68-a6a2-269b-880c-d594f9ca6bde@linu=
x.intel.com/

pci=3Drealloc might help though (but it's also possible it breaks=20
things because it's rollback isn't as robust as I'd like).


Looking your log, it's unclear why this allocation is so small:

[    0.424748] pci 0000:01:00.0: bridge window [mem 0x00100000-0x00cfffff 6=
4bit pref] to [bus 02-13] add_size 1800000 add_align 100000
=2E..
[    0.424811] pci 0000:01:00.0: bridge window [mem 0x90000000-0x90bfffff 6=
4bit pref]: assigned

It seems to not include that add_size for some reason while making the=20
allocation (assignment). __assign_resources_sorted() should try to apply=20
the add_sizes into the resources (it's first loop) before assigning them.=
=20
It seems to work for this:

[    0.424780] pci 0000:00:01.0: bridge window [mem 0x90000000-0x923fffff 6=
4bit pref]: assigned

But not for the 0000:01:00.0 for some reason. You might want to figure=20
that out somehow, e.g., by adding some pci_*() prints here and there.

> * The switch hierarchy is complex but static and stable; only the endpoin=
t moves.
>=20
> Given this pattern, it appears that the bridge-window sizing policy=20
> during hotplug is too conservative for switch-dense topologies like=20
> PEX8748, and the result is an inability to allocate resources for=20
> perfectly normal devices.=20
>=20
> I am happy to run further tests, enable kernel debug options, or try patc=
hes.
>=20
> I'm also attaching the full dmesg and lspci output.
>=20
> Thanks for any guidance or suggestions.


--=20
 i.
--8323328-1614741206-1763998322=:1076--

