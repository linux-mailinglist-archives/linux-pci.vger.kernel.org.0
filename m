Return-Path: <linux-pci+bounces-7905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA418D2015
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 17:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244F0284709
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E02016FF4D;
	Tue, 28 May 2024 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apef/Rip"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8FB171084
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909305; cv=none; b=JNQPwIWYiIuJC+wVsdDcRivszRJQMebqWBvaFyK6EcOKkUQyr2n+97G2yVT9YasexV5W5uTpHQphaVO8DqSOZhikByuGXsBO8MD4LQ8bV3yL52D8Hbl3qRQzM4VBzYzXp5sku+hqLBEVsRNG4T/eKMCsHadb8/NWXgv5LBx5Hzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909305; c=relaxed/simple;
	bh=KeyauqtiSElxmBRtvDgyd2EnH1t7362p1MC4GDOvips=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJSxKTeCtRNUCpZBcSz+4fm5XtET1z5BenXTe5OmDsIiuDVEt+5qrGzglhXxgnzae2ZtPLib7QzUsafp1+LOV8fLOI2phK3tVw4hct8HyviLYVTY+c3119PX8Gn+WnDQTrtSo9g31ssv24xGqKbBrBsIlvnnewSxjfFJ4GhMQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apef/Rip; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716909304; x=1748445304;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KeyauqtiSElxmBRtvDgyd2EnH1t7362p1MC4GDOvips=;
  b=apef/RipN0inlQtH/igS1i+rLoU4DhpGTsoSf4nESWeS5Enqt+/nvcXp
   MyoN3AwR68A6327HaucZbjDGFUWGRQhVnaC1Clda/sSCJNfh+1R5mywqg
   I/OBPiV++XnlIJ4FuUtaqEQHIZQkf12xBl+p8J6V59B10tBN1DCQzK8pf
   GfbT5pCun8a3vIrIK36HItCrq86r3HOctClpil8aUfDBciMSNKADucXLe
   T42DO02MT2YcEE8g8yXXLN7U9oZHcNQ2Cs55IpK6k1b+K8atV4n/hTRUX
   6jsgXq3+zN/sd8EIiX3F7zqVaPGqJ/dY1jHAgxxRJkAd1iUbm3fdHB6Fv
   g==;
X-CSE-ConnectionGUID: vJaSF8doQbaJEwVKXVbmkA==
X-CSE-MsgGUID: evbAg+OGRG+7dOY84LqkRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13209795"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13209795"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 08:15:03 -0700
X-CSE-ConnectionGUID: tDJ3ijMyTV+TTYTTPr8jZA==
X-CSE-MsgGUID: hDeNlUlSRi+2YADdpxbRww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39545813"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.9]) ([10.125.111.9])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 08:15:01 -0700
Message-ID: <cfb50601-5d2a-4676-a958-1bd3f1b06654@intel.com>
Date: Tue, 28 May 2024 08:14:59 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Lockdep annotation introduced warn in VMD driver
To: imre.deak@intel.com
Cc: Xinghui Li <korantli@tencent.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Dan Williams <dan.j.williams@intel.com>
References: <ZlXP5oTnSApiDbD1@ideak-desk.fi.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZlXP5oTnSApiDbD1@ideak-desk.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/24 5:36 AM, Imre Deak wrote:
> Hi,
> 
> commit 7e89efc6e9e402839643cb297bab14055c547f07
> Author: Dave Jiang <dave.jiang@intel.com>
> Date:   Thu May 2 09:57:31 2024 -0700
> 
>     PCI: Lock upstream bridge for pci_reset_function()
> 
> introduced the WARN below in the VMD driver, see [1] for the full log.
> Not sure if the annotation is incorrect or the VMD driver is missing
> the lock, CC'ing VMD folks.
> 
> --Imre
> 
> https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134112v1/bat-adlp-11/boot0.txt

Dan has a fix:
https://lore.kernel.org/linux-cxl/20240502165851.1948523-1-dave.jiang@intel.com/T/#m820e5488c7acd855827eb5463db9a7fa9ecb25ee
https://lore.kernel.org/linux-cxl/171659995361.845588.6664390911348526329.stgit@dwillia2-xfh.jf.intel.com/T/#u



