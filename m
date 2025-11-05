Return-Path: <linux-pci+bounces-40303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3791C33945
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 02:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D16D3A6A40
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 01:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6859923ABB9;
	Wed,  5 Nov 2025 01:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fab6Aj+k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218E22AE65
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304471; cv=none; b=QxYmvKYMu8id3kGDu9EVDwolMQpKhY4M5X4IZiHa/+YruQZvsG/TmXrvg9eYB44AVOgrXifvb0RbGtXG2vqemvmSaHJO42CLiUgty9k2e+zv7H4dy790FnmbW8OECq6VYWjZKuOQXPWGIJGK8zosr5VdSRv1wSfkOVcniqZ7t48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304471; c=relaxed/simple;
	bh=LNzC0bHEUBXHkFiE99rHGDkuGYJKjTGVPzzIlLFvOF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kR2ZmxdF5mNahFG9MjnY1Z1YLL4G6MtERwN+qnnyToFdh3bYVC84YGD3HXRKbFD70/r8ca3Ffke0tCSNob9zcIE8kFSrs26ZKb4hYTicby0jAaLA5HIuU9bG/gpVbtizBfDDl2S/851Gu4ZoENnOScegcSlmUfAS2ZeNasQp8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fab6Aj+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D413BC2BCB0
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 01:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762304470;
	bh=LNzC0bHEUBXHkFiE99rHGDkuGYJKjTGVPzzIlLFvOF0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fab6Aj+kvmF+l/O+bD489wnSNlqjAT4YvcB3JPyA6yd/aijq1tC/IF68429DPsqSA
	 QFVptn9QyCR4yp6KllUryWZzz+MbvbgzLGexKzzvEMpGhJJAWzjr45ZU39GY3UAMHy
	 zS0ky2/+vtPU8kGnMxFTqEZNbsKB9LQ1yeXf9P+I5rIEoIzTXlJ38p2JTrfE3iTFrF
	 2pQmq/4tfXoS/bZ84YvsRyMB5S3YnkJcdHuZoHcVYOhXs1QxvlK4eYgzRE3VpgxQ2Z
	 0g1MOkHgWaVrx7zcJ3Ju8MYo9NuBPV5EX21H/GaCkBIsiHmG3yzEXh++t6aW/k+UiQ
	 muaXiJImZwTMg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640741cdda7so8032698a12.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Nov 2025 17:01:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSVqqVVDIOIjxq4mbMOIr/Xvyb7+x2I6b1fGnpOHPBjcF9DAoKnFdHQma1+LM1RiEV+mq3Ki/sJJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiP/SHK6Sq5feiDk/seBAcpJunXNjVHITRF18PHIn8r1IF9hsQ
	bNChhpjHwwKUDri/vYH8v25eQbWunkdmtyojhbhPFwLAGQ0FOxjDSY3bXq1ygSb7Z1kDlUuARx3
	A2R3Tv83CfnnA9QTZ4QHyQIrHGYWjvpU=
X-Google-Smtp-Source: AGHT+IGrGxegHnyKau9LpVTGrgCjY6ZZT6K86nQYSNmmK0d4RdpQlY330regr/qFOTeAwxQkSbr86alOZaV1UFna+As=
X-Received: by 2002:a17:907:7e96:b0:b72:5918:b90a with SMTP id
 a640c23a62f3a-b72652b86bcmr121172966b.25.1762304468276; Tue, 04 Nov 2025
 17:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-ari_no_bus_dev-v5-0-d9a5eab67ed0@linux.ibm.com>
 <20251029-ari_no_bus_dev-v5-1-d9a5eab67ed0@linux.ibm.com> <CAAhV-H6qqppoX_G5KrWmPor16bXfvNTE2x8Xx6yajAYPqxpigw@mail.gmail.com>
 <958ef380be4ea488698fab05245d631998c32a48.camel@linux.ibm.com>
In-Reply-To: <958ef380be4ea488698fab05245d631998c32a48.camel@linux.ibm.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 5 Nov 2025 09:01:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7iMKmLnisD-874D2ZC919sDYeWy3tw=+eUqifK--6-Dg@mail.gmail.com>
X-Gm-Features: AWmQ_blaQYn17oCd4-puacfkSPvyHc_K4OxzWeUbJCHm18Co-iitsn6Aix4lBVI
Message-ID: <CAAhV-H7iMKmLnisD-874D2ZC919sDYeWy3tw=+eUqifK--6-Dg@mail.gmail.com>
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

