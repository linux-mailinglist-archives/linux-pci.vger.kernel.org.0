Return-Path: <linux-pci+bounces-13899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E429922B2
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C47CB21C2F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 02:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F38231C8F;
	Mon,  7 Oct 2024 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ts4j2ywh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F283C8D7
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728266549; cv=none; b=lN6Sxt2yPY7JSx1oxQEYPMxNe1qZpU2ij6ThVdvB2HBDweWtz0+TQqNAw/wwXc08Pe4QUg3y5mvuhSkouSbJ3UeJotlBmtFtQfRYi/Uli804zGpA9b8pJrRLVnA2uwUNOy7a/ikBGSrhmkFGjGLlkIJhVtMOijwlr9iL7bMJTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728266549; c=relaxed/simple;
	bh=m+DhcAJ7T5xCYccShyZWlwcMLocHgJ/Ps/SdyIztZEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGZ4rTrD2nVH203+6mEUQDmWbqwdqTbLequ21EaFljYu4Eo0aZQ6pSRgFHLnrz/Ch4GO5Cy9xMGW4dEATRGSqIx82vEES0rEoa4TlYaOmZZDaKz3+x5y6WZXGOlzqoZCHksjZ63CWj9VShn/jqvEBlhFFwXsuOGYy39xv4Ozwyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ts4j2ywh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728266547; x=1759802547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m+DhcAJ7T5xCYccShyZWlwcMLocHgJ/Ps/SdyIztZEE=;
  b=Ts4j2ywhx5IhWrFYcfHza7+mfH8/p+ahyqThBsFpPlgEmnjHqKRz25do
   Ph4smHoOP4M+b/8stnRbJG3LXgSCuXsEhXEJ7srzCIVq/xxEpz4AAn2vh
   xmnEPO9Qnaj5eKjeMRFVhpYmRyn/bTQEvqHz4vZMVyNneBcDwF6EBzk5O
   uZ7GrfnX0LJIDREf0uyqqC8McuY/k9Akn+VEd0bS/oaJs6yLAQN+iG697
   8htlWDq2tj3WTHSluXVK0YDswfjmR+0sHMVYtCPDz4nZKTlPy/sZS42uJ
   8ePHzSh4lDNvUtRQFwddkh7REOfMQlaDg/JiVBLhbmm4kHOhsZDJ8bXUc
   g==;
X-CSE-ConnectionGUID: A3+2qF1mR9eRHC4YKzL00Q==
X-CSE-MsgGUID: 7/Eb9bcoTuCYHC1Ti7Rtbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38058805"
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; 
   d="scan'208";a="38058805"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 19:02:26 -0700
X-CSE-ConnectionGUID: /CGnJXOTQ+WjO9rL9wYQ3w==
X-CSE-MsgGUID: em3GyqhvRGinBErnz1ijwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; 
   d="scan'208";a="75668024"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 06 Oct 2024 19:02:24 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxd4n-0004VM-26;
	Mon, 07 Oct 2024 02:02:21 +0000
Date: Mon, 7 Oct 2024 10:01:49 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 4/7] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
Message-ID: <202410070929.jEKAJxjG-lkp@intel.com>
References: <20241004050742.140664-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004050742.140664-5-dlemoal@kernel.org>

Hi Damien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus mani-mhi/mhi-next linus/master v6.12-rc2 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/PCI-endpoint-Introduce-pci_epc_function_is_valid/20241004-130947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241004050742.140664-5-dlemoal%40kernel.org
patch subject: [PATCH v3 4/7] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
config: x86_64-randconfig-122-20241007 (https://download.01.org/0day-ci/archive/20241007/202410070929.jEKAJxjG-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241007/202410070929.jEKAJxjG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410070929.jEKAJxjG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/endpoint/pci-epc-core.c:569:34: sparse: sparse: Using plain integer as NULL pointer
   drivers/pci/endpoint/pci-epc-core.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +569 drivers/pci/endpoint/pci-epc-core.c

   524	
   525	/**
   526	 * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
   527	 * @epc: the EPC device on which the CPU address is to be allocated and mapped
   528	 * @func_no: the physical endpoint function number in the EPC device
   529	 * @vfunc_no: the virtual endpoint function number in the physical function
   530	 * @pci_addr: PCI address to which the CPU address should be mapped
   531	 * @pci_size: the number of bytes to map starting from @pci_addr
   532	 * @map: where to return the mapping information
   533	 *
   534	 * Allocate a controller memory address region and map it to a RC PCI address
   535	 * region, taking into account the controller physical address mapping
   536	 * constraints using pci_epc_map_align().
   537	 * The effective size of the PCI address range mapped from @pci_addr is
   538	 * indicated by @map->pci_size. This size may be less than the requested
   539	 * @pci_size. The local virtual CPU address for the mapping is indicated by
   540	 * @map->virt_addr (@map->phys_addr indicates the physical address).
   541	 * The size and CPU address of the controller memory allocated and mapped are
   542	 * respectively indicated by @map->map_size and @map->virt_base (and
   543	 * @map->phys_base).
   544	 *
   545	 * Returns 0 on success and a negative error code in case of error.
   546	 */
   547	int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
   548			    u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
   549	{
   550		int ret;
   551	
   552		ret = pci_epc_map_align(epc, func_no, vfunc_no, pci_addr, pci_size, map);
   553		if (ret)
   554			return ret;
   555	
   556		map->virt_base = pci_epc_mem_alloc_addr(epc, &map->phys_base,
   557							map->map_size);
   558		if (!map->virt_base)
   559			return -ENOMEM;
   560	
   561		map->phys_addr = map->phys_base + map->map_ofst;
   562		map->virt_addr = map->virt_base + map->map_ofst;
   563	
   564		ret = pci_epc_map_addr(epc, func_no, vfunc_no, map->phys_base,
   565				       map->map_pci_addr, map->map_size);
   566		if (ret) {
   567			pci_epc_mem_free_addr(epc, map->phys_base, map->virt_base,
   568					      map->map_size);
 > 569			map->virt_base = 0;
   570			return ret;
   571		}
   572	
   573		return 0;
   574	}
   575	EXPORT_SYMBOL_GPL(pci_epc_mem_map);
   576	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

