Return-Path: <linux-pci+bounces-10850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B4593D876
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 20:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6E71C23327
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FF4433DF;
	Fri, 26 Jul 2024 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpJ7bFjw"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4923F3FB83
	for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019400; cv=none; b=KazJ4xHgoqHb0m8afUUh2koj43j1M43DGtRcn6fmv4Q94A71ILgyoKN23OIXvfSHuD1c5CMuUda06mkcOofvQQM3zqpzvR8/0lVfAPnzGFB9CSdPv+qb8M0avUO6igVqun7E1MS4oOsJHGge1RYbZPXtRODfPMBGhBhBzuyVC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019400; c=relaxed/simple;
	bh=XInYtRsO0ig8ZYzFvn+qr6hSi2uJ387yYJHAZojDWZU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KQkQtcgRW4/2HlwtDq3gxiWVwgtfWKA2onkR9j4qjrQ9GPhKt4MnAgHw/LzpJLOaFeMsBPOamyhM6NaboyFMw1DvSyzZjVfXa5tt9znLl8AJrGi6dwaBIC9hsIGF4/wdndC50STfH9mNdOf52/ytVUmF7PncwLBLQ+QSXGJUgVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpJ7bFjw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722019397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcNO3jbhugBwlmCnyZwTsF0UWnAb4uSNNdMpqge9mGk=;
	b=dpJ7bFjwUIyUk1/WgPq3nY9E580rkhHEJnCXKdbp6kannChZEsUQQLUJ/yVf/sR7pO52kP
	f0wizZIkUjP1GHg51LEgoEPgtmtlPwXXrXGXryqBg9XmUjClvBEZ582Y/ekLX8MihLo8TJ
	XDAuJvUMMOaNfK/y97tWaS+ItNaRs78=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-Z0gK8EAHMveUqAo3qo8DDg-1; Fri, 26 Jul 2024 14:43:15 -0400
X-MC-Unique: Z0gK8EAHMveUqAo3qo8DDg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5a2b8c44b48so501575a12.0
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 11:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722019394; x=1722624194;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bcNO3jbhugBwlmCnyZwTsF0UWnAb4uSNNdMpqge9mGk=;
        b=Zv9VfSeSf5Wq1Opmm27ph1eMlwJPyOqRXgFzrdQaoEZ+b6j6h6CWeW5rCK6/iGul+1
         mXpARzmHEXxXU2U1jlwkKl3gNjGtaoFBXicueESPUYe0dtwW3FLE3VODhuZBzGtbV/L4
         UHNAb/XZncydChXsV503sMsTIE/iGe+aDbuj7rvZae4Z0pHwgQuDABWleuso14iuVYi+
         EvytsSOKPxoqVilgMGO5HiopdTrzZPBZC6UR7cvBqSs21hASBFJlJUibnXxuiLEwTs7O
         +ajBzDpd6oB+rfuZxctqNV6jaeUN8LTfxGJCmdLF2huaRz78hBTAVzjQJaduc+feK2gc
         ZsMQ==
X-Gm-Message-State: AOJu0Yw0uT/MAjkZ39cocIzMyfKbzbkwNLLzr26Cngc0BZyXqNISpMDj
	P3Yc27g2bsaBwxtNl84DgGsA2rr11xK9ug+wVWQOLX3b4hZwHQRmHbWyaA/7b7ogbS1iGqx1+rL
	zzy7LFFQgRRqbJ3I7RZCXfkeDRsNFPkFHt3gJ1TWZEjQ9prhBJjaAEsU8R41l3/E9sg==
X-Received: by 2002:a05:6402:2711:b0:5a1:1ce3:9b58 with SMTP id 4fb4d7f45d1cf-5ac2775629cmr2906981a12.0.1722019394284;
        Fri, 26 Jul 2024 11:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI8/kRV51i8KHNBfGqgH9nsoK9ivieO2uRjEp1YZSEZIQ69c9eUiRlLcZjjUEy6A7Ui5M5hQ==
