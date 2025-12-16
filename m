Return-Path: <linux-pci+bounces-43110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF639CC1FFD
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 11:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 319BE300502F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 10:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79F431AAA6;
	Tue, 16 Dec 2025 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pw2/Tl+0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A427A12B;
	Tue, 16 Dec 2025 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881837; cv=none; b=T6sq2YSrSFuzjtZhSIBmeml96gwzeNyfesHulzD7e7xb/1Ks423Ly14rud8iWH6nSvDajE72UP2nN4C1ANC3smDOQWTSi1XfKEDVzcpCdFwfROEth2wq7zIKpYVQyGVqkP7B1AlfjMJizTesQPfMNgGQ+iWwPk0HM/qf6MKZEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881837; c=relaxed/simple;
	bh=ShQqqnYqL3uPFHPwfYfB2fWG79JZ9KNFZkLyBGX6r4s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dWG7f1+xSA/B3BNWzUHKg6ho3UoZs7L/Gk3TebK+kg4nbNOZKwEQC4B5neRHCMFebuNmmK4hkuIHFPm9bhzVTKWReQyOFz9bFUkjv5tNe4dZDspNNSKXTS42HFLUf0BhtQGE+xi1ciMyy1sgw+21qSfirIp6XS3SttK5fqKNeM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pw2/Tl+0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765881835; x=1797417835;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ShQqqnYqL3uPFHPwfYfB2fWG79JZ9KNFZkLyBGX6r4s=;
  b=Pw2/Tl+0QyJM9kSLFzuBPvUwBXppNTOYqnuk9t6eo9yZNsLNeqOWLK+I
   YX1SsGUUz7y4Mvh12Sv/Yd+BsJBnWGqJ1twp24xq274GoPYE+eK2BhXGr
   FvOFJ9MhGH+F7HQqX/1JQn6ukE/MhVqW+p5bjLB3fquMZYexrRvhg0JxD
   uhOKsRhRGBFiT87Tw7IqVMiXg+QDFoU49kGiT3sNytnt0CT0GtP5g0gzW
   dgQGNCIZRshtYuOdGF6sVDcI4GKqidRnL3dRE1K+WFjPn5IsaX8/ApHVG
   7WebW6YzrO15ct0mjZtNPS2Xntm8XzldxwbGHkIpFIV0AQ3iDSqFt/6nj
   A==;
X-CSE-ConnectionGUID: Fh/yYgY9TwquRaAsniGl0w==
X-CSE-MsgGUID: BldsNodARUC/BIDe3wwBsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="90452277"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="90452277"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 02:43:55 -0800
X-CSE-ConnectionGUID: sXbLzJ4UTISCMApN+2IRug==
X-CSE-MsgGUID: ehsDbzIAT8qhI2kr6BXBVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="198792092"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.4])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 02:43:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Dec 2025 12:43:48 +0200 (EET)
To: Ziming Du <duziming2@huawei.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, chrisw@redhat.com, 
    jbarnes@virtuousgeek.org, alex.williamson@redhat.com, 
    liuyongqiang13@huawei.com
Subject: Re: [PATCH 2/3] PCI/sysfs: Prohibit unaligned access to I/O port on
 non-x86
In-Reply-To: <20251216083912.758219-3-duziming2@huawei.com>
Message-ID: <43e40c50-e23b-0ebc-9f82-986b2ea55943@linux.intel.com>
References: <20251216083912.758219-1-duziming2@huawei.com> <20251216083912.758219-3-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Dec 2025, Ziming Du wrote:

