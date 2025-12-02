Return-Path: <linux-pci+bounces-42512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0D0C9C540
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 18:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 002E9343766
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC67B296BD8;
	Tue,  2 Dec 2025 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="VDA8EZZ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC377220687;
	Tue,  2 Dec 2025 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695096; cv=none; b=qPVErwVDB9wl3wTkOdKG6ij5yzGqpPJW5Rz7QCSJG5X0TxfF+o3V4LnA+5UycxQT6rekSa8NO3n8aMq2kNPXr1PF5fRzDWlQm6Dd2OL956STdtbXWtkkspkifNnE+2Q61imW+EO9fzLsiZch2BEEsvtxwE1w0/1LGDXt0CmGE/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695096; c=relaxed/simple;
	bh=uJPBxdXwlQ2p8pyCIyndyY3qtmNexcGuwTBL3sS1V40=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jL1hlqMw9t26ef83NT5Xpl7FYfRgYg640mZTs55XL7sctlJDzfw+2sgMQbp3vnuCeQ0OQQlLD/6fMb2i1bS4rT/Armp9znK+XIu2AvMcho19rj0mH3G8HsFDRYF+Wy0ryxl31AgIZkqvnJnnDv9TeUKXUXwdRvnrMirPoNypclc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=VDA8EZZ/; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3MP/GL0zJ/f/+dRIMer7LBbjtyLj1/XiR0mHrjL+C2Y=; b=VDA8EZZ/8vQa/DtCDr8qbpM90j
	z0o20F6mv2bnp5wXsaUwbLwKIXvI38O7EwRwiMP+mI+eomfNxL5PYRtl2fFY5jfyIPV5Rb0TNvSoC
	TFhjZlaQ/xNSCr5PaWlL3AqHzeo+gHO5qc1YMEqsE5QvVISRKBU9DxeLNWSpdeeKa7fuzIubkwgUb
	W2G32oD9DW8uxn4Zri0VY6ZUpvFEEKEQ2pdabg2JJylXGE7ie0JDP0Jeib76P0mFaklr+hJLdSBwr
	WmleSwX2g9n7cSn5mU8I9FUXshMuE633cUjj0zeheYjPGadEkbpjwPhLLS07ss27O+RQL8Wwm9lxj
	8jXj1Fmw==;
Date: Tue, 02 Dec 2025 18:04:51 +0100 (CET)
Message-Id: <20251202.180451.409161725628042305.rene@exactco.de>
To: glaubitz@physik.fu-berlin.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, riccardo.mottola@libero.it
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <05c588754dcb83badaec6930499392fdd26be539.camel@physik.fu-berlin.de>
References: <20251202.174007.745614442598214100.rene@exactco.de>
	<05c588754dcb83badaec6930499392fdd26be539.camel@physik.fu-berlin.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

On Tue, 02 Dec 2025 17:54:33 +0100, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> Hi Rene,
> 
> On Tue, 2025-12-02 at 17:40 +0100, René Rebe wrote:
> > Commit a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all
> > non-x86") was bisected to break various non-x86 RISC Unix systems,
> > e.g. sparc64, see two example oopses below. Fix by only allowing D3Hot
> > on modern ARM64, PPC64 and RISCV ISAs besides new enough x86.
> 
> I think "ISA" is a misnomer here as this issue is not a matter of the
> instruction set architecture in use but the PCI bus. So, I suggest to
> use the term "systems" here as well.
> 
> Plus, I suggest the following message for the summary:
> 
> "pci: Further restrict the use of D3 power state"

I thought ISA is the correct term and few still remember an "ISA" bus,
but happy to rephrase to whatever is preferred.

