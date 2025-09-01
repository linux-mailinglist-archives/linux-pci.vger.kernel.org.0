Return-Path: <linux-pci+bounces-35288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB87B3EC33
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 18:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3275A4445A2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF35232F772;
	Mon,  1 Sep 2025 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSx50yl8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9032F745
	for <linux-pci@vger.kernel.org>; Mon,  1 Sep 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744094; cv=none; b=DjMcWjwmUIw5QEqXv5hQG9QB/n8toM/Qsnlnw25h3J9GKStk7b5rdgtGsBtjFzleQjz7BnwzFZCQRA76Q+97WNaZf5Edc/b6+E7JeEm5i80aKnxiTxj2OqA9nli6R6skk8V9SYfjsXLTbwwH7BE0fxI+1fZRC5uPVu+ZLYQgkGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744094; c=relaxed/simple;
	bh=jcDf5ckba1UcesBpuLdUjwOdAOkD+b/p1DOXErCwaIE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zrr6dPrxHejCMZzHcLVlWpwAplOFLqyGq22CN/Q8FwntXQHbx8HjXZLayg8W70GSmvTMpyT+t7JpavNRGKp1BYkzDabg8Xy4aNwqzY5fpL1mDAqiLiVcEcQp8EIWTddGv8IuM4x2wHGjFCPTdLSnmA5m6hsgfoecF6o5eby4cKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSx50yl8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756744093; x=1788280093;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jcDf5ckba1UcesBpuLdUjwOdAOkD+b/p1DOXErCwaIE=;
  b=HSx50yl8Z4J72PFkI6KhNHm1SxzRLrTbS6oukCR1368g/xWUkxMHlwxH
   VT21JEshNwRWx+6kkm61km1rxGHJ3TGm0S6vuRkJwjpg2BlEeAxfKaQtz
   j+nbeyK2B4p541BOadI9ksQKzwnBuORGhTvsPqxg/zR6aWJ1fFzJP5Q5U
   94k5Eq37TlsjmitSjnm/VofiHHdIPaR4Vw+FnoNJoeHsHxNwjyyrorZh+
   4zEeqrL39S3x5oricgOlZxaOC732vzojVTmixqktjYKzarojwA7KcsG5h
   B+9Iddw0m/JYJVQZeBZTDoC6eoJvmPyL/D3b1ih7kQZBBdm8hQRUXkEH6
   A==;
X-CSE-ConnectionGUID: oZI64ZM6QNOhXHGBvv+5Lg==
X-CSE-MsgGUID: kFU4ek7RQmWwjyJcxyuSsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="58036478"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58036478"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 09:28:11 -0700
X-CSE-ConnectionGUID: xsjs9+PSS1WJSkEkMwdCdg==
X-CSE-MsgGUID: JP1A8GXXRgmMJFqy1VwL9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="194703671"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.193])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 09:28:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 1 Sep 2025 19:28:06 +0300 (EEST)
To: Steve Oswald <stevepeter.oswald@gmail.com>
cc: linux-pci@vger.kernel.org
Subject: Re: [BUG] Thunderbolt eGPU PCI BARs incorrectly assigned, fails to
 assign memory
In-Reply-To: <CAN95MYHpdz0u6-J_=7_enxq-TMzRJJJntfjYxBRgrG8UYbhQ1A@mail.gmail.com>
Message-ID: <0e884fd0-6abf-0b73-b171-875a594658d5@linux.intel.com>
References: <CAN95MYEaO8QYYL=5cN19nv_qDGuuP5QOD17pD_ed6a7UqFVZ-g@mail.gmail.com> <9254be77-46ea-992f-a1bd-98bea3943520@linux.intel.com> <f743efbe-56b7-ad85-f278-743af9385f10@linux.intel.com> <82ac5594-61c0-fece-1d9c-7c10316df384@linux.intel.com>
 <CAN95MYHpdz0u6-J_=7_enxq-TMzRJJJntfjYxBRgrG8UYbhQ1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-980874576-1756744086=:947"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-980874576-1756744086=:947
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 1 Sep 2025, Steve Oswald wrote:

> I've added the dmesg output fordyndbg=3D"file drivers/pci/*. I wasn't
> sure if I added it with the escaped quotes correctly.
> https://gist.github.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af/raw/9cf5=
fc3a8c4f13588a33d61865f804f85e50470a/dmesg_linux_6.11.0_dyndbg.log

Thanks. It was correct and caught the reason for the problem:

[    9.090106] pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003ffff=
f 64bit pref] shrunken by 0x00000007e4400000

I'll get back to this once I've tried to figure why it does what it does.

--=20
 i.

> Am Mo., 1. Sept. 2025 um 19:07 Uhr schrieb Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com>:
> >
> > On Mon, 1 Sep 2025, Ilpo J=C3=A4rvinen wrote:
> >
> > > On Mon, 1 Sep 2025, Ilpo J=C3=A4rvinen wrote:
> > > > On Sun, 31 Aug 2025, Steve Oswald wrote:
> > > >
> > > > > I=E2=80=99ve encountered an issue with Thunderbolt eGPU (external=
ly connected
> > > > > gpu via thunderbolt 4). The change from kernel 6.10.14 to 6.11.0 =
broke
> > > > > the pci memory assignment of the external pcie device. I figured =
out
> > > > > which version broke it by using ubuntu 25.04 and downgrading the
> > > > > kernel (https://raw.githubusercontent.com/pimlie/ubuntu-mainline-=
kernel.sh/master/ubuntu-mainline-kernel.sh).
> > > > >
> > > > > >From the dmesg output, on the broken 6.11.0 I see 'failed to ass=
ign'.
> > > > > The issue occurs (almost never) on previous kernel version 6.10.1=
4.
> > > > > Using pci=3Drealloc did not change the behavior (I can produce th=
e dmesg
> > > > > output if necessary).
> > > > >
> > > > > The issue was tested with 2 egpus (Radeon Instinct MI50 32GB, NVI=
DIA
> > > > > 3080 10GB). Both the amd and the nvidia driver fail to initialize=
 the
