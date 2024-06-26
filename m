Return-Path: <linux-pci+bounces-9274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A94D917AF1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835F11C23D2F
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 08:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386691607BD;
	Wed, 26 Jun 2024 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wj7wVPdg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB814D710;
	Wed, 26 Jun 2024 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390523; cv=none; b=CigEjtgf4Fe23FGOrs81zTwUf7TF/Ho4Is6cALLp7sbh4+8h/e3CsdHrpGrMCtJZny730P4SB7N9rAePAqhSNkQ1+NaLcm1a6U++wUsUPQ4s0adcln0XLbiXOQcHr0KfDciIgu9VZaSS2Z0xZklZBUjzwFGJT6SY5qx46LnI8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390523; c=relaxed/simple;
	bh=R3nU5Sf9uosZLaaurdEW6+sHSnGv6U4iIGH+PoQgGz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7mfeXeQd5QLy9oKDvvrRlpItyF/J82bS3bBw3LCCAu7vYJXWBZPbOHuTYz2j0m+1egp5sUSv3CpYqIxbWTzC90Qc+2ITgBuPYj8hjc7HPowhMupPH8x5TrKGt5gGaCbZso8zbcGnN/S1dj2scqRdmOVS7kJ8+K0I5ukDHhYmuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wj7wVPdg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719390521; x=1750926521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=R3nU5Sf9uosZLaaurdEW6+sHSnGv6U4iIGH+PoQgGz0=;
  b=Wj7wVPdgwzHKrwLdL5wgT7ldjL/bEMP7C/SYAJipjkFPre5n6NAOQv+L
   rwXG3gthc5+BqqAPa7l809MKfm0b/J0Z5seOhtyg2Mrh5Ar6vToCEs1A1
   vuIgpgSOw6wx8vUS3MQsAMbfPEo5SxJ1xUfT5s8tuRxw+8BGP4+whCqeE
   iX5FWZPSBvT9xWXLcDGv+lA/hAwvAgAoVCoVoWX8hNZqyWDkZOlYuibub
   osjnJ2D+8ARE2ZP34rGs7egizj0NTabCulqkCXem0AXUzofL3EY5uX2Mx
   wM/mIxgnLhA+Cxoo8cniLIUWaNLmrUwBNVnz+OHzbRN5mzggU/rqVxeZX
   g==;
X-CSE-ConnectionGUID: gh5/09/mQJCz3/Gad4AtHA==
X-CSE-MsgGUID: aSfNBeGQRYyblanhb1H04g==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27135206"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="27135206"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 01:28:41 -0700
X-CSE-ConnectionGUID: Ss7L8LqxQ/G3NECRBKrxgQ==
X-CSE-MsgGUID: 6CcEeqN4SoiqD9NLgDoX9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="43743504"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Jun 2024 01:28:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMO17-000F7a-01;
	Wed, 26 Jun 2024 08:28:37 +0000
Date: Wed, 26 Jun 2024 16:27:50 +0800
From: kernel test robot <lkp@intel.com>
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, zhoushengqing@ttyinfo.com
Subject: Re: [PATCH] PCI: Enable io space 1k granularity for intel cpu root
 port
Message-ID: <202406261552.dr7kOKOM-lkp@intel.com>
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240626/202406261552.dr7kOKOM-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406261552.dr7kOKOM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406261552.dr7kOKOM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/smp.h:12,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/sched.h:2142,
                    from include/linux/delay.h:23,
                    from drivers/pci/probe.c:7:
   drivers/pci/probe.c: In function 'pci_read_bridge_windows':
>> drivers/pci/probe.c:484:45: error: 'dev' undeclared (first use in this function); did you mean 'cdev'?
     484 |                         list_for_each_entry(dev, &bridge->bus->devices, bus_list) {
         |                                             ^~~
   include/linux/list.h:778:14: note: in definition of macro 'list_for_each_entry'
     778 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |              ^~~
   drivers/pci/probe.c:484:45: note: each undeclared identifier is reported only once for each function it appears in
     484 |                         list_for_each_entry(dev, &bridge->bus->devices, bus_list) {
         |                                             ^~~
   include/linux/list.h:778:14: note: in definition of macro 'list_for_each_entry'
     778 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |              ^~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/kernel.h:22,
                    from drivers/pci/probe.c:6:
   include/linux/compiler_types.h:428:27: error: expression in static assertion is not an integer
     428 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:612:9: note: in expansion of macro 'list_entry'
     612 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:778:20: note: in expansion of macro 'list_first_entry'
     778 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/pci/probe.c:484:25: note: in expansion of macro 'list_for_each_entry'
     484 |                         list_for_each_entry(dev, &bridge->bus->devices, bus_list) {
         |                         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:428:27: error: expression in static assertion is not an integer
     428 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:780:20: note: in expansion of macro 'list_next_entry'
     780 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/pci/probe.c:484:25: note: in expansion of macro 'list_for_each_entry'
     484 |                         list_for_each_entry(dev, &bridge->bus->devices, bus_list) {
         |                         ^~~~~~~~~~~~~~~~~~~


vim +484 drivers/pci/probe.c

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

