Return-Path: <linux-pci+bounces-14127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DCB997B50
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 05:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F79285487
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 03:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F82B9D4;
	Thu, 10 Oct 2024 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrpN8wTQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A461129CEC
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531289; cv=none; b=U61aAeeabBTzRVKHFcN05OWNkIw5ahPP1eHYiZV67DNH7o+ce44GdjISiU6PFDqlE0qdBWoJb5b8jdMz2sKtFj8H3k1XVupZRBqEkyCzWIZRRQSQ792kYf0f4RkbpYmgvFQEDj3ldHtCSiGXtgkW3qfHS8fIzeGKEChfkU0pvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531289; c=relaxed/simple;
	bh=1EQymhFoo7PHNAi1pb9KlKlTNVRwRgpT1OKIX53OvQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af0NIBE2f9dyp+np/E8lYu8jnET3lo8y3ur1fSBJP+YjblZ60xCJ6VYPpqpS7QGQ+h7T2RPe4KhALrgI5c5aBGT/ah89UCXVi2IYn6HGkNIm7uqQXY58Lv4i4gifuunGBtn44ZHzR8aFzuLjZKaJ1DdLeMtOtB/XksAoVmgijmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrpN8wTQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728531286; x=1760067286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1EQymhFoo7PHNAi1pb9KlKlTNVRwRgpT1OKIX53OvQM=;
  b=WrpN8wTQ07nc1nmdoWX79dwOZ4PdpvIuQ10zmbchhfDrg43MgTMAXtkc
   C/cnLb5Fzg4U2V7FyNJCCDoZl/c7v9kj0nX+8t7k2sLHoE8u4zSSv5Ndc
   TE1sU/Sv7Tz0F3hcFDfhkJA27lpidH1jzgrj9u6rbmPdl9TgMfpxy0nL8
   v/Sfa5bIZGqULXslxi+RvNqQyvHs9/X0OlfNlwb+tRExNWQJLao+xNLvU
   t1seVz/MEPzCdXYyknabH6jxQMJ60huKcE9R1uH7FbXUVYqBpmcvhnga2
   bcjR9kZfHTLNy8hbB/wyHYboJAvT5jPG02wwrtyGg/18NC55V6TlrPmQi
   w==;
X-CSE-ConnectionGUID: eX8K7AWDTWCOlmQKObB+Ig==
X-CSE-MsgGUID: pwSOq7TwTG23JYttjRvLeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="15489270"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="15489270"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 20:34:46 -0700
X-CSE-ConnectionGUID: DB5MoxZZSQyKXrxo/VzL2w==
X-CSE-MsgGUID: 1Tc8r3y4SYGxU3b9GPge2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="76451659"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 09 Oct 2024 20:34:42 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syjwm-000A7B-1L;
	Thu, 10 Oct 2024 03:34:40 +0000
Date: Thu, 10 Oct 2024 11:33:49 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v1 4/5] PCI: endpoint: Add NVMe endpoint function driver
Message-ID: <202410101139.m5gNkCfL-lkp@intel.com>
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241010/202410101139.m5gNkCfL-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410101139.m5gNkCfL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410101139.m5gNkCfL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/endpoint/functions/pci-epf-nvme.c:81:21: error: field has incomplete type 'struct pci_epc_map'
      81 |         struct pci_epc_map      pci_map;
         |                                 ^
   drivers/pci/endpoint/functions/pci-epf-nvme.c:81:9: note: forward declaration of 'struct pci_epc_map'
      81 |         struct pci_epc_map      pci_map;
         |                ^
>> drivers/pci/endpoint/functions/pci-epf-nvme.c:415:21: error: variable has incomplete type 'struct pci_epc_map'
     415 |         struct pci_epc_map map;
         |                            ^
   drivers/pci/endpoint/functions/pci-epf-nvme.c:81:9: note: forward declaration of 'struct pci_epc_map'
      81 |         struct pci_epc_map      pci_map;
         |                ^
>> drivers/pci/endpoint/functions/pci-epf-nvme.c:419:8: error: call to undeclared function 'pci_epc_mem_map'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     419 |         ret = pci_epc_mem_map(epf->epc, epf->func_no, epf->vfunc_no,
         |               ^
>> drivers/pci/endpoint/functions/pci-epf-nvme.c:438:2: error: call to undeclared function 'pci_epc_mem_unmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     438 |         pci_epc_mem_unmap(epf->epc, epf->func_no, epf->vfunc_no, &map);
         |         ^
   drivers/pci/endpoint/functions/pci-epf-nvme.c:1021:8: error: call to undeclared function 'pci_epc_mem_map'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1021 |         ret = pci_epc_mem_map(epf->epc, epf->func_no, epf->vfunc_no,
         |               ^
   drivers/pci/endpoint/functions/pci-epf-nvme.c:1034:3: error: call to undeclared function 'pci_epc_mem_unmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1034 |                 pci_epc_mem_unmap(epf->epc, epf->func_no, epf->vfunc_no,
         |                 ^
   drivers/pci/endpoint/functions/pci-epf-nvme.c:1047:2: error: call to undeclared function 'pci_epc_mem_unmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1047 |         pci_epc_mem_unmap(epf->epc, epf->func_no, epf->vfunc_no,
         |         ^
   7 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +81 drivers/pci/endpoint/functions/pci-epf-nvme.c

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

