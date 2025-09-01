Return-Path: <linux-pci+bounces-35285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4CB3EBE2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 18:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0833485790
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D8B13E02A;
	Mon,  1 Sep 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TO8fzC+Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F152EC08B
	for <linux-pci@vger.kernel.org>; Mon,  1 Sep 2025 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742829; cv=none; b=cR/o1WhzaIH5dkErHFiUaGMBXILnWNyXmx/xveUjpXZRvRRdi4VEDJ7WJLG+4UcUMLN4DXA6cDp+1CaucBsndcGbgYADzY+bzpBmaJ2MSDZJloeCy9Lu0U2eh1mClz/GV3ZtSwTNOVDbUPqhKWMT346YfsMSgnjRDxRjNldr46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742829; c=relaxed/simple;
	bh=1xIZZXNQcmoZaw5gH1igrGAUxWqRjnBBdTJoKbt+ac0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HPsO/dg5bpejItJ+NxOVPduO4OcNTS3jky7pTuZoAsZxY9UapNp4BVcMz6PPJaJyFFUZIXDVNKJpmJ46xI0P3tAVp2AWlI0r5BwopaV/3v9GCHfJTdBiCmGiy1xCimUMwBYSp7FB0o5XGfKV39HxDE0youyWsnRFeTBv44hGQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TO8fzC+Z; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756742827; x=1788278827;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1xIZZXNQcmoZaw5gH1igrGAUxWqRjnBBdTJoKbt+ac0=;
  b=TO8fzC+ZzqCSwCuBJqb8c0WVYtpyzGp8RS6YXx7MmK2yBwsmJVrZwWYf
   qvFvHgPcuj1JgSqMvoVAHEhO3ZLiNDMMs0zRv97w92/UtzrDjec7SGwrU
   nLCLdn8aJqdla9Q7CMVit9Yjz12fao5dZV1/7JHxw0nu4zYppfFnGz+JA
   koKQcHC1PvfrIaEIP7EET/TQPxNTXvChwKM4/8d60hvYt1jmWH2rs6dLU
   SFKFXchdIkIcb/zgrwgm8hvZXdVAwreEVZMC50blzeMzATYqZMMkNkyoO
   OzauK/y1veINKIdFS7g1F0B57ClFHhIYabUBqduxT9C/xWMMx6q4XVMjr
   A==;
X-CSE-ConnectionGUID: cvJF4wYEQnmvt0Fabv0r1w==
X-CSE-MsgGUID: Ta3Qix9+ST29aiMsSB6RQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="46584870"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="46584870"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 09:07:04 -0700
X-CSE-ConnectionGUID: k9yjc7L0SxClpOCJ8Zj3Zw==
X-CSE-MsgGUID: 1wEznnRqRo2c0e0BKa2qWw==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.193])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 09:07:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 1 Sep 2025 19:06:59 +0300 (EEST)
To: Steve Oswald <stevepeter.oswald@gmail.com>
cc: linux-pci@vger.kernel.org
Subject: Re: [BUG] Thunderbolt eGPU PCI BARs incorrectly assigned, fails to
 assign memory
In-Reply-To: <f743efbe-56b7-ad85-f278-743af9385f10@linux.intel.com>
Message-ID: <82ac5594-61c0-fece-1d9c-7c10316df384@linux.intel.com>
References: <CAN95MYEaO8QYYL=5cN19nv_qDGuuP5QOD17pD_ed6a7UqFVZ-g@mail.gmail.com> <9254be77-46ea-992f-a1bd-98bea3943520@linux.intel.com> <f743efbe-56b7-ad85-f278-743af9385f10@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-59789189-1756742819=:947"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-59789189-1756742819=:947
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 1 Sep 2025, Ilpo J=C3=A4rvinen wrote:

