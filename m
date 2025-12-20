Return-Path: <linux-pci+bounces-43476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B67CD3272
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 16:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1627300BD99
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 15:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F62BD5A7;
	Sat, 20 Dec 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIsqb+y8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53821D599;
	Sat, 20 Dec 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766245465; cv=none; b=GZSKRCvcHEaFauICyabneV4iGplUENuAF09/6h7hM0b9IQT9hKIIKS0yidhMb/iqdHFk9W3wxYmKVwQdE1UtE86wa4sjI93GIfeIvR+OJtRil3XVNBa8fZy4c1tqD3wVy+M2C8WcE7jIrU/UrZby15GrRDaGUn1QveTYz8rcwqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766245465; c=relaxed/simple;
	bh=i30qgdidF5swEfrY8bISvHkNXQBtVxmPrBDz6HH/8cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyGqxaRwvzzJTDdNhlybDgn9bcKILFbTgSVzW3uccv1xrhlq4YPqF721YUZPKM3dFfN2wPPGNMLWLpNlCtHIHIYu5sykX3tijm7omtzx6byWS0wrQal8Gve9OGbNKU3ZEV3olZuUu4UJo4ZtdtOoq8JwsFNXLIGKUb+dIo1m708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIsqb+y8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766245464; x=1797781464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i30qgdidF5swEfrY8bISvHkNXQBtVxmPrBDz6HH/8cE=;
  b=QIsqb+y823hmSLn7pQLe3rWFE1RvuxZ0wSV4Tzzs5VBQbHZa83sk9NsV
   ucjbYHQdwDKkyK4KpJiz1VFI9n4BnvspzGdgFYPPV+cLLc1Vie717Xnhn
   ox8IvhZnpXhbKSGFNjgqRVwpx0cgZ5JuyOckdA5V/zdHZZ4E6XyYy9mqE
   /V7X0h+lB4eUnAjrMADjDHQWtVpMeI2KdzK7/QWByti8dX5w0NriKTnob
   38jlDSRaj2qgnR7mQ6THh7kCiHDMQy+PoeCVLFmpyeP1ZkrvazVeFF25F
   m2mmYTy9zXAjQPRBi2wFH19HUqOaN5od6/jSBuugFqGfcLhKmONL8OGD/
   g==;
X-CSE-ConnectionGUID: GVLHAZM8SHGpG3pvynoryw==
X-CSE-MsgGUID: QYmQIdivSRWOEeLKwjuMCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="79297143"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="79297143"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 07:44:24 -0800
X-CSE-ConnectionGUID: 7rxyLLmsSwu8Qk61HDxw4w==
X-CSE-MsgGUID: odg2+K3HSBq45ro0hb4fag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="236535410"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Dec 2025 07:44:18 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWz7v-000000004m1-2LBa;
	Sat, 20 Dec 2025 15:44:15 +0000
Date: Sat, 20 Dec 2025 23:43:44 +0800
From: kernel test robot <lkp@intel.com>
To: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Alistair Popple <apopple@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	houtao1@huawei.com
Subject: Re: [PATCH 03/13] kernfs: add support for get_unmapped_area callback
Message-ID: <202512202307.ewUcqBQV-lkp@intel.com>
References: <20251220040446.274991-4-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220040446.274991-4-houtao@huaweicloud.com>

Hi Hou,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus akpm-mm/mm-everything linus/master v6.19-rc1 next-20251219]
[cannot apply to pci/next pci/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hou-Tao/PCI-P2PDMA-Release-the-per-cpu-ref-of-pgmap-when-vm_insert_page-fails/20251220-121804
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20251220040446.274991-4-houtao%40huaweicloud.com
patch subject: [PATCH 03/13] kernfs: add support for get_unmapped_area callback
config: sh-allnoconfig (https://download.01.org/0day-ci/archive/20251220/202512202307.ewUcqBQV-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202307.ewUcqBQV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202307.ewUcqBQV-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/kernfs/file.c: In function 'kernfs_get_unmapped_area':
>> fs/kernfs/file.c:480:16: error: implicit declaration of function 'mm_get_unmapped_area'; did you mean 'get_unmapped_area'? [-Wimplicit-function-declaration]
     480 |         addr = mm_get_unmapped_area(file, uaddr, len, pgoff, flags);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                get_unmapped_area


vim +480 fs/kernfs/file.c

   456	
   457	static unsigned long kernfs_get_unmapped_area(struct file *file, unsigned long uaddr,
   458						      unsigned long len, unsigned long pgoff,
   459						      unsigned long flags)
   460	{
   461		struct kernfs_open_file *of = kernfs_of(file);
   462		const struct kernfs_ops *ops;
   463		long addr;
   464	
   465		if (!(of->kn->flags & KERNFS_HAS_MMAP))
   466			return -ENODEV;
   467	
   468		mutex_lock(&of->mutex);
   469	
   470		addr = -ENODEV;
   471		if (!kernfs_get_active_of(of))
   472			goto out_unlock;
   473	
   474		ops = kernfs_ops(of->kn);
   475		if (ops->get_unmapped_area) {
   476			addr = ops->get_unmapped_area(of, uaddr, len, pgoff, flags);
   477			if (!IS_ERR_VALUE(addr) || addr != -EOPNOTSUPP)
   478				goto out_put;
   479		}
 > 480		addr = mm_get_unmapped_area(file, uaddr, len, pgoff, flags);
   481	
   482	out_put:
   483		kernfs_put_active_of(of);
   484	out_unlock:
   485		mutex_unlock(&of->mutex);
   486	
   487		return addr;
   488	}
   489	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

