Return-Path: <linux-pci+bounces-24339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D28BA6BB07
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2994F3AC02D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 12:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E742248AA;
	Fri, 21 Mar 2025 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KP2YmPdj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F161EA7D3;
	Fri, 21 Mar 2025 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561242; cv=none; b=HSyRmdUtqbGG4ZYGj7uFG4py1Pf/PIsIo4GsrLCOsTGR8uvOIrChOxOfkpDlOP9WR+1KY7WCM6r0kS+9AxCGRpJMO31a8/huyaF8VRRmdy7wnNpLLIhlnsC6qFb/KgkwMCf9r5N+ViFOefMjkkK6eiPfQWSzNSehsnIM8mlaPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561242; c=relaxed/simple;
	bh=tTaG9GkIaJ9CMdxBHO+TL0Je1vznFWj2Qm2pbu1XDLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2EJv/b2EyfmkSaGc0a8/HrnUDJ45edWYVl9FoVzNGgi4AW4YWoJU8I2NgivVJNY861AwEyMn1FICo8Lc5gz4HCWcQHu8DsumOTDtv1EbaQVLDlEq282TvRL3sdj+Xl92m0J+eKLaPg7dFUuT/TztWQpPW8UYX4vYJEhfDDZxo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KP2YmPdj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742561241; x=1774097241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tTaG9GkIaJ9CMdxBHO+TL0Je1vznFWj2Qm2pbu1XDLY=;
  b=KP2YmPdj2Ntjy/akGinlIA/pJfBmt4tHEdduQKgF4WXtSvED26GEW98I
   DbLhWsZuuiVdsYDvkG3CGKxZyQptNwsMo+5ijHNHNBGk4L20MbERcASWj
   CiRc7z7f/zlgd6F0g6XmuMxwhRTANX4H4+JaEEhF0PMglXBwQCyyPr9sv
   m0QdPVcISWEjoYyX1MGAlcHsYQImlZyTzS+XVkD3fZAQe6F/1zMYWWQVd
   Ascs38fdqQfQ3FlXqoo6aXXrD1AbBJhq789QE1R4a9MoxtE/tz/vCQIIp
   7Z8xQkuuFpj/J6nQNwbx9JAwiO19smq6R7kirPB0voyqXsDuSo9OVy8CI
   A==;
X-CSE-ConnectionGUID: azFobtIERbe4wbj90gnh3Q==
X-CSE-MsgGUID: 8aD70VoXS8S+cJvK84UHbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="47705037"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="47705037"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 05:47:20 -0700
X-CSE-ConnectionGUID: brNW0UPFSoeuiUDNYhgLQQ==
X-CSE-MsgGUID: jrvsMQgyQAi8l63xjp8O6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123909529"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 21 Mar 2025 05:47:17 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvbmM-0001Kd-2Y;
	Fri, 21 Mar 2025 12:47:14 +0000
Date: Fri, 21 Mar 2025 20:46:21 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [v4 1/4] PCI: Introduce generic capability search functions
Message-ID: <202503212059.oxvxSlCc-lkp@intel.com>
References: <20250321101710.371480-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321101710.371480-2-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a1cffe8cc8aef85f1b07c4464f0998b9785b795a]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-capability-search-functions/20250321-182140
base:   a1cffe8cc8aef85f1b07c4464f0998b9785b795a
patch link:    https://lore.kernel.org/r/20250321101710.371480-2-18255117159%40163.com
patch subject: [v4 1/4] PCI: Introduce generic capability search functions
config: arc-randconfig-002-20250321 (https://download.01.org/0day-ci/archive/20250321/202503212059.oxvxSlCc-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250321/202503212059.oxvxSlCc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503212059.oxvxSlCc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/nvme.h:11,
                    from drivers/nvme/host/fc.c:13:
>> include/linux/pci.h:2024:12: warning: 'pci_generic_find_ext_capability' defined but not used [-Wunused-function]
    2024 | static u16 pci_generic_find_ext_capability(void *priv,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/pci.h:2021:11: warning: 'pci_generic_find_capability' defined but not used [-Wunused-function]
    2021 | static u8 pci_generic_find_capability(void *priv, pci_generic_read_cfg read_cfg,
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/pci_generic_find_ext_capability +2024 include/linux/pci.h

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
> 2021	static u8 pci_generic_find_capability(void *priv, pci_generic_read_cfg read_cfg,
  2022					      u8 cap)
  2023	{ return 0; }
> 2024	static u16 pci_generic_find_ext_capability(void *priv,
  2025						   pci_generic_read_cfg read_cfg,
  2026						   u8 cap)
  2027	{ return 0; }
  2028	static inline u64 pci_get_dsn(struct pci_dev *dev)
  2029	{ return 0; }
  2030	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

