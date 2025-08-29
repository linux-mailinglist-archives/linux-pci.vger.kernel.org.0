Return-Path: <linux-pci+bounces-35070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0022AB3AEF5
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 02:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27FA1C86CDB
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 00:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCCA6F06B;
	Fri, 29 Aug 2025 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9AKl/IE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45240136658;
	Fri, 29 Aug 2025 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426063; cv=none; b=lE88BJfSnaG3hYQZTlxoS0qy4NabtBo9WzidfBqn60BI3/HqXQa0B8L8DU4gdvgMWQsWIHFBDj2it5q80LGQu93Qvb0QXt1WgEs3WEQ943Bci13qR+r/hjj3SQ0uO24zOh4GVAnQoIJ8kQ/UyIl30OeoQjpyGpN5+5wPrDJ7eh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426063; c=relaxed/simple;
	bh=Ty1/GL3r+/mWK4ebQ6EjoUwslnmZt54SiMHb8ZQhaOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2wjo9rXYy8BJgFkrBzUluaFFWzHEYaZ8rYCs811f9dNKGp1sWirs4JnYJZWOY5PFYSRMeYDdwxwt2um+OJVpujnR2ZQIkb0P3MwUagwOAGleb5DTU4GRzPt4hz58N9ktQxYYqlzsD7I0KICyp8AjBmhxTcwfAKMkl6nDWUuPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9AKl/IE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756426060; x=1787962060;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ty1/GL3r+/mWK4ebQ6EjoUwslnmZt54SiMHb8ZQhaOc=;
  b=O9AKl/IEsYpd/c7DR1ZRqsfpHREDnAMgHp0LjSIAsur2xFtLZz7MgY3n
   VD6w4PZSLJ1wxjYOaKBLHYsc/kfnfuiCwXvA1wTm5TuJFdHeOJq6W12n9
   +bFYCfMj17jIUpvLji+TKj+zRJJ9dHn5zWpymkfp5e6EN/HZdNDuhcAxU
   2soMey1GUPiSS6PB9v9DruhBhnQ+g2hybjh3W+qUogINpLYmsqOZfDfUW
   ALFLSC64zbPZU7TLXAix9aulI15RBOTojtc7Vir0nSxuVeArovQcDTJHF
   znGcU69NnLk9JXKo8J1PHcyoaddn5itrlWbTPRh6LDozbj1rSoDgiRidj
   Q==;
