Return-Path: <linux-pci+bounces-9283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB081917D4E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509EB281E69
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894AD17836D;
	Wed, 26 Jun 2024 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDeOPG6f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC92176AD3;
	Wed, 26 Jun 2024 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396580; cv=none; b=cJfYQQkpTyj6VaM91tpxCSz6lAPo2zVrSXzauVP6HDp5nDgZs2EdhCScB6OvvulLwVX4CvG84FCIwOlrFHmGZVI8jonh6UIAyD1AqCGBdsd6/3n4NWLFhb/rxo9pCTQuTg0r3N3lXpt/K+zokFpF4wkJGxwy148af+4LcUKalgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396580; c=relaxed/simple;
	bh=fOsd+1HfbGLO7Zy0e3bNwQPIz9RvmS2cgJr450bfRiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx+hMLOIKOd/ozNYKfOsE5ItB/rv5TkdC63FFJFwBJhpAHsDoNW7kOFXrLKDQU+loDnJSU4iRlKrKlZwBSWr/iv9Mfg660iUFpg1JzhX0VyrBD/9sBQtU1g8fBkI8K9Li+jwkwweL1xuPcZiJz6WAzovdLtWPyqx8zXZzkTY10Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDeOPG6f; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719396579; x=1750932579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fOsd+1HfbGLO7Zy0e3bNwQPIz9RvmS2cgJr450bfRiA=;
  b=HDeOPG6fRnXpLnG9UP4pYlfHP7DtStt3KjAejcj0ELh3EYYeAAhQBLKg
   nOvagL8RBOwV/fJ7VnGpEBq/3wZZ8YzDauLpPQgEJHjX8UKufVDku35RP
   +66KmramEMkEDAoGHaE4tp/jXp6sbCP5tW5yT9tMtXZyo2IYH0nn4651f
   CCzlH/3g6VrCAdcXUS989mqMlqcgvxZJ6EurZY3usUw9UrD0iZrI4KMz6
   pKhgHW+S4jpVv+6NZHVxdFbtc1oHMJYtRIk7s+myW0t4UdyvCPqE9f9Sg
   dFxPOT5J7kx+y5weMXFU+Z9qnPhkyAkeXVG1KP+Hc89iKOHtNVR2OtUhU
   w==;
X-CSE-ConnectionGUID: P7OtnGhtRmCiVmOLNCEJmA==
X-CSE-MsgGUID: Xvhjb7PhQ82Xt3HfU/3GLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27081106"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="27081106"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:09:38 -0700
X-CSE-ConnectionGUID: lYWXRFMqT1GDqQ7td3on1A==
X-CSE-MsgGUID: Vnu40iiwTCmFxeN3K4W/EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44064960"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 26 Jun 2024 03:09:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMPan-000FBC-3C;
	Wed, 26 Jun 2024 10:09:33 +0000
Date: Wed, 26 Jun 2024 18:09:14 +0800
From: kernel test robot <lkp@intel.com>
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	zhoushengqing@ttyinfo.com
Subject: Re: [PATCH] PCI: Enable io space 1k granularity for intel cpu root
 port
Message-ID: <202406261735.9Fu2z2ic-lkp@intel.com>
References: <20240621020608.28964-1-zhoushengqing@ttyinfo.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621020608.28964-1-zhoushengqing@ttyinfo.com>

