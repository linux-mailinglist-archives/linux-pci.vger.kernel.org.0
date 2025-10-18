Return-Path: <linux-pci+bounces-38563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B780BEC9BB
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 10:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D53DC350DEB
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 08:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4750028725A;
	Sat, 18 Oct 2025 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du6W7IKw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4E285406
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760775293; cv=none; b=DL/16u37kjwqSUAORZhUEB7oDVH2fv2HP+cvtkYmTd2lxmGc7PZO6QvYjplIj/TKX27yxA10mzATgpFGDUxjNauyeSjqWFI+WbWzpX1Isl6uuUVxoJHXyvy4oY5h/4uf3MvxLTSrZcNl7VlG6Fv+ipAr6TOGtcFqJ8nld+0eqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760775293; c=relaxed/simple;
	bh=stEn61YMlDBZHmJHiQAB05JqwH06yI7RnuoevuO0ynQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OMWUfrF9Az9gYrtKvCftnpSF+3NmFYgG4G5WDSM0M4+PSBxMxbBeMZCc9ds6etEugWI94wU0w3IE+ely8eax6IrFUFM4PyeZqCkTvpQCK/LjveL2Ys0Nfk5CqzzpKbO5l88XsxOZk733F2sLpvpYGpQMKUXNkxqNakzw3cXSCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du6W7IKw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710683a644so24591515e9.0
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760775288; x=1761380088; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g+8hJOPQngU4oat/u2j+gPeuDP3LFJ5IRHmNxnbE2sg=;
        b=Du6W7IKwVVLTrzN77nTIuqSOOVCz0EzsTajXgh2Gf57LVy/bdVvx1QkHtw6hYCqUDl
         6BZLlifXiViWLoN0yUNBJRV8n/JInEq9iZn1K7GzpvLGcHhHBpgCrUUURmgP48XtAptr
         B5Kd6CdEzZuYaSIJeUJQAD8Lp+8Ghkd0w0dIyDuDlq3o2lDmMXOI11T+xuaJ3ZflaDGW
         wTfvUpgH/i0PYNWZLs+JIciWTVRLz7aukaqolBJGoLKLuaNPLV5A7qNxQzdbdNdgatRx
         kBmm1SvepXT3e1yO0FjTnm7HqEecGLSIBzInkAIA4MKjhxFv/6XOlp3rqZ+km9unthBv
         +Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760775288; x=1761380088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+8hJOPQngU4oat/u2j+gPeuDP3LFJ5IRHmNxnbE2sg=;
        b=do95ipeVEOPDVUXYm09t2tTgsJskpZcWFVS12b0Yzekvkmy2hfFKCkpZC5I+cTDkRc
         fAPnzAHIqKomhPEGbkfdH11NglEZK54ETik0Hhy76ABCLyAK2FiBpuNmJFauo/jl6Piv
         VbB+DxTrdguxMnlAm25oAzFtmIU8beGWhe88TsVg3WT4qRC+5O8JHyO9ng42jrD87MEA
         MUi1W0f+Nf3i57BGY3CpDBIP2Tm/DMtgha+onkVRtOLAvvszLE1/lBaIv/ivrJgTyNt2
         z02a2rs96IOLDu8tAkCj38WdiJwPMYx96AUjLI1xXpKo+OmN3hpKOm5LqL1O4BKuX3I3
         +5qg==
X-Forwarded-Encrypted: i=1; AJvYcCUMciD+R9gQCcr4vQdIVUOimmpTmxdgyQ6M6sbH8X0ZsB6XAfdsP25vV1x0QdpQ8+SK0ZywmhQ7Pdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKgRzhVklctxm5emIXmetw7oM0k7hh+7p36gnbS7v3+HA+o2I8
	Spdll3wl1qoPSwYTHwxz/3pgXBUypY9AjlFOwgu5p0egwQEHy0zKQXX7