X-CSE-ConnectionGUID: l6dZU2ovTem8ziGxOI5D4Q==
X-CSE-MsgGUID: M5rnGMIXQCK+kRLjl4pXtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69305212"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69305212"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 17:07:39 -0700
X-CSE-ConnectionGUID: kQfOWqPgSUONTsC/uRNECA==
X-CSE-MsgGUID: RSuaPKTRRGCrzmSnvoiezQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="171039460"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.49]) ([10.247.118.49])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 17:07:27 -0700
Message-ID: <73c387b4-014d-41ca-9023-da1f38ce2d5e@intel.com>
Date: Thu, 28 Aug 2025 17:07:23 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] Enable CXL PCIe Port Protocol Error handling
 and logging
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 6:35 PM, Terry Bowman wrote:
> This patchset adds CXL Protocol Error handling for CXL Ports and updates CXL
> Endpoints (EP) handling. Previous versions of this series can be found here:
> https://lore.kernel.org/linux-cxl/20250626224252.1415009-1-terry.bowman@amd.com/
> 
> The first 6 patches reorganize protocol error related CXL code into new files.
> The first patch is authored by Dave Jiang and moves the CXL handling and logging into
> cxl/core/ras.c. Patch 5 and 6 move the AER driver's restricted CXL host (RCH) logic
> into pci/pcie/rch_aer.c. The RCH logic is used for CXL RCH devices from CXL1.1.
> CONFIG_PCIEAER_CXL is removed and replaced with CONFIG_CXL_RAS, defined in CXL
> Kconfig.
> 
> The next 4 patches introduce pcie_is_cxl() and use in the AER driver to detect and
> log the error type as PCIe error or CXL error.
> 
> The next 4 patches are error handler cleanup in preparation for upcoming error handler
> changes.
> 
> The next 7 patches introduce CXL Port error handling as well as updating the existing
> CXL Endpoint handling. This sets all CXL Ports and EPs to use similar handling and logging
> flow. Note, the PCIe EP handling remains for cases the EP is not recognized as a CXL
> device. These patches also include change to move the AER driver's CXL virtual hierarchy
> code into a new file named pci/pcie/cxl_aer.c. This separates the AER driver's CXL
> implementation from the AER driver's core file.
> 
> The final 2 patches enable/disable CXL protocol error interrupts during CXL port
> creation and teardown.
> 
> Note, I'll be on PTO until 9/10. Responses may be delayed.
> 
> ==== Testing ====
> 
> Below are the testing results while using QEMU. The QEMU testing uses a CXL Root
> Port, CXL Upstream Switch Port, CXL Downstream Switch Port and CXL Endpoint as
> given below. I've attached the QEMU startup commandline used.
> 
> The sub-topology for the QEMU testing is:
>                     ---------------------
>                     | CXL RP - 0C:00.0  |
>                     ---------------------
>                               |
>                     ---------------------
>                     | CXL USP - 0D:00.0 |
>                     ---------------------
>                               |
>                     ---------------------
>                     | CXL DSP - 0E:00.0 |
>                     ---------------------
>                               |
>                     ---------------------
>                     | CXL EP - 0F:00.0  |
>                     ---------------------
> 
>  root@tbowman-cxl:~# lspci -t
>  -+-[0000:00]- -00.0
>   |           +-01.0
>   |           +-02.0
>   |           +-03.0
>   |           +-1f.0
>   |           +-1f.2
>   |           \-1f.3
>   \-[0000:0c]---00.0-[0d-0f]----00.0-[0e-0f]----00.0-[0f]----00.0
> 
>  The topology was created with:
>   ${qemu} -boot menu=on \
>              -cpu host \
>              -nographic \
>              -monitor telnet:127.0.0.1:1234,server,nowait \
>              -M virt,cxl=on \
>              -chardev stdio,id=s1,signal=off,mux=on -serial none \
>              -device isa-serial,chardev=s1 -mon chardev=s1,mode=readline \
>              -machine q35,cxl=on \
>              -m 16G,maxmem=24G,slots=8 \
>              -cpu EPYC-v3 \
>              -smp 16 \
>              -accel kvm \
>              -drive file=${img},format=raw,index=0,media=disk \
>              -device e1000,netdev=user.0 \
>              -netdev user,id=user.0,hostfwd=tcp::5555-:22 \
>              -object memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
>              -object memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa0.raw,size=256M \
>              -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>              -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
>              -device cxl-upstream,bus=root_port0,id=us0 \
>              -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
>              -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-vmem0 \
>              -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> 
>  === Root Port ===
>  root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
>  pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
>  aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not availabl e
>  pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
>  pcieport 0000:0c:00.0:    [14] CorrIntErr
>  cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial=0: status: 'CRC Threshold Hit'  
> 
>  root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
>  aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not availabl e
>  pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
>  pcieport 0000:0c:00.0:    [22] UncorrIntErr
>  cxl_aer_uncorrectable_error: memdev=0000:0c:00.0 host=pci0000:0c serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
>  BUG: kernel NULL pointer dereference, address: 0000000000000008
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 10 UID: 0 PID: 216 Comm: kworker/10:1 Tainted: G            E       6.16.0-rc4-testing-00054-g263b76bedfed #1306 PREEMPT(voluntary)
>  Tainted: [E]=UNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  Workqueue: events cxl_proto_err_work_fn [cxl_core]
>  RIP: 0010:cxl_error_detected+0x18/0xd0 [cxl_core]
>  Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 56 41 55 41 54 55 48 89 fd 53 48 8b 5f 78 <4c> 8b 63 08 4d 8d b4 24 80 00 00 00 4c 89 f7 e8 e4 68 0a f6 be 0f
>  RSP: 0018:ffffd1870091fd58 EFLAGS: 00010282
>  RAX: 0000000000000007 RBX: 0000000000000000 RCX: 0000000000000003
>  RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8e0241c120c8
>  RBP: ffff8e0241c120c8 R08: 0000000000000284 R09: 0000000000000001
>  R10: 00000000ffffffff R11: 00cccccc00cccccc R12: ffff8e0241c12148
>  R13: ffff8e0241724f00 R14: 0000000000000000 R15: ffff8e0248571740
>  FS:  0000000000000000(0000) GS:ffff8e05f7ba5000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000008 CR3: 0000000113a8b000 CR4: 00000000003506f0
>  Call Trace:
>   <TASK>
>   cxl_report_error_detected+0x3e/0x70 [cxl_core]
>   cxl_walk_port.constprop.0+0xa4/0x140 [cxl_core]
>   cxl_proto_err_work_fn+0x1fa/0x430 [cxl_core]
>   ? srso_return_thunk+0x5/0x5f
>   process_scheduled_works+0xa8/0x420
>   ? __pfx_worker_thread+0x10/0x10
>   worker_thread+0x11c/0x260
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xfe/0x210
>   ? __pfx_kthread+0x10/0x10
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x18d/0x1e0
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Modules linked in: cfg80211(E) binfmt_misc(E) ppdev(E) intel_rapl_msr(E) cxl_mem(E) intel_rapl_common(E) cxl_pci(E) parport_pc(E) cxl_pmem(E) parport(E) input_leds(E) joydev(E) mac_hid(E) serio_raw(E) dm_m)
>  CR2: 0000000000000008
>  ---[ end trace 0000000000000000 ]---
>  RIP: 0010:cxl_error_detected+0x18/0xd0 [cxl_core]
>  Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 56 41 55 41 54 55 48 89 fd 53 48 8b 5f 78 <4c> 8b 63 08 4d 8d b4 24 80 00 00 00 4c 89 f7 e8 e4 68 0a f6 be 0f
>  RSP: 0018:ffffd1870091fd58 EFLAGS: 00010282
>  RAX: 0000000000000007 RBX: 0000000000000000 RCX: 0000000000000003
>  RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8e0241c120c8
>  RBP: ffff8e0241c120c8 R08: 0000000000000284 R09: 0000000000000001
>  R10: 00000000ffffffff R11: 00cccccc00cccccc R12: ffff8e0241c12148
>  R13: ffff8e0241724f00 R14: 0000000000000000 R15: ffff8e0248571740
>  FS:  0000000000000000(0000) GS:ffff8e05f7ba5000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000008 CR3: 0000000113a8b000 CR4: 00000000003506f0
>  note: kworker/10:1[216] exited with irqs disabled
> 
>  === Upstream Switch Port ===
>  root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
>  pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
>  aer_event: 0000:0d:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>  pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
>  pcieport 0000:0d:00.0:    [14] CorrIntErr
>  cxl_aer_correctable_error: memdev=0000:0d:00.0 host=0000:0c:00.0 serial=0: status: 'CRC Threshold Hit'
> 
>  root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
>  aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
>  pcieport 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
>  cxl_aer_uncorrectable_error: memdev=mem0 host=0000:0f:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
>  Kernel panic - not syncing: CXL cachemem error.
>  CPU: 10 UID: 0 PID: 147 Comm: irq/24-aerdrv Tainted: G            E       6.16.0-rc4-testing-00054-g263b76bedfed #1306 PREEMPT(voluntary)
>  Tainted: [E]=UNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  Call Trace:
>   <TASK>
>   panic+0x364/0x3d0
>   ? __pfx_aer_root_reset+0x10/0x10
>   pci_error_detected+0x2b/0x30 [cxl_core]
>   report_error_detected+0xf7/0x170
>   ? __pfx_report_frozen_detected+0x10/0x10
>   __pci_walk_bus+0x4c/0x70
>   ? __pfx_report_frozen_detected+0x10/0x10
>   __pci_walk_bus+0x34/0x70
>   ? __pfx_report_frozen_detected+0x10/0x10
>   __pci_walk_bus+0x34/0x70
>   ? __pfx_report_frozen_detected+0x10/0x10
>   pci_walk_bus+0x31/0x50
>   pcie_do_recovery+0x163/0x2b0
>   aer_isr_one_error_type+0x1f3/0x380
>   aer_isr_one_error+0x11d/0x140
>   aer_isr+0x4c/0x80
>   irq_thread_fn+0x24/0x70
>   irq_thread+0x199/0x2a0
>   ? __pfx_irq_thread_fn+0x10/0x10
>   ? __pfx_irq_thread_dtor+0x10/0x10
>   ? __pfx_irq_thread+0x10/0x10
>   kthread+0xfe/0x210
>   ? __pfx_kthread+0x10/0x10
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x18d/0x1e0
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Kernel Offset: 0x13400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>  ---[ end Kernel panic - not syncing: CXL cachemem error. ]---
> 
>  === Downstream Switch Port ===
>  root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
>  pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
>  aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>  pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
>  pcieport 0000:0e:00.0:    [14] CorrIntErr
>  cxl_aer_correctable_error: memdev=0000:0e:00.0 host=0000:0d:00.0 serial=0: status: 'CRC Threshold Hit'    
> 
>  root@tbowman-cxl:~/aer-inject# ./ds-uce-inject# ./ds-uce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
>  aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>  pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
>  pcieport 0000:0e:00.0:    [22] UncorrIntErr
>  cxl_aer_uncorrectable_error: memdev=0000:0d:00.0 host=0000:0c:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
>  BUG: kernel NULL pointer dereference, address: 0000000000000008
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 10 UID: 0 PID: 196 Comm: kworker/10:1 Tainted: G            E       6.16.0-rc4-testing-00054-g263b76bedfed #1306 PREEMPT(voluntary)
>  Tainted: [E]=UNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  Workqueue: events cxl_proto_err_work_fn [cxl_core]
>  RIP: 0010:cxl_error_detected+0x18/0xd0 [cxl_core]
>  Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 56 41 55 41 54 55 48 89 fd 53 48 8b 5f 78 <4c> 8b 63 08 4d 8d b4 24 80 00 00 00 4c 89 f7 e8 e4 68 aa d9 be 0f
>  RSP: 0018:ffffd1178086fd58 EFLAGS: 00010282
>  RAX: 0000000000000007 RBX: 0000000000000000 RCX: 0000000000000003
>  RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8a0201c510c8
>  RBP: ffff8a0201c510c8 R08: 000000000000028c R09: 0000000000000001
>  R10: 00000000ffffffff R11: 00cccccc00cccccc R12: ffff8a0201c51148
>  R13: ffff8a0201c56000 R14: ffff8a02011ed000 R15: ffff8a0201110000
>  FS:  0000000000000000(0000) GS:ffff8a05d3fa5000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000008 CR3: 0000000103574000 CR4: 00000000003506f0
>  Call Trace:
>   <TASK>
>   cxl_report_error_detected+0x3e/0x70 [cxl_core]
>   cxl_walk_port.constprop.0+0x12a/0x140 [cxl_core]
>   ? srso_return_thunk+0x5/0x5f
>   cxl_proto_err_work_fn+0x1fa/0x430 [cxl_core]
>   ? srso_return_thunk+0x5/0x5f
>   process_scheduled_works+0xa8/0x420
>   ? __pfx_worker_thread+0x10/0x10
>   worker_thread+0x11c/0x260
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xfe/0x210
>   ? __pfx_kthread+0x10/0x10
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x18d/0x1e0
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Modules linked in: cfg80211(E) binfmt_misc(E) intel_rapl_msr(E) intel_rapl_common(E) ppdev(E) cxl_mem(E) cxl_pmem(E) parport_pc(E) cxl_pci(E) parport(E) joydev(E) input_leds(E) mac_hid(E) serio_raw(E) dm_m)
>  CR2: 0000000000000008
>  ---[ end trace 0000000000000000 ]---
>  RIP: 0010:cxl_error_detected+0x18/0xd0 [cxl_core]
>  Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 56 41 55 41 54 55 48 89 fd 53 48 8b 5f 78 <4c> 8b 63 08 4d 8d b4 24 80 00 00 00 4c 89 f7 e8 e4 68 aa d9 be 0f
>  RSP: 0018:ffffd1178086fd58 EFLAGS: 00010282
>  RAX: 0000000000000007 RBX: 0000000000000000 RCX: 0000000000000003
>  RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8a0201c510c8
>  RBP: ffff8a0201c510c8 R08: 000000000000028c R09: 0000000000000001
>  R10: 00000000ffffffff R11: 00cccccc00cccccc R12: ffff8a0201c51148
>  R13: ffff8a0201c56000 R14: ffff8a02011ed000 R15: ffff8a0201110000
>  FS:  0000000000000000(0000) GS:ffff8a05d3fa5000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000008 CR3: 0000000103574000 CR4: 00000000003506f0
>  note: kworker/10:1[196] exited with irqs disabled
> 
>  === Endpoint ===
>  root@tbowman-cxl:~/aer-inject# ./ep-ce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0f:00.0
>  pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
>  aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>  cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>  cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/00000000
>  cxl_pci 0000:0f:00.0:    [14] CorrIntErr
>  cxl_aer_uncorrectable_error: memdev=mem0 host=0000:0f:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
> 
>  root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0f:00.0
>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
>  aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
>  cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
>  cxl_aer_uncorrectable_error: memdev=mem0 host=0000:0f:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
>  Kernel panic - not syncing: CXL cachemem error.
>  CPU: 10 UID: 0 PID: 148 Comm: irq/24-aerdrv Tainted: G            E       6.16.0-rc4-testing-00054-g263b76bedfed #1306 PREEMPT(voluntary)
>  Tainted: [E]=UNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  Call Trace:
>   <TASK>
>   panic+0x364/0x3d0
>   ? __pfx_aer_root_reset+0x10/0x10
>   pci_error_detected+0x2b/0x30 [cxl_core]
>   report_error_detected+0xf7/0x170
>   ? __pfx_report_frozen_detected+0x10/0x10
>   __pci_walk_bus+0x4c/0x70
>   ? __pfx_report_frozen_detected+0x10/0x10
>   pci_walk_bus+0x31/0x50
>   pcie_do_recovery+0x163/0x2b0
>   aer_isr_one_error_type+0x1f3/0x380
>   aer_isr_one_error+0x11d/0x140
>   aer_isr+0x4c/0x80
>   irq_thread_fn+0x24/0x70
>   irq_thread+0x199/0x2a0
>   ? __pfx_irq_thread_fn+0x10/0x10
>   ? __pfx_irq_thread_dtor+0x10/0x10
>   ? __pfx_irq_thread+0x10/0x10
>   kthread+0xfe/0x210
>   ? __pfx_kthread+0x10/0x10
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x18d/0x1e0
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Kernel Offset: 0xd600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>  ---[ end Kernel panic - not syncing: CXL cachemem error. ]---
> 
>  ==== Changes ====
>  Changes in v10 -> v11:
>  cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
>  - New patch
>  CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
>  - New patch
>  cxl/pci: Remove unnecessary CXL RCH handling helper functions
>  - New patch
>  cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS conditional block
>  - New patch
>  CXL/AER: Introduce rch_aer.c into AER driver for handling CXL RCH errors
>  - Remove changes in code-split and move to earlier, new patch
>  - Add #include <linux/bitfield.h> to cxl_ras.c
>  - Move cxl_rch_handle_error() & cxl_rch_enable_rcec() declarations from pci.h
>    to aer.h, more localized.
>  - Introduce CONFIG_CXL_RCH_RAS, includes Makefile changes, ras.c ifdef changes
>  CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
>  - New patch
>  PCI/CXL: Introduce pcie_is_cxl()
>  - Amended set_pcie_cxl() to check for Upstream Port's and EP's parent
>    downstream port by calling set_pcie_cxl(). (Dan)
>  - Retitle patch: 'Add' -> 'Introduce'
>  - Add check for CXL.mem and CXL.cache (Alejandro, Dan)
>  PCI/AER: Report CXL or PCIe bus error type in trace logging
>  - Remove duplicate call to trace_aer_event() (Shiju)
>  - Added Dan William's and Dave Jiang's reviewed-by
>  CXL/AER: Update PCI class code check to use FIELD_GET()
>  - Add #include <linux/bitfield.h> to cxl_ras.c (Terry)
>  - Removed line wrapping at "(CXL 3.2, 8.1.12.1)". (Jonathan)
>  cxl/pci: Log message if RAS registers are unmapped
>  - Added Dave Jiang's review-by (Terry)
>  cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
>  - Updated CE and UCE trace routines to maintian consistent TP_Struct ABI
>    and unchanged TP_printk() logging. (Shiju, Alison)
>  cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
>  - Added Dave Jiang and Jonathan Cameron's review-by
>  - Changes moved to core/ras.c
>  cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
>  - Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
>  - Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
>  - Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
>    and cxl_switch_port_init_ras() (Dave Jiang)
>  - Port helper changes were in cxl/port.c, now in core/ras.c (Dave Jiang)
>  cxl/pci: Introduce CXL Endpoint protocol error handlers
>  - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
>  - cxl_error_detected() - Remove extra line (Shiju)
>  - Changes moved to core/ras.c (Terry)
>  - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
>  - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
>  - Move #include "pci.h from cxl.h to core.h (Terry)
>  - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)   
>  CXL/AER: Introduce cxl_aer.c into AER driver for forwarding CXL errors
>  - Move RCH implementation to cxl_rch.c and RCH declarations to pci/pci.h. (Terry)
>  - Introduce 'struct cxl_proto_err_kfifo' containing semaphore, fifo,
>    and work struct. (Dan)
>  - Remove embedded struct from cxl_proto_err_work (Dan)
>  - Make 'struct work_struct *cxl_proto_err_work' definition static (Jonathan)
>  - Add check for NULL cxl_proto_err_kfifo to determine if CXL driver is
>    not registered for workqueue. (Dan)
>  PCI/AER: Dequeue forwarded CXL error
>  - Reword patch commit message to remove RCiEP details (Jonathan)
>  - Add #include <linux/bitfield.h> (Terry)
>  - is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
>  - is_cxl_rcd() - Combine return calls into 1  (Jonathan)
>  - cxl_handle_proto_error() - Move comment earlier  (Jonathan)
>  - Usse FIELD_GET() in discovering class code (Jonathan)
>  - Remove BDF from cxl_proto_err_work_data. Use 'struct pci_dev *' (Dan)
>  CXL/PCI: Introduce CXL Port protocol error handlers
>  - Removed check for PCI_EXP_TYPE_RC_END in cxl_report_error_detected() (Terry)
>  - Update is_cxl_error() to check for acceptable PCI EP and port types
>  CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
>  - pci_ers_merge_result() - Change export to non-namespace and rename
>    to be pci_ers_merge_result() (Jonathan)
>  - Move pci_ers_merge_result() definition to pci.h. Needs pci_ers_result (Terry)
>  CXL/PCI: Introduce CXL uncorrectable protocol error recovery
>  - pci_ers_merge_results() - Move to earlier patch
>  CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
>  - Remove guard() in cxl_mask_proto_interrupts(). Observed device lockup/block
>    during testing. (Terry)
>   
>  Changes in v9 -> v10:
>  - Add drivers/pci/pcie/cxl_aer.c
>  - Add drivers/cxl/core/native_ras.c
>  - Change cxl_register_prot_err_work()/cxl_unregister_prot_err_work to return void
>  - Check for pcie_ports_native in cxl_do_recovery()
>  - Remove debug logging in cxl_do_recovery()
>  - Update PCI_ERS_RESULT_PANIC definition to indicate is CXL specific
>  - Revert trace logging changes: name,parent -> memdev,host.
>  - Use FIELD_GET() to check for EP class code (cxl_aer.c & native_ras.c).
>  - Change _prot_ to _proto_ everywhere
>  - cxl_rch_handle_error_iter(), check if driver is cxl_pci_driver
>  - Remove cxl_create_prot_error_info(). Move logic into forward_cxl_error()
>  - Remove sbdf_to_pci() and move logic into cxl_handle_proto_error()
>  - Simplify/refactor get_pci_cxl_host_dev()
>  - Simplify/refactor cxl_get_ras_base()
>  - Move patch 'Remove unnecessary CXL Endpoint handling helper functions' to front
>  - Update description for 'CXL/PCI: Introduce CXL Port protocol error
>    handlers' with why state is not used to determine handling
>  - Introduce cxl_pci_drv_bound() and call from cxl_rch_handle_error_iter()
> 
>  Changes in v8 -> v9:
>  - Updated reference counting to use pci_get_device()/pci_put_device() in
>    cxl_disable_prot_errors()/cxl_enable_prot_errors
>  - Refactored cxl_create_prot_err_info() to fix reference counting
>  - Removed 'struct cxl_port' driver changes for error handler. Instead
>    check for CXL device type (EP or Port device) and call handler
>  - Make pcie_is_cxl() static inline in include/linux/linux.h
>  - Remove NULL check in create_prot_err_info()
>  - Change success return in cxl_ras_init() to use hardcoded 0
>  - Changed 'struct work_struct cxl_prot_err_work' declaration to static
>  - Change to use rate limited log with dev anchor in forward_cxl_error()
>  - Refactored forward-cxl_error() to remove severity auto variable
>  - Changed pci_aer_clear_nonfatal_status() to be static inline for
>    !(CONFIG_PCIEAER)
>  - Renamed merge_result() to be cxl_merge_result()
>  - Removed 'ue' condition in cxl_error_detected()
>  - Updated 2nd parameter in call to __cxl_handle_cor_ras()/__cxl_handle_ras()
>    in unify patch
>  - Added log message for failure while assigning interrupt disable callback
>  - Updated pci_aer_mask_internal_errors() to use pci_clear_and_set_config_dword()
>  - Simplified patch titles for clarity
>  - Moved CXL error interrupt disabling into cxl/core/port.c with CXL Port
>  teardown
>  - Updated 'struct cxl_port_err_info' to only contain sbdf and severity
>  Removed everything else.
>  - Added pdev and CXL device get_device()/put_device() before calling handlers
>  
>  Changes in v7 -> v8:
>  [Dan] Use kfifo. Move handling to CXL driver. AER forwards error to CXL
>  driver
>  [Dan] Add device reference incrementors where needed throughout
>  [Dan] Initiate CXL Port RAS init from Switch Port and Endpoint Port init 
>  [Dan] Combine CXL Port and CXL Endpoint trace routine
>  [Dan] Introduce aer_info::is_cxl. Use to indicate CXL or PCI errors
>  [Jonathan] Add serial number for all devices in trace
>  [DaveJ] Move find_cxl_port() change into patch using it
>  [Terry] Move CXL Port RAS init into cxl/port.c
>  [Terry] Moved kfifo functions into cxl/core/ras.c 
>  
>  Changes in v6 -> v7:
>  [Terry] Move updated trace routine call to later patch. Was causing build
>  error.
>  
>  Changes in v5 -> v6:
>  [Ira] Move pcie_is_cxl(dev) define to a inline function
>  [Ira] Update returning value from pcie_is_cxl_port() to bool w/o cast
>  [Ira] Change cxl_report_error_detected() cleanup to return correct bool
>  [Ira] Introduce and use PCI_ERS_RESULT_PANIC
>  [Ira] Reuse comment for PCIe and CXL recovery paths
>  [Jonathan] Add type check in for cxl_handle_cor_ras() and cxl_handle_ras()
>  [Jonathan] cxl_uport/dport_init_ras_reporting(), added a mutex.
>  [Jonathan] Add logging example to patches updating trace output
>  [Jonathan] Make parameter 'const' to eliminate for cast in match_uport()
>  [Jonathan] Use __free() in cxl_pci_port_ras()
>  [Terry] Add patch to log the PCIe SBDF along with CXL device name
>  [Terry] Add patch to handle CXL endpoint and RCH DP errors as CXL errors
>  [Terry] Remove patch w USP UCE fatal support @ aer_get_device_error_info()
>  [Terry] Rebase to cxl/next commit 5585e342e8d3 ("cxl/memdev: Remove unused partition values")
>  [Gregory] Pre-initialize pointer to NULL in cxl_pci_port_ras()
>  [Gregory] Move AER driver bus name detection to a static function
> 
>  Changes in v4 -> v5:
>  [Alejandro] Refactor cxl_walk_bridge to simplify 'status' variable usage
>  [Alejandro] Add WARN_ONCE() in __cxl_handle_ras() and cxl_handle_cor_ras()
>  [Ming] Remove unnecessary NULL check in cxl_pci_port_ras()
>  [Terry] Add failure check for call to to_cxl_port() in cxl_pci_port_ras()
>  [Ming] Use port->dev for call to devm_add_action_or_reset() in
>  cxl_dport_init_ras_reporting() and cxl_uport_init_ras_reporting()
>  [Jonathan] Use get_device()/put_device() to prevent race condition in
>  cxl_clear_port_error_handlers() and cxl_clear_port_error_handlers()
>  [Terry] Commit message cleanup. Capitalize keywords from CXL and PCI
>  specifications
> 
>  Changes in v3 -> v4:
>  [Lukas] Capitalize PCIe and CXL device names as in specifications
>  [Lukas] Move call to pcie_is_cxl() into cxl_port_devsec()
>  [Lukas] Correct namespace spelling
>  [Lukas] Removed export from pcie_is_cxl_port()
>  [Lukas] Simplify 'if' blocks in cxl_handle_error()
>  [Lukas] Change panic message to remove redundant 'panic' text
>  [Ming] Update to call cxl_dport_init_ras_reporting() in RCH case
>  [lkp@intel] 'host' parameter is already removed. Remove parameter description too.
>  [Terry] Added field description for cxl_err_handlers in pci.h comment block
> 
>  Changes in v1 -> v2:
>  [Jonathan] Remove extra NULL check and cleanup in cxl_pci_port_ras()
>  [Jonathan] Update description to DSP map patch description
>  [Jonathan] Update cxl_pci_port_ras() to check for NULL port
>  [Jonathan] Dont call handler before handler port changes are present (patch order)
>  [Bjorn] Fix linebreak in cover sheet URL
>  [Bjorn] Remove timestamps from test logs in cover sheet
>  [Bjorn] Retitle AER commits to use "PCI/AER:"
>  [Bjorn] Retitle patch#3 to use renaming instead of refactoring
>  [Bjorn] Fix base commit-id on cover sheet
>  [Bjorn] Add VH spec reference/citation
>  [Terry] Removed last 2 patches to enable internal errors. Is not needed
>  because internal errors are enabled in AER driver.
>  [Dan] Create cxl_do_recovery() and pci_driver::cxl_err_handlers.
>  [Dan] Use kernel panic in CXL recovery
>  [Dan] cxl_port_hndlrs -> cxl_port_error_handlers
> 
> 
> Dave Jiang (1):
>   cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
> 
> Terry Bowman (22):
>   CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
>   cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
>   cxl/pci: Remove unnecessary CXL RCH handling helper functions
>   cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS
>     conditional block
>   CXL/AER: Introduce rch_aer.c into AER driver for handling CXL RCH
>     errors
>   CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
>   PCI/CXL: Introduce pcie_is_cxl()
>   PCI/AER: Report CXL or PCIe bus error type in trace logging
>   CXL/AER: Update PCI class code check to use FIELD_GET()
>   cxl/pci: Update RAS handler interfaces to also support CXL Ports
>   cxl/pci: Log message if RAS registers are unmapped
>   cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
>   cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
>   cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
>   cxl/pci: Introduce CXL Endpoint protocol error handlers
>   CXL/AER: Introduce cxl_aer.c into AER driver for forwarding CXL errors
>   PCI/AER: Dequeue forwarded CXL error
>   CXL/PCI: Introduce CXL Port protocol error handlers
>   CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
>   CXL/PCI: Introduce CXL uncorrectable protocol error recovery
>   CXL/PCI: Enable CXL protocol errors during CXL Port probe
>   CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
> 
>  drivers/cxl/Kconfig           |  10 +
>  drivers/cxl/core/Makefile     |   2 +-
>  drivers/cxl/core/core.h       |  46 +++
>  drivers/cxl/core/pci.c        | 381 ++----------------
>  drivers/cxl/core/port.c       |  11 +-
>  drivers/cxl/core/ras.c        | 700 +++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/regs.c       |  12 +-
>  drivers/cxl/core/trace.h      |  68 +---
>  drivers/cxl/cxl.h             |  11 +-
>  drivers/cxl/cxlpci.h          |  56 ---
>  drivers/cxl/mem.c             |   6 +-
>  drivers/cxl/pci.c             |  11 +-
>  drivers/cxl/port.c            |   5 +
>  drivers/pci/pci.c             |  19 +-
>  drivers/pci/pci.h             |  31 +-
>  drivers/pci/pcie/Kconfig      |   9 -
>  drivers/pci/pcie/Makefile     |   2 +
>  drivers/pci/pcie/aer.c        | 164 +-------
>  drivers/pci/pcie/cxl_aer.c    | 144 +++++++
>  drivers/pci/pcie/err.c        |  14 +-
>  drivers/pci/pcie/rcec.c       |   1 +
>  drivers/pci/pcie/rch_aer.c    |  99 +++++
>  drivers/pci/probe.c           |  25 ++
>  include/linux/aer.h           |  29 ++
>  include/linux/pci.h           |  30 ++
>  include/ras/ras_event.h       |   9 +-
>  include/uapi/linux/pci_regs.h |  65 +++-
>  tools/testing/cxl/Kbuild      |   2 +-
>  28 files changed, 1286 insertions(+), 676 deletions(-)
>  create mode 100644 drivers/pci/pcie/cxl_aer.c
>  create mode 100644 drivers/pci/pcie/rch_aer.c
> 
> base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f

Hi Terry, this seems to be some version of cxl/next based on 6.16-rc4. Please rebase the code against linus upstream next time. Should've been a version of 6.17-rc. Thanks.

DJ
 
> --
> 2.51.0.rc2.21.ge5ab6b3e5a
> 


