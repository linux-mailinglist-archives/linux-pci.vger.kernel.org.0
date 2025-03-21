Return-Path: <linux-pci+bounces-24316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F51BA6B7CA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 10:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91454A0EE6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACB41FFC7B;
	Fri, 21 Mar 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P51VhCVV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6A1F4616;
	Fri, 21 Mar 2025 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549889; cv=none; b=cgpzpikn4v83/1g4gcTpygDtvXrQ2r5sdfIW7VRUi7mOKGyKCYEpVIJETyccHRMhRiDg4lCyy7/Ze//rh4olRAmOn1JtQ2mbnbjl7AD7hsh+Mdo8yq41zuABQvrDOs4A7CMnMu44aotNxlG+pPpp9kxpvx3+RJGqksZDNxRoB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549889; c=relaxed/simple;
	bh=YF+mLtY8hsOcRA7tQ/0JU9ySe8NFQscVPQfA0gMcFMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clbWsDZC/+xENNPFpomdA2Rt8IuSm+VlxoLSqZLZd8pjCJKcMXSPoMEglTtV11yduLR4f/ex6n8yw7X9tDMcpfKdvH9XoH/BovikCG92J7RPPe7+evl7YMnBq+j3Poj42i5o/WTPCjryIMDAV49qFAJAmUwhjdC8FwNVUPNv4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P51VhCVV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742549887; x=1774085887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YF+mLtY8hsOcRA7tQ/0JU9ySe8NFQscVPQfA0gMcFMw=;
  b=P51VhCVVOAm/wySoB9QAA8HdGg68Lnz9Smn3h1E26R+NEEs9+DTyz5tY
   RpC3fIz/NTkdFndEAZWN0OvBVuptIuYPVnCy3QWH8lN4dlW7/SdV8mUGQ
   Xu4e8ZmH6Lc8XSyejPHN6KRGT6BtoRw5RfcCP5WfxGm9DaLx0CIXyCgnb
   ep52nlFOs+0KQWTH3Lmv5qScmkLWXBtaDQC5bZoAK0BQ5McMqyEu5vkR0
   td67EQAtxi/gK0nHINQHcG9FhqaJxMJHGgIMgLjghqVNIoKBU3WWTUa/8
   oyjkCvWwY6YQvR/a11vY3blFf0O1suAei8enqfhSd9N1k06hNAa7mNOn2
   w==;
X-CSE-ConnectionGUID: SgEcPUwBTH2fBDXbP6XBIQ==
X-CSE-MsgGUID: c/HXqCduRlyZUqz3LHs4EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="47692796"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="47692796"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 02:38:04 -0700
X-CSE-ConnectionGUID: Y1dnO9t8QS6pC0ONrEEqFA==
X-CSE-MsgGUID: t8aobA94RvaPPneaJvsrCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="124131267"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 21 Mar 2025 02:38:01 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvYpD-0001ET-1a;
	Fri, 21 Mar 2025 09:37:59 +0000
Date: Fri, 21 Mar 2025 17:37:47 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [v3 1/4] PCI: Introduce generic capability search functions
Message-ID: <202503211730.XKhqW2Mw-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on a1cffe8cc8aef85f1b07c4464f0998b9785b795a]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-capability-search-functions/20250321-120748
base:   a1cffe8cc8aef85f1b07c4464f0998b9785b795a
patch link:    https://lore.kernel.org/r/20250321040358.360755-2-18255117159%40163.com
patch subject: [v3 1/4] PCI: Introduce generic capability search functions
config: arm-randconfig-004-20250321 (https://download.01.org/0day-ci/archive/20250321/202503211730.XKhqW2Mw-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project c2692afc0a92cd5da140dfcdfff7818a5b8ce997)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250321/202503211730.XKhqW2Mw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503211730.XKhqW2Mw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm/mm/iomap.c:9:
>> include/linux/pci.h:2021:4: warning: no previous prototype for function 'pci_generic_find_capability' [-Wmissing-prototypes]
    2021 | u8 pci_generic_find_capability(void *priv, pci_generic_read_cfg read_cfg,
         |    ^
   include/linux/pci.h:2021:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    2021 | u8 pci_generic_find_capability(void *priv, pci_generic_read_cfg read_cfg,
         | ^
         | static 
>> include/linux/pci.h:2024:5: warning: no previous prototype for function 'pci_generic_find_ext_capability' [-Wmissing-prototypes]
    2024 | u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg read_cfg,
         |     ^
   include/linux/pci.h:2024:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    2024 | u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg read_cfg,
         | ^
         | static 
   2 warnings generated.


vim +/pci_generic_find_capability +2021 include/linux/pci.h

  1999	
  2000	static inline void pci_set_master(struct pci_dev *dev) { }
  2001	static inline void pci_clear_master(struct pci_dev *dev) { }
  2002	static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
  2003	static inline void pci_disable_device(struct pci_dev *dev) { }
  2004	static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
  2005	static inline int pci_assign_resource(struct pci_dev *dev, int i)
  2006	{ return -EBUSY; }
  2007	static inline int __must_check __pci_register_driver(struct pci_driver *drv,
  2008							     struct module *owner,
  2009							     const char *mod_name)
  2010	{ return 0; }
  2011	static inline int pci_register_driver(struct pci_driver *drv)
  2012	{ return 0; }
  2013	static inline void pci_unregister_driver(struct pci_driver *drv) { }
  2014	static inline u8 pci_find_capability(struct pci_dev *dev, int cap)
  2015	{ return 0; }
  2016	static inline u8 pci_find_next_capability(struct pci_dev *dev, u8 post, int cap)
  2017	{ return 0; }
  2018	static inline u16 pci_find_ext_capability(struct pci_dev *dev, int cap)
  2019	{ return 0; }
  2020	typedef u32 (*pci_generic_read_cfg)(void *priv, int where, int size);
> 2021	u8 pci_generic_find_capability(void *priv, pci_generic_read_cfg read_cfg,
  2022				       u8 cap)
  2023	{ return 0; }
> 2024	u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg read_cfg,
  2025					    u8 cap)
  2026	{ return 0; }
  2027	static inline u64 pci_get_dsn(struct pci_dev *dev)
  2028	{ return 0; }
  2029	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

