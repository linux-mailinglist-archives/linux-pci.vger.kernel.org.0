Return-Path: <linux-pci+bounces-40095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5277AC2AD9C
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 10:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67E894EB557
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4584C2F9980;
	Mon,  3 Nov 2025 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0d/tbvL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200992FB087
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163428; cv=none; b=XxsPA7v9OtbAHQVrDB1FE648aFJciFruA/0jo2p+8MaHZOIi1qOGL/iJzqa/GT9434QebOeywTcOi9KcMZcN0J9l30d1IRvgGJZMy/VwTJZZvXA9DppSidjkfnLkfc4xUviQ6pSqN/Qw5eiKyaKDdALcA+myTx6k4VtHkaGF5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163428; c=relaxed/simple;
	bh=tYIRJCNDS83FSlihnAvsUz65Uw1RaaI3aab9pQPHdcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBuO6q4cxQ6ojIxehQXvrwtXLUUEjRH/em5sP6LJRGEv0R84xIOEZl+lq8d1+fE4IahxRuYCt+lI7FDOa+sHAAqRbHzY46FuUQzX/AvV1jKVBszAbHB6XoXEy0rzSwytvcPSarp5g5aWhvRR0Zpr6Z2hVlZwtd5W/6TVrLU7Eag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0d/tbvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B589DC4CEE7
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762163427;
	bh=tYIRJCNDS83FSlihnAvsUz65Uw1RaaI3aab9pQPHdcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o0d/tbvLY21MJS8egZkd0Ri1kw6SIk6ujVTmZp3+FHJgDC446N+4YaN0P8z5/Ak+m
	 eVDkw3ons91vLRaElSJNtusAMLzGrqqj3SklVGWcEoapPntfieh25BEBz7wNCA/g/u
	 7Ar4rwgSEFzKYKhdgxFZcjXabRLt5FukstCzexiPBZersOjx5WgGCpV9WFVNrpwSZ4
	 55fG+jYpwXNWUwRIxJCeJPh7n2QSWjrOQ7RK5wn3ZBO97Cgqne5mQJ9jo8lG3kQKgE
	 Zq9v0lJ97Qkh3/jeDPJODxyXTWeDes8J+gXtTtm3VXFNJAQHTqmoaoDSW7s/oJCUC2
	 cbFmULb7qNwvA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso6669710a12.2
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 01:50:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxtlPbsvSi0aKup5c5soOw5woUEAgTPA17FQfaINuy+oEmOTgmgGNo2+Ll8BfpIoOYCEL0Kkb7B28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlknJwAjXNIVF3qmbwxsD0JPqU27TbtFkp2ZVDHgUOtdFGrVzg
	rtLYrnjeJ0aGqK5JAYY5nydTw8nNLCyab8uqgeE499mAbQFNqxy69xiXBjRmoilAiBZ5d8CbLgV
	O4jKsbJSx3cOUxuKI9+5WtGHjMGoqn0U=
X-Google-Smtp-Source: AGHT+IH8qJzoI36AiJwr/7p2nTBJuZh3M5fSlb8Ojf11RW0d2BQ5ZRzirGxdOyLDc1rkkCxm0+GO4GSCTkJK54VerPk=
X-Received: by 2002:a17:907:60c9:b0:b70:b077:b949 with SMTP id
 a640c23a62f3a-b70b077bc32mr381684366b.37.1762163425945; Mon, 03 Nov 2025
 01:50:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-ari_no_bus_dev-v5-0-d9a5eab67ed0@linux.ibm.com> <20251029-ari_no_bus_dev-v5-1-d9a5eab67ed0@linux.ibm.com>
In-Reply-To: <20251029-ari_no_bus_dev-v5-1-d9a5eab67ed0@linux.ibm.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 3 Nov 2025 17:50:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6qqppoX_G5KrWmPor16bXfvNTE2x8Xx6yajAYPqxpigw@mail.gmail.com>
X-Gm-Features: AWmQ_bkF9DD4U4chJ9TajuEmQvXaXS5rbGCcvKkn6W1c1fvxW9F5_O2LhkhUoKE
Message-ID: <CAAhV-H6qqppoX_G5KrWmPor16bXfvNTE2x8Xx6yajAYPqxpigw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: Fix isolated PCI function probing with ARI
 and SR-IOV
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Bibo Mao <maobibo@loongson.cn>, linux-s390 <linux-s390@vger.kernel.org>, 
	loongarch@lists.linux.dev, Farhan Ali <alifm@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Gerd Bayer <gbayer@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Niklas,

