Return-Path: <linux-pci+bounces-14897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AF99A4B96
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 08:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E2A283BAE
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 06:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F511D47BC;
	Sat, 19 Oct 2024 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVkzCIiS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E811D2704
	for <linux-pci@vger.kernel.org>; Sat, 19 Oct 2024 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729320029; cv=none; b=fWn+NsrZA0bb3FjOD2cCJFa4lXfgygYiwi2vj5GL8F6cKns6olLunj3+o8P1ClEEsJtiQpbxucL0Rzvv3Ua0zK5tTdGNTHafwV//Vd29bFdw/kXCSOgBkQq+UtUENnS4Si+9FV7Ur29lIcgd4Pqc6aBwH+vlI9hR6cPzyQd908E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729320029; c=relaxed/simple;
	bh=D5FqVUHEb5PhIa8e816qkRe/BB6uCpIxWn//F32Wgu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvLi9f+Q+e9kJFNOVIHTA6aRe0a0FBGkqyQMKHM4UcwKMd6jfiO1czCoHQ0NtKcHx6vgBzK0+ObRqNBRY8+E/V5wlNHf+YxVdoAlVMEHWfvr6S8T/QHnzA2LBhYkvLlvvbKO0zkb/gzZnPjrDnuVMQ2yoqHhIC3HhwnG2Tkjt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVkzCIiS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729320026; x=1760856026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D5FqVUHEb5PhIa8e816qkRe/BB6uCpIxWn//F32Wgu4=;
  b=kVkzCIiSlH5FRpT/j6idJYZpl2uzd46jbriDoetEQVLfpQEuGy8qGmyT
   BkKHJnshFoHXNLLK1WY+nRHCyi64rMG76H13HGKXF4MWdsVDQjjWL4dVM
   sCva8n5pJdXXsU9TwfQf3TxWx13lySPKa/YQskjCRV40mqsI8FXr6hgy8
   S024115efdmNz/iA0UEwQGqGRbVptwyhXe8u+YhgJX3tq6McGAYH/dSj/
   OURuq/F0he5FmJ49B1JCmJESuOJovxHOeLQKaXSUgGyj3f6b3TYJR39y/
   U4zp4928xA5CV6ro9+8Mhkv48m8KURbkmflXqAbmTPayJjwAoutWtG1h4
   w==;
X-CSE-ConnectionGUID: meFV4HNRQh+MfoqrsdaMtQ==
X-CSE-MsgGUID: BCXd9+oiROKmkYZ5uWMQIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="16470604"
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="16470604"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 23:40:25 -0700
X-CSE-ConnectionGUID: +6IffJ2AQK+66CtzAPmD8g==
X-CSE-MsgGUID: C48p0Nm8QT+9SILCFHjwRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="79471816"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 Oct 2024 23:40:23 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t238P-000Ol3-2O;
	Sat, 19 Oct 2024 06:40:21 +0000
Date: Sat, 19 Oct 2024 14:39:38 +0800
From: kernel test robot <lkp@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: optimize proc sequential file read
Message-ID: <202410191439.yQ27wvB6-lkp@intel.com>
References: <20241018054728.116519-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018054728.116519-1-kanie@linux.alibaba.com>

Hi Guixin,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.12-rc3 next-20241018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guixin-Liu/PCI-optimize-proc-sequential-file-read/20241018-135026
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241018054728.116519-1-kanie%40linux.alibaba.com
patch subject: [PATCH] PCI: optimize proc sequential file read
config: i386-buildonly-randconfig-003-20241019 (https://download.01.org/0day-ci/archive/20241019/202410191439.yQ27wvB6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410191439.yQ27wvB6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410191439.yQ27wvB6-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/pci/probe.o: in function `pci_device_add':
>> drivers/pci/probe.c:2595: undefined reference to `pci_seq_tree_add_dev'
   ld: drivers/pci/remove.o: in function `pci_destroy_dev':
>> drivers/pci/remove.c:56: undefined reference to `pci_seq_tree_remove_dev'


vim +2595 drivers/pci/probe.c

  2546	
  2547	void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
  2548	{
  2549		int ret;
  2550	
  2551		pci_configure_device(dev);
  2552	
  2553		device_initialize(&dev->dev);
  2554		dev->dev.release = pci_release_dev;
  2555	
  2556		set_dev_node(&dev->dev, pcibus_to_node(bus));
  2557		dev->dev.dma_mask = &dev->dma_mask;
  2558		dev->dev.dma_parms = &dev->dma_parms;
  2559		dev->dev.coherent_dma_mask = 0xffffffffull;
  2560	
  2561		dma_set_max_seg_size(&dev->dev, 65536);
  2562		dma_set_seg_boundary(&dev->dev, 0xffffffff);
  2563	
  2564		pcie_failed_link_retrain(dev);
  2565	
  2566		/* Fix up broken headers */
  2567		pci_fixup_device(pci_fixup_header, dev);
  2568	
  2569		pci_reassigndev_resource_alignment(dev);
  2570	
  2571		dev->state_saved = false;
  2572	
  2573		pci_init_capabilities(dev);
  2574	
  2575		/*
  2576		 * Add the device to our list of discovered devices
  2577		 * and the bus list for fixup functions, etc.
  2578		 */
  2579		down_write(&pci_bus_sem);
  2580		list_add_tail(&dev->bus_list, &bus->devices);
  2581		up_write(&pci_bus_sem);
  2582	
  2583		ret = pcibios_device_add(dev);
  2584		WARN_ON(ret < 0);
  2585	
  2586		/* Set up MSI IRQ domain */
  2587		pci_set_msi_domain(dev);
  2588	
  2589		/* Notifier could use PCI capabilities */
  2590		dev->match_driver = false;
  2591		ret = device_add(&dev->dev);
  2592		WARN_ON(ret < 0);
  2593	
  2594		pci_npem_create(dev);
> 2595		pci_seq_tree_add_dev(dev);
  2596	}
  2597	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

