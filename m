Return-Path: <linux-pci+bounces-43653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B08CDBC3B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 10:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6FAC30094AB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4239330322;
	Wed, 24 Dec 2025 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A61/YqaC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374CC330313
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766567518; cv=none; b=aAY+sLjxIm6WhssuFkVQ+YRgaCE2x6wYPWHRdfafXgcIUcb09CMtqLDl7HDyvKHteD9Ic9mQS4YJfTGNeTviZ+moJ/EkdulBBdQIV2GAqCZaOvCj2tgaZQaAib4YD34vzSnooAyoFXwi0oyf4FzCGsfIBVtvDvsRdi+BVbmeBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766567518; c=relaxed/simple;
	bh=TpIMFQwkBjLpN7TAR4OGUaKapxQMZxMvttMX5iboaPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDrjttCRg/v0uXC1o9kenFWlHdXAeaveLpqQk+OzKzMCsz5EXgRnlSlhIxW0F4gzTjGCi//72KfrnHmEEJcU4g1tWvq+P6m4L/Dfz046lmQDS+N+nUXfP+a4bROZea4hkvVfC4H02WofTofq4yZgwN4JuUebsCLNw1VHSsdKaiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A61/YqaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A71C2BCAF
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 09:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766567517;
	bh=TpIMFQwkBjLpN7TAR4OGUaKapxQMZxMvttMX5iboaPY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A61/YqaC8wJIboToHJJBSnuoZwJ+xZFiyMjRhErfG/UO5iHh3+c722aRwZ87HTjcm
	 7reUvWDzIbY6Q+xzUSS7PIsHbZ4trLKonyNbQpEUMG2uDfjWu1PfYxxdSuBb8ap289
	 XXKlsDiPxFCqgy8Yj+FHTo7wCC7gcILoFvYIq1jBmfjY1ZkXhilr2O9PosYE09gUqj
	 73t8iK16WETmSxwVIg3904bqrtSWBpvGinVwJ+L/0bLoOF/7k6uWoujvv2vnTD6Xlo
	 F2iX99sLN0+8Nffk3QUi9q26V4RJIyEVxIo5mE+omu4tmGm05LxX8HBXCYKhdbFsQi
	 DK9/suglzsK4A==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b8e5d1611so6921386a12.3
        for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 01:11:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVv6YgLK9EMZJSvMZ/tGrQng+SHBPm7RFxteLHqnO+hFseCD74d8DuzU2qKPiFdE9vtN5jyoYNo+2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxCBb/IdJhUM0gkhsrag0/K5TDF8ID6EFUP9vQwxWy8dJvCxq
	HMEYPPrPW/+v4v2Cwut3UJSNTvosDKbzY0Z4Dgw8QjpxO4917nTpYUaWqe0LHkWcGQvsdE2kE9D
	B8jrYQw3IIQ1HUqjKBXKiz3UFlS48u8U=
