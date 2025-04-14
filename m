Return-Path: <linux-pci+bounces-25840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC6FA88486
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 16:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3A417EB1A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE86C26AFB;
	Mon, 14 Apr 2025 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6iOU3ea"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E6A1805B;
	Mon, 14 Apr 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638744; cv=none; b=GyC6tHlYH5VynWJGxuNTte5hZDLb9sLw5FvWcsp6wuzN9IwDbO95jY0wyM/XNOOupvSmHtu+AeLLHlGIVjq8isbkoYuIwXNitnDz9IwrFUwzK9Ll2Bw+zl2a304eBxkSKnIMYP9Y8w+LIs/1PLMXX0PtdLnadnpTC7PTzJsUIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638744; c=relaxed/simple;
	bh=2us9Yy1h7Rn5Y+xf7l2KgkWlECqJmgw3NVFKQasnIk8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=s08674OFoxcVJJhCIk+v/fNArNBM7kqf58A6iGj+VMvydoiSddxb7rwHC8dgku5843pQktVEdnvQA/Gtu7VRG8QPbgoGe+AkZzlCNR7lAy3JmHQnSOOLbUuyTeuX0bK1qlB/prsqJ4om1UwsipNnZV3JMZZOKxWk+B48NRXDPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6iOU3ea; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744638743; x=1776174743;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2us9Yy1h7Rn5Y+xf7l2KgkWlECqJmgw3NVFKQasnIk8=;
  b=f6iOU3eaUyFJVW2ajIixo/jL3jSy4sm9pDMDgFOKLhWHT6+vbgzY8oPM
   L6/o8hEaln8wyVS866Lca1kWqEtvx4u8lwxAr1FW5dPxZMgwdhwWX3KEy
   YmlMFyCN7OfXbYDETkzjei3imkUze9YBK+MI2htB7KrzvT4Fbxo9nSrUZ
   ui2Z5NiCBZq4IkUHf9RCM57b85Svx7YRMHXC9dU0tkytR+4V3iezj8H7N
   U8lYj8MbZirXusmbcUH7FQvTiHJDor9Bf8T/Lf9pDckhilyWyJASPC/zR
   Ltl1aLnyh363a/yBr6dZLp8IKHvWbSlrHjVxXh4ZiNJ6qV73b8jWV+Z/I
   g==;
X-CSE-ConnectionGUID: 6lQnJmF3TXa+EmJ/DOcv1g==
X-CSE-MsgGUID: Cq3szEBIR0GOA1l93Th0EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="57475329"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="57475329"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:52:23 -0700
X-CSE-ConnectionGUID: z84XrAOnQvaQbVfugPEkBg==
X-CSE-MsgGUID: N/HG3ICZS8C987amuYcghQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="134664588"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.8])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:52:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 14 Apr 2025 16:52:16 +0300 (EEST)
To: =?ISO-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
cc: Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <rndyvjlylykt7aj6czm5awh47ddi3j22zna45zfppq5iu4xdgd@tqvzfa524vd3>
Message-ID: <d42d4239-ed64-a1ff-9d86-905460bfeb6c@linux.intel.com>
References: <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <01eb7d40-f5b5-4ec5-b390-a5c042c30aff@roeck-us.net> <75f74b48-edd8-7d1c-d303-1222d12e3812@linux.intel.com> <6612c4d2-2533-98ef-7c89-f61d80c3e3e2@linux.intel.com> <5eb8fd42-b288-4ecb-ae0e-177904cc0a14@roeck-us.net>
 <c34c6dc2-5ab2-1a81-3ba4-b3bc2c016945@linux.intel.com> <nb4knp52jylojmj3jsvvgq2dsbn3srruxmkqfuto2k3hv3fnqs@6rkqgdved6gi> <9c9d5aed-ae10-f590-3e59-34234d4d8f7d@linux.intel.com> <tuhhms3jfcbgzzgmxt7ghvhp5zoh56ue2ikvge2kdhsudnpoon@elmy6yymd6bf>
 <a822896a-de7d-697c-2240-2afa95b318f3@linux.intel.com> <rndyvjlylykt7aj6czm5awh47ddi3j22zna45zfppq5iu4xdgd@tqvzfa524vd3>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1273008509-1744638736=:10563"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1273008509-1744638736=:10563
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 14 Apr 2025, Ond=C5=99ej Jirman wrote:
> On Mon, Apr 14, 2025 at 04:15:01PM +0300, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 14 Apr 2025, Ond=C5=99ej Jirman wrote:
> > > On Mon, Apr 14, 2025 at 12:52:15PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > > On Fri, 11 Apr 2025, Ond=C5=99ej Jirman wrote:
> > > >=20
> > > > > Hello Ilpo,
> > > > >=20
> > > > > On Tue, Apr 01, 2025 at 08:38:48PM +0300, Ilpo J=C3=A4rvinen wrot=
e:
> > > > > > That log wasn't taken from a bad case but it doesn't matter any=
more as I=20
> > > > > > could test this with qemu myself, thanks for providing enough t=
o make it=20
> > > > > > easy to reproduce & test it locally :-).
> > > > > >=20
> > > > > > The problem is caused by assign+release cycle being destructive=
 on start=20
