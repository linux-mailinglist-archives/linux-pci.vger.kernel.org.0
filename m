Return-Path: <linux-pci+bounces-35924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A63DB53A5F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 19:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12451BC45F5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BDD32274C;
	Thu, 11 Sep 2025 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwhYat6d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2454B34AB1F;
	Thu, 11 Sep 2025 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611668; cv=none; b=Xre4kvFEk+8ow5Vy0dgnDt5SO5OQuTjvL0dwYlM17OROAsM+LolUpCflWQndtknuBC/ncfm553tVeCRqRRExJG60aenbhTjwVWmqP+ecM8gPetq/A2h1ymXZ5r0O3Dtxmw6aBBZH7lCAeTRfT/+0EoA+jVqLs5ANJw1UbqcpzSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611668; c=relaxed/simple;
	bh=ksSOC9HhtQFYQQktMTsL79phs/XjbvQsz3wxyYSeG+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+83Klh4ZYWFD6v+eaBoDRoNicTizyAtLbaDmQKKwMmimkRqwKVSoBlIMfCR+5XPrKyALHV/saXMLdlD+vCv+leX3BoNiTXbro6bVVSfzx1H+FZgGZ51eOoDrgw8YlmLhg1rblf1WK/htmkes7sJFbWhbFXuBM1dQND4N/YKcnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwhYat6d; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757611666; x=1789147666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ksSOC9HhtQFYQQktMTsL79phs/XjbvQsz3wxyYSeG+0=;
  b=JwhYat6dpDM/PGAPvYeZVYeKTc3lay57db7IPo7N3hWYR4S0doh31PRK
   DRTiGgjt9T/YcT6JquQPSPla1W56Gwbqis7ZX0l+qES+CMG2DJdSTDoLi
   XDvSrwVZuUuDTnBXQ/hA7UTWABibzNR4kVkvUJLTwnJIWzjnr4ji+7++a
   llflsFGDhCEeAlCr8UKB8BlYTA8eX7OsEIVoz2Rc2wVpCMFfbOd0ZHfM+
   VClfa2l8pCyTanoI7oFfeougZKGaey6zTjuDAIsKjPqwvfNOumoL4fp1v
   LZ7g5ozME7gskY8eHQJuVmJLgq79CVo8rWy7RcKdyj9t+et6T+9uPKHuI
   A==;
X-CSE-ConnectionGUID: F6NwfWb/RuSL0R2aOVTcKQ==
X-CSE-MsgGUID: TQbHDduRR96xYqyNm6kmxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59650060"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="59650060"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 10:27:46 -0700
X-CSE-ConnectionGUID: iAOoUCiuRAazE1mZ9IitzA==
X-CSE-MsgGUID: gkAWkz59Tu+ukrMSB2DuXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="178073668"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 11 Sep 2025 10:27:44 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwl51-0000Wm-2e;
	Thu, 11 Sep 2025 17:27:33 +0000
Date: Fri, 12 Sep 2025 01:26:38 +0800
From: kernel test robot <lkp@intel.com>
To: Roshan Kumar <roshaen09@gmail.com>, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Roshan Kumar <roshaen09@gmail.com>
Subject: Re: [PATCH] pci: access: fixed coding style issues in access.c
Message-ID: <202509120146.8WGO09ab-lkp@intel.com>
References: <20250910184809.392702-1-roshaen09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910184809.392702-1-roshaen09@gmail.com>