X-Google-Smtp-Source: AGHT+IHB89cIUvKSxmBt+g49jMK1OxGRtbh4e1aCsc1kMGYWhPRIMlED7E7Jggse9KD0KHnjmwpFcUF4knaH6YlLpjw=
X-Received: by 2002:a17:907:1b13:b0:b73:8e7d:4f87 with SMTP id
 a640c23a62f3a-b80371f8f3amr1660296066b.45.1766567515940; Wed, 24 Dec 2025
 01:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-ari_no_bus_dev-v5-0-d9a5eab67ed0@linux.ibm.com>
 <20251029-ari_no_bus_dev-v5-1-d9a5eab67ed0@linux.ibm.com> <CAAhV-H6qqppoX_G5KrWmPor16bXfvNTE2x8Xx6yajAYPqxpigw@mail.gmail.com>
 <958ef380be4ea488698fab05245d631998c32a48.camel@linux.ibm.com>
 <CAAhV-H7iMKmLnisD-874D2ZC919sDYeWy3tw=+eUqifK--6-Dg@mail.gmail.com>
 <8dd0f3df4b18a6c9f8b49ede7bc2ab71e40fd8f9.camel@linux.ibm.com>
 <CAAhV-H4MNSiUqYpE919YcCaC-_-Q3GBwxRL13ggjsyLahQ-t1A@mail.gmail.com>
 <7385677843a7790e01158644f63ae4dbb3353bfe.camel@linux.ibm.com>
 <298aaf6b2815e59d1a94efffdd0e3b002c000cea.camel@linux.ibm.com>
 <CAAhV-H7fgaZUuFSpE0VsMtptnrUTzh0TS=B9ZBUZ_=TH-XjKtg@mail.gmail.com>
 <ba63ea826472b4f2d2a318784b710ee91fdca202.camel@linux.ibm.com>
 <CAAhV-H6GE3q4qaPo9OvNkYOzatR-8BMYeGQ8hdmvKVZXbQF2rw@mail.gmail.com> <39e1536d956bfe061a4da7446c41a1b21eac0b37.camel@linux.ibm.com>
In-Reply-To: <39e1536d956bfe061a4da7446c41a1b21eac0b37.camel@linux.ibm.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 24 Dec 2025 17:12:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5-6t=4fybED5x7bRQWSdrS_578oF3=_OY4cr5yGsxqQA@mail.gmail.com>
X-Gm-Features: AQt7F2oyeADgMNN07eRhXBb99W5Fr9I_VpXM8w1tyoztbZo7I603nbJ5LCsIb1Q
Message-ID: <CAAhV-H5-6t=4fybED5x7bRQWSdrS_578oF3=_OY4cr5yGsxqQA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: Fix isolated PCI function probing with ARI
 and SR-IOV
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	linux-s390 <linux-s390@vger.kernel.org>, loongarch@lists.linux.dev, 
	Farhan Ali <alifm@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Gerd Bayer <gbayer@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 8:03=E2=80=AFPM Niklas Schnelle <schnelle@linux.ibm=
.com> wrote:
>
> On Wed, 2025-12-17 at 14:55 +0800, Huacai Chen wrote:
> > On Thu, Dec 4, 2025 at 5:45=E2=80=AFAM Niklas Schnelle <schnelle@linux.=
ibm.com> wrote:
> > >
> > > On Mon, 2025-12-01 at 22:45 +0800, Huacai Chen wrote:
> > > >
> > > --- snip ---
> > > > You said that "it feels like this is just a hack to probe an odd
> > > > topology". Yes, to some extent you are right.
> > > >
> > > > 1, One of our SoC (LS2K3000) has a special device which has func1 b=
ut
> > > > without func0. To let the PCI core scan func1 we can only make
> > > > hypervisor_isolated_pci_functions() return true.
> > > > 2, In the above case, PCI_SCAN_ALL_PCIE_DEVS has no help.
> > > > 3, Though we change hypervisor_isolated_pci_functions() to resolve =
the
> > > > above problem, it also lets us pass isolated PCI functions to a gue=
st
> > > > OS instance.
> > > >
> > > > As a summary, for real machines commit a02fd05661d73a850 is a hack =
to
> > > > probe an odd device, for virtual machines it allows passing isolate=
d
> > > > PCI functions.
> > >
> > > Ok, thanks for the answer. So let's see how we can debug this and get
> > > to a solution that works for both of us. Looking around a bit I see
> > > that your pci_loongson_map_bus() has some special handling for trying
> > > not to access non-existent devices added by your commit 2410e3301fcc
> > > ("PCI: loongson: Don't access non-existent devices"). I wonder if wit=
h
> > > this patch applied we're running into this same issue but with a devf=
n
> > > that was previously not tried and is not covered by your checks? And
> > > maybe since your root complex doesn't return 0xff for these non-
> > > existent devices we could end up trying to probe AHCI on such an empt=
y
> > > slot misinterpreting whatever it returns as matching device/vendor?
> > Commit 2410e3301fcc seems to have no relationship with current problems=
.
>
> I'm not so sure. The only thing this patch is potentially supposed to
> change is which devfns get enumerated and thus config space accessed
> looking for a device. And that commit talks about accessing non
> existent devices causing a system hang so that does seem fitting in
> principle.
>
> > >
> --- snip ---
> > > Could you try redoing the test with the AHCI hang but add a print of
> > > the affected bus/device/function that AHCI thinks it is probing? Then
> > > if the above theory applies we should see it trying to probe on a
> > > device that is missing in the correctly booted case and got past your
> > > existing checks.
> > By redoing this test we found there is only one AHCI detected, and the
> > BDF is: bus=3D0, device=3D8, fun=3D0.
> >
> > With or without this patch, only one AHCI. But without this patch, the
> > AHCI initialization doesn't hang.
> >
>
>
> This is all very odd. Just so there is no chance of misunderstanding.
> You did check the BDF that the ahci driver is trying to probe directly?
> I.e. something like what I added as the top commit here:
> https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=3Dl=
oongarch_debug
We check the BDF in ahci_init_one().

