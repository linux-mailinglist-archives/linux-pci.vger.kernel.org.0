Return-Path: <linux-pci+bounces-4818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A0E87BBED
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 12:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FD31F2388C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F273C6EB5D;
	Thu, 14 Mar 2024 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxLSzVHd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907D36EB51;
	Thu, 14 Mar 2024 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415671; cv=none; b=V/jhkRQ3Sg7TN1uIrMrrnv737snZ5wG5idxNr5vEcxLhd/e6IFAR9Mwk1tALlJJoa0qPCIMUnSBPY/9654Xacwf/92EpiwQyk7gANnTmBMwAwoJMDh7J/r931UMB5eaHQE3I2MeCZffSDWVDazMwTL4UHBwD7yorb/CdLqk8XXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415671; c=relaxed/simple;
	bh=RSBfRzcIF8/q+WdQyiGl9PK9UXleYIlOt3mM4ulKvkE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z26JhOoMmPKqSanM1j6GkOFdz1Pmipp0y2XWpbrMtF0POiN8SynruY2u0UJy8tI6l5gKgLBRDn5cNLe80e6BhRprb6vnpA5EZ2TK1l0T1LL+Bp7Y7IOLDvQDnUArgMfKANkPSezlJqkRh4d42dBdkWL/leib1V9BSPInhtotRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxLSzVHd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710415667; x=1741951667;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RSBfRzcIF8/q+WdQyiGl9PK9UXleYIlOt3mM4ulKvkE=;
  b=cxLSzVHdWu9oto4UEgMP7uQZClqGyYlbgiFSLWhU3ylDvk2bV6oSI45F
   2XJvBD2/50cXWeX4jYPIXkKJ/u1DTSTgfBOMLPTiweV5nLVB8u6S4C3/Q
   8ivir/QW4eSuOPzH3gNtQRJW6CxaTx5jpPwL4lUAmdVttKq+wkNP1m/rK
   5lHl+OfdybjVaoJI9u6oTH4u9esCpf9yPl1D/EOKxdsCc4zEWQaM2yf30
   +OLWjSqs9N+F65rn3bXhULk6b9NxhpT0ZZBTu/izfKXCaKNFCye+nU1SM
   YM3+eP2bFNu4VDnnS01diWpoZ+OPqXIOncDQvhIWnR6rzqFEta3gV3D6Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="30666376"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="30666376"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 04:27:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="16921191"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.8])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 04:27:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 14 Mar 2024 13:27:36 +0200 (EET)
To: Pengfei Xu <pengfei.xu@intel.com>
cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: Correct error reporting with PCIe failed link
 retraining
In-Reply-To: <ZfKk+dYXkiRRkk+p@xpf.sh.intel.com>
Message-ID: <d223a58a-8a4b-b745-c8c9-2e19d4742cdb@linux.intel.com>
References: <alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk> <alpine.DEB.2.21.2402100045590.2376@angie.orcam.me.uk> <ZfKk+dYXkiRRkk+p@xpf.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1973735611-1710415656=:1017"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1973735611-1710415656=:1017
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 14 Mar 2024, Pengfei Xu wrote:

> Hi Maciej W. Rozycki,
>=20
> Greeting!
>=20
> We tested intel internal Linux next kernel by syzkaller fuzz testing and =
met
> "CPU soft lockup in __run_timers" problem in guest.
>=20
> Bisect and find that the following patch is the first bad commit.

Hi,

I'm skeptical of this bisect result (perhaps some of the kernels marked=20
good are actually bad because the problem does not always trigger?).

Did you check what is the result if you put that patch on top of 6.8?

--=20
 i.

> Check the commit content is same as following patch.
>
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/2=
40313_174939___run_timers
> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blo=
b/main/240313_174939___run_timers/repro.c
> Syzkaller reproduced steps: https://github.com/xupengfe/syzkaller_logs/bl=
ob/main/240313_174939___run_timers/repro.prog
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240313_=
174939___run_timers/bisect_info.log
> Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240313_=
174939___run_timers/0a53950322bc80aeebf56f5a9d38c847186a082a_dmesg.log
> bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240313_17493=
9___run_timers/bzImage_v6.8_problem.tar.gz
>=20
> "
> [   34.599994] hrtimer: interrupt took 63789 ns
> [  102.443957] clocksource: Long readout interval, skipping watchdog chec=
k: cs_nsec: 3343956725 wd_nsec: 3343956627
> [  393.043326] watchdog: BUG: soft lockup - CPU#1 stuck for 27s! [repro:2=
653]
> [  393.043704] Modules linked in:
> [  393.043856] irq event stamp: 17486443
> [  393.044019] hardirqs last  enabled at (17486442): [<ffffffff855b0ebe>]=
 irqentry_exit+0x3e/0xa0