Hi Zhou,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.10-rc5 next-20240625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhou-Shengqing/PCI-Enable-io-space-1k-granularity-for-intel-cpu-root-port/20240625-161818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240621020608.28964-1-zhoushengqing%40ttyinfo.com
patch subject: [PATCH] PCI: Enable io space 1k granularity for intel cpu root port
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240626/202406261735.9Fu2z2ic-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406261735.9Fu2z2ic-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406261735.9Fu2z2ic-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/probe.c:484:24: error: use of undeclared identifier 'dev'
     484 |                         list_for_each_entry(dev, &bridge->bus->devices, bus_list) {
         |                                             ^
>> drivers/pci/probe.c:484:24: error: use of undeclared identifier 'dev'
>> drivers/pci/probe.c:484:24: error: use of undeclared identifier 'dev'
>> drivers/pci/probe.c:484:24: error: use of undeclared identifier 'dev'
>> drivers/pci/probe.c:484:24: error: use of undeclared identifier 'dev'
>> drivers/pci/probe.c:484:24: error: use of undeclared identifier 'dev'
>> drivers/pci/probe.c:484:24: error: use of undeclared identifier 'dev'
>> drivers/pci/probe.c:484:24: error: use of undeclared identifier 'dev'
>> drivers/pci/probe.c:484:24: error: use of undeclared identifier 'dev'
   drivers/pci/probe.c:485:26: error: use of undeclared identifier 'dev'
     485 |                                 pci_read_config_word(dev, PCI_VENDOR_ID, &ven_id);
         |                                                      ^
   drivers/pci/probe.c:486:26: error: use of undeclared identifier 'dev'
     486 |                                 pci_read_config_word(dev, PCI_DEVICE_ID, &dev_id);
         |                                                      ^
   drivers/pci/probe.c:489:27: error: use of undeclared identifier 'dev'
     489 |                                         pci_read_config_word(dev, 0x1c0, &en1k);
         |                                                              ^
   12 errors generated.


vim +/dev +484 drivers/pci/probe.c

   458	
   459	static void pci_read_bridge_windows(struct pci_dev *bridge)
   460	{
   461		u32 buses;
   462		u16 io;
   463		u32 pmem, tmp;
   464		u16 ven_id, dev_id;
   465		u16 en1k = 0;
   466		struct resource res;
   467	
   468		pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
   469		res.flags = IORESOURCE_BUS;
   470		res.start = (buses >> 8) & 0xff;
   471		res.end = (buses >> 16) & 0xff;
   472		pci_info(bridge, "PCI bridge to %pR%s\n", &res,
   473			 bridge->transparent ? " (subtractive decode)" : "");
   474	
   475		pci_read_config_word(bridge, PCI_IO_BASE, &io);
   476		if (!io) {
   477			pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
   478			pci_read_config_word(bridge, PCI_IO_BASE, &io);
   479			pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
   480		}
   481		if (io) {
   482			bridge->io_window = 1;
   483			if (pci_is_root_bus(bridge->bus)) {
 > 484				list_for_each_entry(dev, &bridge->bus->devices, bus_list) {
   485					pci_read_config_word(dev, PCI_VENDOR_ID, &ven_id);
   486					pci_read_config_word(dev, PCI_DEVICE_ID, &dev_id);
   487					if (ven_id == PCI_VENDOR_ID_INTEL && dev_id == 0x09a2) {
   488						/*IIO MISC Control offset 0x1c0*/
   489						pci_read_config_word(dev, 0x1c0, &en1k);
   490					}
   491				}
   492			/*
   493			 *Intel ICX SPR EMR GNR
   494			 *IIO MISC Control (IIOMISCCTRL_1_5_0_CFG) — Offset 1C0h
   495			 *bit 2:Enable 1K (EN1K)
   496			 *This bit when set, enables 1K granularity for I/O space decode
   497			 *in each of the virtual P2P bridges
   498			 *corresponding to root ports, and DMI ports.
   499			 */
   500			if (en1k & 0x4)
   501				bridge->io_window_1k = 1;
   502			}
   503			pci_read_bridge_io(bridge, &res, true);
   504		}
   505	
   506		pci_read_bridge_mmio(bridge, &res, true);
   507	
   508		/*
   509		 * DECchip 21050 pass 2 errata: the bridge may miss an address
   510		 * disconnect boundary by one PCI data phase.  Workaround: do not
   511		 * use prefetching on this device.
   512		 */
   513		if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
   514			return;
   515	
   516		pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
   517		if (!pmem) {
   518			pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE,
   519						       0xffe0fff0);
   520			pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
   521			pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
   522		}
   523		if (!pmem)
   524			return;
   525	
   526		bridge->pref_window = 1;
   527	
   528		if ((pmem & PCI_PREF_RANGE_TYPE_MASK) == PCI_PREF_RANGE_TYPE_64) {
   529	
   530			/*
   531			 * Bridge claims to have a 64-bit prefetchable memory
   532			 * window; verify that the upper bits are actually
   533			 * writable.
   534			 */
   535			pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &pmem);
   536			pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
   537					       0xffffffff);
   538			pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &tmp);
   539			pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, pmem);
   540			if (tmp)
   541				bridge->pref_64_window = 1;
   542		}
   543	
   544		pci_read_bridge_mmio_pref(bridge, &res, true);
   545	}
   546	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