And with your repo, the boot log is like this:

[   10.454172] ahci 0000:00:08.0: ahci_enable_ahci() hung
[   10.459292] ------------[ cut here ]------------
[   10.463876] WARNING: drivers/ata/libahci.c:459 at
ahci_save_initial_config+0x3d8/0x448, CPU#0: kworker/0:2/253
[   10.473824] Modules linked in:
[   10.476856] CPU: 0 UID: 0 PID: 253 Comm: kworker/0:2 Not tainted
6.19.0-rc1+ #1 PREEMPT(full)
[   10.485416] Hardware name: To be filled by O.E.M.To be fill To be
filled by O.E.M.To be fill/To be filled by O.E.M.To be fill, BIOS
Loongson-UDK2018-V4.0.
[   10.499160] Workqueue: events work_for_cpu_fn
[   10.503489] pc 900000000104e3f8 ra 900000000104e3f8 tp
900000010fb74000 sp 900000010fb77c20
[   10.511788] a0 000000000000002a a1 90000000027223c0 a2
900000010fb77968 a3 90000000027223c8
[   10.520089] a4 90000000027223c0 a5 900000010fb77960 a6
0000000000000001 a7 0000000000000001
[   10.528390] t0 09c296afbf53694b t1 09c296afbf53694b t2
ffffffffffffffff t3 0000000000000001
[   10.536693] t4 fffffffffffffffe t5 0000000000000332 t6
0000000000000005 t7 00000000000011bd
[   10.544993] t8 0000000000000000 u0 9000000000232db0 s9
900000000226a4a8 s0 9000000100e7ea30
[   10.553293] s1 ffff80003243d800 s2 90000001012af0b8 s3
900000010fb77cc8 s4 9000000002269fb8
[   10.561592] s5 0000000000000005 s6 9000000002429000 s7
90000001012af0b8 s8 900000010fb77d08
[   10.569890]    ra: 900000000104e3f8 ahci_save_initial_config+0x3d8/0x448
[   10.576551]   ERA: 900000000104e3f8 ahci_save_initial_config+0x3d8/0x448
[   10.583212]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
[   10.589359]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[   10.593687]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[   10.598447]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
[   10.603207] ESTAT: 000c0000 [BRK] (IS=3D ECode=3D12 EsubCode=3D0)
[   10.608744]  PRID: 0014d010 (Loongson-64bit, Loongson-3C6000/S)
[   10.614625] CPU: 0 UID: 0 PID: 253 Comm: kworker/0:2 Not tainted
6.19.0-rc1+ #1 PREEMPT(full)
[   10.614628] Hardware name: To be filled by O.E.M.To be fill To be
filled by O.E.M.To be fill/To be filled by O.E.M.To be fill, BIOS
Loongson-UDK2018-V4.0.
[   10.614630] Workqueue: events work_for_cpu_fn
[   10.614633] Stack : 900000010fb77858 0000000000000000
900000000024371c 900000010fb74000
[   10.614637]         900000010fb77830 900000010fb77838
0000000000000000 900000010fb77978
[   10.614639]         900000010fb77970 900000010fb77970
900000010fb77650 0000000000000001
[   10.614642]         0000000000000001 900000010fb77838
09c296afbf53694b 9000000100414300
[   10.614645]         80000000ffffe349 fffffffffffffffe
000000000000034b 000000000000002f
[   10.614648]         0000000000000063 0000000000000001
000000000672c000 900000000226a4a8
[   10.614651]         0000000000000000 0000000000000000
90000000020fd980 9000000002429000
[   10.614654]         00000000000001cb 0000000000000009
0000000000000002 90000001012af0b8
[   10.614657]         900000010fb77d08 0000000000000000
9000000000243734 0000000000000000
[   10.614659]         00000000000000b0 0000000000000004
0000000000000000 0000000000071c1d
[   10.614662]         ...
[   10.614664] Call Trace:
[   10.614665] [<9000000000243734>] show_stack+0x5c/0x180
[   10.614669] [<900000000023f3c4>] dump_stack_lvl+0x6c/0x9c
[   10.614674] [<9000000000267168>] __warn+0x90/0x128
[   10.614679] [<90000000017e983c>] __report_bug+0x84/0x198
[   10.614683] [<90000000017e9a4c>] report_bug+0x3c/0xc0
[   10.614686] [<9000000001823910>] do_bp+0x2d0/0x340
[   10.614690] [<9000000000241e00>] handle_bp+0x120/0x1c0
[   10.614692] [<900000000104e3f8>] ahci_save_initial_config+0x3d8/0x448
[   10.614695] [<900000000104b374>] ahci_init_one+0x354/0x1068
[   10.614699] [<9000000000d2343c>] local_pci_probe+0x44/0xb8
[   10.614703] [<9000000000286bf8>] work_for_cpu_fn+0x18/0x30
[   10.614706] [<900000000028a4e0>] process_one_work+0x160/0x330
[   10.614709] [<900000000028aee8>] worker_thread+0x338/0x468
[   10.614712] [<9000000000295ef4>] kthread+0x11c/0x138
[   10.614716] [<9000000001823a58>] ret_from_kernel_thread+0x28/0xd0
[   10.614717] [<90000000002414e4>] ret_from_kernel_thread_asm+0xc/0x88
[   10.614720]
[   10.614720] ---[ end trace 0000000000000000 ]---
[   10.818394] ahci 0000:00:08.0: forcing PORTS_IMPL to 0x1
[   10.902172] ahci 0000:00:08.0: ahci_enable_ahci() hung
[   10.907282] ------------[ cut here ]------------
[   10.911866] WARNING: drivers/ata/libahci.c:994 at
ahci_reset_controller+0x88/0x1d8, CPU#0: kworker/0:2/253
[   10.921466] Modules linked in:
[   10.924496] CPU: 0 UID: 0 PID: 253 Comm: kworker/0:2 Tainted: G
   W           6.19.0-rc1+ #1 PREEMPT(full)