X-Received: by 2002:a05:6402:2711:b0:5a1:1ce3:9b58 with SMTP id 4fb4d7f45d1cf-5ac2775629cmr2906973a12.0.1722019393756;
        Fri, 26 Jul 2024 11:43:13 -0700 (PDT)
Received: from fedora.fritz.box (200116b82d4f5c00cbecb909b7d5f58c.dip.versatel-1u1.de. [2001:16b8:2d4f:5c00:cbec:b909:b7d5:f58c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b0464sm2244168a12.4.2024.07.26.11.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 11:43:13 -0700 (PDT)
Message-ID: <ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.camel@redhat.com>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
From: pstanner@redhat.com
To: Damien Le Moal <dlemoal@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>,  Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 26 Jul 2024 20:43:12 +0200
In-Reply-To: <6ce4c9f4-7c75-4451-8c6f-fe3d6a3dd913@kernel.org>
References: <20240725120729.59788-2-pstanner@redhat.com>
	 <6ce4c9f4-7c75-4451-8c6f-fe3d6a3dd913@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-26 at 09:19 +0900, Damien Le Moal wrote:
> On 7/25/24 21:07, Philipp Stanner wrote:
> > pci_intx() is a function that becomes managed if
> > pcim_enable_device()
> > has been called in advance. Commit 25216afc9db5 ("PCI: Add managed
> > pcim_intx()") changed this behavior so that pci_intx() always leads
> > to
> > creation of a separate device resource for itself, whereas earlier,
> > a
> > shared resource was used for all PCI devres operations.
> >=20
> > Unfortunately, pci_intx() seems to be used in some drivers'
> > remove()
> > paths; in the managed case this causes a device resource to be
> > created
> > on driver detach.
> >=20
> > Fix the regression by only redirecting pci_intx() to its managed
> > twin
> > pcim_intx() if the pci_command changes.
> >=20
> > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> > Reported-by: Damien Le Moal <dlemoal@kernel.org>
> > Closes:
> > https://lore.kernel.org/all/b8f4ba97-84fc-4b7e-ba1a-99de2d9f0118@kernel=
.org/
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > Alright, I reproduced this with QEMU as Damien described and this
> > here
> > fixes the issue on my side. Feedback welcome. Thank you very much,
> > Damien.
>=20
> This works ans is cleaner that what I had :)

The fundamental idea is mostly identical to yours =E2=80=93 you likely just
didn't see it because your attention was directed towards the code in
devres.c ;)

>=20
> Tested-by: Damien Le Moal <dlemoal@kernel.org>

You might wanna ping Bjorn about that in case he didn't see.

>=20
> > It seems that this might yet again be the issue of drivers not
> > being
> > aware that pci_intx() might become managed, so they use it in their
> > unwind path (rightfully so; there probably was no alternative back
> > then).
>=20
> At least for the ahci driver with wich I found the issue, what is odd
> is that
> there is only a single call to pci_intx()=C2=A0

There is only a single _directly visible_ call :]

> to *enable* intx, and that call is in
> the probe path. With QEMU, this call is not even done as the qemu
> AHCI support MSI.

Hmm, MSI...

