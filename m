Return-Path: <linux-pci+bounces-16014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E85929BC190
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 00:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C14B282C0A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 23:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC63188703;
	Mon,  4 Nov 2024 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2UKLijk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FE139CFF;
	Mon,  4 Nov 2024 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763854; cv=none; b=qhzu+HEF+hSmzJDbdF/DwikAE0gJzVrc7DZ/cZATapdGJeMKIL0ZDw5ja6rCAFbtKsUYeLpWQRohkQVWirP9C5UJnjhOIIWJzqrGTtevMcUckU7k7fx0m6hke+NHuQeIV5lbut/OjWbYzA6XjYipAk0DjGRykTEq2j+hUmddRo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763854; c=relaxed/simple;
	bh=2aMoY1TDDy3/xz9iBSLrQX4eaLsKZYiELDT17zLpN40=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JImxuaHxSbpeKJsgbASib+3rPOUjnMoYTdTcliGObF3RnFQmjcAFHbqLu6XgQ1QjWetJ84PZRnjHH4zVz+4gBhoLw0tMa2Fo4FdG4WUduoKsdIDegJrTLdzhZrYTKny6P3O7zmYtBJ+C9WSuuarvW6DZ81RfgRoK3l6cJBJI/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2UKLijk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAED7C4CECE;
	Mon,  4 Nov 2024 23:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730763853;
	bh=2aMoY1TDDy3/xz9iBSLrQX4eaLsKZYiELDT17zLpN40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=H2UKLijkMvNmkkIbBjMyh3ZPWuCwSMAUuBwg1vUWaN4DxRmCJc0LiBsp0A/kV5rU/
	 ttWJQrp4/WBzfj7EK97Mtyaj1k3iwOPfB5cGCONLbH/gzvPA9Y7qMZoNhJiEvsTUe2
	 YIICAqFHckO/myRF5SgGnCMJ3NojDwtMrbjy5u0N6SuVpiqgZIvRFpvKaf/8RA4bxj
	 WbpjqinfYP9emFck0B+77REIz6dL9gY/nqN72DRjMz2qiAz5nJ+CB/Ipv9/WGbu2WM
	 yrcPSbwsOdqXQpAXG39QbQOH+iKvK8MBTMTCp4+KRikhnhH70P3sjzk/hPssXElL0d
	 vHTENob6qY90w==
Date: Mon, 4 Nov 2024 17:44:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dullfire <dullfire@yahoo.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Kernel panic with niu module
Message-ID: <20241104234412.GA1446170@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7c43842-270e-48f8-ba89-9b5e67910131@yahoo.com>

[+cc Thomas, author of 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X
entries")]

On Mon, Nov 04, 2024 at 05:34:42AM -0600, Dullfire wrote:
> Hello,
> 
> I am working on a set of patches that address a panic on bind in the niu
> module. However, none of the approaches I see integrate well with the kernels
> frameworks, so any feed back you could provide would be appreciated.
> 
> On sparcv9 systems (and possibly others), when the niu drivers sets up the
> MSIX IRQ vectors, a fatal trap[0] is encountered. I have done a number of
> tests[1]. From these tests I have believe that any read from a specific MSIX
> table entry must come after a write to it's PCI_MSIX_ENTRY_DATA field,
> otherwise it will cause a fatal trap.
> 
> I see types of approaches:
> 1) Add writes to the ENTRY_DATA field to niu before it call into the 
>     msi(x) code.
> 2) Adjust the MSIX code to either skip the read, or write to ENTRY_DATA first
> 3) Add a PCI quirk for this device to "initialize" the MSIX vector table.
> 
> Approach 1 encounters issues in needing to write to the MSIX table. The
> functions needed to do this are internal to msi.c (or drivers/pci/msi/msi.h),
> so they would have to either be reproduces in niu, or exposed in a public
> header. Neither of those seem like a good approach to me.
> 
> Approach 2 can be done in a small amount of code, but it would either require
> the addition of a struct pci_dev flag of some sort, or it would be invasive
> to lots of other devices.
> 
> While approach 3 seems to be the most correct location, it suffers many of
> the same issues as approach 1.
> 
> I have also bisected the kernel, and determined that  upstream commit
> 7d5ec3d3612396dc6d4b76366d20ab9fc06f399f revealed this issue. This commit
> adds read to the mask status before any write to PCI_MSIX_ENTRY_DATA, thus
> provoking the issue.