[   10.934611] Tainted: [W]=3DWARN
[   10.937551] Hardware name: To be filled by O.E.M.To be fill To be
filled by O.E.M.To be fill/To be filled by O.E.M.To be fill, BIOS
Loongson-UDK2018-V4.0.
[   10.951294] Workqueue: events work_for_cpu_fn
[   10.955622] pc 900000000104e4f0 ra 900000000104e4f0 tp
900000010fb74000 sp 900000010fb77c10
[   10.963922] a0 000000000000002a a1 90000000027223c0 a2
900000010fb77958 a3 90000000027223c8
[   10.972221] a4 90000000027223c0 a5 900000010fb77950 a6
0000000000000001 a7 0000000000000001
[   10.980519] t0 09c296afbf53694b t1 09c296afbf53694b t2
ffffffffffffffff t3 0000000000000001
[   10.988818] t4 fffffffffffffffe t5 000000000000036b t6
0000000000000005 t7 000000000000233d
[   10.997117] t8 0000000000000000 u0 9000000000232db0 s9
90000001001f0000 s0 900000010000dc80
[   11.005416] s1 ffff80003243d800 s2 9000000100e7ea30 s3
9000000100e7ea30 s4 9000000002269fb8
[   11.013715] s5 90000001012af0b8 s6 9000000002429000 s7
90000001012af0b8 s8 0000000000000001
[   11.022014]    ra: 900000000104e4f0 ahci_reset_controller+0x88/0x1d8
[   11.028328]   ERA: 900000000104e4f0 ahci_reset_controller+0x88/0x1d8
[   11.034641]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
[   11.040787]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[   11.045116]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[   11.049877]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
[   11.054636] ESTAT: 000c0000 [BRK] (IS=3D ECode=3D12 EsubCode=3D0)
[   11.060173]  PRID: 0014d010 (Loongson-64bit, Loongson-3C6000/S)
[   11.066053] CPU: 0 UID: 0 PID: 253 Comm: kworker/0:2 Tainted: G
   W           6.19.0-rc1+ #1 PREEMPT(full)
