Return-Path: <linux-pci+bounces-13326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB60A97D48F
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 13:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03971C21129
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 11:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3933013D26B;
	Fri, 20 Sep 2024 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCVj7zUG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6579655887;
	Fri, 20 Sep 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726830589; cv=none; b=FalNzqTq1vuRUlSbTIZwlIsjA9uw6Xeq3rVI8HaffrF5VMXTnJuzIdlxp1ZahSioP2BqaEbWtFWjhbkBjtvBwz13XDJJXTAoHtMjnZDYSh9HtjRh0GRKQNU0/C3kcaZ/D1ZCVC/zGODDBYlgu8KVuZZSs6nNs5M2ObSbxiIC6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726830589; c=relaxed/simple;
	bh=vCaO4ypVNNj50k616bvbWb0ZhmSIhGXQ+CsBpme5xXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqbB8zmsKIdPEwGaWdPgoYpAyj8WiMfpOL6m8nxEGIjvCzVV23LXSLvZc0K2P1iiRv9EHCCcXRHYoTpJZS25c2+jNj4vwcMsJbT6IQ45jMMAkw5laaMQ+WfH/5lW2ySXudkEsryUYkCz/e8iqBiuD9uuhkSLYJ3P6SAZ+fkHQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCVj7zUG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726830587; x=1758366587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vCaO4ypVNNj50k616bvbWb0ZhmSIhGXQ+CsBpme5xXE=;
  b=mCVj7zUGKdRM9OeE91UgS/y6/ALdlwtR1cP0DiaPVgbKu7a1SjSz1E7F
   J6dTxb/EiNZ1MnVPcY6dstvAK+6lj8gpq5zzCMZT9Zd0VlOyhFazGQRAH
   qsVhsgY9SiDppANml+U+cju9rw7R/ic4Hi998f+NSlAtBQJurT+yNKEVP
   11RZx6lXVZlCdC64ksNhg9T/Fo5EmKDYbmuglptowoq8CgDR3gHZ6ydqA
   sB5uHFN+sLvCdTy7EsQ7ouc/3jQNkL5jKjLeKoDfkIXzhE6p8/oUrUvHG
   UFipjUnumwnXv/vnSXbJ79Kh7mzhoYRapw7tzrhKjgaVgy9t3KiOD1/C1
   w==;
X-CSE-ConnectionGUID: +eqXOH90T6ufOKzHDy+DdA==
X-CSE-MsgGUID: B5kYsJ5xRMeoRxphP7TZWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="29726420"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="29726420"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 04:09:46 -0700
X-CSE-ConnectionGUID: N1zVYBiWRBCSO1UCyjakwg==
X-CSE-MsgGUID: wtpa2aEqTcynycK8eRDJQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75219609"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Sep 2024 04:09:42 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srbW7-000EJH-28;
	Fri, 20 Sep 2024 11:09:39 +0000
Date: Fri, 20 Sep 2024 19:09:27 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: oe-kbuild-all@lists.linux.dev, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Subject: Re: [PATCH v2 2/3] PCI: Allow extending VF BAR within original
 resource boundary
Message-ID: <202409201854.z0daqyYE-lkp@intel.com>
References: <20240919223557.1897608-3-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240919223557.1897608-3-michal.winiarski@intel.com>

Hi Michał,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/for-linus]
[also build test WARNING on drm-xe/drm-xe-next drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v6.11 next-20240920]
[cannot apply to pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micha-Winiarski/PCI-Add-support-for-VF-Resizable-Bar-extended-cap/20240920-064112
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/20240919223557.1897608-3-michal.winiarski%40intel.com
patch subject: [PATCH v2 2/3] PCI: Allow extending VF BAR within original resource boundary
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20240920/202409201854.z0daqyYE-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240920/202409201854.z0daqyYE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409201854.z0daqyYE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/of.c:12:
   include/linux/pci.h: In function 'pci_iov_resource_extend':
>> include/linux/pci.h:2421:10: warning: 'return' with a value, in function returning void [-Wreturn-type]
    2421 | { return -ENODEV; }
         |          ^
   include/linux/pci.h:2420:20: note: declared here
    2420 | static inline void pci_iov_resource_extend(struct pci_dev *dev, int resno, bool enable)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~


vim +/return +2421 include/linux/pci.h

  2397	
  2398	static inline int pci_iov_sysfs_link(struct pci_dev *dev,
  2399					     struct pci_dev *virtfn, int id)
  2400	{
  2401		return -ENODEV;
  2402	}
  2403	static inline int pci_iov_add_virtfn(struct pci_dev *dev, int id)
  2404	{
  2405		return -ENOSYS;
  2406	}
  2407	static inline void pci_iov_remove_virtfn(struct pci_dev *dev,
  2408						 int id) { }
  2409	static inline void pci_disable_sriov(struct pci_dev *dev) { }
  2410	static inline int pci_num_vf(struct pci_dev *dev) { return 0; }
  2411	static inline int pci_vfs_assigned(struct pci_dev *dev)
  2412	{ return 0; }
  2413	static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
  2414	{ return 0; }
  2415	static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
  2416	{ return 0; }
  2417	#define pci_sriov_configure_simple	NULL
  2418	static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
  2419	{ return 0; }
  2420	static inline void pci_iov_resource_extend(struct pci_dev *dev, int resno, bool enable)
> 2421	{ return -ENODEV; }
  2422	static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe) { }
  2423	#endif
  2424	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

