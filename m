Return-Path: <linux-pci+bounces-4609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066DA875564
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 18:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AAC1F24865
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F070B12FF6C;
	Thu,  7 Mar 2024 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV6YbjXG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB7612FF6B;
	Thu,  7 Mar 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833345; cv=none; b=H0mr2ZFlBCcpJkGZtkygwiIKYxNYbWzK2FM1lZ77CfiYaSabXU6bxnD14Qc5cToxAUQHwZaZbOUn09DG6M3JBcIf7PEpG2SBy6ySXfbeb2WLTB+svDwnj9SiDl80zYwf8qZ6Ad/up0h2unSGLLRFD8qBEdniZh7/T151b3pBbAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833345; c=relaxed/simple;
	bh=Bvba2DtZz+jf7Ja4Z76FOUCxSbokk36ji0l3Y1c0nrI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LpxHrwJ36GVSGZWcH/rLkpkpFa/otvvnWb5pn7WbpfnlReIdjTEUIMr9ODouSYZhhMN4jHGrm9pJj9Yx7tbgMWbQGfvTC+XpFzXsmGuIqCLol1UHhoXag16itWm9PCBlTiZdVRkiPRnzhpivqZrSy684kQRQXkUYUy2fEr6K6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV6YbjXG; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so848190a12.1;
        Thu, 07 Mar 2024 09:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709833344; x=1710438144; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GNPv2vcny770JugCU5vEv7PYXpIlGF138/B6fZ0069A=;
        b=QV6YbjXGomqjNOhv0EMOy27ZXJ9UhtCU6r7Q41Cc55D1I0ltoQklmUJ0M9PoNOfvsK
         PeOhXJRkITbhPqEDzwlp7FrXyuBURPuxXhxKbAkWGcc4VirSSXHnbuGrt9IfwptY7YJq
         qmjrUa49Or8AlblnGfMnfyavYHIDJZTNYQ7yDkWr5rvHAuxuLghJOTzh/pWhAxveMi9R
         pU1ipdUI7pX1Ygw7WVbke7+v7+ArBm0tb53jGzqBK3tmtHr+YNXpcqiWPqGgAXTdU4Yt
         XeknqIgtgWKbiNdtVAnhcixhvKnbaH09LetMi5ceMhvyWuJF+TpL71TLl6YabcSQ9O85
         qVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833344; x=1710438144;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNPv2vcny770JugCU5vEv7PYXpIlGF138/B6fZ0069A=;
        b=uicmOP7zmiDkCWIjs4g14WQ6diCAjO80yCxqJf8QhO0r+OHzkNSyHcpa1T06hN8B5I
         yz289uSVXCahWb6216WXjiGelO5hmONJ1uUqbCCQR8F3FAtdUlMGGU0mZzVPCBQORW+3
         mkx4b2cT919yZmClSeKFyyDYEUKkU2EvG4lsWW9Ltuq6RDPz0dTPHTE7gpSy2NUotGOl
         hzgcwKMbJUNvx/NDJmMOvN84Svu7mUyEJ2dG6Y7/UnzydoR4hXLqG2MFgQFpZPLeMTS4
         YEXb5ntd5uQQ/7UP9xHgL0bXSGo5aHLU7XbVjlJAjnOpX6dBjcVTjI9krlo8AWXSikfe
         QEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUACkY6lEnJsKvolcuSAITvH+0aIXfcZ0RiinIRm2DF4+6aey32xdBo+yZ171cYhjT+ued19vM7iPCOtgRg+CsgCDYA4y0lhv9sW26dU/Vy2BKLcMPrTF2aXBg5MTFS
X-Gm-Message-State: AOJu0Yy6nOvILjmPC+RxT8D2Fvx6GxI+WwLgNoF13E5rCRkGnbN4C3Gn
	XBN2df/7rkmipvEROx51BeRkVktoVyHlEN5V4jM3ZjRqtV3RjyWAfcU7G7GFciT7SZcW8N5zpDJ
	Lrog0WDCeuy7pTJKgrVrHlKdLNOVle11jAPKWOCmU
X-Google-Smtp-Source: AGHT+IHNfRuXjverMdTwkkrAgRMRadVy4zksg6l+DjOqSczT1b1ZK9UlbLpR4hkPIznRqnBltkEc6DRl9eMeHfy/6XE=
X-Received: by 2002:a05:6a20:47d8:b0:1a1:3042:8ee4 with SMTP id
 ey24-20020a056a2047d800b001a130428ee4mr6755151pzb.42.1709833343587; Thu, 07
 Mar 2024 09:42:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 7 Mar 2024 18:42:11 +0100
Message-ID: <CANiq72ka4rir+RTN2FQoT=Vvprp_Ao-CvoYEkSNqtSY+RZj+AA@mail.gmail.com>
Subject: vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, alexei.starovoitov@gmail.com, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi arm64/bpf/pci,

In today's next-20240307 with a defconfig LLVM=1 I am seeing [1] under
QEMU virt, i.e. from
https://lore.kernel.org/all/20240305030516.41519-2-alexei.starovoitov@gmail.com/
applied to the bpf-next tree.

Cheers,
Miguel

[1]