> On Mon, 1 Sep 2025, Ilpo J=C3=A4rvinen wrote:
> > On Sun, 31 Aug 2025, Steve Oswald wrote:
> >=20
> > > I=E2=80=99ve encountered an issue with Thunderbolt eGPU (externally c=
onnected
> > > gpu via thunderbolt 4). The change from kernel 6.10.14 to 6.11.0 brok=
e
> > > the pci memory assignment of the external pcie device. I figured out
> > > which version broke it by using ubuntu 25.04 and downgrading the
> > > kernel (https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kern=
el.sh/master/ubuntu-mainline-kernel.sh).
> > >=20
> > > >From the dmesg output, on the broken 6.11.0 I see 'failed to assign'=
=2E
> > > The issue occurs (almost never) on previous kernel version 6.10.14.
> > > Using pci=3Drealloc did not change the behavior (I can produce the dm=
esg
> > > output if necessary).
> > >=20
> > > The issue was tested with 2 egpus (Radeon Instinct MI50 32GB, NVIDIA
> > > 3080 10GB). Both the amd and the nvidia driver fail to initialize the
> > > device because they cannot write the pcie messages.
> > >=20
> > > System details:
> > > - Kernel: Linux 6.10.14-061014-generic (Ubuntu build) > 6.11.0-061100
> > > - Laptop: TUXEDO InfinityBook Pro 16 - Gen8 with Thunderbolt 4
> > > - eGPU: Radeon Instinct MI50 32GB, NVIDIA 3080 10GB
> > >=20
> > > Steps to reproduce:
> > > 1. Boot the system with the eGPU.
> > > 2. Observe PCI BAR message in `dmesg`.
> > >=20
> > > Logs:
> > > both kernel messages, lspci can be found here:
> > > https://gist.github.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af
> > > raw files:
> > > - dmesg_linux_6.11.0.log
> > > https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d5675=
b4e4af/raw/f9470a06ff929d386c50ec6b5d07e0ff3f053dcf/dmesg_linux_6.11.0.log
> > > - dmesg_linux_6.10.14.log
> > > https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d5675=
b4e4af/raw/f9470a06ff929d386c50ec6b5d07e0ff3f053dcf/dmesg_linux_6.10.14.log
> > >=20
> > > If additional info is needed, I'm happy to help.
> >=20
> > Hi Steve,
> >=20
> > Thanks for the report.
> >=20
> > My analysis is that the problem boils down to lack of this line with 6.=
11:
> >=20
> > pcieport 0000:00:07.0: resource 15 [mem 0x6000000000-0x601bffffff 64bit=
 pref] released
> >=20
> > It means one of the upstream bridge windows could not be released for=
=20
> > resize as it is printed from pci_reassign_bridge_resources() which like=
ly=20
> > occurs inside pci_resize_resource() call from amdgpu(?).
> >=20
> > The very likely cause is this check:
> >=20
> >                         /* Ignore BARs which are still in use */
> >                         if (res->child)
> >                                 continue;
> >=20
> > ...which (until very recently) is entirely silent so there's no warning=
=20
> > whatsover what is the root cause.
>=20
> Hi again,
>=20
> Actually, scratch most of that. It's not during resize as the log should=
=20
> say "releasing" (I don't know how I got this confused). "released" is fro=
m=20
> pci_bridge_release_resources() which is called from=20
> pci_bus_release_bridge_resources() doesn't even try to walk upwards.
>=20
> But that begs question, why didn't also the bridge windows fail their=20
> assignments.
>=20
> Resource fitting calculates size for the bridge window:
>=20
> pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit pref]=
 to [bus 04-2c] add_size 100000 add_align 100000
>=20
> ...but I cannot see assignment for that even being attempted as almost=20
> immediately, this occurs:
>=20
> pci 0000:03:00.0: bridge window [mem 0x6000000000-0x601bffffff 64bit pref=
]: assigned
>=20
> ...which is much less than 0x10003fffff-0x800000000. I cannot think of=20
> anything what could make it shrink like that.
>=20
> I'll have to think this more, it might require a debug patch but I'll=20
> think until tomorrow to see if I can understand it from the code alone.

Only thing I can think of is something going wrong in=20
adjust_bridge_window().

Could you please provide a dmesg with dyndbg=3D"file drivers/pci/* +p" on=
=20
the kernel cmdline from 6.11.

> > What this means, is that there's some assigned resource underneath=20
> > 0000:00:07.0 with 6.11 that wasn't there with 6.10. And it is because 6=
=2E11=20
> > tried harder to get your resources assigned and was successful here and=
=20
> > there resulting in pinning the bridge window in its place, whereas 6.10=
=20
> > failed to assign the same resource.
> >=20
> > Could you provide /proc/iomem (it's enough to do that for 6.11 for now)=
?
> >=20
> >=20
> > You could try to use hpmmioprefsize=3D on kernel's command line to rese=
rve=20
> > more space for the bridge windows, the default is only 2M and these GPU=
s=20
> > need a magnitude more (gigabytes), you can check from 6.10 what the siz=
es=20
> > of the BARs on the GPU are, and round the sum upwards to the next power=
 of=20
> > two multiple.
> >
> > I'd also be interested to see why pci=3Drealloc failed to solve this pr=
oblem=20
> > as it should reconfigure the entire resource tree so if you could provi=
de=20
> > the logs with that. Please take lspci with -vvv.
> >=20
> >=20
> >=20
>=20
>=20

--=20
 i.

--8323328-59789189-1756742819=:947--

