Return-Path: <linux-pci+bounces-13327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EE497D4B9
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221041C215FD
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5B91422BD;
	Fri, 20 Sep 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rg7Y0YK7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE845027;
	Fri, 20 Sep 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726831249; cv=none; b=iHqms/UFPdAw2l5dd8cGZ/kTNuYz1kae3CT8IocOMxUGEmc1nRzNUNz+YrS27+PhH1PHqBWoA3kQGx7f+oD5W/EUVouZ+djKT9S6Kd7fY6JQtrprJA3yrnUBT/kJXZ6oSogwTcoSrOCtMT8zStsIatBJR6+hz3FCTaS8tkVuqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726831249; c=relaxed/simple;
	bh=cOkG5YrAfWWRLhi0lqdnxR0XhBJNfGEMHWKajqt7vE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skgcycQKZq+qMJnScc2Lp7y2VD53UyItN528yqP/oUSa8cAcmBNdGUoVv0W1qFQ92UeZsb8aOJPWU5SXRjZQkojiGqxWqt8g0X9FrBxBEIu3dP7bjwfNIluUO/hIbYu0tYUMVPtGgOVxoYeprfEh96MaSgVpDCqp9ef5CRn4VXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rg7Y0YK7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726831247; x=1758367247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cOkG5YrAfWWRLhi0lqdnxR0XhBJNfGEMHWKajqt7vE8=;
  b=Rg7Y0YK7TLjLipU6QzVdDcMdasTklPhEx0iCGpoK6XqHddJJixLuqnMA
   JQUdv9nPcgiqeDe3TaT1RpMY73+qIUPGA2fEtih/w08X9855ZSl8fUVqb
   3QEQCf+btCC9J1+HBt3rzzx04KyUnVYuhSlyxepLC8h3eUthSLvmtz0F7
   Mghf8TwLujAM3egSVTQTGt+PniU92oDaSfruL+Jz5+kASTxwCe+NljqoG
   I2kZluWT5fty55Un2NU4tvJzRXzYzLeiUBk5Jje6pxCxLGDaSj/yd7oUk
   tOZKpBpnPpItsUqPtYqt4u7pvhHcoKCBiKqezJNfPchj5h6PlW1/mfJen
   A==;
X-CSE-ConnectionGUID: miaxVNYMR2GjN9Y2i6rqFA==
X-CSE-MsgGUID: gekinTJzS5yqyAPVZMciGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="26018562"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="26018562"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 04:20:47 -0700
X-CSE-ConnectionGUID: B3bubxXqRtyC80JACfA9Ig==
X-CSE-MsgGUID: NmwJsoqIRU+K3lIEz7n1bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="69868882"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Sep 2024 04:20:42 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srbgl-000EJd-2d;
	Fri, 20 Sep 2024 11:20:39 +0000
Date: Fri, 20 Sep 2024 19:19:39 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
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
Message-ID: <202409201934.yM9hVUai-lkp@intel.com>
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
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20240920/202409201934.yM9hVUai-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240920/202409201934.yM9hVUai-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409201934.yM9hVUai-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm/mm/iomap.c:9:
>> include/linux/pci.h:2421:3: warning: void function 'pci_iov_resource_extend' should not return a value [-Wreturn-mismatch]
    2421 | { return -ENODEV; }
         |   ^      ~~~~~~~
   In file included from arch/arm/mm/iomap.c:9:
   In file included from include/linux/pci.h:2672:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   2 warnings generated.


vim +/pci_iov_resource_extend +2421 include/linux/pci.h

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

