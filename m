Return-Path: <linux-pci+bounces-35269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF82FB3E4DF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 15:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C9F7AF604
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 13:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34A71DE2A0;
	Mon,  1 Sep 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrabhnCm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38321DED7B
	for <linux-pci@vger.kernel.org>; Mon,  1 Sep 2025 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733133; cv=none; b=rorYuMQVwUBV9k81Hu85Udp0ELuZk7ZlWs3a8qqWAsWBiByQ6jllNNQiMA/BTS2Q5injk73inz0rT/eP+rYHFZnO1r1eEG3wo/maZgeBKU4iN86ULw7rEoxzzT0VYpXkB/b5pphOYgujYrwa7OgmDPEwhWgfqsNztOX6uDzk+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733133; c=relaxed/simple;
	bh=A1H+mKr/xOmEJhkxcxqtkC/kXHHkQIr5vRJz82Gbu5I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uG1CFI8b7lyowxVQ+CnLeVWkCs4PNINULTvY2zWGQiETWPm5qyahsF0HwbT7ElRLM69WnlFrf7vUn4+cCQ9I9dSI1oflyEyRUlE8Y4fRVI/LDESToGkFW2rzOMVXSZ1+eIcaEgjc/xsYKPVO+FnWcQ6Mra5YmkRhSWdC1jzJ6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrabhnCm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756733132; x=1788269132;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=A1H+mKr/xOmEJhkxcxqtkC/kXHHkQIr5vRJz82Gbu5I=;
  b=mrabhnCmywtFxxDivWSD3qC2QzffLb6IWR5oDoAv8AgJ8m852Dm2LJ3p
   64kyhDXUZlKEYwT1GLDV+qqsF4QIMXfgZAFrzBPXGiVcH9uQONmUMJOxw
   zhS74pf/M6eub5ivAmPUXqLWHiW6E1K8x5SeBaaLowDZMNUDlywugg7xZ
   XJZCrL3fBYcxju3etpxX285jn+PDPRfOsAf+CxZTVnbJ/JnrgMTvQFDTK
   g+WqVIHu3J8o2S27I40oWntjaMgh+QeKAABD3+ib8Qzr8EvVZj4fuUq2Z
   v9A32lRkGb1s6BVHTTHm9magUjyCAdpQbCFNEp8QedC4dqejLzxXvMbLR
   Q==;
X-CSE-ConnectionGUID: vTm/PDKhRuulZHfB+wBwHA==
X-CSE-MsgGUID: 9qZ772w3R/SkEmhG1HkfmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="62808968"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="62808968"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 06:25:31 -0700
X-CSE-ConnectionGUID: xetoECzxRjWqmS0z+saipg==
X-CSE-MsgGUID: 1/6TXXsOREyufo6HSJLT3Q==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.193])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 06:25:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 1 Sep 2025 16:25:26 +0300 (EEST)
To: Steve Oswald <stevepeter.oswald@gmail.com>
cc: linux-pci@vger.kernel.org
Subject: Re: [BUG] Thunderbolt eGPU PCI BARs incorrectly assigned, fails to
 assign memory
In-Reply-To: <CAN95MYEaO8QYYL=5cN19nv_qDGuuP5QOD17pD_ed6a7UqFVZ-g@mail.gmail.com>
Message-ID: <9254be77-46ea-992f-a1bd-98bea3943520@linux.intel.com>
References: <CAN95MYEaO8QYYL=5cN19nv_qDGuuP5QOD17pD_ed6a7UqFVZ-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1407081250-1756731395=:947"
Content-ID: <9ad813cf-e1e2-8477-74d8-36eb1e20854d@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1407081250-1756731395=:947
Content-Type: text/plain; CHARSET=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <c142e57f-e57a-b405-106f-271b73ddc10d@linux.intel.com>

On Sun, 31 Aug 2025, Steve Oswald wrote:

> Hello,
>=20
> I=A2ve encountered an issue with Thunderbolt eGPU (externally connected
> gpu via thunderbolt 4). The change from kernel 6.10.14 to 6.11.0 broke
> the pci memory assignment of the external pcie device. I figured out
> which version broke it by using ubuntu 25.04 and downgrading the
> kernel (https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kernel.s=
h/master/ubuntu-mainline-kernel.sh).
>=20
> >From the dmesg output, on the broken 6.11.0 I see 'failed to assign'.
> The issue occurs (almost never) on previous kernel version 6.10.14.
> Using pci=3Drealloc did not change the behavior (I can produce the dmesg
> output if necessary).
>=20
> The issue was tested with 2 egpus (Radeon Instinct MI50 32GB, NVIDIA
> 3080 10GB). Both the amd and the nvidia driver fail to initialize the
> device because they cannot write the pcie messages.
>=20
> System details:
> - Kernel: Linux 6.10.14-061014-generic (Ubuntu build) > 6.11.0-061100
> - Laptop: TUXEDO InfinityBook Pro 16 - Gen8 with Thunderbolt 4
> - eGPU: Radeon Instinct MI50 32GB, NVIDIA 3080 10GB
>=20
> Steps to reproduce:
> 1. Boot the system with the eGPU.
> 2. Observe PCI BAR message in `dmesg`.
>=20
> Logs:
> both kernel messages, lspci can be found here:
> https://gist.github.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af
> raw files:
> - dmesg_linux_6.11.0.log
> https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4=
af/raw/f9470a06ff929d386c50ec6b5d07e0ff3f053dcf/dmesg_linux_6.11.0.log
> - dmesg_linux_6.10.14.log
> https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4=
af/raw/f9470a06ff929d386c50ec6b5d07e0ff3f053dcf/dmesg_linux_6.10.14.log
>=20
> If additional info is needed, I'm happy to help.

Hi Steve,

Thanks for the report.

My analysis is that the problem boils down to lack of this line with 6.11:

pcieport 0000:00:07.0: resource 15 [mem 0x6000000000-0x601bffffff 64bit pre=
f] released

It means one of the upstream bridge windows could not be released for=20
resize as it is printed from pci_reassign_bridge_resources() which likely=
=20
occurs inside pci_resize_resource() call from amdgpu(?).

The very likely cause is this check:

                        /* Ignore BARs which are still in use */
                        if (res->child)
                                continue;

=2E..which (until very recently) is entirely silent so there's no warning=
=20
whatsover what is the root cause.

What this means, is that there's some assigned resource underneath=20
0000:00:07.0 with 6.11 that wasn't there with 6.10. And it is because 6.11=
=20
tried harder to get your resources assigned and was successful here and=20
there resulting in pinning the bridge window in its place, whereas 6.10=20
failed to assign the same resource.

Could you provide /proc/iomem (it's enough to do that for 6.11 for now)?


You could try to use hpmmioprefsize=3D on kernel's command line to reserve=
=20
more space for the bridge windows, the default is only 2M and these GPUs=20
need a magnitude more (gigabytes), you can check from 6.10 what the sizes=
=20
of the BARs on the GPU are, and round the sum upwards to the next power of=
=20
two multiple.


I'd also be interested to see why pci=3Drealloc failed to solve this proble=
m=20
as it should reconfigure the entire resource tree so if you could provide=
=20
the logs with that. Please take lspci with -vvv.


--=20
 i.
--8323328-1407081250-1756731395=:947--