> From: Yongqiang Liu <liuyongqiang13@huawei.com>
> 
> Unaligned access is harmful for non-x86 archs such as arm64. When we
> use pwrite or pread to access the I/O port resources with unaligned
> offset, system will crash as follows:
> 
> Unable to handle kernel paging request at virtual address fffffbfffe8010c1
> Internal error: Oops: 0000000096000061 [#1] SMP
> Modules linked in:
> CPU: 1 PID: 44230 Comm: syz.1.10955 Not tainted 6.6.0+ #1
> Hardware name: linux,dummy-virt (DT)
> pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __raw_writew arch/arm64/include/asm/io.h:33 [inline]
> pc : _outw include/asm-generic/io.h:594 [inline]
> pc : logic_outw+0x54/0x218 lib/logic_pio.c:305
> lr : _outw include/asm-generic/io.h:593 [inline]
> lr : logic_outw+0x40/0x218 lib/logic_pio.c:305
> sp : ffff800083097a30
> x29: ffff800083097a30 x28: ffffba71ba86e130 x27: 1ffff00010612f93
> x26: ffff3bae63b3a420 x25: ffffba71bbf585d0 x24: 0000000000005ac1
> x23: 00000000000010c1 x22: ffff3baf0deb6488 x21: 0000000000000002
> x20: 00000000000010c1 x19: 0000000000ffbffe x18: 0000000000000000
> x17: 0000000000000000 x16: ffffba71b9f44b48 x15: 00000000200002c0
> x14: 0000000000000000 x13: 0000000000000000 x12: ffff6775ca80451f
> x11: 1fffe775ca80451e x10: ffff6775ca80451e x9 : ffffba71bb78cf2c
> x8 : 0000988a357fbae2 x7 : ffff3bae540228f7 x6 : 0000000000000001
> x5 : 1fffe775e2b43c78 x4 : dfff800000000000 x3 : ffffba71b9a00000
> x2 : ffff80008d22a000 x1 : ffffc58ec6600000 x0 : fffffbfffe8010c1
> Call trace:
>  _outw include/asm-generic/io.h:594 [inline]
>  logic_outw+0x54/0x218 lib/logic_pio.c:305
>  pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
>  pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
>  pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
>  sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
>  kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
>  call_write_iter include/linux/fs.h:2085 [inline]
>  new_sync_write fs/read_write.c:493 [inline]
>  vfs_write+0x7bc/0xac8 fs/read_write.c:586
>  ksys_write+0x12c/0x270 fs/read_write.c:639
>  __do_sys_write fs/read_write.c:651 [inline]
>  __se_sys_write fs/read_write.c:648 [inline]
>  __arm64_sys_write+0x78/0xb8 fs/read_write.c:648
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall+0x8c/0x2e0 arch/arm64/kernel/syscall.c:51
>  el0_svc_common.constprop.0+0x200/0x2a8 arch/arm64/kernel/syscall.c:134
>  do_el0_svc+0x4c/0x70 arch/arm64/kernel/syscall.c:176
>  el0_svc+0x44/0x1d8 arch/arm64/kernel/entry-common.c:806
>  el0t_64_sync_handler+0x100/0x130 arch/arm64/kernel/entry-common.c:844
>  el0t_64_sync+0x3c8/0x3d0 arch/arm64/kernel/entry.S:757
> 
> Powerpc seems affected as well, so prohibit the unaligned access
> on non-x86 archs.
> 
> Fixes: 8633328be242 ("PCI: Allow read/write access to sysfs I/O port resources")
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Ziming Du <duziming2@huawei.com>
> ---
>  drivers/pci/pci-sysfs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7e697b82c5e1..6fa3c9d0e97e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1141,6 +1141,13 @@ static int pci_mmap_resource_wc(struct file *filp, struct kobject *kobj,
>  	return pci_mmap_resource(kobj, attr, vma, 1);
>  }
>  
> +#if !defined(CONFIG_X86)
> +static bool is_unaligned(unsigned long port, size_t size)
> +{
> +	return port & (size - 1);
> +}
> +#endif
> +
>  static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  			       const struct bin_attribute *attr, char *buf,
>  			       loff_t off, size_t count, bool write)
> @@ -1158,6 +1165,11 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  	if (port + count - 1 > pci_resource_end(pdev, bar))
>  		return -EINVAL;
>  
> +#if !defined(CONFIG_X86)
> +	if (is_unaligned(port, count))
> +		return -EFAULT;
> +#endif
> +

This changes return value from -EINVAL -> -EFAULT for some values of count 
which seems not justified.

To me it's not clear why even x86 should allow unaligned access. This 
interface is very much geared towards natural alignment and sizing of the 
reads (e.g. count = 3 leads to -EINVAL), so it feels somewhat artificial 
to make x86 behave different here from the others.

>  	switch (count) {
>  	case 1:
>  		if (write)
> 

-- 
 i.