> > > > > > aligned resources because successful assigment overwrites the s=
tart field.=20
> > > > > > I'll send a patch to fix the problem once I've given it a bit m=
ore thought
> > > > > > as this resource fitting code is somewhat complex.
> > > > >=20
> > > > > BTW, same thing here on a different SoC:
> > > > >=20
> > > > > https://lore.kernel.org/lkml/hrcsm2bo4ysqj2ggejndlou32cdc7yiknnm5=
nrlcoz4d64wall@7te4dfqsoe3y/T/#u
> > > > >=20
> > > > > There are kernel logs there, too, although I don't have dynamic d=
ebug enabled
> > > > > in the kernel.
> > > > >=20
> > > > > Interestingly, bisect pointed me initially to a different commit.=
 Reverting
> > > > > it helped, but just on one board (QuartzPro64).
> > > >=20
> > > > Hi,
> > > >=20
> > > > Since you didn't mention it, I guess you haven't tried the fix:
> > > >=20
> > > > https://patchwork.kernel.org/project/linux-pci/patch/20250403093137=
=2E1481-1-ilpo.jarvinen@linux.intel.com/
> > >=20
> > > This patch works. Thank you.
> >=20
> > Thanks for testing. If you feel confident enough, please send your=20
> > Tested-by tag to its thread (not this one).
> >=20
> > > One difference compared to 6.14 that I'm noticing
> > > in the kernel log is that "save config" sequences now are printed twi=
ce for
> > > unpopulated port. Not sure if it's related to your patches. Previousl=
y it was
> > > printed just once.
> >=20
> > I don't think it is related. The resource fitting/assignment changes=20
> > should not impact PCI save/restore AFAIK (except by preventing device f=
rom=20
> > working in the first place if necessary resources do not get assigned).
> >=20
> > PCI state saving has always seemed like that in most logs I've seen wit=
h=20
> > dyndbg enabled, that is, the state is seemingly saved multiple times,=
=20
> > often right after the previous save too. So TBH, I'm not convinced it's=
=20
> > even something new. If you have backtraces to show those places that=20
> > invoke pci_save_state() I can take a look but I don't expect much to=20
> > come out of that.
>=20
> You're right. It's unrelated. The traces:
>=20
> [    1.878732]  show_stack+0x28/0x80 (C)
> [    1.878751]  dump_stack_lvl+0x58/0x74
> [    1.878762]  dump_stack+0x14/0x1c
> [    1.878772]  pci_save_state+0x34/0x1e8
> [    1.878783]  pcie_portdrv_probe+0x330/0x6a8
> [    1.878794]  local_pci_probe+0x3c/0xa0
> [    1.878804]  pci_device_probe+0xac/0x194
> [    1.878813]  really_probe+0xbc/0x388
> [    1.878825]  __driver_probe_device+0x78/0x144
> [    1.878837]  driver_probe_device+0x38/0x110
> [    1.878850]  __device_attach_driver+0xb0/0x150
> [    1.878862]  bus_for_each_drv+0x6c/0xb0
> [    1.878873]  __device_attach+0x98/0x1a0
> [    1.878886]  device_attach+0x10/0x20
> [    1.878897]  pci_bus_add_device+0x84/0x12c
> [    1.878911]  pci_bus_add_devices+0x40/0x90
> [    1.878924]  pci_host_probe+0x88/0xe4
> [    1.878933]  dw_pcie_host_init+0x258/0x714
> [    1.878945]  rockchip_pcie_probe+0x2f0/0x3f8
> [    1.878956]  platform_probe+0x64/0xcc
> [    1.878965]  really_probe+0xbc/0x388
> [    1.878977]  __driver_probe_device+0x78/0x144
> [    1.878989]  driver_probe_device+0x38/0x110
> [    1.879001]  __device_attach_driver+0xb0/0x150
> [    1.879014]  bus_for_each_drv+0x6c/0xb0
> [    1.879025]  __device_attach+0x98/0x1a0
> [    1.879037]  device_initial_probe+0x10/0x20
> [    1.879049]  bus_probe_device+0xa8/0xb8
> [    1.879061]  deferred_probe_work_func+0xa4/0xf0
> [    1.879072]  process_one_work+0x13c/0x2bc
> [    1.879084]  worker_thread+0x284/0x460
> [    1.879094]  kthread+0xe4/0x1a0
> [    1.879107]  ret_from_fork+0x10/0x20
> [    1.879121] pcieport 0002:20:00.0: save config 0x00: 0x35881d87
> [    1.879158] pcieport 0002:20:00.0: save config 0x04: 0x00100507
> [    1.879168] pcieport 0002:20:00.0: save config 0x08: 0x06040001
> [    1.879177] pcieport 0002:20:00.0: save config 0x0c: 0x00010000
> [    1.879221] pcieport 0002:20:00.0: save config 0x10: 0x00000000
> [    1.879232] pcieport 0002:20:00.0: save config 0x14: 0x00000000
> [    1.879242] pcieport 0002:20:00.0: save config 0x18: 0x00212120
> [    1.879251] pcieport 0002:20:00.0: save config 0x1c: 0x000000f0
> [    1.879260] pcieport 0002:20:00.0: save config 0x20: 0x0000fff0
> [    1.879270] pcieport 0002:20:00.0: save config 0x24: 0x0001fff1
> [    1.879279] pcieport 0002:20:00.0: save config 0x28: 0x00000000
> [    1.879289] pcieport 0002:20:00.0: save config 0x2c: 0x00000000
> [    1.879298] pcieport 0002:20:00.0: save config 0x30: 0x00000000
> [    1.879307] pcieport 0002:20:00.0: save config 0x34: 0x00000040
> [    1.879316] pcieport 0002:20:00.0: save config 0x38: 0x00000000
> [    1.879325] pcieport 0002:20:00.0: save config 0x3c: 0x00020194       =
       =20
