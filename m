Return-Path: <linux-pci+bounces-24405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14242A6C4B6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 21:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13B41B60F6C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 20:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86681231C9C;
	Fri, 21 Mar 2025 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ym2bZEUT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEFB232384;
	Fri, 21 Mar 2025 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590659; cv=none; b=SLT1wMpXeFD/VdmPgzPGmiJlmM93mkrTNt4uj9d4X+g3c8uRXjqGP2U0/J6tck6t2wdgSW1m75qKGnfruHwVrFRAm6k2tmOQ5RWlLNZHC7qAriFevkSi+PGKCOVSdOCtUWbKrPUAxTyw2dX1KnXgNnGGdQDgfKpMVQrJuswdIeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590659; c=relaxed/simple;
	bh=ZXz1lCeNrvjVJLRs04XWZoMrQXMdrcjG9uS7WXXyp9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H97KFsgyqM6GV9P0zbes8cFz4k+a/4i0GDS3w1QwIDtwWhmhG1LpWrSYR/ILCJ1DmErPqNnY1EHrtF8Y5P1XYfh97OCgZtYUhB9RBLudEFfScDB2WtnwVtR59uAEJuY9F+fD/RP9+FsBySEMSN5yOpsgQHllbX5FiYMOmmkjSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ym2bZEUT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742590657; x=1774126657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZXz1lCeNrvjVJLRs04XWZoMrQXMdrcjG9uS7WXXyp9k=;
  b=Ym2bZEUTWag0A2F3TzGt+bOdtOzt704uckulqFjHJWPOMN9+mpQaWmty
   Ish8nLKBkyjxUkYJ3Toq1dEEY/6V13YJ3oX8FASrgrtfCE+e/AOBqRIsx
   bZWye+/LLNwrvpDy6ENMVChryxyfBMetg+Lm42/Ilwm2R2NHW+HsCE8rz
   +h+ADDCIX3Qfj3OaTrh4IJIocu7Jbkd3loMbgk+2Bzdr0eGxkXdc0D70D
   HuEP/doZDIZFnhlBqhLD/K8yQgqQUE5FI7ZeZzr0RkPgQHWOAcUGuwJXU
   9XRvPOpGdRlCuoGRiJVk1e+YYE5wJxF+nQJefg5FdcmfOtwzB5dHUPui0
   A==;
X-CSE-ConnectionGUID: 5PoZ45heSYyzLAz4jRJhyg==
X-CSE-MsgGUID: aOxRfWwuSsKE0Dk07OWO6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="44057303"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="44057303"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 13:57:36 -0700
X-CSE-ConnectionGUID: t1NdUEubT1Wto0n2pc9WMw==
X-CSE-MsgGUID: N6WEr2ixShCQQD6FioBq5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="128179654"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 21 Mar 2025 13:57:33 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvjQo-0001gn-2m;
	Fri, 21 Mar 2025 20:57:30 +0000
Date: Sat, 22 Mar 2025 04:57:29 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [v5 1/4] PCI: Introduce generic capability search functions
Message-ID: <202503220416.dfoSTxfs-lkp@intel.com>
References: <20250321163803.391056-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321163803.391056-2-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on a1cffe8cc8aef85f1b07c4464f0998b9785b795a]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-capability-search-functions/20250322-004312
base:   a1cffe8cc8aef85f1b07c4464f0998b9785b795a
patch link:    https://lore.kernel.org/r/20250321163803.391056-2-18255117159%40163.com
patch subject: [v5 1/4] PCI: Introduce generic capability search functions
config: arm-randconfig-001-20250322 (https://download.01.org/0day-ci/archive/20250322/202503220416.dfoSTxfs-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250322/202503220416.dfoSTxfs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503220416.dfoSTxfs-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm/mm/iomap.c:9:0:
>> include/linux/pci.h:2025:1: error: expected identifier or '(' before '{' token
    { return 0; }
    ^
   include/linux/pci.h:2029:1: error: expected identifier or '(' before '{' token
    { return 0; }
    ^
   In file included from arch/arm/mm/iomap.c:9:0:
   include/linux/pci.h:2023:1: warning: 'pci_host_bridge_find_capability' declared 'static' but never defined [-Wunused-function]
    pci_host_bridge_find_capability(void *priv, pci_host_bridge_read_cfg read_cfg,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pci.h:2027:1: warning: 'pci_host_bridge_find_ext_capability' declared 'static' but never defined [-Wunused-function]
    pci_host_bridge_find_ext_capability(void *priv,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +2025 include/linux/pci.h

  2000	
  2001	static inline void pci_set_master(struct pci_dev *dev) { }
  2002	static inline void pci_clear_master(struct pci_dev *dev) { }
  2003	static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
  2004	static inline void pci_disable_device(struct pci_dev *dev) { }
  2005	static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
  2006	static inline int pci_assign_resource(struct pci_dev *dev, int i)
  2007	{ return -EBUSY; }
  2008	static inline int __must_check __pci_register_driver(struct pci_driver *drv,
  2009							     struct module *owner,
  2010							     const char *mod_name)
  2011	{ return 0; }
  2012	static inline int pci_register_driver(struct pci_driver *drv)
  2013	{ return 0; }
  2014	static inline void pci_unregister_driver(struct pci_driver *drv) { }
  2015	static inline u8 pci_find_capability(struct pci_dev *dev, int cap)
  2016	{ return 0; }
  2017	static inline u8 pci_find_next_capability(struct pci_dev *dev, u8 post, int cap)
  2018	{ return 0; }
  2019	static inline u16 pci_find_ext_capability(struct pci_dev *dev, int cap)
  2020	{ return 0; }
  2021	typedef u32 (*pci_host_bridge_read_cfg)(void *priv, int where, int size);
  2022	static inline u8
  2023	pci_host_bridge_find_capability(void *priv, pci_host_bridge_read_cfg read_cfg,
  2024					u8 cap);
> 2025	{ return 0; }
  2026	static inline u16
  2027	pci_host_bridge_find_ext_capability(void *priv,
  2028					    pci_host_bridge_read_cfg read_cfg, u8 cap);
  2029	{ return 0; }
  2030	static inline u64 pci_get_dsn(struct pci_dev *dev)
  2031	{ return 0; }
  2032	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