> > > > > device because they cannot write the pcie messages.
> > > > >
> > > > > System details:
> > > > > - Kernel: Linux 6.10.14-061014-generic (Ubuntu build) > 6.11.0-06=
1100
> > > > > - Laptop: TUXEDO InfinityBook Pro 16 - Gen8 with Thunderbolt 4
> > > > > - eGPU: Radeon Instinct MI50 32GB, NVIDIA 3080 10GB
> > > > >
> > > > > Steps to reproduce:
> > > > > 1. Boot the system with the eGPU.
> > > > > 2. Observe PCI BAR message in `dmesg`.
> > > > >
> > > > > Logs:
> > > > > both kernel messages, lspci can be found here:
> > > > > https://gist.github.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af
> > > > > raw files:
> > > > > - dmesg_linux_6.11.0.log
> > > > > https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d=
5675b4e4af/raw/f9470a06ff929d386c50ec6b5d07e0ff3f053dcf/dmesg_linux_6.11.0.=
log
> > > > > - dmesg_linux_6.10.14.log
> > > > > https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d=
5675b4e4af/raw/f9470a06ff929d386c50ec6b5d07e0ff3f053dcf/dmesg_linux_6.10.14=
=2Elog
> > > > >
> > > > > If additional info is needed, I'm happy to help.
> > > >
> > > > Hi Steve,
> > > >
> > > > Thanks for the report.
> > > >
> > > > My analysis is that the problem boils down to lack of this line wit=
h 6.11:
> > > >
> > > > pcieport 0000:00:07.0: resource 15 [mem 0x6000000000-0x601bffffff 6=
4bit pref] released
> > > >
> > > > It means one of the upstream bridge windows could not be released f=
or
> > > > resize as it is printed from pci_reassign_bridge_resources() which =
likely
> > > > occurs inside pci_resize_resource() call from amdgpu(?).
> > > >
> > > > The very likely cause is this check:
> > > >
> > > >                         /* Ignore BARs which are still in use */
> > > >                         if (res->child)
> > > >                                 continue;
> > > >
> > > > ...which (until very recently) is entirely silent so there's no war=
ning
> > > > whatsover what is the root cause.
> > >
> > > Hi again,
> > >
> > > Actually, scratch most of that. It's not during resize as the log sho=
uld
> > > say "releasing" (I don't know how I got this confused). "released" is=
 from
> > > pci_bridge_release_resources() which is called from
> > > pci_bus_release_bridge_resources() doesn't even try to walk upwards.
> > >
> > > But that begs question, why didn't also the bridge windows fail their
> > > assignments.
> > >
> > > Resource fitting calculates size for the bridge window:
> > >
> > > pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit p=
ref] to [bus 04-2c] add_size 100000 add_align 100000
> > >
> > > ...but I cannot see assignment for that even being attempted as almos=
t
> > > immediately, this occurs:
> > >
> > > pci 0000:03:00.0: bridge window [mem 0x6000000000-0x601bffffff 64bit =
pref]: assigned
> > >
> > > ...which is much less than 0x10003fffff-0x800000000. I cannot think o=
f
> > > anything what could make it shrink like that.
> > >
> > > I'll have to think this more, it might require a debug patch but I'll
> > > think until tomorrow to see if I can understand it from the code alon=
e.
> >
> > Only thing I can think of is something going wrong in
> > adjust_bridge_window().
> >
> > Could you please provide a dmesg with dyndbg=3D"file drivers/pci/* +p" =
on
> > the kernel cmdline from 6.11.
> >
> > > > What this means, is that there's some assigned resource underneath
> > > > 0000:00:07.0 with 6.11 that wasn't there with 6.10. And it is becau=
se 6.11
> > > > tried harder to get your resources assigned and was successful here=
 and
> > > > there resulting in pinning the bridge window in its place, whereas =
6.10
> > > > failed to assign the same resource.
> > > >
> > > > Could you provide /proc/iomem (it's enough to do that for 6.11 for =
now)?
> > > >
> > > >
> > > > You could try to use hpmmioprefsize=3D on kernel's command line to =
reserve
> > > > more space for the bridge windows, the default is only 2M and these=
 GPUs
> > > > need a magnitude more (gigabytes), you can check from 6.10 what the=
 sizes
> > > > of the BARs on the GPU are, and round the sum upwards to the next p=
ower of
> > > > two multiple.
> > > >
> > > > I'd also be interested to see why pci=3Drealloc failed to solve thi=
s problem
> > > > as it should reconfigure the entire resource tree so if you could p=
rovide
> > > > the logs with that. Please take lspci with -vvv.
> > > >
> > > >
> > > >
> > >
> > >
> >
> > --
> >  i.
>=20
--8323328-980874576-1756744086=:947--

