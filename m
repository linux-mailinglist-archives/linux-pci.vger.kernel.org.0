Return-Path: <linux-pci+bounces-24401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBA3A6C3D5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 21:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC8B468A59
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 20:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDFF22DFA6;
	Fri, 21 Mar 2025 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQw1UpSo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1B1EEA3C;
	Fri, 21 Mar 2025 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742587566; cv=none; b=MSO+ETad/jbetUVXS2V1KspbsFZ+wkeOvb6ozbE1LXQrDsGEYYUphxvQk5TYhuyZz5A5FwqF4xYXFSk2D1WU1FSeo1yDW56PuX50r2xpDkXivcHE5CxHkdKYGZ97Bkx/Wgo90G+PnNQnFXbzLG9WapXleH5F56MrFp0mwnN1ThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742587566; c=relaxed/simple;
	bh=V2PQ1B96+LOOx9jmCYATmDQGnJZ+JVZ5BSmL2n6WdDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uuzg1VYcD5qQ4j5R4Qc6q4TfVTA5bBe7isokdvsf+tXzxzDJwdZyRW1UNdw36w69XBXgh19GM9tQh+lwoSQV3ArmutWaDWGIOSofdytDZvwYEpYi2hjH9p/cPaJ0AsyyOcy4MaFulzdw+wa+g4kJfoA7P61r27fZyqWS1SvH3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQw1UpSo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742587565; x=1774123565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V2PQ1B96+LOOx9jmCYATmDQGnJZ+JVZ5BSmL2n6WdDw=;
  b=fQw1UpSoEJ1PEL14saM52fgS2rf/EORV8GU4jVvjif3vpo/tXRgYzooA
   Za/av+kanLOqfQ9kSYDRsbr0QCJkuMjBLIpfdFtLkG7oUjXhcWgA4KWGx
   MdnU6V1RRl16kvli3AH153kY/U52WVvqZfcVlHmCc8EvkytqN4GcKKbou
   Tf1Zh/1ewddLMDCf1TNex0VjiDsINFBmlZIidXyLkFdQK1c6OugfYVR2R
   D8YDDghTfryudck+hM9rYzUgT+7qrDnP98Zu8WauY4Cz0YVgP2JS+9IjN
   RClNVu4i6r//ZNHxIUyBSGLyaOUTbx0t5CCBr82l3IM2Yn6attYOJw2Js
   A==;
X-CSE-ConnectionGUID: QF4MSPwXQ+m+iMWJ+W2ffg==
X-CSE-MsgGUID: DlS0tGGZQpCKms20shUnzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43030660"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43030660"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 13:06:04 -0700
X-CSE-ConnectionGUID: cs+1kr6VShuVyPbwE3Ut7Q==
X-CSE-MsgGUID: 2HHFYUrfQumOA+E7tI8GRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123201454"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 21 Mar 2025 13:06:02 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvicx-0001ep-0Z;
	Fri, 21 Mar 2025 20:05:59 +0000
Date: Sat, 22 Mar 2025 04:05:39 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [v5 1/4] PCI: Introduce generic capability search functions
Message-ID: <202503220356.59PxEhDx-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on a1cffe8cc8aef85f1b07c4464f0998b9785b795a]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-capability-search-functions/20250322-004312
base:   a1cffe8cc8aef85f1b07c4464f0998b9785b795a
patch link:    https://lore.kernel.org/r/20250321163803.391056-2-18255117159%40163.com
patch subject: [v5 1/4] PCI: Introduce generic capability search functions
config: arm-randconfig-001-20250322 (https://download.01.org/0day-ci/archive/20250322/202503220356.59PxEhDx-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250322/202503220356.59PxEhDx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503220356.59PxEhDx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm/mm/iomap.c:9:0:
   include/linux/pci.h:2025:1: error: expected identifier or '(' before '{' token
    { return 0; }
    ^
   include/linux/pci.h:2029:1: error: expected identifier or '(' before '{' token
    { return 0; }
    ^
   In file included from arch/arm/mm/iomap.c:9:0:
>> include/linux/pci.h:2023:1: warning: 'pci_host_bridge_find_capability' declared 'static' but never defined [-Wunused-function]
    pci_host_bridge_find_capability(void *priv, pci_host_bridge_read_cfg read_cfg,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/pci.h:2027:1: warning: 'pci_host_bridge_find_ext_capability' declared 'static' but never defined [-Wunused-function]
    pci_host_bridge_find_ext_capability(void *priv,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +2023 include/linux/pci.h

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
> 2023	pci_host_bridge_find_capability(void *priv, pci_host_bridge_read_cfg read_cfg,
  2024					u8 cap);
> 2025	{ return 0; }
  2026	static inline u16
> 2027	pci_host_bridge_find_ext_capability(void *priv,
  2028					    pci_host_bridge_read_cfg read_cfg, u8 cap);
> 2029	{ return 0; }
  2030	static inline u64 pci_get_dsn(struct pci_dev *dev)
  2031	{ return 0; }
  2032	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