X-Gm-Gg: ASbGncs7bROLJ2oFK+TrJT1mFTwEeplnaEnzYO6+EMMDBEkjEtLK5likNi2+O0z4cKH
	yobAviVuNotcju62rGniBsDDkKYRXDftUpRB/Fasgo+81VsfJM+pJv6642HGOlbEM59dXA7Ujcy
	kPcFFiqVK6RDtt5KFbrKyuCnY8rd9xXzkV8s1bgAUS7D/k9d+2pM/5ZB+uqeuyO0b/fBgCll4T1
	zBHNEvBm8J0Rc/gFubsLUsmenywocXWt7B27bPuu4IyqaaTKN3UFm4LJXmHZnZcSogaxpXazPwE
	ZlxaUi5budaQjchFr10L+7riupBwMgWd5FJ2QgQPbeFGzpIGz/tv6BDAQWnhqgoDJPAqV9SkmOp
	ZgAoGA7cb+BENEPMhpXZ7n/is0gDkeO0gJfGz1TF7Q6cHk68S/NP7DGlvCWo3fxRrVMBlkHDUcV
	ZnAZOWaFUc1RiZl8jRJciZD4ewbgQe2pMjmZX/aWTDnRFggH/AueEm5pg=
X-Google-Smtp-Source: AGHT+IEMMZDB/lqLE2C50yNzfz6dfaD+4c8YbAcbUT7njlExhc7aN8j2iEPocSPr5UhqgT4Za/7hSQ==
X-Received: by 2002:a05:600c:6384:b0:471:846:80ac with SMTP id 5b1f17b1804b1-471173460a3mr51372525e9.18.1760775287957;
        Sat, 18 Oct 2025 01:14:47 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:a776:5e51:5cb5:418? ([2a02:168:6806:0:a776:5e51:5cb5:418])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c82b8sm121077135e9.15.2025.10.18.01.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 01:14:47 -0700 (PDT)
Message-ID: <51e8cf1c62b8318882257d6b5a9de7fdaaecc343.camel@gmail.com>
Subject: WARNING at drivers/pci/setup-bus.c:2373, bisected to "PCI: Use
 pbus_select_window_for_type() during mem window sizing"
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Date: Sat, 18 Oct 2025 10:14:47 +0200
In-Reply-To: <20250829131113.36754-20-ilpo.jarvinen@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
	 <20250829131113.36754-20-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-29 at 16:11 +0300, Ilpo J=C3=A4rvinen wrote:
> __pci_bus_size_bridges() goes to great lengths of helping pbus_size_mem()
> in which types it should put into a particular bridge window, requiring
> passing up to three resource type into pbus_size_mem().
>=20
> Instead of having complex logic in __pci_bus_size_bridges() and a
> non-straightforward interface between those functions, use
> pbus_select_window_for_type() and pbus_select_window() to find the correc=
t
> bridge window and compare if the resources belong to that window.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>


Hi,


this batch became mainline commit ae88d0b9c57f, and causes a warning when b=
ooting
on my Turris Omnia.

Device tree: arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
PCI driver: pci-mvebu
Hardware status: The joint mPCIe / mSATA slot carries an mSATA drive, the o=
ther
two mPCIe slots carry WiFi cards.

As far as I can tell, hardware is operating nominally, so the warning looks=
 like
a false positive.


*** relevant section of the boot log, at ae88d0b9c57f (first bad commit) **=
*

