Return-Path: <linux-pci+bounces-43787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BA9CE64E6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 10:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B14E301E580
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 09:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DDD27F736;
	Mon, 29 Dec 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bok0K2Cg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7B24E4B4;
	Mon, 29 Dec 2025 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001017; cv=none; b=HONOHaOh6BQWUTOE6fKmxbg/Vmf0Vb8t8LQg4am/znhaIzmIFN6sX8Kt54qby54GU0lwnGBK/JbJxODth17uu+FYnA9wfQsSPPwHJcgqnt/1Wjlr4wy45ACL6tYX3m/BKQWuv8Q8D2yGLghVYxGtY0gMvSH7om7pjidB0Y8ueiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001017; c=relaxed/simple;
	bh=G26w5y81bitdkx/92kUm5dnITLIlraf55+6lODGNMUg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IBCl/Kv+Pacm/vCo+rtO4ZFJKmnSGbeIq8DaMRHZ+0uqc7l0r77ylin9xjMRSNqSBFbpVQ9e3iu2QwIOgdLsOSyLrJ7D3sEntH4siBFC5fy/b9EBJ7/W8ARq8168YhwErUR71SFSrFpqCaq3nKv5j8zwoZ6+/gbJjASBc9/tSHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bok0K2Cg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767001015; x=1798537015;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=G26w5y81bitdkx/92kUm5dnITLIlraf55+6lODGNMUg=;
  b=bok0K2CgUr6r9HpIOq4ABPQ/x2MxKKDyHgQgosaJDFZRJduJVhNwRDDV
   WaHsmsqqZLrIEMl5SwdCDjOr/l/0cmyRfGm52QwktZrMeINCstQuLSlOg
   goQ+hJEf8lc9oXAXbppAJYs0TO9iX1atjJC7kMNljHcSCvxskDPmvnYp/
   83vaVXu1QARQ6ptGessurHgRLpFtrQBmZXAeL3Cyt1DgxYXFoke+FaqIJ
   DQgqpxYxGQJyupvxR4ds8XPQM4V2NaGgw2TldpQzmDLL1yDD6Un8AJ7fo
   q6niStVb75Bo4dG4vejGRRPf/b+W/91uOe1u8yJlVEhBDVcTF3ppAHQm9
   Q==;
X-CSE-ConnectionGUID: efdy+i1RQR2Q95OWK05Oiw==
X-CSE-MsgGUID: tkAO17ftR469F8ckyE5Iyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68548609"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68548609"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 01:36:54 -0800
X-CSE-ConnectionGUID: oJYWD2amRmuUzKkYMuwCdQ==
X-CSE-MsgGUID: knx1ziC2SRuSl4bRrDbntA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,185,1763452800"; 
   d="scan'208";a="200845417"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 01:36:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Dec 2025 11:36:48 +0200 (EET)
To: Ziming Du <duziming2@huawei.com>
cc: bhelgaas@google.com, jbarnes@virtuousgeek.org, chrisw@redhat.com, 
    alex.williamson@redhat.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, liuyongqiang13@huawei.com
Subject: Re: [PATCH v2 3/3] PCI/sysfs: Prohibit unaligned access to I/O port
 on non-x86
In-Reply-To: <20251224092721.2034529-4-duziming2@huawei.com>
Message-ID: <2bc52d2a-7934-df63-6463-7bc91a526ab4@linux.intel.com>
References: <20251224092721.2034529-1-duziming2@huawei.com> <20251224092721.2034529-4-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 24 Dec 2025, Ziming Du wrote:

> From: Yongqiang Liu <liuyongqiang13@huawei.com>
> 
> Unaligned access is harmful for non-x86 archs such as arm64. When we
> use pwrite or pread to access the I/O port resources with unaligned
> offset, system will crash as follows:
> 
> Unable to handle kernel paging request at virtual address fffffbfffe8010c1
> Internal error: Oops: 0000000096000061 [#1] SMP
> Call trace:
>  _outw include/asm-generic/io.h:594 [inline]
>  logic_outw+0x54/0x218 lib/logic_pio.c:305
>  pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
>  pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
>  pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
>  sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
>  kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
>  vfs_write+0x7bc/0xac8 fs/read_write.c:586
>  ksys_write+0x12c/0x270 fs/read_write.c:639
>  __arm64_sys_write+0x78/0xb8 fs/read_write.c:648
> 
> Powerpc seems affected as well, so prohibit the unaligned access
> on non-x86 archs.
> 
> Fixes: 8633328be242 ("PCI: Allow read/write access to sysfs I/O port resources")
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Ziming Du <duziming2@huawei.com>
> ---
>  drivers/pci/pci-sysfs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7e697b82c5e1..c44a9c4a91ab 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1166,12 +1166,20 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  			*(u8 *)buf = inb(port);
>  		return 1;
>  	case 2:
> +#if !defined(CONFIG_X86)
> +		if (!IS_ALIGNED(port, count))
> +			return -EFAULT;
> +#endif
>  		if (write)
>  			outw(*(u16 *)buf, port);
>  		else
>  			*(u16 *)buf = inw(port);
>  		return 2;
>  	case 4:
> +#if !defined(CONFIG_X86)
> +		if (!IS_ALIGNED(port, count))
> +			return -EFAULT;
> +#endif
>  		if (write)
>  			outl(*(u32 *)buf, port);
>  		else
> 

To use IS_ALIGNED(), you need to add:

#include <linux/align.h>

-- 
 i.