[   11.066055] Tainted: [W]=3DWARN
[   11.066056] Hardware name: To be filled by O.E.M.To be fill To be
filled by O.E.M.To be fill/To be filled by O.E.M.To be fill, BIOS
Loongson-UDK2018-V4.0.
[   11.066057] Workqueue: events work_for_cpu_fn
[   11.066060] Stack : 900000010fb77848 0000000000000000
900000000024371c 900000010fb74000
[   11.066063]         900000010fb77820 900000010fb77828
0000000000000000 900000010fb77968
[   11.066066]         900000010fb77960 900000010fb77960
900000010fb77640 0000000000000001
[   11.066068]         0000000000000001 900000010fb77828
09c296afbf53694b 9000000100414300
[   11.066071]         80000000ffffe384 fffffffffffffffe
0000000000000386 000000000000002f
[   11.066074]         0000000000000063 0000000000000001
000000000672c000 90000001001f0000
[   11.066077]         0000000000000000 0000000000000000
90000000020fd980 9000000002429000
[   11.066079]         00000000000003e2 0000000000000009
0000000000000002 90000001012af0b8
[   11.066082]         0000000000000001 0000000000000000
9000000000243734 0000000000000000
[   11.066085]         00000000000000b0 0000000000000004
0000000000000000 0000000000071c1d
[   11.066088]         ...
[   11.066089] Call Trace:
[   11.066089] [<9000000000243734>] show_stack+0x5c/0x180
[   11.066091] [<900000000023f3c4>] dump_stack_lvl+0x6c/0x9c
[   11.066095] [<9000000000267168>] __warn+0x90/0x128
[   11.066098] [<90000000017e983c>] __report_bug+0x84/0x198
[   11.066102] [<90000000017e9a4c>] report_bug+0x3c/0xc0
[   11.066105] [<9000000001823910>] do_bp+0x2d0/0x340
[   11.066106] [<9000000000241e00>] handle_bp+0x120/0x1c0
[   11.066108] [<900000000104e4f0>] ahci_reset_controller+0x88/0x1d8
[   11.066111] [<900000000104a58c>] ahci_pci_reset_controller+0x2c/0xd8
[   11.066114] [<900000000104bc10>] ahci_init_one+0xbf0/0x1068
[   11.066116] [<9000000000d2343c>] local_pci_probe+0x44/0xb8
[   11.066119] [<9000000000286bf8>] work_for_cpu_fn+0x18/0x30
[   11.066122] [<900000000028a4e0>] process_one_work+0x160/0x330
[   11.066125] [<900000000028aee8>] worker_thread+0x338/0x468
[   11.066128] [<9000000000295ef4>] kthread+0x11c/0x138
[   11.066131] [<9000000001823a58>] ret_from_kernel_thread+0x28/0xd0
[   11.066132] [<90000000002414e4>] ret_from_kernel_thread_asm+0xc/0x88
[   11.066134]
[   11.066135] ---[ end trace 0000000000000000 ]---
[   11.358172] ahci 0000:00:08.0: ahci_enable_ahci() hung
[   11.363283] ------------[ cut here ]------------
[   11.367867] WARNING: drivers/ata/libahci.c:1028 at
ahci_reset_controller+0x1cc/0x1d8, CPU#0: kworker/0:2/253
[   11.377638] Modules linked in:
[   11.380668] CPU: 0 UID: 0 PID: 253 Comm: kworker/0:2 Tainted: G
   W           6.19.0-rc1+ #1 PREEMPT(full)
