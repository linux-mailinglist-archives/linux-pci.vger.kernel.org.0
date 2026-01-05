Return-Path: <linux-pci+bounces-43985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0151CF254E
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 09:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD444300A29B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 08:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8517C2DEA70;
	Mon,  5 Jan 2026 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmPhXDf6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599382DCC1F;
	Mon,  5 Jan 2026 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600322; cv=none; b=Q40sdnBHK1eady3gEenlaA7ajxt8hIkKdYoeol5QMFg6Sbk+vOpfQ65zdItrR0TreOJ93a3qayw90iIAIKdvNyihW5AHOkbhVtHvd5VWAOapeJeDIBCJBlEuPXJR482EQhY9Rvw78L5CuhX9gbYfDuOXErBC/rKvjXC2nKcgr4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600322; c=relaxed/simple;
	bh=FoM8mWgDmN7vw6BwnaKdDE21e9+RptdJpN+IQY802Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M99nVkpO9/QxIl3HMUaOdsf8QTbDaGCHPw0/q8LPsoxwgZVkW8aA4Le5KnvCeBqYzJATae6q5w3FIqXGc+p6liCVqxevt+RWBARUwXN2cPAV2VLzDgDCXmypdLUPt3UZmH2DDHw4OGlNhTkIgC4GYs9dk0CxatDw+ikdrZFG3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmPhXDf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05516C116D0;
	Mon,  5 Jan 2026 08:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767600321;
	bh=FoM8mWgDmN7vw6BwnaKdDE21e9+RptdJpN+IQY802Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmPhXDf6KYdMXoaZwypZ0PC0I7lxiWw48NjGdqhnyTG1GD2XQoHx+0EPL9sAaQdg3
	 wzf/x3Qvl9+VGMPyajXed19u06h5JRWcSFCbhF1lDDARY03xwM8hsTCudSt0daB2Kr
	 CBddFqqpR7x+pk5ODgEXNNuv7HjcIKlhLlZ+CeU7XmfBubU2HxwU2FIRS2+qfF1QLV
	 5vSdUIdkzAdX4qlVmFBaVSnM9/ghiHKkRzdoxpSztxqL8eUacEQVVf6LrsI2zvzhFA
	 oXiNfXaSWmV1/p0enNkTaGh5Tchn3tmeHKC7k2WpvPd80KwHl9MW7baGzCue/6FI33
	 lyglABIxWm6Hg==
Date: Mon, 5 Jan 2026 13:35:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?B?UmVuw6k=?= Rebe <rene@exactco.de>
Cc: linux-pci@vger.kernel.org, rafael@kernel.org, 
	mika.westerberg@linux.intel.com, lukas@wunner.de, briannorris@chromium.org, helgaas@kernel.org, 
	linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de, riccardo.mottola@libero.it, 
	mario.limonciello@amd.com
Subject: Re: [PATCH V2] PCI: Fix PCI bridges not to go to D3Hot on SPARC64
Message-ID: <n7adgu7s5tlcbscqybgbf3gzxgpqchwfgxi5ggu2p4mmxlxkie@u63km56hmpbc>
References: <20251203.200526.1986895588669292863.rene@exactco.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251203.200526.1986895588669292863.rene@exactco.de>

