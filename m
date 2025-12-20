Return-Path: <linux-pci+bounces-43477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE94CD3286
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 16:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2331F300FA0A
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 15:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CFD2D12ED;
	Sat, 20 Dec 2025 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NO0H0a5M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52157280A5B;
	Sat, 20 Dec 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766246247; cv=none; b=btH2k3ntADDGlnYL+ms1MzSOUvHT1fqig+5GxttcNT1zNNJSVnB0fyRuiYoytWbAuBNgC+ZQ6/wHZABPB2EN1E6GSlICiWVklf6ziKkN9am2mDHoLkURUlmcnwCiUS1DLpbJ/f5iCSzuC8x0nC9UvOEFKzLGIQzOwjmkb+KAGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766246247; c=relaxed/simple;
	bh=mvgKR5eBPfsudG+7ydx/1/S0torXhJ+RG9LyOYP6tlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwxC9O7mvzgGvQ28ePLK+U7nIb3wnclkZ3ytIs3l4m9LqFgsgrRs3DhQ0c4M3ObjutKE0c5f3OX5LhiUJ4aOWLkT8NbPMlbM7gdtwGrQpmiAFzEt3met2Er2WpQCyIGXE54EzaKbWtGrNq73nVe8XBlYZLSWH/xPQvK1SL47srE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NO0H0a5M; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766246245; x=1797782245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mvgKR5eBPfsudG+7ydx/1/S0torXhJ+RG9LyOYP6tlY=;
  b=NO0H0a5MsYr0Jer2knJB/bNMZRWdTefJ5sGLsjWkzVgxjqi3DhU88HrO
   IFmdj2YwPItgBFhYa2FZUxdV7P4fxE86Flod9E3SuYG8/EktIT3DwcaSC
   1SNcCRWMMJsSEuGZay4U/LMilDxYYdaY+3Wq+nIaT8kwl+tMUtYmXFq7y
   RnmAOhF/GBVpAlOWFroEcRlDhwPvZCrvwqXHjD86gke1+Wm4HqpgigQzA
   FfHNwja7NOZdFQTk/FosZc0dMpf4qBvSjQfejHSCxebb+MdZnb/y3EU03
   ETPm2iqjz7sDCBFPfJJLdL/FH9Qla3U1Z3Dln18mkFbnqnfA/aQP3YaJi
   w==;
X-CSE-ConnectionGUID: n4zoVSG+S8mAl+7IFML+gg==
X-CSE-MsgGUID: TthLt2B8QIOkVksgwdaQ8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="70748105"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="70748105"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 07:57:24 -0800
X-CSE-ConnectionGUID: OK5FWqYtSzGM3+TRRKERfw==
X-CSE-MsgGUID: UyYosMaJTDaoOZl/8+B6Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199642886"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 20 Dec 2025 07:57:20 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWzKX-000000004nl-31dx;
	Sat, 20 Dec 2025 15:57:17 +0000
Date: Sat, 20 Dec 2025 23:57:06 +0800
From: kernel test robot <lkp@intel.com>
To: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <202512202338.qFqw6FI8-lkp@intel.com>
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
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20251220/202512202338.qFqw6FI8-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project b324c9f4fa112d61a553bf489b5f4f7ceea05ea8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202338.qFqw6FI8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202338.qFqw6FI8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/kernfs/file.c:480:9: error: call to undeclared function 'mm_get_unmapped_area'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     480 |         addr = mm_get_unmapped_area(file, uaddr, len, pgoff, flags);
         |                ^
   fs/kernfs/file.c:480:9: note: did you mean '__get_unmapped_area'?
   include/linux/mm.h:3671:1: note: '__get_unmapped_area' declared here
    3671 | __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
         | ^
   1 error generated.


vim +/mm_get_unmapped_area +480 fs/kernfs/file.c

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