>=20
> Adding a WARN_ON(!enable) at the beginning of pci_inx(), we can see
> that what
> happens is that during device probe, we get this backtrace:
>=20
> [=C2=A0=C2=A0 34.658988] WARNING: CPU: 0 PID: 999 at drivers/pci/pci.c:44=
80
> pci_intx+0x7f/0xc0
> [=C2=A0=C2=A0 34.660799] Modules linked in: ahci(+) rpcsec_gss_krb5 auth_=
rpcgss
> nfsv4
> dns_resolver nfs lockd grace netfs]
> [=C2=A0=C2=A0 34.673784] CPU: 0 UID: 0 PID: 999 Comm: modprobe Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W
> =C2=A06.10.0+ #1948
> [=C2=A0=C2=A0 34.675961] Tainted: [W]=3DWARN
> [=C2=A0=C2=A0 34.676891] Hardware name: QEMU Standard PC (Q35 + ICH9, 200=
9),
> BIOS
> 1.16.3-2.fc40 04/01/2014
> [=C2=A0=C2=A0 34.679197] RIP: 0010:pci_intx+0x7f/0xc0
> [=C2=A0=C2=A0 34.680348] Code: b7 d2 be 04 00 00 00 48 89 df e8 0c 84 ff =
ff 48
> 8b 44 24 08
> 65 48 2b 04 25 28 00 00 00 756
> [=C2=A0=C2=A0 34.685015] RSP: 0018:ffffb60f40e2f7f0 EFLAGS: 00010246
> [=C2=A0=C2=A0 34.686436] RAX: 0000000000000000 RBX: ffff9dbb81237000 RCX:
> ffffb60f40e2f64c
> [=C2=A0=C2=A0 34.688294] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff9dbb81237000
> [=C2=A0=C2=A0 34.690120] RBP: 0000000000000000 R08: 0000000000000000 R09:
> 0000000000000001
> [=C2=A0=C2=A0 34.691986] R10: ffff9dbb88883538 R11: 0000000000000001 R12:
> 0000000000000001
> [=C2=A0=C2=A0 34.693687] R13: ffff9dbb812370c8 R14: ffff9dbb86eeaa00 R15:
> 0000000000000000
> [=C2=A0=C2=A0 34.695140] FS:=C2=A0 00007f9d81465740(0000) GS:ffff9dbcf7c0=
0000(0000)
> knlGS:0000000000000000
> [=C2=A0=C2=A0 34.696884] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> [=C2=A0=C2=A0 34.698107] CR2: 00007ffc786ed8b8 CR3: 00000001088da000 CR4:
> 0000000000350ef0
> [=C2=A0=C2=A0 34.699562] Call Trace:
> [=C2=A0=C2=A0 34.700215]=C2=A0 <TASK>
> [=C2=A0=C2=A0 34.700802]=C2=A0 ? pci_intx+0x7f/0xc0
> [=C2=A0=C2=A0 34.701607]=C2=A0 ? __warn.cold+0xa5/0x13c
> [=C2=A0=C2=A0 34.702448]=C2=A0 ? pci_intx+0x7f/0xc0
> [=C2=A0=C2=A0 34.703257]=C2=A0 ? report_bug+0xff/0x140
> [=C2=A0=C2=A0 34.704105]=C2=A0 ? handle_bug+0x3a/0x70
> [=C2=A0=C2=A0 34.704938]=C2=A0 ? exc_invalid_op+0x17/0x70
> [=C2=A0=C2=A0 34.705826]=C2=A0 ? asm_exc_invalid_op+0x1a/0x20
> [=C2=A0=C2=A0 34.706593]=C2=A0 ? pci_intx+0x7f/0xc0
> [=C2=A0=C2=A0 34.707086]=C2=A0 msi_capability_init+0x35a/0x370
> [=C2=A0=C2=A0 34.707723]=C2=A0 __pci_enable_msi_range+0x187/0x240
> [=C2=A0=C2=A0 34.708356]=C2=A0 pci_alloc_irq_vectors_affinity+0xc4/0x110
> [=C2=A0=C2=A0 34.709058]=C2=A0 ahci_init_one+0x6ec/0xcc0 [ahci]
> [=C2=A0=C2=A0 34.709692]=C2=A0 ? __pm_runtime_resume+0x58/0x90
> [=C2=A0=C2=A0 34.710311]=C2=A0 local_pci_probe+0x45/0x90
> [=C2=A0=C2=A0 34.710865]=C2=A0 pci_device_probe+0xbb/0x230
> [=C2=A0=C2=A0 34.711433]=C2=A0 really_probe+0xcc/0x350
> [=C2=A0=C2=A0 34.711976]=C2=A0 ? pm_runtime_barrier+0x54/0x90
> [=C2=A0=C2=A0 34.712569]=C2=A0 ? __pfx___driver_attach+0x10/0x10
> [=C2=A0=C2=A0 34.713206]=C2=A0 __driver_probe_device+0x78/0x110
> [=C2=A0=C2=A0 34.713837]=C2=A0 driver_probe_device+0x1f/0xa0
> [=C2=A0=C2=A0 34.714427]=C2=A0 __driver_attach+0xbe/0x1d0
> [=C2=A0=C2=A0 34.715001]=C2=A0 bus_for_each_dev+0x92/0xe0
> [=C2=A0=C2=A0 34.715563]=C2=A0 bus_add_driver+0x115/0x200
> [=C2=A0=C2=A0 34.716136]=C2=A0 driver_register+0x72/0xd0
> [=C2=A0=C2=A0 34.716704]=C2=A0 ? __pfx_ahci_pci_driver_init+0x10/0x10 [ah=
ci]
> [=C2=A0=C2=A0 34.717457]=C2=A0 do_one_initcall+0x76/0x3a0
> [=C2=A0=C2=A0 34.718036]=C2=A0 do_init_module+0x60/0x210
> [=C2=A0=C2=A0 34.718616]=C2=A0 init_module_from_file+0x86/0xc0
> [=C2=A0=C2=A0 34.719243]=C2=A0 idempotent_init_module+0x127/0x2c0
> [=C2=A0=C2=A0 34.719913]=C2=A0 __x64_sys_finit_module+0x5e/0xb0
> [=C2=A0=C2=A0 34.720546]=C2=A0 do_syscall_64+0x7d/0x160
> [=C2=A0=C2=A0 34.721100]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 34.721695]=C2=A0 ? do_syscall_64+0x89/0x160
> [=C2=A0=C2=A0 34.722258]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 34.722846]=C2=A0 ? do_sys_openat2+0x9c/0xe0
> [=C2=A0=C2=A0 34.723421]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 34.724012]=C2=A0 ? syscall_exit_to_user_mode+0x64/0x1f0
> [=C2=A0=C2=A0 34.724703]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 34.725293]=C2=A0 ? do_syscall_64+0x89/0x160
> [=C2=A0=C2=A0 34.725883]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 34.726467]=C2=A0 ? syscall_exit_to_user_mode+0x64/0x1f0
> [=C2=A0=C2=A0 34.727159]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 34.727764]=C2=A0 ? do_syscall_64+0x89/0x160
> [=C2=A0=C2=A0 34.728341]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 34.728937]=C2=A0 ? exc_page_fault+0x6c/0x200
> [=C2=A0=C2=A0 34.729511]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 34.730109]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [=C2=A0=C2=A0 34.730837] RIP: 0033:0x7f9d80d281dd
> [=C2=A0=C2=A0 34.731375] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 =
0f 1e
> fa 48 89 f8
> 48 89 f7 48 89 d6 48 89 ca 4d8
> [=C2=A0=C2=A0 34.733796] RSP: 002b:00007ffc786f0898 EFLAGS: 00000246 ORIG=
_RAX:
> 0000000000000139
> [=C2=A0=C2=A0 34.734894] RAX: ffffffffffffffda RBX: 00005617347f09a0 RCX:
> 00007f9d80d281dd
> [=C2=A0=C2=A0 34.735850] RDX: 0000000000000000 RSI: 0000561715fe5e79 RDI:
> 0000000000000003
> [=C2=A0=C2=A0 34.736812] RBP: 00007ffc786f0950 R08: 00007f9d80df6b20 R09:
> 00007ffc786f08e0
> [=C2=A0=C2=A0 34.737769] R10: 00005617347f13e0 R11: 0000000000000246 R12:
> 0000561715fe5e79
> [=C2=A0=C2=A0 34.738725] R13: 0000000000040000 R14: 00005617347f8990 R15:
> 00005617347f8b20
> [=C2=A0=C2=A0 34.739695]=C2=A0 </TASK>
> [=C2=A0=C2=A0 34.740075] ---[ end trace 0000000000000000 ]---
>=20
> So it is msi_capability_init() that is the problem: that function
> calls
> pci_intx_for_msi(dev, 0) which then calls pci_intx(dev, 0), thus
> creating the
> intx devres for the device despite the driver code not touching intx
> at all.