> > Sun Blade 1000:
> > ERROR(0): Cheetah error trap taken afsr[0010080005000000] afar[000007f900800000] TL1(0)
> > ERROR(0): TPC[100a05a4] TNPC[100a05a8] O7[42acc8] TSTATE[4411001603]
> > ERROR(0):
> > TPC<MakeIocReady+0xc/0x278 [mptbase]>
> > ERROR(0): M_SYND(0),  E_SYND(0), Privileged
> > ERROR(0): Highest priority error (0000080000000000) "Bus error response from system bus"
> > ERROR(0): D-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
> > ERROR(0): D-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
> > ERROR(0): I-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000] u[0000000000000000] l[0000000000000000]
> > ERROR(0): I-cache INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
> > ERROR(0): I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
> > ERROR(0): E-cache idx[b08040] tag[000000001e008fa0]
> > ERROR(0): E-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[ffffffffffffffff]
> > Kernel panic - not syncing: Irrecoverable deferred error trap.
> > CPU: 0 UID: 0 PID: 46 Comm: (udev-worker) Not tainted 6.14.0-rc1-00001-ga5fb3ff63287 #18
> > Call Trace:
> > [<00000000004294b0>] panic+0xf0/0x370
> > [<0000000000435bc4>] cheetah_deferred_handler+0x2c8/0x2d8
> > [<0000000000405e88>] c_deferred+0x18/0x24
> > [<00000000100a05a4>] MakeIocReady+0xc/0x278 [mptbase]
> > [<00000000100a089c>] mpt_do_ioc_recovery+0x8c/0x1054 [mptbase]
> > [<000000001009f2d4>] mpt_attach+0x920/0xa68 [mptbase]
> > [<000000001012424c>] mptsas_probe+0x8/0x3e8 [mptsas]
> > [<0000000000788308>] local_pci_probe+0x24/0x70
> > [<0000000000788dac>] pci_device_probe+0x1c0/0x1d0
> > [<000000000082633c>] really_probe+0x13c/0x29c
> > [<0000000000826590>] __driver_probe_device+0xf4/0x104
> > [<0000000000826614>] driver_probe_device+0x24/0xa0
> > [<000000000082683c>] __driver_attach+0xe8/0x104
> > [<0000000000824da0>] bus_for_each_dev+0x58/0x84
> > [<0000000000825508>] bus_add_driver+0xdc/0x1f8
> > [<0000000000827110>] driver_register+0x70/0x120
> > 
> > Niagara T1:
> > mptsas 0000:07:00.0: Unable to change power state from D3cold to D0, device inaccessible
> > NON-RESUMABLE ERROR: Reporting on cpu 31
> > NON-RESUMABLE ERROR: TPC [0x0000000010184034] <MakeIocReady+0x10/0x298 [mptbase]>
> > NON-RESUMABLE ERROR: RAW [1f10000000000007:0000000e3179235c:0000000202000004:000000ea00300000
> > NON-RESUMABLE ERROR: 00000000001f0000:0000000000000000:0000000000000000:0000000000000000]
> > NON-RESUMABLE ERROR: handle [0x1f10000000000007] stick [0x0000000e3179235c]
> > NON-RESUMABLE ERROR: type [precise nonresumable]
> > NON-RESUMABLE ERROR: attrs [0x02000004] < PIO sp-faulted priv >
> > NON-RESUMABLE ERROR: raddr [0x000000ea00300000]
> > Kernel panic - not syncing: Non-resumable error.
> > CPU: 31 UID: 0 PID: 367 Comm: (udev-worker) Not tainted 6.16.12+3-sparc64-smp #1 NONE  Debian 6.16.12-2+sparc64.1
> > Call Trace:
> > [<00000000004373c4>] dump_stack+0x8/0x18
> > [<0000000000429540>] panic+0xf4/0x398
> > [<000000000043afcc>] sun4v_nonresum_error+0x16c/0x240
> > [<0000000000406eb8>] sun4v_nonres_mondo+0xc8/0xd8
> > [<0000000010184034>] MakeIocReady+0x10/0x298 [mptbase]
> > [<00000000101844b4>] mpt_do_ioc_recovery+0x9c/0x1110 [mptbase]
> > [<00000000101836f8>] mpt_attach+0xb58/0xd20 [mptbase]
> > [<0000000010287f30>] mptsas_probe+0x10/0x440 [mptsas]
> > [<0000000000b3fab0>] local_pci_probe+0x30/0x80
> > [<0000000000b405d4>] pci_device_probe+0xb4/0x240
> > [<0000000000bfd348>] really_probe+0xc8/0x400
> > [<0000000000bfd70c>] __driver_probe_device+0x8c/0x160
> > [<0000000000bfd8c8>] driver_probe_device+0x28/0x100
> > [<0000000000bfdb7c>] __driver_attach+0xbc/0x1e0
> > [<0000000000bfacfc>] bus_for_each_dev+0x5c/0xc0
> > [<0000000000bfcafc>] driver_attach+0x1c/0x40
> > Press Stop-A (L1-A) from sun keyboard or send break
> > twice on console to return to the boot prom
> > 
> > Fixes: a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86")
> > Signed-off-by: René Rebe <rene@exactco.de>
> > ---
> > Tested on Sun Blade 1000, and shipping in all T2/Linux builds since 2025-08-01
> > ---
> >  drivers/pci/pci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b14dd064006c..7619d2cfa66d 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3033,9 +3033,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> >  
> >  		/*
> >  		 * Out of caution, we only allow PCIe ports from 2015 or newer
> > -		 * into D3 on x86.
> > +		 * into D3 or other modern ISAs only.
> 
> Same here, I suggest "systems" instead of "ISAs".
> 
> >  		 */
> > -		if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >= 2015)
> > +		if (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_PPC64) || IS_ENABLED(CONFIG_RISCV) || dmi_get_bios_year() >= 2015)
> 
> Is there actually a justification to restrict the use of D3 to ARM64,
> PPC64 and RISCV? What about MIPS, LoongArch or s390x?

Because the ones I picked are more modern, and thus more likely to
work. MIPS is very old. and I have no LoongArch nor regular access to
s390x. Maybe users of those want to allow list after testing? Now that
I think about it I was wondering why ALSA RAD1 audio is not longer
working in my Sgi Octane with the PCI window not being enabled. Would
not suprise me it was some change like this, too. Should bisect next
;-)

Before the breakign change it was disabled for all this other arch
anyway with:

static inline int dmi_get_bios_year(void) { return -ENXIO; }

and comparing whether the negative error code is greater than 2014,
...

      René

> Thanks,
> Adrian
> 
> >  			return true;
> >  		break;
> >  	}
> > -- 
> > 2.52.0
> > 
> > -- 
> > René Rebe, ExactCODE GmbH, Berlin, Germany
> > https://exactco.de • https://t2linux.com • https://patreon.com/renerebe
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