> [  393.044462] hardirqs last disabled at (17486443): [<ffffffff855aed94>]=
 sysvec_apic_timer_interrupt+0x14/0xc0
> [  393.044925] softirqs last  enabled at (14336234): [<ffffffff8126c828>]=
 __irq_exit_rcu+0xa8/0x110
> [  393.045332] softirqs last disabled at (14336237): [<ffffffff8126c828>]=
 __irq_exit_rcu+0xa8/0x110
> [  393.045740] CPU: 1 PID: 2653 Comm: repro Not tainted 6.8.0-0a53950322b=
c+ #1
> [  393.046062] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [  393.046618] RIP: 0010:preempt_count_sub+0x6c/0x160
> [  393.046856] Code: ed 07 85 c9 75 1b 65 8b 05 d9 7b d2 7e 89 c2 81 e2 f=
f ff ff 7f 39 da 7c 1b 81 fb fe 00 00 00 76 6b f7 db 65 01 1d bc 7b d2 7e <=
48> 8b 5d f8 c9 c3 cc cc cc cc e8 d5 36 9d 01 85 c0 74 ed 48 c7 c0
> [  393.047696] RSP: 0018:ffff88806cd09da0 EFLAGS: 00000213
> [  393.047950] RAX: 0000000000000102 RBX: 00000000ffffffff RCX: 000000000=
0000000
> [  393.048281] RDX: 0000000000000102 RSI: 0000000000000102 RDI: 000000000=
0000001
> [  393.048611] RBP: ffff88806cd09da8 R08: 0000000000000001 R09: fffffbfff=
11caa46
> [  393.048943] R10: ffffffff88e55237 R11: 0000000000000001 R12: ffff88806=
cd32a00
> [  393.049277] R13: ffffffff81516e90 R14: dffffc0000000000 R15: ffff88806=
cd32a00
> [  393.049611] FS:  0000000000000000(0000) GS:ffff88806cd00000(0000) knlG=
S:0000000000000000
> [  393.049987] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  393.050261] CR2: 00007febf5bfa838 CR3: 000000000bda4006 CR4: 000000000=
0770ef0
> [  393.050596] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  393.050928] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 000000000=
0000400
> [  393.051262] PKRU: 55555554
> [  393.051396] Call Trace:
> [  393.051521]  <IRQ>
> [  393.051630]  ? show_regs+0xa9/0xc0
> [  393.051805]  ? watchdog_timer_fn+0x531/0x6b0
> [  393.052019]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [  393.052255]  ? __hrtimer_run_queues+0x1a4/0xc00
> [  393.052505]  ? __pfx___hrtimer_run_queues+0x10/0x10
> [  393.052770]  ? hrtimer_interrupt+0x324/0x7a0
> [  393.052994]  ? __sysvec_apic_timer_interrupt+0x105/0x3c0
> [  393.053254]  ? sysvec_apic_timer_interrupt+0x4b/0xc0
> [  393.053495]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
> [  393.053757]  ? __pfx_clocksource_watchdog+0x10/0x10
> [  393.054002]  ? preempt_count_sub+0x6c/0x160
> [  393.054213]  _raw_spin_unlock_irq+0x3c/0x60
> [  393.054423]  __run_timers.part.0+0x6c9/0xa40
> [  393.054647]  ? __pfx___run_timers.part.0+0x10/0x10
> [  393.054883]  ? sysvec_irq_work+0x8b/0x100
> [  393.055087]  ? asm_sysvec_irq_work+0x1f/0x30
> [  393.055314]  run_timer_softirq+0xbc/0x1c0
> [  393.055517]  __do_softirq+0x1cb/0x84a
> [  393.055709]  __irq_exit_rcu+0xa8/0x110
> [  393.055899]  irq_exit_rcu+0x12/0x30
> [  393.056078]  sysvec_apic_timer_interrupt+0xa5/0xc0
> [  393.056314]  </IRQ>
> [  393.056422]  <TASK>
> [  393.056532]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
> [  393.056781] RIP: 0010:__schedule+0xbe/0x30c0
> [  393.056993] Code: c0 e8 e6 a8 fd ff 48 98 48 8d 3c c5 a0 dc 75 86 48 8=
9 fa 48 c1 ea 03 42 80 3c 2a 00 0f 85 81 28 00 00 4c 03 24 c5 a0 dc 75 86 <=
49> 8d 84 24 58 0a 00 00 48 89 c2 48 89 85 e0 fe ff ff 48 b8 00 00
> [  393.057847] RSP: 0018:ffff888024f3f6e8 EFLAGS: 00000282
> [  393.058101] RAX: 0000000000000001 RBX: 0000000000046380 RCX: 000000000=
0000001
> [  393.058437] RDX: 1ffffffff0cebb95 RSI: 0000000000000001 RDI: ffffffff8=
675dca8
> [  393.058771] RBP: ffff888024f3f820 R08: 0000000000000001 R09: 000000000=
0000002
> [  393.059107] R10: 0000000000406000 R11: 0000000000000001 R12: ffff88806=
cd46380
> [  393.059442] R13: dffffc0000000000 R14: ffffffff855da674 R15: 000000000=
0406000
> [  393.059779]  ? __cond_resched+0x24/0x30
> [  393.059982]  ? __schedule+0x9a/0x30c0
> [  393.060173]  ? lockdep_hardirqs_on+0x8a/0x110
> [  393.060408]  ? trace_hardirqs_on+0x26/0x120
> [  393.060637]  ? __pfx___schedule+0x10/0x10
> [  393.060836]  ? __this_cpu_preempt_check+0x21/0x30
> [  393.061068]  ? lock_release+0x417/0x7e0
> [  393.061267]  ? __this_cpu_preempt_check+0x21/0x30
> [  393.061497]  ? lock_is_held_type+0xf0/0x150
> [  393.061705]  ? __cond_resched+0x24/0x30
> [  393.061895]  preempt_schedule_common+0x4a/0xd0
> [  393.062118]  __cond_resched+0x24/0x30
> [  393.062302]  unmap_page_range+0xab4/0x3690
> [  393.062530]  ? __pfx_unmap_page_range+0x10/0x10
> [  393.062752]  ? __this_cpu_preempt_check+0x21/0x30
> [  393.062989]  ? uprobe_munmap+0xb0/0x590
> [  393.063186]  unmap_single_vma+0x1ac/0x2d0
> [  393.063390]  unmap_vmas+0x210/0x470
> [  393.063572]  ? __pfx_unmap_vmas+0x10/0x10
> [  393.063769]  ? __pfx_lock_release+0x10/0x10
> [  393.063977]  ? lock_release+0x417/0x7e0
> [  393.064167]  ? __pfx_folio_batch_move_lru+0x10/0x10
> [  393.064410]  ? __pfx_lock_release+0x10/0x10
> [  393.064624]  ? mlock_drain_local+0x281/0x4b0
> [  393.064844]  exit_mmap+0x19b/0xac0
> [  393.065018]  ? mark_lock.part.0+0xf3/0x17a0
> [  393.065233]  ? __pfx_exit_mmap+0x10/0x10
> [  393.065427]  ? __kasan_check_write+0x18/0x20
> [  393.065644]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
> [  393.065909]  ? mutex_unlock+0x16/0x20
> [  393.066096]  __mmput+0xde/0x3e0
> [  393.066256]  mmput+0x74/0x90
> [  393.066407]  do_exit+0xa59/0x28c0
> [  393.066580]  ? lock_release+0x417/0x7e0
> [  393.066778]  ? __pfx_lock_release+0x10/0x10
> [  393.066989]  ? __pfx_do_exit+0x10/0x10
> [  393.067179]  ? __this_cpu_preempt_check+0x21/0x30
> [  393.067410]  ? _raw_spin_unlock_irq+0x2c/0x60
> [  393.067630]  ? lockdep_hardirqs_on+0x8a/0x110
> [  393.067845]  ? _raw_spin_unlock_irq+0x2c/0x60
> [  393.068064]  ? trace_hardirqs_on+0x26/0x120
> [  393.068287]  do_group_exit+0xe5/0x2c0
> [  393.068489]  __x64_sys_exit_group+0x4d/0x60
> [  393.068707]  do_syscall_64+0x73/0x150
> [  393.068894]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [  393.069140] RIP: 0033:0x7febf5b18a4d
> [  393.069319] Code: Unable to access opcode bytes at 0x7febf5b18a23.
> "
>=20
> ---
>=20
> If you don't need the following environment to reproduce the problem or i=
f you
> already have one reproduced environment, please ignore the following info=
rmation.
>=20
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v=
7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65=
 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=3Dpflash,format=3Draw,reado=