On Wed, Oct 29, 2025 at 5:42=E2=80=AFPM Niklas Schnelle <schnelle@linux.ibm=
.com> wrote:
>
> When the isolated PCI function probing mechanism is used in conjunction
> with ARI or SR-IOV it may not find all available PCI functions. In the
> case of ARI the problem is that next_ari_fn() always returns -ENODEV if
> dev is NULL and thus if fn 0 is missing the scan stops.
>
> For SR-IOV things are more complex. Here the problem is that the check
> for multifunction may fail. One example where this can occur is if the
> first passed-through function is a VF with devfn 8. Now in
> pci_scan_slot() this means it is fn 0 and thus multifunction doesn't get
> set. Since VFs don't get multifunction set via PCI_HEADER_TYPE_MFD it
> remains unset and probing stops even if there is a devfn 9.
>
> Now at the moment both of these issues are hidden on s390. The first one
> because ARI is detected as disabled as struct pci_bus's self is NULL
> even though firmware does enable and use ARI. The second issue is hidden
> as a side effect of commit 25f39d3dcb48 ("s390/pci: Ignore RID for
> isolated VFs"). This is because VFs are either put on their own virtual
> bus if the parent PF is not passed-through to the same instance or VFs
> are hotplugged once SR-IOV is enabled on the parent PF and then
> pci_scan_single_device() is used.
>
> Still especially the first issue prevents correct detection of ARI and
> the second might be a problem for other users of isolated function
> probing. Fix both issues by keeping things as simple as possible. If
> isolated function probing is enabled simply scan every possible devfn.
I'm very sorry, but applying this patch on top of commit a02fd05661d7
("PCI: Extend isolated function probing to LoongArch") we fail to
boot.

Boot log:
[   10.365340] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16
00:01:03 EST 2006)
[   10.372628] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 20=
06)
[   10.379564] megasas: 07.734.00.00-rc1
[   10.383222] mpt3sas version 54.100.00.00 loaded
[   10.388304] nvme nvme0: pci function 0000:08:00.0
[   10.395088] Freeing initrd memory: 45632K
[   10.469822] ------------[ cut here ]------------
[   10.474409] WARNING: CPU: 0 PID: 247 at drivers/ata/libahci.c:233
ahci_enable_ahci+0x64/0xb8
[   10.482804] Modules linked in:
[   10.485838] CPU: 0 UID: 0 PID: 247 Comm: kworker/0:11 Not tainted
6.18.0-rc3 #1 PREEMPT(full)
[   10.494397] Hardware name: To be filled by O.E.M.To be fill To be
filled by O.E.M.To be fill/To be filled by O.E.M.To be fill, BIOS
Loongson-UDK2018-V4.0.
[   10.508139] Workqueue: events work_for_cpu_fn
[   10.512468] pc 900000000103be2c ra 900000000103be28 tp
900000010ae44000 sp 900000010ae47be0
[   10.520769] a0 0000000000000000 a1 00000000000000b0 a2
0000000000000001 a3 9000000001810e0c
[   10.529069] a4 9000000002343e20 a5 0000000000000001 a6
0000000000000010 a7 0000000000000000
[   10.537373] t0 d10951fa66920f31 t1 d10951fa66920f31 t2
0000000000001280 t3 000000000674c000
[   10.545673] t4 0000000000000000 t5 0000000000000000 t6
9000000008002480 t7 00000000000000b4
[   10.553972] t8 90000001055eab90 u0 900000010ae47b68 s9
9000000002221a50 s0 0000000000000000
[   10.562272] s1 ffff800032435800 s2 0000000000000000 s3
ffffffff80000000 s4 9000000002221570
[   10.570571] s5 0000000000000005 s6 9000000101ccf0b8 s7
90000000023dd000 s8 900000010ae47d08
[   10.578869]    ra: 900000000103be28 ahci_enable_ahci+0x60/0xb8
[   10.584665]   ERA: 900000000103be2c ahci_enable_ahci+0x64/0xb8
[   10.590461]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
[   10.596609]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[   10.600937]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[   10.605698]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
[   10.610458] ESTAT: 000c0000 [BRK] (IS=3D ECode=3D12 EsubCode=3D0)
[   10.615994]  PRID: 0014d010 (Loongson-64bit, Loongson-3C6000/S)
[   10.621875] CPU: 0 UID: 0 PID: 247 Comm: kworker/0:11 Not tainted
6.18.0-rc3 #1 PREEMPT(full)
[   10.621877] Hardware name: To be filled by O.E.M.To be fill To be
filled by O.E.M.To be fill/To be filled by O.E.M.To be fill, BIOS
Loongson-UDK2018-V4.0.
[   10.621878] Workqueue: events work_for_cpu_fn
[   10.621881] Stack : 900000010ae47848 0000000000000000
90000000002436bc 900000010ae44000
[   10.621884]         900000010ae47820 900000010ae47828
0000000000000000 900000010ae47968
[   10.621887]         900000010ae47960 900000010ae47960
900000010ae47630 0000000000000001
[   10.621890]         0000000000000001 900000010ae47828
d10951fa66920f31 9000000100414300
[   10.621893]         80000000ffffe34d fffffffffffffffe
000000000000034f 000000000000002f
[   10.621896]         0000000000000063 0000000000000001
000000000674c000 9000000002221a50
[   10.621899]         0000000000000000 0000000000000000
90000000020b6500 90000000023dd000
[   10.621902]         00000000000000e9 0000000000000009
0000000000000002 90000000023dd000
[   10.621905]         900000010ae47d08 0000000000000000
90000000002436d4 0000000000000000
[   10.621908]         00000000000000b0 0000000000000004
0000000000000000 0000000000071c1d
[   10.621910]         ...
[   10.621912] Call Trace:
[   10.621913] [<90000000002436d4>] show_stack+0x5c/0x180
[   10.621918] [<900000000023f328>] dump_stack_lvl+0x6c/0x9c
[   10.621923] [<9000000000266eb8>] __warn+0x80/0x108
[   10.621927] [<90000000017d1910>] report_bug+0x158/0x2a8
[   10.621932] [<900000000180b610>] do_bp+0x2d0/0x340
[   10.621938] [<9000000000241da0>] handle_bp+0x120/0x1c0
[   10.621940] [<900000000103be2c>] ahci_enable_ahci+0x64/0xb8
[   10.621943] [<900000000103beb8>] ahci_save_initial_config+0x38/0x4d8
[   10.621946] [<90000000010391b4>] ahci_init_one+0x354/0x1088
[   10.621950] [<9000000000d16cdc>] local_pci_probe+0x44/0xb8
[   10.621953] [<9000000000286f78>] work_for_cpu_fn+0x18/0x30
[   10.621956] [<900000000028a840>] process_one_work+0x160/0x330
[   10.621961] [<900000000028b208>] worker_thread+0x330/0x460
[   10.621964] [<9000000000295fdc>] kthread+0x11c/0x138
[   10.621968] [<900000000180b740>] ret_from_kernel_thread+0x28/0xa8
[   10.621971] [<9000000000241484>] ret_from_kernel_thread_asm+0xc/0x88
[   10.621973]