Nope, that is not the problem =E2=80=93 as you correctly point out below, t=
hat
device resource should be destroyed again.

> The driver is fine ! It is MSI touching INTX that is messing things
> up.

Yes, many drivers are more or less innocent in regards with all of
that. As Christoph rightfully pointed out, an API should never behave
like that and do _implicit_ magic behind your back. That's the entire
philosophy of the C Language.

>=20
> That said, I do not see that as an issue in itself. What I fail to
> understand
> though is why that intx devres is not deleted on device teardown. I
> think this
> may have something to do with the fact that pcim_intx() always does
> "res->orig_intx =3D !enable;", that is, it assumes that if there is a
> call to
> pcim_intx(dev, 0), then it is because intx where enabled already,
> which I do not
> think is true for most drivers... So we endup with INTX being wrongly
> enabled on
> device teardown by pcim_intx_restore(), and because of that, the intx
> resource
> is not deleted ?

Spoiler: The device resources that have initially been created do get
deleted. Devres works as intended. The issue is that the forces of evil
invoke pci_intx() through another path, hidden behind an API, through
another devres callback.

So the device resource never gets deleated because it is *created* on
driver detach, when devres already ran.

>=20
> Re-enabling intx on teardown is wrong I think, but that still does
> not explain
> why that resource is not deleted. I fail to see why.

