Return-Path: <linux-pci+bounces-33622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69190B1E6E5
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 12:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E67527A6303
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E91256C73;
	Fri,  8 Aug 2025 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="q4RG3tTS"
X-Original-To: linux-pci@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57023535A;
	Fri,  8 Aug 2025 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754650774; cv=none; b=Igj3kkGyMIhFik/VGLxbCLTigSpNIKxI4g9vLLIh67+HXT1a0EuQoVae01lirkZkompBb5fbGMmk2acGWcihBYJu2GCywPb4YTuJXc+Z+JKg3Ns2ighDTNkbUxgrCWOmh0JMaz+NcIcqJQdLlBT4IrzyYbBUF0nEHms3cLRpAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754650774; c=relaxed/simple;
	bh=0Kz37+b2HmhQsaCCr11nF9LPPY0BleYfH+dO9HDEFlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCmJFD/gBR5OaF8jZlJhjjygT6DDo25zHOec0gobUKyFrgZykBW3ieNaj8Q43ey5hPCiw8HUQ/lQsVTNifw4G8577WVUQm5gxWlLb22kNsb/lylPxYfOZFzHvwiGzwD84MYb7/OmalbWquBM5Q8OSLZmlV/F4upd/g6xx6i3Si4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=q4RG3tTS; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754650763;
	bh=0Kz37+b2HmhQsaCCr11nF9LPPY0BleYfH+dO9HDEFlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=q4RG3tTSLaF8x1NxuBYCxz+426cAzi8275UkWCKuyywKptTlX2hj2MfDjJpMfQIJV
	 pnSaLqt7kLp9aVWgwzCdvRQq/6TnrInuRpCP3I1ewdd6bKf+jjPZ2MnkFOU6Ysue1M
	 728rXB8iyTTmnO7jnl+zM2rmbU9EwvBCht0qnUZaGylzwr/HcuuML3Z5iH+wABZlLt
	 E00F2yJKxsdm59nFqteAvbpbXwrGFwQwuPvTo3mi8amRZFs3v2hgbZhoIfKX9lsz4Z
	 RYNup+F8TkJ5BUHV2aYmD5XtblDg8sVGzxnGjFNiX+Xnb2W3D5yvZSLPj78VTTmAD3
	 IqJUVAMAaCNnA==
Received: from linux.gnuweeb.org (unknown [182.253.126.185])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 9D90D3127DA9;
	Fri,  8 Aug 2025 10:59:20 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Fri, 8 Aug 2025 17:59:17 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux PCI Mailing List <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>,
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
	gwml@vger.gnuweeb.org
Subject: Re: [GIT PULL v2] PCI changes for v6.17
Message-ID: <aJXYhfc/6DfcqfqF@linux.gnuweeb.org>
References: <20250801142254.GA3496192@bhelgaas>
 <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
 <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>
 <aJQi3RN6WX6ZiQ5i@wunner.de>
 <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>
 <20250807050350.FyWHwsig@linutronix.de>
 <aJQ19UvTviTNbNk4@linux.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJQ19UvTviTNbNk4@linux.gnuweeb.org>
X-Machine-Hash: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Thu, Aug 07, 2025 at 12:13:37PM +0700, Ammar Faizi wrote:
> On Thu, Aug 07, 2025 at 07:03:50AM +0200, Nam Cao wrote:
> > Does the diff below help?
> 
> Yes, it works.