nly=3Don,file=3D./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>=20
> After login vm(virtual machine) successfully, you could transfer reproduc=
ed
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>=20
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc =
has
>=20
> Fill the bzImage file into above start3.sh to load the target kernel in v=
m.
>=20
>=20
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc --e=
nable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
> ---
>=20
> Best Regards,
> Thanks!
>=20
> On 2024-02-10 at 01:43:50 +0000, Maciej W. Rozycki wrote:
> > Only return successful completion status from `pcie_failed_link_retrain=
'=20
> > if retraining has actually been done, preventing excessive delays from=
=20
> > being triggered at call sites in a hope that communication will finally=
=20
> > be established with the downstream device where in fact nothing has bee=
n=20
> > done about the link in question that would justify such a hope.
> >=20
> > Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> > Reported-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > Link: https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@li=
nux.intel.com/
> > Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> > Cc: stable@vger.kernel.org # v6.5+
> > ---
> >  drivers/pci/quirks.c |   18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >=20
> > linux-pcie-failed-link-retrain-status-fix.diff
> > Index: linux-macro/drivers/pci/quirks.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-macro.orig/drivers/pci/quirks.c
> > +++ linux-macro/drivers/pci/quirks.c
> > @@ -74,7 +74,8 @@
> >   * firmware may have already arranged and lift it with ports that alre=
ady
> >   * report their data link being up.
> >   *
> > - * Return TRUE if the link has been successfully retrained, otherwise =
FALSE.
> > + * Return TRUE if the link has been successfully retrained, otherwise =
FALSE,
> > + * also when retraining was not needed in the first place.
> >   */
> >  bool pcie_failed_link_retrain(struct pci_dev *dev)
> >  {
> > @@ -83,10 +84,11 @@ bool pcie_failed_link_retrain(struct pci
> >  =09=09{}
> >  =09};
> >  =09u16 lnksta, lnkctl2;
> > +=09bool ret =3D false;
> > =20
> >  =09if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
> >  =09    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
> > -=09=09return false;
> > +=09=09return ret;
> > =20
> >  =09pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
> >  =09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> > @@ -98,9 +100,10 @@ bool pcie_failed_link_retrain(struct pci
> >  =09=09lnkctl2 |=3D PCI_EXP_LNKCTL2_TLS_2_5GT;
> >  =09=09pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
> > =20
> > -=09=09if (pcie_retrain_link(dev, false)) {
> > +=09=09ret =3D pcie_retrain_link(dev, false) =3D=3D 0;
> > +=09=09if (!ret) {
> >  =09=09=09pci_info(dev, "retraining failed\n");
> > -=09=09=09return false;
> > +=09=09=09return ret;
> >  =09=09}
> > =20
> >  =09=09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> > @@ -117,13 +120,14 @@ bool pcie_failed_link_retrain(struct pci
> >  =09=09lnkctl2 |=3D lnkcap & PCI_EXP_LNKCAP_SLS;
> >  =09=09pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
> > =20
> > -=09=09if (pcie_retrain_link(dev, false)) {
> > +=09=09ret =3D pcie_retrain_link(dev, false) =3D=3D 0;
> > +=09=09if (!ret) {
> >  =09=09=09pci_info(dev, "retraining failed\n");
> > -=09=09=09return false;
> > +=09=09=09return ret;
> >  =09=09}
> >  =09}
> > =20
> > -=09return true;
> > +=09return ret;
> >  }
> > =20
> >  static ktime_t fixup_debug_start(struct pci_dev *dev,


--8323328-1973735611-1710415656=:1017--

