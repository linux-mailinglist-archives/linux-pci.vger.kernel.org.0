Return-Path: <linux-pci+bounces-42510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CD8C9C4DF
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 17:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DEEA7348BE3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B4A2C3247;
	Tue,  2 Dec 2025 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="QuVtST9D"
X-Original-To: linux-pci@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870C2C0283;
	Tue,  2 Dec 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694485; cv=none; b=k2JRBSDtW1IIL0jm7m2atAu5oHBm1Wymew+QAbWavCvn7zIySbzaU7UmsQP76/zVEP/PbWC264yDGtXgXc98MGEr+nh5YxSgYSvdFRrMxN0KgViwe8bAudfHIxdoKX1q/bAbmkFtk1MvNuHwt4U0/xpgZzU0Hjo4VYQqkNFgFvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694485; c=relaxed/simple;
	bh=R3Tkj9Jz/yFR8hML9nESu59flJTh0gfjmtFTRncvPlA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KeF0jTwxwEf2X24gJ7AEnDzAdDtjqgyTUf72ErBgfRJI5xghDNbwAKQjL2ezPZAM8WsSgJgNftypKegYYllvOD0OZFNUi7EHPsqd5jaDhRVibkKU7GBDdzaeFBIp4mkuQMmhCTa5+X9u89w39Mb/VBytBBoSuKAb9PO25len5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=QuVtST9D; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ygRtUzfCqwQtTtOCF+MYnB9Z7xjyeGMZIm4Z2YsB//g=; t=1764694481;
	x=1765299281; b=QuVtST9DzOo9JSwXT/WbTafjAkcHx7dL/zdr05uBkiT/LDsDU/wBlaj5oVQgJ
	08DOuh5wWQUlLAM0JP779hMQcXolGto+QlZvD0xVHNjYgxZqsIVpJ9rsnJH97uvnxf8C6AJghkQAe
	ZrLJRkalsMJm6Nt0LI/Iih2neW0KpOEg1Fggb3nNh5YX9rlLXZoaW8+1hTNxFDzpxMuKX6PFF4frk
	HjjRx0XTvaA9arq9I/ivdokx+t1zPQ84MQdJMHG5xKlgMS1nwrsdR91147ltKP2KavzHNyUV7TRxD
	kXx6BMosOCqeGhP+OA9Ub5XUBCoqqb899q016UdRpyMajklXpg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vQTe6-00000003emd-00IU; Tue, 02 Dec 2025 17:54:34 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vQTe5-00000002UiO-3HAu; Tue, 02 Dec 2025 17:54:33 +0100
Message-ID: <05c588754dcb83badaec6930499392fdd26be539.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>,
 linux-pci@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Riccardo Mottola
	 <riccardo.mottola@libero.it>
Date: Tue, 02 Dec 2025 17:54:33 +0100
In-Reply-To: <20251202.174007.745614442598214100.rene@exactco.de>
References: <20251202.174007.745614442598214100.rene@exactco.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Rene,

On Tue, 2025-12-02 at 17:40 +0100, Ren=C3=A9 Rebe wrote:
> Commit a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all
> non-x86") was bisected to break various non-x86 RISC Unix systems,
> e.g. sparc64, see two example oopses below. Fix by only allowing D3Hot
> on modern ARM64, PPC64 and RISCV ISAs besides new enough x86.

I think "ISA" is a misnomer here as this issue is not a matter of the
instruction set architecture in use but the PCI bus. So, I suggest to
use the term "systems" here as well.

Plus, I suggest the following message for the summary:

"pci: Further restrict the use of D3 power state"