So today, I synced with Linus' master branch again:

  37816488247d ("Merge tag 'net-6.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

and applied your fix on top of it.

I can boot, but I get this splat. Looking at the call trace, it seems
it's still related to pci, but different issue. The call trace is also
different from the previous one.

Let me know if you have something for me to test.

  [    1.017767] pci 10000:e0:1d.0: bridge window [mem 0x82000000-0x820fffff]: assigned
  [    1.018519] pci 10000:e0:1d.0: bridge window [io  size 0x1000]: can't assign; no space
  [    1.019268] pci 10000:e0:1d.0: bridge window [io  size 0x1000]: failed to assign
  [    1.020026] pci 10000:e0:1d.0: bridge window [io  size 0x1000]: can't assign; no space
  [    1.020789] pci 10000:e0:1d.0: bridge window [io  size 0x1000]: failed to assign
  [    1.021539] pci 10000:e1:00.0: BAR 0 [mem 0x82000000-0x82003fff 64bit]: assigned
  [    1.022317] pci 10000:e0:1d.0: PCI bridge to [bus e1]
  [    1.023091] pci 10000:e0:1d.0:   bridge window [mem 0x82000000-0x820fffff]
  [    1.023885] pci 10000:e1:00.0: VMD: Default LTR value set by driver
  [    1.024654] pci 10000:e1:00.0: can't override BIOS ASPM; OS doesn't have ASPM control
  [    1.025442] pcieport 10000:e0:1d.0: can't derive routing for PCI INT A
  [    1.026245] pcieport 10000:e0:1d.0: PCI INT A: no GSI
  [    1.027058] ------------[ cut here ]------------
  [    1.027849] WARNING: CPU: 0 PID: 166 at drivers/pci/controller/vmd.c:309 vmd_init_dev_msi_info+0x36/0x40 [vmd]
  [    1.028649] Modules linked in: hid_generic i2c_hid_acpi i2c_hid drm intel_lpss_pci i2c_i801 i2c_mux intel_lpss idma64 i2c_smbus vmd(+) hid video wmi pinctrl_tigerlake
  [    1.029467] CPU: 0 UID: 0 PID: 166 Comm: systemd-udevd Not tainted 6.16.0-afh-home-2025-08-08-g6026508bdb9d #10 PREEMPT(full)  fe08b908bb15b9ded6f7769c45f204194ebf7eef
  [    1.030301] Hardware name: HP HP Laptop 14s-dq2xxx/87FD, BIOS F.21 03/21/2022
  [    1.031122] RIP: 0010:vmd_init_dev_msi_info+0x36/0x40 [vmd]
  [    1.031953] Code: 48 89 cb e8 7c 49 4f e1 84 c0 74 1a 48 8b 53 20 48 c7 42 18 70 18 40 a0 48 8b 53 20 48 c7 42 20 e0 17 40 a0 5b c3 31 c0 5b c3 <0f> 0b 31 c0 c3 0f 1f 44 00 00 0f 1f 44 00 00 41 56 41 55 41 54 49
  [    1.032798] RSP: 0018:ffff888105a47860 EFLAGS: 00010297
  [    1.033642] RAX: ffff8881014d5d98 RBX: ffff8881014d5c00 RCX: ffff8881014d5d98
  [    1.034506] RDX: ffff888120a49400 RSI: ffff888120a49400 RDI: ffff88810132b0c8
  [    1.035359] RBP: 0000000000000001 R08: ffff888100d8de3a R09: 00000000ffffffff
  [    1.036206] R10: 0000000000000004 R11: 0000000000000005 R12: ffff8881019b7e40
  [    1.036561] usb 1-2: new full-speed USB device number 3 using xhci_hcd
  [    1.037058] R13: ffffffffa020c680 R14: ffff88810132b0c8 R15: ffff888120a49400
  [    1.038724] FS:  00007f25ede3a8c0(0000) GS:ffff8890f1a2d000(0000) knlGS:0000000000000000
  [    1.039559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [    1.040400] CR2: 00007f25ee475ea0 CR3: 000000011dfd1003 CR4: 0000000000770ef0
  [    1.041265] PKRU: 55555554
  [    1.042121] Call Trace:
  [    1.042971]  <TASK>
  [    1.043803]  msi_create_device_irq_domain+0x1eb/0x290
  [    1.044645]  __pci_enable_msi_range+0x106/0x300
  [    1.045488]  pci_alloc_irq_vectors_affinity+0xc5/0x110
  [    1.046336]  pcie_portdrv_probe+0x24e/0x610
  [    1.047177]  ? kernfs_activate+0x48/0x60
  [    1.048015]  local_pci_probe+0x3c/0x80
  [    1.048854]  pci_device_probe+0xbc/0x1b0
  [    1.049693]  really_probe+0xcd/0x380
  [    1.050529]  ? driver_probe_device+0x90/0x90
  [    1.051353]  __driver_probe_device+0x78/0x150
  [    1.052182]  driver_probe_device+0x1f/0x90
  [    1.053000]  __device_attach_driver+0x76/0xf0
  [    1.053812]  bus_for_each_drv+0x69/0xa0
  [    1.054633]  __device_attach+0xaa/0x1a0
  [    1.055448]  pci_bus_add_device+0x4c/0x70
  [    1.056260]  pci_bus_add_devices+0x2c/0x70
  [    1.057063]  vmd_probe+0x81e/0xa20 [vmd 65bddf00234a3cddd21388091a077f038c9af2be]
  [    1.057881]  local_pci_probe+0x3c/0x80
  [    1.058682]  pci_device_probe+0xbc/0x1b0
  [    1.059489]  really_probe+0xcd/0x380
  [    1.060303]  ? __device_attach_driver+0xf0/0xf0
  [    1.061112]  __driver_probe_device+0x78/0x150
  [    1.061908]  driver_probe_device+0x1f/0x90
  [    1.062711]  __driver_attach+0xbf/0x1b0
  [    1.063500]  bus_for_each_dev+0x64/0xa0
  [    1.064303]  bus_add_driver+0x10a/0x230
  [    1.065100]  driver_register+0x55/0xf0
  [    1.065892]  ? vmd_drv_exit+0x9a0/0x9a0 [vmd 65bddf00234a3cddd21388091a077f038c9af2be]
  [    1.066673]  do_one_initcall+0x31/0x1e0
  [    1.067460]  do_init_module+0x60/0x260
  [    1.068264]  init_module_from_file+0x74/0x90
  [    1.069068]  idempotent_init_module+0xed/0x2c0
  [    1.069853]  __x64_sys_finit_module+0x65/0xd0
  [    1.070630]  do_syscall_64+0x56/0x260
  [    1.071394]  entry_SYSCALL_64_after_hwframe+0x29/0x31
  [    1.072152] RIP: 0033:0x7f25ee53288d
  [    1.072918] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
  [    1.073698] RSP: 002b:00007fff09cbd5b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
  [    1.074477] RAX: ffffffffffffffda RBX: 000055d9edf36030 RCX: 00007f25ee53288d
  [    1.075254] RDX: 0000000000000000 RSI: 00007f25ee6cc441 RDI: 0000000000000005
  [    1.076042] RBP: 0000000000020000 R08: 0000000000000000 R09: 00007fff09cbd6f0
  [    1.076827] R10: 0000000000000005 R11: 0000000000000246 R12: 00007f25ee6cc441
  [    1.077609] R13: 000055d9edf323b0 R14: 000055d9edf36120 R15: 000055d9edf35850
  [    1.078389]  </TASK>
  [    1.079166] ---[ end trace 0000000000000000 ]---

-- 
Ammar Faizi