[    0.024347] mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
[    0.024372] mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> =
0x0000080000
[    0.024388] mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> =
0x0000040000
[    0.024401] mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> =
0x0000044000
[    0.024414] mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> =
0x0000048000
[    0.024427] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0100000000
[    0.024439] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0100000000
[    0.024452] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0200000000
[    0.024464] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0200000000
[    0.024476] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0300000000
[    0.024488] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0300000000
[    0.024500] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0400000000
[    0.024508] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0400000000
[    0.024698] mvebu-pcie soc:pcie: pcie1.0: Slot power limit 10.0W
[    0.024890] mvebu-pcie soc:pcie: pcie2.0: Slot power limit 10.0W
[    0.025099] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
[    0.025107] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.025114] pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081ff=
f] (bus address [0x00080000-0x00081fff])
[    0.025120] pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041ff=
f] (bus address [0x00040000-0x00041fff])
[    0.025125] pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045ff=
f] (bus address [0x00044000-0x00045fff])
[    0.025135] pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049ff=
f] (bus address [0x00048000-0x00049fff])
[    0.025139] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7fffff=
f]
[    0.025143] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
[    0.025262] pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.025277] pci 0000:00:02.0: PCI bridge to [bus 00]
[    0.025284] pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
[    0.025289] pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff=
]
[    0.025484] /soc/pcie/pcie@2,0: Fixed dependency cycle(s) with /soc/pcie=
/pcie@2,0/interrupt-controller
[    0.025524] pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.025537] pci 0000:00:03.0: PCI bridge to [bus 00]
[    0.025543] pci 0000:00:03.0:   bridge window [io  0x0000-0x0fff]
[    0.025547] pci 0000:00:03.0:   bridge window [mem 0x00000000-0x000fffff=
]
[    0.025665] /soc/pcie/pcie@3,0: Fixed dependency cycle(s) with /soc/pcie=
/pcie@3,0/interrupt-controller
[    0.026453] PCI: bus0: Fast back to back transfers disabled
[    0.026459] pci 0000:00:02.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    0.026466] pci 0000:00:03.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    0.026538] pci 0000:01:00.0: [168c:002e] type 00 class 0x028000 PCIe Le=
gacy Endpoint
[    0.026577] pci 0000:01:00.0: BAR 0 [mem 0xc0000000-0xc000ffff 64bit]
[    0.026669] pci 0000:01:00.0: supports D1
[    0.026673] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
[    0.026783] PCI: bus1: Fast back to back transfers disabled
[    0.026788] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.026860] pci 0000:02:00.0: [168c:003c] type 00 class 0x028000 PCIe En=
dpoint
[    0.026898] pci 0000:02:00.0: BAR 0 [mem 0xc8000000-0xc81fffff 64bit]
[    0.026909] pci 0000:02:00.0: ROM [mem 0xc8200000-0xc820ffff pref]
[    0.026987] pci 0000:02:00.0: supports D1 D2
[    0.027083] PCI: bus2: Fast back to back transfers disabled
[    0.027088] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    0.027107] pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] =
to [bus 02] add_size 200000 add_align 200000
[    0.027115] pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] =
to [bus 02] add_size 200000 add_align 200000
[    0.027131] pci 0000:00:03.0: bridge window [mem 0xe0000000-0xe03fffff]:=
 assigned
[    0.027138] pci 0000:00:02.0: bridge window [mem 0xe0400000-0xe04fffff]:=
 assigned
[    0.027146] pci 0000:01:00.0: BAR 0 [mem 0xe0400000-0xe040ffff 64bit]: a=
ssigned
[    0.027158] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.027165] pci 0000:00:02.0:   bridge window [mem 0xe0400000-0xe04fffff=
]
[    0.027178] pci 0000:02:00.0: BAR 0 [mem 0xe0000000-0xe01fffff 64bit]: a=
ssigned
[    0.027188] pci 0000:02:00.0: ROM [mem 0xe0200000-0xe020ffff pref]: assi=
gned
[    0.027194] pci 0000:00:03.0: PCI bridge to [bus 02]
[    0.027199] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xe03fffff=
]
[    0.027208] ------------[ cut here ]------------
[    0.027211] WARNING: CPU: 0 PID: 1 at drivers/pci/setup-bus.c:2373 pci_a=
ssign_unassigned_root_bus_resources+0x1bc/0x234
[    0.027230] Modules linked in:
[    0.027238] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-rc1+=
 #49 NONE=20
