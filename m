Return-Path: <linux-pci+bounces-42586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E797ECA155E
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 20:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FA8C3016916
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765C13321D4;
	Wed,  3 Dec 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1oeRHD0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A8932E6A7
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789566; cv=none; b=taARnPlsD73t10tbNDY6ECs6fG0/R6dZQ6AVxam9/DWYrzQReKX+CcTKMc+gC4HhCt2hfKKJshPlAsz6hMHGqLgyCxiYrfWbY5mad/Q1ao1tidY9UnkMihWr/HDwuoagG++AKsCRZh8n88jYmUJ0fQxw5Kk4Ov9GkqTkW02CMmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789566; c=relaxed/simple;
	bh=hzF2XWnzKUq6IkGJO9/cBUu7U/nDvETxnDKQ8Jcf8Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQS5IHaQwqXc1e71Vz2mDINran4O3P1F3FOGBCM+DKk+4mqjCHvapQTv4oS7cWODLzDnEwzNflyTeDXaonkkhVPSW7QJ+YlHiFkOfXQpQ9WB+8KVfLsJZGSOIR8YiON9jSY+jrIauGqVGgQ/ObMxd730fmQetxBzbo+Z8POMUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1oeRHD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED683C19423
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 19:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764789566;
	bh=hzF2XWnzKUq6IkGJO9/cBUu7U/nDvETxnDKQ8Jcf8Kk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s1oeRHD0QD3iMxR+Fa2lzct0PrGcoV3wWrbyxFlVBLOrLH9/DNilW+4MTSaF1QtL/
	 VQR0pzBtcu896ld5awEqu4Pj+oIs14BQjFv06DgUwbH7I+EiV2VoVsyfqE0cDRdZV7
	 eUKl5yrUgFh8BwHPApY3TZ4JKHwbTadXizcFl1l+p57CGPC/Uxmb4+W9kPQKvdkM8p
	 uVzXzVvv8MrTDdQmHC8P/fVwQ9WYmy8YIfxTzLny2C54ulgdKk0ZS51wzWtFgLUYtE
	 0ysU4xykKl2h8mjZQnrcIVHT4Rq8UJ4RI9O0abd8LKqlbqDRcAPX4I9YT5Tpg8bvQg
	 vcNsyxYhlIckA==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c75387bb27so53945a34.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 11:19:25 -0800 (PST)
X-Gm-Message-State: AOJu0Yz3eKsTva3d9hyw4qU+dDSvxTYdJCPKTUWSCMAZHSDenZ8UjzZe
	wZ/U6eBx/fuEvg3D7ujDPczF8AJ+6JJW37I1Gep+oLeN1oWs1skWIjW6GxFXxkabGOowKro7c5g
	XkBd+QElAJ3orHoWaYPS2t5yBKw1vkj8=
X-Google-Smtp-Source: AGHT+IH2PhXdxNaz/i0sO7yxpc7uJPaZKO4M3dAbJb9ZMUviia9lPNoja3s+efixal+V4XS32uDkCdEEft5w+mZhXrc=
X-Received: by 2002:a05:6830:3347:b0:7b0:826e:4002 with SMTP id
 46e09a7af769-7c94db2e9bemr1888637a34.20.1764789565081; Wed, 03 Dec 2025
 11:19:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203.200526.1986895588669292863.rene@exactco.de>
In-Reply-To: <20251203.200526.1986895588669292863.rene@exactco.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Dec 2025 20:19:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gHHHMmiE2OaT_a88Y7EOqHWN5ifOLxOx=segrze0s6pA@mail.gmail.com>
X-Gm-Features: AWmQ_bm_C3VJpte-lbkLRvD8FRR4SMthY290bpoL1DoH5Rt5K7mS93_IgqKkrGw
Message-ID: <CAJZ5v0gHHHMmiE2OaT_a88Y7EOqHWN5ifOLxOx=segrze0s6pA@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: Fix PCI bridges not to go to D3Hot on SPARC64
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: linux-pci@vger.kernel.org, rafael@kernel.org, 
	mika.westerberg@linux.intel.com, lukas@wunner.de, briannorris@chromium.org, 
	helgaas@kernel.org, linux-kernel@vger.kernel.org, 
	glaubitz@physik.fu-berlin.de, riccardo.mottola@libero.it, mani@kernel.org, 
	mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 8:05=E2=80=AFPM Ren=C3=A9 Rebe <rene@exactco.de> wro=
te:
>
> Commit a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all
> non-x86") was bisected to break some SPARC64 systems, see two oopses
> below. Fix by not allowing D3Hot on sparc64 while this is being
> further analyzed.
>
> Sun Blade 1000:
> ERROR(0): Cheetah error trap taken afsr[0010080005000000] afar[000007f900=
800000] TL1(0)
> ERROR(0): TPC[100a05a4] TNPC[100a05a8] O7[42acc8] TSTATE[4411001603]
> ERROR(0):
> TPC<MakeIocReady+0xc/0x278 [mptbase]>
> ERROR(0): M_SYND(0),  E_SYND(0), Privileged
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
>
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
-smp #1 NONE  Debian 6.16.12-2+sparc64.1
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
> Fixes: a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x8=
6")
> Cc: stable@kernel.org
> Signed-off-by: Ren=C3=A9 Rebe <rene@exactco.de>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

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
> @@ -3033,9 +3033,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge=
)
>
>                 /*
>                  * Out of caution, we only allow PCIe ports from 2015 or =
newer
> -                * into D3 on x86.
> +                * into D3 or x86. Avoid SPARC64 for now, too.
>                  */
> -               if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >=3D 2=
015)
> +               if ((IS_ENABLED(CONFIG_X86) && dmi_get_bios_year() >=3D 2=
015) ||
> +                   !IS_ENABLED(CONFIG_SPARC64))
>                         return true;
>                 break;
>         }
> --