> Sun Blade 1000:
> ERROR(0): Cheetah error trap taken afsr[0010080005000000] afar[000007f900=
800000] TL1(0)
> ERROR(0): TPC[100a05a4] TNPC[100a05a8] O7[42acc8] TSTATE[4411001603]
> ERROR(0):
> TPC<MakeIocReady+0xc/0x278 [mptbase]>
> ERROR(0): M_SYND(0),=C2=A0 E_SYND(0), Privileged
> ERROR(0): Highest priority error (0000080000000000) "Bus error response f=
rom system bus"
> ERROR(0): D-cache idx[0] tag[0000000000000000] utag[0000000000000000] sta=
g[0000000000000000]
> ERROR(0): D-cache data0[0000000000000000] data1[0000000000000000] data2[0=
000000000000000] data3[0000000000000000]
> ERROR(0): I-cache idx[0] tag[0000000000000000] utag[0000000000000000] sta=
g[0000000000000000] u[0000000000000000] l[0000000000000000]
> ERROR(0): I-cache INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0=
000000000000000] INSN3[0000000000000000]
> ERROR(0): I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0=
000000000000000] INSN7[0000000000000000]
> ERROR(0): E-cache idx[b08040] tag[000000001e008fa0]
> ERROR(0): E-cache data0[0000000000000000] data1[0000000000000000] data2[0=
000000000000000] data3[ffffffffffffffff]
> Kernel panic - not syncing: Irrecoverable deferred error trap.
> CPU: 0 UID: 0 PID: 46 Comm: (udev-worker) Not tainted 6.14.0-rc1-00001-ga=
5fb3ff63287 #18
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
>=20
> Niagara T1:
> mptsas 0000:07:00.0: Unable to change power state from D3cold to D0, devi=
ce inaccessible
> NON-RESUMABLE ERROR: Reporting on cpu 31
> NON-RESUMABLE ERROR: TPC [0x0000000010184034] <MakeIocReady+0x10/0x298 [m=
ptbase]>
> NON-RESUMABLE ERROR: RAW [1f10000000000007:0000000e3179235c:0000000202000=
004:000000ea00300000
> NON-RESUMABLE ERROR: 00000000001f0000:0000000000000000:0000000000000000:0=
000000000000000]
> NON-RESUMABLE ERROR: handle [0x1f10000000000007] stick [0x0000000e3179235=
c]
> NON-RESUMABLE ERROR: type [precise nonresumable]
> NON-RESUMABLE ERROR: attrs [0x02000004] < PIO sp-faulted priv >
> NON-RESUMABLE ERROR: raddr [0x000000ea00300000]
> Kernel panic - not syncing: Non-resumable error.
> CPU: 31 UID: 0 PID: 367 Comm: (udev-worker) Not tainted 6.16.12+3-sparc64=
-smp #1 NONE=C2=A0 Debian 6.16.12-2+sparc64.1
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
>=20
> Fixes: a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x8=
6")
> Signed-off-by: Ren=C3=A9 Rebe <rene@exactco.de>
> ---
> Tested on Sun Blade 1000, and shipping in all T2/Linux builds since 2025-=
08-01
> ---
> =C2=A0drivers/pci/pci.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..7619d2cfa66d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3033,9 +3033,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> =C2=A0
> =C2=A0		/*
> =C2=A0		 * Out of caution, we only allow PCIe ports from 2015 or newer
> -		 * into D3 on x86.
> +		 * into D3 or other modern ISAs only.

Same here, I suggest "systems" instead of "ISAs".

> =C2=A0		 */
> -		if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >=3D 2015)
> +		if (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_PPC64) || IS_ENABLED=
(CONFIG_RISCV) || dmi_get_bios_year() >=3D 2015)

Is there actually a justification to restrict the use of D3 to ARM64,
PPC64 and RISCV? What about MIPS, LoongArch or s390x?

Thanks,
Adrian

> =C2=A0			return true;
> =C2=A0		break;
> =C2=A0	}
> --=20
> 2.52.0
>=20
> --=20
> Ren=C3=A9 Rebe, ExactCODE GmbH, Berlin, Germany
> https://exactco.de=C2=A0=E2=80=A2 https://t2linux.com=C2=A0=E2=80=A2 http=
s://patreon.com/renerebe

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

