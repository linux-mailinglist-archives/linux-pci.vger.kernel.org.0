Return-Path: <linux-pci+bounces-44937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB30D242DF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 12:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2EA7300F9FD
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955D3352FA5;
	Thu, 15 Jan 2026 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpJQNMol"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197936CDEC
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476604; cv=none; b=WJxw2BwesMH60n20u6hy+8EnXAsHI8O9KxweVn0op3a8PlGbtbmYmdCobohy0E4k1iQxscxG+GUcdTX3ltz7tQSgU1HBCuJys62qz/NC9L9KSIh6RzDo6S5HL3qMbidfBNw294X4igLPFPw5uIJpYW8trSXAq1TQdCDFTZzVoWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476604; c=relaxed/simple;
	bh=1x4kCfbALV/YdOTPH9CCOw9FtU7H29jvfqGwJZLYVkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw0ge1CWkUV73g+FMgGwoKq/vS8lDFg4G5GEIBRPhHD7zFEGmAF4YhhZzp9QJ4Fy/d1g19wEUc+7sOi++lrdVEPYARFZ8ZL/5ChYrr2VpAkwPvrlB1Wu7o+R0E+8h4vtUZSrrv4wJWGReYftDFklqFkaWDepLGONLpcXbjl+T/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpJQNMol; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768476603; x=1800012603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1x4kCfbALV/YdOTPH9CCOw9FtU7H29jvfqGwJZLYVkE=;
  b=MpJQNMolRKQiCJ3h98AoyZPKg3+X1SVlY5aVj1EgpQdXXwthumOF0VFa
   0gvCkNwPI7dOXACo+ztYkBJ1/q7BL1vQR0Y4A64bB0x6q5wgAjnb6ll6k
   JVS9JU+uQqSu0Eeq0RF0fCZ3BYSFfBUBkG9a+pGbZxr8/n0YQbdhPhpbQ
   kX6v1r0DDbXw/yfdqNVgOpH0Au8HvP0a+YdnhGynnk+8vS1MW+VoVKXmu
   R6wMI9/XNeWmp3yTvo/XCGWPYc51TtX2hUtbfJRmbJzE/LEk5jSiBj5OW
   43exgiAJQgFMZBYmbabVFE3yqxhWZXznfgLXBwUnei8j0jPYFQK9IX3eY
   Q==;
X-CSE-ConnectionGUID: 0BRjQf/hRnmvOP0meSPbzA==
X-CSE-MsgGUID: i24tpJuHQaOg8lrym/o6GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870236"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="69870236"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 03:30:02 -0800
X-CSE-ConnectionGUID: CuJLsxEcQ6S4tw4pZcLJsA==
X-CSE-MsgGUID: tZvE29toTfC9YBTOUBQomQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="204810359"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Jan 2026 03:30:00 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgLY6-00000000Ht0-0egd;
	Thu, 15 Jan 2026 11:29:58 +0000
Date: Thu, 15 Jan 2026 19:29:41 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] pci: make reset_subordinate hotplug safe
Message-ID: <202601151946.zSD1T6Tn-lkp@intel.com>
References: <20260114185821.704089-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114185821.704089-1-kbusch@meta.com>

Hi Keith,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.19-rc5 next-20260115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/pci-make-reset_subordinate-hotplug-safe/20260115-030004
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260114185821.704089-1-kbusch%40meta.com
patch subject: [PATCH] pci: make reset_subordinate hotplug safe
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20260115/202601151946.zSD1T6Tn-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260115/202601151946.zSD1T6Tn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601151946.zSD1T6Tn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pci.c:5585:5: warning: no previous prototype for function '__pci_reset_bus' [-Wmissing-prototypes]
    5585 | int __pci_reset_bus(struct pci_bus *bus)
         |     ^
   drivers/pci/pci.c:5585:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    5585 | int __pci_reset_bus(struct pci_bus *bus)
         | ^
         | static 
   1 warning generated.


vim +/__pci_reset_bus +5585 drivers/pci/pci.c

9a3d2b9beefd5b0 Alex Williamson 2013-08-14  5578  
090a3c5322e900f Alex Williamson 2013-08-08  5579  /**
c6a44ba950d147e Sinan Kaya      2018-07-19  5580   * __pci_reset_bus - Try to reset a PCI bus
090a3c5322e900f Alex Williamson 2013-08-08  5581   * @bus: top level PCI bus to reset
090a3c5322e900f Alex Williamson 2013-08-08  5582   *
61cf16d8bd38c3d Alex Williamson 2013-12-16  5583   * Same as above except return -EAGAIN if the bus cannot be locked
090a3c5322e900f Alex Williamson 2013-08-08  5584   */
2fa046449a82a7d Keith Busch     2024-10-25 @5585  int __pci_reset_bus(struct pci_bus *bus)
090a3c5322e900f Alex Williamson 2013-08-08  5586  {
090a3c5322e900f Alex Williamson 2013-08-08  5587  	int rc;
090a3c5322e900f Alex Williamson 2013-08-08  5588  
9bdc81ce440ec6e Amey Narkhede   2021-08-17  5589  	rc = pci_bus_reset(bus, PCI_RESET_PROBE);
090a3c5322e900f Alex Williamson 2013-08-08  5590  	if (rc)
090a3c5322e900f Alex Williamson 2013-08-08  5591  		return rc;
090a3c5322e900f Alex Williamson 2013-08-08  5592  
61cf16d8bd38c3d Alex Williamson 2013-12-16  5593  	if (pci_bus_trylock(bus)) {
ddefc033eecf23f Alex Williamson 2019-02-18  5594  		pci_bus_save_and_disable_locked(bus);
61cf16d8bd38c3d Alex Williamson 2013-12-16  5595  		might_sleep();
381634cad15b711 Sinan Kaya      2018-07-19  5596  		rc = pci_bridge_secondary_bus_reset(bus->self);
ddefc033eecf23f Alex Williamson 2019-02-18  5597  		pci_bus_restore_locked(bus);
61cf16d8bd38c3d Alex Williamson 2013-12-16  5598  		pci_bus_unlock(bus);
61cf16d8bd38c3d Alex Williamson 2013-12-16  5599  	} else
61cf16d8bd38c3d Alex Williamson 2013-12-16  5600  		rc = -EAGAIN;
090a3c5322e900f Alex Williamson 2013-08-08  5601  
090a3c5322e900f Alex Williamson 2013-08-08  5602  	return rc;
090a3c5322e900f Alex Williamson 2013-08-08  5603  }
8dd7f8036c12329 Sheng Yang      2008-10-21  5604  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