Hi Roshan,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.17-rc5 next-20250911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roshan-Kumar/pci-access-fixed-coding-style-issues-in-access-c/20250911-024937
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250910184809.392702-1-roshaen09%40gmail.com
patch subject: [PATCH] pci: access: fixed coding style issues in access.c
config: x86_64-buildonly-randconfig-001-20250911 (https://download.01.org/0day-ci/archive/20250912/202509120146.8WGO09ab-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250912/202509120146.8WGO09ab-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509120146.8WGO09ab-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/access.c:227:1: error: expected ';' before 'int'
     227 | int pci_user_read_config_##size                                         \
         | ^~~
   drivers/pci/access.c:273:1: note: in expansion of macro 'PCI_USER_READ_CONFIG'
     273 | PCI_USER_READ_CONFIG(word, u16)
         | ^~~~~~~~~~~~~~~~~~~~
>> drivers/pci/access.c:227:1: error: expected ';' before 'int'
     227 | int pci_user_read_config_##size                                         \
         | ^~~
   drivers/pci/access.c:274:1: note: in expansion of macro 'PCI_USER_READ_CONFIG'
     274 | PCI_USER_READ_CONFIG(dword, u32)
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/pci/access.c:253:1: error: expected ';' before 'int'
     253 | int pci_user_write_config_##size                                        \
         | ^~~
   drivers/pci/access.c:275:1: note: in expansion of macro 'PCI_USER_WRITE_CONFIG'
     275 | PCI_USER_WRITE_CONFIG(byte, u8)
         | ^~~~~~~~~~~~~~~~~~~~~
   drivers/pci/access.c:253:1: error: expected ';' before 'int'
     253 | int pci_user_write_config_##size                                        \
         | ^~~
   drivers/pci/access.c:276:1: note: in expansion of macro 'PCI_USER_WRITE_CONFIG'
     276 | PCI_USER_WRITE_CONFIG(word, u16)
         | ^~~~~~~~~~~~~~~~~~~~~
   drivers/pci/access.c:253:1: error: expected ';' before 'int'
     253 | int pci_user_write_config_##size                                        \
         | ^~~
   drivers/pci/access.c:277:1: note: in expansion of macro 'PCI_USER_WRITE_CONFIG'
     277 | PCI_USER_WRITE_CONFIG(dword, u32)
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/access.c:287:1: error: expected ';' before 'void'
     287 | void pci_cfg_access_lock(struct pci_dev *dev)
         | ^~~~


vim +227 drivers/pci/access.c

e04b0ea2e0f9c1 Brian King      2005-09-27  224  
34e3207205ef49 Greg Thelen     2011-04-17  225  /* Returns 0 on success, negative values indicate error. */
e04b0ea2e0f9c1 Brian King      2005-09-27  226  #define PCI_USER_READ_CONFIG(size, type)				\
e04b0ea2e0f9c1 Brian King      2005-09-27 @227  int pci_user_read_config_##size						\
e04b0ea2e0f9c1 Brian King      2005-09-27  228  	(struct pci_dev *dev, int pos, type * val)			\
e04b0ea2e0f9c1 Brian King      2005-09-27  229  {									\
e04b0ea2e0f9c1 Brian King      2005-09-27  230  	u32 data = -1;							\
4c407392c1aff3 Ilpo Järvinen   2024-04-29  231  	int ret;							\
4c407392c1aff3 Ilpo Järvinen   2024-04-29  232  									\
34e3207205ef49 Greg Thelen     2011-04-17  233  	if (PCI_##size##_BAD)						\
34e3207205ef49 Greg Thelen     2011-04-17  234  		return -EINVAL;						\
4c407392c1aff3 Ilpo Järvinen   2024-04-29  235  									\
511dd98ce8cf6d Thomas Gleixner 2010-02-17  236  	raw_spin_lock_irq(&pci_lock);					\
fb51ccbf217c1c Jan Kiszka      2011-11-04  237  	if (unlikely(dev->block_cfg_access))				\
fb51ccbf217c1c Jan Kiszka      2011-11-04  238  		pci_wait_cfg(dev);					\
e04b0ea2e0f9c1 Brian King      2005-09-27  239  	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
e04b0ea2e0f9c1 Brian King      2005-09-27  240  				  pos, sizeof(type), &data);		\
511dd98ce8cf6d Thomas Gleixner 2010-02-17  241  	raw_spin_unlock_irq(&pci_lock);					\
f4f7eb43c5238f Naveen Naidu    2021-11-18  242  	if (ret)							\
f4f7eb43c5238f Naveen Naidu    2021-11-18  243  		PCI_SET_ERROR_RESPONSE(val);				\
f4f7eb43c5238f Naveen Naidu    2021-11-18  244  	else								\
e04b0ea2e0f9c1 Brian King      2005-09-27  245  		*val = (type)data;					\
4c407392c1aff3 Ilpo Järvinen   2024-04-29  246  									\
d97ffe23689485 Gavin Shan      2014-05-21  247  	return pcibios_err_to_errno(ret);				\
c63587d7f5b9db Alex Williamson 2012-06-11  248  }									\
08fa50b5c3a3d8 Roshan Kumar    2025-09-10  249  EXPORT_SYMBOL_GPL(pci_user_read_config_##size)
e04b0ea2e0f9c1 Brian King      2005-09-27  250  
34e3207205ef49 Greg Thelen     2011-04-17  251  /* Returns 0 on success, negative values indicate error. */
e04b0ea2e0f9c1 Brian King      2005-09-27  252  #define PCI_USER_WRITE_CONFIG(size, type)				\
e04b0ea2e0f9c1 Brian King      2005-09-27  253  int pci_user_write_config_##size					\
e04b0ea2e0f9c1 Brian King      2005-09-27  254  	(struct pci_dev *dev, int pos, type val)			\
e04b0ea2e0f9c1 Brian King      2005-09-27  255  {									\
4c407392c1aff3 Ilpo Järvinen   2024-04-29  256  	int ret;							\
4c407392c1aff3 Ilpo Järvinen   2024-04-29  257  									\
34e3207205ef49 Greg Thelen     2011-04-17  258  	if (PCI_##size##_BAD)						\
34e3207205ef49 Greg Thelen     2011-04-17  259  		return -EINVAL;						\
4c407392c1aff3 Ilpo Järvinen   2024-04-29  260  									\
511dd98ce8cf6d Thomas Gleixner 2010-02-17  261  	raw_spin_lock_irq(&pci_lock);					\
fb51ccbf217c1c Jan Kiszka      2011-11-04  262  	if (unlikely(dev->block_cfg_access))				\
fb51ccbf217c1c Jan Kiszka      2011-11-04  263  		pci_wait_cfg(dev);					\
e04b0ea2e0f9c1 Brian King      2005-09-27  264  	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
e04b0ea2e0f9c1 Brian King      2005-09-27  265  				   pos, sizeof(type), val);		\
511dd98ce8cf6d Thomas Gleixner 2010-02-17  266  	raw_spin_unlock_irq(&pci_lock);					\
4c407392c1aff3 Ilpo Järvinen   2024-04-29  267  									\
d97ffe23689485 Gavin Shan      2014-05-21  268  	return pcibios_err_to_errno(ret);				\
c63587d7f5b9db Alex Williamson 2012-06-11  269  }									\
08fa50b5c3a3d8 Roshan Kumar    2025-09-10  270  EXPORT_SYMBOL_GPL(pci_user_write_config_##size)
e04b0ea2e0f9c1 Brian King      2005-09-27  271  
e04b0ea2e0f9c1 Brian King      2005-09-27  272  PCI_USER_READ_CONFIG(byte, u8)
e04b0ea2e0f9c1 Brian King      2005-09-27  273  PCI_USER_READ_CONFIG(word, u16)
e04b0ea2e0f9c1 Brian King      2005-09-27  274  PCI_USER_READ_CONFIG(dword, u32)
e04b0ea2e0f9c1 Brian King      2005-09-27  275  PCI_USER_WRITE_CONFIG(byte, u8)
e04b0ea2e0f9c1 Brian King      2005-09-27  276  PCI_USER_WRITE_CONFIG(word, u16)
e04b0ea2e0f9c1 Brian King      2005-09-27  277  PCI_USER_WRITE_CONFIG(dword, u32)
e04b0ea2e0f9c1 Brian King      2005-09-27  278  
e04b0ea2e0f9c1 Brian King      2005-09-27  279  /**
fb51ccbf217c1c Jan Kiszka      2011-11-04  280   * pci_cfg_access_lock - Lock PCI config reads/writes
e04b0ea2e0f9c1 Brian King      2005-09-27  281   * @dev:	pci device struct
e04b0ea2e0f9c1 Brian King      2005-09-27  282   *
fb51ccbf217c1c Jan Kiszka      2011-11-04  283   * When access is locked, any userspace reads or writes to config
fb51ccbf217c1c Jan Kiszka      2011-11-04  284   * space and concurrent lock requests will sleep until access is
0b131b139467db Brian Norris    2017-03-27  285   * allowed via pci_cfg_access_unlock() again.
7ea7e98fd8d023 Matthew Wilcox  2006-10-19  286   */
fb51ccbf217c1c Jan Kiszka      2011-11-04 @287  void pci_cfg_access_lock(struct pci_dev *dev)
fb51ccbf217c1c Jan Kiszka      2011-11-04  288  {
fb51ccbf217c1c Jan Kiszka      2011-11-04  289  	might_sleep();
fb51ccbf217c1c Jan Kiszka      2011-11-04  290  
fb51ccbf217c1c Jan Kiszka      2011-11-04  291  	raw_spin_lock_irq(&pci_lock);
fb51ccbf217c1c Jan Kiszka      2011-11-04  292  	if (dev->block_cfg_access)
fb51ccbf217c1c Jan Kiszka      2011-11-04  293  		pci_wait_cfg(dev);
fb51ccbf217c1c Jan Kiszka      2011-11-04  294  	dev->block_cfg_access = 1;
fb51ccbf217c1c Jan Kiszka      2011-11-04  295  	raw_spin_unlock_irq(&pci_lock);
fb51ccbf217c1c Jan Kiszka      2011-11-04  296  }
fb51ccbf217c1c Jan Kiszka      2011-11-04  297  EXPORT_SYMBOL_GPL(pci_cfg_access_lock);
fb51ccbf217c1c Jan Kiszka      2011-11-04  298  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

