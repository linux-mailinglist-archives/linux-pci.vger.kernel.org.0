Return-Path: <linux-pci+bounces-43111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 462ACCC20AA
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 11:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8925301F277
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3D932939B;
	Tue, 16 Dec 2025 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNd4ZHM7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C332D47ED;
	Tue, 16 Dec 2025 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882685; cv=none; b=luUII7rjFHkUT7/QMLHzZLtB1xzJ8SgeTvR5aXKLILXYMibF1VUlJK8cwIOZfbKEqshiNn9uI/Sw/VGajJBknIa6qRjZpszOl94+fGsKR9EGgpnvtBK+JMLwOnChHX6MksObnEZ+bNT1I3BxZNtehVaRf6GSGJZcIq6jzGNZfzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882685; c=relaxed/simple;
	bh=yitx9KrNMYRbnX2q+dZyRl9jZxh4Qie+gSSn0r8or1E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uk5o6HKwLVzuRpWPOaUwICjdBHt9/Rh4XScqF3QprX23YLukYLtFETKjHu49YeusWhwv0RCGMOubmHnVHAsKgW1mz2Vl8rYaPYYbjLZZNxTf2XeB/Zjp4iWr7wipNNY9CtGBWPyT+RkVUFdBjuIcgZrJzRkcczrVeUfFBP7J6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNd4ZHM7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765882683; x=1797418683;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yitx9KrNMYRbnX2q+dZyRl9jZxh4Qie+gSSn0r8or1E=;
  b=iNd4ZHM7DT2sBIhjGDnMTUlt5yVeEKAV+7agwU1V7kKRoiwX0QRAbDdp
   G4XVrQhGzlzqltuNbjbioYZ2zJA/D+oaUAGDoAivMSvgz5GLWzkRBH2uV
   C6498bgv1utgXn/etz+E+wqmhdK8CF2v9/aekhbdQ1yQnF/drEgA7Trcd
   QronUy5fQjEbD7W/7ZCduWKDz8yEWZOXKaQ2arpsKAyifhILG14JX4EQw
   TyugZ1pKxsYe8jN43qW4Mhb5QhcfG74xfRoJWMr9rutiPyQykJGfOhuG6
   6MnHX1JHW+NbnXYsCvGq/EdFY/nBL1X+gELPpivl8tp+SPLUDIhsqPK9L
   Q==;
X-CSE-ConnectionGUID: o+ATET2JSFOpgB558h549w==
X-CSE-MsgGUID: fua+3jChScGFWfRB44fw+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67736854"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67736854"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 02:57:45 -0800
X-CSE-ConnectionGUID: EBcy7O3uTMa+iV1f1Ydxlw==
X-CSE-MsgGUID: ZAvpDHK9Q+uV8Pe21LcDvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="197971207"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.4])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 02:57:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Dec 2025 12:57:38 +0200 (EET)
To: Ziming Du <duziming2@huawei.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, chrisw@redhat.com, 
    jbarnes@virtuousgeek.org, alex.williamson@redhat.com, 
    liuyongqiang13@huawei.com
Subject: Re: [PATCH 3/3] PCI: Prevent overflow in proc_bus_pci_write()
In-Reply-To: <20251216083912.758219-4-duziming2@huawei.com>
Message-ID: <47ccdb75-7134-b86a-e8bb-eebb9f1e0b47@linux.intel.com>
References: <20251216083912.758219-1-duziming2@huawei.com> <20251216083912.758219-4-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Dec 2025, Ziming Du wrote:

> When the value of ppos over the INT_MAX, the pos will be

is over

> set a negtive value which will be pass to get_user() or

set to a negative value which will be passed

> pci_user_write_config_dword(). And unexpected behavior

Please start the sentence with something else than And.

Hmm, the lines look rather short too, can you please reflow the changelog 
paragraphs to 75 characters.

> such as a softlock happens:
> 
>  watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
>  Modules linked in:
>  CPU: 0 PID: 3444 Comm: syz.3.109 Not tainted 6.6.0+ #33
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
>  Code: cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 e8 52 12 00 00 90 fb 65 ff 0d b1 a1 86 6d <74> 05 e9 42 52 00 00 0f 1f 44 00 00 c3 cc cc cc cc 0f 1f 84 00 00
>  RSP: 0018:ffff88816851fb50 EFLAGS: 00000246
>  RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff927daf9b
>  RDX: 0000000000000cfc RSI: 0000000000000046 RDI: ffffffff9a7c7400
>  RBP: 00000000818bb9dc R08: 0000000000000001 R09: ffffed102d0a3f59
>  R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
>  R13: ffff888102220000 R14: ffffffff926d3b10 R15: 00000000210bbb5f
>  FS:  00007ff2d4e56640(0000) GS:ffff8881f5c00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00000000210bbb5b CR3: 0000000147374002 CR4: 0000000000772ef0
>  PKRU: 00000000
>  Call Trace:
>   <TASK>
>   pci_user_write_config_dword+0x126/0x1f0
>   ? __get_user_nocheck_8+0x20/0x20
>   proc_bus_pci_write+0x273/0x470
>   proc_reg_write+0x1b6/0x280
>   do_iter_write+0x48e/0x790
>   ? import_iovec+0x47/0x90
>   vfs_writev+0x125/0x4a0
>   ? futex_wake+0xed/0x500
>   ? __pfx_vfs_writev+0x10/0x10
>   ? userfaultfd_ioctl+0x131/0x1ae0
>   ? userfaultfd_ioctl+0x131/0x1ae0
>   ? do_futex+0x17e/0x220
>   ? __pfx_do_futex+0x10/0x10
>   ? __fget_files+0x193/0x2b0
>   __x64_sys_pwritev+0x1e2/0x2a0
>   ? __pfx___x64_sys_pwritev+0x10/0x10
>   do_syscall_64+0x59/0x110
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2

Could you please trim the dump so it only contains things relevant to this 
issue () (also check trimming in the other patches).

> Fix this by use unsigned int for the pos.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Ziming Du <duziming2@huawei.com>
> ---
>  drivers/pci/proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 9348a0fb8084..dbec1d4209c9 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -113,7 +113,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  {
>  	struct inode *ino = file_inode(file);
>  	struct pci_dev *dev = pde_data(ino);
> -	int pos = *ppos;
> +	unsigned int pos = *ppos;
>  	int size = dev->cfg_size;
>  	int cnt, ret;

So this still throws away some bits compared with the original ppos ?

-- 
 i.