[   11.390783] Tainted: [W]=3DWARN
[   11.393723] Hardware name: To be filled by O.E.M.To be fill To be
filled by O.E.M.To be fill/To be filled by O.E.M.To be fill, BIOS
Loongson-UDK2018-V4.0.
[   11.407466] Workqueue: events work_for_cpu_fn
[   11.411792] pc 900000000104e634 ra 900000000104e634 tp
900000010fb74000 sp 900000010fb77c10
[   11.420092] a0 000000000000002a a1 90000000027223c0 a2
900000010fb77958 a3 90000000027223c8
[   11.428391] a4 90000000027223c0 a5 900000010fb77950 a6
0000000000000001 a7 0000000000000001
[   11.436691] t0 09c296afbf53694b t1 09c296afbf53694b t2
ffffffffffffffff t3 0000000000000001
[   11.444990] t4 fffffffffffffffe t5 00000000000003a6 t6
0000000000000005 t7 0000000000000dfd
[   11.453288] t8 0000000000000000 u0 9000000000232db0 s9
90000001001f0000 s0 900000010000dc80
[   11.461587] s1 ffff80003243d800 s2 9000000100e7ea30 s3
9000000100e7ea30 s4 9000000002269fb8
[   11.469885] s5 90000001012af0b8 s6 9000000002429000 s7
90000001012af0b8 s8 0000000000000001
[   11.478185]    ra: 900000000104e634 ahci_reset_controller+0x1cc/0x1d8
[   11.484586]   ERA: 900000000104e634 ahci_reset_controller+0x1cc/0x1d8
[   11.490987]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
[   11.497131]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[   11.501458]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[   11.506218]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
[   11.510977] ESTAT: 000c0000 [BRK] (IS=3D ECode=3D12 EsubCode=3D0)
[   11.516512]  PRID: 0014d010 (Loongson-64bit, Loongson-3C6000/S)
[   11.522393] CPU: 0 UID: 0 PID: 253 Comm: kworker/0:2 Tainted: G
   W           6.19.0-rc1+ #1 PREEMPT(full)
