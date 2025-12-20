Return-Path: <linux-pci+bounces-43482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A09CD3818
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 23:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD173300E3DC
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 22:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09AD2C1581;
	Sat, 20 Dec 2025 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiIKnN9d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AC52BD022;
	Sat, 20 Dec 2025 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766269374; cv=none; b=QW7v5k1bMXYF9/9LL2pUdxAo7uKC9SHUf7Z52r3DzntRcXN0Gaczrw902zu+1nx/HMnwueFP5lSrE7wIA3CXajWCLCRVa3NsyNcAXLCkOV7w7xk2jBucKKhDx0eqt0dPLvg+vziquB3SjggotmQr2fsNfsCdAsbW6Mg+IiB27TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766269374; c=relaxed/simple;
	bh=R1Jaj/KasLrmbIdCFUgBGCNzU9HfFfRLRQd1chPkPq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlG2T9vJcnygTuVxhxlEHXrtDfMFqWXFrKOyo8HCeVZd9+28k2h9tXf42f9tKK4P4oq331/jixFY87lOyG7N8cpWK4L8eLqw6pgCE6rM5ILsID2QAzZbZiH21DbyvlZFwWwwBTvlsbZYx9aDNctZLO/6igAcXabfMLdEqqs/QGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiIKnN9d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766269373; x=1797805373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R1Jaj/KasLrmbIdCFUgBGCNzU9HfFfRLRQd1chPkPq0=;
  b=NiIKnN9d4e8F/s0aHYs1QiQSZyi/M/1kdBYMnretGh+lpNJ6T4hHFeKz
   mBEk4a9kD6xkCqk/TsZMPdxqvHKosbMn/HFhMogI9IW/3WB2w3+OyAwOU
   OgMqpoaiXFU1yD59WCerolO2HE4djwsjlh7f2d7S+3EWtVas9UqvACCYl
   Jzu+8DhXuAvMeTLrBjAN8ThMJ52sdd8v/L7fdZmWjd/OYgUKglxb+GUpC
   hCiu54Vbxe842vrkopZATEIgXDGICfqzm0v/dqiIr3xQJNKCZ2HNE+Vfr
   XyCwxdSzP2Xo/Booh/MzGJGRYOUzFMe3EiN0441ZyadDG9CK1Iy9EdWoX
   Q==;
X-CSE-ConnectionGUID: nSl0KVTdQFqWqn0+vxUC/A==
X-CSE-MsgGUID: bMyhvcHOTCav7TQYEVARmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="78823169"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="78823169"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 14:22:52 -0800
X-CSE-ConnectionGUID: qLYGld/lTLavhGxUh1bGbQ==
X-CSE-MsgGUID: 4olp1ytkSrKr/eW1miFBHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199211875"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Dec 2025 14:22:46 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX5LX-000000005AD-3uuB;
	Sat, 20 Dec 2025 22:22:43 +0000
Date: Sun, 21 Dec 2025 06:22:10 +0800
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
Subject: Re: [PATCH 12/13] nvme-pci: introduce cmb_devmap_align module
 parameter
