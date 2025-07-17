Return-Path: <linux-pci+bounces-32419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3388BB0933C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 19:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0113A6071
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880D12FCE14;
	Thu, 17 Jul 2025 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9/G+298"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA41DE3C3
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773475; cv=none; b=cDiOEOaQxU3Xrdpyv25FMgDGa5mafbfatSKjn5Hq1XWzJckvfUhdKE+5iEfSmPj3jT8kvccgCfS9sb6ucuZSoEr+eknFWhHYSfjPpdGcFeJTCTV8N6a4FhED8hP9r+K3aLWKm2/LoDWXjSfiAjnI6rVA3hdNF5c1Y28VSfxAzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773475; c=relaxed/simple;
	bh=mZlLBjEGt3eBWCZWYcB71kIeOMih/Nb65JEO3Sp72KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLaiWA+U910ZanPPgbK5okXXCL7EL7KX5fvnXbA1Ik657qGcOlt7qCIZTHYmeWt7j29y12p/Vg/hKKGJdQ+T7eZDt5Te5Ak8Gg4t2d7C2EMVZxM7Ts5inHy6XvdoxKmt4noRwOuRCN3C2c/ymDtQpojZ1/uduTAGaJMf1w5tE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9/G+298; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752773474; x=1784309474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mZlLBjEGt3eBWCZWYcB71kIeOMih/Nb65JEO3Sp72KY=;
  b=X9/G+298VxVtPjwlq6AtruulqVmX6CyBz2oZvM9CPkwfnRc1bt949462
   SxkEhMqfZ+8Gbp5zHL4XYRJbLL+QrTAVgUquGR5bxSejeU4ZnsCoaO/uG
   9qEButzEah3fz+Csem91gSo31xJzsf3GG7x28damqUaJRbzKU/69b5KVz
   poFCG5YtWmGNu83HolYWcBIkfQS+4oYS6D9nAn7wDJhlBD1j9JvCMpbhH
   xlrQJGHSvxjpM55vS1Y51AqypEv9IkUf+zxRqZpWlKXaZ/IEjZyq0BQR7
   RZUrbr3Wxn1wmbc+g4nPF0JJ3PZE9LyAOsFZL4mBWipESgvoRM/Gb8vQO
   Q==;
X-CSE-ConnectionGUID: MokE9WXJSfWS/luFo/XKnA==
X-CSE-MsgGUID: oSKpLSGKSbW0JzasgXtpkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55205947"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="55205947"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 10:31:13 -0700
X-CSE-ConnectionGUID: Xh0G8rkiTmOBtDr9uo7KEw==
X-CSE-MsgGUID: BB/HBUHIQoi0lTcuThjEjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="194986268"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 17 Jul 2025 10:31:11 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucSRo-000Dsl-1Z;
	Thu, 17 Jul 2025 17:31:08 +0000
Date: Fri, 18 Jul 2025 01:30:56 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bhelgaas@google.com,
	ashishk@purestorage.com, macro@orcam.me.uk,
	bamstadt@purestorage.com, msaggi@purestorage.com,
	sconnor@purestorage.com, Matthew W Carlis <mattc@purestorage.com>
Subject: Re: [PATCH 1/1] PCI: Add CONFIG_PCI_NOSPEED_QUIRK to remove
 pcie_failed_link_retrain