[    0.027246] Hardware name: Marvell Armada 380/385 (Device Tree)
[    0.027250] Call trace:=20
[    0.027258]  unwind_backtrace from show_stack+0x10/0x14
[    0.027278]  show_stack from dump_stack_lvl+0x50/0x64
[    0.027288]  dump_stack_lvl from __warn+0x7c/0xd4
[    0.027301]  __warn from warn_slowpath_fmt+0x158/0x15c
[    0.027314]  warn_slowpath_fmt from pci_assign_unassigned_root_bus_resou=
rces+0x1bc/0x234
[    0.027328]  pci_assign_unassigned_root_bus_resources from pci_host_prob=
e+0x50/0xb8
[    0.027341]  pci_host_probe from platform_probe+0x48/0x84
[    0.027351]  platform_probe from really_probe+0xc8/0x2c8
[    0.027364]  really_probe from driver_probe_device+0x38/0x114
[    0.027378]  driver_probe_device from __driver_attach+0x9c/0x194
[    0.027391]  __driver_attach from bus_for_each_dev+0x60/0x94
[    0.027404]  bus_for_each_dev from bus_add_driver+0xc8/0x1e8
[    0.027417]  bus_add_driver from driver_register+0x84/0x138
[    0.027426]  driver_register from do_one_initcall+0x44/0x268
[    0.027433]  do_one_initcall from kernel_init_freeable+0x258/0x2c8
[    0.027445]  kernel_init_freeable from kernel_init+0x1c/0x130
[    0.027458]  kernel_init from ret_from_fork+0x14/0x28
[    0.027466] Exception stack(0xf0831fb0 to 0xf0831ff8)
[    0.027472] 1fa0:                                     00000000 00000000 =
00000000 00000000
[    0.027477] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.027481] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.027485] ---[ end trace 0000000000000000 ]---
[    0.027489] pci_bus 0000:00: resource 4 [mem 0xf1080000-0xf1081fff]
[    0.027495] pci_bus 0000:00: resource 5 [mem 0xf1040000-0xf1041fff]
[    0.027500] pci_bus 0000:00: resource 6 [mem 0xf1044000-0xf1045fff]
[    0.027504] pci_bus 0000:00: resource 7 [mem 0xf1048000-0xf1049fff]
[    0.027508] pci_bus 0000:00: resource 8 [mem 0xe0000000-0xe7ffffff]
[    0.027512] pci_bus 0000:00: resource 9 [io  0x1000-0xeffff]
[    0.027517] pci_bus 0000:01: resource 1 [mem 0xe0400000-0xe04fffff]
[    0.027522] pci_bus 0000:02: resource 1 [mem 0xe0000000-0xe03fffff]




*** relevant section of the boot log, at 13016e15d595 (last good commit) **=
*