[   11.522395] Tainted: [W]=3DWARN
[   11.522396] Hardware name: To be filled by O.E.M.To be fill To be
filled by O.E.M.To be fill/To be filled by O.E.M.To be fill, BIOS
Loongson-UDK2018-V4.0.
[   11.522397] Workqueue: events work_for_cpu_fn
[   11.522400] Stack : 900000010fb77848 0000000000000000
900000000024371c 900000010fb74000
[   11.522403]         900000010fb77820 900000010fb77828
0000000000000000 900000010fb77968
[   11.522406]         900000010fb77960 900000010fb77960
900000010fb77640 0000000000000001
[   11.522409]         0000000000000001 900000010fb77828
09c296afbf53694b 9000000100414300
[   11.522412]         80000000ffffe3bf fffffffffffffffe
00000000000003c1 000000000000002f
[   11.522415]         0000000000000063 0000000000000001
000000000672c000 90000001001f0000
[   11.522418]         0000000000000000 0000000000000000
90000000020fd980 9000000002429000
[   11.522420]         0000000000000404 0000000000000009
0000000000000002 90000001012af0b8
[   11.522423]         0000000000000001 0000000000000000
9000000000243734 0000000000000000
[   11.522426]         00000000000000b0 0000000000000004
0000000000000000 0000000000071c1d
[   11.522428]         ...
[   11.522430] Call Trace:
[   11.522430] [<9000000000243734>] show_stack+0x5c/0x180
[   11.522432] [<900000000023f3c4>] dump_stack_lvl+0x6c/0x9c
[   11.522436] [<9000000000267168>] __warn+0x90/0x128
[   11.522439] [<90000000017e983c>] __report_bug+0x84/0x198
[   11.522442] [<90000000017e9a4c>] report_bug+0x3c/0xc0
[   11.522445] [<9000000001823910>] do_bp+0x2d0/0x340
[   11.522447] [<9000000000241e00>] handle_bp+0x120/0x1c0
[   11.522448] [<900000000104e634>] ahci_reset_controller+0x1cc/0x1d8
[   11.522451] [<900000000104a58c>] ahci_pci_reset_controller+0x2c/0xd8
[   11.522454] [<900000000104bc10>] ahci_init_one+0xbf0/0x1068
[   11.522456] [<9000000000d2343c>] local_pci_probe+0x44/0xb8
[   11.522459] [<9000000000286bf8>] work_for_cpu_fn+0x18/0x30
[   11.522462] [<900000000028a4e0>] process_one_work+0x160/0x330
[   11.522465] [<900000000028aee8>] worker_thread+0x338/0x468
[   11.522467] [<9000000000295ef4>] kthread+0x11c/0x138
[   11.522470] [<9000000001823a58>] ret_from_kernel_thread+0x28/0xd0
[   11.522471] [<90000000002414e4>] ret_from_kernel_thread_asm+0xc/0x88
[   11.522473]
[   11.522474] ---[ end trace 0000000000000000 ]---
[   11.736718] ahci 0000:00:08.0: AHCI vers 0000.0000, 1 command
slots, ? Gbps, unknown mode
[   11.744847] ahci 0000:00:08.0: 1/1 ports implemented (port mask 0x1)
[   11.751159] ahci 0000:00:08.0: flags:
[   11.755115] scsi host0: ahci
[   11.758048] ata1: SATA max UDMA/133 abar m1024@0xe0030401800 port
0xe0030401900 irq 44 lpm-pol 1
[   11.767294] e1000: Intel(R) PRO/1000 Network Driver
[   11.772145] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   11.777870] e1000e: Intel(R) PRO/1000 Network Driver
[   11.782800] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.

Huacai

>
> This is because with the AHCI controller having a devfn 08.0 devfn and
> likely dev->multifunction not set this patch would make a difference in
> that it would try to enumerate 08.1 and so on while without this  patch
> these would be skipped because of the dev && !dev->multifunction
> condition even though isolated function probing should look at all
> functions. And I was thinking maybe this causes us to end up trying to
> probe an AHCI controller where there is none.
>
> Another thing I could imagine, especially with commit 2410e3301fcc
> ("PCI: loongson: Don't access non-existent devices") in mind is that
> accessing the device/vendor config space for some non existent devices
> leaves your PCIe controller in some bad state and then the MMIOs for
> the AHCI enable go lost or something. Maybe you could add debug code in
> the relevant parts of drivers/pci/controller/pci-loongson.c to check
> which devices get accessed with this patch vs without it? Would it help
> if I provided a debug patch for that? Though I really don't know what
> part is relevant for the system you're seeing the problem with.
>
> Thanks,
> Niklas

