Return-Path: <linux-pci+bounces-44330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA19D0789D
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 08:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7B6C30402D6
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 07:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B12EC0B2;
	Fri,  9 Jan 2026 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpVeM+pA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A42EC571;
	Fri,  9 Jan 2026 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943289; cv=none; b=ElYwYCL27eRkcOQs26Z2GY4yAjb4QVFV5XKxCbCtAyyymPnsaGVwI/Y97N3N4fgAFRLUkD1YayqD8sXLJNBNsLyF8wadGzeA6ILUMOn88l8tub9LiMYHY0tNYI+8o4uB98FUiuMMjm98KEoeu2BBbyas//ogIvzSsjt0ZelUckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943289; c=relaxed/simple;
	bh=GgrwOnpQ7LcONawPw/k+za/zyA/Z6tNZVPTlWXxxWqU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Kl+loxI9ah33tl3dLw8qhQMhXHak8Ee+iMULkz5ktv53zEZ7gYuPtZ0x+RnncETCwcl8XHqidOQUF988ypfpmCSCGrujDOn3SSvwFHQlYKzQNIRiLsRrNvMGw5TjGCCUAl+85rl24qUSYD9ivf0E8kGbXnZxnNyKNZ7Mfw1fKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpVeM+pA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767943282; x=1799479282;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=GgrwOnpQ7LcONawPw/k+za/zyA/Z6tNZVPTlWXxxWqU=;
  b=XpVeM+pAop8ssynXV0dkfW8XR1gzPQNNJ1bIrQtX8bco1BWHulMCkr7w
   o8rTt+p5upDuNobcCOCGR9I6F5vYwM4z7J6v4eAXwsMCyUQGcETN/GENO
   xwNupdw1CAoGzZ/a7Q6tr4tLkH/fZ8T5zwLYch+YQDEILyuibgFbM3jaQ
   R4NQZS++ZP4GAh++hDQpD/szVHrXaxBLLRFeYKjANd8yJC5xsoDcmPojv
   ewvsTWZ8Ny4i1pQ8OM3xFtc5fqkiCx+HEwJnBfKRQthuW4L0ftW2toXKV
   Xyeszz64IhlVr/ziw21lhesgR0WWtf5xEXOM7OoeiA1R/xVI/o+JtBarZ
   Q==;
X-CSE-ConnectionGUID: 9I7WTVVFQoGvP7zFL48vqQ==
X-CSE-MsgGUID: gFOeRlCFTnu3RmLb66HR6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69061853"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="69061853"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 23:21:19 -0800
X-CSE-ConnectionGUID: 6USPIqZqSmCX5MOKKW5fsQ==
X-CSE-MsgGUID: La9zFs1kRa6qdhmQ8Od7Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="203434793"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.124.223.57])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 23:21:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Jan 2026 09:21:13 +0200 (EET)
To: duziming <duziming2@huawei.com>
cc: David Laight <david.laight.linux@gmail.com>, bhelgaas@google.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    liuyongqiang13@huawei.com
Subject: Re: [PATCH v3 3/3] PCI/sysfs: Prohibit unaligned access to I/O port
 on non-x86
In-Reply-To: <98ecea9b-ca2f-4ef7-9f1a-848faa9c92a3@huawei.com>
Message-ID: <0d57b385-410f-3296-ca8b-8b1370a886b1@linux.intel.com>
References: <20260108015944.3520719-1-duziming2@huawei.com> <20260108015944.3520719-4-duziming2@huawei.com> <20260108085611.0f07816d@pumpkin> <98ecea9b-ca2f-4ef7-9f1a-848faa9c92a3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-869657705-1767942562=:1008"
Content-ID: <ca08e239-65fb-46bd-aecc-febefe948889@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-869657705-1767942562=:1008
Content-Type: text/plain; CHARSET=ISO-2022-JP
Content-ID: <1f9bf9c8-22ab-7c0c-1415-027317731ae2@linux.intel.com>

On Thu, 8 Jan 2026, duziming wrote:

> 
> 在 2026/1/8 16:56, David Laight 写道:
> > On Thu, 8 Jan 2026 09:59:44 +0800
> > Ziming Du <duziming2@huawei.com> wrote:
> > 
> > > From: Yongqiang Liu <liuyongqiang13@huawei.com>
> > > 
> > > Unaligned access is harmful for non-x86 archs such as arm64. When we
> > > use pwrite or pread to access the I/O port resources with unaligned
> > > offset, system will crash as follows:
> > > 
> > > Unable to handle kernel paging request at virtual address fffffbfffe8010c1
> > > Internal error: Oops: 0000000096000061 [#1] SMP
> > > Call trace:
> > >   _outw include/asm-generic/io.h:594 [inline]
> > >   logic_outw+0x54/0x218 lib/logic_pio.c:305
> > >   pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
> > >   pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
> > >   pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
> > >   sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
> > >   kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
> > >   vfs_write+0x7bc/0xac8 fs/read_write.c:586
> > >   ksys_write+0x12c/0x270 fs/read_write.c:639
> > >   __arm64_sys_write+0x78/0xb8 fs/read_write.c:648
> > > 
> > > Powerpc seems affected as well, so prohibit the unaligned access
> > > on non-x86 archs.
> > I'm not sure it makes any real sense for x86 either.
> > IIRC io space is just like memory space, so a 16bit io access looks the
> > same as two 8bit accesses to an 8bit device (some put the 'data fifo' on
> > addresses 0 and 1 so the code could use 16bit io accesses to speed things
> > up).
> > The same will have applied to misaligned accesses.
> > But, in reality, all device registers are aligned.
> > 
> > I'm not sure EFAULT is the best error code though, EINVAL might be better.
> > (EINVAL is returned for other address/size errors.)
> > EFAULT is usually returned for errors accessing the user buffer, a least
> > one unix system raises SIGSEGV whenever EFAULT is returned.
> > 
> Just to confirm: should all architectures prohibit unaligned access to device
> registers?

In my opinion, yes, also x86 should prohibit it (like I already 
expressed but you ignored that comment until now).

-- 
 i.

> > > Fixes: 8633328be242 ("PCI: Allow read/write access to sysfs I/O port
> > > resources")
> > > Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> > > Signed-off-by: Ziming Du <duziming2@huawei.com>
> > > ---
> > >   drivers/pci/pci-sysfs.c | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 7e697b82c5e1..11d8b7ec4263 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -31,6 +31,7 @@
> > >   #include <linux/of.h>
> > >   #include <linux/aperture.h>
> > >   #include <linux/unaligned.h>
> > > +#include <linux/align.h>
> > >   #include "pci.h"
> > >     #ifndef ARCH_PCI_DEV_GROUPS
> > > @@ -1166,12 +1167,20 @@ static ssize_t pci_resource_io(struct file *filp,
> > > struct kobject *kobj,
> > >   			*(u8 *)buf = inb(port);
> > >   		return 1;
> > >   	case 2:
> > > +		#if !defined(CONFIG_X86)
> > > +			if (!IS_ALIGNED(port, count))
> > > +				return -EFAULT;
> > > +		#endif
> > >   		if (write)
> > >   			outw(*(u16 *)buf, port);
> > >   		else
> > >   			*(u16 *)buf = inw(port);
> > >   		return 2;
> > >   	case 4:
> > > +		#if !defined(CONFIG_X86)
> > > +			if (!IS_ALIGNED(port, count))
> > > +				return -EFAULT;
> > > +		#endif
> > >   		if (write)
> > >   			outl(*(u32 *)buf, port);
> > >   		else
> 
--8323328-869657705-1767942562=:1008--