Message-ID: <202512210635.b7EdhXBT-lkp@intel.com>
References: <20251220040446.274991-13-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220040446.274991-13-houtao@huaweicloud.com>

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
patch link:    https://lore.kernel.org/r/20251220040446.274991-13-houtao%40huaweicloud.com
patch subject: [PATCH 12/13] nvme-pci: introduce cmb_devmap_align module parameter
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20251221/202512210635.b7EdhXBT-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210635.b7EdhXBT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210635.b7EdhXBT-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvme/host/pci.c: In function 'nvme_map_cmb':
>> drivers/nvme/host/pci.c:2319:54: error: passing argument 1 of 'pci_p2pdma_max_pagemap_align' makes integer from pointer without a cast [-Wint-conversion]
    2319 |                 align = pci_p2pdma_max_pagemap_align(pdev, bar, size, offset);
         |                                                      ^~~~
         |                                                      |
         |                                                      struct pci_dev *
   In file included from include/linux/blk-mq-dma.h:6,
                    from drivers/nvme/host/pci.c:10:
   include/linux/pci-p2pdma.h:232:67: note: expected 'resource_size_t' {aka 'long long unsigned int'} but argument is of type 'struct pci_dev *'
     232 | static inline size_t pci_p2pdma_max_pagemap_align(resource_size_t start,
         |                                                   ~~~~~~~~~~~~~~~~^~~~~
>> drivers/nvme/host/pci.c:2319:25: error: too many arguments to function 'pci_p2pdma_max_pagemap_align'; expected 3, have 4
    2319 |                 align = pci_p2pdma_max_pagemap_align(pdev, bar, size, offset);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~                  ~~~~~~
   include/linux/pci-p2pdma.h:232:22: note: declared here
     232 | static inline size_t pci_p2pdma_max_pagemap_align(resource_size_t start,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/pci_p2pdma_max_pagemap_align +2319 drivers/nvme/host/pci.c

  2267	
  2268	static void nvme_map_cmb(struct nvme_dev *dev)
  2269	{
  2270		u64 size, offset;
  2271		resource_size_t bar_size;
  2272		struct pci_dev *pdev = to_pci_dev(dev->dev);
  2273		size_t align;
  2274		int bar;
  2275	
  2276		if (dev->cmb_size)
  2277			return;
  2278	
  2279		if (NVME_CAP_CMBS(dev->ctrl.cap))
  2280			writel(NVME_CMBMSC_CRE, dev->bar + NVME_REG_CMBMSC);
  2281	
  2282		dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
  2283		if (!dev->cmbsz)
  2284			return;
  2285		dev->cmbloc = readl(dev->bar + NVME_REG_CMBLOC);
  2286	
  2287		size = nvme_cmb_size_unit(dev) * nvme_cmb_size(dev);
  2288		offset = nvme_cmb_size_unit(dev) * NVME_CMB_OFST(dev->cmbloc);
  2289		bar = NVME_CMB_BIR(dev->cmbloc);
  2290		bar_size = pci_resource_len(pdev, bar);
  2291	
  2292		if (offset > bar_size)
  2293			return;
  2294	
  2295		/*
  2296		 * Controllers may support a CMB size larger than their BAR, for
  2297		 * example, due to being behind a bridge. Reduce the CMB to the
  2298		 * reported size of the BAR
  2299		 */
  2300		size = min(size, bar_size - offset);
  2301	
  2302		if (!IS_ALIGNED(size, memremap_compat_align()) ||
  2303		    !IS_ALIGNED(pci_resource_start(pdev, bar),
  2304				memremap_compat_align()))
  2305			return;
  2306	
  2307		/*
  2308		 * Tell the controller about the host side address mapping the CMB,
  2309		 * and enable CMB decoding for the NVMe 1.4+ scheme:
  2310		 */
  2311		if (NVME_CAP_CMBS(dev->ctrl.cap)) {
  2312			hi_lo_writeq(NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE |
  2313				     (pci_bus_address(pdev, bar) + offset),
  2314				     dev->bar + NVME_REG_CMBMSC);
  2315		}
  2316	
  2317		align = cmb_devmap_align;
  2318		if (!align)
> 2319			align = pci_p2pdma_max_pagemap_align(pdev, bar, size, offset);
  2320		if (pci_p2pdma_add_resource(pdev, bar, size, align, offset)) {
  2321			dev_warn(dev->ctrl.device,
  2322				 "failed to register the CMB\n");
  2323			hi_lo_writeq(0, dev->bar + NVME_REG_CMBMSC);
  2324			return;
  2325		}
  2326	
  2327		dev->cmb_size = size;
  2328		dev->cmb_use_sqes = use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS);
  2329	
  2330		if ((dev->cmbsz & (NVME_CMBSZ_WDS | NVME_CMBSZ_RDS)) ==
  2331				(NVME_CMBSZ_WDS | NVME_CMBSZ_RDS))
  2332			pci_p2pmem_publish(pdev, true);
  2333	}
  2334	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