Huacai

>
> Cc: stable@vger.kernel.org
> Fixes: 189c6c33ff42 ("PCI: Extend isolated function probing to s390")
> Link: https://lore.kernel.org/linux-pci/d3f11e8562f589ddb2c1c83e74161bd89=
48084c3.camel@linux.ibm.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/probe.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a876afe72af35a9f4a44d598e8d500..41dd1a339a994956a6bc7e1fe=
a0fe0d55452a963 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2808,16 +2808,19 @@ static int next_ari_fn(struct pci_bus *bus, struc=
t pci_dev *dev, int fn)
>         return next_fn;
>  }
>
> -static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
> +static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn,
> +                  bool isolated_fns)
>  {
> -       if (pci_ari_enabled(bus))
> -               return next_ari_fn(bus, dev, fn);
> +       if (!isolated_fns) {
> +               if (pci_ari_enabled(bus))
> +                       return next_ari_fn(bus, dev, fn);
>
> +               /* only multifunction devices may have more functions */
> +               if (dev && !dev->multifunction)
> +                       return -ENODEV;
> +       }
>         if (fn >=3D 7)
>                 return -ENODEV;
> -       /* only multifunction devices may have more functions */
> -       if (dev && !dev->multifunction)
> -               return -ENODEV;
>
>         return fn + 1;
>  }
> @@ -2859,10 +2862,12 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>  {
>         struct pci_dev *dev;
>         int fn =3D 0, nr =3D 0;
> +       bool isolated_fns;
>
>         if (only_one_child(bus) && (devfn > 0))
>                 return 0; /* Already scanned the entire slot */
>
> +       isolated_fns =3D hypervisor_isolated_pci_functions();
>         do {
>                 dev =3D pci_scan_single_device(bus, devfn + fn);
>                 if (dev) {
> @@ -2876,10 +2881,10 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>                          * a hypervisor that passes through individual PC=
I
>                          * functions.
>                          */
> -                       if (!hypervisor_isolated_pci_functions())
> +                       if (!isolated_fns)
>                                 break;
>                 }
> -               fn =3D next_fn(bus, dev, fn);
> +               fn =3D next_fn(bus, dev, fn, isolated_fns);
>         } while (fn >=3D 0);
>
>         /* Only one slot has PCIe device */
>
> --
> 2.48.1
>