> [    1.879376] pcieport 0002:20:00.0: vgaarb: pci_notify
>=20
> second time it's from:
>=20
> [    2.004478] Workqueue: pm pm_runtime_work
> [    2.004488] Call trace:
> [    2.004491]  show_stack+0x28/0x80 (C)
> [    2.004500]  dump_stack_lvl+0x58/0x74
> [    2.004506]  dump_stack+0x14/0x1c
> [    2.004511]  pci_save_state+0x34/0x1e8
> [    2.004516]  pci_pm_runtime_suspend+0xa8/0x1e0
> [    2.004521]  __rpm_callback+0x3c/0x220
> [    2.004527]  rpm_callback+0x6c/0x80
> [    2.004532]  rpm_suspend+0xec/0x674
> [    2.004537]  pm_runtime_work+0x104/0x114
> [    2.004542]  process_one_work+0x13c/0x2bc
> [    2.004548]  worker_thread+0x284/0x460
> [    2.004552]  kthread+0xe4/0x1a0
> [    2.004559]  ret_from_fork+0x10/0x20
> [    2.004567] pcieport 0002:20:00.0: save config 0x00: 0x35881d87
> [    2.004578] pcieport 0002:20:00.0: save config 0x04: 0x00100507
> [    2.004583] pcieport 0002:20:00.0: save config 0x08: 0x06040001
> [    2.004587] pcieport 0002:20:00.0: save config 0x0c: 0x00010000
> [    2.004591] pcieport 0002:20:00.0: save config 0x10: 0x00000000
> [    2.004596] pcieport 0002:20:00.0: save config 0x14: 0x00000000
> [    2.004600] pcieport 0002:20:00.0: save config 0x18: 0x00212120
> [    2.004604] pcieport 0002:20:00.0: save config 0x1c: 0x000000f0
> [    2.004608] pcieport 0002:20:00.0: save config 0x20: 0x0000fff0
> [    2.004613] pcieport 0002:20:00.0: save config 0x24: 0x0001fff1
> [    2.004617] pcieport 0002:20:00.0: save config 0x28: 0x00000000
> [    2.004621] pcieport 0002:20:00.0: save config 0x2c: 0x00000000
> [    2.004625] pcieport 0002:20:00.0: save config 0x30: 0x00000000
> [    2.004629] pcieport 0002:20:00.0: save config 0x34: 0x00000040
> [    2.004633] pcieport 0002:20:00.0: save config 0x38: 0x00000000
> [    2.004638] pcieport 0002:20:00.0: save config 0x3c: 0x00020194
> [    2.004662] pcieport 0002:20:00.0: PME# enabled
>=20
> on 6.15-rc:
>=20
> cat /sys/class/pci_bus/0002:20/device/0002:20:00.0/power/runtime_status  =
                                                                           =
                                                                         OK
> suspended
>=20
> on 6.14:
>=20
> cat /sys/class/pci_bus/0002:20/device/0002:20:00.0/power/runtime_status  =
                                                                           =
                                                                         OK
> active
>=20
> So some other unrelated change in 6.15-rc just enabled RPM to suspend the=
 unused
> port.

Ah right, makes sense, now that you mention I recall D3 became allowed for=
=20
PCI bridge on non-x86 archs but I just couldn't make the connection in my=
=20
mind.

--=20
 i.

--8323328-1273008509-1744638736=:10563--

