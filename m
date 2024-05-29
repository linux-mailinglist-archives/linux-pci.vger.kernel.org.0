Return-Path: <linux-pci+bounces-8039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7C78D3BE9
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC94B26785
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF401156C61;
	Wed, 29 May 2024 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+0Jk4+d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2AB14291E
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998925; cv=none; b=a2GusNibJZ/Qx8c2kifMD36vScKb6+bCis/7yhg5hMIZ4nYgF5JlQbAQ3G6sHyc+HpTh2k1UZ3QoULp0veVdDpiYqljCaRXrpaYfcMcRFi/BMlmBjrwYmUoEuh3wzmzXwJcyB4/p/r8J2oc4NUMSxmSneCeIqSO2lrgv8mJymAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998925; c=relaxed/simple;
	bh=RQwgnuRk9YsciTsfJitZxkeOhlFD+3h+F1e3GdYqh9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=my4GwpCydG++W9f0Wkg3veuZU7CHcGQi6GRd7rB/L3r7mEsn2ZAD5BNxzdEKV6639m47ISspfkExQQnRhM3oGHTHZmMmJ+Md3wBmFacDvq8Xfhsvcnbn12obH6Rq6cQv1eAQeXAgScG2aPV4CO3CmgR/YTQFUFSSolIEHfmsB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+0Jk4+d; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716998924; x=1748534924;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RQwgnuRk9YsciTsfJitZxkeOhlFD+3h+F1e3GdYqh9U=;
  b=A+0Jk4+dMdyrJV2sZXkZG7BNl6oYJ+t/+0nzEcn/4LQurUcVlMzyDIOY
   1pllgZmK2nVKo8fKj+n/W57JZ0Z/U7tL3/j3mgTU9OQrUIHZ0ewG0hB29
   DNfn5LzGkdvvQ3dlBccyrFqFIq4MWWmXr6Atp81n7Mhf4lSMOVQaoHSr+
   tvtgjsvAAJSLBTsWryOafrr7In6lXnA6WBs6vU81CzQDAxS00igP+KWlx
   H5M0VkDV3v1CwQQ0MPse9Yji8YaWBQ2G4waUEB9+VmXAjhBuWSQWkuyM/
   XJ+fu0Z2BZKaH9s64cqmhF1FE7ro3yKMCEKrfHLyFUjW/bj93TvLTeCEZ
   A==;
X-CSE-ConnectionGUID: KvDlTRt4Qp6HJbVFt5mhXA==
X-CSE-MsgGUID: VSQV9rteRIm+1hdkJqz0Cg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24832194"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="24832194"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:08:35 -0700
X-CSE-ConnectionGUID: sLPfa7oyRcSghj0XlHhsMA==
X-CSE-MsgGUID: bp4+mPFKRSiVKvCQqp5njw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35450841"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.117]) ([10.125.111.117])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:08:34 -0700
Message-ID: <5fbf60dd-4ad1-43f1-a3e5-451e9481883e@intel.com>
Date: Wed, 29 May 2024 09:08:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Lockdep annotation introduced warn in VMD driver
To: "Saarinen, Jani" <jani.saarinen@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>, "Deak, Imre"
 <imre.deak@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
Cc: =?UTF-8?B?5p2OLCDmmJ/ovok=?= <korantli@tencent.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
References: <ZlXP5oTnSApiDbD1@ideak-desk.fi.intel.com>
 <20240528155228.00005850@linux.intel.com> <877cfdkpom.fsf@intel.com>
 <DM8PR11MB565579189DD400BACDF5493CE0F22@DM8PR11MB5655.namprd11.prod.outlook.com>
 <DM8PR11MB5655FA22F73644AD0520EC16E0F22@DM8PR11MB5655.namprd11.prod.outlook.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <DM8PR11MB5655FA22F73644AD0520EC16E0F22@DM8PR11MB5655.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/29/24 8:36 AM, Saarinen, Jani wrote:
> Hi, 
>> -----Original Message-----
>> From: Saarinen, Jani
>> Sent: Wednesday, 29 May 2024 16.49
>> To: Jani Nikula <jani.nikula@linux.intel.com>; Nirmal Patel
>> <nirmal.patel@linux.intel.com>; Deak, Imre <imre.deak@intel.com>; Jiang,
>> Dave <dave.jiang@intel.com>
>> Cc: 李, 星辉 <korantli@tencent.com>; Jonathan Derrick
>> <jonathan.derrick@linux.dev>; Bjorn Helgaas <bhelgaas@google.com>; linux-
>> pci@vger.kernel.org; intel-gfx@lists.freedesktop.org
>> Subject: RE: Lockdep annotation introduced warn in VMD driver
>>
>> Hi,
>>
>>> -----Original Message-----
>>> From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf Of Jani
>>> Nikula
>>> Sent: Wednesday, 29 May 2024 11.06
>>> To: Nirmal Patel <nirmal.patel@linux.intel.com>; Deak, Imre
>>> <imre.deak@intel.com>
>>> Cc: Jiang, Dave <dave.jiang@intel.com>; 李, 星辉 <korantli@tencent.com>;
>>> Jonathan Derrick <jonathan.derrick@linux.dev>; Bjorn Helgaas
>>> <bhelgaas@google.com>; linux-pci@vger.kernel.org; intel-
>>> gfx@lists.freedesktop.org
>>> Subject: Re: Lockdep annotation introduced warn in VMD driver
>>>
>>> On Tue, 28 May 2024, Nirmal Patel <nirmal.patel@linux.intel.com> wrote:
>>>> On Tue, 28 May 2024 15:36:54 +0300
>>>> Imre Deak <imre.deak@intel.com> wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> commit 7e89efc6e9e402839643cb297bab14055c547f07
>>>>> Author: Dave Jiang <dave.jiang@intel.com>
>>>>> Date:   Thu May 2 09:57:31 2024 -0700
>>>>>
>>>>>     PCI: Lock upstream bridge for pci_reset_function()
>>>>>
>>>>> introduced the WARN below in the VMD driver, see [1] for the full log.
>>>>> Not sure if the annotation is incorrect or the VMD driver is missing
>>>>> the lock, CC'ing VMD folks.
>>>>>
>>>>> --Imre
>>>> Can you please provide repro steps and some background on the setup?
>>>
>>> Hardware name: Intel Corporation Alder Lake Client Platform/AlderLake-P
>>> LP5 RVP.
>>>
>>> Kconfig: https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_14842/kconfig.txt
>>>
>>> Just booting with the above commit is enough.
>> It seems fix do not fix as seen on
>> https://patchwork.freedesktop.org/series/134183/
>> => https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134183v1/index.html?
>> See those red not where both are red stil and also both dmesg (boot.log) look
>> still identical.
>> So eg:
>> base build:   https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_14846/bat-dg2-
>> 13/boot0.txt
>> pw patches: https://intel-gfx-ci.01.org/tree/drm-
>> tip/Patchwork_134183v1/bat-dg2-13/boot0.txt
>>
>> Dave, thoughts?
> Also Imre tried with 2 PCI patches together https://patchwork.freedesktop.org/series/134193/ 
> And still not good for those 4 systems (mtlp-9, bat-dg2-13/14 and bat-adlp-11) : https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_134193v1/index.html? 
> Dave, Dan, thoughts? 

Can you provide the dmesg from the failure system with the 2 patches applied please?