7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries") appeared in
v5.14 in 2021.  Surely other drivers use MSI-X and would have been
tested on sparcv9 since then?  Just based on the age of 7d5ec3d36123,
I would guess some kind of niu issue.  But Thomas will know much more.

> If you have any suggestions, please let me know.
> 
> Regards,
> Jonathan Currier
> 
> 
> [0] The trap looks like this:
> -----------------------------------------------------------------------------
> [   25.166817] niu: niu.c:v1.1 (Apr 22, 2010)
> [   25.166952] niu 0001:04:00.0: enabling device (0144 -> 0146)
> [   25.174100] niu: niu0: Found PHY 002063b0 type MII at phy_port 26
> [   25.174559] niu: niu0: Found PHY 002063b0 type MII at phy_port 27
> [   25.175004] niu: niu0: Found PHY 002063b0 type MII at phy_port 28
> [   25.175449] niu: niu0: Found PHY 002063b0 type MII at phy_port 29
> [   25.176298] niu: niu0: Port 0 [4 RX chans] [6 TX chans]
> [   25.176405] niu: niu0: Port 1 [4 RX chans] [6 TX chans]
> [   25.176507] niu: niu0: Port 2 [4 RX chans] [6 TX chans]
> [   25.176548] niu: niu0: Port 3 [4 RX chans] [6 TX chans]
> [   25.176590] niu: niu0: Port 0 RDC tbl(0) [ 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 ]
> [   25.176757] niu: niu0: Port 0 RDC tbl(1) [ 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 ]
> [   25.176890] niu: niu0: Port 1 RDC tbl(2) [ 4 5 6 7 4 5 6 7 4 5 6 7 4 5 6 7 ]
> [   25.177053] niu: niu0: Port 1 RDC tbl(3) [ 4 5 6 7 4 5 6 7 4 5 6 7 4 5 6 7 ]
> [   25.177185] niu: niu0: Port 2 RDC tbl(4) [ 8 9 10 11 8 9 10 11 8 9 10 11 8 9 10 11 ]
> [   25.177349] niu: niu0: Port 2 RDC tbl(5) [ 8 9 10 11 8 9 10 11 8 9 10 11 8 9 10 11 ]
> [   25.177483] niu: niu0: Port 3 RDC tbl(6) [ 12 13 14 15 12 13 14 15 12 13 14 15 12 13 14 15 ]
> [   25.177649] niu: niu0: Port 3 RDC tbl(7) [ 12 13 14 15 12 13 14 15 12 13 14 15 12 13 14 15 ]
> [   25.245863] NON-RESUMABLE ERROR: Reporting on cpu 64
> [   25.245973] NON-RESUMABLE ERROR: TPC [0x00000000005f6900] <msix_prepare_msi_desc+0x90/0xa0>
> [   25.246106] NON-RESUMABLE ERROR: RAW [4010000000000016:00000e37f93e32ff:0000000202000080:ffffffffffffffff
> [   25.246215] NON-RESUMABLE ERROR:      0000000800000000:0000000000000000:0000000000000000:0000000000000000]
> [   25.246291] NON-RESUMABLE ERROR: handle [0x4010000000000016] stick [0x00000e37f93e32ff]
> [   25.246335] NON-RESUMABLE ERROR: type [precise nonresumable]
> [   25.246373] NON-RESUMABLE ERROR: attrs [0x02000080] < ASI sp-faulted priv >
> [   25.246435] NON-RESUMABLE ERROR: raddr [0xffffffffffffffff]
> [   25.246476] NON-RESUMABLE ERROR: insn effective address [0x000000c50020000c]
> [   25.246517] NON-RESUMABLE ERROR: size [0x8]
> [   25.246544] NON-RESUMABLE ERROR: asi [0x00]
> [   25.246573] CPU: 64 UID: 0 PID: 745 Comm: kworker/64:1 Not tainted 6.11.5 #63
> [   25.246625] Workqueue: events work_for_cpu_fn
> [   25.246671] TSTATE: 0000000011001602 TPC: 00000000005f6900 TNPC: 00000000005f6904 Y: 00000000    Not tainted
> [   25.246729] TPC: <msix_prepare_msi_desc+0x90/0xa0>
> [   25.246771] g0: 00000000000002e9 g1: 000000000000000c g2: 000000c50020000c g3: 0000000000000100
> [   25.246815] g4: ffff8000470307c0 g5: ffff800fec5be000 g6: ffff800047a08000 g7: 0000000000000000
> [   25.246861] o0: ffff800014feb000 o1: ffff800047a0b620 o2: 0000000000000011 o3: ffff800047a0b620
> [   25.246906] o4: 0000000000000080 o5: 0000000000000011 sp: ffff800047a0ad51 ret_pc: 00000000005f7128
> [   25.246951] RPC: <__pci_enable_msix_range+0x3cc/0x460>
> [   25.247004] l0: 000000000000000d l1: 000000000000c01f l2: ffff800014feb0a8 l3: 0000000000000020
> [   25.247049] l4: 000000000000c000 l5: 0000000000000001 l6: 0000000020000000 l7: ffff800047a0b734
> [   25.247094] i0: ffff800014feb000 i1: ffff800047a0b730 i2: 0000000000000001 i3: 000000000000000d
> [   25.247138] i4: 0000000000000000 i5: 0000000000000000 i6: ffff800047a0ae81 i7: 00000000101888b0
> [   25.247182] I7: <niu_try_msix.constprop.0+0xc0/0x130 [niu]>
> [   25.247321] Call Trace:
> [   25.247346] [<00000000101888b0>] niu_try_msix.constprop.0+0xc0/0x130 [niu]
> [   25.247442] [<000000001018f840>] niu_get_invariants+0x183c/0x207c [niu]
> [   25.247536] [<00000000101902fc>] niu_pci_init_one+0x27c/0x2fc [niu]
> [   25.247630] [<00000000005ef3e4>] local_pci_probe+0x28/0x74
> [   25.247677] [<0000000000469240>] work_for_cpu_fn+0x8/0x1c
> [   25.247726] [<000000000046b008>] process_scheduled_works+0x144/0x210
> [   25.247782] [<000000000046b518>] worker_thread+0x13c/0x1c0
> [   25.247833] [<00000000004710e0>] kthread+0xb8/0xc8
> [   25.247874] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
> [   25.247931] [<0000000000000000>] 0x0
> [   25.247961] Kernel panic - not syncing: Non-resumable error.
> -----------------------------------------------------------------------------
> 
> [1] Tests I have done (and their results)
> All tests done on a T5240 (UltaSPARC T2).
> In my test cases: niu driver tries to use up to 13 vectors (table size of 32 entries).
> "SUCCCESS" - Test case booted with functional networking
> "FAILED" - Test case experienced a fatal trap after loading the niu module 
>  - writing 0 to all of the MSIX table entrys' ENTRY_VECTOR_CTRL: FAILED 
>  - writing 0 to all of the MSIX table entrys' ENTRY_LOWER_ADDR: FAILED 
>  - writing 0 to all of the MSIX table entrys' ENTRY_UPPER_ADDR: FAILED 
>  - writing 0 to all of the MSIX table entrys' ENTRY_DATA: SUCCESS
>  - writing 0 to only one MSIX table entry's ENTRY_DATA: FAILED
>  - writing 0 to only the first 1/2 of the MSIX table entrys' ENTRY_DATA: SUCCESS
>  - writing ~0 to only the first 1/2 of the MSIX table entrys' ENTRY_DATA: SUCCESS
>  - writing 0 to only the first 12 of the MSIX table entrys' ENTRY_DATA: FAILED
>  - writing 0 to only the first 13 of the MSIX table entrys' ENTRY_DATA: SUCCESS
>  - reading ENTRY_DATA before writing it: FAILED 
>  - reading ENTRY_LOWER_ADDR before writing it: FAILED 
>  - reading ENTRY_UPPER_ADDR before writing it: FAILED

