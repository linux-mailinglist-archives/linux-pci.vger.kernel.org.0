Return-Path: <linux-pci+bounces-14115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D00F2997A03
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 03:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A24928447D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 01:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37EC405F7;
	Thu, 10 Oct 2024 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/HPX6h1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F62A1D2
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 01:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522642; cv=none; b=VVLn6J/YfruHzCHbJpUA2oeL2kaWSBfGpaYj50hG3nCzFaT4bGQK//lTamNqg8n470URdXxpxRCrg2ZWty2e56Ao5l4F/Lj0Yc8jZhefKY0N1Slzl8zneFMoNo43iMz4CLEWTprJg1ALZ/rqndmWVwM3qQF1NOdQ6/Z/ojTshy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522642; c=relaxed/simple;
	bh=Qq985kPM2kR5NPx7dLci4TmZFgYxHUtg9/kh9dwzS7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipzBWChuoPe31oSIP5a639HIxwwP2wHb/MIxc1a4oizC0RHdOICOBVo3Z/8Uq+1qilo+beCEYhCmQSgMHzAkxhOZQoRyONvE+2Lr3TEmWlLcBFP6c2p2oj/O/ftq8Y75ZLepzuNfGp1OOcYAPtRN9olpd8RjCehvZxFcVGIDtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/HPX6h1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728522641; x=1760058641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qq985kPM2kR5NPx7dLci4TmZFgYxHUtg9/kh9dwzS7c=;
  b=R/HPX6h1aHUzR07ZAyk0lNU4mcylzcOX3rNLnGsw4n5M5TjPu33BSqqb
   NlNIjnJoVoR/w71eszpBZkztCuuxjo57V1QwKoFgsioL7hT8X8+JU7Uum
   +iL1nhpeMgUR//5njxV8OMAmhBOA1B35c/6QPEbZMNUBY2H/7ST0kNt/q
   ibuxxKlmngnIgVsQ05W6MU9gnFTo9Ftd23IOHkD6P1F+Yiw7cJFjp6IXl
   U/Pkb9xmYqKIQ9SwMDiPpejbxufV1naitbB2ittvkq40mcX0STTrwLlce
   Snnk46QYAtlATsrObR51S2FrIM3bBQTHJ4R2jKw1jquEBU7fzWRDAmIlv
   Q==;
X-CSE-ConnectionGUID: 6pHx1sjRST29usj6I6aORA==
X-CSE-MsgGUID: 0qeCqXpvS0y1xn6R7bze9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28015189"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="28015189"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 18:10:41 -0700
X-CSE-ConnectionGUID: teWRoEUTS/WA7fSvj/H55g==
X-CSE-MsgGUID: OMIvwlOFTBCz35hqcw06eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="80951730"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 09 Oct 2024 18:10:37 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syhhL-000A0N-0V;
	Thu, 10 Oct 2024 01:10:35 +0000
Date: Thu, 10 Oct 2024 09:10:29 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v1 4/5] PCI: endpoint: Add NVMe endpoint function driver
Message-ID: <202410100833.wTKBq6k1-lkp@intel.com>
References: <20241007044351.157912-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007044351.157912-5-dlemoal@kernel.org>

Hi Damien,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.12-rc2 next-20241009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/nvmet-rename-and-move-nvmet_get_log_page_len/20241007-124428
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241007044351.157912-5-dlemoal%40kernel.org
patch subject: [PATCH v1 4/5] PCI: endpoint: Add NVMe endpoint function driver
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20241010/202410100833.wTKBq6k1-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410100833.wTKBq6k1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410100833.wTKBq6k1-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/pci/endpoint/functions/pci-epf-nvme.c:81:33: error: field 'pci_map' has incomplete type
      81 |         struct pci_epc_map      pci_map;
         |                                 ^~~~~~~
   drivers/pci/endpoint/functions/pci-epf-nvme.c: In function 'pci_epf_nvme_mmio_transfer':
>> drivers/pci/endpoint/functions/pci-epf-nvme.c:415:28: error: storage size of 'map' isn't known
     415 |         struct pci_epc_map map;
         |                            ^~~
>> drivers/pci/endpoint/functions/pci-epf-nvme.c:419:15: error: implicit declaration of function 'pci_epc_mem_map'; did you mean 'pci_epc_mem_exit'? [-Wimplicit-function-declaration]
     419 |         ret = pci_epc_mem_map(epf->epc, epf->func_no, epf->vfunc_no,
         |               ^~~~~~~~~~~~~~~
         |               pci_epc_mem_exit
>> drivers/pci/endpoint/functions/pci-epf-nvme.c:438:9: error: implicit declaration of function 'pci_epc_mem_unmap'; did you mean 'pci_epc_mem_init'? [-Wimplicit-function-declaration]
     438 |         pci_epc_mem_unmap(epf->epc, epf->func_no, epf->vfunc_no, &map);
         |         ^~~~~~~~~~~~~~~~~
         |         pci_epc_mem_init
>> drivers/pci/endpoint/functions/pci-epf-nvme.c:415:28: warning: unused variable 'map' [-Wunused-variable]
     415 |         struct pci_epc_map map;
         |                            ^~~
   In file included from include/linux/bits.h:7,
                    from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/microblaze/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/delay.h:22,
                    from drivers/pci/endpoint/functions/pci-epf-nvme.c:10:
   drivers/pci/endpoint/functions/pci-epf-nvme.c: In function 'pci_epf_nvme_init_ctrl_regs':
   include/uapi/linux/bits.h:8:31: warning: left shift count >= width of type [-Wshift-count-overflow]
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pci/endpoint/functions/pci-epf-nvme.c:1391:23: note: in expansion of macro 'GENMASK'
    1391 |         ctrl->cap &= ~GENMASK(35, 32);
         |                       ^~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pci/endpoint/functions/pci-epf-nvme.c:1391:23: note: in expansion of macro 'GENMASK'
    1391 |         ctrl->cap &= ~GENMASK(35, 32);
         |                       ^~~~~~~
   drivers/pci/endpoint/functions/pci-epf-nvme.c: In function 'pci_epf_nvme_enable_ctrl':
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pci/endpoint/functions/pci-epf-nvme.c:1467:45: note: in expansion of macro 'GENMASK'
    1467 |                                 ctrl->acq & GENMASK(63, 12));
         |                                             ^~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pci/endpoint/functions/pci-epf-nvme.c:1473:50: note: in expansion of macro 'GENMASK'
    1473 |                                      ctrl->asq & GENMASK(63, 12));
         |                                                  ^~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/pci_map +81 drivers/pci/endpoint/functions/pci-epf-nvme.c

    69	
    70	/*
    71	 * Queue definition and mapping for the local PCI controller.
    72	 */
    73	struct pci_epf_nvme_queue {
    74		struct pci_epf_nvme	*epf_nvme;
    75	
    76		unsigned int		qflags;
    77		int			ref;
    78	
    79		phys_addr_t		pci_addr;
    80		size_t			pci_size;
  > 81		struct pci_epc_map	pci_map;
    82	
    83		u16			qid;
    84		u16			cqid;
    85		u16			size;
    86		u16			depth;
    87		u16			flags;
    88		u16			vector;
    89		u16			head;
    90		u16			tail;
    91		u16			phase;
    92		u32			db;
    93	
    94		size_t			qes;
    95	
    96		struct workqueue_struct	*cmd_wq;
    97		struct delayed_work	work;
    98		spinlock_t		lock;
    99		struct list_head	list;
   100	};
   101	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