> 
> Br,
> Jani
>>
>>
>> Br,
>> Jani
>>
>>> BR,
>>> Jani.
>>>
>>>>
>>>> -nirmal
>>>>>
>>>>> https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134112v1/bat-adlp-
>>>>> 11/boot0.txt
>>>>>
>>>>> <4>[   17.354071] WARNING: CPU: 0 PID: 1 at drivers/pci/pci.c:4886
>>>>> pci_bridge_secondary_bus_reset+0x5d/0x70 <4>[   17.354095] Modules
>>>>> linked in: <4>[   17.354104] CPU: 0 PID: 1 Comm: swapper/0 Not
>>>>> tainted 6.10.0-rc1-Patchwork_134112v1-gabaeae202dfb+ #1 <4>[
>>>>> 17.354128] Hardware name: Intel Corporation Alder Lake Client
>>>>> Platform/AlderLake-P LP5 RVP, BIOS
>> RPLPFWI1.R00.4035.A00.2301200723
>>>>> 01/20/2023 <4>[   17.354153] RIP:
>>>>> 0010:pci_bridge_secondary_bus_reset+0x5d/0x70 <4>[   17.354167]
>>> Code:
>>>>> c3 cc cc cc cc 48 89 ef 48 c7 c6 78 55 44 82 5d e9 d8 c6 ff ff 48 8d
>>>>> bf 48 08 00 00 be ff ff ff ff e8 97 10 5f 00 85 c0 75 b5 <0f> 0b eb
>>>>> b1 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 <4>[
>>>>> 17.354199] RSP: 0000:ffffc90000097ca0 EFLAGS: 00010246 <4>[
>>>>> 17.354210] RAX: 0000000000000000 RBX: ffff888105604000 RCX:
>>>>> 0000000000000000 <4>[   17.354224] RDX: 0000000080000000 RSI:
>>>>> ffffffff82421c40 RDI: ffffffff82441c4c <4>[   17.354238] RBP:
>>>>> ffff888105601000 R08: 0000000000000001 R09: 0000000000000000
>> <4>[
>>>>> 17.354251] R10: 0000000000000001 R11: ffff8881008c8040 R12:
>>>>> 0000000000000000 <4>[   17.354264] R13: 0000000000000020 R14:
>>>>> 000000000000007f R15: ffff888105615c28 <4>[   17.354283] FS:
>>>>> 0000000000000000(0000) GS:ffff8882a6e00000(0000)
>>>>> knlGS:0000000000000000 <4>[   17.354313] CS:  0010 DS: 0000 ES: 0000
>>>>> CR0: 0000000080050033 <4>[   17.354334] CR2: ffff8882afbff000 CR3:
>>>>> 000000000663a000 CR4: 0000000000f50ef0 <4>[   17.354348] PKRU:
>>>>> 55555554 <4>[   17.354355] Call Trace: <4>[   17.354361]  <TASK> <4>[
>>>>>   17.354367]  ? __warn+0x8c/0x190 <4>[   17.354380]  ?
>>>>> pci_bridge_secondary_bus_reset+0x5d/0x70 <4>[   17.354392]  ?
>>>>> report_bug+0x1f8/0x200 <4>[   17.354405]  ? handle_bug+0x3c/0x70
>> <4>[
>>>>>   17.354415]  ? exc_invalid_op+0x18/0x70 <4>[   17.354424]  ?
>>>>> asm_exc_invalid_op+0x1a/0x20 <4>[   17.354438]  ?
>>>>> pci_bridge_secondary_bus_reset+0x5d/0x70 <4>[   17.354451]
>>>>> pci_reset_bus+0x1d8/0x270 <4>[   17.354461]
>> vmd_probe+0x778/0xa10
>>>>> <4>[   17.354474]  pci_device_probe+0x95/0x120 <4>[   17.354484]
>>>>> really_probe+0xd9/0x370 <4>[   17.354496]  ?
>>>>> __pfx___driver_attach+0x10/0x10 <4>[   17.354505]
>>>>> __driver_probe_device+0x73/0x150 <4>[   17.354516]
>>>>> driver_probe_device+0x19/0xa0 <4>[   17.354525]
>>>>> __driver_attach+0xb6/0x180 <4>[   17.354534]  ?
>>>>> __pfx___driver_attach+0x10/0x10 <4>[   17.354544]
>>>>> bus_for_each_dev+0x77/0xd0 <4>[   17.354555]
>>>>> bus_add_driver+0x110/0x240 <4>[   17.354566]
>>>>> driver_register+0x5b/0x110 <4>[   17.354575]  ?
>>>>> __pfx_vmd_drv_init+0x10/0x10 <4>[   17.354587]
>>>>> do_one_initcall+0x5c/0x2b0 <4>[   17.354600]
>>>>> kernel_init_freeable+0x18e/0x340 <4>[   17.354612]  ?
>>>>> __pfx_kernel_init+0x10/0x10 <4>[   17.354623]  kernel_init+0x15/0x130
>>>>> <4>[   17.354631]  ret_from_fork+0x2c/0x50 <4>[   17.354641]  ?
>>>>> __pfx_kernel_init+0x10/0x10 <4>[   17.354650]
>>>>> ret_from_fork_asm+0x1a/0x30 <4>[   17.354663]  </TASK> <4>[
>>>>> 17.354669] irq event stamp: 28577685 <4>[   17.354677] hardirqs last
>>>>> enabled at (28577693): [<ffffffff8117c060>]
>>>>> console_unlock+0x110/0x120 <4>[   17.354697] hardirqs last disabled
>>>>> at (28577700): [<ffffffff8117c045>] console_unlock+0xf5/0x120 <4>[
>>>>> 17.354713] softirqs last  enabled at (28577176): [<ffffffff810df29c>]
>>>>> handle_softirqs+0x2ec/0x3f0 <4>[   17.354731] softirqs last disabled
>>>>> at (28577167): [<ffffffff810dfa17>] irq_exit_rcu+0x87/0xc0 <4>[
>>>>> 17.354747] ---[ end trace 0000000000000000 ]---
>>>>>
>>>>> <4>[   17.487274] =====================================
>>>>> <4>[   17.487277] WARNING: bad unlock balance detected!
>>>>> <4>[   17.487279] 6.10.0-rc1-Patchwork_134112v1-gabaeae202dfb+ #1
>>>>> Tainted: G        W <4>[   17.487282]
>>>>> ------------------------------------- <4>[   17.487284] swapper/0/1
>>>>> is trying to release lock (10000:e1:00.0) at: <4>[   17.487287]
>>>>> [<ffffffff8176b377>] pci_cfg_access_unlock+0x57/0x60 <4>[
>>>>> 17.487292] but there are no more locks to release! <4>[   17.487294]
>>>>>                   other info that might help us debug this:
>>>>> <4>[   17.487297] 2 locks held by swapper/0/1:
>>>>> <4>[   17.487299]  #0: ffff888102c1c1b0 (&dev->mutex){....}-{3:3},
>>>>> at: __driver_attach+0xab/0x180 <4>[   17.487306]  #1:
>>>>> ffff8881056041b0 (&dev->mutex){....}-{3:3}, at:
>>>>> pci_dev_trylock+0x19/0x50 <4>[   17.487312] stack backtrace:
>>>>> <4>[   17.487314] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
>>>>>        6.10.0-rc1-Patchwork_134112v1-gabaeae202dfb+ #1 <4>[
>>>>> 17.487318] Hardware name: Intel Corporation Alder Lake Client
>>>>> Platform/AlderLake-P LP5 RVP, BIOS
>> RPLPFWI1.R00.4035.A00.2301200723
>>>>> 01/20/2023 <4>[   17.487322] Call Trace: <4>[   17.487324]  <TASK>
>>>>> <4>[   17.487325]  dump_stack_lvl+0x82/0xd0 <4>[   17.487329]
>>>>> lock_release+0x20b/0x2d0 <4>[   17.487334]
>> pci_bus_unlock+0x25/0x40
>>>>> <4>[   17.487337]  pci_reset_bus+0x1eb/0x270
>>>>> <4>[   17.487340]  vmd_probe+0x778/0xa10
>>>>> <4>[   17.487344]  pci_device_probe+0x95/0x120
>>>>> <4>[   17.487346]  really_probe+0xd9/0x370
>>>>> <4>[   17.487349]  ? __pfx___driver_attach+0x10/0x10
>>>>> <4>[   17.487352]  __driver_probe_device+0x73/0x150
>>>>> <4>[   17.487354]  driver_probe_device+0x19/0xa0
>>>>> <4>[   17.487357]  __driver_attach+0xb6/0x180
>>>>> <4>[   17.487359]  ? __pfx___driver_attach+0x10/0x10
>>>>> <4>[   17.487362]  bus_for_each_dev+0x77/0xd0
>>>>> <4>[   17.487365]  bus_add_driver+0x110/0x240
>>>>> <4>[   17.487369]  driver_register+0x5b/0x110
>>>>> <4>[   17.487371]  ? __pfx_vmd_drv_init+0x10/0x10
>>>>> <4>[   17.487374]  do_one_initcall+0x5c/0x2b0
>>>>> <4>[   17.487378]  kernel_init_freeable+0x18e/0x340
>>>>> <4>[   17.487381]  ? __pfx_kernel_init+0x10/0x10
>>>>> <4>[   17.487384]  kernel_init+0x15/0x130
>>>>> <4>[   17.487387]  ret_from_fork+0x2c/0x50
>>>>> <4>[   17.487390]  ? __pfx_kernel_init+0x10/0x10
>>>>> <4>[   17.487392]  ret_from_fork_asm+0x1a/0x30
>>>>> <4>[   17.487396]  </TASK>
>>>>>
>>>>
>>>
>>> --
>>> Jani Nikula, Intel