Message-ID: <202507180125.48CXWNxm-lkp@intel.com>
References: <20250716190206.15269-2-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716190206.15269-2-mattc@purestorage.com>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.16-rc6 next-20250717]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-W-Carlis/PCI-Add-CONFIG_PCI_NOSPEED_QUIRK-to-remove-pcie_failed_link_retrain/20250717-030438
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250716190206.15269-2-mattc%40purestorage.com
patch subject: [PATCH 1/1] PCI: Add CONFIG_PCI_NOSPEED_QUIRK to remove pcie_failed_link_retrain
config: sparc-randconfig-002-20250717 (https://download.01.org/0day-ci/archive/20250718/202507180125.48CXWNxm-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250718/202507180125.48CXWNxm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507180125.48CXWNxm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/probe.c: In function 'pci_device_add':
>> drivers/pci/probe.c:2688:2: error: implicit declaration of function 'pcie_failed_link_retrain'; did you mean 'pci_enable_link_state'? [-Werror=implicit-function-declaration]
     pcie_failed_link_retrain(dev);
     ^~~~~~~~~~~~~~~~~~~~~~~~
     pci_enable_link_state
   cc1: some warnings being treated as errors
--
   drivers/pci/pci.c: In function 'pci_dev_wait':
>> drivers/pci/pci.c:1325:9: error: implicit declaration of function 'pcie_failed_link_retrain'; did you mean 'pci_enable_link_state'? [-Werror=implicit-function-declaration]
        if (pcie_failed_link_retrain(bridge) == 0) {
            ^~~~~~~~~~~~~~~~~~~~~~~~
            pci_enable_link_state
   cc1: some warnings being treated as errors


vim +2688 drivers/pci/probe.c

44aa0c657e3e45 Marc Zyngier      2015-07-28  2670  
96bde06a2df1b3 Sam Ravnborg      2007-03-26  2671  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
^1da177e4c3f41 Linus Torvalds    2005-04-16  2672  {
4f535093cf8f6d Yinghai Lu        2013-01-21  2673  	int ret;
4f535093cf8f6d Yinghai Lu        2013-01-21  2674  
6cd33649fa83d9 Bjorn Helgaas     2014-08-27  2675  	pci_configure_device(dev);
6cd33649fa83d9 Bjorn Helgaas     2014-08-27  2676  
cdb9b9f730eac4 Paul Mackerras    2005-09-06  2677  	device_initialize(&dev->dev);
cdb9b9f730eac4 Paul Mackerras    2005-09-06  2678  	dev->dev.release = pci_release_dev;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2679  
7629d19a4df922 Yinghai Lu        2013-01-21  2680  	set_dev_node(&dev->dev, pcibus_to_node(bus));
cdb9b9f730eac4 Paul Mackerras    2005-09-06  2681  	dev->dev.dma_mask = &dev->dma_mask;
4d57cdfacaa1c2 FUJITA Tomonori   2008-02-04  2682  	dev->dev.dma_parms = &dev->dma_parms;
cdb9b9f730eac4 Paul Mackerras    2005-09-06  2683  	dev->dev.coherent_dma_mask = 0xffffffffull;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2684  
b0da3498c587c2 Christoph Hellwig 2018-10-09  2685  	dma_set_max_seg_size(&dev->dev, 65536);
a6f44cf9f5cc60 Christoph Hellwig 2018-10-09  2686  	dma_set_seg_boundary(&dev->dev, 0xffffffff);
4d57cdfacaa1c2 FUJITA Tomonori   2008-02-04  2687  
a89c82249c3763 Maciej W. Rozycki 2023-06-11 @2688  	pcie_failed_link_retrain(dev);
a89c82249c3763 Maciej W. Rozycki 2023-06-11  2689  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2690  	/* Fix up broken headers */
^1da177e4c3f41 Linus Torvalds    2005-04-16  2691  	pci_fixup_device(pci_fixup_header, dev);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2692  
2069ecfbe14ebd Yinghai Lu        2012-02-15  2693  	pci_reassigndev_resource_alignment(dev);
2069ecfbe14ebd Yinghai Lu        2012-02-15  2694  
4b77b0a2ba27d6 Rafael J. Wysocki 2009-09-09  2695  	dev->state_saved = false;
4b77b0a2ba27d6 Rafael J. Wysocki 2009-09-09  2696  
201de56eb22f1f Zhao, Yu          2008-10-13  2697  	pci_init_capabilities(dev);
eb9d0fe40e313c Rafael J. Wysocki 2008-07-07  2698  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2699  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  2700  	 * Add the device to our list of discovered devices
^1da177e4c3f41 Linus Torvalds    2005-04-16  2701  	 * and the bus list for fixup functions, etc.
^1da177e4c3f41 Linus Torvalds    2005-04-16  2702  	 */
d71374dafbba7e Zhang Yanmin      2006-06-02  2703  	down_write(&pci_bus_sem);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2704  	list_add_tail(&dev->bus_list, &bus->devices);
d71374dafbba7e Zhang Yanmin      2006-06-02  2705  	up_write(&pci_bus_sem);
4f535093cf8f6d Yinghai Lu        2013-01-21  2706  
06dc660e6eb881 Oliver O'Halloran 2021-09-14  2707  	ret = pcibios_device_add(dev);
4f535093cf8f6d Yinghai Lu        2013-01-21  2708  	WARN_ON(ret < 0);
4f535093cf8f6d Yinghai Lu        2013-01-21  2709  
3e466e2d3a04c7 Bjorn Helgaas     2017-11-30  2710  	/* Set up MSI IRQ domain */
44aa0c657e3e45 Marc Zyngier      2015-07-28  2711  	pci_set_msi_domain(dev);
44aa0c657e3e45 Marc Zyngier      2015-07-28  2712  
4f535093cf8f6d Yinghai Lu        2013-01-21  2713  	/* Notifier could use PCI capabilities */
4f535093cf8f6d Yinghai Lu        2013-01-21  2714  	ret = device_add(&dev->dev);
4f535093cf8f6d Yinghai Lu        2013-01-21  2715  	WARN_ON(ret < 0);
4e893545ef8712 Mariusz Tkaczyk   2024-09-04  2716  
4e893545ef8712 Mariusz Tkaczyk   2024-09-04  2717  	pci_npem_create(dev);
2311ab1820fed2 Alistair Francis  2025-03-06  2718  
2311ab1820fed2 Alistair Francis  2025-03-06  2719  	pci_doe_sysfs_init(dev);
cdb9b9f730eac4 Paul Mackerras    2005-09-06  2720  }
cdb9b9f730eac4 Paul Mackerras    2005-09-06  2721  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