You came very close to the truth ;)

With some help from my favorite coworker I did some tracing today and
found this when doing `rmmod ahci`:

=3D> pci_intx
=3D> pci_msi_shutdown
=3D> pci_disable_msi
=3D> devres_release_all
=3D> device_unbind_cleanup
=3D> device_release_driver_internal
=3D> driver_detach
=3D> bus_remove_driver
=3D> pci_unregister_driver
=3D> __do_sys_delete_module
=3D> do_syscall_64
=3D> entry_SYSCALL_64_after_hwframe

The SYSCALL is my `rmmod`.

As you can see, pci_intx() is invoked indirectly through
pci_disable_msi() =E2=80=93 which gets invoked by devres, which is precisel=
y
one reason why you could not find the suspicious pci_intx() call in the
ahci code base.

Now the question is: Who set up that devres callback which indirectly
calls pci_intx()?

It is indeed MSI, here in msi/msi.c:

static void pcim_msi_release(void *pcidev)
{
 struct pci_dev *dev =3D pcidev;

 dev->is_msi_managed =3D false;
 pci_free_irq_vectors(dev); // <-- calls pci_disable_msi(), which calls pci=
_intx(), which re-registers yet another devres callback
}

/*
 * Needs to be separate from pcim_release to prevent an ordering problem

=3D=3D> Oh, here they even had a warning about that interacting with devres=
 somehow...

 * vs. msi_device_data_release() in the MSI core code.
 */
static int pcim_setup_msi_release(struct pci_dev *dev)
{
 int ret;

 if (!pci_is_managed(dev) || dev->is_msi_managed)
 return 0;

 ret =3D devm_add_action(&dev->dev, pcim_msi_release, dev);
 if (ret)
 return ret;

 dev->is_msi_managed =3D true;
 return 0;
}

I don't know enough about AHCI to see where exactly it jumps into
these, but a candidate would be:
 * pci_enable_msi(), called among others in acard-ahci.c

Another path is:
   1. ahci_init_one() calls
   2. ahci_init_msi() calls
   3. pci_alloc_irq_vectors() calls
   4. pci_alloc_irq_vectors_affinity() calls
   5. __pci_enable_msi_range() OR __pci_enable_msix_range() call
   6. pci_setup_msi_context() calls
   7. pcim_setup_msi_release() which registers the callback to
      pci_intx()


Ha!

I think I earned myself a Friday evening beer now 8-)


Now the interesting question will be how the heck we're supposed to
clean that up.

Another interesting question is: Did that only work by coincidence
during the last 15 years, or is it by design that the check in
pci_intx():

if (new !=3D pci_command)

only evaluates to true if we are not in a detach path.

If it were coincidence, it would not have caused faults as it did now
with my recent work, because the old version did not allocate in
pci_intx().

But it could certainly have been racy and might run into a UAF since
the old pci_intx() would have worked on memory that is also managed by
devres, but has been registered at a different place. I guess that is
what that comment in the MSI code quoted above is hinting at.


Christoph indeed rightfully called it voodoo ^^


Cheers,
P.


