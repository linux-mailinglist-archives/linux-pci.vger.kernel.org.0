Return-Path: <linux-pci+bounces-42513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48FC9C628
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 18:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2872734337E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 17:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE442C032C;
	Tue,  2 Dec 2025 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDiIhZlq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7653287503;
	Tue,  2 Dec 2025 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696518; cv=none; b=Jw/vvl3OhKkV/1GNzsKmEbRlXPuNCce/fmOhU4GGluSyFPFNmdy2kz64XuHP6PJqznDjguYg2zbybG0RvGyvrwmu1mgXvzPNvu5YhRrvJadLNwTzipk/RWYfu5vhbm1brpKNWecVm7JQiKRKSkbiGdz/geg62WkIC5ujfeODAg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696518; c=relaxed/simple;
	bh=GqQQSgnYZ8aaYHuZ+ILVfOybpniJ02xbNm53/IV6GOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n/sks8eyR9Zi9rl798IEwXAGCwfK4lGf3whRBhL6cFyr54DHruUyFP1+oM7qtLpkkwkQA7ZkeDdmgHd7+R1vZazvj+FdzV1mPWFMNlc7X4TwKw67WDaCvqSHpcuMaO0JhaeQazFRIOmNWYxl/SOsZTqKV1SUHzzPNd6EgkwZHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDiIhZlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B805C4CEF1;
	Tue,  2 Dec 2025 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764696518;
	bh=GqQQSgnYZ8aaYHuZ+ILVfOybpniJ02xbNm53/IV6GOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FDiIhZlqHMGzH7pG/KaIlD65WuyGf6W8qKDT5Vi7pbtBZSelGTPbiw/ggMYjNosD5
	 D1D4GbBpU6UQMVpaDMVYgB5BYC0zwsAgJPX9Izx0OBBvwIxdOHzaygbHCNI4ctTz3r
	 IYWjhtl+0XLYjfckRqFSHdW10T12VmEkM0y1W6WO4qBxbvB0JlNfAgF+aYPCuvkxE/
	 RZudXDjyEtov6iXkoGwP/2i9lLFesVgiS1ptVloEtkME+AdJQjuHlsAJANA4siMcAE
	 gRV3M4ouEHkjmeJ5jj83QxnxND91UGl8h5mggqOwDuuDP/5QB44Ik0Sv8tm379Qry6
	 uF+TyneON/xyQ==
Date: Tue, 2 Dec 2025 11:28:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?UmVuw6k=?= Rebe <rene@exactco.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Riccardo Mottola <riccardo.mottola@libero.it>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
Message-ID: <20251202172837.GA3078292@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251202.174007.745614442598214100.rene@exactco.de>

[+cc Mani, Brian (a5fb3ff63287 authors), Rafael, Lukas, Mario]

On Tue, Dec 02, 2025 at 05:40:07PM +0100, René Rebe wrote:
> Commit a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all
> non-x86") was bisected to break various non-x86 RISC Unix systems,
> e.g. sparc64, see two example oopses below. Fix by only allowing D3Hot
> on modern ARM64, PPC64 and RISCV ISAs besides new enough x86.

I think we need some kind of analysis of what is happening to the PCI
devices here.  I don't know why the CPU architecture per se would be
related to PCI power management.

pci_bridge_d3_possible() is already a barely maintainable hodge podge
of random things that work and don't work.  Generally speaking most of
those cases relate to firmware.  

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

I assume both of these crashes are related to the
CHIPREG_READ32(&ioc->chip->Doorbell) in mpt_GetIocState(), e.g., maybe
that PCI read failed because an upstream bridge was not in D0 and
therefore treated the read as an unsupported request.

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
> Signed-off-by: René Rebe <rene@exactco.de>
> ---
> Tested on Sun Blade 1000, and shipping in all T2/Linux builds since 2025-08-01
> ---
>  drivers/pci/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..7619d2cfa66d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3033,9 +3033,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  
>  		/*
>  		 * Out of caution, we only allow PCIe ports from 2015 or newer
> -		 * into D3 on x86.
> +		 * into D3 or other modern ISAs only.
>  		 */
> -		if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >= 2015)
> +		if (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_PPC64) || IS_ENABLED(CONFIG_RISCV) || dmi_get_bios_year() >= 2015)
>  			return true;
>  		break;
>  	}
> -- 
> 2.52.0
> 
> -- 
> René Rebe, ExactCODE GmbH, Berlin, Germany
> https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

