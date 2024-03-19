Return-Path: <linux-pci+bounces-4894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ECC87FD3F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 13:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFE71F227B8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 12:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D05C7FBB7;
	Tue, 19 Mar 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RL2nhDCb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8047EF1F
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849584; cv=none; b=YY75lBYAUvDfgjtOTHzR3iirjeQdLNB/XNRUUhauPZ+Q6C/l08DnzFuap41i1BpDHqhLWmU/Z7Ejct7XTBLGCNOXgPsQ8Xwh4KLm22UpYVrdsPAXN21JNfocThkzKshhOvbr6eu2YaiaPUp8v6Pr4RD6lqbplgY8d0r0eXYX/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849584; c=relaxed/simple;
	bh=nV/CUv0Q2iqScleIZcKdlzfNZTyky5RIcqpS5P1mk8M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uJTpGJyj3hu97G13B396KUsI15OS3BKgCwhWwZWarJFtsaBFE62LKwZHg9/Dwpg0RZ7vhXyubkDUJpVVNAFxOjow4IZhHvUIb497ofy5kRGZoYkmicW5p3QWV7HKy5v8WYatJyplPE4L0mD9GG6dhf5xlM5FizU+UbzbCXjNf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RL2nhDCb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710849582; x=1742385582;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nV/CUv0Q2iqScleIZcKdlzfNZTyky5RIcqpS5P1mk8M=;
  b=RL2nhDCbD0dy70xJBWHzPTpgU7cTrJpFWCpqKIMF/1YdMAMPZBDTWzXR
   +mgVDhR8QIQUN9XZgM5gQ6tUbQfVFiPRfyxW6DB7thPyYqey4BEX6NOgQ
   nf5szGBQmTk9W247E6+Slc4F8IQmB4d3wjlT20LikTG3WyxHSqE9fgzfp
   wqJE1rISJJ3UkB140hObCJ7ICRolynX29GHF+9+1nqkSq9BBvBAXSr7v5
   Ep/2QioeBAseQ4bAO5k5Eef5aLFPeVML4TmVu4hNvfOzI2cqfg2N9ga8i
   f6VJrTscJwOUyKWUQf8JepLN+1qEqatMg4dy51ScM4iVqjchPLYAbAjFe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5579538"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5579538"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 04:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="14173444"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.12])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 04:59:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 19 Mar 2024 13:59:34 +0200 (EET)
To: Changhui Zhong <czhong@redhat.com>, Baoquan He <bhe@redhat.com>
cc: linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
    Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [bug report] WARNING: CPU: 0 PID: 1 at kernel/resource.c:834
 __insert_resource+0x84/0x110
In-Reply-To: <CAGVVp+U+s692sC8-ioGQ7aP2shhQ6qyGOThVk=L6P4_XovDo5Q@mail.gmail.com>
Message-ID: <73a510c8-51a0-4a4a-1aa8-7bdcd4cdde22@linux.intel.com>
References: <CAGVVp+U+s692sC8-ioGQ7aP2shhQ6qyGOThVk=L6P4_XovDo5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 19 Mar 2024, Changhui Zhong wrote:

> Hello,
> 
> found a kernel warning issue at "kernel/resource.c:834
> __insert_resource+0x84/0x110" ,please help check,
> 
> repo:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> branch: master
> commit HEAD:f6cef5f8c37f58a3bc95b3754c3ae98e086631ca
> 
>  [    0.130164] ------------[ cut here ]------------
> [    0.130370] WARNING: CPU: 0 PID: 1 at kernel/resource.c:834
> __insert_resource+0x84/0x110
> [    0.131364] Modules linked in:
> [    0.132364] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0+ #1
> [    0.133365] Hardware name: Dell Inc. PowerEdge R640/06DKY5, BIOS
> 2.15.1 06/15/2022
> [    0.134364] RIP: 0010:__insert_resource+0x84/0x110
> [    0.135364] Code: d0 4c 39 c1 76 b1 c3 cc cc cc cc 4c 8d 4a 30 48
> 8b 52 30 48 85 d2 75 b7 48 89 56 30 49 89 31 48 89 46 28 31 c0 c3 cc
> cc cc cc <0f> 0b 48 89 d0 c3 cc cc cc cc 49 89 d2 eb 1a 4d 39 42 08 77
> 19 4d
> [    0.136363] RSP: 0000:ffffb257400dfe08 EFLAGS: 00010246
> [    0.137363] RAX: ffff9e147ffca640 RBX: 0000000000000000 RCX: 0000000026000000
> [    0.138363] RDX: ffffffff86c45ee0 RSI: ffffffff86c45ee0 RDI: 0000000026000000
> [    0.139363] RBP: ffffffff8684d120 R08: 0000000035ffffff R09: 0000000035ffffff
> [    0.140363] R10: 000000002f31646f R11: 0000000059a7ffee R12: ffffffff86c45ee0
> [    0.141363] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [    0.142363] FS:  0000000000000000(0000) GS:ffff9e1277800000(0000)
> knlGS:0000000000000000
> [    0.143363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.144363] CR2: ffff9e1333601000 CR3: 0000000332220001 CR4: 00000000007706f0
> [    0.145363] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    0.146363] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    0.147363] PKRU: 55555554
> [    0.148363] Call Trace:
> [    0.149364]  <TASK>
> [    0.150365]  ? __warn+0x7f/0x130
> [    0.151363]  ? __insert_resource+0x84/0x110
> [    0.152364]  ? report_bug+0x18a/0x1a0
> [    0.153364]  ? handle_bug+0x3c/0x70
> [    0.154363]  ? exc_invalid_op+0x14/0x70
> [    0.155363]  ? asm_exc_invalid_op+0x16/0x20
> [    0.156364]  ? __insert_resource+0x84/0x110
> [    0.157364]  ? add_device_randomness+0x75/0xa0
> [    0.158363]  insert_resource+0x26/0x50
> [    0.159364]  ? __pfx_insert_crashkernel_resources+0x10/0x10
> [    0.160363]  insert_crashkernel_resources+0x62/0x70

Hi,

This seems related to crashkernel stuff, I added a few Ccs related to 
it.

I don't know why you sent this only to linux-pci list as it seems likely 
to be entirely unrelated to PCI.

-- 
 i.

> [    0.161365]  do_one_initcall+0x41/0x300
> [    0.162364]  kernel_init_freeable+0x21e/0x320
> [    0.163365]  ? __pfx_kernel_init+0x10/0x10
> [    0.164364]  kernel_init+0x16/0x1c0
> [    0.165364]  ret_from_fork+0x2d/0x50
> [    0.166364]  ? __pfx_kernel_init+0x10/0x10
> [    0.167363]  ret_from_fork_asm+0x1a/0x30
> [    0.168365]  </TASK>
> [    0.169363] ---[ end trace 0000000000000000 ]---
> 
> Thanks,
> 
> 