[    0.425177] pci-host-generic 4010000000.pcie: host bridge
/pcie@10000000 ranges:
[    0.425886] pci-host-generic 4010000000.pcie:       IO
0x003eff0000..0x003effffff -> 0x0000000000
[    0.426534] pci-host-generic 4010000000.pcie:      MEM
0x0010000000..0x003efeffff -> 0x0010000000
[    0.426764] pci-host-generic 4010000000.pcie:      MEM
0x8000000000..0xffffffffff -> 0x8000000000
[    0.427324] ------------[ cut here ]------------
[    0.427456] vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
[    0.427944] WARNING: CPU: 0 PID: 1 at mm/vmalloc.c:315
ioremap_page_range+0x25c/0x2bc
[    0.428543] Modules linked in:
[    0.429236] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
6.8.0-rc7-next-20240307 #1
[    0.429513] Hardware name: linux,dummy-virt (DT)
[    0.429751] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.429946] pc : ioremap_page_range+0x25c/0x2bc
[    0.430063] lr : ioremap_page_range+0x258/0x2bc
[    0.430178] sp : ffff80008002b670
[    0.430271] x29: ffff80008002b690 x28: 0000000000001820 x27: 0000000000001880
[    0.430556] x26: ffffde390bd7d000 x25: 0000000000000000 x24: ffffde390bce9000
[    0.430729] x23: ffff69958280b0a0 x22: 0000000000000000 x21: 000000003eff0000
[    0.430895] x20: ffff699582805090 x19: ffffffffc0800000 x18: 00000000de69481d
[    0.431060] x17: ffff80008002b1fb x16: 0000000000000108 x15: 0000000000000004
[    0.431245] x14: ffffde390bd19570 x13: 0000000000000fff x12: 0000000000000003
[    0.431421] x11: 0000000000000003 x10: ffffde390bca2008 x9 : 4038d3d4a4dd4200
[    0.431623] x8 : 4038d3d4a4dd4200 x7 : 0773076107200764 x6 : 0765076b07720761
[    0.431774] x5 : ffff699582829f00 x4 : ffff699582829fa0 x3 : 0000000000000000
[    0.431923] x2 : 0000000000000000 x1 : ffff80008002b400 x0 : 00000000ffffffea
[    0.432220] Call trace:
[    0.432462]  ioremap_page_range+0x25c/0x2bc
[    0.432703]  pci_remap_iospace+0x78/0x84
[    0.432854]  devm_pci_remap_iospace+0x54/0x98
[    0.432979]  devm_of_pci_bridge_init+0x2e0/0x48c
[    0.433114]  devm_pci_alloc_host_bridge+0xa4/0xbc
[    0.433254]  pci_host_common_probe+0x48/0x1a4
[    0.433363]  platform_probe+0xa8/0xd0
[    0.433456]  really_probe+0x130/0x2e4
[    0.433545]  __driver_probe_device+0xa0/0x128
[    0.433647]  driver_probe_device+0x3c/0x1f8
[    0.433742]  __driver_attach+0xdc/0x1a4
[    0.433834]  bus_for_each_dev+0xe8/0x140
[    0.433925]  driver_attach+0x24/0x30
[    0.434011]  bus_add_driver+0x154/0x240
[    0.434104]  driver_register+0x68/0x100
[    0.434196]  __platform_driver_register+0x24/0x30
[    0.434306]  gen_pci_driver_init+0x1c/0x28
[    0.434407]  do_one_initcall+0xbc/0x248
[    0.434533]  do_initcall_level+0x94/0xb4
[    0.434632]  do_initcalls+0x54/0x94
[    0.434721]  do_basic_setup+0x50/0x60
[    0.434810]  kernel_init_freeable+0x10c/0x178
[    0.434912]  kernel_init+0x20/0x1a0
[    0.435003]  ret_from_fork+0x10/0x20
[    0.435227] ---[ end trace 0000000000000000 ]---
[    0.435691] pci-host-generic 4010000000.pcie: error -22: failed to
map resource [io  0x0000-0xffff]
[    0.436124] pci-host-generic 4010000000.pcie: Memory resource size
exceeds max for 32 bits
[    0.436713] pci-host-generic 4010000000.pcie: ECAM at [mem
0x4010000000-0x401fffffff] for [bus 00-ff]
[    0.438068] pci-host-generic 4010000000.pcie: PCI host bridge to bus 0000:00
[    0.438414] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.438584] pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff]
[    0.438732] pci_bus 0000:00: root bus resource [mem
0x8000000000-0xffffffffff]
[    0.440126] pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
conventional PCI endpoint
[    0.443526] pci 0000:00:01.0: [1af4:1000] type 00 class 0x020000
conventional PCI endpoint
[    0.443891] pci 0000:00:01.0: BAR 0 [io  0x0000-0x001f]
[    0.444059] pci 0000:00:01.0: BAR 1 [mem 0x00000000-0x00000fff]
[    0.444227] pci 0000:00:01.0: BAR 4 [mem 0x00000000-0x00003fff 64bit pref]
[    0.444468] pci 0000:00:01.0: ROM [mem 0x00000000-0x0007ffff pref]
[    0.446795] pci 0000:00:01.0: ROM [mem 0x10000000-0x1007ffff pref]: assigned
[    0.447158] pci 0000:00:01.0: BAR 4 [mem 0x8000000000-0x8000003fff
64bit pref]: assigned
[    0.447465] pci 0000:00:01.0: BAR 1 [mem 0x10080000-0x10080fff]: assigned
[    0.447632] pci 0000:00:01.0: BAR 0 [io  size 0x0020]: can't assign; no space
[    0.447945] pci 0000:00:01.0: BAR 0 [io  size 0x0020]: failed to assign