> 
> <4>[   17.354071] WARNING: CPU: 0 PID: 1 at drivers/pci/pci.c:4886 pci_bridge_secondary_bus_reset+0x5d/0x70
> <4>[   17.354095] Modules linked in:
> <4>[   17.354104] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc1-Patchwork_134112v1-gabaeae202dfb+ #1
> <4>[   17.354128] Hardware name: Intel Corporation Alder Lake Client Platform/AlderLake-P LP5 RVP, BIOS RPLPFWI1.R00.4035.A00.2301200723 01/20/2023
> <4>[   17.354153] RIP: 0010:pci_bridge_secondary_bus_reset+0x5d/0x70
> <4>[   17.354167] Code: c3 cc cc cc cc 48 89 ef 48 c7 c6 78 55 44 82 5d e9 d8 c6 ff ff 48 8d bf 48 08 00 00 be ff ff ff ff e8 97 10 5f 00 85 c0 75 b5 <0f> 0b eb b1 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90
> <4>[   17.354199] RSP: 0000:ffffc90000097ca0 EFLAGS: 00010246
> <4>[   17.354210] RAX: 0000000000000000 RBX: ffff888105604000 RCX: 0000000000000000
> <4>[   17.354224] RDX: 0000000080000000 RSI: ffffffff82421c40 RDI: ffffffff82441c4c
> <4>[   17.354238] RBP: ffff888105601000 R08: 0000000000000001 R09: 0000000000000000
> <4>[   17.354251] R10: 0000000000000001 R11: ffff8881008c8040 R12: 0000000000000000
> <4>[   17.354264] R13: 0000000000000020 R14: 000000000000007f R15: ffff888105615c28
> <4>[   17.354283] FS:  0000000000000000(0000) GS:ffff8882a6e00000(0000) knlGS:0000000000000000
> <4>[   17.354313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   17.354334] CR2: ffff8882afbff000 CR3: 000000000663a000 CR4: 0000000000f50ef0
> <4>[   17.354348] PKRU: 55555554
> <4>[   17.354355] Call Trace:
> <4>[   17.354361]  <TASK>
> <4>[   17.354367]  ? __warn+0x8c/0x190
> <4>[   17.354380]  ? pci_bridge_secondary_bus_reset+0x5d/0x70
> <4>[   17.354392]  ? report_bug+0x1f8/0x200
> <4>[   17.354405]  ? handle_bug+0x3c/0x70
> <4>[   17.354415]  ? exc_invalid_op+0x18/0x70
> <4>[   17.354424]  ? asm_exc_invalid_op+0x1a/0x20
> <4>[   17.354438]  ? pci_bridge_secondary_bus_reset+0x5d/0x70
> <4>[   17.354451]  pci_reset_bus+0x1d8/0x270
> <4>[   17.354461]  vmd_probe+0x778/0xa10
> <4>[   17.354474]  pci_device_probe+0x95/0x120
> <4>[   17.354484]  really_probe+0xd9/0x370
> <4>[   17.354496]  ? __pfx___driver_attach+0x10/0x10
> <4>[   17.354505]  __driver_probe_device+0x73/0x150
> <4>[   17.354516]  driver_probe_device+0x19/0xa0
> <4>[   17.354525]  __driver_attach+0xb6/0x180
> <4>[   17.354534]  ? __pfx___driver_attach+0x10/0x10
> <4>[   17.354544]  bus_for_each_dev+0x77/0xd0
> <4>[   17.354555]  bus_add_driver+0x110/0x240
> <4>[   17.354566]  driver_register+0x5b/0x110
> <4>[   17.354575]  ? __pfx_vmd_drv_init+0x10/0x10
> <4>[   17.354587]  do_one_initcall+0x5c/0x2b0
> <4>[   17.354600]  kernel_init_freeable+0x18e/0x340
> <4>[   17.354612]  ? __pfx_kernel_init+0x10/0x10
> <4>[   17.354623]  kernel_init+0x15/0x130
> <4>[   17.354631]  ret_from_fork+0x2c/0x50
> <4>[   17.354641]  ? __pfx_kernel_init+0x10/0x10
> <4>[   17.354650]  ret_from_fork_asm+0x1a/0x30
> <4>[   17.354663]  </TASK>
> <4>[   17.354669] irq event stamp: 28577685
> <4>[   17.354677] hardirqs last  enabled at (28577693): [<ffffffff8117c060>] console_unlock+0x110/0x120
> <4>[   17.354697] hardirqs last disabled at (28577700): [<ffffffff8117c045>] console_unlock+0xf5/0x120
> <4>[   17.354713] softirqs last  enabled at (28577176): [<ffffffff810df29c>] handle_softirqs+0x2ec/0x3f0
> <4>[   17.354731] softirqs last disabled at (28577167): [<ffffffff810dfa17>] irq_exit_rcu+0x87/0xc0
> <4>[   17.354747] ---[ end trace 0000000000000000 ]---
> 
> <4>[   17.487274] =====================================
> <4>[   17.487277] WARNING: bad unlock balance detected!
> <4>[   17.487279] 6.10.0-rc1-Patchwork_134112v1-gabaeae202dfb+ #1 Tainted: G        W
> <4>[   17.487282] -------------------------------------
> <4>[   17.487284] swapper/0/1 is trying to release lock (10000:e1:00.0) at:
> <4>[   17.487287] [<ffffffff8176b377>] pci_cfg_access_unlock+0x57/0x60
> <4>[   17.487292] but there are no more locks to release!
> <4>[   17.487294]
>                   other info that might help us debug this:
> <4>[   17.487297] 2 locks held by swapper/0/1:
> <4>[   17.487299]  #0: ffff888102c1c1b0 (&dev->mutex){....}-{3:3}, at: __driver_attach+0xab/0x180
> <4>[   17.487306]  #1: ffff8881056041b0 (&dev->mutex){....}-{3:3}, at: pci_dev_trylock+0x19/0x50
> <4>[   17.487312]
>                   stack backtrace:
> <4>[   17.487314] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.10.0-rc1-Patchwork_134112v1-gabaeae202dfb+ #1
> <4>[   17.487318] Hardware name: Intel Corporation Alder Lake Client Platform/AlderLake-P LP5 RVP, BIOS RPLPFWI1.R00.4035.A00.2301200723 01/20/2023
> <4>[   17.487322] Call Trace:
> <4>[   17.487324]  <TASK>
> <4>[   17.487325]  dump_stack_lvl+0x82/0xd0
> <4>[   17.487329]  lock_release+0x20b/0x2d0
> <4>[   17.487334]  pci_bus_unlock+0x25/0x40
> <4>[   17.487337]  pci_reset_bus+0x1eb/0x270
> <4>[   17.487340]  vmd_probe+0x778/0xa10
> <4>[   17.487344]  pci_device_probe+0x95/0x120
> <4>[   17.487346]  really_probe+0xd9/0x370
> <4>[   17.487349]  ? __pfx___driver_attach+0x10/0x10
> <4>[   17.487352]  __driver_probe_device+0x73/0x150
> <4>[   17.487354]  driver_probe_device+0x19/0xa0
> <4>[   17.487357]  __driver_attach+0xb6/0x180
> <4>[   17.487359]  ? __pfx___driver_attach+0x10/0x10
> <4>[   17.487362]  bus_for_each_dev+0x77/0xd0
> <4>[   17.487365]  bus_add_driver+0x110/0x240
> <4>[   17.487369]  driver_register+0x5b/0x110
> <4>[   17.487371]  ? __pfx_vmd_drv_init+0x10/0x10
> <4>[   17.487374]  do_one_initcall+0x5c/0x2b0
> <4>[   17.487378]  kernel_init_freeable+0x18e/0x340
> <4>[   17.487381]  ? __pfx_kernel_init+0x10/0x10
> <4>[   17.487384]  kernel_init+0x15/0x130
> <4>[   17.487387]  ret_from_fork+0x2c/0x50
> <4>[   17.487390]  ? __pfx_kernel_init+0x10/0x10
> <4>[   17.487392]  ret_from_fork_asm+0x1a/0x30
> <4>[   17.487396]  </TASK>
> 