On Mon, Nov 3, 2025 at 7:23=E2=80=AFPM Niklas Schnelle <schnelle@linux.ibm.=
com> wrote:
>
> On Mon, 2025-11-03 at 17:50 +0800, Huacai Chen wrote:
> > Hi, Niklas,
> >
> > On Wed, Oct 29, 2025 at 5:42=E2=80=AFPM Niklas Schnelle <schnelle@linux=
.ibm.com> wrote:
> > >
> > > When the isolated PCI function probing mechanism is used in conjuncti=
on
> > > with ARI or SR-IOV it may not find all available PCI functions. In th=
e
> > > case of ARI the problem is that next_ari_fn() always returns -ENODEV =
if
> > > dev is NULL and thus if fn 0 is missing the scan stops.
> > >
> > > For SR-IOV things are more complex. Here the problem is that the chec=
k
> > > for multifunction may fail. One example where this can occur is if th=
e
> > > first passed-through function is a VF with devfn 8. Now in
> > > pci_scan_slot() this means it is fn 0 and thus multifunction doesn't =
get
> > > set. Since VFs don't get multifunction set via PCI_HEADER_TYPE_MFD it
> > > remains unset and probing stops even if there is a devfn 9.
> > >
> > > Now at the moment both of these issues are hidden on s390. The first =
one
> > > because ARI is detected as disabled as struct pci_bus's self is NULL
> > > even though firmware does enable and use ARI. The second issue is hid=
den
> > > as a side effect of commit 25f39d3dcb48 ("s390/pci: Ignore RID for
> > > isolated VFs"). This is because VFs are either put on their own virtu=
al
> > > bus if the parent PF is not passed-through to the same instance or VF=
s
> > > are hotplugged once SR-IOV is enabled on the parent PF and then
> > > pci_scan_single_device() is used.
> > >
> > > Still especially the first issue prevents correct detection of ARI an=
d
> > > the second might be a problem for other users of isolated function
> > > probing. Fix both issues by keeping things as simple as possible. If
> > > isolated function probing is enabled simply scan every possible devfn=
.
> > I'm very sorry, but applying this patch on top of commit a02fd05661d7
> > ("PCI: Extend isolated function probing to LoongArch") we fail to
> > boot.
> >
> > Boot log:
> > [   10.365340] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16
> > 00:01:03 EST 2006)
> > [   10.372628] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 ES=
T 2006)
> > [   10.379564] megasas: 07.734.00.00-rc1
> > [   10.383222] mpt3sas version 54.100.00.00 loaded
> > [   10.388304] nvme nvme0: pci function 0000:08:00.0
> > [   10.395088] Freeing initrd memory: 45632K
> > [   10.469822] ------------[ cut here ]------------
> > [   10.474409] WARNING: CPU: 0 PID: 247 at drivers/ata/libahci.c:233
> > ahci_enable_ahci+0x64/0xb8
> > [   10.482804] Modules linked in:
> > [   10.485838] CPU: 0 UID: 0 PID: 247 Comm: kworker/0:11 Not tainted
> > 6.18.0-rc3 #1 PREEMPT(full)
> > [   10.494397] Hardware name: To be filled by O.E.M.To be fill To be
> > filled by O.E.M.To be fill/To be filled by O.E.M.To be fill, BIOS
> > Loongson-UDK2018-V4.0.
> > [   10.508139] Workqueue: events work_for_cpu_fn
> > [   10.512468] pc 900000000103be2c ra 900000000103be28 tp
> > 900000010ae44000 sp 900000010ae47be0
> > [   10.520769] a0 0000000000000000 a1 00000000000000b0 a2
> > 0000000000000001 a3 9000000001810e0c
> > [   10.529069] a4 9000000002343e20 a5 0000000000000001 a6
> > 0000000000000010 a7 0000000000000000
> > [   10.537373] t0 d10951fa66920f31 t1 d10951fa66920f31 t2
> > 0000000000001280 t3 000000000674c000
> > [   10.545673] t4 0000000000000000 t5 0000000000000000 t6
> > 9000000008002480 t7 00000000000000b4
> > [   10.553972] t8 90000001055eab90 u0 900000010ae47b68 s9
> > 9000000002221a50 s0 0000000000000000
> > [   10.562272] s1 ffff800032435800 s2 0000000000000000 s3
> > ffffffff80000000 s4 9000000002221570
> > [   10.570571] s5 0000000000000005 s6 9000000101ccf0b8 s7
> > 90000000023dd000 s8 900000010ae47d08
> > [   10.578869]    ra: 900000000103be28 ahci_enable_ahci+0x60/0xb8
> > [   10.584665]   ERA: 900000000103be2c ahci_enable_ahci+0x64/0xb8
> > [   10.590461]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -W=
E)
> > [   10.596609]  PRMD: 00000004 (PPLV0 +PIE -PWE)
> > [   10.600937]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> > [   10.605698]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
> > [   10.610458] ESTAT: 000c0000 [BRK] (IS=3D ECode=3D12 EsubCode=3D0)
> > [   10.615994]  PRID: 0014d010 (Loongson-64bit, Loongson-3C6000/S)
> > [   10.621875] CPU: 0 UID: 0 PID: 247 Comm: kworker/0:11 Not tainted
> > 6.18.0-rc3 #1 PREEMPT(full)
> > [   10.621877] Hardware name: To be filled by O.E.M.To be fill To be
> > filled by O.E.M.To be fill/To be filled by O.E.M.To be fill, BIOS
> > Loongson-UDK2018-V4.0.
> > [   10.621878] Workqueue: events work_for_cpu_fn
> > [   10.621881] Stack : 900000010ae47848 0000000000000000
> > 90000000002436bc 900000010ae44000
> > [   10.621884]         900000010ae47820 900000010ae47828
> > 0000000000000000 900000010ae47968
> > [   10.621887]         900000010ae47960 900000010ae47960
> > 900000010ae47630 0000000000000001
> > [   10.621890]         0000000000000001 900000010ae47828
> > d10951fa66920f31 9000000100414300
> > [   10.621893]         80000000ffffe34d fffffffffffffffe
> > 000000000000034f 000000000000002f
> > [   10.621896]         0000000000000063 0000000000000001
> > 000000000674c000 9000000002221a50
> > [   10.621899]         0000000000000000 0000000000000000
> > 90000000020b6500 90000000023dd000
> > [   10.621902]         00000000000000e9 0000000000000009
> > 0000000000000002 90000000023dd000
> > [   10.621905]         900000010ae47d08 0000000000000000
> > 90000000002436d4 0000000000000000
> > [   10.621908]         00000000000000b0 0000000000000004
> > 0000000000000000 0000000000071c1d
> > [   10.621910]         ...
> > [   10.621912] Call Trace:
> > [   10.621913] [<90000000002436d4>] show_stack+0x5c/0x180
> > [   10.621918] [<900000000023f328>] dump_stack_lvl+0x6c/0x9c
> > [   10.621923] [<9000000000266eb8>] __warn+0x80/0x108
> > [   10.621927] [<90000000017d1910>] report_bug+0x158/0x2a8
> > [   10.621932] [<900000000180b610>] do_bp+0x2d0/0x340
> > [   10.621938] [<9000000000241da0>] handle_bp+0x120/0x1c0
> > [   10.621940] [<900000000103be2c>] ahci_enable_ahci+0x64/0xb8
> > [   10.621943] [<900000000103beb8>] ahci_save_initial_config+0x38/0x4d8
> > [   10.621946] [<90000000010391b4>] ahci_init_one+0x354/0x1088
> > [   10.621950] [<9000000000d16cdc>] local_pci_probe+0x44/0xb8
> > [   10.621953] [<9000000000286f78>] work_for_cpu_fn+0x18/0x30
> > [   10.621956] [<900000000028a840>] process_one_work+0x160/0x330
> > [   10.621961] [<900000000028b208>] worker_thread+0x330/0x460
> > [   10.621964] [<9000000000295fdc>] kthread+0x11c/0x138
> > [   10.621968] [<900000000180b740>] ret_from_kernel_thread+0x28/0xa8
> > [   10.621971] [<9000000000241484>] ret_from_kernel_thread_asm+0xc/0x88
> > [   10.621973]
> >
> >
>
> This looks like a warning telling us that AHCI enable failed / timed
> out. Do you have Panic on Warn on that this directly causes a boot
> failure? The only relation I can see with my patch is that maybe this
> AHCI device wasn't probed before and somehow isn't working?
The rootfs is on the AHCI controller, so AHCI failure causes the boot
failure, without this patch no boot problems.

Huacai

>
> Thanks,
> Niklas