On Wed, Dec 03, 2025 at 08:05:26PM +0100, René Rebe wrote:
> Commit a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all
> non-x86") was bisected to break some SPARC64 systems, see two oopses
> below. Fix by not allowing D3Hot on sparc64 while this is being
> further analyzed.
> 
> Sun Blade 1000:
> ERROR(0): Cheetah error trap taken afsr[0010080005000000] afar[000007f900800000] TL1(0)
> ERROR(0): TPC[100a05a4] TNPC[100a05a8] O7[42acc8] TSTATE[4411001603]
> ERROR(0):
> TPC<MakeIocReady+0xc/0x278 [mptbase]>
> ERROR(0): M_SYND(0),  E_SYND(0), Privileged
> ERROR(0): Highest priority error (0000080000000000) "Bus error response from system bus"
> ERROR(0): D-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
> ERROR(0): D-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
> ERROR(0): I-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000] u[0000000000000000] l[0000000000000000]
> ERROR(0): I-cache INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
> ERROR(0): I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
> ERROR(0): E-cache idx[b08040] tag[000000001e008fa0]
> ERROR(0): E-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[ffffffffffffffff]
> Kernel panic - not syncing: Irrecoverable deferred error trap.
> CPU: 0 UID: 0 PID: 46 Comm: (udev-worker) Not tainted 6.14.0-rc1-00001-ga5fb3ff63287 #18
> Call Trace:
> [<00000000004294b0>] panic+0xf0/0x370
> [<0000000000435bc4>] cheetah_deferred_handler+0x2c8/0x2d8
> [<0000000000405e88>] c_deferred+0x18/0x24
> [<00000000100a05a4>] MakeIocReady+0xc/0x278 [mptbase]
> [<00000000100a089c>] mpt_do_ioc_recovery+0x8c/0x1054 [mptbase]
> [<000000001009f2d4>] mpt_attach+0x920/0xa68 [mptbase]
> [<000000001012424c>] mptsas_probe+0x8/0x3e8 [mptsas]
> [<0000000000788308>] local_pci_probe+0x24/0x70
> [<0000000000788dac>] pci_device_probe+0x1c0/0x1d0
> [<000000000082633c>] really_probe+0x13c/0x29c
> [<0000000000826590>] __driver_probe_device+0xf4/0x104
> [<0000000000826614>] driver_probe_device+0x24/0xa0
> [<000000000082683c>] __driver_attach+0xe8/0x104
> [<0000000000824da0>] bus_for_each_dev+0x58/0x84
> [<0000000000825508>] bus_add_driver+0xdc/0x1f8
> [<0000000000827110>] driver_register+0x70/0x120
> 
> Niagara T1:
> mptsas 0000:07:00.0: Unable to change power state from D3cold to D0, device inaccessible
> NON-RESUMABLE ERROR: Reporting on cpu 31
> NON-RESUMABLE ERROR: TPC [0x0000000010184034] <MakeIocReady+0x10/0x298 [mptbase]>
> NON-RESUMABLE ERROR: RAW [1f10000000000007:0000000e3179235c:0000000202000004:000000ea00300000
> NON-RESUMABLE ERROR: 00000000001f0000:0000000000000000:0000000000000000:0000000000000000]
> NON-RESUMABLE ERROR: handle [0x1f10000000000007] stick [0x0000000e3179235c]
> NON-RESUMABLE ERROR: type [precise nonresumable]
> NON-RESUMABLE ERROR: attrs [0x02000004] < PIO sp-faulted priv >
> NON-RESUMABLE ERROR: raddr [0x000000ea00300000]
> Kernel panic - not syncing: Non-resumable error.
> CPU: 31 UID: 0 PID: 367 Comm: (udev-worker) Not tainted 6.16.12+3-sparc64-smp #1 NONE  Debian 6.16.12-2+sparc64.1
> Call Trace:
> [<00000000004373c4>] dump_stack+0x8/0x18
> [<0000000000429540>] panic+0xf4/0x398
> [<000000000043afcc>] sun4v_nonresum_error+0x16c/0x240
> [<0000000000406eb8>] sun4v_nonres_mondo+0xc8/0xd8
> [<0000000010184034>] MakeIocReady+0x10/0x298 [mptbase]
> [<00000000101844b4>] mpt_do_ioc_recovery+0x9c/0x1110 [mptbase]
> [<00000000101836f8>] mpt_attach+0xb58/0xd20 [mptbase]
> [<0000000010287f30>] mptsas_probe+0x10/0x440 [mptsas]
> [<0000000000b3fab0>] local_pci_probe+0x30/0x80
> [<0000000000b405d4>] pci_device_probe+0xb4/0x240
> [<0000000000bfd348>] really_probe+0xc8/0x400
> [<0000000000bfd70c>] __driver_probe_device+0x8c/0x160
> [<0000000000bfd8c8>] driver_probe_device+0x28/0x100
> [<0000000000bfdb7c>] __driver_attach+0xbc/0x1e0
> [<0000000000bfacfc>] bus_for_each_dev+0x5c/0xc0
> [<0000000000bfcafc>] driver_attach+0x1c/0x40
> Press Stop-A (L1-A) from sun keyboard or send break
> twice on console to return to the boot prom
> 
> Fixes: a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86")
> Cc: stable@kernel.org
> Signed-off-by: René Rebe <rene@exactco.de>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> Tested on Sun Blade 1000 and PowerPC64 G5 w/ T2/Linux.
> ---
>  drivers/pci/pci.c | 4 ++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..7619d2cfa66d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3033,9 +3033,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  
>  		/*
>  		 * Out of caution, we only allow PCIe ports from 2015 or newer
> -		 * into D3 on x86.
> +		 * into D3 or x86. Avoid SPARC64 for now, too.
>  		 */
> -		if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >= 2015)
> +		if ((IS_ENABLED(CONFIG_X86) && dmi_get_bios_year() >= 2015) ||
> +		    !IS_ENABLED(CONFIG_SPARC64))
>  			return true;
>  		break;
>  	}
> -- 
> 2.52.0
> 
> -- 
> René Rebe, ExactCODE GmbH, Berlin, Germany
> https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

-- 
மணிவண்ணன் சதாசிவம்

