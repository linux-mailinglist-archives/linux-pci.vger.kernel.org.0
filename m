Return-Path: <linux-pci+bounces-42543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5766C9DC98
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 06:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490863A6A88
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 05:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068D274FD3;
	Wed,  3 Dec 2025 05:15:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05185274B32;
	Wed,  3 Dec 2025 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764738947; cv=none; b=EpCbb1XIiHuLD76/unoHLlgxJ3fk5HLbrggt9q17bKrVe1k0LJuneVp8Faq++8rkeR2CPrWUyJq4ATfT5jSTcsKgKgGWfU3v4yvTUFxnurW4RZXzEla0ptkxEIiKYaWqd8oDHpB6U8luk2tjMMEQMsI91OlhZFq1nX8575BnApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764738947; c=relaxed/simple;
	bh=DRO0Yx0DBRrPeYfxGT/5WqVHtyGa3kE3owGKMIG7sVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYr89g1pmI2/bX74ho/Ad9TixD77xi5/c3jwdx4DiWKtsbaxxrHb0h2iCzfCejS3ofBxXoEDcuhySWHTwuGRJDby9sVAixsx8KtMPai8/GPE+MnYNoPlNKyhItG4EtW436jYjdloZ2txqBZWuJ3O5JpjbFqdtEBS0xu384gMTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1D3692007F91;
	Wed,  3 Dec 2025 06:15:42 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 034B51E6C8; Wed,  3 Dec 2025 06:15:42 +0100 (CET)
Date: Wed, 3 Dec 2025 06:15:41 +0100
From: Lukas Wunner <lukas@wunner.de>
To: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Riccardo Mottola <riccardo.mottola@libero.it>
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
Message-ID: <aS_HfXIGVLd4g0Ma@wunner.de>
References: <20251202.174007.745614442598214100.rene@exactco.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251202.174007.745614442598214100.rene@exactco.de>

On Tue, Dec 02, 2025 at 05:40:07PM +0100, René Rebe wrote:
> Commit a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all
> non-x86") was bisected to break various non-x86 RISC Unix systems,
> e.g. sparc64, see two example oopses below.
[...]
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

Some ARM PCIe host controllers are known to raise a Data Abort exception
upon a Completion Timeout (pcie-brcmstb.c is a case in point).  It looks
like these SPARC CPUs behave similarly.

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

I suspect this is a bug in the mpt3sas driver and/or scsi layer.
A runtime PM ref is held on the PCI Endpoint device when the
driver probes, so that ref must have been dropped.  The Endpoint
(SCSI host controller) went into runtime suspend, which allowed the
Root Port to go to D3hot.  When the Root Port is in D3hot,
MMIO to the attached Endpoint will cause Completion Timeouts.
(Config Space accesses will still work.)

I'm not seeing any "pm_runtime" or "autopm" occurrences in
drivers/scsi/mpt3sas/, so perhaps the issue is in the scsi layer?

To track this down, you'd have to instrument calls to pm_runtime_put()
and friends with a printk to see where runtime PM refs are acquired
and dropped.  Alternatively, enabling tracing may help, there's a few
tracepoints in runtime PM code.

> mptsas 0000:07:00.0: Unable to change power state from D3cold to D0, device inaccessible

Maybe the Root Port or Endpoint need extra delays to resume to D0?

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

Same stracktrace, same bug I guess.

Thanks,

Lukas

