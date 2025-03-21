Return-Path: <linux-pci+bounces-24318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 837EEA6B80B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 10:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F9B27AAA6C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 09:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB261F1906;
	Fri, 21 Mar 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcfeoHQa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48481F17E5;
	Fri, 21 Mar 2025 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550607; cv=none; b=mD9O2yCNDCc+fgYHjQGNVD0bPxakCEZo5ww9xGDfsHud/phveoQZip8BsFQlYdw/8WFopLw2FTGxYsxUmxIf+kqN8NGrhzCTvJod5rTzbU6dlqTK5l9UOIIVORuRDn3llC50HTz9VIC6bBt5WDuqGDzFIow2B6DRhGC6GAnBsQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550607; c=relaxed/simple;
	bh=3YG+DczV632k/slGK52ohCebjqt0NGwK/ts86iP6w6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dr1vpSYAV8fP4MU0EhcIRAf7oqBpFJFwKj3nW4xoNFpXwpZIGBkb4AIXjo37bDlcmIQdBwe9QYMBwsSCOCWVOPA2mb24uND28dBsXGVtONBz4zQDJc/ttS6mhWadztSJV6X1oJbJZdeJSU1IrWxTNCe9i6DOepfYme5ldYcVFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcfeoHQa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742550606; x=1774086606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3YG+DczV632k/slGK52ohCebjqt0NGwK/ts86iP6w6A=;
  b=BcfeoHQapQgfMcRCDKlGhJaX1HKmEs8SCnE1uyDSqARD38CRdJ5WnnHm
   u/MvuBUIQXD7NcA78iv4I+p42ZFKL6i9EVSnDHTVNaRU86H6IO1NNewaZ
   g9kCsEXE7J4gZdtlNzURunh0vKrM3MYLyaH79crdXXz+MkP3Z2K/WZxT0
   xXzhZH5GtTzgSG51V77l1DuZQUU6Dvwjomy/AZ6j0WaK27W7ZeBOSTamZ
   kUWdp3Hfd3CloAZzbaVRUGw40g95sf8For4YdymZF/qKhHN/IjwgJnY5Y
   JPDPXLJ6rq2nCrKKibnVpwaB70qzcHu8ZgxjNrcHzXWmq66B4O07GN7AT
   w==;
X-CSE-ConnectionGUID: e6iSqTFTSgaR/ka0IH9GOg==
X-CSE-MsgGUID: oS7xP5wzSeS+9SIDXINPdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43825223"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="43825223"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 02:50:06 -0700
X-CSE-ConnectionGUID: TXGJfUADThyc287pgEfijQ==
X-CSE-MsgGUID: pAtjGjIhSGiEC4g0ma5+AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123379760"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 21 Mar 2025 02:50:03 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvZ0q-0001F1-1K;
	Fri, 21 Mar 2025 09:50:00 +0000
Date: Fri, 21 Mar 2025 17:49:35 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [v3 1/4] PCI: Introduce generic capability search functions
Message-ID: <202503211714.tv7E2QkK-lkp@intel.com>
References: <20250321040358.360755-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321040358.360755-2-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on a1cffe8cc8aef85f1b07c4464f0998b9785b795a]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-capability-search-functions/20250321-120748
base:   a1cffe8cc8aef85f1b07c4464f0998b9785b795a
patch link:    https://lore.kernel.org/r/20250321040358.360755-2-18255117159%40163.com
patch subject: [v3 1/4] PCI: Introduce generic capability search functions
config: arc-randconfig-001-20250321 (https://download.01.org/0day-ci/archive/20250321/202503211714.tv7E2QkK-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250321/202503211714.tv7E2QkK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503211714.tv7E2QkK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/pci.c:691:5: error: conflicting types for 'pci_generic_find_ext_capability'; have 'u16(void *, u32 (*)(void *, int,  int), int)' {aka 'short unsigned int(void *, unsigned int (*)(void *, int,  int), int)'}
     691 | u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg read_cfg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pci/pci.c:18:
   include/linux/pci.h:1211:5: note: previous declaration of 'pci_generic_find_ext_capability' with type 'u16(void *, u32 (*)(void *, int,  int), u8)' {aka 'short unsigned int(void *, unsigned int (*)(void *, int,  int), unsigned char)'}
    1211 | u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg read_cfg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/pci/pci.c:11:
   drivers/pci/pci.c:696:19: error: conflicting types for 'pci_generic_find_ext_capability'; have 'u16(void *, u32 (*)(void *, int,  int), int)' {aka 'short unsigned int(void *, unsigned int (*)(void *, int,  int), int)'}
     696 | EXPORT_SYMBOL_GPL(pci_generic_find_ext_capability);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:70:28: note: in definition of macro '__EXPORT_SYMBOL'
      70 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:84:41: note: in expansion of macro '_EXPORT_SYMBOL'
      84 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/pci/pci.c:696:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     696 | EXPORT_SYMBOL_GPL(pci_generic_find_ext_capability);
         | ^~~~~~~~~~~~~~~~~
   include/linux/pci.h:1211:5: note: previous declaration of 'pci_generic_find_ext_capability' with type 'u16(void *, u32 (*)(void *, int,  int), u8)' {aka 'short unsigned int(void *, unsigned int (*)(void *, int,  int), unsigned char)'}
    1211 | u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg read_cfg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +691 drivers/pci/pci.c

   690	
 > 691	u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg read_cfg,
   692					    int cap)
   693	{
   694		return pci_generic_find_next_ext_capability(priv, read_cfg, 0, cap);
   695	}
   696	EXPORT_SYMBOL_GPL(pci_generic_find_ext_capability);
   697	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