[    0.024666] mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
[    0.024690] mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> =
0x0000080000
[    0.024706] mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> =
0x0000040000
[    0.024719] mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> =
0x0000044000
[    0.024732] mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> =
0x0000048000
[    0.024745] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0100000000
[    0.024757] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0100000000
[    0.024770] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0200000000
[    0.024782] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0200000000
[    0.024794] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0300000000
[    0.024806] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0300000000
[    0.024818] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0400000000
[    0.024827] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0400000000
[    0.025022] mvebu-pcie soc:pcie: pcie1.0: Slot power limit 10.0W
[    0.025210] mvebu-pcie soc:pcie: pcie2.0: Slot power limit 10.0W
[    0.025451] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
[    0.025459] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.025466] pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081ff=
f] (bus address [0x00080000-0x00081fff])
[    0.025472] pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041ff=
f] (bus address [0x00040000-0x00041fff])
[    0.025477] pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045ff=
f] (bus address [0x00044000-0x00045fff])
[    0.025482] pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049ff=
f] (bus address [0x00048000-0x00049fff])
[    0.025487] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7fffff=
f]
[    0.025491] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
[    0.025617] pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.025633] pci 0000:00:02.0: PCI bridge to [bus 00]
[    0.025639] pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
[    0.025644] pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff=
]
[    0.025794] /soc/pcie/pcie@2,0: Fixed dependency cycle(s) with /soc/pcie=
/pcie@2,0/interrupt-controller
[    0.025832] pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.025844] pci 0000:00:03.0: PCI bridge to [bus 00]
[    0.025851] pci 0000:00:03.0:   bridge window [io  0x0000-0x0fff]
[    0.025855] pci 0000:00:03.0:   bridge window [mem 0x00000000-0x000fffff=
]
[    0.025968] /soc/pcie/pcie@3,0: Fixed dependency cycle(s) with /soc/pcie=
/pcie@3,0/interrupt-controller
[    0.026757] PCI: bus0: Fast back to back transfers disabled
[    0.026762] pci 0000:00:02.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    0.026769] pci 0000:00:03.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    0.026845] pci 0000:01:00.0: [168c:002e] type 00 class 0x028000 PCIe Le=
gacy Endpoint
[    0.026884] pci 0000:01:00.0: BAR 0 [mem 0xc0000000-0xc000ffff 64bit]
[    0.026976] pci 0000:01:00.0: supports D1
[    0.026980] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
[    0.027082] PCI: bus1: Fast back to back transfers disabled
[    0.027087] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.027163] pci 0000:02:00.0: [168c:003c] type 00 class 0x028000 PCIe En=
dpoint
[    0.027201] pci 0000:02:00.0: BAR 0 [mem 0xc8000000-0xc81fffff 64bit]
[    0.027212] pci 0000:02:00.0: ROM [mem 0xc8200000-0xc820ffff pref]
[    0.027290] pci 0000:02:00.0: supports D1 D2
[    0.027381] PCI: bus2: Fast back to back transfers disabled
[    0.027386] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    0.027405] pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] =
to [bus 02] add_size 200000 add_align 200000
[    0.027423] pci 0000:00:03.0: bridge window [mem 0xe0000000-0xe03fffff]:=
 assigned
[    0.027430] pci 0000:00:02.0: bridge window [mem 0xe0400000-0xe04fffff]:=
 assigned
[    0.027438] pci 0000:01:00.0: BAR 0 [mem 0xe0400000-0xe040ffff 64bit]: a=
ssigned
[    0.027450] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.027457] pci 0000:00:02.0:   bridge window [mem 0xe0400000-0xe04fffff=
]
[    0.027470] pci 0000:02:00.0: BAR 0 [mem 0xe0000000-0xe01fffff 64bit]: a=
ssigned
[    0.027481] pci 0000:02:00.0: ROM [mem 0xe0200000-0xe020ffff pref]: assi=
gned
[    0.027487] pci 0000:00:03.0: PCI bridge to [bus 02]
[    0.027492] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xe03fffff=
]
[    0.027502] pci_bus 0000:00: resource 4 [mem 0xf1080000-0xf1081fff]
[    0.027507] pci_bus 0000:00: resource 5 [mem 0xf1040000-0xf1041fff]
[    0.027511] pci_bus 0000:00: resource 6 [mem 0xf1044000-0xf1045fff]
[    0.027515] pci_bus 0000:00: resource 7 [mem 0xf1048000-0xf1049fff]
[    0.027519] pci_bus 0000:00: resource 8 [mem 0xe0000000-0xe7ffffff]
[    0.027523] pci_bus 0000:00: resource 9 [io  0x1000-0xeffff]
[    0.027528] pci_bus 0000:01: resource 1 [mem 0xe0400000-0xe04fffff]
[    0.027532] pci_bus 0000:02: resource 1 [mem 0xe0000000-0xe03fffff]


#regzbot introduced: ae88d0b9c57f


Thanks, Klaus

